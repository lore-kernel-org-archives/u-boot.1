Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D65AC369AB
	for <u-boot@archiver.kernel.org>; Sat, 12 Apr 2025 19:40:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3AE6982F10;
	Sat, 12 Apr 2025 21:40:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=samcday.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=samcday.com header.i=@samcday.com header.b="ACSY26d+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B378A82F10; Sat, 12 Apr 2025 21:40:12 +0200 (CEST)
Received: from mail-4323.protonmail.ch (mail-4323.protonmail.ch [185.70.43.23])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 74BC082F4B
 for <u-boot@lists.denx.de>; Sat, 12 Apr 2025 21:40:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=samcday.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=me@samcday.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samcday.com;
 s=protonmail; t=1744486808; x=1744746008;
 bh=3+zRXHBKtVM7Nfq9UqXXdjj94sos5scnLZdRa8HR7Eo=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
 b=ACSY26d+vxFrxzEE/B3fKFPn6pymaExt/pwQ25tLyrPbwmITelq/z9gGdaojmzKP0
 jGUhGbxuQNtwD3QbQbursifRDxD1kVMYFE4yNP8/QJNvnLuCEQ5S7X0c/JnOemrTKe
 iZ4Gxg9MJjxXPeR9KR4JmfTD3rJDzL6YKDZyCQQI+lc/wjhLTcFsUqlbJ35aDzFn5a
 8lzkkhZK6AU2DsNSXZVZ+V2oGBVGIVjaWIBCd6U0MVEryncV0lZepDic6atq7L9++G
 KK1OYFy6ka3CJt4XY/xL2Nx0yNqVWhMj558krsia6J1UYmmjeqAtqMJloQ9uPDKhxf
 EntPNV8jABQgw==
Date: Sat, 12 Apr 2025 19:40:03 +0000
To: Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, Marek Vasut <marex@denx.de>,
 Tom Rini <trini@konsulko.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Sumit Garg <sumit.garg@kernel.org>,
 Stephan Gerhold <stephan.gerhold@linaro.org>
From: Sam Day <me@samcday.com>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, Sam Day <me@samcday.com>
Subject: [PATCH 2/3] usb: host: ehci-msm: Register ChipIdea UDC from glue
 wrapper
Message-ID: <20250412-msm8916-usb-v1-2-2925239caf4b@samcday.com>
In-Reply-To: <20250412-msm8916-usb-v1-0-2925239caf4b@samcday.com>
References: <20250412-msm8916-usb-v1-0-2925239caf4b@samcday.com>
Feedback-ID: 25366008:user:proton
X-Pm-Message-ID: 82db75f648dac5d559284e8e99e5a36130c189d6
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

When CONFIG_DM_USB_GADGET is enabled, the CI UDC driver needs to be
explicitly bound. So we do this from the newly introduced glue driver.

Signed-off-by: Sam Day <me@samcday.com>
---
 drivers/usb/host/ehci-msm.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/usb/host/ehci-msm.c b/drivers/usb/host/ehci-msm.c
index 8aeb6a915563453ad2a02721d4828fd1b300a4e4..ae40e96e6349b1a352608e6350c=
e950a3cff95af 100644
--- a/drivers/usb/host/ehci-msm.c
+++ b/drivers/usb/host/ehci-msm.c
@@ -161,6 +161,13 @@ static int qcom_ci_hdrc_bind(struct udevice *dev)
 =09if (ret)
 =09=09return ret;
=20
+=09if (IS_ENABLED(CONFIG_DM_USB_GADGET) && IS_ENABLED(CONFIG_CI_UDC)) {
+=09=09ret =3D device_bind_driver_to_node(dev, "ci-udc", "ci-udc",
+=09=09=09=09dev_ofnode(dev), NULL);
+=09=09if (ret)
+=09=09=09return ret;
+=09}
+
 =09if (!ofnode_valid(ulpi_node))
 =09=09return 0;
=20

--=20
2.49.0



Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABB92CD5BDE
	for <u-boot@archiver.kernel.org>; Wed, 27 May 2026 01:18:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B1F984946;
	Wed, 27 May 2026 03:18:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=samcday.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=samcday.com header.i=@samcday.com header.b="irS8ckgV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2443284855; Wed, 27 May 2026 02:38:03 +0200 (CEST)
Received: from mail-4317.protonmail.ch (mail-4317.protonmail.ch [185.70.43.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C7F2846A5
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 02:38:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=samcday.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=me@samcday.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samcday.com;
 s=protonmail3; t=1779842279; x=1780101479;
 bh=TGnfrhxKdGUAFcral3/w8ZP0pQV0omJ1q35YYwjbgDE=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=irS8ckgVRo+5AMLgWQudyGmEl2EFRIJ76Zf5vSKj6O52DugDPXxVgihs6efqbBSLL
 AjR762ADCYj3tU0TD7XP6sv3b3USUOppXvb+j2XKofZQAvPNE1veYcS0r8HB7KEzh5
 nAUWyj/M1MOyPdaoeyySItmaGAIwboaMpKOnLr1DbD+lyDKJIe65IwCkYBdN9nngQ1
 J4Q9bqiS9IKnIjUqMMJCeJq1BlNOl1gWPKncvopT11auZYE2BWWKkdyJ4R5SBpv71B
 eJwpTb7gzA22ex4aR4njW6WJKxhCscG/LRCXBkLZ47T/lEefZJ+LD3kKyT2qAkuXJq
 HSv8HzUR7Zr7w==
Date: Wed, 27 May 2026 00:37:54 +0000
To: Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, Marek Vasut <marex@denx.de>,
 Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>,
 Stephan Gerhold <stephan.gerhold@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>
From: Sam Day <me@samcday.com>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Kever Yang <kever.yang@rock-chips.com>, Peter Robinson <pbrobinson@gmail.com>,
 Jonas Karlman <jonas@kwiboo.se>, George Chan <gchan9527@gmail.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 =?utf-8?Q?Petr_Bene=C5=A1?= <petr.benes@ysoft.com>,
 Heiko Schocher <hs@nabladev.com>, Simon Glass <sjg@chromium.org>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Paul Sajna <sajattack@postmarketos.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Luca Weiss <luca.weiss@fairphone.com>, Sam Day <me@samcday.com>
Subject: [PATCH v2 2/3] usb: host: ehci-msm: Register ChipIdea UDC from glue
 wrapper
Message-ID: <20260527-msm8916-usb-v2-2-343e1e32e77b@samcday.com>
In-Reply-To: <20260527-msm8916-usb-v2-0-343e1e32e77b@samcday.com>
References: <20260527-msm8916-usb-v2-0-343e1e32e77b@samcday.com>
Feedback-ID: 25366008:user:proton
X-Pm-Message-ID: 6b292f1a18bd0d58f8d3ef9c05b7897884f3ec26
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Wed, 27 May 2026 03:18:29 +0200
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
index a58eff7cb9c..00719b7b575 100644
--- a/drivers/usb/host/ehci-msm.c
+++ b/drivers/usb/host/ehci-msm.c
@@ -161,6 +161,13 @@ static int qcom_ci_hdrc_bind(struct udevice *dev)
 =09if (ret)
 =09=09return ret;
=20
+=09if (IS_ENABLED(CONFIG_DM_USB_GADGET) && IS_ENABLED(CONFIG_CI_UDC)) {
+=09=09ret =3D device_bind_driver_to_node(dev, "ci-udc", "ci-udc",
+=09=09=09=09=09=09 dev_ofnode(dev), NULL);
+=09=09if (ret)
+=09=09=09return ret;
+=09}
+
 =09if (!ofnode_valid(ulpi_node))
 =09=09return 0;
=20

--=20
2.54.0



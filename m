Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50FD6CD5BD2
	for <u-boot@archiver.kernel.org>; Wed, 27 May 2026 01:19:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 615BC8494D;
	Wed, 27 May 2026 03:18:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=samcday.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=samcday.com header.i=@samcday.com header.b="ck7BYWfJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D88284855; Wed, 27 May 2026 02:38:15 +0200 (CEST)
Received: from mail-106100.protonmail.ch (mail-106100.protonmail.ch
 [79.135.106.100])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4F784846A5
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 02:38:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=samcday.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=me@samcday.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samcday.com;
 s=protonmail3; t=1779842291; x=1780101491;
 bh=mnaPpxsYedoTb60zaNritoQHHdMrQCotBy8nmyAMLGU=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=ck7BYWfJiH2lJZY6WNtsRpk4bE+BS/y+nLslhi+bITXS+Oe4lNSuaNkZRNjIvy3cT
 3oS0tm9QiyRug3VXfBJ77+pYNCjpCCQ6h+y9IrP+lzxT3od8V7dHzKZ224mIKUyt2N
 2CdBw73MPXKNlyUT3t9O+s5lw4Y1F6PzRwP4GZ/lXy88KszY2pfKeCcMPzXPS0cyHj
 imErY2ajq+JtHuPjbVF4suFwvXJoWuc6Ur5InB+Z0aVL2i8qIo7xTc+X8th7ZTUiA2
 JXgAfHuf8y3ZM1wxrvO44vmP4jNIXqTxVjvvGjpXdVoo8xjVBDtVfHO/H575SHk3L/
 WuRzMkj85Um8A==
Date: Wed, 27 May 2026 00:38:03 +0000
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
Subject: [PATCH v2 3/3] qcom_defconfig: Enable MSM8916 USB PHY + ChipIdea UDC
Message-ID: <20260527-msm8916-usb-v2-3-343e1e32e77b@samcday.com>
In-Reply-To: <20260527-msm8916-usb-v2-0-343e1e32e77b@samcday.com>
References: <20260527-msm8916-usb-v2-0-343e1e32e77b@samcday.com>
Feedback-ID: 25366008:user:proton
X-Pm-Message-ID: bee873625422c7a7fafeb3782309b44a312ae34c
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

Now that the ChipIdea UDC driver supports USB Gadget driver model, we
can enable it alongside the dwc3 generic driver.

Signed-off-by: Sam Day <me@samcday.com>
---
 configs/qcom_defconfig | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
index d0d54ec5a70..75e22f01f17 100644
--- a/configs/qcom_defconfig
+++ b/configs/qcom_defconfig
@@ -108,7 +108,6 @@ CONFIG_DWC_ETH_QOS_QCOM=3Dy
 CONFIG_RGMII=3Dy
 CONFIG_PHY_MICREL=3Dy
 CONFIG_PHY_MICREL_KSZ90X1=3Dy
-CONFIG_PHY=3Dy
 CONFIG_PHY_QCOM_QMP_UFS=3Dy
 CONFIG_PHY_QCOM_QUSB2=3Dy
 CONFIG_PHY_QCOM_USB_SNPS_FEMTO_V2=3Dy
@@ -139,9 +138,12 @@ CONFIG_SYSRESET_QCOM_PSHOLD=3Dy
 CONFIG_USB=3Dy
 CONFIG_USB_XHCI_HCD=3Dy
 CONFIG_USB_XHCI_DWC3=3Dy
+CONFIG_USB_EHCI_HCD=3Dy
+CONFIG_USB_EHCI_MSM=3Dy
 CONFIG_USB_DWC3=3Dy
 CONFIG_USB_DWC3_GENERIC=3Dy
 CONFIG_USB_GADGET=3Dy
+CONFIG_CI_UDC=3Dy
 CONFIG_UFS=3Dy
 CONFIG_UFS_QCOM=3Dy
 CONFIG_VIDEO=3Dy

--=20
2.54.0



Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72679C369AE
	for <u-boot@archiver.kernel.org>; Sat, 12 Apr 2025 19:40:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8903F82E28;
	Sat, 12 Apr 2025 21:40:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=samcday.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=samcday.com header.i=@samcday.com header.b="cuwJf1T9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6696982D66; Sat, 12 Apr 2025 21:40:21 +0200 (CEST)
Received: from mail-10624.protonmail.ch (mail-10624.protonmail.ch
 [79.135.106.24])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9CE1D82F4B
 for <u-boot@lists.denx.de>; Sat, 12 Apr 2025 21:40:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=samcday.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=me@samcday.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samcday.com;
 s=protonmail; t=1744486816; x=1744746016;
 bh=XJUh9N46jeIrxVG0TEfuD4gZhqseFkao6NCUwTLV3GA=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
 b=cuwJf1T9750auDvEjdpi+cf7I+i7xsCoTerFdvkx+PeHBEM6hV+rocepUUje8n9ca
 EbmUrCO4wBwoM2zGaQ9Bdey4txnV5lDhr3hG+cmLPcyz87WfGCtnkFVNqV+Q5opXLq
 fBaeCE9+a6gelcP8SjphmUmqqZphejschnxzCXJKgIDFnc97YuuLJAjcHoqHZXSEJo
 T8Cu7lm97DwEQZTPRjJyJCu2XGirfNlfERRbP7rcgtz0ZJ1Xrjra7DnzAMs6sFqIn8
 tGeoFyVhPTS0Fsxphr7FdTgdvS2jSe6Z2MChDL4WT0gYUwcwZpR1NrifjWp+/hYyRH
 nfrYL8Nqkurrw==
Date: Sat, 12 Apr 2025 19:40:11 +0000
To: Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, Marek Vasut <marex@denx.de>,
 Tom Rini <trini@konsulko.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Sumit Garg <sumit.garg@kernel.org>,
 Stephan Gerhold <stephan.gerhold@linaro.org>
From: Sam Day <me@samcday.com>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, Sam Day <me@samcday.com>
Subject: [PATCH 3/3] qcom_defconfig: Enable MSM8916 USB PHY + ChipIdea UDC
Message-ID: <20250412-msm8916-usb-v1-3-2925239caf4b@samcday.com>
In-Reply-To: <20250412-msm8916-usb-v1-0-2925239caf4b@samcday.com>
References: <20250412-msm8916-usb-v1-0-2925239caf4b@samcday.com>
Feedback-ID: 25366008:user:proton
X-Pm-Message-ID: 3b24719d432452bd903de0e8b12199b02159b1d0
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

Now that the ChipIdea UDC driver supports USB Gadget driver model, we
can enable it alongside the dwc3 generic driver.

Signed-off-by: Sam Day <me@samcday.com>
---
 configs/qcom_defconfig | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
index 537806450dc4a61d3c617cdd2b0cfb8eab1c343c..e8582d4e6bd2fae4ff2f7e34dc3=
2651ea2de76bc 100644
--- a/configs/qcom_defconfig
+++ b/configs/qcom_defconfig
@@ -45,6 +45,7 @@ CONFIG_OF_UPSTREAM_BUILD_VENDOR=3Dy
 CONFIG_USE_DEFAULT_ENV_FILE=3Dy
 CONFIG_DEFAULT_ENV_FILE=3D"board/qualcomm/default.env"
 CONFIG_BUTTON_QCOM_PMIC=3Dy
+CONFIG_CI_UDC=3Dy
 CONFIG_CLK=3Dy
 CONFIG_CLK_STUB=3Dy
 CONFIG_CLK_QCOM_APQ8016=3Dy
@@ -121,6 +122,7 @@ CONFIG_RNG_MSM=3Dy
 CONFIG_SCSI=3Dy
 CONFIG_MSM_SERIAL=3Dy
 CONFIG_MSM_GENI_SERIAL=3Dy
+CONFIG_MSM8916_USB_PHY=3Dy
 CONFIG_SOC_QCOM=3Dy
 CONFIG_QCOM_COMMAND_DB=3Dy
 CONFIG_QCOM_RPMH=3Dy
@@ -133,6 +135,10 @@ CONFIG_USB_XHCI_HCD=3Dy
 CONFIG_USB_XHCI_DWC3=3Dy
 CONFIG_USB_DWC3=3Dy
 CONFIG_USB_DWC3_GENERIC=3Dy
+CONFIG_USB_EHCI_HCD=3Dy
+CONFIG_USB_EHCI_MSM=3Dy
+CONFIG_USB_ULPI=3Dy
+CONFIG_USB_ULPI_VIEWPORT=3Dy
 CONFIG_USB_GADGET=3Dy
 CONFIG_USB_GADGET_DOWNLOAD=3Dy
 CONFIG_USB_FUNCTION_MASS_STORAGE=3Dy

--=20
2.49.0



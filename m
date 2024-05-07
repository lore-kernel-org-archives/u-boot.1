Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAAD3C25B4F
	for <u-boot@archiver.kernel.org>; Tue,  7 May 2024 18:47:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 59C1C88315;
	Tue,  7 May 2024 20:47:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=samcday.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=samcday.com header.i=@samcday.com header.b="kHXtW5wI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C7C488315; Tue,  7 May 2024 20:47:03 +0200 (CEST)
Received: from mail-4323.proton.ch (mail-4323.proton.ch [185.70.43.23])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9ADF088116
 for <u-boot@lists.denx.de>; Tue,  7 May 2024 20:47:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=samcday.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=me@samcday.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samcday.com;
 s=protonmail2; t=1715107619; x=1715366819;
 bh=QlqxeIq51f4uUs/maV3L90NjheInaPoB/sx8o/8mQ4g=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=kHXtW5wIoTk8egqaXdgTct4tPxmb1CLY4NZwOIVObqDq88dyDG17swpoPmCWWIbM2
 tTTaqqAm8DP2AdhuFcI/ePfFN7ZyLZSwAGUYV53pqrRcU5TBCtXNus0y0BtO7N9ZrR
 HwQl8CluKMaiAdZLUnuJULypfF6hBzCnwafKYS3x2IsUWpQf6kjrqOiimxkNfZ2zCi
 ye7Qap+aktTLZdgmoGPLbkTT+AkRFJManIqZ0r5pzx8n7nuTGvvqetDY7ts7Uw4RmF
 69eB6tvfn1Fcd23w4gLhSdtpr12bcVuLEY0bOxo0JkjE7KpoZ9OIUDaXV3GO68rwfa
 yWhifVWx2TDVw==
Date: Tue, 07 May 2024 18:46:54 +0000
To: Caleb Connolly <caleb.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Sumit Garg <sumit.garg@linaro.org>,
 Tom Rini <trini@konsulko.com>
From: Sam Day <me@samcday.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de, Sam Day <me@samcday.com>
Subject: [PATCH] qcom_defconfig: enable msm8916 and msm8996
Message-ID: <20240507-qcom-defconfig-msm8916-v1-1-6d6914bfc00f@samcday.com>
Feedback-ID: 25366008:user:proton
X-Pm-Message-ID: c68eb679ca26e70e7c5dc2ceb90c5081620df527
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

From: Caleb Connolly <caleb.connolly@linaro.org>

Enable the clock/pinctrl drivers for these two SoCs. Previously left out
due to only being used on the db410c and db820c respectively which both
have their own board code. We can still boot these with most features
working without that board code.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
I nabbed this commit from one of Caleb's work trees. Along with the
carveout patch I just sent, this gets U-Boot to successfully boot when
chained from lk2nd on msm8916 devices supported by that bootloader.

A similar plea on this patch as with the "mach-snapdragon: do carveouts
for qcs404 only" patch: if we could scrape these changes into the
2024.07 release that would be positively sublime.

Signed-off-by: Sam Day <me@samcday.com>
---
 configs/qcom_defconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
index 80ad3b32e1..c438aeef8e 100644
--- a/configs/qcom_defconfig
+++ b/configs/qcom_defconfig
@@ -37,6 +37,8 @@ CONFIG_OF_LIVE=3Dy
 CONFIG_OF_BOARD_SETUP=3Dy
 CONFIG_BUTTON_QCOM_PMIC=3Dy
 CONFIG_CLK=3Dy
+CONFIG_CLK_QCOM_APQ8016=3Dy
+CONFIG_CLK_QCOM_APQ8096=3Dy
 CONFIG_CLK_QCOM_QCM2290=3Dy
 CONFIG_CLK_QCOM_QCS404=3Dy
 CONFIG_CLK_QCOM_SDM845=3Dy
@@ -73,6 +75,8 @@ CONFIG_PHY_QCOM_QUSB2=3Dy
 CONFIG_PHY_QCOM_USB_SNPS_FEMTO_V2=3Dy
 CONFIG_PHY_QCOM_SNPS_EUSB2=3Dy
 CONFIG_PINCTRL=3Dy
+CONFIG_PINCTRL_QCOM_APQ8016=3Dy
+CONFIG_PINCTRL_QCOM_APQ8096=3Dy
 CONFIG_PINCTRL_QCOM_QCM2290=3Dy
 CONFIG_PINCTRL_QCOM_QCS404=3Dy
 CONFIG_PINCTRL_QCOM_SDM845=3Dy

---
base-commit: 1c40dda60f5f7e83a6d6f541cf5a57eb7e8ec43c
change-id: 20240507-qcom-defconfig-msm8916-61c8437a0b2e

Best regards,
--=20
Sam Day <me@samcday.com>



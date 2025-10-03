Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8D61CAC5B0
	for <u-boot@archiver.kernel.org>; Fri,  3 Oct 2025 12:48:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC65183824;
	Fri,  3 Oct 2025 14:48:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=mainlining.org header.i=@mainlining.org header.b="THUNEOiA";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="+rmLyQDL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 09A2B836B4; Fri,  3 Oct 2025 12:03:09 +0200 (CEST)
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C0EA18366F
 for <u-boot@lists.denx.de>; Fri,  3 Oct 2025 12:03:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=mainlining.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=david.wronek@mainlining.org
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org;
 c=relaxed/relaxed; 
 h=To:Message-Id:Date:Subject:From; t=1759485670; bh=9VxJhKLBGoYtRY7KeaMskRc
 TBpsT65VsB2GYJ+xV2HI=; b=THUNEOiAHTw62mXNexZWdbMkcGySyMNDtEKz8rdWPNy16d1kMN
 gdhDMrhmoVz5pBrIdcVJNNl6Ptn3L/7+hrIZqBuVObeMRzhqvOwNgfW6hRmwJMjBIeXb5dGAIKo
 +rv2KkWtpzIQNwjQCga9PduQgTNYoHwT6t/Zc6Q7ferp0ZxQsOAt4aoQD+xPRWU2hlet2brc9bs
 QYsCLA7r8GalIsiF0cQuBGO92DWu7mAzfL1Q76UnsS3dqOBdg60vg5HlqKraBZVHb/MpC141s1j
 Mh7wDf6OGXr1RT25gMMo5oCYZ/0Ppp20OoAafGBoxhHCRJcxh9L4VlDK30oW1YAgiDg==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org;
 c=relaxed/relaxed; 
 h=To:Message-Id:Date:Subject:From; t=1759485670; bh=9VxJhKLBGoYtRY7KeaMskRc
 TBpsT65VsB2GYJ+xV2HI=; b=+rmLyQDLb0ay+bIO1siQiX4s5TtbiczB5K6ygotmZB50OQRAMC
 WUeYRmer1y3sBOhuk+6R8E0MsVoDO5fEpvDA==;
From: David Wronek <david.wronek@mainlining.org>
Subject: [PATCH v2 0/5] Add initial support for Qualcomm SDM670
Date: Fri, 03 Oct 2025 12:01:08 +0200
Message-Id: <20251003-sdm670-v2-0-52c0fa481286@mainlining.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOSe32gC/2XMQQrCMBCF4auUWRuZjLFFV95DukibMR2wSUkkK
 KV3N3br8n88vhUyJ+EM12aFxEWyxFCDDg2Mkw2elbjaQEhnvGijspvbDhU7NgO1buwIoZ6XxA9
 579C9rz1JfsX02d2if+sfUbRCZU/GIBlsyQ632Up4SpDgjzF56Ldt+wKIAD6voQAAAA==
X-Change-ID: 20250914-sdm670-ede4b26dc720
To: Alexey Minnekhanov <alexeymin@postmarketos.org>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Christopher Obbard <christopher.obbard@linaro.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Julius Lehmann <lehmanju@devpi.de>, Lukasz Majewski <lukma@denx.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Rui Miguel Silva <rui.silva@linaro.org>, Sam Day <me@samcday.com>, 
 Sean Anderson <seanga2@gmail.com>, Sumit Garg <sumit.garg@kernel.org>, 
 Tom Rini <trini@konsulko.com>, 
 Varadarajan Narayanan <quic_varada@quicinc.com>
Cc: linux@mainlining.org, ~postmarketos/upstreaming@lists.sr.ht, 
 u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>, 
 Sumit Garg <sumit.garg@oss.qualcomm.com>, 
 David Wronek <david.wronek@mainlining.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759485669; l=1159;
 i=david.wronek@mainlining.org; s=20250914; h=from:subject:message-id;
 bh=TIYJmXMTIXq6TkSBlJWvmJGTL/gMr876mPj2gR8jHic=;
 b=YUKVZB7ca6zIWwDSLGtLOMKYV0juJ6U7nP2YaRW7NmoGQklnSecZdCO7QckOqcBUPFcaW100j
 C9NrO6t5bRaA7QEW64nTST9E5V5Ku2QBlGhpJF8XRrg/xlz5x5LwC0H
X-Developer-Key: i=david.wronek@mainlining.org; a=ed25519;
 pk=NtKhS1PfXjRIaJwWcYTu7JS0cX3GEmccZo+a6erVTfU=
X-Mailman-Approved-At: Fri, 03 Oct 2025 14:48:13 +0200
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

This patch series adds support for the Qualcomm SDM670 SoC, used in
various Android devices like the Google Pixel 3a.

Signed-off-by: David Wronek <david.wronek@mainlining.org>
---
Changes in v2:
- Dropped special_pins_names
- Link to v1: https://lore.kernel.org/r/20250914-sdm670-v1-0-a344024062ab@mainlining.org

---
David Wronek (5):
      clk/stub: add sdm670 rpmh clock
      clk/qcom: sdm845: add support for sdm670
      pinctrl: qcom: add sdm670 pinctrl driver
      qcom_defconfig: enable pinctrl for sdm670
      gpio: qcom_spmi: add pm660l

 configs/qcom_defconfig                |   1 +
 drivers/clk/clk-stub.c                |   1 +
 drivers/clk/qcom/clock-sdm845.c       | 127 +++++++++++++++++
 drivers/gpio/qcom_spmi_gpio.c         |   1 +
 drivers/pinctrl/qcom/Kconfig          |   7 +
 drivers/pinctrl/qcom/Makefile         |   1 +
 drivers/pinctrl/qcom/pinctrl-sdm670.c | 247 ++++++++++++++++++++++++++++++++++
 7 files changed, 385 insertions(+)
---
base-commit: 72f72fab00773f7ee89c9635e490908c0a058162
change-id: 20250914-sdm670-ede4b26dc720

Best regards,
--  
David Wronek <david.wronek@mainlining.org>


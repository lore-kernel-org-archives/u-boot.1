Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A37EC3DA6E
	for <u-boot@archiver.kernel.org>; Thu, 21 Dec 2023 00:41:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A3A0C87861;
	Thu, 21 Dec 2023 01:41:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="tU5VGIDj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F1FC28785C; Thu, 21 Dec 2023 01:41:13 +0100 (CET)
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com
 [IPv6:2607:f8b0:4864:20::831])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD06D87862
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 01:41:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qt1-x831.google.com with SMTP id
 d75a77b69052e-4279a1b2a00so486681cf.0
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 16:41:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703119268; x=1703724068; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PGlz1zb7UnE0cFW/7/3DW6AmPJi5x5oFXIB45jhBBYA=;
 b=tU5VGIDj1pfd7rjXMTzCBcNMeDckZYT7IFiG+8XAeiWT8oTTwqVghXz2UYA1fXeKs6
 LR5JX5W52oY4tI2D/m9RmHKPcxOE/YycQDJWxhu+2y/shcb5HA3W6AtUaeus9Czmdb4Q
 Owbsc57qz2Y5YmURWLywT6ErAIWLeL1NlBXIbPDLyMSVjMwLHj5Z391tuKSX108nVm4/
 58U4ZGZduaj+4IqLptpiwh4BrSPRP0i4xtcoev3ZLplgFlEEpMdOgsuKrDF2/n/b3j4z
 hmFRQn02A2C9hWE3P6l+PS4wAjxhWehlqY4cGYZWJ4hUbCNM8yQj2lS0MTirSc8dGMH+
 zC2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703119268; x=1703724068;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PGlz1zb7UnE0cFW/7/3DW6AmPJi5x5oFXIB45jhBBYA=;
 b=RRSx0iWj2oe8zn2n1rKM+mnf9F6Erfh3c3KEDYSnVrO9G1/hujziposOpjzJ82RfTv
 +HcrBYPwRODK37CTjPeKa+oS0cSr28DzIyPj9s9ZfIhCbLdYMGOmBQdsf3GHR9KFwUh+
 /S7fBg7OdcN09B2lGiFA3q8PXc16LijVtnQc6goN+aSxzL8TzMhcVpHidF9FAVNFwPhQ
 8aKj8F5WwX7mi/+wgdF/qKnc6a9Hi7FqJLCYc3SJvg15skFbanLzQay4ZVshkOAbXrSf
 wXM79EAgicLHXmSUV3W21Fn8Y+C72w5MsMFm3AwRBHYVgkL8h+z+XfiB8HZAD1fsnvsx
 ZFTQ==
X-Gm-Message-State: AOJu0YyR/+4aBfvoI/eCuc0PQSeaav7/jNWBuNyHs1G53o7LmUr1lPFS
 S5MouSpTD2K0/J24RFakrYUETRmQJFwjRRZqZ0s=
X-Google-Smtp-Source: AGHT+IFD287DlolpCuokNm2W6g87Eh5jcblDMcjqrmbdQkg+ARudn0VCogwO+qYOui+IR8tGID3U+A==
X-Received: by 2002:a05:622a:1006:b0:427:9a7a:2c73 with SMTP id
 d6-20020a05622a100600b004279a7a2c73mr102279qte.82.1703119267880; 
 Wed, 20 Dec 2023 16:41:07 -0800 (PST)
Received: from ubuntu.localdomain
 (cpe688f2e182063-cm688f2e182060.sdns.net.rogers.com. [174.115.4.214])
 by smtp.gmail.com with ESMTPSA id
 fv9-20020a05622a4a0900b00419801b1094sm354184qtb.13.2023.12.20.16.41.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Dec 2023 16:41:07 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de, ilias.apalodimas@linaro.org, sjg@chromium.org,
 jwerner@chromium.org
Cc: Raymond Mao <raymond.mao@linaro.org>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Kevin Chen <kevin_chen@aspeedtech.com>, Nikhil M Jain <n-jain1@ti.com>,
 Bin Meng <bmeng.cn@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Shiji Yang <yangshiji66@outlook.com>, Baruch Siach <baruch@tkos.co.il>,
 Michal Simek <michal.simek@amd.com>, Stefan Roese <sr@denx.de>,
 Sean Anderson <sean.anderson@seco.com>
Subject: [PATCH v2 4/9] arm: armv7: save boot arguments
Date: Wed, 20 Dec 2023 16:40:23 -0800
Message-Id: <20231221004030.581388-5-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231221004030.581388-1-raymond.mao@linaro.org>
References: <20231221004030.581388-1-raymond.mao@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Save boot arguments r[0-3] into an array for handover of bloblist from
previous boot stage.

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
Changes in v2
- New patch file created for v2.

 arch/arm/cpu/armv7/start.S | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/cpu/armv7/start.S b/arch/arm/cpu/armv7/start.S
index 69e281b086..ac55b443da 100644
--- a/arch/arm/cpu/armv7/start.S
+++ b/arch/arm/cpu/armv7/start.S
@@ -152,9 +152,21 @@ ENDPROC(c_runtime_cpu_setup)
  *
  *************************************************************************/
 WEAK(save_boot_params)
+#if (IS_ENABLED(CONFIG_OF_BOARD) && IS_ENABLED(CONFIG_BLOBLIST))
+	ldr r12, =saved_args
+	stm r12, {r0, r1, r2, r3}
+#endif
 	b	save_boot_params_ret		@ back to my caller
 ENDPROC(save_boot_params)
 
+.section .data
+.global saved_args
+saved_args:
+	.rept 4
+	.word 0
+	.endr
+END(saved_args)
+
 #ifdef CONFIG_ARMV7_LPAE
 WEAK(switch_to_hypervisor)
 	b	switch_to_hypervisor_ret
-- 
2.25.1


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9295C4828F
	for <u-boot@archiver.kernel.org>; Sat,  3 Feb 2024 16:38:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5625D876F8;
	Sat,  3 Feb 2024 17:38:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="F34yrvsJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B41D487A0E; Sat,  3 Feb 2024 17:38:03 +0100 (CET)
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com
 [IPv6:2001:4860:4864:20::31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 90A998767C
 for <u-boot@lists.denx.de>; Sat,  3 Feb 2024 17:38:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-210dec2442eso1923891fac.2
 for <u-boot@lists.denx.de>; Sat, 03 Feb 2024 08:38:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706978280; x=1707583080; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PqXyfHBqMSkxZ7lDO2aXzwVXS3GdMqigO7TWvRT1RX4=;
 b=F34yrvsJUJoSrucNYjy29wOXxrhCnpcnrJbSIdLdbKTvE13vOdbSnZhK9VVy+OTSQc
 k6AiJADQzhPzjGZ0prYRzHP44n7VOHy2Bb5ysTG42aKXXb56UeeFeeCvTlONJgZcDqmD
 ZJFBszs32EwMquxdQ9WOeQ3KotKkdF8Hfr8zqjUFi97Q/VVhnXbXfoHRHOnv//KRmLib
 RscrkxiFns3vrg6KiIb2SlDKAUwsEAUCmOY8PnrQiYLeAOenkJGMLDZ/GSf2oLNu7nBh
 VhDt4CmY+NzRmAJt97P1jva5GYOuCsOyZ1tHxSQ6JnB47iXG7hR8dzGmw5VX1Kvv8I/G
 bNIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706978280; x=1707583080;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PqXyfHBqMSkxZ7lDO2aXzwVXS3GdMqigO7TWvRT1RX4=;
 b=vpMD+6Gzh7ynf5wLm90jZpeUpBcFzl7ZC5/m6udx3/Uk3dMTVbDG7Zovx+i7NJLUS7
 OOQ3Ovde42/JRB7xbwF1sJN1xN2JAnUWlI3z4l8ewyPQIkD3mQPEjHgoHpxlZ0ogMgHT
 bThYf0PUzN89kiMO04T3yX7vewK0EBllKLE22UtnICla6ke1dqiqy9Z44QLuZ1IUd22l
 OGoXinQoUcO2IxynBdxoON/cBgjwOn+uleTSIedHkl7A+haFfwCqOFi0/JQQ9UTF7NtJ
 pBZzaOqpQ7oFb4sCQQe5QVGS0j0tqj3WJkSmupqn4PkRRhuw7HCYqsy7WugqnTemc3ym
 uWgw==
X-Gm-Message-State: AOJu0Yx62JbZFYMGOUKVrhpH7Bd43dRv+pKntv4U6BjUQHtxeNeXXT6l
 AbBhSkIa4V8ccId23MoAn03KDCx7sNTThOJmgXDFOqcx0dmDGuAiwX+NeYTlW2riIq5lsEUP5OR
 V
X-Google-Smtp-Source: AGHT+IEzcaOnWuj+egT5CP9AZbKLUYHAYktjgvcsWnnUjcFWaC/r3oTxY79osnBihPXKdY2pm9mA8w==
X-Received: by 2002:a05:6870:440e:b0:219:433d:8b4c with SMTP id
 u14-20020a056870440e00b00219433d8b4cmr2904623oah.14.1706978279839; 
 Sat, 03 Feb 2024 08:37:59 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCX5zRuJwm7YxpkYGMY1KjvjtXMqvnZli+mKUK9KDtABg87tsQ+A0vvBtUJihsxDd+mDIPESOhpD5z/c5SZvGPwEN23eHCkFkUG8TYApkYybUZSOcyO/b3zIpsG0ENA39W+SReI4ydQJrB3Wo134vXOW3xL6D3WY1KcHDpdaoVGGCg3uvtgcSkrUkKlhG/aSfKJ9jLSelcbLVHt7+mPnpTmNM2FtWqTp4RbwfBhu07PvCDorszpJNGUBWcB8Z94ea07ry+D4bOOigN2aANPWzuyFOm4+SWFXDIT04IMgDYxDbNCYPhkgyDkRuCm6lqM1LF2t/HU0AManoolJUo0JC6EY8E22CBK2SyYut8CMPhyp1wKNxID0FswvaeTU7b3HGTrJBmUS2H5Wn+kY8oanC4N7FNakh//VvbbXpcJ6tgY=
Received: from ubuntu.localdomain
 (cpe688f2e182063-cm688f2e182060.sdns.net.rogers.com. [174.115.4.214])
 by smtp.gmail.com with ESMTPSA id
 oj16-20020a056214441000b006869d54c818sm1909086qvb.109.2024.02.03.08.37.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 Feb 2024 08:37:59 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymond.mao@linaro.org>, Ard Biesheuvel <ardb@kernel.org>,
 Simon Glass <sjg@chromium.org>, Kevin Chen <kevin_chen@aspeedtech.com>,
 Sean Anderson <sean.anderson@seco.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, Nikhil M Jain <n-jain1@ti.com>,
 Shiji Yang <yangshiji66@outlook.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Michal Simek <michal.simek@amd.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Qu Wenruo <wqu@suse.com>
Subject: [PATCH v8 5/8] arm: armv8: save boot arguments
Date: Sat,  3 Feb 2024 08:36:24 -0800
Message-Id: <20240203163631.177508-6-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240203163631.177508-1-raymond.mao@linaro.org>
References: <20240203163631.177508-1-raymond.mao@linaro.org>
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

Save boot arguments x[0-3] into an array for handover of bloblist from
previous boot stage.

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
Suggested-by: Ard Biesheuvel <ardb@kernel.org>
---
Changes in v2
- New patch file created for v2.
Changes in V5
- Drop the dependence on OF_BOARD.
Changes in V7
- Exclude the saved_args when BLOBLIST is disabled.
Changes in V8
- Use PC-relative reference for saved_args.
- Add 4-byte alignment for saved_args.

 arch/arm/cpu/armv8/start.S | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm/cpu/armv8/start.S b/arch/arm/cpu/armv8/start.S
index 6cc1d26e5e..7461280261 100644
--- a/arch/arm/cpu/armv8/start.S
+++ b/arch/arm/cpu/armv8/start.S
@@ -370,5 +370,28 @@ ENTRY(c_runtime_cpu_setup)
 ENDPROC(c_runtime_cpu_setup)
 
 WEAK(save_boot_params)
+#if (IS_ENABLED(CONFIG_BLOBLIST))
+	/* Calculate the PC-relative address of saved_args */
+	adr	x9, saved_args_offset
+	ldr	w10, saved_args_offset
+	add	x9, x9, w10, sxtw
+
+	stp	x0, x1, [x9]
+	stp	x2, x3, [x9, #16]
+#endif
 	b	save_boot_params_ret	/* back to my caller */
 ENDPROC(save_boot_params)
+
+#if (IS_ENABLED(CONFIG_BLOBLIST))
+saved_args_offset:
+	.long	saved_args - .	/* offset from current code to save_args */
+
+	.section .data
+	.align 2
+	.global saved_args
+saved_args:
+	.rept 4
+	.dword 0
+	.endr
+END(saved_args)
+#endif
-- 
2.25.1


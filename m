Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3D76C4828F
	for <u-boot@archiver.kernel.org>; Sat,  3 Feb 2024 16:38:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C1A3F87B98;
	Sat,  3 Feb 2024 17:37:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="oltl7Dtb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B103687A4B; Sat,  3 Feb 2024 17:37:57 +0100 (CET)
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com
 [IPv6:2607:f8b0:4864:20::c30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9515D8767C
 for <u-boot@lists.denx.de>; Sat,  3 Feb 2024 17:37:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-59a8ee08c23so1302663eaf.2
 for <u-boot@lists.denx.de>; Sat, 03 Feb 2024 08:37:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706978274; x=1707583074; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=msYYYOfOCIIEwLKvt+49ol2npAn4TXw2keNESaVd8rk=;
 b=oltl7DtbSULDYILrMr0h1kbH4W/476hsHY+Dp8kctmieIxS5+XNeu6BdhH+9BYyiKk
 M0ekXuFAAcfogC8Pz0hGzBBBDxfb8yOA5KDtqH1PQAy0vDKF2l2YvxoSo4mkxXHNTZ0X
 7TraraIeWhwmJtA2xvlEcV/in3ZDaPDiIumgaOorukPSHt+Gjeo2e9ROJSXUXQzIvQdK
 STXbjdJblw5AZDww9LQED839purxBGYguxoxiZfDFvddcHWvr44G7OhZuKAW3exmV8Py
 rjjsTFDf4mkxKG10/3k63u4nKIxKSGf68oSahSMETdskKZFBx7F3Tlfa8qbYs0pQFEOY
 dbAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706978274; x=1707583074;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=msYYYOfOCIIEwLKvt+49ol2npAn4TXw2keNESaVd8rk=;
 b=uEecMcGYtZwCSmWu0Lfge7b4u0hCsqfBHNq9w9GmPL/9QDfdT7F7G+m77/RUJqfZMi
 L1PNjJvhPHi7mwSTjhNaZmgFavYiZshQF9IZM49GDzRskJGs8EPHoCnpY4XKK/sYEmmr
 JgL3XDPoWzSkfU6zYGuXxOitpLcNi7jP/bGHHG1AaZHdJrK4MnigVto4y202DebBB8eL
 U2QsKE6PrX8s7EkMVgVFTSbduBGSTMYx9ry4YI4iIPcRTuHedvCTkcbHYS6RyWbzJDrt
 rM9uFpdDMcep/WklQPVCddJTc3izFnJRrnW8ThdVfYBEZB1y3gUXTN53Ei7kcEDo+aby
 Id4Q==
X-Gm-Message-State: AOJu0YwTCqgsw6z6+o7+JIdEaWt03CPkF3EuoPFWNvSWRXInLlZeYQc/
 dEVngDy8agc052nAwZoho7qPa1zlWvxsNyssAvyqx8Yl4oCE0EzAmq+NivxP/Z11Q/pdeAOkll1
 f
X-Google-Smtp-Source: AGHT+IFMHorxz3ec+ioaibc2k6AG8YHF9J8JuFB8K4ESCNQkfuLyN5ANhxY3sezl1/UXW6WHTd7V8g==
X-Received: by 2002:a05:6359:4285:b0:177:6dc9:ac1e with SMTP id
 kp5-20020a056359428500b001776dc9ac1emr11334864rwb.8.1706978273704; 
 Sat, 03 Feb 2024 08:37:53 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCVQqI27WIhLkK2nhBLc+mRu1+wvEhu9puzQegt9Fs9o4FPxcUWqKYt3+1bBtD5n96e8vZMeDuqZ9EQ8d6RUqB1u8wGXPliQIPytPtMxLJw9PZ3n4GKr3OL4sI3cc1i4Z3+hmlNGmj36p/vscfH4gE5E2mz5y+00txGG42mNM0OvyBNTEl0sw+3Hw8OSm5TZLGywLloMNlaUo2RprEoXFPhOD7XT7uFGQUgVhtPZsrfqx00dC9GCeeTLR/35m+2o369bwc1MOV9bSH0seG8C15U5xY28iXqLqp66iBFZ84mt6ZSanLHVqB4shR8ubNQSqdlEa+Lm1HutH3H2r4fyZXD9D0/4hwD1f8scbJ/+lDyAXE1j0ZY/OsG60lcZ7JC75LCfLn+GKn+DZA3HsrqHNXfYscWb5dRC79CEqK/aHTcRhzru27P3ISeU5L2hYK53fTfRlzagaIBJHHHe67zTag==
Received: from ubuntu.localdomain
 (cpe688f2e182063-cm688f2e182060.sdns.net.rogers.com. [174.115.4.214])
 by smtp.gmail.com with ESMTPSA id
 oj16-20020a056214441000b006869d54c818sm1909086qvb.109.2024.02.03.08.37.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 Feb 2024 08:37:53 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymond.mao@linaro.org>, Ard Biesheuvel <ardb@kernel.org>,
 Simon Glass <sjg@chromium.org>, Kevin Chen <kevin_chen@aspeedtech.com>,
 Sean Anderson <sean.anderson@seco.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, Nikhil M Jain <n-jain1@ti.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Shiji Yang <yangshiji66@outlook.com>, Michal Simek <michal.simek@amd.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Qu Wenruo <wqu@suse.com>
Subject: [PATCH v8 4/8] arm: armv7: save boot arguments
Date: Sat,  3 Feb 2024 08:36:23 -0800
Message-Id: <20240203163631.177508-5-raymond.mao@linaro.org>
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

Save boot arguments r[0-3] into an array for handover of bloblist from
previous boot stage.

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
Suggested-by: Ard Biesheuvel <ardb@kernel.org>
---
Changes in v2
- New patch file created for v2.
Changes in v3
- Swap value of r0 with r2.
Changes in v4
- Fix a bug when saving the boot args.
Changes in V5
- Drop the dependence on OF_BOARD.
Changes in V7
- Exclude the saved_args when BLOBLIST is disabled.
Changes in V8
- Use PC-relative reference for saved_args.
- Add 4-byte alignment for saved_args.

 arch/arm/cpu/armv7/start.S | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/arm/cpu/armv7/start.S b/arch/arm/cpu/armv7/start.S
index 69e281b086..7730a16e51 100644
--- a/arch/arm/cpu/armv7/start.S
+++ b/arch/arm/cpu/armv7/start.S
@@ -152,9 +152,38 @@ ENDPROC(c_runtime_cpu_setup)
  *
  *************************************************************************/
 WEAK(save_boot_params)
+#if (IS_ENABLED(CONFIG_BLOBLIST))
+	/* Calculate the PC-relative address of saved_args */
+	adr	r12, saved_args_offset
+	ldr	r13, saved_args_offset
+	add	r12, r12, r13
+
+	/*
+	 * Intentionally swapping r0 with r2 in order to simplify the C
+	 * function we use later.
+	 */
+	str	r2, [r12]
+	str	r1, [r12, #4]
+	str	r0, [r12, #8]
+	str	r3, [r12, #12]
+#endif
 	b	save_boot_params_ret		@ back to my caller
 ENDPROC(save_boot_params)
 
+#if (IS_ENABLED(CONFIG_BLOBLIST))
+saved_args_offset:
+	.long	saved_args - .	/* offset from current code to save_args */
+
+	.section .data
+	.align 2
+	.global saved_args
+saved_args:
+	.rept 4
+	.word 0
+	.endr
+END(saved_args)
+#endif
+
 #ifdef CONFIG_ARMV7_LPAE
 WEAK(switch_to_hypervisor)
 	b	switch_to_hypervisor_ret
-- 
2.25.1


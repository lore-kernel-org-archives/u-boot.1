Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03A9DC46CD2
	for <u-boot@archiver.kernel.org>; Tue,  2 Jan 2024 22:13:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA1118796B;
	Tue,  2 Jan 2024 23:13:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="zCAZ2/45";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8269287980; Tue,  2 Jan 2024 23:13:34 +0100 (CET)
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com
 [IPv6:2607:f8b0:4864:20::f2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C696887987
 for <u-boot@lists.denx.de>; Tue,  2 Jan 2024 23:13:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-67f9f6ca479so74847096d6.3
 for <u-boot@lists.denx.de>; Tue, 02 Jan 2024 14:13:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704233610; x=1704838410; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xAmjtAmHfutWl3JNMhyfdCg/CfELCV28imuP360X0t8=;
 b=zCAZ2/45K3NemA4cduYmTIXR/rWicisY3gimK8hU8RTGinbDHAhRuLF7sWYkwcpe7c
 rFOYAQz35kFcn/6hIF+ZWW1I/t6GHxAwk3UjIk32ZLZBtgaxxrLVDyIFWWzPkkwxJNCk
 DFbI0rCTHuiXsueEcJt1tEJAGDg++yn/k04qt11trl1Q8AYB1G9cnvr843DChE7sMu1b
 Cck97YmwXmsPTXqqC9AKTnzfwQMb2yJz9EDIdmTxXDA/+Ws5IjSDYtNzT6r8Iu8TY810
 AUYlD7fsh3npoIyte86eLIOYimjL9G2/eX5iSQnubxYnQP3LDT9uO9TpVm8O8jjcKte4
 8PaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704233610; x=1704838410;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xAmjtAmHfutWl3JNMhyfdCg/CfELCV28imuP360X0t8=;
 b=BA9e7QwSOYBhx9jg+QG6Je9U9Lijx6G53OrByWWZaK26uBDK+BO2sYr3UEMPWoA2tn
 UMOZjU3INqalPXPSS0ZFoPYtPhVEG1y03rRRcrUO97BXkk17UPvnE7+Jutpoy1XrKPTW
 ezN0JsRyYFrJE7w86FNwgu5jmniNYJFrNE8GZ56OYOMWc15a8M44+rFogDJbi6k6L/t/
 /f4ZLXrE9NQZKP9sAfrJpR5TH/s/o28KzfGvoPv1aoVhYlVsBdtakeUJij32xRtU4Vto
 B5MdLxITLnVfhy5iFwL9glRBV/vB/Ozl+APo2WlZk+LAHQDi3PhWE0Bi7rt8ZNiqxfv9
 Jngw==
X-Gm-Message-State: AOJu0Yzes1IucpZJTBxMMUr1v0Hh2nrxuE5vs3VqTLnBd0FQvc6UdBF6
 Sy/ZlJupEnQ/g1N0v+ecAiaZB9+2rGEzQmJENgMyWA2yzkA=
X-Google-Smtp-Source: AGHT+IHAF+0EiYiN3t04euJuyiUy56ydzRUWk6xwyuIA0fyj48VB+kpfVGSDzY2XuMkQW/aDO89ytw==
X-Received: by 2002:a05:6214:dc2:b0:67a:b63e:8f93 with SMTP id
 2-20020a0562140dc200b0067ab63e8f93mr35735579qvt.28.1704233610477; 
 Tue, 02 Jan 2024 14:13:30 -0800 (PST)
Received: from ubuntu.localdomain
 (cpe688f2e182063-cm688f2e182060.sdns.net.rogers.com. [174.115.4.214])
 by smtp.gmail.com with ESMTPSA id
 mg14-20020a056214560e00b0067f70cc986asm10431487qvb.92.2024.01.02.14.13.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jan 2024 14:13:30 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de, ilias.apalodimas@linaro.org, sjg@chromium.org,
 jwerner@chromium.org
Cc: Raymond Mao <raymond.mao@linaro.org>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Kevin Chen <kevin_chen@aspeedtech.com>,
 Sean Anderson <sean.anderson@seco.com>, Nikhil M Jain <n-jain1@ti.com>,
 Bin Meng <bmeng.cn@gmail.com>, Devarsh Thakkar <devarsht@ti.com>,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Shiji Yang <yangshiji66@outlook.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Baruch Siach <baruch@tkos.co.il>,
 Michal Simek <michal.simek@amd.com>, Stefan Roese <sr@denx.de>
Subject: [PATCH v4 5/9] arm: armv8: save boot arguments
Date: Tue,  2 Jan 2024 14:12:30 -0800
Message-Id: <20240102221237.1007090-6-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240102221237.1007090-1-raymond.mao@linaro.org>
References: <20240102221237.1007090-1-raymond.mao@linaro.org>
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
Reviewed-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
Changes in v2
- New patch file created for v2.

 arch/arm/cpu/armv8/start.S | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/cpu/armv8/start.S b/arch/arm/cpu/armv8/start.S
index 6cc1d26e5e..8e704f590e 100644
--- a/arch/arm/cpu/armv8/start.S
+++ b/arch/arm/cpu/armv8/start.S
@@ -370,5 +370,19 @@ ENTRY(c_runtime_cpu_setup)
 ENDPROC(c_runtime_cpu_setup)
 
 WEAK(save_boot_params)
+#if (IS_ENABLED(CONFIG_OF_BOARD) && IS_ENABLED(CONFIG_BLOBLIST))
+	adr x9, saved_args
+	stp x0, x1, [x9]
+	/* Increment the address by 16 bytes for the next pair of values */
+	stp x2, x3, [x9, #16]
+#endif
 	b	save_boot_params_ret	/* back to my caller */
 ENDPROC(save_boot_params)
+
+.section .data
+.global saved_args
+saved_args:
+	.rept 4
+	.xword 0
+	.endr
+END(saved_args)
-- 
2.25.1


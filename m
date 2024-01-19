Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A56BC4725D
	for <u-boot@archiver.kernel.org>; Fri, 19 Jan 2024 15:29:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A775687C00;
	Fri, 19 Jan 2024 16:29:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="fsO6nfeM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC8C987BB5; Fri, 19 Jan 2024 16:29:31 +0100 (CET)
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com
 [IPv6:2607:f8b0:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B87B487C00
 for <u-boot@lists.denx.de>; Fri, 19 Jan 2024 16:29:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-il1-x134.google.com with SMTP id
 e9e14a558f8ab-3608bd50cbeso4264785ab.3
 for <u-boot@lists.denx.de>; Fri, 19 Jan 2024 07:29:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705678168; x=1706282968; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=70O85wPhaoVf5WO6fvHnMGIduy574PKUNX619hmQC6s=;
 b=fsO6nfeMfve2IZs5+vvItaNiW6ip8PIGtVvvw3pf/mZJARHHD//2IPIFIha/4HNyA+
 LZtSbh3ZYlhceqL48HMRSS3enK38nu/mrzB1Wgm3ZlVeL9gdV/PMrx3O312VCv6KGibC
 g0PEFG3RV/6VkzSL6hSq3WlAUyfVSeAy0lo0qu/x9/CDDKPBljB+D2FcUbccyLeXBaUG
 eKFzLS0a/sewhazmzqcn+JcfskU3XSbCIS9Yq/dxRQKDo9427W82VMg/YQcgAyq71+jz
 qgUv/1cIyN0akah+52545SZfPgJoZufhRuXVPKvLr/KXqoBUczW62RsOZ4Y/dBzaaG1A
 +jtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705678168; x=1706282968;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=70O85wPhaoVf5WO6fvHnMGIduy574PKUNX619hmQC6s=;
 b=R2BF+ROXcF8H4BPJpLMxcmCCyvmJXZyK/P/q1oMzWnnPch0k0NXkdSRA7731bsqGJn
 YvCbEmC7H3U4WXOVS++aStzqkM2B+B8ACPBRE72oq1CzieaFb8xbIP0wAlhmwCsY0G/d
 pDhlu6mDMlcbEhxt3Cbk99qN+i2Tn2Dnn6c6CKqArEupVBX0Yx+mOVTdCDrc7bTcb76S
 qbBD+51slwBvJgWptJQMdGjVb/yF1x73lmBB6rhuUcMhKaO5254vBi6CY8Id71nM+S6j
 cRejzbYQGt3ewf7ptzxs/bXSvoXVtB7LCo4aO7uGfPcEm4fTZXLxrti1D7j5yt9nb99S
 TeRQ==
X-Gm-Message-State: AOJu0YyoYx50xymKIyLLVKVhUPqMd8/NoVI38vwHPW2FIGFBWk6aVpFS
 ZH+v2Buo2jFhWck9UNR2eL/rYr4y3t5/AKoXIu8HMdPbAGb0og9OJJdVj6dc4pyjWERwr7WgWrb
 K
X-Google-Smtp-Source: AGHT+IFE9voIx3sYrijM2fidWlTr3f5GE0dDynY1GnXoBT3JcspT5MCT6wBGfzkPUzQUf4Tv71oQhA==
X-Received: by 2002:a5d:9393:0:b0:7be:f34a:5b53 with SMTP id
 c19-20020a5d9393000000b007bef34a5b53mr3338403iol.9.1705678167982; 
 Fri, 19 Jan 2024 07:29:27 -0800 (PST)
Received: from ubuntu.localdomain
 (cpe688f2e182063-cm688f2e182060.sdns.net.rogers.com. [174.115.4.214])
 by smtp.gmail.com with ESMTPSA id
 d96-20020a0285e9000000b0046e25dde777sm1627252jai.35.2024.01.19.07.29.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jan 2024 07:29:27 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de, ilias.apalodimas@linaro.org, sjg@chromium.org,
 jwerner@chromium.org
Cc: Raymond Mao <raymond.mao@linaro.org>,
 Kevin Chen <kevin_chen@aspeedtech.com>,
 Sean Anderson <sean.anderson@seco.com>, Bin Meng <bmeng.cn@gmail.com>,
 Nikhil M Jain <n-jain1@ti.com>, Shiji Yang <yangshiji66@outlook.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Devarsh Thakkar <devarsht@ti.com>, Michal Simek <michal.simek@amd.com>,
 Stefan Roese <sr@denx.de>, Qu Wenruo <wqu@suse.com>
Subject: [PATCH v7 5/8] arm: armv8: save boot arguments
Date: Fri, 19 Jan 2024 07:29:15 -0800
Message-Id: <20240119152918.715980-1-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
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
---
Changes in v2
- New patch file created for v2.
Changes in V5
- Drop the dependence on OF_BOARD.
Changes in V7
- Exclude the saved_args when BLOBLIST is disabled.

 arch/arm/cpu/armv8/start.S | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/cpu/armv8/start.S b/arch/arm/cpu/armv8/start.S
index 6cc1d26e5e..2a26b1c276 100644
--- a/arch/arm/cpu/armv8/start.S
+++ b/arch/arm/cpu/armv8/start.S
@@ -370,5 +370,21 @@ ENTRY(c_runtime_cpu_setup)
 ENDPROC(c_runtime_cpu_setup)
 
 WEAK(save_boot_params)
+#if (IS_ENABLED(CONFIG_BLOBLIST))
+	adr x9, saved_args
+	stp x0, x1, [x9]
+	/* Increment the address by 16 bytes for the next pair of values */
+	stp x2, x3, [x9, #16]
+#endif
 	b	save_boot_params_ret	/* back to my caller */
 ENDPROC(save_boot_params)
+
+#if (IS_ENABLED(CONFIG_BLOBLIST))
+.section .data
+.global saved_args
+saved_args:
+	.rept 4
+	.xword 0
+	.endr
+END(saved_args)
+#endif
-- 
2.25.1


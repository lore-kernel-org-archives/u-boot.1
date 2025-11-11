Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9928CCCFA18
	for <u-boot@archiver.kernel.org>; Tue, 11 Nov 2025 07:59:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0789683B2C;
	Tue, 11 Nov 2025 08:59:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="DpGJaqzx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE43983B43; Tue, 11 Nov 2025 08:59:20 +0100 (CET)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B3FEE83AB4
 for <u-boot@lists.denx.de>; Tue, 11 Nov 2025 08:59:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-47728f914a4so22238275e9.1
 for <u-boot@lists.denx.de>; Mon, 10 Nov 2025 23:59:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762847958; x=1763452758; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ruIG2Xz7tP2575E2Psc5cJMVmQRrJhlcymegjGzq0XY=;
 b=DpGJaqzx4DhO20Bd3gVWgk51ITwfZuMj9leeXPjrF6DxlFRNlzfU7QUhOdKyOrE9OY
 Gru480TV8ebxT6GiJfyzVaquAfcM8oR7Z6nRQq/ogdcvCeCO8wP8ABRtSrQNYp2tFh4M
 rTrP9XqXRkEeaqcAaRA6c2lbvD7zTnJ0bbW5cfEx7+TyxQ1wJHK4Znf5aXBAIxP9+q5S
 ejcWJmpqt2gH42UYu/yuNRKTPnUiJfQGSJeuU/b5nwAs52STiCqD/t8q70UfolgH6tFG
 Ki/wg9ghAaIUdgeAvLP26+LLNDwu1FITBQ3tiOwVugBHX8Z+ftdb1Ohcve9GdRPVqO53
 eREw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762847958; x=1763452758;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ruIG2Xz7tP2575E2Psc5cJMVmQRrJhlcymegjGzq0XY=;
 b=VF6mZInLO2lghRRgbjSi6+AhqhTV1O2g7Aq4GgYPJfiYVX49nDhCap+l7WorqpMw0f
 Z26UQGoHbfuZLi7lPmnvm+8B5+fwIMY4EGvRIhgOxjO9gNr7fbxluY0MKAlOgJzKQfeZ
 21B18D984YeWAWhU1FdHyN8b57z6DAWQz0oIBdlb1Xc4GKvP46312dNcUIK0G4FIZTgq
 X6n/1hTU3oE7NjsAJam6VJRpapFxt96JVisaCx614W0UMG0eJaBbMRRPUqr5yQMzSjhS
 APQRydGR2ZrDgfrhGZK5DDMPwHQV3NPKWF1ruvHcsB5m8J9i/mUOXBAaKdrsMn6oEitk
 0B0Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVF+R1xWYE/0KIOtby/sE47oFp97udbt2Khng1bh4uG7u6XAm3ouLhTq3QpKKWvdSHU3mmPcfI=@lists.denx.de
X-Gm-Message-State: AOJu0YydRz7oZe94R8Z/V+9a8l0edvSTjg2a5ZgIF3uk3C0Stj2pqVFI
 hLsdQfejiYwgthraxctIsOkgEktXe/O3G9U5N11F7tmhp4+O2VKfl+1Dyvp9LpJYZ6I=
X-Gm-Gg: ASbGncsD3B+7r72UYSrLPW14MHCM+GcYs36IV1+CvDPXiiDDDJKO2z1ggeP/d+H4p8N
 JwKBndSewW7LH46MMxo/tiVKDPgnBXwHUnVcL6beNbg+eV9mBtEEUq/4U5XfY6AE82ABt3DzlyM
 mPko7C+xACbtAVUsvHAQnsfwRVy2g4mBGF3k16paWHVm0azUgtpvRuxrAaW2X3WlGfIgswohupV
 dpbGDKBOEGLGAAAY6dYp40YO7QuFCziRZV1z9vi91whbjwUyZm5lIv4TKs/vHn5MXl81Ggpy4vD
 gL4IDsk2I+I0GNB5WWw16wKxlqh8Bw7t6DB6OOgHHj8N49ER7+ngQi4AZHWIP+Ocbqcwm3DoG2v
 ys7cygSbK6O/qdrb+x6UAm3xb/8Jyf1Vtys7rJ2JmYNrzhro8E33Xm3QgiAlhtGEsSsfN0ufZmJ
 /+HIZG8Olkv9TAB47ec0SX0F2UL1gI2w34RaYFlAQnj9JoAubWn/iGtwAUZ1dxI4c3PQ0=
X-Google-Smtp-Source: AGHT+IGi+L32L/LPyf+niM35ETI7tLtQX2UiRw7MCliTijrF6ExUIwYBVo/+jr+XzBW2bktR3puLvQ==
X-Received: by 2002:a05:600c:310a:b0:475:de12:d3b2 with SMTP id
 5b1f17b1804b1-477732975cfmr94827185e9.36.1762847958174; 
 Mon, 10 Nov 2025 23:59:18 -0800 (PST)
Received: from hera ([95.164.180.12]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4776bd08834sm245127175e9.15.2025.11.10.23.59.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Nov 2025 23:59:17 -0800 (PST)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: trini@konsulko.com
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Raymond Mao <raymondmaoca@gmail.com>, Xu Zhang <423756212@qq.com>,
 Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Subject: [PATCH v2] armv8: Fix transfer list passing with KVM
Date: Tue, 11 Nov 2025 09:59:06 +0200
Message-ID: <20251111075906.38701-1-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.51.0
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

When loading U-Boot in a low memory address, the adpr instruction
to preserve saved_args[] end up within the memory space of QEMUs
mapped pflashes. As a result the following store pair instructions
lead to a crash since instructions that modify more than one registers
can't trap into KVM.

This problem can be solved with loading U-Boot with -kernel
and defining a different text base address. But when running with
-bios we always start from 0x0. So let's postpone the calculation
of saved_args[] post relocation, where we will have an address that
doesn't collide with the QEMU flashes.

Acked-by: Raymond Mao <raymondmaoca@gmail.com>
Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
Changes since v1:
- Move comments to the appropriate place
- Add missing ifdefs when calculating the bloblist placement

 arch/arm/cpu/armv8/start.S | 9 ++++-----
 arch/arm/lib/crt0_64.S     | 7 +++++++
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/arch/arm/cpu/armv8/start.S b/arch/arm/cpu/armv8/start.S
index 40c342e97e9b..c9ca93bcc904 100644
--- a/arch/arm/cpu/armv8/start.S
+++ b/arch/arm/cpu/armv8/start.S
@@ -386,11 +386,10 @@ ENDPROC(c_runtime_cpu_setup)
 
 WEAK(save_boot_params)
 #if (IS_ENABLED(CONFIG_BLOBLIST))
-	/* Calculate the PC-relative address of saved_args */
-	adrp	x9, saved_args
-	add	x9, x9, :lo12:saved_args
-	stp 	x0, x1, [x9]
-	stp 	x2, x3, [x9, #16]
+	mov     x0, x19
+	mov     x1, x20
+	mov     x2, x21
+	mov     x3, x22
 #endif
 	b	save_boot_params_ret	/* back to my caller */
 ENDPROC(save_boot_params)
diff --git a/arch/arm/lib/crt0_64.S b/arch/arm/lib/crt0_64.S
index 3e7627aa389b..588d89687206 100644
--- a/arch/arm/lib/crt0_64.S
+++ b/arch/arm/lib/crt0_64.S
@@ -132,6 +132,13 @@ ENTRY(_main)
 	b	relocate_code
 
 relocation_return:
+#if (IS_ENABLED(CONFIG_BLOBLIST))
+	/* Calculate the PC-relative address of saved_args */
+	adrp    x9, saved_args
+	add     x9, x9, :lo12:saved_args
+	stp     x19, x20, [x9]
+	stp     x21, x22, [x9, #16]
+#endif
 
 /*
  * Set up final (full) environment
-- 
2.51.0


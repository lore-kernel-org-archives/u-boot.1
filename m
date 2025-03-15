Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3755C28B30
	for <u-boot@archiver.kernel.org>; Sat, 15 Mar 2025 14:31:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 33D6381DFA;
	Sat, 15 Mar 2025 15:28:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DZMkZv1w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CE9C881A02; Sat, 15 Mar 2025 15:28:04 +0100 (CET)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D12D381DED
 for <u-boot@lists.denx.de>; Sat, 15 Mar 2025 15:28:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-43cf034d4abso7470295e9.3
 for <u-boot@lists.denx.de>; Sat, 15 Mar 2025 07:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1742048882; x=1742653682; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nrnnT8wDk5xdyTY1r15VVd/Pkw9n0RcLFQ1R7hR7Vgg=;
 b=DZMkZv1wZN5r0DAgBJA02/2VwPAuz5WaLCbLDv5LotlT7PPPSeGGZip1Ze9FmyxqHu
 rQ9dy92R2X5WkOw31FVi7PjApQ1e8MGQ+4e1hZXqG5PrC70xlrtPQ2n9QVRVMkfCIjTv
 GvlAXCsgF5hnj2MJ+A1n4i9LkgPM6LvBnM4Ts=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742048882; x=1742653682;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nrnnT8wDk5xdyTY1r15VVd/Pkw9n0RcLFQ1R7hR7Vgg=;
 b=pjUJstr73HsxuwRyHe9ESCeoyH5pc/XIrZEuovYLCJuaeZb302JW1tKDEguyp3Ym1g
 JBaAZ85ZE4IELXcN0RdA2KAiwnsieHAf1uPqyS80Cp9gVonycnvf1TsLnO6wdeSV4uZ4
 qOsn5yzqtfLWfP1J9OxxADIfU2SxUceDyiz1RBRkPv90K9t8Ig2t+bwAs+rDbxknfOKr
 Hydm+8MYA2/1mrajNXCGsG+Ib+cqxUMe+tfYRURnNN1mioUhDnR5uWcSnIm6oyuI1knA
 91SgtMNUFVh35QW+UvyLZI7imwHi9l7+KKVP4StH5yw89f869Jah1AxrLYJXjtfyDfNx
 y6qA==
X-Gm-Message-State: AOJu0YyokrwlWvr0vZmAHc28wAB5tHUElU+bNyiyZbzlUbR/tjaHU6t0
 Bd9/g4qTFPR+rzaL4duOV8wfYNFG3mypYAQoKJVxN6R+trJAThXid59Mzdb+a69g8JV07mOSyb6
 hIA==
X-Gm-Gg: ASbGncvi6qPc68Xa8xAUUy8QWV6KVHYEbfmvbbhC9q2FE9mx47vMj6/yKKa6bBEL5mh
 vLVdfJoHHpdGdwWwj8lgX7DwSwQmz687ruuLyEAhGDNTfG8PAa23wfAMZodOgdZ0KsEt03twNMd
 4Abo8G2Pkhgm8zrSTi/vjnGzHBJyfoa0ezowhdrtfzCAL8C0x5oAipreTj+K/hSJ9TxwWI+VG1S
 EjzaubG565Nb1S8zgSWDkZzWhlDvo72l8KwPaXZPJW2QWDbkY6WfXJzZE0AVJFcTTaIc3hPiVWd
 c6d5zL/WWsWwImdgXQZKqzBfJqkrBGZrRmWboOc1Ohr9mpeOZA4+
X-Google-Smtp-Source: AGHT+IGnNlpDpwz37CGr2sS70LIr7oIMNL4UdTSc9Idc98Q+OnA6P/5ergGuiaq+HuklMm1chhQVqw==
X-Received: by 2002:a05:600c:3203:b0:43c:f78d:82eb with SMTP id
 5b1f17b1804b1-43d2017f600mr80398315e9.15.1742048881837; 
 Sat, 15 Mar 2025 07:28:01 -0700 (PDT)
Received: from chromium.org ([169.155.233.10])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d1fe29386sm52105055e9.17.2025.03.15.07.28.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Mar 2025 07:28:01 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v5 25/46] x86: Correct msr operation on amd64
Date: Sat, 15 Mar 2025 14:25:45 +0000
Message-ID: <20250315142643.2600605-26-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250315142643.2600605-1-sjg@chromium.org>
References: <20250315142643.2600605-1-sjg@chromium.org>
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

The CONFIG option is no-longer correct since we can have SPL and PPL
with different bitness.

Fix this and sync up with Linux 6.13 in this area, since this is where
the code came from many years ago.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v3)

Changes in v3:
- Add new patch to correct msr operation on amd64

 arch/x86/include/asm/msr.h | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/msr.h b/arch/x86/include/asm/msr.h
index af5f9a11980..39dc7b33aa0 100644
--- a/arch/x86/include/asm/msr.h
+++ b/arch/x86/include/asm/msr.h
@@ -59,15 +59,14 @@ static inline unsigned long long native_read_tscp(unsigned int *aux)
  * edx:eax, while for x86_64 it doesn't mean rdx:rax or edx:eax. Instead,
  * it means rax *or* rdx.
  */
-#ifdef CONFIG_X86_64
-#define DECLARE_ARGS(val, low, high)	unsigned low, high
-#define EAX_EDX_VAL(val, low, high)	((low) | ((u64)(high) << 32))
-#define EAX_EDX_ARGS(val, low, high)	"a" (low), "d" (high)
+#if CONFIG_IS_ENABLED(X86_64)
+/* Using 64-bit values saves one instruction clearing the high half of low */
+#define DECLARE_ARGS(val, low, high)	unsigned long low, high
+#define EAX_EDX_VAL(val, low, high)	((low) | (high) << 32)
 #define EAX_EDX_RET(val, low, high)	"=a" (low), "=d" (high)
 #else
 #define DECLARE_ARGS(val, low, high)	unsigned long long val
 #define EAX_EDX_VAL(val, low, high)	(val)
-#define EAX_EDX_ARGS(val, low, high)	"A" (val)
 #define EAX_EDX_RET(val, low, high)	"=A" (val)
 #endif
 
-- 
2.43.0


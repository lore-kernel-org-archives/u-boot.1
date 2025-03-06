Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29EA7C282D1
	for <u-boot@archiver.kernel.org>; Thu,  6 Mar 2025 16:09:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F7CD81430;
	Thu,  6 Mar 2025 17:05:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="odvv8pJn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 597C181CFC; Thu,  6 Mar 2025 17:05:45 +0100 (CET)
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com
 [IPv6:2607:f8b0:4864:20::d32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E000C81C67
 for <u-boot@lists.denx.de>; Thu,  6 Mar 2025 17:05:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd32.google.com with SMTP id
 ca18e2360f4ac-85ae33109f6so59798239f.2
 for <u-boot@lists.denx.de>; Thu, 06 Mar 2025 08:05:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1741277141; x=1741881941; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nrnnT8wDk5xdyTY1r15VVd/Pkw9n0RcLFQ1R7hR7Vgg=;
 b=odvv8pJnf8PwI8gp/6XuYrO93sbDMUeBb3HeUmxV6pQpAaT9NRfgi5E4HMQoL+k0nq
 owukijVmn9hrfyeGMjTD6UgH+1GDQrKnyxCdfNsN2nNbKl7Dr66fVzu7M8cxmpZ8xSsJ
 vzD6ehZwoXVQ8FXBdnXKx00VC0Qi/SV8WsfUA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741277141; x=1741881941;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nrnnT8wDk5xdyTY1r15VVd/Pkw9n0RcLFQ1R7hR7Vgg=;
 b=uria/AAgF2pNm8AiXuxXfHrAM1wJMQjNKnKp1J2/swoqFp+V8OXkaV2Rcr3EVO9LTI
 kjyDsKUuqRUDeZVmbVp6U8CBdDxnoKi5CZV6hQR6wsM8Lc7H1EksGDjvW+374eWLoK4A
 OFvVhqsBn+/rXbMfrQb4vaFFmB1NS7p8Mq9+ZF2gCOtepow8n2aAvwdU/LyWa6+jTIQ9
 6oLVb5bJdxJm8mmfGpUQh1AerHDR0IoEHm+ImlQ277SCiG5DLLUnQcCnfJ5VLkr6nQ22
 L28yZO0VAJQFTSUKfyRafkdnq4JISGpKwru9irClgc0ib0o6qXL9pEPiZRSXVHhhXW3d
 vALg==
X-Gm-Message-State: AOJu0YyvwJP75BphIva2AtrmpkYNf9nJv2EyTB1K+9RiXBiZKZ1/ZZb5
 LnOA5ANTzxlfZyzZb6oDxz6a5qSy9HQDipa7Xv5OSrVlfZARfT4mbOmTpHHWtF4B4FqIDH1HYVQ
 =
X-Gm-Gg: ASbGnctPboI0cMQvGatXJRWZdm5mUXl0Rqwj4rniaGWCuPlWi173DPlqEBcV9gnYm15
 WHFRw/cfqc1bWUOV5Jtsm4BhZc2oSwSuOR1+0YEc/0L3A0NmvqRZ2Rfn/QhiFfWXEMnzp6emwMd
 rzdEjpTBU3wKmeBY881SDR6KzB+Js8GFz/I7kgZE2A+KlU5PCTo0eTPzQmW9NNArcaQW6Oo3Kzz
 gLruRgV//ommzojI3/7tsEkceELoCkgNkWtSSo+cgsuRlh4KK1CSredFnhr5jNesZfnuVbKjFqr
 AHn6yc0vChUnTwpB2dUp9mKW1cnBuB0KizACleAWH0j5IQ9FieQUUhTqPTH9pK0NIf9K0aCegXy
 9pw1QqQ==
X-Google-Smtp-Source: AGHT+IFngbBa1ikxjjeHB1FirrCZKkQGzAgaGC67NVVeV4iPriMflwKwARLzXMlyfZTxL8wNNq27nQ==
X-Received: by 2002:a05:6e02:927:b0:3d2:b72d:a502 with SMTP id
 e9e14a558f8ab-3d42b995fd4mr82510835ab.22.1741277141120; 
 Thu, 06 Mar 2025 08:05:41 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f213b959c1sm46759173.38.2025.03.06.08.05.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Mar 2025 08:05:39 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 25/47] x86: Correct msr operation on amd64
Date: Thu,  6 Mar 2025 09:03:52 -0700
Message-ID: <20250306160428.3041057-26-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250306160428.3041057-1-sjg@chromium.org>
References: <20250306160428.3041057-1-sjg@chromium.org>
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


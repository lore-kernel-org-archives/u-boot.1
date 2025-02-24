Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BA87C021B6
	for <u-boot@archiver.kernel.org>; Mon, 24 Feb 2025 23:10:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B99FC811C1;
	Tue, 25 Feb 2025 00:07:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Etx4/wFw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B66A081111; Tue, 25 Feb 2025 00:07:48 +0100 (CET)
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com
 [IPv6:2607:f8b0:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 015AD80F56
 for <u-boot@lists.denx.de>; Tue, 25 Feb 2025 00:07:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x130.google.com with SMTP id
 e9e14a558f8ab-3d03ac846a7so16635155ab.2
 for <u-boot@lists.denx.de>; Mon, 24 Feb 2025 15:07:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1740438464; x=1741043264; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fdRNii3pU8zvo1EaVN/Svwz1RQQS1XsdqfNHq0fCr7I=;
 b=Etx4/wFwfDg00nWdKAaB57IthC+m6Ow3zbLRucCJpfm+vwtRjLwPWfo2AVJN8gmb7m
 c8/U+zYHUEc4MLGKWspGwpTK+EsnN2k9qyl345EQ5r3DnHxFtoxXGcgEEvxQBvx7umbn
 A3orJFmPXCcl64vhyFiu+us8Zxsg1Cv2AdrjQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740438464; x=1741043264;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fdRNii3pU8zvo1EaVN/Svwz1RQQS1XsdqfNHq0fCr7I=;
 b=qlnyp3y9BlQEdQ2lMpo0a5tmI3hudh2wVt2VD4rVlW0HtXOIYW4sM59H2hEZbX5grl
 /8Fic2lqyJLjZzU1JYIk1TbCIdyCvxlGcpy81bbyU0rVNYj8L5OLcaUwJYgVvvWcwKi1
 wtGVbD5FtZ5dn6NVgwanODn7oapV7RpQq60UtKbbG1aUYaM3zs7Q2+4LYFBOc0cPRBk7
 nDAqaUNeE/viYyusMfVzo/iOwcV3DJiTSORTiTNTIobrR5bTAnwuXjVEyrj3LVyW3cwj
 93Xo+ics3PtzZ+hL5oW2ZsaXII2TGyDokjVPRPWA5/j+pNNnJ348G8W3wfW8cxasXq9z
 z4Xw==
X-Gm-Message-State: AOJu0YzpJ/vWbk75kvNXcAEwV9yChLBZqbVZXCRO7NtIRtdMg2+pcUpI
 xeY4DpAGiMjbCmCpD8uaIgp3EY33JKZ94N47/4Y5V3mZbmfmJiGBuM3anRCiIOOMW1t3IG838KA
 =
X-Gm-Gg: ASbGnctvgy6PmzjtclhHCaRM6weqs02NTVlAP+AW6morsFBZ/dwLGK8jRcYENutGCib
 p3gKSynZ+oHVMSQkh7QPuipK5YrnEQETeOzdOvDB/ivhzEGx3KYJK1/q5nTYMaLDABoYHgIsred
 KjypAfYRZrZSselVslsdCxXXFVzDphHCajeEVquQW3VF6dD0lLEZ8MWiep39zQzfoxfQLL44Xjg
 slDtFx4eM1foxM7+EJMeuqR8MHGEVaHT302dPJiB1BrSyxv+ZieFgkuYDQizgXFrtG+OpSFhD36
 ln8XHFEJZ8Fn4XXosrOmW/N5GrBz7QNF42N673UCptQOb/hjXzMComcfjplSoY8=
X-Google-Smtp-Source: AGHT+IHIo0b2OmuA+r7i4lPUM2mmNpyLvqalcjrIKKO+kzEt/rteWxNvt09JWMu+UcKEydgRXmti2g==
X-Received: by 2002:a05:6e02:3a0d:b0:3d1:863e:5536 with SMTP id
 e9e14a558f8ab-3d2cb5153a9mr166626705ab.18.1740438464161; 
 Mon, 24 Feb 2025 15:07:44 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f04752e026sm113941173.107.2025.02.24.15.07.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2025 15:07:43 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 23/44] x86: Correct msr operation on amd64
Date: Mon, 24 Feb 2025 16:06:12 -0700
Message-ID: <20250224230640.2665206-24-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250224230640.2665206-1-sjg@chromium.org>
References: <20250224230640.2665206-1-sjg@chromium.org>
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


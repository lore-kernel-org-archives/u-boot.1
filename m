Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6605C28B28
	for <u-boot@archiver.kernel.org>; Sat, 15 Mar 2025 22:19:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F7C38168B;
	Sat, 15 Mar 2025 23:18:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="If7ZzEUI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4DE5F8141E; Sat, 15 Mar 2025 23:18:31 +0100 (CET)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com
 [IPv6:2607:f8b0:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6234980F9C
 for <u-boot@lists.denx.de>; Sat, 15 Mar 2025 23:18:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cfsworks@gmail.com
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-22580c9ee0aso56293715ad.2
 for <u-boot@lists.denx.de>; Sat, 15 Mar 2025 15:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742077107; x=1742681907; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7sZ+rPwUTD7M7qhGxe4tYTRZNuXXWNygJvl6Zo+YsPA=;
 b=If7ZzEUI7On/8nShH9/sG+Ni/UdztjtTFRrM7xl3xzF5SanCXhCGwO9gZ4CF9wGC8o
 xnOh4BhC+Qv8/JFyWTM8jBbqXgC/4dW6yVgIdntOj25dk2rCMhB4CSSD4/GmiQUbcHDD
 jVI79gIqbMScOknPNBDmmJgYkpSXc0dbF/fCD2ima3pPW3JkPIhXXEk/k5Aa67iGExiU
 yHED+yKxfnUkTB7+CqVxTcEyjJIzHc73Q0AobXuGsk3ncuX9V1VFo79TU0PvKztTyO5F
 q9I+lu73g4/S3AGv3ls6xyQ3guDTHjXwm69M1xfwCpkRz8HZOaqGyCSilsaaTTeM4L4v
 HHrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742077107; x=1742681907;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7sZ+rPwUTD7M7qhGxe4tYTRZNuXXWNygJvl6Zo+YsPA=;
 b=jUjXBaL+ARGffpOuznUoipYfqgikjyGF9aXplcuMfE5zRCOxdGNIcFs+4KGzGImFcA
 +e6Sq34GVLQv3ly8071lQaeu0KEcucbPQSCrZipWauderqF1bqTw1N3Xv46rohT9OVFd
 ImUWKBBS0T58pOaQA1R1muHL97BzBq+yxLhMTeBkzoHlUWtLtNT3Pw61PBwabB/Uq1zy
 vhgTbEwA30zUoNRtZHDL5Psc4XfZ8YMXKXHE1+2ukMjP9iyXcT7N/Egon4yFb0ObgooA
 JKq615eaG4EuLJ8FgSE8+C6yYPu+Doxva6C5m8VGoM7IDC465ZP0TZR+JXppBE/tIldM
 KF6g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUAVfmxVlcOcumLChgxlSBeCsDw9nLJk9rd+w+N953lxfp8/xFkBSWWr8NpgUBwN3eKCam5QuI=@lists.denx.de
X-Gm-Message-State: AOJu0YzM+pvFcMdcu9kKTDskWgMLaLG6jvSNdnSklb+3VRqNy6uUitue
 T4YkFVo5LTWmGGXgjFb6CD9hX86Ym/0BNI+P03U/t/i77erXNW+0
X-Gm-Gg: ASbGnctRLU+Zn17Pg+4fm+tn+ikUeEDLBLi2J16YVZ6aMH9yGNoycIzQ2JGB/uM1mgi
 +6Lydf6XtYjhudGD29deYLxMV6McgpVbVoDWcXuZwbgM4TscnoO8TM2+mIIfp1VvdK6d59X16JG
 I8yf/BlFsnG6dygyIJxAOJEvqb1Wsie+4BbXPUY9kOBKBikQhfH6V+XEEJ9fOD2waZUq0RxFp+d
 1HNHW+V+/pcAc6zS9ICM48WnaKzYK+MoKHfFxBqd0OiOZTF73B0N4LqJ4ru0C+AV3UuWqxXc9b4
 xtkP6bx5qvkTw/6+qbgGZqhv0zvShlXGEyj5hDf7zWl4W/V4xWVFuxs=
X-Google-Smtp-Source: AGHT+IGh3le0NhE4kKfVimu6Js6tTN1ojyeHTSj251czUE1kNBPY1OezH3GDb9n3JfDZaMsqU0OXPA==
X-Received: by 2002:a05:6a00:14cf:b0:736:9f20:a176 with SMTP id
 d2e1a72fcca58-7372235444cmr9870523b3a.8.1742077106902; 
 Sat, 15 Mar 2025 15:18:26 -0700 (PDT)
Received: from celestia.turtle.lan ([2601:1c2:c184:dc00:f31:f69b:ca22:e094])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73711578a5csm4899380b3a.74.2025.03.15.15.18.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Mar 2025 15:18:26 -0700 (PDT)
From: Sam Edwards <cfsworks@gmail.com>
X-Google-Original-From: Sam Edwards <CFSworks@gmail.com>
To: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sumit Garg <sumit.garg@linaro.org>, Peter Robinson <pbrobinson@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>, u-boot@lists.denx.de,
 Sam Edwards <CFSworks@gmail.com>
Subject: [PATCH v2 07/15] x86: Fix call64's section flags
Date: Sat, 15 Mar 2025 15:18:05 -0700
Message-ID: <20250315221813.1265193-8-CFSworks@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250315221813.1265193-1-CFSworks@gmail.com>
References: <20250315221813.1265193-1-CFSworks@gmail.com>
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

When a section is not flagged with SHF_ALLOC, LLD's --gc-sections
algorithm fails to visit the sections that it references. As a result of
this, LLD was dropping the call64.o(.data) section, which is itself only
referenced by .text_call64.

This appears to be a bug in LLD, but the .section directive for
.text_call64 should really have the correct flags either way.

Add `"ax"` to mark the section as ALLOC ("supposed to be loaded") and
CODE ("supposed to be executed").

Fixes: 7dc82591d68e2a ("x86: Move call64 into its own section")
Signed-off-by: Sam Edwards <CFSworks@gmail.com>
---
 arch/x86/cpu/i386/call64.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/cpu/i386/call64.S b/arch/x86/cpu/i386/call64.S
index d81bcc6f8f4..424732fa3fa 100644
--- a/arch/x86/cpu/i386/call64.S
+++ b/arch/x86/cpu/i386/call64.S
@@ -10,7 +10,7 @@
 #include <asm/processor-flags.h>
 
 .code32
-.section .text_call64
+.section .text_call64, "ax"
 .globl cpu_call64
 cpu_call64:
 	/*
-- 
2.48.1


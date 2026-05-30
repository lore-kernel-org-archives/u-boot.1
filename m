Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74BF4CD5BD0
	for <u-boot@archiver.kernel.org>; Sat, 30 May 2026 18:37:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 01674846B4;
	Sat, 30 May 2026 20:37:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Q+N7fgoy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 39C0084839; Sat, 30 May 2026 20:37:01 +0200 (CEST)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A80A8846B4
 for <u-boot@lists.denx.de>; Sat, 30 May 2026 20:36:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-7e615efd7d7so6570052a34.2
 for <u-boot@lists.denx.de>; Sat, 30 May 2026 11:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1780166217; x=1780771017; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=6oj+EUGTQ09dzS/fAFc9rwbBS2dgu8o8CzU3DpzCPX8=;
 b=Q+N7fgoyetieLUvuB8pXUBxxqh9nitzCNY4ofJ0AibezxwM9PoDJZZfx43DBvie029
 8FMBsO7Yf3NtdstkXbfVXnqqv9hgS9eyIFrSuvl5b6DGFResQ6ND9RDiRWEHY0rvaRQb
 MxgDpw+ZTiljNO0yhSJfw9wR3rAaMs2s9/EB4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780166217; x=1780771017;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=6oj+EUGTQ09dzS/fAFc9rwbBS2dgu8o8CzU3DpzCPX8=;
 b=LlbOufvx6u2YELtVWLVowovFcP10FVwAiv8BFWbWIv8FZKWzfiq/haenTj4S4LcvQ6
 TPt/eYyE928bWv2cVqQGNTy5S2Ly1sUj4vNi5kC1WoVxjJfz/2SIabHh5O1VrIwbuhMu
 ZxMGMVWGD263Sjft0urIIbSXUr9b940f46XOJUKqTVHcY4E+JIsXM8Pd3e0AuXnOa87g
 MzCRiJBilhbF2fWriYmF1z7Fy8KdbASqHWJk6JhkluBbDzhZpRxWpy2b4IZFVUpia8O+
 10ulNrhjKBGlxzjIKwPSYCnREXm84j3JGCA8V5W6S9RiW3xueCyChHdrmKWXMsC/BMEL
 tf7w==
X-Gm-Message-State: AOJu0YweuX93qtCkWZ48DbA2m0mTnRO7J2RpuK+/qxZGCSDzRrJ+EfYn
 ZR7kAGNjRqR9TQI/BfN5ZLSmbcsFGvu3ugZdO7E6CZUELsYX6QAHXv+EeDCbB/Rrh2A=
X-Gm-Gg: Acq92OH2/UXvcWYPsAVnC7YXqwIJp8SFwKAWQa+bB/z0/Ai3wO3aT3EV3r7emywjtSk
 SReR4ouys6BpZmje7ASasbKxviG3DUK8idgBuuKJHXIMKb3mGZ2KK446TkTY81mtGdPEMScUQ7R
 yvAbgmZ5fBRbak6PBO99YEAuCzoWg775XkHT0ng52fahD+k5WBxs+DzXfslNOrumb9B0TGpgxqj
 UUU3TLUNn7k0WSyuquKjQnaLkcXUu2TpmaUUEvtn3cpK1iqSmubr7YEZBJFQsmLLpqaZEGd0kgh
 UYp/7AYEdSazTMm1Iun88SabuAF7ib8liJ0OYIGCh1hiCPhHdB+F9cw11FhZaCQsmLQT3cyEHDS
 0ESfXSaJnWq9xbjcNqzX00q5Ln03ojINp5zlPl1s0mBzRD6I5m4sPdmncSmr/RdeViicsaGXpS3
 xaXZN29sQfUUzH8tpEjFFilQrSxKm+nLqgBpWt56gz3nFVlc+Y2RY9OALQHIx9l9WwoKfGZb7gT
 RnYFbwfzkn/s7v10sRuKSfncSCwqM0W+V4PtO/FzTpkOpz2fxzA5bA=
X-Received: by 2002:a05:6830:3907:b0:7d9:f50f:9691 with SMTP id
 46e09a7af769-7e6a1aeb066mr3028113a34.0.1780166217414; 
 Sat, 30 May 2026 11:36:57 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-191-8-235.totalplay.net. [187.191.8.235])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e695b8f662sm4245130a34.4.2026.05.30.11.36.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 30 May 2026 11:36:57 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20260323195309.2363640-1-trini@konsulko.com>
References: <20260323195309.2363640-1-trini@konsulko.com>
Subject: Re: [PATCH] video: Correct dependencies for VIDEO_LCD_RAYDIUM_RM68200
Message-Id: <178016621691.1038765.899795790767173528.b4-ty@konsulko.com>
Date: Sat, 30 May 2026 12:36:56 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Mon, 23 Mar 2026 13:53:09 -0600, Tom Rini wrote:

> The VIDEO_LCD_RAYDIUM_RM68200 functionality can only work with BACKLIGHT
> enabled, so express this dependency in Kconfig.
> 
> 

Applied to u-boot/next, thanks!

[1/1] video: Correct dependencies for VIDEO_LCD_RAYDIUM_RM68200
      commit: ff3bece92fc5e0bdbd49e6b3e87da58fb4129a3c
-- 
Tom



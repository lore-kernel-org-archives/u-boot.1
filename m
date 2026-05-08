Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4E3ACD342F
	for <u-boot@archiver.kernel.org>; Fri,  8 May 2026 23:15:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5222A84E03;
	Sat,  9 May 2026 01:14:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="f4/mbcI2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8254A84C9E; Sat,  9 May 2026 01:14:46 +0200 (CEST)
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4176A84CF3
 for <u-boot@lists.denx.de>; Sat,  9 May 2026 01:14:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-47bdee5bfc4so1761173b6e.1
 for <u-boot@lists.denx.de>; Fri, 08 May 2026 16:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1778282081; x=1778886881; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qfeJ8vbjC3Xa+OzUSqHeik4vqpRJpnrfSpsJHWkplgg=;
 b=f4/mbcI2m4c3ea6PiX3bV89E5fKr8H86mRFaKuoeUkXpxONCmyml3XQh3DgL7nTqTk
 bYP/F91pQfoLcdng3mVDV3oDtjEflyBKY/SJaH5xwAZQ2FmZL84lOerDKHhmIffiUlET
 7CkNULkbzlt3j7tOB3ftDb5yW8b5YWBoiljV0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778282081; x=1778886881;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qfeJ8vbjC3Xa+OzUSqHeik4vqpRJpnrfSpsJHWkplgg=;
 b=AkIro2u6MjXC9DHW6UWb82HoegJ9U/f10Pxk+eM+kpKB0hzP/nT4rW09kh7/cdq4pb
 w2NkeYeifXkFHPiRPvgHMCsQEJ7PUdPcSeahh5UtSC7vwcQI3XHTeMlLBW9f3c+fHp+P
 +t1U91y9g9dMBfjT6HMKVrC3QlqtDP3s0dk8dTWlIhSbvL5xBANX5UhOx47l+TjQsmMJ
 r6+qq8PE5GkXyYlaUjjBIN1Vh1vpnTwUpI+rRmSSOfj9ZOwOtOmwYrM4IP35dbHWYMT/
 1XdUFBfgxquwNYHKwsIsnrT90MzbWabcMnPEtvgNwywLAUQTbGwta7L8C0Iw7rVdSNIl
 KXDw==
X-Gm-Message-State: AOJu0YyZdfsIRE+9GlHCjCGKt48rrxardHE0RHOM4haBCaJILWvCb1Fi
 UD3VVgxtd6YrXT4Vu1O439GMdjcyU5N9yiGU9yK3i0yu/L/CqCjiDfXph7YwFh05ob4=
X-Gm-Gg: AeBDieuAtK4i6KNNM8kczgjtGqClUafbMZMhXAtlqX7qBPyTuzZBkjw+ojVRfGgbaoc
 UD8SECkAOJmmBQh57zLaUCGW+frbYi0l78eef72qqiLVSbXojeFyrb0edtq2ZTMgoRcyTAJcLXq
 PDFKcIulvUFKZ6huqrFE4CR1UryzbALGZcjg+rAoby3DmIaf7UzK4G6MfFhSevJihSZq0SIjdKt
 5lgdIezpgBgzp1vOuU5tfu87jIaGwz1cQ8PW+p78f5396MkzmObCb0ljqAQP1Zgv7AR90UhOzZI
 Rj/BlgXvNG8peZkR4Fac9ucz+AoDKnWDhcmVjEV1gDFPkx5Bipna8fjVP7xVDDfl9BC+QNZr/0d
 m1nTGAWnKgiRxeJ+MSrwL+0kAn8hMDZh0DhXwL+5r3ervfiNs5WWIIdpQm/GOdrhVoTMwfEUcFC
 KxPp8TtCxiY8oocyDQurMvOcxGcbYgHxvz+9mQuoLS6bAjqp2MPk8gT5QmYOCwRezCqENq56XJ1
 3u1c+z/Cmf/Fw7EbtRIhRa7N7h38X2FGSImi3VJMu6AwPi2sA==
X-Received: by 2002:a05:6808:3022:b0:467:d71:7f1a with SMTP id
 5614622812f47-48061c39d5emr4692190b6e.21.1778282080894; 
 Fri, 08 May 2026 16:14:40 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e367be1168sm2005082a34.5.2026.05.08.16.14.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2026 16:14:40 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Rasmus Villemoes <ravi@prevas.dk>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260504144455.3674272-1-ravi@prevas.dk>
References: <20260504144455.3674272-1-ravi@prevas.dk>
Subject: Re: [PATCH] boot: image-fit.c: check target, not source, for
 8-byte alignment when loading FDT
Message-Id: <177828208021.1997265.17149806959979415026.b4-ty@konsulko.com>
Date: Fri, 08 May 2026 17:14:40 -0600
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

On Mon, 04 May 2026 16:44:55 +0200, Rasmus Villemoes wrote:

> A number of our boards no longer boot with v2026.04, ironically as a
> result of the effort to ensure 8-byte alignment of the dtb passed to
> the kernel and getting rid of the fdt_high=0xffffffff.
> 
> The problem exists when the FIT image does specify a (properly
> aligned) load address to use for the fdt. For example, we have
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] boot: image-fit.c: check target, not source, for 8-byte alignment when loading FDT
      commit: 55b152e6f0204e0b769f66ffd40ad02081f9bff0
-- 
Tom



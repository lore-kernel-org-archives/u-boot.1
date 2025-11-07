Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9D48CCFA05
	for <u-boot@archiver.kernel.org>; Fri,  7 Nov 2025 14:17:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 67A6E83DC7;
	Fri,  7 Nov 2025 15:17:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="VbrTI96D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E5E983D0C; Fri,  7 Nov 2025 15:17:08 +0100 (CET)
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com
 [IPv6:2001:4860:4864:20::2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E57383D90
 for <u-boot@lists.denx.de>; Fri,  7 Nov 2025 15:17:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-3e4228e0fb7so504357fac.3
 for <u-boot@lists.denx.de>; Fri, 07 Nov 2025 06:17:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1762525025; x=1763129825; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9t5oNQ9ImoiPS6nOdqm+TXPLarmWb1/KWcU88aVStpY=;
 b=VbrTI96DH1sFvodoGG0zvOcZ29PEvATNI+/Zou1sblRkEtOX37JuiormhhslcxbL2c
 irePz3sxgH/jCjSWBIJtnzt+CpcdXz/8Dng76Z8cFfvV2LFWmLXoSG8iwgFP8nDnOarQ
 vO6MEPI3x1sN82E5NEF6ZrNU8g051FzgHJgUo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762525025; x=1763129825;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9t5oNQ9ImoiPS6nOdqm+TXPLarmWb1/KWcU88aVStpY=;
 b=Hfjqxx9xLzVm9aU6hP55XH1p33ye1au0uioJKam1gCQiqxu8hP5xCF9v2sL6heR94q
 /nD6A2zmx00O4f3IEafciln/LNhesZS2AERFAUAoacVDRCQkJxGxOa9MhSpaRxQ7xBw3
 /Tpq78SEBcn5uS/A7HYNjRnAI/nOpjH6gtLsKWBM5Nf6RydMiC06C0WA6qPtE907PCkE
 lujA/eDAkXgdnuE9liHC1mge45SMLtssLajlqKJdSm5yENYtNMtBXKXGc5Zjy1lQgXM/
 nP0tyiTc2IokM12f/5M9qkHHUK024i3koxGQyW23edDGN/m3XElvtyd8aS4pUe7/r5oY
 wckg==
X-Gm-Message-State: AOJu0Yw8etS9UyFv5BpGbjky0umpri0tQq0sjuxFqy8p5mNVR8V60rdl
 9JHeo7TnOcX23wTjXFjQ6Z7N+po1dlJIMCFvPSosX3hQKfCGZJkQgB0CQmFoe2c2buVJ/Z6hprn
 pCbjrKlinBw==
X-Gm-Gg: ASbGncty78AsSLDBLDILhQAVog4Qc6Csxjl9XFHbBmjVSreM7vq6MGk0FSFMXXyBFz5
 8rlkqaiRYOfhco/pvBqLiTKHeF7BZfxMKghc3EJRdHAbk0MS2GEFZYCNmrGPvuJBBOme/7LTAH7
 z7fRc3/GDSpLZhbxY0te2yxhlyPRxfpqkcF68efZjF+B8+rFWIXiEmTNNwvnhgwStwYdONjF+tH
 lr8JPRW77i6/A1jzqUY1wwyk3B5XLHE/w8FaY+as6Y5ra49cXorcJRDXi+4q2iTSE9Sb3+5Djn3
 yjTH1nX+o7u4Y858h89fNA0yT0NudLQBr8NbjH+3yycroKkzRaxZawFP/0PDujnso95x6/BnCH1
 ll02xYsK6HkDbnjwFewsM/gbLNELcpF5iXQQIIsmX6WfwEG7xPiekrBjJv2lDfOEzOGni/3MRn3
 D33BVJR+/R610XD/HPNqfx7oezi/E7RNqpG3MaPw==
X-Google-Smtp-Source: AGHT+IGbCCRgxDsn2TxH75GbQLVSWM9YjBFAohMuBajbrNVHBkRQtMwRRIMS1w54vosBmvP3PhmU0w==
X-Received: by 2002:a05:6870:b1ca:b0:3d2:c44b:4d13 with SMTP id
 586e51a60fabf-3e41e608883mr2208748fac.32.1762525024922; 
 Fri, 07 Nov 2025 06:17:04 -0800 (PST)
Received: from [127.0.1.1] (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c6f0f0bb8dsm1479692a34.6.2025.11.07.06.17.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Nov 2025 06:17:04 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Quentin Schulz <foss+uboot@0leil.net>
Cc: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20251029-rsa-verify-with-pkey-typo-v1-1-e23f6c2bb2db@cherry.de>
References: <20251029-rsa-verify-with-pkey-typo-v1-1-e23f6c2bb2db@cherry.de>
Subject: Re: [PATCH] rsa: fix typo in $(PHASE_)RSA_VERIFY_WITH_PKEY help text
Message-Id: <176252502370.3410992.10801329190602844910.b4-ty@konsulko.com>
Date: Fri, 07 Nov 2025 08:17:03 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
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

On Wed, 29 Oct 2025 12:20:27 +0100, Quentin Schulz wrote:

> 


Applied to u-boot/master, thanks!

[1/1] rsa: fix typo in $(PHASE_)RSA_VERIFY_WITH_PKEY help text
      commit: 64ba0aa9f48cd3c2bba92c1f15a9da4c21000d2e
-- 
Tom



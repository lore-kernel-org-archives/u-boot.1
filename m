Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D183EC02194
	for <u-boot@archiver.kernel.org>; Tue,  4 Feb 2025 19:44:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 37198805DA;
	Tue,  4 Feb 2025 20:43:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Hydb+YBV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D7367805D7; Tue,  4 Feb 2025 20:43:28 +0100 (CET)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2A4828078B
 for <u-boot@lists.denx.de>; Tue,  4 Feb 2025 20:43:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-3eb87127854so1265267b6e.2
 for <u-boot@lists.denx.de>; Tue, 04 Feb 2025 11:43:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1738698205; x=1739303005; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IBUCUv8iuM5PQg0FXsSFCTMUftXvisLNI1CpOj9FR84=;
 b=Hydb+YBV87JX6sk+hTGL+ajHl7zVOFFBrQjcoJr8DaSoKwg0SENsztuuNhMAd38u99
 iTUhFWa4WxgteKcPd2o6IPuGI2Oerl6AFlZzfF6lw0NkIzhL9tT92M8O9S3NQS8DKHjI
 nXpTfR5c4JoMY5WGPTLyDUJn8GqaYkSAiXA3g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738698205; x=1739303005;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IBUCUv8iuM5PQg0FXsSFCTMUftXvisLNI1CpOj9FR84=;
 b=qIbVCKIqYsn5H5XLXOG45kIGjltaVExxh7d7EOG6o4XZbx8sjIogJ6GQRpVaPB47d1
 o5bCXOuRmVA/eeLmEhdsNJmz/D9Wgasxx/ObpwP6oUDdxb2XnO4XCSeOlY3sXlsxdzRT
 NYvo2mNetmmWOSNwUNUoIu2c+2RxZ1TEcJvNKiBfn8D70IOcLuRtk8Y01UypyoSO1VyJ
 3bhnr/GyQrJtLFYGLf7ioidm+1I9+nHuRYJfv84qGpkJ5WyMlHFAEb9n7Xe16XbBQwzW
 wGNHoo7A5U6OgmSd8RjvU1gZgk7quTdR4vpqXj0hNBScwwKhQL2Riw/DVCdJvjnPeQ7m
 zA+A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUkHolXKsy92QOr7+MTvZiXmP6xuD3+k8L269PUsLuYpKgokBgn45G20cqD2ejAJMAs5onYcps=@lists.denx.de
X-Gm-Message-State: AOJu0Yw0e9SCAsDF6hJUP3KCUeJxoaqC2/oQmxLIwEex7d0hZPBpw1UJ
 qsyMzEevo4M2Id2nHbz+s7eu0YOk3/sbX+A9DSucZG02I6JwzMuijEOzbHiGlXc=
X-Gm-Gg: ASbGncu1D3MzGFXByOHgX8WpkS8N1oOoHgVMhgAj1dx3bo1JgEl+XkgVcuXzcrIDY0f
 TiFtuQWO0QxlbeTXm113w1t65WW4SmXaN2NnpojuG6C6+nKi1sA5/LQ1IS9k+rDzVXudXtGuv9N
 fSLdE/oJeS24o1acE9txazUskz6fZDe+/Vz31bVyGQy1k42f59NSbz7+PIVO9DKstLSa4HKbv7T
 1cPc9AWcPT86aoSC5oii6nffXoyTsJyYoHIJxy5R1yqzvEFHyS/RnglVjXzulWPw/PZhzRak1jw
 Y+Qxsd9dX8rHxg==
X-Google-Smtp-Source: AGHT+IGOp9z/1uG3rFM5DnRWJEadlekS1PhFuc9/3d1Q/8qqnQXmgijFOTt9K223Favivv9kXW8+xQ==
X-Received: by 2002:a05:6808:bce:b0:3eb:3f7d:b777 with SMTP id
 5614622812f47-3f323b67bcamr16647001b6e.31.1738698204943; 
 Tue, 04 Feb 2025 11:43:24 -0800 (PST)
Received: from [127.0.1.1] ([189.177.145.20]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3f333690ba9sm3160867b6e.49.2025.02.04.11.43.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Feb 2025 11:43:24 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: 1425075683@qq.com
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 "Brunham, Kalen" <kalen.brunham@intel.com>, u-boot@lists.denx.de
In-Reply-To: <tencent_11A7276C90990D36D80B2816D36292D24705@qq.com>
References: <tencent_11A7276C90990D36D80B2816D36292D24705@qq.com>
Subject: Re: [PATCH v1] examples: fix building on arm32
Message-Id: <173869820375.637016.10831442811408410803.b4-ty@konsulko.com>
Date: Tue, 04 Feb 2025 13:43:23 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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

On Tue, 28 Jan 2025 09:13:16 +0800, 1425075683@qq.com wrote:

> Refer to the commit a3c101a61348 ("examples: fix building on arm64")
> fix for arm32. crt0.S does not even build with:
>     operating system and architecture:
>         5.15.0-130-generic x86_64
>     installed version of gcc and binutils:
>         gcc version 9.4.0 (Ubuntu 9.4.0-1ubuntu1~20.04.3)
>     GNU ld (GNU Binutils for Ubuntu) 2.34
>     used defconfig:
>         stm32h750-art-pi_defconfig
>     used commands for building:
>         export CROSS_COMPILE=arm-none-eabi- ARCH=arm
>         make stm32h750-art-pi_defconfig
>         make menuconfig # to add
>         make
>     examples/api/crt0.S: Assembler messages:
>     examples/api/crt0.S:32: Error: lo register required -- `ldr ip,=search_hint'
>     examples/api/crt0.S:33: Error: lo register required -- `str sp,[ip]'
>     examples/api/crt0.S:39: Error: lo register required -- `ldr ip,=syscall_ptr'
>     examples/api/crt0.S:40: Error: lo register required -- `ldr pc,[ip]'
>     make[2]: *** [scripts/Makefile.build:292：examples/api/crt0.o] Error 1
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom



Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23C69C369A2
	for <u-boot@archiver.kernel.org>; Fri, 11 Apr 2025 19:17:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 02F5F84246;
	Fri, 11 Apr 2025 21:16:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ivQ0MGKV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D3E084241; Fri, 11 Apr 2025 21:16:53 +0200 (CEST)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C7CC84238
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 21:16:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-3fb3f4bf97aso782086b6e.2
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 12:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1744399009; x=1745003809; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1bUjJ9QwKBoMXQFJGpClrdwnLM/P8gvO+4XT8vc44w4=;
 b=ivQ0MGKVhE8F7KQ/74nWjGYfdbHjccluC6LVWc+Sv0Sfp54Quq3aSilMCM9FAoUtz3
 JhuzgFzq2WZOHr7+bVCxxjU4+x+Dkj3P7P0y+gviVshtRDD6SoaTr1E1iwPRdsVZ//hF
 vxIGlcaDkjeapgTNZVN5HlsxBZrH9gtrrW8Lo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744399009; x=1745003809;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1bUjJ9QwKBoMXQFJGpClrdwnLM/P8gvO+4XT8vc44w4=;
 b=JtEPT58gBsYXfsxtxVMZJ/WomDX0lTxUas0LzpiIXgOcBeye8YVYQqc5UIykqAen6v
 lN46Q5ajf+071DmYYCMyZkQF76QdE+Zn+lqHygtkOM+LrDh7pLxdWsZxk4S1FUK3PbDY
 mFLqN+sxcaBfWcnkOMup9NP40OnvKfQebnw0ESkSpInpZq01ZRq0VxNdMiPyCkQTpOW/
 6i9sj9afoieuWY/pfWGDSTsB8rz099Y46wAlo3yDy3ToYGD23DlQFKNeI9yzKZTM9TdU
 OvL3HoLXbklP/8lDXwgsQbzcov9rqPJfxuyBJHZtT5WCzMuCdluoJLJ6RRKwZkdnkdbt
 muTw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXyENKoWeo6hicZGma+zfC3ZgF1fW+veWuVZzBcg64udvG8uEAN+W/2xKzR/nJt4laAagWkb5g=@lists.denx.de
X-Gm-Message-State: AOJu0YyG2FCGFw0bMjJy3uCqGD1QeKQxFPeuzzmtaqLeFN+VUEx9KLiG
 GO9Ro9YONXoERFf6NWwL7UwwMXMDxcUd0wRymvNOjRqV5H6iLMrzVs6U2lKjfIc=
X-Gm-Gg: ASbGncuYYdsL7mKCGMI795oQ/EwRnqSlNR2VUWcF2XKebbK9BID3XLKWhmMlL7hSyWd
 Kw6pAL6am84PYOPCjfwlNDasVFDEPdnE+feiUEVKeT5Bi2uKH5vcbrDRSJIDWCcC8J5osPfHz4m
 YSXqHcHUYr866LDW+eX9LhWjhXqyaPHk+qkzkXFo0B1nIENK6mNUkPb/HbZzak6Qsd+gZtxXvzR
 Ttp138Q+U7HFFb5Y/CNyKTYDxVGu+mdPAsq9dXXfyYhU5tA1SKM27luhV6yQRp9Bq/SRkMlSY0n
 vBXHtWLe1V70zd8NzT+r56yQUBPK2J/4uoiljjuUQE211uP1nxklI8opmvitRxM/GrpVikhqdbB
 j
X-Google-Smtp-Source: AGHT+IERgaW6aJr6DFEo3ESGjxEeEHNrsHKKNcKEbfUTzmSKGKkFAhJRzqf2yV/TuKumVIaXFhn1eQ==
X-Received: by 2002:a05:6808:3c43:b0:3f5:50f3:4a6b with SMTP id
 5614622812f47-4008506d689mr2715363b6e.17.1744399009147; 
 Fri, 11 Apr 2025 12:16:49 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-400762cc752sm1043970b6e.20.2025.04.11.12.16.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Apr 2025 12:16:48 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Raymond Mao <raymond.mao@linaro.org>, Simon Glass <sjg@chromium.org>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, u-boot@lists.denx.de
In-Reply-To: <20250403144753.1065007-1-heinrich.schuchardt@canonical.com>
References: <20250403144753.1065007-1-heinrich.schuchardt@canonical.com>
Subject: Re: [PATCH v2 1/1] configs: qemu-arm raise CONFIG_NR_DRAM_BANKS
Message-Id: <174439900782.3262324.6051689417556277446.b4-ty@konsulko.com>
Date: Fri, 11 Apr 2025 13:16:47 -0600
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

On Thu, 03 Apr 2025 16:47:53 +0200, Heinrich Schuchardt wrote:

> The number of memory banks in QEMU is not bounded by 1.
> 
> In this example we have two banks:
> 
>     qemu-system-aarch64 \
>     -machine virt \
>     -nographic \
>     -cpu cortex-a72 \
>     -m 8G \
>     -smp 8,sockets=2,cores=4,threads=1 \
>     -object memory-backend-ram,id=mem0,size=4G \
>     -numa node,cpus=0-3,memdev=mem0 \
>     -object memory-backend-ram,id=mem1,size=4G \
>     -numa node,cpus=4-7,memdev=mem1 \
>     -bios u-boot.bin
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] configs: qemu-arm raise CONFIG_NR_DRAM_BANKS
      commit: ba13350d49370373bda42f9823d923adbee0e764
-- 
Tom



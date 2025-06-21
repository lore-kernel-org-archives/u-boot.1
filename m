Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D10FC7115C
	for <u-boot@archiver.kernel.org>; Sat, 21 Jun 2025 01:37:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BDA3582D4A;
	Sat, 21 Jun 2025 03:37:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Ozi8w/We";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E646582D4E; Sat, 21 Jun 2025 03:37:26 +0200 (CEST)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BFD4382CF4
 for <u-boot@lists.denx.de>; Sat, 21 Jun 2025 03:37:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-40ad1f7c23bso436927b6e.2
 for <u-boot@lists.denx.de>; Fri, 20 Jun 2025 18:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1750469843; x=1751074643; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1h5kFraG9WvFGXUbRbHpEGvnZfzfcaJc7B3q4zGa6rI=;
 b=Ozi8w/WeF2IyKZO2CzF+jWjcq4T0QIfjIY+2Mcf+1Yy/WgkhIORX4O6n1HOr9oQXXK
 nF3cafB7jxOU8dfMWA/23b3rfkIAGrGYIZzvw2PyO5iZ0ae3Ap9aKxDGOil0iPh5pF1q
 pUcBWzV+5qG7QqLZuKilZiAHpV0zsGjb5g5To=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750469843; x=1751074643;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1h5kFraG9WvFGXUbRbHpEGvnZfzfcaJc7B3q4zGa6rI=;
 b=pW4u243rKx7LtKljzvDME52JQGu5meZmUm0cL0jexEn5xWo/lQ2SOBGG3e8ZkBXDQW
 ntocx+4+Rps15U5hhircnEivQdv9UFVt0t8NSdmnvafsIkP8FN+ERfqxMRooyxyU0H64
 fF3EmnvJzhV6dxZf00buKpjjuA7KHp8oYYcGGRyJU3s0kO14nCVXIBJ8gaJD7YZhl1fY
 P9ssxaZLVHdDpsplta1uS82+fsCAXxJX5ATp6/R1OFhnhLtzjJifP6bho9qJdO4R4lHE
 a1+du63PV9g3jwoNOojwOeTVMixZCbIUP4yH4JknOyxmFO/CjtgODsl1zBfFuQ4yqj08
 xbDg==
X-Gm-Message-State: AOJu0YxotbjY+wzY2AWohfJVSQCCf0K9wq/4yAZxSnoHYFLMyIkHdNzg
 VNn5jTlmHLM7g3o4d8q8J3xvwv/YyEB7+9sEmFsvck4M7wKuV6pg16RS5ngeK0GwHeD7phCYues
 2fGcRzMM=
X-Gm-Gg: ASbGncvAyCAg1gFSfnsTNbQNr27Mwye2KeKpcBziq7rlqO8HsYfhUBDNmR0mZvj5b20
 /eP5FeCM7XEA8aIfNgaTBSuOKpI5uZOKoVRMl6a3kPsvLuwU8/SwWUO/4XeBOeqrMcWnkvx6/EI
 gI4mZq5hlgZre9l1NXUtFMzxAAlnXZ9GyzLmCsqJpoHZgueBjtwgFg+gG6CGUAnLKBGLzALUdMA
 Vadm11ckNv4oAFJMPILZXpik8BilMyMk0DsW05sH2vP67uq2FAhri+cMGBe1qysXuO1fiQb+TWK
 s+nBW/EyYkrLIh79IlFAB/tPWtVTE/Pt9Tdltr4lgYjz5IKMy88fkn0r55+0V9tK+cOj8LXNTXS
 j2vmvXsqlcwfpO+v8431z8A==
X-Google-Smtp-Source: AGHT+IEOMLMcXnvmqhYGXBXJvo4TmwWHHafWynfJRF75ac5vn7pqpqCHDJaPr/ApbwvV9gKeUjnMCQ==
X-Received: by 2002:a05:6808:2122:b0:409:f8e:72a8 with SMTP id
 5614622812f47-40ac6fec161mr3489627b6e.23.1750469843449; 
 Fri, 20 Jun 2025 18:37:23 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-40ac6ceff18sm498252b6e.26.2025.06.20.18.37.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Jun 2025 18:37:22 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>
In-Reply-To: <20250609192701.20260-1-marek.vasut+renesas@mailbox.org>
References: <20250609192701.20260-1-marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH v2 0/8] Consistent Kconfig environment options
 CONFIG_ENV_ prefix
Message-Id: <175046984224.3628297.4841542212311328382.b4-ty@konsulko.com>
Date: Fri, 20 Jun 2025 19:37:22 -0600
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

On Mon, 09 Jun 2025 21:26:35 +0200, Marek Vasut wrote:

> Rename the environment related variables and add ENV_ prefix, so that
> all configuration options which are related to environment would have
> an CONFIG_ENV_ prefix. No functional change.
> 
> Marek Vasut (8):
>   env: Rename OVERWRITE_ETHADDR_ONCE to ENV_OVERWRITE_ETHADDR_ONCE
>   env: Rename SYS_REDUNDAND_ENVIRONMENT to ENV_REDUNDANT
>   env: Rename SYS_RELOC_GD_ENV_ADDR to ENV_RELOC_GD_ENV_ADDR
>   env: Rename SYS_MMC_ENV_DEV to ENV_MMC_DEVICE_INDEX
>   env: Rename SYS_MMC_ENV_PART to ENV_MMC_EMMC_HW_PARTITION
>   env: Rename ENV_MMC_PARTITION to ENV_MMC_SW_PARTITION
>   env: Rename DEFAULT_ENV_FILE to ENV_DEFAULT_ENV_TEXT_FILE
>   env: Drop DELAY_ENVIRONMENT
> 
> [...]

Applied to u-boot/next, thanks!

[1/8] env: Rename OVERWRITE_ETHADDR_ONCE to ENV_OVERWRITE_ETHADDR_ONCE
      commit: 0fd9a3480a024a39da00b502af1406418378a27e
[2/8] env: Rename SYS_REDUNDAND_ENVIRONMENT to ENV_REDUNDANT
      commit: 5fb88fa725d6d4f6d358e86613a14cde01426692
[3/8] env: Rename SYS_RELOC_GD_ENV_ADDR to ENV_RELOC_GD_ENV_ADDR
      commit: 123682c7651d187113455cb01d396825c08619c4
[4/8] env: Rename SYS_MMC_ENV_DEV to ENV_MMC_DEVICE_INDEX
      commit: 0f44d5549ed814744b95b2450fbacfa14192587d
[5/8] env: Rename SYS_MMC_ENV_PART to ENV_MMC_EMMC_HW_PARTITION
      commit: 31617b880ab7da6aade0cf3c07f0d02b42bb8f4c
[6/8] env: Rename ENV_MMC_PARTITION to ENV_MMC_SW_PARTITION
      commit: ffc4914703a2b897d51e3412703b1d4f42081b42
[7/8] env: Rename DEFAULT_ENV_FILE to ENV_DEFAULT_ENV_TEXT_FILE
      commit: fb5235239aad43c41d528b2e6c8bd6c7b390cde1
[8/8] env: Drop DELAY_ENVIRONMENT
      commit: 224224c9fa287bed428d5c507b8926357191848a
-- 
Tom



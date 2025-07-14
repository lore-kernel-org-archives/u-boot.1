Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6E7DC83F17
	for <u-boot@archiver.kernel.org>; Mon, 14 Jul 2025 21:10:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 277D782E37;
	Mon, 14 Jul 2025 23:10:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="fo8+yiYR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8223882F6F; Mon, 14 Jul 2025 23:10:51 +0200 (CEST)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E76582CEA
 for <u-boot@lists.denx.de>; Mon, 14 Jul 2025 23:10:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-73e57de73b8so130269a34.0
 for <u-boot@lists.denx.de>; Mon, 14 Jul 2025 14:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1752527448; x=1753132248; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=7K2xU1UM2xLhNWtS0HJjo7iDgQ0xn8sQo3c2pbC+kVw=;
 b=fo8+yiYRIHu5ouDc3ELPV/FdebUk+hAA0MRyxi2omRuM1n1lPnFCiPi09gN8Z/DGSm
 m7oNXp26tKST+FaA8bG655KyQuLrD3Do8HZldjvPv4XbLoylvdbtPS6ewYgI4qzLYyNC
 BcCCC20nniglvBU0sN2PW46T1LfZGYQTQcTbY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752527448; x=1753132248;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7K2xU1UM2xLhNWtS0HJjo7iDgQ0xn8sQo3c2pbC+kVw=;
 b=eNtfIaTO+ghmtvRAXlAHXxqYaj6A2wTOwzOh8/dMn9QD78xcn0Kcg+hlzunI5WlpLC
 1Wu+MEnpgPdubzdgxy8U1KsOcRkqQ14rhciJdEiv5CO8Ttd5XI1Cu+A+zgwXH4Z7QjV9
 OlTYSI2I5z+1uJOTDDdpLMeXvY7iDaOfPcpcXM8BEU37EUxC8/WcSmjzQ7W4/8X0BgqR
 IiozUCZBzAgzt3pJNE+O33cDlSf7cof3QCoawkExpAPwONqjGDZigtkre3x+6iOv3Tv9
 0MhIqqDeJu4wG8RPnObThqaJWo2M2zxPf6+KdNeCVMh/ioqxRVIONQV/jpKgDZOam+dP
 YgrA==
X-Gm-Message-State: AOJu0YxerRhf/hmpe8WGRdBAIbK/kvVxoIym1hruGAkOyYZfQ5D+pLsa
 93P7FYjZjrn8YsXSevnoUy8O6ak9P8cXrk0Ntz3wzXwEldI9esa2bhBBP5CjwRndHtYy2fvne+6
 4giFzoIo=
X-Gm-Gg: ASbGncuXqukliOJAXFvdc0Rt9kXievFcV1VSDGjORCWHxadzAOGtpMybyVIS+bxvFk+
 MtG/8/foK1HbKDWEP79Oa0hzQ39G4HNZxQvtm2kD+BxfWXBfOE+epQjcYilBijYl4Q8A2P0e2wV
 Crnm/PQlPTMU3zen0JWxiy58A6fQhEHkaSBZnZbcD5stYL8dtqIbhd0dO9l6FNd/bJSJigywFdc
 GhXaG6qVxCkGl5ARva0c1+A5B66oLW2cW3dV767DdxOW/nmGJB2GUw8o30mhZRaB/2cTOacrAnR
 b1Gkvd6YZa+WImIMPfh2dp01d+GJY83kTmfhc0Zbg7J1QoIExD76K0UCeHvrhy2Jo4L3VDX8ZbC
 ndEGCWGxHZPRfTQlywRKXAE7mtYYdw8AdzukDe/qUtDrnRebU0jeQE/s=
X-Google-Smtp-Source: AGHT+IFBTTee0ROFK6n/4xV7tG6B3ChYsohDTF3TqwY/blH88j4zM7pwKTuWVeTXXRmuxiB7iff4RA==
X-Received: by 2002:a05:6830:8107:b0:73a:d3f6:8b22 with SMTP id
 46e09a7af769-73e57733540mr576437a34.11.1752527448041; 
 Mon, 14 Jul 2025 14:10:48 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73e541c3a6fsm202668a34.57.2025.07.14.14.10.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 14:10:47 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Rasmus Villemoes <ravi@prevas.dk>
In-Reply-To: <20250707203655.613340-1-ravi@prevas.dk>
References: <20250707203655.613340-1-ravi@prevas.dk>
Subject: Re: [PATCH v2 0/3] integer limit macro consolidation
Message-Id: <175252744723.202878.14649503760799034937.b4-ty@konsulko.com>
Date: Mon, 14 Jul 2025 15:10:47 -0600
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

On Mon, 07 Jul 2025 22:36:52 +0200, Rasmus Villemoes wrote:

> I was bitten by our limit macros not being usable in #if conditionals
> when building a standalone app. It turns out that the work to fix that
> had already been started by the inclusion of the mbedtls library, so
> it's something that people do hit.
> 
> Let's finish the job by providing suitable limit macros for all three families:
> 
> [...]

Applied to u-boot/master, thanks!

[1/3] move more limits from kernel.h to limits.h and standardize their definitions
      commit: dc323f3bee318514af9d7c6fed1e01c712bc71ae
[2/3] move limits for sNN/uNN types from kernel.h to limits.h
      commit: 0604595c16a6bf3c0aed131b80d1a25d5d74057d
[3/3] limits.h: provide all limit macros for standard [u]intNN_t types
      commit: dd260d95fd26deedc64f076b554759d09420f006
-- 
Tom



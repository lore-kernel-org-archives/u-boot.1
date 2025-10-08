Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DA2ECAC5BB
	for <u-boot@archiver.kernel.org>; Wed,  8 Oct 2025 04:22:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E17D83A2D;
	Wed,  8 Oct 2025 06:22:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="trcDben4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EFE69839FB; Wed,  8 Oct 2025 06:22:11 +0200 (CEST)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE7FA8394E
 for <u-boot@lists.denx.de>; Wed,  8 Oct 2025 06:22:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-7a7b084ef77so4022236a34.2
 for <u-boot@lists.denx.de>; Tue, 07 Oct 2025 21:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1759897328; x=1760502128; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nMNB6soDkdZNZV7jzFwMlVE5CiNTkyF93/O/gGavi9s=;
 b=trcDben44Dp1luuFyi8HIhCvYBNL1L/7Jfm/LRue17kdVb0iToypgfX2xMy481jJSM
 mZ6bPhIdPERReLDwmlpxr94xQG298uKyUfcLUYZeIupTmB8e01MrHXhPp/DbmNoVRBgV
 DLb6olVZl1I+TZK79gljIrvQaimvhPN0RWtBE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759897328; x=1760502128;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nMNB6soDkdZNZV7jzFwMlVE5CiNTkyF93/O/gGavi9s=;
 b=D3uXm43VMcz/ydpVIBsBp889Biv9tVI09W5DZBvnyn39dge0P+bJX6hIxSEnpwQrlk
 5pLiUv8EWlCAmo2LiOTntZ/JbwgSOwqbsJpe33S86ns6/gcq5PCumDo+pK0RmV+NflOv
 HnmOxtEmzC2MdtSFyf2S+RUYhz+SSLkKONJVQ8A2HSTt3pq1fL9J6YC7x5pg9LLdu/HI
 ut9snfPvohcwaKhMrx9Nf5vDMd7ZVQEhRV30POGE91Yq6V3wuaPtDU5z92aDTK5Q3DW/
 E2DBngvJtLk/ooZzjcGuObQKPTucAxCaq6oeF8KzZ4sRb5ilBwYYBZCrZygy7YrL5G2Z
 z+dg==
X-Gm-Message-State: AOJu0YzZR6Udu7G4xcoqq2L/rkBGdl5lp2VmKKQHHjhkDlM2nLVYWEOw
 hcttPNGSyGDGLMX0V+uYl6SrwVXmEOLVcWdulp75D6uTwXANcKAOY19oxp5z4N6S2vU=
X-Gm-Gg: ASbGncu8odQERFwrC4+V5YKIU2B9r5dWMP9h28ZyXnQ29jtDPEodloFZAGbCIzodrKR
 UcG6B3Kx+1rvLDVF5x5eN2yPZCvERaYcQ3bTl2Fvb9Hk49ICEpXBtTCpLN5pU1fjOIx2vnB6uOB
 cdkwoLqDu6pJzSCuLuaev3shDNLlW5ivEgubCzHPOyjGRw2hQaSn8goYbKOfhOqJUfpqHwR4p3x
 3MPp2ilAv/mA7xmG0wm4UdoKOXbajwB5KDVhGS/O7pPQs7AFodfQnyGJfY9qarKDjwdWEMaJKBZ
 v+Ygf9wuQc90OsjLk8O8Sb/rmhwTFuqQoknVYgZ0x5WIzSc5kgoUXS/N2YHOC53BmwdcYX872f6
 c1ulJ2d/1qlJGiPTsvosjeZYx5l05PY8iZAdNA+4ISOc4yZ97QmDz5RXZpGXimRIHMO0CuCaZdk
 Y1m225eNKurYuBQ/yx2Jc=
X-Google-Smtp-Source: AGHT+IFoS8hAYbjliGUjG18ApH8GLYWoY4h+ORad23Q4YkM+w4I62oY+a8sPov9cq2AO/obyA9a8ug==
X-Received: by 2002:a05:6830:6a94:b0:7bf:6dca:2055 with SMTP id
 46e09a7af769-7c0df6a5533mr1138258a34.4.1759897328456; 
 Tue, 07 Oct 2025 21:22:08 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-64e1bc7f424sm3818016eaf.17.2025.10.07.21.22.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Oct 2025 21:22:07 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, briansune <briansune@gmail.com>
Cc: quentin.schulz@cherry.de
In-Reply-To: <20250923181254.830-1-briansune@gmail.com>
References: <20250913163913.395-1-briansune@gmail.com>
 <20250923181254.830-1-briansune@gmail.com>
Subject: Re: [PATCH v2] cmd/dma: implement dmareset command
Message-Id: <175989732707.1794629.12743192393543638744.b4-ty@konsulko.com>
Date: Tue, 07 Oct 2025 22:22:07 -0600
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

On Wed, 24 Sep 2025 02:12:54 +0800, briansune wrote:

> This adds a new U-Boot command 'c5_pl330_dma' for Cyclone V SoCDK
> boards. It provides access to the Reset Manager's Per2ModRst register
> to release the reset for ARM PrimeCell PL330 DMA channels. This allows
> software to initialize and use the PL330 DMA controller properly after
> reset.
> 
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] cmd/dma: implement dmareset command
      commit: 92dcb3ad5d98f494b2448a7345e1cb7eefa50278
-- 
Tom



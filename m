Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B87C7CCD183
	for <u-boot@archiver.kernel.org>; Fri, 17 Oct 2025 01:24:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C7ACC83734;
	Fri, 17 Oct 2025 03:23:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="JfvdFBxx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B3D7D83734; Fri, 17 Oct 2025 03:23:58 +0200 (CEST)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 99E498367F
 for <u-boot@lists.denx.de>; Fri, 17 Oct 2025 03:23:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-441bc60f35bso437632b6e.2
 for <u-boot@lists.denx.de>; Thu, 16 Oct 2025 18:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1760664235; x=1761269035; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PrACAVD1d8hynrdzXkPh02ccN/GY0yIbAwvsm58kxSc=;
 b=JfvdFBxxtcLPBndziArst1o1lX/dTOZmdhhGmq/V40Ny0z8rc50KvD+Apsh1lIpWgQ
 Vwl/X5zLBKmAy0Pc16cKaLR5YX32vdkrU1X0Rj+v1n67VpRPZaJ9jG5R5LomcaKoT7lW
 shMa1h9+0M7vHlIDQFEFFtSojJI8I63HAMbaE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760664235; x=1761269035;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PrACAVD1d8hynrdzXkPh02ccN/GY0yIbAwvsm58kxSc=;
 b=eAXku/eU76mlVaHvrcyIi/oOmJa1sKyS/mARd9Yl0T6M3p/w7wOUpB2sQA4M6zdfGn
 n2yJF+rM6d6ukq49+h0R5QSr3WLHsZ1Z09ABjEeOLUujzzyyb8lj/h+7uKLq8goAfe92
 WExgt+Jkj2GL5Ppidk/DhRsszHCac/kt9PVCcAzeSmCGUR0ZH6o2ib76BOOVD1rYd8YQ
 02IFxbtBIDOQTQvLpSHI1CNWU4Ao1mYGhcCm/laX7t+l4OkEIJ9mzG6xBZ/EhV5L2gBh
 zY1qrmgFN4gdB4oOe2Tjp87kAYg3zXFJ2Dr6vnUFr0dD2eTK4go5gipk1sSoIpFM97lL
 Gwow==
X-Forwarded-Encrypted: i=1;
 AJvYcCUPtOvRotlTF3jMj9eOGLwwgfn3XLc+72UO/JXOWTywDRmT+oo7DHQDU19lmr9fQa3HCT3mk98=@lists.denx.de
X-Gm-Message-State: AOJu0Yz+21ozs+O3NBO1rotCcwtMxeeR5+HdtlF1LzKrwvn/Z0Z5nxsS
 giYV1C4uI4zwpCyKUzVKnV6dpzxW+lp8rx5y+nPBKFJt2cJcyrul2JT6ZLaCOGmPNW47CjZ8teK
 NdJlYHG8=
X-Gm-Gg: ASbGnctO0h5VTpGeli8Rbq2lNoX1/AI5T+KNGyGc9L6nG3zqfU4zBITYE7pdsPhqMkr
 3/PAVeOMWfqNd6vQFN/kqWnD6NTp2jFPKPYTo74Tj6HrMqAuFB7crfCJD6tWAB6tuj9mxpHJ6hr
 t95QeWvumEnqzKLEv6B5HrLEgDIahaGkF8eK7xkeRXkUXn/2ru6kmSUt4EUSNGACcLmGTdg0BTZ
 8MpFG9WiA0NeBUDSoQ5u2yRvM8bowFVOBU/BKNHkGE79Noe23bJApZLYk+X1d2VNCajF8x9B0Px
 BY9kpJXa5kh753nR5Xj20SZ5o0KhSxBjIgJyDEECFiRcD8zjaBlcfTaFiFyl+VGBMZ1vm3OkXh9
 cZtxrdUi4v//3tdBVobZbVwYxsncbZqvZxfU6NBOzMoXRQkdAtlndCFuxtWcCDP2EqRHuKviZbV
 bNvwblZUadRkt13fLEJOqHyojIg/wNwVGzqsJekQ==
X-Google-Smtp-Source: AGHT+IGyEeqrnuYZ4kDlswpsCfh+ZIMuFq6m1nDZ3cpfJdMhwpZFLFE+BeTgWkh50MXoXkYrA5UwmA==
X-Received: by 2002:a05:6808:1b0d:b0:43f:278b:91d6 with SMTP id
 5614622812f47-443a30d0fb5mr804090b6e.36.1760664235245; 
 Thu, 16 Oct 2025 18:23:55 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-65018130f87sm5157512eaf.3.2025.10.16.18.23.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Oct 2025 18:23:54 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Bin Meng <bmeng.cn@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Debbie Horsfall <debbie.horsfall@arm.com>, 
 Andre Przywara <andre.przywara@arm.com>, 
 Emil Renner Berthing <emil.renner.berthing@canonical.com>, 
 Dmitrii Merkurev <dimorinny@google.com>, 
 Cody Schuffelen <schuffelen@google.com>, u-boot@lists.denx.de
In-Reply-To: <20251009164435.49535-1-heinrich.schuchardt@canonical.com>
References: <20251009164435.49535-1-heinrich.schuchardt@canonical.com>
Subject: Re: [PATCH 1/1] virito: blk: fix logic to determine block sizes
Message-Id: <176066423321.298873.7337553685266044210.b4-ty@konsulko.com>
Date: Thu, 16 Oct 2025 19:23:53 -0600
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

On Thu, 09 Oct 2025 18:44:35 +0200, Heinrich Schuchardt wrote:

> With commit c85b8071e7d3 ("virtio: blk: support block sizes exceeding 512
> bytes") logic was added to detect the VIRTIO_BLK_F_BLK_SIZE capability and
> to copy the block size reported by QEMU to the block device descriptor.
> 
> The logical block size can be set when invoking QEMU:
> 
>     -drive if=none,file=4096.img,format=raw,id=vda \
>     -device virtio-blk-device,drive=vda,physical_block_size=4096,logical_block_size=4096
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] virito: blk: fix logic to determine block sizes
      commit: 7e65d29b6618603a51053d5fa9f4ef585e5b8959
-- 
Tom



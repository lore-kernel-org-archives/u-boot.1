Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE7D8C369C2
	for <u-boot@archiver.kernel.org>; Wed, 23 Apr 2025 01:50:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CD0D480FF7;
	Wed, 23 Apr 2025 03:49:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="PVybND6n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A95C80F9C; Wed, 23 Apr 2025 03:49:56 +0200 (CEST)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7348B80F03
 for <u-boot@lists.denx.de>; Wed, 23 Apr 2025 03:49:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-3fbc00143d6so3850260b6e.3
 for <u-boot@lists.denx.de>; Tue, 22 Apr 2025 18:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1745372991; x=1745977791; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ESAKoscm7PAou1xSZngTJqa6lnWPtKG6vS0e+9U9RrY=;
 b=PVybND6ny8+zk5X0IK6pMUf/NcXSedIYFxLdMbqTqPTGUbdI6W3ErxCdmAVGxitiGN
 qZebt5U86hpf2rCJj708RhinYj14NWdkaQn0eE3CGHPuEesVjKbI1uXCygOdCO4H1Q57
 XkLlEB/VrAVV1qRFpalFU9x5Gnz3T0SyeZQ+E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745372991; x=1745977791;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ESAKoscm7PAou1xSZngTJqa6lnWPtKG6vS0e+9U9RrY=;
 b=oYXHmknNRyy8HJcyYdgdtBv6bLux9IQJ5EaoTi44+2Wc5oMxBvHWB0lMLCFsdGRW0Q
 /auDEixFuBnlEjSzyCwn3wL2xW3CazsCi6NNWS1mFBIPcNA4MmDOfWGIkQLzzkau3MLy
 DtPJPdv+pOyet5DLXsQaYKxKH4pC+13wqFk21Zw+A1CbySWhBYvQ+wmjGvYuOyXIGGpr
 Mf6E9C4TLO2O4Wu4pEMwn/A3LZ0mhurZVN1nfbpdgiLvUapxnkTkGYoe2/jIr1e6Du1F
 lKuD1+Cg2bDdQdEtzUKpni9d9XyGmPpXr+xYOarYrRHN/fSps1LeRaL3fMVQBx4pUGIf
 oG8Q==
X-Gm-Message-State: AOJu0YyEDy8PvaeRJ60ZDXMzqyLF6Y01n/8xusHPdW1rySf6izidA7XM
 v88WAizPIh3d1GXgTsQkcyAjp8EtMdp/EjCwfXcN44wBVqfRYYmiGBFXeh+HCGY=
X-Gm-Gg: ASbGncs5JzynEIzyP0AYRqwaLDWWxaH8zZfYxNzq/+Ppra3fcCUlyU95VyOCl8riltP
 Xedi+W536dOPpSifn8HRh+YM0OQL5jXcK7wHfs5tnOMsljRZTua90ne+4QnRFKpcEftmExCtndn
 mjhVLOb+zHkZUO25FVv9Z93yVa03WCqssMMLe8h02/ANTqRXG2Nl/R902BaZTHP/lWqiWWpRkIr
 n77F1hwp2MtW21nRmSoYMpxARd4PnwBfnm/XjJTu9oQ0gxix8aOQ25HG7LUOQVhI5ZBZcdJ9Hgn
 cpLvfhSgPelU6vrsCXY4GYQfLxzLV4O2YgnplCTm4UmAlfs5tD+2LRBMK7InZEBIDjWQLkzVjEs
 6
X-Google-Smtp-Source: AGHT+IHUHpxScIoXRutiuk3pEqFWeIWwj8ZVnYIjCJDxcC4b8aW1u8bkpIaGGYuzIG13QjCFJrKl2g==
X-Received: by 2002:a05:6808:8012:b0:3fb:a7d0:3b46 with SMTP id
 5614622812f47-401c0925f03mr8769620b6e.8.1745372991090; 
 Tue, 22 Apr 2025 18:49:51 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-401d9e94fedsm961358b6e.1.2025.04.22.18.49.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Apr 2025 18:49:50 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: Michal Simek <michal.simek@amd.com>, 
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, 
 Paul Burton <paulburton@kernel.org>, Simon Glass <sjg@chromium.org>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Sumit Garg <sumit.garg@kernel.org>
In-Reply-To: <20240517-boston-v3-0-1ea7d23f4a1d@flygoat.com>
References: <20240517-boston-v3-0-1ea7d23f4a1d@flygoat.com>
Subject: Re: [PATCH v3 00/12] MIPS: Boston: Various enhancements
Message-Id: <174537298898.3850697.14612800703368173610.b4-ty@konsulko.com>
Date: Tue, 22 Apr 2025 19:49:48 -0600
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

On Fri, 17 May 2024 19:14:48 +0100, Jiaxun Yang wrote:

> This is a huge series which promoted MIPS/Boston target into a
> usable state, with fixes to drivers and general framework issues
> I found in this process.
> 
> I also converted the target to OF_UPSTREAM.
> 
> This target is covered by QEMU, to test on QEMU:
> ```
> make boston64r6el_defconfig
> make
> qemu-system-mips64el -M boston -cpu I6500 -bios ./u-boot.bin -nographic
> ```
> 
> [...]

Applied to u-boot/master, thanks!

[01/12] pci: xilinx: Handle size of ecam region properly
        commit: cb5af7aa4f5119faf738542f6c066fa5bb352aa1
[02/12] pci: auto: Reduce bridge mem alignment boundary for boston
        commit: fc25cd0e1a1d5bea59c651782b93e70289d68c1f
[03/12] pci: Enable PCI_MAP_SYSTEM_MEMORY when ARCH_MAP_SYSMEM is not set
        commit: 1864dfb1c457e090d2e84d14ee56d9579a898e7f
[04/12] ahci: DMA addressing fixes
        commit: 8daa1fadc2c45bc954537a70942674e0a4cf85a8
[05/12] ahci: dwc_ahsata: Generalize the driver
        commit: 2b62ec62ac39723660bfeb6c0b4d336269a3adfc
[06/12] MIPS: Provide dummy acpi_table.h
        commit: 0fd4686df5fe7a7b1783eec6ff21ffdd1c2b0467
[07/12] MIPS: boston: Imply various options
        commit: 49cc0e1adceeeb8f149390e45a0aa8fa0c1e4ef4
[08/12] MIPS: boston: Provide default env vars
        commit: a6661e260c5f98b578a636a5e265690435167981
[09/12] clk: boston: Allow to get regmap from parent device
        commit: 964bb01f34741c9866917337afecab98262be562
[10/12] dts/upstream: Add Makefile for MIPS
        commit: d3730b53d9ae26bc0ec0f35d65d563f60800326d
[11/12] MIPS: boston: Migrate to OF_UPSTREAM
        commit: 4ba5026a0fb4a4a3825e250d8e76f07b5a5e4609
[12/12] mailmap: Update email for Paul Burton
        commit: baf4bdcdeda78874efa8e2e7875ab4a91f5aa502
-- 
Tom



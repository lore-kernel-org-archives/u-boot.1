Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B7DBCD5BB3
	for <u-boot@archiver.kernel.org>; Sat, 23 May 2026 00:02:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2AFA0848B9;
	Sat, 23 May 2026 02:02:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="fb0oVScy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F2C20848A2; Sat, 23 May 2026 02:02:02 +0200 (CEST)
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com
 [IPv6:2607:f8b0:4864:20::c33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 69A7C848A2
 for <u-boot@lists.denx.de>; Sat, 23 May 2026 02:01:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-69d7a8f6365so1142698eaf.1
 for <u-boot@lists.denx.de>; Fri, 22 May 2026 17:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1779494518; x=1780099318; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6b3xPAhGUCgsn6t1B5yC+dcORbFvGdbuHBjVLkvqsdM=;
 b=fb0oVScylH2GsyMHF8zYptjx7dGE2I70Nf0nSFHT6TUIfWr0yfO4B35BOqXY2BKRwq
 CvufIjRevX8OFPmB63PC2JfszYkUS59F3FoOxoD4euzm/I+7CNkZd/1yk369WcoVmqrH
 MM0V9gMTITGh61zKml2cVM+EKKCo2X/XKfAcw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779494518; x=1780099318;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6b3xPAhGUCgsn6t1B5yC+dcORbFvGdbuHBjVLkvqsdM=;
 b=kMnvKzhjr+c6W/eLNze90iDU9DFlXcTemjOqp/KNG02hoVoXkcwWNV27fuxc6OQGHf
 VNRobfBZOTgl6X0ED3F/Ehpaem/CdgO8jQ7Yz51CuBGqDtkkc/Esx9ZUdR2yQGVUyBA3
 uFY9X4eOC9fGOqtBgDyyNMi6UE1/pby+qMJFmOJvsk6tEsPf9t6b2K2n8Ms+gs1Th6nl
 wH4fTrW/4JZiwAdtbM+0Eot70pEs7icdHoUo7+GnT9tDpkFooNzfqz3GtwKDzWJVWj2C
 zUSk3w+MxDEWxODijbmaaVK95P0XYRMP7Iy6eRqjWHXsfupLRJnkfqbVew5U63ouSklm
 sOxA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+FoA2FZAnJOuINJ8rY5/cl1gowDtzgWwST8OF29L/2GrscapjCeJNtxKwMNnJ2l+vSo7nm3RE=@lists.denx.de
X-Gm-Message-State: AOJu0YzN2afab6PSiO9/+Sp0yl8OD/naQ89gNOIb7nrhLVIfFLjftyr1
 lhW61zq3H/bKfjxHJizSq5HLVFlNz2V0HPdiop8piskDVvmoF/9joD+rF5or5Uq45s0=
X-Gm-Gg: Acq92OHd+cdd65bjzwk4F7uztJICUF7Gt13f++k6TwqfKz0onm2maFzlawU8Rw2ZBLz
 Isk1he5tBdXadFZHJmk8Trk4e5yeWjbDWSEqAlNHQL+ieXvR4Ni9ROtPJ/vWO1NepbcqM0K+Czf
 /5L+uq9gy7X8VBNAZHp7SPju3KYeEvzusezxlH476Ck+8NxwzlaJxN53WPSE/4QxiwkbmVki00A
 LiNflWg1mmcHr0sLUEKIyM/wqPtbJTslUd1gYljHc6UGvW73M+3oqrVvsuOmVb0238BjBCCbFuu
 bMFacr9swZyBiwg1mlgMwVDA8SRakbWoYk28QKX/nUb1Ge1IGTzYI0/47Fx/h7RPtE4rt7cpJmV
 lLcKnTW91F4hCxniE/YQi0crYxrUfaRnLGqTwjbc4WKI/MCUwjfrR5C5+sh8awRVEXrRi3xeid4
 Y2AFcRph1cWr81fBtGDGOpFD/ZM/kHOCRQkoo0qX48HZBvR2OxGTI8dfRrjc/rfZWFk7S7zOzUh
 YZxShbkX7RX2/DK204WFRpqVIP3SUq8OecxYMSenVI9MYN0TXX68U8=
X-Received: by 2002:a05:6820:a011:b0:694:a17f:759d with SMTP id
 006d021491bc7-69d7ec42ce7mr2277193eaf.28.1779494518090; 
 Fri, 22 May 2026 17:01:58 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-191-8-235.totalplay.net. [187.191.8.235])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-69d8373a80esm1669310eaf.8.2026.05.22.17.01.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2026 17:01:57 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Daniel Palmer <daniel@thingy.jp>
Cc: visitorckw@gmail.com, angelo@kernel-space.org, bmeng.cn@gmail.com, 
 sjg@chromium.org, u-boot@lists.denx.de
In-Reply-To: <20260516074016.885146-1-daniel@thingy.jp>
References: <20260516074016.885146-1-daniel@thingy.jp>
Subject: Re: [PATCH v7 0/9] Add virtio-mmio support to m68k virt machine
Message-Id: <177949451695.2537592.6739922625339024473.b4-ty@konsulko.com>
Date: Fri, 22 May 2026 18:01:56 -0600
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

On Sat, 16 May 2026 16:39:52 +0900, Daniel Palmer wrote:

> Lets start making the m68k virt machine support useful.
> 
> First we need to fix some m68k endian issues.
> 
> Then allow virtio mmio driver instances to be created with
> platform data and fix a minor endian issue.
> 
> [...]

Applied to u-boot/next, thanks!

[1/9] sysreset: qemu virt: Use map_sysmem()
      commit: ccec4ce2ee8ae7c95a00b16da0b5dbd88615a8e2
[2/9] sysreset: qemu virt: Use __raw_writel()
      commit: 0bcd158db30aa14aa6add56060626388079c50cf
[3/9] rtc: goldfish: Use __raw_readl() and __raw_writel()
      commit: 5116fed77dee99a513f17f18be0dbf2e63363eef
[4/9] timer: goldfish: Use __raw_readl()
      commit: 75a1d7280a72d587d54b6af653234a96210f7177
[5/9] m68k: Fix writew(), writel(), readw(), readl() endianness for classic m68k
      commit: 3e2b261647a78929f494a932fad4e80e607a2fef
[6/9] virtio: mmio: Allow instantiation via platform data
      commit: 009cd5b56dbc2d0f7675e4262347a1a6b6a55cb2
[7/9] virtio: cmd: Depend on VIRTIO_BLK
      commit: b781017fb63831abac4bb6956e83595f5cb8c428
[8/9] virtio: blk: Fix converting the vendor id to a string
      commit: ddba15ab72df5a01fd483a0f4fc40f9ae4d2475c
[9/9] board: qemu: m68k: Create virtio mmio instances
      commit: 3dc2761d6347c35fe15fef64592d20946396872d
-- 
Tom



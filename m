Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 007C1C52D6F
	for <u-boot@archiver.kernel.org>; Tue, 20 Aug 2024 00:30:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 68E5288D3E;
	Tue, 20 Aug 2024 02:29:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="uTzH2gr2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DDF8F88CA8; Tue, 20 Aug 2024 02:29:48 +0200 (CEST)
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com
 [IPv6:2607:f8b0:4864:20::c29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C8BB388D3E
 for <u-boot@lists.denx.de>; Tue, 20 Aug 2024 02:29:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-5d5ed6f51cfso3312142eaf.0
 for <u-boot@lists.denx.de>; Mon, 19 Aug 2024 17:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1724113785; x=1724718585; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=dY6qkaeG2yNe2cF+zAI21bGzABYVBImyBWryUqbvQHE=;
 b=uTzH2gr2h4butZCs38jn3MWwy28K+manmFHEKTmwX0dBaf9wj6FoytjS5NJ9gJ2EXH
 VLvgz4gtHKxaG9j5kuc9gFSEYRS1XnR0Z7UVLVi+e56vV2XiHSEWTy6iRdpp8xWeFBfL
 VRWsm+xlJrs9SS/XtHJbb73GXzneChGaNLmhM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724113785; x=1724718585;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dY6qkaeG2yNe2cF+zAI21bGzABYVBImyBWryUqbvQHE=;
 b=do5sviRQrOUWfI1IUZGST+MBbXu8Ge2zaGVQkYkJjXt7dd77Q3bG/EU+qni6swHpNC
 xx61mJ/upl+s1aJcM2ARq/kj4P1mxgHPH3LotEG9yykIcPCPXEqi1Z9SX74uC9SUOT3N
 9VGhRtJo6hhuoE+/g+lD4i3OjXVg98P/U2gP8T5CkwDV9+TuemUdsyCzKx04AbxbyOa2
 s/bCQNqY00T5O5HoRxLgxr5k6X6szGENZQCsqRxgDLp9ACVM3fKVb4VIPP+Z06BSGh40
 01t4LNeBYs3eYMv9EDnco+ajULKY9pCYuVblZp3o0j5UFltIuY//mICoZQoSBAZBgYIf
 AKdA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV5rVwEDqjVkfc3gJ+Q8TaTdFW35PO+ppFt7YcFiEORrTKe04Gpng+lRmw9GxIxXeb9bUH1SyUMkDBXxTkco2vUU3yulw==
X-Gm-Message-State: AOJu0YzVPwQ2HIvVN9ag63CUPvPXrOYmDp1WHLzDZ81we3H0OjbrBRHo
 BWT0ZIfD8tW+i1+8YpmBjhfl8gD6CNOq93JeIIpiO9wCOzBo5DeYs1Ocd1td73Y=
X-Google-Smtp-Source: AGHT+IGFJWLXbZpuOcRWtc0UXcu/Fx58RmMz7m9axO6JJrJR+cwSYbs/GPRkQPB7U2WDluPHnIJXcg==
X-Received: by 2002:a05:6871:3a28:b0:269:2708:afe7 with SMTP id
 586e51a60fabf-2701c407558mr15083595fac.27.1724113785450; 
 Mon, 19 Aug 2024 17:29:45 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-236.totalplay.net.
 [189.203.97.236]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-270046a6208sm3319572fac.27.2024.08.19.17.29.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Aug 2024 17:29:45 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 u-boot@lists.denx.de, Christian Marangi <ansuelsmth@gmail.com>
In-Reply-To: <20240803084050.449-1-ansuelsmth@gmail.com>
References: <20240803084050.449-1-ansuelsmth@gmail.com>
Subject: Re: [PATCH 00/15] clk: mediatek: mt7986: clk migration for OF_UPSTREAM
Message-Id: <172411378452.165406.11643986270699905521.b4-ty@konsulko.com>
Date: Mon, 19 Aug 2024 18:29:44 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
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

On Sat, 03 Aug 2024 10:40:33 +0200, Christian Marangi wrote:

> These are all the required patches to migrate clk and correctly support
> OF_UPSTREAM. This will align the clk index to upstream to support the same
> clk implementation with downstream and upstream DTS.
> 
> Christian Marangi (15):
>   clk: mediatek: mt7986: fix wrong shift for PCIe clocks
>   clk: mediatek: mt7986: rename CB_CKSQ_40M to TOP_XTAL
>   clk: mediatek: mt7986: rename 66M_MCK to SYSAXI_D2
>   clk: mediatek: mt7986: fix wrong parent for INFRA_ADC_26M_CK
>   clk: mediatek: mt7986: drop 1/1 infracfg spurious factor
>   clk: mediatek: mt7986: add missing entry for IPCIE_PIPE_CK infra gate
>   clk: mediatek: mt7986: fix typo for infra_i2c0_ck
>   clk: mediatek: mt7986: rename TOPCKGEN factor clock to upstream naming
>   clk: mediatek: mt7986: reorder TOPCKGEN factor ID
>   clk: mediatek: mt7986: drop 1/1 spurious factor for topckgen
>   clk: mediatek: mt7986: comment out CK_TOP_A_TUNER as not used
>   clk: mediatek: mt7986: move INFRA_TRNG_CK to the bottom of the list
>   clk: mediatek: mt7986: replace infracfg ID with upstream linux
>   clk: mediatek: mt7986: convert to unified infracfg gates + muxes
>   clk: mediatek: mt7986: rename CK to CLK
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom



Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7041FC41513
	for <u-boot@archiver.kernel.org>; Fri, 12 Jul 2024 08:29:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C7D0F8871F;
	Fri, 12 Jul 2024 10:29:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TGAQN6zm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B1EDA88756; Fri, 12 Jul 2024 10:29:18 +0200 (CEST)
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com
 [IPv6:2a00:1450:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E4F0885F5
 for <u-boot@lists.denx.de>; Fri, 12 Jul 2024 10:29:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-52e96d4986bso1763071e87.3
 for <u-boot@lists.denx.de>; Fri, 12 Jul 2024 01:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720772956; x=1721377756; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:subject:to
 :from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=i3wh8+GeEOcQrNteltAOSa4vL3DZPxfuXwuGqFGU4LQ=;
 b=TGAQN6zmXEB2ZMbsoGLoqCruWCiKy8b0Fwc2Q5T9Jq1FVf3isnpZTM/3NoTYi9Ug7z
 6HDc7JBuE6UmJVLAEYf9aRm6/bvxqG6VqqIWa4qlbvJzZkKshZ5KBuDfkBOZ4RibAd/2
 mtPMRQUsWC1WaccM85MbU1g9KI8tzb8ut/AOogaliJfFUpYzd6sNiFt8ondj69h42+zv
 Be8Vc3nOKPSIwbY/aOewG9E0BImaY7he1F+5HvPS80IDUzLDTcbgR71ki62dpih4eecU
 nQ6eIT7aX2j+ozNtH4Nc5+HDamyYYSoedP2Li3OVJWKCX3Y1T4dMt2A18pOCEnPIo2fO
 lZaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720772956; x=1721377756;
 h=in-reply-to:content-disposition:mime-version:references:subject:to
 :from:date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i3wh8+GeEOcQrNteltAOSa4vL3DZPxfuXwuGqFGU4LQ=;
 b=jpq7X7Vj3lYuWcLP+ijGmWSmlRaa9BE57mLfPjQ9+FesLoGyNaXUu+SIkJW4H0Tl0c
 8ov9Wq3TNxVVOXZEBV2E2sgZ+o7IK2dtzfVVHwDU8e3T2gJm3YY7bIop/GvMmeoG5Vpz
 mxpXWFihznVdckFgC+agnv7nbv39873B48PKvJfwD7W8PaMJ174DvX/RX5wqBNhFPnn1
 UJ0eGIWkBI7alU1S5IAsI1zeN1Pdv2ij3LLcOWMZIn1X/2pTZoJ5Zr7wnROPbU1tBl2K
 feCudvKrWlavPIOt7ebuIUTum0KTqINZmtWzE11BxepFvdsVOtt3uG1zjqz2sFKC3GP7
 xs4w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXqICsW+jMrz6ANmLTnKKOnQPeyjaU1Y3DkEV0PTBBo7Q/ydgqQGvxbANUPQ/A6yJM2djgY4R49vRrKMsueWDjWqMSYlA==
X-Gm-Message-State: AOJu0YzVFxBcrC6985cHOMyrrAkp9dntgZwlQ+UAgjinb5kxObt0c+uU
 MvCditv8e3tnE4LiTGgC/MhtJB4EhfMRSwoRwGtHc4KpmsxT/c4g
X-Google-Smtp-Source: AGHT+IG20vrLQ+BrYeauveca8d6VpnabbzDzrBK+iLV4cy8TheiUthXX5+3L4lKZ7syFwtA9CJ4Fyw==
X-Received: by 2002:ac2:5102:0:b0:52e:97e1:723b with SMTP id
 2adb3069b0e04-52eb9996049mr5471679e87.28.1720772955766; 
 Fri, 12 Jul 2024 01:29:15 -0700 (PDT)
Received: from Ansuel-XPS. (93-34-90-105.ip49.fastwebnet.it. [93.34.90.105])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4279f2d74c6sm14600285e9.45.2024.07.12.01.29.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jul 2024 01:29:15 -0700 (PDT)
Message-ID: <6690e95b.050a0220.61f69.49bb@mx.google.com>
X-Google-Original-Message-ID: <ZpDi2BNNSrUbEfA2@Ansuel-XPS.>
Date: Fri, 12 Jul 2024 10:01:28 +0200
From: Christian Marangi <ansuelsmth@gmail.com>
To: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 John Crispin <john@phrozen.org>
Subject: Re: [PATCH 00/12] clk: mediatek: add OPs to support OF_UPSTREAM
References: <20240628174114.8675-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240628174114.8675-1-ansuelsmth@gmail.com>
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

On Fri, Jun 28, 2024 at 07:40:45PM +0200, Christian Marangi wrote:
> This series doesn't currently change anything and it does add all the
> additional OPs to make support of OF_UPSTREAM.
> 
> While converting the mt7681/7686/7688/7623/7622 it was notice lots of
> discrepancy between the downstream dtsi and the upstream one and the
> clock ID between downstream clock ID and upstream clock ID.
> 
> Upstream reference clock by names and clock are handled by the
> CCF (Common Clock Framework). The same can't be used here as we would
> quickly reach the max space allocated before relocation.
> 
> The current mediatek clock driver reference all the parents and clocks
> with offset from the clk ID related to the different tables.
> 
> Discrepancy between clock ID and the order in the clocks table cause
> one clock referenced for another or even crash for trying to access
> a clock at an offset that doesn't exist.
> 
> To handle this and permit use of OF_UPSTREAM, various measure and
> changes are done to the mediatek clock driver to support it.
> 
> This series have all the generic clock changes. Once this is merged,
> series for each SoC will came that will just change files in their
> dedicated clock driver. This is to prevent massive patch and to
> permit to split series, one for each SoC.
> 
> As said at the start, these changes doesn't cause regression and are
> just expansion to the current API. Current behaviour is saved in every
> possible way (aside from the first 2 patch that fixes latent bugs)
> 
> World compile tested in Azure Pipeline test
> 
> Christian Marangi (12):
>   clk: mediatek: return XTAL rate directly for gates with XTAL parent
>   clk: mediatek: return XTAL rate for infrasys get_mux_rate
>   clk: mediatek: add support for gates in clk_tree for infrasys
>   clk: mediatek: add support for gate ID at offset
>   clk: mediatek: add support for parent mux from different source
>   clk: mediatek: add support for parent mux from different source for
>     topckgen
>   clk: mediatek: add support for gate clock to reference topckgen clock
>   clk: mediatek: provide common clk init function for infrasys
>   clk: mediatek: add support for remapping clock ID
>   clk: mediatek: implement MUX_FLAGS and MUX_MIXED_FLAGS macro
>   clk: mediatek: add support for GATEs for APMIXED OPs
>   clk: mediatek: add support for APMIXED parent in infra MUX
> 
>  drivers/clk/mediatek/clk-mtk.c | 433 ++++++++++++++++++++++++---------
>  drivers/clk/mediatek/clk-mtk.h |  74 +++++-
>  2 files changed, 392 insertions(+), 115 deletions(-)
>

Any news for this? Notice the driver changes got merged. This is
currently blocking 4 more series to convert all the mediatek soc to of
upstream.

-- 
	Ansuel

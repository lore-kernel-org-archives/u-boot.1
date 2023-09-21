Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82708E70717
	for <u-boot@archiver.kernel.org>; Thu, 21 Sep 2023 11:35:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 04BE886484;
	Thu, 21 Sep 2023 13:35:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="o7HBaS7S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D96A5864C4; Thu, 21 Sep 2023 13:35:09 +0200 (CEST)
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com
 [IPv6:2607:f8b0:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BCAE18644E
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 13:35:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=ventanamicro.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mchitale@ventanamicro.com
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-690bc3f82a7so759121b3a.0
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 04:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1695296106; x=1695900906; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:user-agent:references
 :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
 :date:message-id:reply-to;
 bh=qRX1Zay/hMWVWZbVJrTHyOicO70zpO38+p1venlWesE=;
 b=o7HBaS7Sz3BAT+kHNTH9NRNJgvSO5Yx99RTX3o61BVJoCntmmIqPRqgf92vENGIUs+
 0ZUCfttrkxRyMseZGBrN3iAr/Y7K9ZA+oj5HS0R7Kv6lxpm2C1RKHKu5a6VQ/bzFFZyZ
 XMm0XSTouSt4PgCKrumVKAmaEr9tlDVL16vI4GbvW87qCQzSXDRsind46Bwklj5NGNwW
 nnY4fz/Hh+X5nCm6TZsIvlf1XLLfYshi8jgB3e56rYNEOMi5S+LfJjxUGpfjRzNV0tcW
 WXLJY6teFRe1rI3L/cN4N6v+7xIStMaE2AF/dehyzK470Bl+gteuJAuuNvlSWJMPOnOm
 bH2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695296106; x=1695900906;
 h=content-transfer-encoding:mime-version:user-agent:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qRX1Zay/hMWVWZbVJrTHyOicO70zpO38+p1venlWesE=;
 b=vT7Dl5bnxP8qMMMyttLWFjs7QPvuSFL4hdv5QaeTqlJ3HLO4mzVeh3Pud+H62D8rBL
 yJv8Rcr9xt3YpD2dmtq1IEUgkgydeLp9Uy0pXqpA+6uAb5TLGfNeGhVZO73Jy8HtyiVb
 ePMEZhbLFqaobtYhUmg3skYCy++OKPiPqwZ5t+hLhIVgOru/FtIB/TnJ45r3xn102w6J
 yvhkotz6RK/Jrx+gmZo42kt0wYP0mLT+vdtBgbI6uLcPerP5rHZ2o3fmUmm9qZ+xQRma
 ISm+b2nxekgvAka/mJslAnkENyuDQ6thYFbGxr6bPmYCj30j667o6OexQieD3Mur6yud
 cxhg==
X-Gm-Message-State: AOJu0YwnvZ3CpKrV0GTgYQgiGAYOhbrBet7qx5VXCfY8TPLJ6DNR1a6e
 HFB7ZxLC/OPt3PKm0zSg1hqQfg==
X-Google-Smtp-Source: AGHT+IEoxmJTDeP4v+66FVj5omJU6SPaQhoM+LQiB7vTanmBsVWBg57RwzLLrIfqFstzF+qE/4tfPw==
X-Received: by 2002:a05:6a20:3d87:b0:14c:76bd:10c1 with SMTP id
 s7-20020a056a203d8700b0014c76bd10c1mr5842599pzi.21.1695296105819; 
 Thu, 21 Sep 2023 04:35:05 -0700 (PDT)
Received: from ThinkPad-T490 ([2401:4900:5603:8473:c4d2:90e3:b3d0:fe96])
 by smtp.gmail.com with ESMTPSA id
 bk16-20020aa78310000000b00690fe1c928csm1187856pfb.147.2023.09.21.04.35.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Sep 2023 04:35:05 -0700 (PDT)
Message-ID: <a9b76195135665aac150760992ea662e617dcf43.camel@ventanamicro.com>
Subject: Re: [PATCH v1 1/2] part: Add a function to find ESP partition
From: mchitale@ventanamicro.com
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>, Heinrich
 Schuchardt <xypron.glpk@gmx.de>, Sean Anderson <sean.anderson@seco.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Date: Thu, 21 Sep 2023 17:05:01 +0530
In-Reply-To: <20230914162930.GB305624@bill-the-cat>
References: <20230914100821.755904-1-mchitale@ventanamicro.com>
 <20230914100821.755904-2-mchitale@ventanamicro.com>
 <20230914162930.GB305624@bill-the-cat>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
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

On Thu, 2023-09-14 at 12:29 -0400, Tom Rini wrote:
> On Thu, Sep 14, 2023 at 03:38:20PM +0530, Mayuresh Chitale wrote:
> > If a disk has an EFI system partition (ESP) then it can be used to
> > locate the boot files. Add a function to find the ESP.
> > 
> > Signed-off-by: Mayuresh Chitale <mchitale@ventanamicro.com>
> > Reviewed-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com
> > >
> > ---
> >  disk/part.c    | 16 ++++++++++++++++
> >  include/part.h | 10 ++++++++++
> >  2 files changed, 26 insertions(+)
> > 
> > diff --git a/disk/part.c b/disk/part.c
> > index 72241b7b23..2be0866671 100644
> > --- a/disk/part.c
> > +++ b/disk/part.c
> > @@ -841,3 +841,19 @@ int part_get_bootable(struct blk_desc *desc)
> >  
> >  	return 0;
> >  }
> > +
> > +int part_get_esp(struct blk_desc *desc)
> > +{
> > +	struct disk_partition info;
> > +	int p;
> > +
> > +	for (p = 1; p <= MAX_SEARCH_PARTITIONS; p++) {
> > +		int ret;
> > +
> > +		ret = part_get_info(desc, p, &info);
> > +		if (!ret && (info.bootable &
> > PART_EFI_SYSTEM_PARTITION))
> > +			return p;
> > +	}
> > +
> > +	return 0;
> > +}
> > diff --git a/include/part.h b/include/part.h
> > index db34bc6bb7..036f9fd762 100644
> > --- a/include/part.h
> > +++ b/include/part.h
> > @@ -689,6 +689,13 @@ int part_get_type_by_name(const char *name);
> >   * @return first bootable partition, or 0 if there is none
> >   */
> >  int part_get_bootable(struct blk_desc *desc);
> > +/**
> 
> Missing blank line?
> 
Ok, I will add it.


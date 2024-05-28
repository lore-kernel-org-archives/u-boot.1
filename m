Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6B21C25B7C
	for <u-boot@archiver.kernel.org>; Tue, 28 May 2024 16:48:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E93F48857C;
	Tue, 28 May 2024 18:47:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="mp+7pDdP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 77DDE87AD2; Tue, 28 May 2024 13:53:42 +0200 (CEST)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E6D587D1A
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 13:53:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-35b6467754cso269133f8f.3
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 04:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716897220; x=1717502020; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=wMCXTgSSxsxAro1/t/vLD18WwdW9nSXz2XqpecF+5/s=;
 b=mp+7pDdPdY80t8U1L8aZPGEYbPwV5BL1naF7u3Vnl16NzErfH4mDnXADQ/VB0tSZ5e
 CZimXkaokxSooEtmMuw349kIXvVlHdydA8/nrbZX2/6v++jC/CSr3b/Ab+LgwcHkXzYk
 eUjs+2KYA6zJt6p8x2WvGWoysoP3eC1pUrGkWnWg07Tv9xc/nbye1JEWSp7j9K5f5r3Q
 54BMtwGEaok/x12P2WLtE62CtdzVuu8gnxyoJxS2rbPTqNNVPCbPjWtZ2QhuRTDytONb
 j2+FxMxdawmXpVt06EAZkcYK929G+od5b6RS+WwqB8VqWcmMjFB6NK1VUjhlW3slZYhn
 3nOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716897220; x=1717502020;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wMCXTgSSxsxAro1/t/vLD18WwdW9nSXz2XqpecF+5/s=;
 b=vjuRPI9Y8SYrON/0tQBO0mjcBSXOePEzxsPmOVzoP+jx2gk126oPadHu7qKIsy1pq+
 nOKPjqsjgaZQBhbS+QTAdQH2Q3uteP+g5YsG1K9IreKrwHYyxAzUXzCv2+x69J6eUcXR
 HDZlgExTO00YhCTTBNJoET7sugmxY//Aayuxo8rqqDvh65JFp7zOLH6m5WqdOnuq17KF
 4DZJSuHIhsNghdKywvcBVQResw2zcb2Um7JHulLcvHUDyFwxLyk2HnN5BNTcIEvn4GZa
 t74TIONNqTotSDc2srrDbIeM4SF/bTpkY0qPr353pGDzUyatuws7Cd7Qn5Z5A8CwEHxC
 S39w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXWRyDcGCyGtARZ+vNwjDmIppSX3FNu1vMRQw0iDesgRW+bF5NG4zejOhR+RYyr7YVD2zzht1D9hTHvSRtQsAVzD2o5pQ==
X-Gm-Message-State: AOJu0YxLV7ngY5LN/Vf4eKUV4LLOWN5p7lvY4vGLYhuqNDaz41mUhk7r
 h7rWid6AJBIzP8XHAp6D/HGp1SqoY3z7sbbrlLAtd3MyB4Cfe760EBbxlj8qq0g=
X-Google-Smtp-Source: AGHT+IFL7gOYz32NFohnAv7s/vA/RUR9Wlda8QPjJGedhWSHDjJWlNdwnQ+P/r9JFP/gzry2OoNYvg==
X-Received: by 2002:a5d:584d:0:b0:35b:6448:a540 with SMTP id
 ffacd0b85a97d-35b6448aa06mr1014559f8f.50.1716897219825; 
 Tue, 28 May 2024 04:53:39 -0700 (PDT)
Received: from hera (ppp089210091242.access.hol.gr. [89.210.91.242])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3558889fb57sm11657807f8f.114.2024.05.28.04.53.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 May 2024 04:53:39 -0700 (PDT)
Date: Tue, 28 May 2024 14:53:34 +0300
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: Tom Rini <trini@konsulko.com>
Cc: Jerome Forissier <jerome.forissier@linaro.org>, u-boot@lists.denx.de,
 Javier Tia <javier.tia@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Marek Vasut <marex@denx.de>,
 Simon Glass <sjg@chromium.org>, Greg Malysa <greg.malysa@timesys.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Jonas Karlman <jonas@kwiboo.se>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Shengyu Qu <wiagn233@outlook.com>,
 John Keeping <jkeeping@inmusicbrands.com>,
 Jesse Taube <mr.bossman075@gmail.com>,
 Sumit Garg <sumit.garg@linaro.org>, Bryan Brattlof <bb@ti.com>,
 "Leon M. Busch-George" <leon@georgemail.eu>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Samuel Dionne-Riel <samuel@dionne-riel.com>,
 Joshua Watt <jpewhacker@gmail.com>, Sean Anderson <sean.anderson@seco.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Samuel Holland <samuel@sholland.org>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 Ion Agorria <ion@agorria.com>,
 Yanhong Wang <yanhong.wang@starfivetech.com>,
 Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, Baruch Siach <baruch@tkos.co.il>
Subject: Re: [PATCH v2 01/14] net: introduce alternative implementation as
 net-lwip/
Message-ID: <ZlXFvvs7RHPwAoui@hera>
References: <cover.1716566960.git.jerome.forissier@linaro.org>
 <923f66b4a74d9c91c6d661e96dced8e1cbcdc7e0.1716566960.git.jerome.forissier@linaro.org>
 <20240527153434.GH2568172@bill-the-cat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240527153434.GH2568172@bill-the-cat>
X-Mailman-Approved-At: Tue, 28 May 2024 18:47:36 +0200
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

On Mon, May 27, 2024 at 09:34:34AM -0600, Tom Rini wrote:
> On Fri, May 24, 2024 at 06:19:55PM +0200, Jerome Forissier wrote:
>
> > Prepare the introduction of the lwIP (lightweight IP) TCP/IP stack by
> > adding a new net-lwip/ directory and the NET_LWIP symbol. At this
> > point, enabling NET_LWIP simply disables NET. Subsequent commits will
> > introduce the lwIP code, re-work the NETDEVICE integration and port
> > some of the NET commands and features to lwIP.
> >
> > SPL_NET cannot be enabled when NET_LWIP=y. SPL_NET pulls some symbols
> > that are part of NET (such as arp_init(), arp_timeout_check(),
> > arp_receive(), net_arp_wait_packet_ip()). lwIP support in SPL may be
> > added later.
> >
> > Similarly, DFU_TFTP is not compatible with NET_LWIP because it depends
> > on net_loop(), tftp_timeout_ms, tftp_timeout_count_max. Let's add a
> > dependency on !NET_LWIP for now.
> >
> > Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> [snip]
> > diff --git a/Kconfig b/Kconfig
> > index 82df59f176e..758256ab121 100644
> > --- a/Kconfig
> > +++ b/Kconfig
> > @@ -747,6 +747,8 @@ source "env/Kconfig"
> >
> >  source "net/Kconfig"
> >
> > +source "net-lwip/Kconfig"
> > +
> >  source "drivers/Kconfig"
> >
> >  source "fs/Kconfig"
>
> I think we need to instead rework this to a choice statement instead so
> that in the end we have something like:

+ 1

> choice "Networking stack"
> config NO_NET
>   bool "No networking support"
> config NET
>   bool "Legacy U-Boot networking stack"
> config NET_LWIP
>   bool "Use lwIP for networking stack"
>
> if NET_LEGACY
> source "net/Kconfig"
> endif
>
> if NET_LWIP
> source "net-lwip/Kconfig"
> endif
>
> And then SPL_NET still depends on !NET_LWIP for now and we sort out the
> problems with different networking stacks in SPL vs full U-Boot later
> on.

That's an excellent idea tbh. We can now decouple SPL and u-boot proper
using different stacks and fix the more difficult to debug SPL issues in
time. Once we feel happy we can switch over to LWIP completely

Thanks
/Ilias
>
> --
> Tom



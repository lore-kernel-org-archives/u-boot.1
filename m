Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B330C28B20
	for <u-boot@archiver.kernel.org>; Wed,  2 Apr 2025 15:33:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9DC7E80584;
	Wed,  2 Apr 2025 17:33:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FRHCHIBb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D24C81703; Wed,  2 Apr 2025 17:33:14 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1AAF18035B
 for <u-boot@lists.denx.de>; Wed,  2 Apr 2025 17:33:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-43cf680d351so5918135e9.0
 for <u-boot@lists.denx.de>; Wed, 02 Apr 2025 08:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743607990; x=1744212790; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:subject:cc
 :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=8xbHNYR+NvP0p2gOge/GTMK6ZxuSPluX+zwJPY2TsbU=;
 b=FRHCHIBb6cN1VYMbfGzq4YD8iqtwO5KtWRoZMMNJReDfhKlL4hdPefkag8Nwhq+D4o
 j0ioglUXlK6IjpF6eBCkudikd5Hg1SFkS/eah80N8HFn5V25szJgQgYV+7HGbsJl3JsI
 XEd9o+nLXsEpobPTGtuoHHeENpHrWtkN6ZeSZ8ip+OPS1/CBE20c2Rn+Bm9sJZxE+jfE
 ckekWhfsS0+6noIjI9gUbmbYjdr/FwvSM2F3Xl/t9Q/6eEYKcQ9H2weLw0Dg4eXd/bad
 aZ2FMQILzmap91OeGGd7lX/oGGqiPkqkfGiW5dbBJsbES8efwSANhTcD2KEqfab1wm+u
 QbrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743607990; x=1744212790;
 h=in-reply-to:content-disposition:mime-version:references:subject:cc
 :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8xbHNYR+NvP0p2gOge/GTMK6ZxuSPluX+zwJPY2TsbU=;
 b=UeAkmNKcjFxB4mKpfZtYOmsYaETxEp1lFhSoEETZQof722OGrtRnR1wMIg81JZlZTE
 fU+qfcbI8VJFotPavEahwlT+WbUSdkByZjtFf1czOArQCLGWTar6oCelr0x4TO8G5eM6
 fWm5zU6xAXtnQ041mlO3svE11jgA31L2yxIDUOwj42mv/VfEO0pPT1piMxd1Ax2uINEu
 RryzMTtyN0G2zQaUskHrxB4gBwKJiZ0MnkeUoGJnrudKORz5AxKtm/E1up+QeK4Eup3D
 K40myYZ1BCH3SUdmn4q28tF/96imyAdROhx3Xg6V2TLU+d8Neaj+sjcxSv3vwV7R42uB
 tg5Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXr742LVD7khzd2N1pj4DX3E761l3qBMU/RoFU97qI3e11Y62PXhHHpgezRKuBv12HWZBW4yBU=@lists.denx.de
X-Gm-Message-State: AOJu0YyYwz1KeXIjf+3qmX7SowPODFGeu/HrXCM/axo5l+hj521wNP9b
 8AHVKftj8B1m2yzFOI5mYx0+0AxEKJTCuCKAZyXPEA0HCDalEPlr
X-Gm-Gg: ASbGncsDKYT6NiPl5ovh5TEeRS/xtKy5Chv9AdYkZL2Y1Omjgjv1uMlihNwsDazfeiw
 3SOADdoOaZlEwFjxrbGzY5Vl9KaqWsLPdRJOAuFOPGXOhQddTj94ODmy6T2h4my2HTZafUrVoE+
 y46n6D3BrPstLGnDNINE0DudoslfyF4S20RaIBStvEpQwaNK+I7oj4oHxh5C4Ao5Lp/ruF/+hVz
 xoGKqM5KJCxGJV98+y5vU4TU596FKgugwBRfI2ibSbTvXMNtz8iSdXIddLcXc6vD4dG6T6mNUZv
 nvIezmdqR99tDP3WO9mm/KX73oda8qobVAjgV1WJf2XJoPFWwlPQ1dX3OC//BIENvPe/Bf0S3ZE
 V
X-Google-Smtp-Source: AGHT+IE2ZluxSiIolIOs+K69T7cWuoP32DMcsiPAs4ekAXGkdL5TO9i/CQXIZWpYky+bVmNB6po07A==
X-Received: by 2002:a05:600c:4f01:b0:439:8878:5029 with SMTP id
 5b1f17b1804b1-43eb71557f7mr24221765e9.2.1743607990200; 
 Wed, 02 Apr 2025 08:33:10 -0700 (PDT)
Received: from Ansuel-XPS. (93-34-88-225.ip49.fastwebnet.it. [93.34.88.225])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43eb6190bb9sm24085215e9.29.2025.04.02.08.33.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Apr 2025 08:33:09 -0700 (PDT)
Message-ID: <67ed58b5.7b0a0220.72a9e.b0ce@mx.google.com>
X-Google-Original-Message-ID: <Z-1YswyqPyGhsr-V@Ansuel-XPS.>
Date: Wed, 2 Apr 2025 17:33:07 +0200
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>
Cc: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Bruce Suen <bruce_suen@163.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 02/14] net: airoha: Add Airoha Ethernet driver
References: <20250401225156.25790-1-ansuelsmth@gmail.com>
 <20250401225156.25790-3-ansuelsmth@gmail.com>
 <20250402151951.GY5495@bill-the-cat>
 <67ed5610.050a0220.1c650.ac73@mx.google.com>
 <20250402153104.GZ5495@bill-the-cat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250402153104.GZ5495@bill-the-cat>
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

On Wed, Apr 02, 2025 at 09:31:04AM -0600, Tom Rini wrote:
> On Wed, Apr 02, 2025 at 05:21:49PM +0200, Christian Marangi wrote:
> > On Wed, Apr 02, 2025 at 09:19:51AM -0600, Tom Rini wrote:
> > > On Wed, Apr 02, 2025 at 12:51:34AM +0200, Christian Marangi wrote:
> > > 
> > > > Add airoha Ethernet driver for Airoha AN7581 SoC. This is a majorly
> > > > rewritten and simplified version of the Linux airoha_eth.c driver.
> > > > 
> > > > It's has been modified to support a single RX/TX ring to reflect U-Boot
> > > > implementation with recv and send API.
> > > > 
> > > > The struct and the define are kept as similar as possible to upstream
> > > > one to not diverge too much.
> > > > 
> > > > The AN7581 SoC include an Ethernet Switch based on the Mediatek MT753x
> > > > but doesn't require any modification aside from setting the CPU port and
> > > > applying the Flood configuration hence it can be handled entirely in the
> > > > Ethernet driver.
> > > > 
> > > > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > > > ---
> > > >  drivers/net/Kconfig      |    8 +
> > > >  drivers/net/Makefile     |    1 +
> > > >  drivers/net/airoha_eth.c | 1448 ++++++++++++++++++++++++++++++++++++++
> > > >  3 files changed, 1457 insertions(+)
> > > >  create mode 100644 drivers/net/airoha_eth.c
> > > 
> > > checkpatch.pl has some macro warnings and it looks like some
> > > inconsistent spacing around '#define FOO' vs '#define<tab>FOO' ? And are
> > > all of those defines needed?
> > > 
> > 
> > No they are not all needed, I defined them for consistency with the
> > original driver. Should I drop them?
> > 
> > For the checkpatch check, also comes from the original driver.
> 
> I guess if it will make long term re-syncs easier, we can ignore them.
> But the macro thing should likely be addressed upstream too?
> 

Ehh ethernet driver are always very different compared to the upstream
version. I think I will just remove additional define not needed in v2.

-- 
	Ansuel

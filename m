Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 709B9E77188
	for <u-boot@archiver.kernel.org>; Wed, 18 Dec 2024 22:53:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E2A6C8022B;
	Wed, 18 Dec 2024 23:53:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=xs4all.nl header.i=@xs4all.nl header.b="eduTiJ/p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A793280241; Wed, 18 Dec 2024 23:53:09 +0100 (CET)
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.183])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 156CE8021D
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 23:53:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mark.kettenis@xs4all.nl
X-KPN-MessageId: e5ab892e-bd92-11ef-bc4b-005056992ed3
Received: from smtp.kpnmail.nl (unknown [10.31.155.5])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id e5ab892e-bd92-11ef-bc4b-005056992ed3;
 Wed, 18 Dec 2024 23:53:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=xs4all01;
 h=subject:to:from:message-id:date;
 bh=bNApfqqV+Mfc5sAukY7r4kpVQUhCesymImP9Um82AYs=;
 b=eduTiJ/pvkqb+Uk9SPewXkowAYieESqOLxzk0tdWCUszdBuNOpnXF/fv8rTnW369NE2nPqna1dJuX
 9gKp7ffqyjZ8X+Ey1mz1AXk/UofiWR0ZFM+pPuLnY9a35W1DvNKRla2Y36Xn4bezQtFOZaxIaVrmW3
 iR7lBuZejAwC2aLzT0dyGTdCtPYAUOueYwNuhg9ClqqEAa+nVNcshfepQXLQ9mlz6n7h1KdnN/7Xj3
 ubkKclWSFAcBP4e2E/Ab1K/TI90oCUeHUEqzOpYso1/OAPbT0mMQCZuACabsrwyjr9bwrJfZM0MrPy
 KufZsFpsErUeSHeR49vEdXJeMo3+g6w==
X-KPN-MID: 33|bVfCb0vgiX7LwzScW9b/IMCVejPv8Xu2bVxaXfmEG2Q9dCEa2jN2gbSn/MPcXjT
 Kxf0ydQT5ByZvQVhxJ6NAF/2ryJK5RYLbzLS7JJuECr8=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|Usf5hzAHZsxoeFYAL2aB7xTZuoRfmPrbnu+JNHE6wnKMdKZv2uqgePpdAJ4bCg4
 6ZhZUxyE895k69lEEiWa1SA==
X-Originating-IP: 80.61.163.207
Received: from bloch.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net
 [80.61.163.207]) by smtp.xs4all.nl (Halon) with ESMTPSA
 id d7cd8b4c-bd92-11ef-b687-00505699b758;
 Wed, 18 Dec 2024 23:53:06 +0100 (CET)
Date: Wed, 18 Dec 2024 23:53:05 +0100
Message-Id: <87zfksr4by.fsf@bloch.sibelius.xs4all.nl>
From: Mark Kettenis <mark.kettenis@xs4all.nl>
To: Frieder Schrempf <frieder.schrempf@kontron.de>
Cc: ilias.apalodimas@linaro.org, trini@konsulko.com,
 sughosh.ganu@linaro.org, sbabic@denx.de, festevam@gmail.com,
 uboot-imx@nxp.com, peng.fan@nxp.com, sjg@chromium.org,
 vitor.soares@toradex.com,
 paul.geurts@prodrive-technologies.com, marex@denx.de, u-boot@lists.denx.de
In-Reply-To: <93a5b107-63c7-4d44-a0f4-f4079935f8e8@kontron.de> (message from
 Frieder Schrempf on Wed, 18 Dec 2024 10:17:54 +0100)
Subject: Re: [PATCH] imx: Fix usable memory ranges for imx8m SOCs
References: <20241218090007.692815-1-ilias.apalodimas@linaro.org>
 <93a5b107-63c7-4d44-a0f4-f4079935f8e8@kontron.de>
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

> Date: Wed, 18 Dec 2024 10:17:54 +0100
> From: Frieder Schrempf <frieder.schrempf@kontron.de>

Hi,

> On 18.12.24 10:00 AM, Ilias Apalodimas wrote:
> > In the long run we should change all of the above and have 32b and 64b
> > platforms define ram_top identically.
> 
> Some more ideas for cleaning up the situation in the long run:
> 
> * Get rid of board_get_usable_ram_top() and fix the drivers that require
>   address space below SZ_4G.

Note that in many cases there are hardware limitations that restrict
access to memory above SZ_4G by these devices.  So the only way to
"fix" the drivers would be to add bounce buffer support to them.  That
typically isn't trivial and adds complexity, especially when dealing
with things like DMA rings.  And it will make things slower.

These boards all seem to have plenty of memory below SZ_4G, so I think
board_get_usable_ram_top() is actually a very reasonable solution for
the problem.

> * Parse the 'dma-ranges' property in the SoC node of the devicetree
>   which already tells us what address space is usable (at least for
>   i.MX8M).

We do this in OpenBSD to determine a memory range that is "DMA-safe".
It isn't entirely trivial though.  Not all boards have the relevant
'dma-ranges' property in the SoC node, and some boards have a
'dma-ranges' on nodes further down the tree that are very restrictive
and not really relevant for what U-Boot wants to do.  So you'd
probably need a Kconfig option to override this.

Cheers,

Mark

Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FDD5C4345F
	for <u-boot@archiver.kernel.org>; Sun, 14 Apr 2024 21:28:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A27387E0D;
	Sun, 14 Apr 2024 23:28:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="W41Dvw6W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C7B2087D73; Sun, 14 Apr 2024 23:28:42 +0200 (CEST)
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E51F087F00
 for <u-boot@lists.denx.de>; Sun, 14 Apr 2024 23:28:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=ideasonboard.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=laurent.pinchart@ideasonboard.com
Received: from pendragon.ideasonboard.com
 (117.145-247-81.adsl-dyn.isp.belgacom.be [81.247.145.117])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 41F39844;
 Sun, 14 Apr 2024 23:27:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1713130075;
 bh=GcBwMlgRipqbP8R6Goojlpnn+xQLK7hF5+38VKBVj2Q=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=W41Dvw6WgGdqcyyTnii+YNQFR7igD7FO6ZcphQE2WcydwAlIUkWj8oHC36t2bo0P+
 Ld7nqt1POirbtyh53vd7vJZJLHEW8BMEidyYS90X7vDmchsXnJ5AemXuSfAUTGvr9K
 rU9EFZkEHruBG/ULtjAhsRO1lOBsjUdlxB8Ba11U=
Date: Mon, 15 Apr 2024 00:28:31 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de,
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH] boot: fdt: Turn all addresses and sizes into u64
Message-ID: <20240414212831.GA17506@pendragon.ideasonboard.com>
References: <20240414183759.146925-1-marex@denx.de>
 <20240414192904.GA7117@pendragon.ideasonboard.com>
 <a881fc20-c555-40b9-9ee7-ea28c4913dda@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a881fc20-c555-40b9-9ee7-ea28c4913dda@denx.de>
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

On Sun, Apr 14, 2024 at 11:25:06PM +0200, Marek Vasut wrote:
> On 4/14/24 9:29 PM, Laurent Pinchart wrote:
> > Hi Marek,
> > 
> > Thank you for the patch.
> > 
> > On Sun, Apr 14, 2024 at 08:37:20PM +0200, Marek Vasut wrote:
> >> In case of systems where DRAM bank ends at the edge of 32bit boundary,
> >> start + size calculations would overflow. This happens on STM32MP15xx
> >> with 1 DRAM bank starting at 0xc0000000 and 1 GiB of DRAM. This is a
> >> usual 32bit system DRAM size overflow, fix it by doing all DRAM size
> >> and offset calculations using u64 types.
> > 
> > I'm not sure I like this much, as it removes a useful indication
> > regarding what the variables store.
> 
> That's what the variable name is for, not variable type.
> 
> > Wouldn't it be better if the code's
> > logic could be modified to avoid those overflows ?
> 
> I'd prefer to keep the code simple and blanket avoid the overflows for a 
> very long time, rather than play whack-a-mole with various odd corner 
> cases here.

Up to you.

> Note that this is a fix for a previous series which changed from 
> u64/ulong to phys_addr/size_t , which clearly was incorrect .
> 
> >> This also covers a case where
> >> a 32bit PAE system might be able to address up to 36bits of DRAM.
> > 
> > Shouldn't phys_addr_t be a 64-bit type on PAE systems ?
> 
> That depends on CONFIG_PHYS_64BIT , on am57xx this is not set for 
> example, so there phys_addr_t is 32bit .

The system won't be able to address more than 32 bits of memory in that
case, would it ?

-- 
Regards,

Laurent Pinchart

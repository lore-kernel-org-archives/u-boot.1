Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E8B7C4345F
	for <u-boot@archiver.kernel.org>; Tue, 16 Apr 2024 12:50:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9501E883FA;
	Tue, 16 Apr 2024 14:50:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=jookia.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=jookia.org header.i=@jookia.org header.b="q9/rP4/L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 34E178839A; Tue, 16 Apr 2024 14:50:40 +0200 (CEST)
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com
 [91.218.175.188])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 81B03883FA
 for <u-boot@lists.denx.de>; Tue, 16 Apr 2024 14:50:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=jookia.org
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=contact@jookia.org
Date: Tue, 16 Apr 2024 22:46:55 +1000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jookia.org; s=key1;
 t=1713271834;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=m/7sYDtT24fGvi1J4SJA8MhGquj2jn3weXA/SGTco1A=;
 b=q9/rP4/LtIcyL/3w0sBH+0wZLf7/41OPyVM7UybaZuzOHFoDC3nYyWE0ugX+Yycsg+UjZc
 P3qhOleWKDnK880lugsGWVYtdt+ap4iLp/N57GYP1lGkHHCgZao58lIYESyskDQlabKTsY
 Spx5sq0+3jNpIi5NTfkXlokQRYX7CXO7GwilcKEM/x28SDp4ldXxkb6mQSprCVdSYMfumi
 3yyZX+3WRghfSV2nJQhZOV43GSiKvhJ2zxc/Fbhi8JXBxV1+OwHc7vEZ4OxbuKT5X3fi3z
 u++B9wkEjsa4Utk86HrtTOSGL1a3XrRTqxytxDl3RBvReCanwuri6V6BuA8wtQ==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: John Watts <contact@jookia.org>
To: Sam Edwards <cfsworks@gmail.com>
Cc: u-boot@lists.denx.de, Andre Przywara <andre.przywara@arm.com>,
 Jagan Teki <jagan@amarulasolutions.com>, Marek Vasut <marex@denx.de>
Subject: Re: [PATCH v2 0/2] sunxi, usb: UDC/DM gadget model support
Message-ID: <Zh5zP3L_auM9xhl3@titan>
References: <20230608195631.55364-1-CFSworks@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230608195631.55364-1-CFSworks@gmail.com>
X-Migadu-Flow: FLOW_OUT
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

On Thu, Jun 08, 2023 at 01:56:29PM -0600, Sam Edwards wrote:
> Happy Thursday, U-Boot list!
> 
> Here is attempt 2 at making this USB controller driver compatible with
> DM's gadget model, following what most of the other musb variants do.
> 
> v2 removes the unwanted printfs in the probe func, per feedback from Marek.
> I received no other feedback against v1 of this patch.

Hi Sam,

I did some more testing and I believe my USB issues mentioned in the
other subthread are unrelated to this patch.

As such, here's my reviewed-by and tested-by. :)

John.

Reviewed-by: John Watts <contact@jookia.org>
Tested-by: John Watts <contact@jookia.org>

> 
> Cheers,
> Sam
> 
> Sam Edwards (2):
>   usb: musb-new: sunxi: remove unwanted printfs
>   usb: musb-new: sunxi: make compatible with UDC/DM gadget model
> 
>  drivers/usb/musb-new/sunxi.c | 52 +++++++++++++++++++++---------------
>  1 file changed, 31 insertions(+), 21 deletions(-)
> 
> -- 
> 2.39.2
> 

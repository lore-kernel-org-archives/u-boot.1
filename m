Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F89DC5AD4C
	for <u-boot@archiver.kernel.org>; Thu, 23 Nov 2023 13:04:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4324987600;
	Thu, 23 Nov 2023 14:04:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=tq-group.com header.i=@tq-group.com header.b="iA4UCcpN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 506AB8760A; Thu, 23 Nov 2023 14:04:47 +0100 (CET)
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 59419875BE
 for <u-boot@lists.denx.de>; Thu, 23 Nov 2023 14:04:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Markus.Niebel@ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
 t=1700744684; x=1732280684;
 h=message-id:subject:from:to:cc:date:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Nw6xZojMdCE43C9/HKHttiaOKJ1wSgynVhFGZ7rDJlE=;
 b=iA4UCcpNfASzwxQ3Cc3pJOw7HkNkNNbUskZwU5sDSwBJ/Yd1ucuCcAzv
 3eezeMYqgyestBW2C7oqAT+cuvE0KTrgtC5JDKZgsH3n3G8piQg0ikMNW
 yIErZmI7fV/z5s0oCCkld1GfVh2GzHj/Cc8fjEp++6n0xyoTFs2XaiVUl
 v9uawAFtLpect6eoy/oXkUKIbIbw8/R4/EsaXMg5fQPaHvj/5Yxa9chNL
 gRgaajO/MlfxcK1NJeH4964oGYujEBxSuKTb7el5QlOuTuyXqpzwvdUTj
 Igd+3y9eyEKEIXKdFaP50DLvTWM+N/6OiiceR7AGItxky/lzjzSXThQ4t A==;
X-IronPort-AV: E=Sophos;i="6.04,221,1695679200"; d="scan'208";a="34142793"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
 by mx1.tq-group.com with ESMTP; 23 Nov 2023 14:04:43 +0100
Received: from NIEBEL-W3.tq-net.de (NIEBEL-W3.tq-net.de [10.123.53.155])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 41F46280075;
 Thu, 23 Nov 2023 14:04:43 +0100 (CET)
Message-ID: <b7f6a997414bd7b37e75dc29c14c6708fad8164c.camel@ew.tq-group.com>
Subject: Re: [PATCH] tqma6: Fix DDR configuration
From: Markus Niebel <Markus.Niebel@ew.tq-group.com>
To: miquel.raynal@bootlin.com
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, 
 thomas.petazzoni@bootlin.com, alexander.stein@ew.tq-group.com, 
 u-boot@ew.tq-group.com
Date: Thu, 23 Nov 2023 14:04:43 +0100
In-Reply-To: <mailman.3902.1700255720.703.u-boot@lists.denx.de>
References: <mailman.3902.1700255720.703.u-boot@lists.denx.de>
Organization: TQ Systems GmbH
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Hello Miquel,

> Initially investigating a Linux network issue causing a lot of drop and
> poor network performances on a custom system based on a TQMA6A module
> (based on an iMX6Q), [1st link below].
> 
> I eventually correlated my observations with a contention at the NIC
> level when in concurrency with the graphics pipeline. Troubleshooting
> this in the kernel lead to disabling DMA bursts accesses made by the IPU
> in order to avoid triggering the QoS at the interconnect level, reducing
> from 50 to 10% the drop rate on eth0, [2nd link below]. The solution
> worked on my setup but not on others, which still suffered from
> abnormally high drop rates even with this "fix".
> 
> After looking a while into TQ Systems BSP I figured out a number of
> differences in recent U-Boot out-of-tree patches they had in their
> repository [3rd link]. Parsing the differences one after the other lead
> me to this final solution.
> 
> The reset pad of the DDR controller was apparently misconfigured, Bit
> 18-19 picturing the "DDR select field". The current value b11 is
> reserved. The only defined value as of version 6 of the iMX6Q manual was
> b00 "DDR3 and LPDDR2 mode". In practice no register difference has been
> spotted after changing this configuration but all issues tracked thus
> far just vanished. All previous fixes have been proven irrelevant. Just
> clearing this field solved all our network issues and the drop rate as
> measured by iperf3 felt back to 0%.
> 
> Link: 
> https://lore.kernel.org/netdev/20231012193410.3d1812cf@xps-13/
> 
> Link: 
> https://lists.freedesktop.org/archives/dri-devel/2023-October/428251.html
> 
> Link: 
> https://github.com/tq-systems/u-boot-tqmaxx/commit/15eb6abbefbf6916c28467b85485911dad3da6bc
> 
> Signed-off-by: Miquel Raynal <
> miquel.raynal@bootlin.com
> >
> ---
>  board/tq/tqma6/tqma6q.cfg | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/board/tq/tqma6/tqma6q.cfg b/board/tq/tqma6/tqma6q.cfg
> index a49489aed3f..a345c4de93d 100644
> --- a/board/tq/tqma6/tqma6q.cfg
> +++ b/board/tq/tqma6/tqma6q.cfg
> @@ -36,7 +36,7 @@ DATA 4, MX6_IOM_DRAM_SDCLK_1, 0x00008030
>  DATA 4, MX6_IOM_DRAM_CAS, 0x00008030
>  DATA 4, MX6_IOM_DRAM_RAS, 0x00008030
>  DATA 4, MX6_IOM_GRP_ADDDS, 0x00000030
> -DATA 4, MX6_IOM_DRAM_RESET, 0x000C3030
> +DATA 4, MX6_IOM_DRAM_RESET, 0x00003030

Thank you for pointing this out. Originally this error came from an
older/ancient reference manual. Sorry that we missed to bring this
upstream. We will send the changes for DCD data in the next days.

>  DATA 4, MX6_IOM_DRAM_SDCKE0, 0x00003000
>  DATA 4, MX6_IOM_DRAM_SDCKE1, 0x00000000
>  DATA 4, MX6_IOM_DRAM_SDBA2, 0x00000000
> -- 
> 2.34.1

Markus

-- 
TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht München, HRB 105018
Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
http://www.tq-group.com/


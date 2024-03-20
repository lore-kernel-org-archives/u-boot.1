Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A37FFC54E58
	for <u-boot@archiver.kernel.org>; Wed, 20 Mar 2024 21:00:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E157987CFC;
	Wed, 20 Mar 2024 22:00:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="TuNnToC1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 07C2E8723E; Wed, 20 Mar 2024 22:00:21 +0100 (CET)
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E8C958802B
 for <u-boot@lists.denx.de>; Wed, 20 Mar 2024 22:00:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=ideasonboard.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=laurent.pinchart@ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi
 [81.175.209.231])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id B5FFCBEB;
 Wed, 20 Mar 2024 21:59:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1710968390;
 bh=3E3yc1EY1Sha5j2fuXrktBnfqk7FgKWqHsI3B/dda8Q=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=TuNnToC1rpgm+frHnJmsTTdtB/AcZkc/FYnwarAoXaCcYIFoXsNw+0YKTaKNWXwyJ
 tMEpH6Iu6HmaF5OUgIcEPu03hJCEHxhem9b48LppwPulkZyz5Te2bQg9sOTZXLdRYx
 RszXN07+le7SmQTerM4Jp54h8359uc+p0ymbRrM0=
Date: Wed, 20 Mar 2024 23:00:15 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH v2 2/4] boot: fdt: Clean up env_get_bootm_size()
Message-ID: <20240320210015.GA2539@pendragon.ideasonboard.com>
References: <20240318150200.8178-1-marek.vasut+renesas@mailbox.org>
 <20240318150200.8178-2-marek.vasut+renesas@mailbox.org>
 <20240318161813.GF13682@pendragon.ideasonboard.com>
 <b13328fd-03ed-49e0-90b2-0f0697e8c415@mailbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b13328fd-03ed-49e0-90b2-0f0697e8c415@mailbox.org>
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

On Wed, Mar 20, 2024 at 09:52:34PM +0100, Marek Vasut wrote:
> On 3/18/24 5:18 PM, Laurent Pinchart wrote:
> 
> >> @@ -142,7 +140,7 @@ phys_size_t env_get_bootm_size(void)
> >>   
> >>   	s = env_get("bootm_low");
> >>   	if (s)
> >> -		tmp = (phys_size_t)simple_strtoull(s, NULL, 16);
> >> +		tmp = simple_strtoull(s, NULL, 16);
> >>   	else
> >>   		tmp = start;
> >>   
> > 
> > Maybe you could even drop the tmp variable completely by writing this
> > 
> > 	if (s)
> > 		size -= simple_strtoull(s, NULL, 16) - start;
> > 
> > 	return size;
> > 
> > I've never liked variables named tmp :-)
> 
> No, let's not do this. With this FDT part, the code should be verbose 
> and as easy to understand at first glance as possible, no subtraction 
> assignments and other shenanigans please.

How about this ?

	s = env_get("bootm_low");
	if (s) {
		phys_addr_t low_addr = simple_strtoull(s, NULL, 16);
                size -= low_addr - start;
	}

	return size;

If you're going for readability, that's clearer than

	return size - (tmp - start);

and it also interestingly points out that tmp/low_addr should be a
phys_addr_t, not a phys_size_t.

-- 
Regards,

Laurent Pinchart

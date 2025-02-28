Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAAB6C19F32
	for <u-boot@archiver.kernel.org>; Fri, 28 Feb 2025 03:40:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C109F807D7;
	Fri, 28 Feb 2025 04:40:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="wHENZB7U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA9418083E; Fri, 28 Feb 2025 04:40:10 +0100 (CET)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F16DC801FB
 for <u-boot@lists.denx.de>; Fri, 28 Feb 2025 04:40:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 51S3e5e82540279
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 27 Feb 2025 21:40:05 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1740714005;
 bh=/cyuo0TZYb3rGkH1MagK5d3G0o2O9TSYzl0yccl2Okk=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=wHENZB7ULjvQKCtEYJ0D/xccQoAMgRRP4cq4gf2Id1Wdf28fP0C22ZK2Dx0POrNS3
 Kh8W/I6kyG7Be14uicU8tlpGuTzTXXrX0IM7gyRi8hxLTm7Exq9NBys8VmWkrSwrj4
 2OQscoZnGWbkj4EYsA/ooQvc9ND8x/n9XlLYk05Q=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 51S3e5RX018274
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 27 Feb 2025 21:40:05 -0600
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 27
 Feb 2025 21:40:05 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 27 Feb 2025 21:40:05 -0600
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51S3e52K028958;
 Thu, 27 Feb 2025 21:40:05 -0600
Date: Thu, 27 Feb 2025 21:40:05 -0600
From: Bryan Brattlof <bb@ti.com>
To: Andrew Davis <afd@ti.com>
CC: Tom Rini <trini@konsulko.com>, <u-boot@lists.denx.de>
Subject: Re: [PATCH] mach-k3: common_fdt: create a reserved memory node
Message-ID: <20250228034005.bu6qxqn2sfnplxd5@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20250227-reserved-memory-v1-1-638a6328884c@ti.com>
 <de56be1f-bb18-45a8-b837-e10e520bb093@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <de56be1f-bb18-45a8-b837-e10e520bb093@ti.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

On February 27, 2025 thus sayeth Andrew Davis:
> On 2/27/25 11:14 AM, Bryan Brattlof wrote:
> > Some device trees may not have a reserved-memory node. Rather than
> > exiting early we should create a new reserved-memory node along with
> > the memory carveout for the firmware we (U-Boot) have placed.
> > 
> > Signed-off-by: Bryan Brattlof <bb@ti.com>
> > ---
> >   arch/arm/mach-k3/common_fdt.c | 7 +++----
> >   1 file changed, 3 insertions(+), 4 deletions(-)
> > 
> > diff --git a/arch/arm/mach-k3/common_fdt.c b/arch/arm/mach-k3/common_fdt.c
> > index 4a01671156687..361b0c0b31b09 100644
> > --- a/arch/arm/mach-k3/common_fdt.c
> > +++ b/arch/arm/mach-k3/common_fdt.c
> > @@ -122,10 +122,8 @@ int fdt_fixup_reserved(void *blob, const char *name,
> >   	/* Find reserved-memory */
> >   	nodeoffset = fdt_subnode_offset(blob, 0, "reserved-memory");
> > -	if (nodeoffset < 0) {
> > -		debug("Could not find reserved-memory node\n");
> > -		return 0;
> > -	}
> > +	if (nodeoffset < 0)
> 
> We could also reverse this check and put the node deleting logic
> below inside this block. Same effect but removes the need for
> a goto for flow control here (goto considered harmful etc..)
> 
> if (nodeoffset >= 0) {
>     /* Find existing matching subnode and remove it */
>     ...
> }
> 
> Might make the intention a bit much, so either way is fine with me,
> 

Ha it's funny you mentioned this. I had a previous version where I did 
just that but wasn't sure how people felt about adding another tab to 
such a large section. Then started looking at adding a fdt_* function
before landing on seeing what people thought about a goto label.

I guess I should take votes :)

~Bryan

> Acked-by: Andrew Davis <afd@ti.com>
> 
> > +		goto add_carveout;
> >   	/* Find existing matching subnode and remove it */
> >   	fdt_for_each_subnode(subnode, blob, nodeoffset) {
> > @@ -154,6 +152,7 @@ int fdt_fixup_reserved(void *blob, const char *name,
> >   		}
> >   	}
> > +add_carveout:
> >   	struct fdt_memory carveout = {
> >   		.start = new_address,
> >   		.end = new_address + new_size - 1,
> > 
> > ---
> > base-commit: b78f8677cde8b1dde31b66f5b780f2e9b62fba7f
> > change-id: 20250227-reserved-memory-85f5d409e6a7
> > 
> > Best regards,

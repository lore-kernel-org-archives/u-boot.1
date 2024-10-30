Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92813D7497F
	for <u-boot@archiver.kernel.org>; Wed, 30 Oct 2024 08:28:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA8CF891DD;
	Wed, 30 Oct 2024 09:28:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="pSCm8qBd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 31866891EB; Wed, 30 Oct 2024 09:28:52 +0100 (CET)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 088398904C
 for <u-boot@lists.denx.de>; Wed, 30 Oct 2024 09:28:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 49U8SlZU090466;
 Wed, 30 Oct 2024 03:28:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1730276927;
 bh=ha9lwwtiAJKNuVha4tjRfu73tyHIcyKotu1Wvx/Foeo=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=pSCm8qBdn7W6p4e9akWfm3KmKs4K+vSKDscSN6UCS/MqUqrv5Zpauight16Jlrc1I
 DI/bBFM15HXl2/jnFxgJcLRUAM+siwlPglUNFto6fpAsopK2BiQf5LVf4JjHzOW/yn
 cu8mwx6cfWPufi28MwINMqaiobTV44Vxkbv3eeAc=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 49U8SlOa101628
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 30 Oct 2024 03:28:47 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 30
 Oct 2024 03:28:46 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 30 Oct 2024 03:28:46 -0500
Received: from localhost (uda0497581.dhcp.ti.com [10.24.68.185])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49U8Sjqs088358;
 Wed, 30 Oct 2024 03:28:46 -0500
Date: Wed, 30 Oct 2024 13:58:45 +0530
From: Manorit Chawdhry <m-chawdhry@ti.com>
To: Aniket Limaye <a-limaye@ti.com>, Neha Malcom Francis <n-francis@ti.com>
CC: <u-boot@lists.denx.de>, <trini@konsulko.com>, <u-kumar1@ti.com>,
 <reidt@ti.com>, <nm@ti.com>
Subject: Re: [PATCH v2 4/5] arm: mach-k3: j721e-init.c: J7200: Add support
 for CONFIG_K3_OPP_LOW
Message-ID: <20241030082845.7gmdwicixpjoh7zi@uda0497581>
References: <20241023130033.1826413-1-a-limaye@ti.com>
 <20241023130033.1826413-5-a-limaye@ti.com>
 <20241029101025.n6xioxbqqwhpbbmz@uda0497581>
 <20241030080100.em6zd5xfhu64xsdp@uda0497581>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241030080100.em6zd5xfhu64xsdp@uda0497581>
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

Hi Neha, Aniket,

On 13:31-20241030, Manorit Chawdhry wrote:
> Hi Aniket,
> 
> On 15:40-20241029, Manorit Chawdhry wrote:
> > Hi Aniket,
> > 
> > On 18:27-20241023, Aniket Limaye wrote:
> > > From: Reid Tonking <reidt@ti.com>
> > > 
> > > The default j7200 devicetree and k3_avs driver set 2GHz/1GHz frequency
> > > for A72/MSMC clks and the OPP_NOM voltage.
> > > 
> > > J7200 SOCs may support OPP_LOW Operating Performance Point:
> > > 1GHz/500MHz clks for A72/MSMC and OPP_LOW AVS voltage read from efuse.
> > > 
> > > Hence, add a config check to select OPP_LOW specs:
> > > - Check if OPP_LOW AVS voltage read from efuse is valid.
> > > - Update the clock frequencies in devicetree.
> > > - Program the OPP_LOW AVS voltage for VDD_CPU.
> > > 
> > > Signed-off-by: Reid Tonking <reidt@ti.com>
> > > Signed-off-by: Aniket Limaye <a-limaye@ti.com>
> > > 
> > > ---
[...]
> > >  
> > > +int fix_freq(const void *fdt)
> 
> I think this can be static as well btw, maybe rename it to something
> more descriptive as well. fdt_fixup_a72_clock_frequency?

Do you think ft_system_setup is a good place for doing this fixup btw?
Was wondering that it would be good to know what all DT fixups are being
done at some common place instead of multiple scattered places but not
sure when does ft_system_setup kick in, would it be before we startup
a72?

Regards,
Manorit

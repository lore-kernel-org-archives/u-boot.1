Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1362CEB8FAD
	for <u-boot@archiver.kernel.org>; Wed,  6 Sep 2023 05:02:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 025708654A;
	Wed,  6 Sep 2023 07:02:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="BagxtQC/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E2058654A; Wed,  6 Sep 2023 07:02:40 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1DCB18666B
 for <u-boot@lists.denx.de>; Wed,  6 Sep 2023 07:02:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38652Yj5017794;
 Wed, 6 Sep 2023 00:02:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1693976554;
 bh=6Wr7p05xr+PXuwwTbnbYDHxzHB7Am+/twEu6SibFnuQ=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=BagxtQC/kk3Rs/BHonz+STgFAqHoJP1e/Ya+imW5/JM7M6L+VasxAMbomSuOgjJYn
 tCVy6fehTcjoNP4R/B68VbeXcTvJsS3dvv6WMYg1a4Vn0PGx5r94EWrUiga7hbqYD1
 1IHV9fKfG3/CnLiqrcPs30lMK0vj7CMhR4/EPXWo=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38652YOo010701
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 6 Sep 2023 00:02:34 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 6
 Sep 2023 00:02:34 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 6 Sep 2023 00:02:34 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38652Wfb020305;
 Wed, 6 Sep 2023 00:02:33 -0500
Date: Wed, 6 Sep 2023 10:32:31 +0530
From: Manorit Chawdhry <m-chawdhry@ti.com>
To: Neha Malcom Francis <n-francis@ti.com>
CC: Andrew Davis <afd@ti.com>, Simon Glass <sjg@chromium.org>, Alper Nebi
 Yasak <alpernebiyasak@gmail.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, <u-boot@lists.denx.de>,
 Udit Kumar <u-kumar1@ti.com>, Praneeth Bajjuri <praneeth@ti.com>,
 Kamlesh Gurudasani <kamlesh@ti.com>, Nishanth Menon <nm@ti.com>
Subject: Re: [RFC PATCH 2/2] binman: j721e: Add firewall configurations for atf
Message-ID: <20230906050231.ethqqhzo3473eotg@ula0497581>
References: <20230905-binman-firewalling-v1-0-3894520bff8a@ti.com>
 <20230905-binman-firewalling-v1-2-3894520bff8a@ti.com>
 <72516776-1b6f-cd79-2e00-a28b920f722f@ti.com>
 <2c91bdf0-39c1-f7d9-28db-c1a7a8e361eb@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2c91bdf0-39c1-f7d9-28db-c1a7a8e361eb@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

Hi Neha, Andrew,

On 09:20-20230906, Neha Malcom Francis wrote:
> Hi Andrew,
> 
> On 05/09/23 20:52, Andrew Davis wrote:
> > On 9/5/23 3:21 AM, Manorit Chawdhry wrote:
> > > The following commits adds the configuration of firewalls required to
> > > protect ATF and OP-TEE memory region from non-secure reads and
> > > writes using master and slave firewalls present in our K3 SOCs.
> 
> [...]
> 
> > > +                        // cpu_0_cpu_0_msmc Foreground Firewall
> > > +                        firewall-1 {
> > > +                            id = <257>;
> > > +                            region = <1>;
> > > +                            control = <0x1a>;
> > > +                            permissions = <0x0100ff>;
> > > +                            start_address = <0x0 0x70000000>;
> > 
> > This address might change if one moves ATF, might work to use
> > CONFIG_K3_ATF_LOAD_ADDR?
> > Not sure how you would get the end address as we don't really know ATF size..
> > 
> 
> I think this could be handled within binman IF CONFIG_K3_ATF_LOAD_ADDR and
> the ATF binary were not only A53/A72 inputs. But since it is, I don't see
> how that can be implemented.
> 

Andrew, 

I don't think that just using the CONFIG would be a good solution as
the slave firewalls would not be able to protect the updated ATF address. 

Maybe we can use configs and put some warning in build time if the ATF
address is not the default, would see how this could be done getting the
size is still an issue as Neha mentioned that they have to be inputs for
all the build stages. 

Neha,

Would you be able to elaborate more on that part?

Regards,
Manorit

> > Andrew
> 
> -- 
> Thanking You
> Neha Malcom Francis

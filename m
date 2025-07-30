Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06BADC87FC9
	for <u-boot@archiver.kernel.org>; Wed, 30 Jul 2025 22:19:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E0B8831B4;
	Thu, 31 Jul 2025 00:19:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="yupqLBF7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0FB70831D7; Thu, 31 Jul 2025 00:19:14 +0200 (CEST)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2D2CA802C1
 for <u-boot@lists.denx.de>; Thu, 31 Jul 2025 00:19:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 56UMJ9V23341774;
 Wed, 30 Jul 2025 17:19:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1753913949;
 bh=+OrA7rxz1mu6V2qdp5HEZpsqaM3Alc87fVYY1iEKjWw=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=yupqLBF7e7cNhU58XXRE0TCAbvPr+UhvnDs+s7VnQIKxZggUlzTYKl1OQ/yTDKuFw
 G6AJg7UhPV78pTKHVuqUukPwZjIMYmnuphh8j08k+nbU2MBvBDSoNiryXoQWkK1zCb
 wGx5K2vn4fg2g8vFt7cB/AM7K+pcdcGIrKpoJCyM=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
 by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 56UMJ8Ys3494681
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Wed, 30 Jul 2025 17:19:08 -0500
Received: from DFLE209.ent.ti.com (10.64.6.67) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 30
 Jul 2025 17:19:08 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE209.ent.ti.com
 (10.64.6.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.2.1748.24; Wed, 30 Jul
 2025 17:19:08 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Wed, 30 Jul 2025 17:19:08 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 56UMJ8dE1917859;
 Wed, 30 Jul 2025 17:19:08 -0500
Date: Wed, 30 Jul 2025 17:19:08 -0500
From: Bryan Brattlof <bb@ti.com>
To: Tom Rini <trini@konsulko.com>
CC: Wadim Egorov <w.egorov@phytec.de>, Garrett Giordano
 <ggiordano@phytec.com>, <u-boot@lists.denx.de>, Daniel Schultz
 <d.schultz@phytec.de>
Subject: Re: [PATCH 0/2] arm: dts: k3-am62a: remove GP security variant for
 AM62A
Message-ID: <20250730221908.sqxudugdd3oa3gre@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20250729-no-62a-gp-v1-0-1dbdb4469ad3@ti.com>
 <03e3be58-3c69-407d-8bf8-3f90e6b19e6c@phytec.de>
 <20250730142624.GO1807455@bill-the-cat>
 <9d812fd3-6bbd-40c4-9485-f1aca43804b9@phytec.de>
 <20250730155258.GQ1807455@bill-the-cat>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20250730155258.GQ1807455@bill-the-cat>
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

On July 30, 2025 thus sayeth Tom Rini:
> On Wed, Jul 30, 2025 at 06:34:42PM +0300, Wadim Egorov wrote:
> > 
> > 
> > On 7/30/25 5:26 PM, Tom Rini wrote:
> > > On Wed, Jul 30, 2025 at 04:12:48PM +0300, Wadim Egorov wrote:
> > > > 
> > > > 
> > > > On 7/29/25 9:36 PM, Bryan Brattlof wrote:
> > > > > Hello Everyone,
> > > > > 
> > > > > The AM62Ax was created right when TI was shifting to their high security
> > > > > (HS-FS and HS-SE) processes. During this transition a small subset of
> > > > > AM62A parts where configured to use the old "GP" security for internal
> > > > > and for select groups of partners but never sold for the wider public.
> > > > 
> > > > I guess I will need to update my hardware to an HS-FS device :/
> > > 
> > > Did these chips then get sold to the wider public? Or just distributed
> > > within phytec? I'm wondering if we have another i.MX95 A0 type situation
> > > or not
> > > (https://lore.kernel.org/u-boot/PAXPR04MB96443299A51764EE05533DE0E224A@PAXPR04MB9644.eurprd04.prod.outlook.com/)
> > > 
> > 
> > I am pretty sure I got a super early prototype for bringup. AFAIK there are
> > no other SoMs with this revision in the wild.

Ha you scared me for a bit. I was told no-one had these samples :)

Even the teams producing the TIFS and DM firmware binaries have lost 
their ability to test on any real GP hardware. So it's only a matter of 
time before these boards bit rot away

~Bryan

> 
> OK, I'll assume things will get worked out then, barring further "wait
> no, this is in the wild!" reports.
> 
> -- 
> Tom



Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D73EC2FC0E
	for <u-boot@archiver.kernel.org>; Thu, 17 Aug 2023 11:34:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB9EC86AD0;
	Thu, 17 Aug 2023 13:34:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="lFjxBrXK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4CE1586AD8; Thu, 17 Aug 2023 13:34:07 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C3EA586AB0
 for <u-boot@lists.denx.de>; Thu, 17 Aug 2023 13:34:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37HBXrKR027246;
 Thu, 17 Aug 2023 06:33:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1692272033;
 bh=yV3pTJYKY9xlfBvnO6IFw3g/V0HFX47T4YSAHAYBWy4=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=lFjxBrXKrpSfR9yk9k+Oj7OBiabltZNAQ3j01VKZNJIRRvcDT+ACRcYPUAECHZ38N
 5XefHPgWnuvHNa8PnYx9M8p4WlilOsVo/QoBq1fia7G1baFCqVGMSPQjct5Xuy/sDS
 ncbSd+mwNUJ36BJwiaLzmNEPNcf9DdAQ8HYZnfII=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37HBXrEW087487
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 17 Aug 2023 06:33:53 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 17
 Aug 2023 06:33:52 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 17 Aug 2023 06:33:52 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37HBXq9M024573;
 Thu, 17 Aug 2023 06:33:52 -0500
Date: Thu, 17 Aug 2023 06:33:52 -0500
From: Nishanth Menon <nm@ti.com>
To: Bhupesh Sharma <bhupesh.sharma@linaro.org>
CC: Neha Malcom Francis <n-francis@ti.com>, Marek Vasut
 <marek.vasut@mailbox.org>, <u-boot@lists.denx.de>,
 <sjg@chromium.org>, <trini@konsulko.com>, <bhupesh.linux@gmail.com>,
 <marek.vasut+renesas@mailbox.org>, <sumit.garg@linaro.org>,
 <rfried.dev@gmail.com>, <patrice.chotard@foss.st.com>,
 <jbx6244@gmail.com>, <kever.yang@rock-chips.com>,
 <eugen.hristev@collabora.com>, "vigneshr@ti.com" <vigneshr@ti.com>,
 "Kumar, Udit" <u-kumar1@ti.com>
Subject: Re: [PATCH 17/17] MAINTAINERS: Update UFS maintainer
Message-ID: <20230817113352.pgx2nx7mwfejubb7@iciness>
References: <20230814215457.4075025-1-bhupesh.sharma@linaro.org>
 <20230814215457.4075025-18-bhupesh.sharma@linaro.org>
 <d4b2b0f9-6231-6087-a06f-df7f059a80e5@mailbox.org>
 <CAH=2Ntw_4sJYy_ehbQ2ZL6GMd6bbFcAO9pJBWRrmqMjKNehSwg@mail.gmail.com>
 <020474d5-bd1a-9231-af72-0e6cf1da66e6@mailbox.org>
 <91f9cd39-76d1-376b-1048-063a3d5588a7@ti.com>
 <CAH=2NtzyQgximynKuG45UUux715Du=WKKusm9-aQGHcUZsWzSw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAH=2NtzyQgximynKuG45UUux715Du=WKKusm9-aQGHcUZsWzSw@mail.gmail.com>
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

On 15:40-20230817, Bhupesh Sharma wrote:
> Hi Neha,
> 
> On Thu, 17 Aug 2023 at 10:26, Neha Malcom Francis <n-francis@ti.com> wrote:
> >
> > Hi Bhupesh, Marek
> >
> > On 16/08/23 02:16, Marek Vasut wrote:
> > > On 8/15/23 19:48, Bhupesh Sharma wrote:
> > >> On Tue, 15 Aug 2023 at 04:01, Marek Vasut <marek.vasut@mailbox.org> wrote:
> > >>>
> > >>> On 8/14/23 23:54, Bhupesh Sharma wrote:
> > >>>> Since Faiz Abbas's email ID is no longer valid,
> > >>>> drop him from UFS Maintainer list.
> > >>>>
> > >>>> Since I am using the UFS framework now extensively
> > >>>> on Qualcomm Snapdragon SoCs, so proposing myself as
> > >>>> the new UFS maintainer.
> > >>>>
> > >>>> I have also been sending out u-boot UFS fixes in the
> > >>>> recent past.
> > >>>>
> > >>>> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> > >>>
> > >>> I believe TI is working on something here, so please coordinate with them.
> > >>
> > >> Ok, well I haven't seen any reply to my earlier UFS fix related emails
> > >> from TI, so I thought maybe no one is actively looking into this area.
> > >> But I would love to hear from TI on the same..
> > >
> > > This is why I CCed Vignesh and Nishanth , coordinate with them.
> > >
> > >> Anyways since I will be working on the Qualcomm UFS glue layer going
> > >> forward, I can propose to either be a UFS maintainer or a reviewer for
> > >> now to make sure that the subsystem patches are reviewed and tested .
> > >
> > >
> >
> > I'd like to propose myself as a UFS maintainer along with Bhupesh, can help with
> > reviewing and testing starting with these patches. If all seems okay, I can send
> > a MAINTAINERS patch adding both Bhupesh and me.
> 
> Thanks for stepping in. The above proposal looks good to me - I can
> help to-maintain this u-boot framework and work closely with you for
> testing / reviewing patches related to  this area.
> 
> Many thanks to Nishanth as well for his prompt response when I ping'ed
> him regarding this :)

Thank you folks for volunteering and keeping our community vibrant.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

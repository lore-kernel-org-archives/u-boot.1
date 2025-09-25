Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5896FCAC5B1
	for <u-boot@archiver.kernel.org>; Thu, 25 Sep 2025 14:28:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D300580107;
	Thu, 25 Sep 2025 16:28:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="TAtgoskc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E8B9809A5; Thu, 25 Sep 2025 16:28:35 +0200 (CEST)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7FE2A800D7
 for <u-boot@lists.denx.de>; Thu, 25 Sep 2025 16:28:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58PESGep1475199;
 Thu, 25 Sep 2025 09:28:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1758810496;
 bh=otdluRCHbQp/BAIFvSIPJ5TugV2ETMaIoDLXQAyov40=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=TAtgoskcucQZwFXU4P95HBGxDMCaqMdIJXNtRhQY6KQDet4Vd0hy7jvjlzKDJWxeM
 HEse1MvD1e7xCi2TAUcOlLUfndgTDUkI8jHOzaYnNklmFvwL5ReK2/LdbXboEz5XNL
 njg8o8EQw4ideJ94cqZoske7h9pCreKwCV1h+W40=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
 by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58PESFkb233723
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Thu, 25 Sep 2025 09:28:15 -0500
Received: from DLEE214.ent.ti.com (157.170.170.117) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 25
 Sep 2025 09:28:15 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE214.ent.ti.com
 (157.170.170.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 25 Sep 2025 09:28:15 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58PESFS03629532;
 Thu, 25 Sep 2025 09:28:15 -0500
Date: Thu, 25 Sep 2025 09:28:15 -0500
From: Bryan Brattlof <bb@ti.com>
To: Aristo Chen <jj251510319013@gmail.com>
CC: Nishanth Menon <nm@ti.com>, Tom Rini <trini@konsulko.com>, E Shattow
 <e@freeshell.de>, <u-boot@lists.denx.de>,
 <sjg@chromium.org>, <alpernebiyasak@gmail.com>, <al.kochet@gmail.com>,
 <paul.henrys_ext@softathome.com>, <y.moog@phytec.de>,
 <w.egorov@phytec.de>, <francesco.dolcini@toradex.com>,
 <ggiordano@phytec.com>, <n-francis@ti.com>, <afd@ti.com>,
 <d.schultz@phytec.de>, <d-gole@ti.com>, <ravi@prevas.dk>,
 <carlos.lopezr4096@gmail.com>, <quentin.schulz@cherry.de>,
 <alice.guo@nxp.com>, Aristo Chen <aristo.chen@canonical.com>
Subject: Re: [PATCH v2 0/7] mkimage: Detect FIT image load address overlaps
 and fix related test/DTS issues
Message-ID: <20250925142815.p46kfcxibgipf3hr@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20250914110021.4103-1-aristo.chen@canonical.com>
 <20250924113733.uz6hozszbuynemtc@giddy>
 <20250924114317.742ae4ntrb4mvuyq@expert>
 <b07919da-f3fe-49ca-8f76-ab057d8af58a@freeshell.de>
 <20250924135139.GH197373@bill-the-cat>
 <20250924140524.fy46p7ifr4oxh5mc@uncooked>
 <CAJwFiG+M8v3RA9=E296s8xc+NnK3HxwBspw30LsXUBMpzB18ew@mail.gmail.com>
 <CAJwFiGJAkESqDDpsuMe1jxYcZD=G+m+2OFuSW3Jzqh4=Jxm_Qg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJwFiGJAkESqDDpsuMe1jxYcZD=G+m+2OFuSW3Jzqh4=Jxm_Qg@mail.gmail.com>
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

On September 25, 2025 thus sayeth Aristo Chen:
> Aristo Chen <jj251510319013@gmail.com> 於 2025年9月24日 週三 下午10:33寫道：
> >
> > Nishanth Menon <nm@ti.com> 於 2025年9月24日 週三 下午10:05寫道：
> > >
> > > On 07:51-20250924, Tom Rini wrote:
> > > > On Wed, Sep 24, 2025 at 06:31:23AM -0700, E Shattow wrote:
> > > > > Hi Aristo,
> > > > >
> > > > > On 9/24/25 04:43, Nishanth Menon wrote:
> > > > > > On 06:37-20250924, Nishanth Menon wrote:
> > > > > >> On 10:59-20250914, Aristo Chen wrote:
> > > > > >>> This patch series enhances FIT image robustness by adding **memory
> > > > > >>> region overlap detection** to `mkimage` and fixing existing overlaps
> > > > > >>> in DTS files and `binman` tests.
> > > > > >
> > > > > > [...]
> > > > > >>>
> > > > > >>
> > > > > >> Looks like i see a build regression in linux-next after this series.
> > > > > >
> > > > > > I fat fingered that one.. sorry, I meant u-boot next.
> > > > > >
> > > > > >
> > > > > > Fails at commit 4d84fa1261eb, last pass was on commit d81c1118580f
> > > > > >
> > > > > >>
> > > > > >> https://gist.github.com/nmenon/b2fc9e7680cc296062c7dced94105f76
> > > > > >
> > > > > > I  believe there are outstanding comments on V1 that have'nt been
> > > > > > addressed either. Can we revert/drop this series for now while the
> > > > > > comments are addressed?
> > > > > >
> > > > >
> > > > > Similar to Nishanth, I am seeing a build regression, itb.map:
> > > >
> > > > Sorry for the noise all, I've reverted this in next now.
> > > >
> > >
> > > Thanks Tom.
> > > --
> > > Regards,
> > > Nishanth Menon
> > > Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
> > > https://ti.com/opensource
> >
> > Apology for introducing the regression, I will find time to fix them,
> > and thanks Tom for reverting my patch set to unblock others
> >
> > For TIFS stub entries on AM6x platforms and the starfive visionfive2,
> > sounds like the image in the FIT will be selected during the runtime,
> > so they are not really overlapping each other. I will need to figure
> > out other way instead
> 
> 
> Thank you all for the feedback on my FIT image overlap detection patch
> series, and apology again for the issues that I introduced
> 
> Currently what I have in my mind is to have the following 2 changes in
> my patch set
> ### 1. Add support for mutually exclusive image groups
> Some platforms load only one image from a group at runtime. In the
> device tree, we may have something like this
> ```
> tifsstub-hs {
>     // ... existing properties ...
>     mutually-exclusive-group = "tifsstub";
> };
> tifsstub-fs {
>     // ... existing properties ...
>     mutually-exclusive-group = "tifsstub";
> };
> ```
> The overlap checker would then skip validation between images in the
> same mutually-exclusive-group, while still catching genuine
> overlaps

This was the direction I was leaning as well. A way to opt-out or group 
the binaries we know should overlap.

> 
> ### 2.  Change from build error to warning
> Given that there may be edge cases(such as
> starfive_visionfive2_defconfig) not covered by current CI pipelines,
> changing overlap
> detection from a build-stopping error to a warning initially. This would:
> - Alert developers to potential memory layout issues
> - Avoid breaking existing working configurations
> - Allow time to refine the detection logic based on community feedback
> - Enable a gradual transition to stricter validation once the approach is proven
> The warning could later become an error once we have confidence in the
> detection accuracy across all supported platforms.
> 

I haven't looked into what is needed for the visionfive2 board, but I 
liked having this as a build error. If we know the build will not work 
on for the board I think we should fail to build it.

Though it's really just for the selfish reason of not having to debug 
other people's builds that lead to the unsatisfying conclusion of memory 
corruption.

~Bryan

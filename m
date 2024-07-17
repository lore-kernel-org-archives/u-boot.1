Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEFC9C3DA42
	for <u-boot@archiver.kernel.org>; Wed, 17 Jul 2024 12:12:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 35CC188755;
	Wed, 17 Jul 2024 14:12:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="MEH48lfv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 17F2F886E7; Wed, 17 Jul 2024 14:12:02 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6F64E884D1
 for <u-boot@lists.denx.de>; Wed, 17 Jul 2024 14:11:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 46HCBmEn121338;
 Wed, 17 Jul 2024 07:11:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1721218308;
 bh=NkLbR/NiKYx4omUavlBwGPQCw0lbINMyLMannH0m+Hg=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=MEH48lfvxhfNDaly3/8DFFXcMwhvFo4+vQngnEdBSAwnuMD9Bnj7YqLHbqi/K/xDJ
 C0DiJAetGSTueLbMHsbM6VtEbUPAoJ9vhWlodORu3I6iZP8fXthwcRu6FNx4gj6SZU
 8nWfNpNiql9S/ft4CProQRfz2mx7ahDc0mZSqkw8=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 46HCBmr0015385
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 17 Jul 2024 07:11:48 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 17
 Jul 2024 07:11:47 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 17 Jul 2024 07:11:47 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 46HCBl3G025887;
 Wed, 17 Jul 2024 07:11:47 -0500
Date: Wed, 17 Jul 2024 07:11:47 -0500
From: Nishanth Menon <nm@ti.com>
To: Tom Rini <trini@konsulko.com>
CC: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 <u-boot@lists.denx.de>, Simon Glass <sjg@chromium.org>, Quentin Schulz
 <quentin.schulz@theobroma-systems.com>, Peter Robinson
 <pbrobinson@gmail.com>, Enric Balletbo i Serra <eballetb@redhat.com>, Josh
 Boyer <jwboyer@redhat.com>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Subject: Re: Request for hosting a boot-firmware repository in u-boot git
 (denx and GitHub)
Message-ID: <20240717121147.2otvlmo6tpmek3wm@vacancy>
References: <20240620213539.ftmjhphypssxp5n4@desolate>
 <20240716191300.GM561963@bill-the-cat>
 <4bb80912-62fa-4f33-a344-351141d8df10@canonical.com>
 <20240716200147.GN561963@bill-the-cat>
 <e188ea04-9309-408b-8749-f137fbbd23fa@canonical.com>
 <20240716213618.GO561963@bill-the-cat>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240716213618.GO561963@bill-the-cat>
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

On 15:36-20240716, Tom Rini wrote:
[...]

> > > > Distributing the closed source binaries and U-Boot in separate packages
> > > > according to their respective licenses and only assemble them on the target
> > > > device via a post-installation script might be allowable.
> > > 
> > > For this project the question is making sure that the binaries are
> > > licensed such that they could be externally redistributable.
> > > 
> > > I don't know why someone would suggest that ABI calls are suddenly
> > > linkage as I thought that (as far as these matters go) that was already
> > > settled, but I am not a lawyer.
> > 
> > The relevant term in the GPL 2.0 license is "work based on the Program".
> > According to the GPL a "work based on the Program" is "a work containing the
> > Program or a portion of it".
> > 
> > If you build a binary via binman that contains U-Boot and another binary,
> > the resulting binary could be considered "a work containing the Program or a
> > portion of it".
> > 
> > The GPL 2.0 requires:
> > 
> > "But when you distribute the same sections as part of a whole which is a
> > work based on the Program, the distribution of the whole must be on the
> > terms of this License, whose permissions for other licensees extend to the
> > entire whole, and thus to each and every part regardless of who wrote it."
> 
> I'm not a lawyer and I don't pretend to be one on mailing lists, either.
> 
> In that my non-lawyer statements matter, I don't think binman
> constitutes some new form of linking and I believe it falls in to the
> same well known ABI exception.
> 
> But that's entirely unrelated to the question of hosting binaries (some
> of which may be closed source) for use in firmware projects, some of
> which will not be GPL. For example, I would assume that running
> tianocore on i.MX8 requires the same assorted binaries that U-Boot does,
> and that would not have a license conflict.

Usual disclaimers (not a lawyer, not representing corporate policy..  etc):
buildroot and yocto for example prebuild images for embedded systems and
they have had to deal with closed firmwares in the past as well.
Packaging binaries in a filesystem or some format (x509/fit) is
essentially the same thing - anyways.. interesting thought there.


PS: For folks interested: LPC accepted our proposal[1] in the
security/boot MC and if folks could join in person or virtually, it
would be great to lay this out and get the thoughts out and come to some
direction here.

[1] https://lpc.events/event/18/contributions/1815/


-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

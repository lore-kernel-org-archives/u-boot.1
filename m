Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F304C4332F
	for <u-boot@archiver.kernel.org>; Mon,  6 Nov 2023 14:45:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 35D4E86F09;
	Mon,  6 Nov 2023 15:45:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="g2YH/+M6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C266886F8A; Mon,  6 Nov 2023 15:45:33 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 78F8E86D0E
 for <u-boot@lists.denx.de>; Mon,  6 Nov 2023 15:45:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3A6EjQlb025262;
 Mon, 6 Nov 2023 08:45:26 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1699281926;
 bh=+LYBkRlKLfcXyIYpqMa6JT2h61ZBwRLVLuMYZLzw8vU=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=g2YH/+M6JnPBgVKVwHJITuVz1f9xMey5vf3hCR03+G2USyTN1ry8uRcXTtnZCrL5Y
 5j37DTuK7PIzsVB9KehPkGN2WxuNwdRGf4AdE/QIDI9wcu+Qqsq4wcEBQaRI0/qVK+
 gbsMtLj1Qh5JpcMD+9yDl33FE9tkvpin32kebB3s=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3A6EjQob024989
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 6 Nov 2023 08:45:26 -0600
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 6
 Nov 2023 08:45:26 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 6 Nov 2023 08:45:25 -0600
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3A6EjQTT020622;
 Mon, 6 Nov 2023 08:45:26 -0600
Date: Mon, 6 Nov 2023 08:45:26 -0600
From: Nishanth Menon <nm@ti.com>
To: Bryan Brattlof <bb@ti.com>
CC: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sinthu Raja <sinthu.raja@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>,
 Reid Tonking <reidt@ti.com>, Neha Malcom Francis <n-francis@ti.com>,
 Andrew Davis <afd@ti.com>, Simon Glass <sjg@chromium.org>, Robert Nelson
 <robertcnelson@gmail.com>,
 Jason Kridner <jkridner@beagleboard.org>, <u-boot@lists.denx.de>,
 <praneeth@ti.com>
Subject: Re: [PATCH 1/5] arm: dts: k3-am625-beagleplay-u-boot/r5: Just depend
 on k3-binman.dtsi
Message-ID: <20231106144526.ydafngyzpx6utki5@troubling>
References: <20231104080137.9628-1-nm@ti.com> <20231104080137.9628-2-nm@ti.com>
 <20231106143451.w7qqaisbx34zqtlr@bryanbrattlof.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231106143451.w7qqaisbx34zqtlr@bryanbrattlof.com>
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

On 08:34-20231106, Bryan Brattlof wrote:
> Hi Nishanth!
> 
> On November  4, 2023 thus sayeth Nishanth Menon:
> > With the upcoming folder separation, there is no further need to depend
> > on am625-binman.dtsi. Duplicate the existing definitions to u-boot.dtsi
> > and r5.dts as appropriate.
> > 
> > Signed-off-by: Nishanth Menon <nm@ti.com>
> 
> Reviewed-by: Bryan Brattlof <bb@ti.com>
> 
> > ---
> >  arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi | 160 +++++++++++++++++--
> >  arch/arm/dts/k3-am625-r5-beagleplay.dts      |  39 +++++
> >  2 files changed, 184 insertions(+), 15 deletions(-)
> 
> ...
> 
> > -&spl_am625_sk_dtb_unsigned {
> > -	filename = SPL_AM625_BEAGLEPLAY_DTB;
> > -};
> > +	ti-spl_unsigned {
> > +		filename = "tispl.bin_unsigned";
> 
> If all of the beagle-plays are using the GP security variant shouldn't 
> we remove the _unsigned?

Today, they are GP, but there is already plans being discussed for
hs-fs variants - timelines aren't very clear though.

> 
> > +		pad-byte = <0xff>;
> > +
> 
> ...
> 
> > -&am625_sk_dtb_unsigned {
> > -	filename = AM625_BEAGLEPLAY_DTB;
> > +	u-boot_unsigned {
> > +		filename = "u-boot.img_unsigned";
> 
> And here? I don't really have an opinion either way. Just curious if 
> we've thought about that.
> 
> > +		pad-byte = <0xff>;
> > +
> 
> ~Bryan
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

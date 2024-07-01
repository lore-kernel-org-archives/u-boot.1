Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3760BC2BD09
	for <u-boot@archiver.kernel.org>; Mon,  1 Jul 2024 15:29:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C04C886B6;
	Mon,  1 Jul 2024 17:29:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="U+r324oL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 42B81886B8; Mon,  1 Jul 2024 17:29:05 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1DBEA886A0
 for <u-boot@lists.denx.de>; Mon,  1 Jul 2024 17:29:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 461FT09L071770;
 Mon, 1 Jul 2024 10:29:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1719847740;
 bh=Mlijiqbo1M6HismDfGDaqdPBbIyh7FN1QjA28HCOMfw=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=U+r324oLgHiwt+GdTan2dy56gdIVKz3FQw7rRABPEyIvgRunNBxo0jvfiBaNN+blH
 rwcn8Rz1lHOK7hOej/E/Nzk+2REEAhADNBRbnnkeRDEBGaAXqf7YSBHy2ZCOYrxTQr
 4EJkcIzs+F7qsDiRyFisaR+15newj8dV2zH3csf4=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 461FT04K037279
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 1 Jul 2024 10:29:00 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 1
 Jul 2024 10:29:00 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 1 Jul 2024 10:29:00 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 461FT0lH108582;
 Mon, 1 Jul 2024 10:29:00 -0500
Date: Mon, 1 Jul 2024 10:29:00 -0500
From: Nishanth Menon <nm@ti.com>
To: Robert Nelson <robertcnelson@gmail.com>
CC: Dhruva Gole <d-gole@ti.com>, Jason Kridner <jkridner@beagleboard.org>, Tom
 Rini <trini@konsulko.com>, <u-boot@lists.denx.de>, Neha Malcom Francis
 <n-francis@ti.com>, <c-shilwant@ti.com>,
 <m-chawdhry@ti.com>, <vigneshr@ti.com>
Subject: Re: [PATCH v4 0/2] k3-am625-beagleplay: Add symlinks for tiboot3 and
 tispl
Message-ID: <20240701152900.p4vu346cifaewtj6@whooping>
References: <20240618044946.270299-1-d-gole@ti.com>
 <20240628131222.4ev5rhmqepmc7qnk@reward>
 <CAOCHtYjWva2T+ALZL+Q7t7QA9wCojRqeAtbfJwns41XDJaG5BA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOCHtYjWva2T+ALZL+Q7t7QA9wCojRqeAtbfJwns41XDJaG5BA@mail.gmail.com>
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

On 21:32-20240628, Robert Nelson wrote:
> On Fri, Jun 28, 2024 at 8:12 AM Nishanth Menon <nm@ti.com> wrote:
> >
> > On 10:19-20240618, Dhruva Gole wrote:
> > > Add symlinks for both tiboot3.bin and tispl.bin because a user has to
> > > anyway rename these files to get the platform to boot up.
> > > Also update the documentation to reflect above change.
> > >
> > > Changes in v4:
> > > * Add the docs patch.
> > >
> > > Cc: Nishant Menon <nm@ti.com>
> > > Cc: Robert Nelson <robertcnelson@gmail.com>
> > >
> > > Dhruva Gole (2):
> > >   arm: dts: k3-am625-beagleplay: Add symlinks for tiboot3 and tispl
> > >   doc: beagle: am62x_beagleplay: Rename the boot bins
> > >
> > >  arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi | 1 +
> > >  arch/arm/dts/k3-am625-r5-beagleplay.dts      | 1 +
> > >  doc/board/beagle/am62x_beagleplay.rst        | 7 +++----
> > >  3 files changed, 5 insertions(+), 4 deletions(-)
> >
> >
> > Robert/Jason:
> >
> > Can you folks confirm that we will ONLY have GP version of BeaglePlay
> > for even a new update of the board? If that is confirmed, then this
> > series is good.
> >
> > Any thoughts?
> 
> Yeap pretty sure the BeaglePlay will ONLY ever use the GP version.

Alright. thanks.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

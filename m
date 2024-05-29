Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAF20C25B75
	for <u-boot@archiver.kernel.org>; Wed, 29 May 2024 06:09:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D58B8796B;
	Wed, 29 May 2024 08:09:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="T/87lExC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ACC4786FB2; Wed, 29 May 2024 08:09:20 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3131988590
 for <u-boot@lists.denx.de>; Wed, 29 May 2024 08:09:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=d-gole@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44T69A8O051604;
 Wed, 29 May 2024 01:09:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1716962950;
 bh=kOsgrnpG4zeYRSy2JiAtiC5DdivyxzGUNQUEtiCq0PY=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=T/87lExCAA4jgKN4AFPaComWkGK/1P9Y0mULA7duNNH23CP7A/pAVSpwH+KQdZAlc
 u3+4eWsNPVDTUZcBekkSgnWrid8GQ7bak22KhsGoYRrXjwhacjXIHoSi4gBa/Xd+sL
 GNP+Ch2S1AH6gFKwPucOuvuAX9l8uD8phrjUkVaQ=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44T69Aeq095523
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 29 May 2024 01:09:10 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 29
 May 2024 01:09:10 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 29 May 2024 01:09:10 -0500
Received: from localhost (dhruva.dhcp.ti.com [172.24.227.68])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44T69924087942;
 Wed, 29 May 2024 01:09:09 -0500
Date: Wed, 29 May 2024 11:39:08 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Tom Rini <trini@konsulko.com>
CC: Marcel Ziswiler <marcel.ziswiler@toradex.com>, "nm@ti.com" <nm@ti.com>,
 "sjoerd@collabora.com" <sjoerd@collabora.com>, "a-govindraju@ti.com"
 <a-govindraju@ti.com>, "d-gerlach@ti.com" <d-gerlach@ti.com>,
 "jpanis@baylibre.com" <jpanis@baylibre.com>, "mkorpershoek@baylibre.com"
 <mkorpershoek@baylibre.com>, "g-tammana@ti.com" <g-tammana@ti.com>,
 "kamlesh@ti.com" <kamlesh@ti.com>, "vigneshr@ti.com" <vigneshr@ti.com>,
 "marex@denx.de" <marex@denx.de>, "hayashi.kunihiko@socionext.com"
 <hayashi.kunihiko@socionext.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, "angus@akkea.ca" <angus@akkea.ca>, "g-vlaev@ti.com"
 <g-vlaev@ti.com>, "s-anna@ti.com" <s-anna@ti.com>, "sjg@chromium.org"
 <sjg@chromium.org>
Subject: Re: [PATCH v2 0/8] Add DFU, emmc and usb boot for TI am62x
Message-ID: <20240529060908.l6vy6rnefpei5lqs@dhruva>
References: <20230406185542.1179073-1-sjoerd@collabora.com>
 <20230531211403.GA980359@bill-the-cat>
 <3f8f03e9736aa93b87a26e8056037d53bb50db56.camel@collabora.com>
 <df470ed11d3c7f748a171cf221102b0bcd2ead23.camel@toradex.com>
 <20230821182026.GH3953269@bill-the-cat>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230821182026.GH3953269@bill-the-cat>
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

Hi Sjoerd,

On Aug 21, 2023 at 14:20:26 -0400, Tom Rini wrote:
> On Mon, Aug 21, 2023 at 04:13:32PM +0000, Marcel Ziswiler wrote:
> > Hi Sjoerd
> > 
> > On Thu, 2023-06-01 at 08:37 +0200, Sjoerd Simons wrote:
> > > On Wed, 2023-05-31 at 17:14 -0400, Tom Rini wrote:
> > > > On Thu, Apr 06, 2023 at 08:55:34PM +0200, Sjoerd Simons wrote:
> > > > 
> > > > > This series adds more boot sources for the TI am62x. For that the
> > > > > dts'
> > > > > are synced from the upstream ti-next git tree (to add usb nodes),
> > > > > some
> > > > > dwc3 glue is and finally the default configuration is tuned to add
> > > > > support for DFU and USB (host and gadget)
> > > > 
> > > > This seems, conceptually, fine.  But as we're getting the TI dts
> > > > files
> > > > in sync with the kernel, I'm deferring this version and you'll want
> > > > to
> > > > rebase and re-post once everything has settled.
> > > 
> > > Thanks for the update/hint ;) I also got a few review comments so the
> > > plan is to include those and repost.. Just my may has been stupidly
> > > busy causing me to not get around it in the first place, so maybe that
> > > turned into good timing in the end.
> > 
> > Any progress on this?
> > 
> > I still carry your re-based series on top of latest master [1] and USB DFU is working very well on Verdin AM62.
> > 
> > Thanks!
> > 
> > [1] https://github.com/ziswiler/u-boot/tree/verdin-am62-usb-support
> 
> As the am62 files have been re-synced, re-basing this and re-posting for
> next would be appropriate at this point.

Any updates on this? Do you have plans to rebase and resend this series?



-- 
Best regards,
Dhruva Gole <d-gole@ti.com>

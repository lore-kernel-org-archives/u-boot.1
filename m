Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D220D1715C
	for <u-boot@archiver.kernel.org>; Tue, 22 Oct 2024 03:16:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5DC0B88E39;
	Tue, 22 Oct 2024 05:16:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="x9B1YlEX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D4CC288EFB; Tue, 22 Oct 2024 05:16:40 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E38D68806A
 for <u-boot@lists.denx.de>; Tue, 22 Oct 2024 05:16:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 49M3GWnh114345;
 Mon, 21 Oct 2024 22:16:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1729566992;
 bh=M6weraKKNjkOhZ/K4LHZfMvvE7gSYBfLIsv3hQ3iU5o=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=x9B1YlEX8FCxeGFMKRYj0VNctMUH1Na6k3tEIPv3vOzTh9YGKam1wM0e06HqV9boX
 UQ8BpT7QR+2cXxpA7uYquw29gBLKvj53IK9UEItV/Cd9DRsExX/HhTaDBUL6fCJEHc
 joplhl1RBdOh7UYHayiy1H9QbgB5gGJdiEstUbpE=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49M3GWsR109986;
 Mon, 21 Oct 2024 22:16:32 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 21
 Oct 2024 22:16:32 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 21 Oct 2024 22:16:32 -0500
Received: from [172.24.227.36]
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.227.36]
 (may be forged))
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49M3GTtH063192;
 Mon, 21 Oct 2024 22:16:30 -0500
Message-ID: <631b61e3-ba64-4d0c-abf4-d8a649fb2cf0@ti.com>
Date: Tue, 22 Oct 2024 08:46:28 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] doc: do not include K3 boards twice in TOC
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>, Tom Rini
 <trini@konsulko.com>
CC: Sean Anderson <sean.anderson@seco.com>, Nishanth Menon <nm@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>, Bryan Brattlof <bb@ti.com>,
 Dhruva Gole <d-gole@ti.com>, U-Boot Mailing List <u-boot@lists.denx.de>
References: <20241021180101.18452-1-heinrich.schuchardt@canonical.com>
 <20241021180101.18452-3-heinrich.schuchardt@canonical.com>
 <20241021181234.GQ4959@bill-the-cat>
 <1e9609f3-f237-4aa7-9f9a-4eb30243261f@canonical.com>
 <20241021184249.GT4959@bill-the-cat>
 <CAM=mAOkx8XyaL9TrPzExDhkjy0LUzHSu+nc07gNRpANQMRFjzw@mail.gmail.com>
Content-Language: en-US
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <CAM=mAOkx8XyaL9TrPzExDhkjy0LUzHSu+nc07gNRpANQMRFjzw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
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

Hi Heinrich

On 22/10/24 01:06, Heinrich Schuchardt wrote:
> 
> 
> Tom Rini <trini@konsulko.com <mailto:trini@konsulko.com>> schrieb am Mo., 21. 
> Okt. 2024, 20:42:
> 
>     On Mon, Oct 21, 2024 at 08:15:45PM +0200, Heinrich Schuchardt wrote:
>      > On 10/21/24 20:12, Tom Rini wrote:
>      > > On Mon, Oct 21, 2024 at 08:01:01PM +0200, Heinrich Schuchardt wrote:
>      > > > Sphinx writes a warning if a page is included twice in the table of
>      > > > contents. Use references instead.
>      > > >
>      > > > Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com
>     <mailto:heinrich.schuchardt@canonical.com>>
>      > > > ---
>      > > >   doc/board/ti/k3.rst | 11 +++++++----
>      > > >   1 file changed, 7 insertions(+), 4 deletions(-)
>      > > >
>      > > > diff --git a/doc/board/ti/k3.rst b/doc/board/ti/k3.rst
>      > > > index c3513f0aee2..5d01f487622 100644
>      > > > --- a/doc/board/ti/k3.rst
>      > > > +++ b/doc/board/ti/k3.rst
>      > > > @@ -32,19 +32,22 @@ K3 Based SoCs
>      > > >      am62ax_sk
>      > > >      am62x_sk
>      > > > -   ../beagle/am62x_beagleplay
>      > > > -   ../phytec/phycore-am62x
>      > > > -   ../toradex/verdin-am62
>      > > >      am62px_sk
>      > > >      am64x_evm
>      > > >      am65x_evm
>      > > >      j7200_evm
>      > > > -   ../beagle/j721e_beagleboneai64
>      > > >      j721e_evm
>      > > >      j721s2_evm
>      > > >      j722s_evm
>      > > >      j784s4_evm
>      > > > +K3 SoC based boards in other sections
>      > > > +
>      > > > +* :doc:`../beagle/am62x_beagleplay`
>      > > > +* :doc:`../beagle/j721e_beagleboneai64`
>      > > > +* :doc:`../phytec/phycore-am62x`
>      > > > +* :doc:`../toradex/verdin-am62`
>      > >
>      > > Can we just make the changes to :doc: links be inline and keep the list
>      > > sorted/ordered as-is? Or does that not read well once rendered?
>      > >
>      >
>      > This is nothing Sphinx would understand:
>      >
>      > WARNING: toctree contains reference to nonexisting document
>      > 'board/ti/:doc:`../beagle/am62x_beagleplay`' [toc.not_readable]
> 
>     Hmm, maybe toctree is the wrong keyword, given where it is in the file
>     and the rest of the contents. I think the whole list is intended as
>     "here are all of the K3-based platforms". This however may mean that a
>     bunch of boards then need :orphan: added as they won't strictly be in
>     some other ToC list?
> 
>     -- 
>     Tom
> 
> 
> I would prefer not to break tree navigation. It would be best if the TI 
> contribitors stepped in.
> 

I personally feel this is good enough, the toc contains the TI K3 boards present 
within the "K3 Generation" page while the references points to the other vendor 
boards.

> Best regards
> 
> Heinrich
> 

-- 
Thanking You
Neha Malcom Francis

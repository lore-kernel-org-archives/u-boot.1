Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A21D2C3DA4B
	for <u-boot@archiver.kernel.org>; Wed, 17 Jul 2024 14:09:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB78A884E2;
	Wed, 17 Jul 2024 16:09:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="BW4l2/ZX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 71CCC8800C; Wed, 17 Jul 2024 16:09:22 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 964648876E
 for <u-boot@lists.denx.de>; Wed, 17 Jul 2024 16:09:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 46HE9DxW016710;
 Wed, 17 Jul 2024 09:09:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1721225353;
 bh=8Dh74SzHvg73j7BNVrGzjpNifJ7BMIuhL7Cg/8PozQs=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=BW4l2/ZX6BEC1nPkRgRSt+MekJBvqbGXOs18QczdMsLOEyMGZsthorHjUDBUc9GKx
 zwpI72c1W6Kr6B/hc8kMikdFmNb7qenl8uwjOfNpZxUbsF3xVwdQkuhzpegeS6v8Yy
 zuPKxqoknPJV6aGW8ivtHK5gS5xE5JASkv29M5oQ=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 46HE9DbH026941
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 17 Jul 2024 09:09:13 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 17
 Jul 2024 09:09:12 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 17 Jul 2024 09:09:13 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 46HE9DNs062990;
 Wed, 17 Jul 2024 09:09:13 -0500
Date: Wed, 17 Jul 2024 09:09:13 -0500
From: Nishanth Menon <nm@ti.com>
To: "Kumar, Udit" <u-kumar1@ti.com>
CC: Francesco Dolcini <francesco@dolcini.it>, <trini@konsulko.com>,
 <u-boot@lists.denx.de>, <j-humphreys@ti.com>,
 <marcel.ziswiler@toradex.com>, <vigneshr@ti.com>, <b-padhi@ti.com>
Subject: Re: [PATCH] configs: j784s4_evm : Increase Dynamic memory allocation
 size
Message-ID: <20240717140913.ljhoqn2thiuv2jkf@resemble>
References: <20240715174301.2688466-1-u-kumar1@ti.com>
 <20240716200555.GC85916@francesco-nb>
 <ddef3081-76a2-4985-bc47-9a18bcd7ed93@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ddef3081-76a2-4985-bc47-9a18bcd7ed93@ti.com>
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

On 09:40-20240717, Kumar, Udit wrote:
> Hi Francesco
> 
> On 7/17/2024 1:35 AM, Francesco Dolcini wrote:
> > Hello,
> > 
> > On Mon, Jul 15, 2024 at 11:13:01PM +0530, Udit Kumar wrote:
> > > Increase malloc size to 32 MB to align with other J7
> > > family devices.
> > Is this needed for any specific reason? I am asking to understand if
> > other boards using the same SOC should be updated to prevent
> > $random_issue.
> 
> In our downstream version, we are seeing an issue , while using DFU to MMC
> 
> Please see
> 
> https://gist.github.com/uditkumarti/b8209f61eff3154f6eb288ba63715263#file-gistfile1-txt-L82
> 
> 
> 
> Since DFU is not supported yet in mainline u-boot, so I avoided to mention
> that failure.
> 
> Also this change is generic, so i thought of pushing it now instead of
> waiting for DFU series.

if we are going to repeat this over and over - does it make sense to
have this in include? so that *other* board manufacturers do not need to
re-discover this?


-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

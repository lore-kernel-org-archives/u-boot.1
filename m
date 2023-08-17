Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C486EB64DD
	for <u-boot@archiver.kernel.org>; Thu, 17 Aug 2023 11:47:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C1D586AE5;
	Thu, 17 Aug 2023 13:47:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="wVPn7Njd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6261B86AE6; Thu, 17 Aug 2023 13:47:49 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF55E86ADB
 for <u-boot@lists.denx.de>; Thu, 17 Aug 2023 13:47:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37HBliOI071713;
 Thu, 17 Aug 2023 06:47:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1692272864;
 bh=s1RJt4ol1SOig/EgPpUNOYetK93bI5p5NWkuDdjVRvY=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=wVPn7Njdy2w7itnGvJ/7888+EYPxW+b9bildX4Ak5/771mkZ+R1ALASeaWybPdGM6
 e5Dn9Y4O32OXVgODaKj1EGFu6vZuulRVVuFIvtUF09FsxkJDhqE95Lselz1CaxU16m
 hwkfqcRJuzz+LT/UebPxwAmRUg9+kP2PLnglPARI=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37HBliWl004239
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 17 Aug 2023 06:47:44 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 17
 Aug 2023 06:47:44 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 17 Aug 2023 06:47:44 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37HBlima099188;
 Thu, 17 Aug 2023 06:47:44 -0500
Date: Thu, 17 Aug 2023 06:47:44 -0500
From: Nishanth Menon <nm@ti.com>
To: Manorit Chawdhry <m-chawdhry@ti.com>
CC: Tom Rini <trini@konsulko.com>, <u-boot@lists.denx.de>, Neha Malcom Francis
 <n-francis@ti.com>, Udit Kumar <u-kumar1@ti.com>,
 Andrew Davis <afd@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH 3/3] docs: ti: j721s2_evm: Create documentation from
 J7200 docs
Message-ID: <20230817114744.uqrh2oxnm553bu2t@mummy>
References: <20230816-b4-upstream-j721s2-r5-pinmux-v1-0-f4548452760a@ti.com>
 <20230816-b4-upstream-j721s2-r5-pinmux-v1-3-f4548452760a@ti.com>
 <20230816153503.up6ercmspho3oop6@jigsaw>
 <20230817081214.m6xxym6y2imtseux@ula0497581>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230817081214.m6xxym6y2imtseux@ula0497581>
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

On 13:42-20230817, Manorit Chawdhry wrote:
[...]
> 
> Ah yes, I hadn't found the board specific MAINTAINER file. 
> 
> Can you suggest whom to keep the MAINTAINER for J721S2? The previous 
> maintainer seems stale, Aswath Govindraju <a-govindraju@ti.com> is no 
> longer in TI. Let me know if I can take the ownership for J721S2.

Please propose as a patch if you are able to volunteer.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

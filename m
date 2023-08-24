Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E3A0C6FA8F
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 12:26:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 688E8846C0;
	Thu, 24 Aug 2023 14:26:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="gLpBuJsy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 61AF88477A; Thu, 24 Aug 2023 14:26:44 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A8DC783F7D
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 14:26:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37OCQMXD121452;
 Thu, 24 Aug 2023 07:26:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1692879982;
 bh=VxWMTYdF4yUxZ9H1HdXvGy1JTkGt6s32Y9FEtgIKXQ8=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=gLpBuJsy1Q2iz1DZ0uxl4OnlA79f0jnkg2VUFizeusvdW/rg3GsfzxMoWyEodtGSf
 gxhneEao7OzGx+ovahBGp8s8dT7kATUAKaCC0x9uSlIzJdIRrJWol5gGIUsZvUQUdW
 MsUN9DSviT23vKmzZCIRJJjuwGkfmHDn9cfuR7Rs=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37OCQMOq049576
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 24 Aug 2023 07:26:22 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 24
 Aug 2023 07:26:21 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 24 Aug 2023 07:26:21 -0500
Received: from [10.24.68.114] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37OCQG1p122195;
 Thu, 24 Aug 2023 07:26:16 -0500
Message-ID: <66f15744-0b0b-743f-8ad3-8448d78812f6@ti.com>
Date: Thu, 24 Aug 2023 17:56:15 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 0/6] Attempt to enforce standard extensions for build
 output
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>, Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Dillon Min <dillon.minfei@gmail.com>, Ivan
 Mikhaylov <fr0st61te@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Kamil Lulko <kamil.lulko@gmail.com>, Marek Vasut <marex@denx.de>,
 Michael Walle <michael@walle.cc>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Patrick
 Delaunay <patrick.delaunay@foss.st.com>, Peng Fan <peng.fan@nxp.com>,
 Philippe Reynes <philippe.reynes@softathome.com>, Stefan Herbrechtsmeier
 <stefan.herbrechtsmeier@weidmueller.com>, Vikas Manocha
 <vikas.manocha@st.com>, <u-boot@dh-electronics.com>,
 <uboot-stm32@st-md-mailman.stormreply.com>, Nishanth Menon <nm@ti.com>,
 "Raghavendra, Vignesh" <vigneshr@ti.com>
References: <20230824030304.1555547-1-sjg@chromium.org>
Content-Language: en-US
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <20230824030304.1555547-1-sjg@chromium.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
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

Hi Simon

+ Vignesh, Nishanth to comment on this as well

On 24/08/23 08:32, Simon Glass wrote:
> In this early stage of using binman to produce output files, we are mostly
> seeing people using common extensions such as '.bin' and '.rom'

[...]

> The fact that the .pem files are at the top level means that they are
> output images, which surely is not intended. They should be buried in the
> image description, at a lower level, as part of something else.
> 
> So please take a loke at the above and see if the binman descriptions can
> be reworked slightly to follow these new rules.
> 

I think this can work... but few concerns.

1. Our output binaries also include <image>.bin_unsigned, would extensions that 
aren't "standard" be added to the list if they are truly output binaries? If 
not, changing names for them may be a long stretch (pinging Vignesh and Nishanth 
to comment here).

2. Can it be an option to not enforce this, to support users that may make use 
of the intermediate binaries?

Also if we do move forward with this, we will need to sync to make sure that the 
changes to the affected boards come through as well.

-- 
Thanking You
Neha Malcom Francis

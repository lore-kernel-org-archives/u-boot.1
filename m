Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87148F41998
	for <u-boot@archiver.kernel.org>; Wed, 15 Apr 2026 12:45:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BAEA083B99;
	Wed, 15 Apr 2026 14:45:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=norik.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=norik.com header.i=@norik.com header.b="QLdoU6EF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E36583C2B; Wed, 15 Apr 2026 14:45:13 +0200 (CEST)
Received: from cp2.siel.si (cp2.siel.si [46.19.12.180])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED50483936
 for <u-boot@lists.denx.de>; Wed, 15 Apr 2026 14:45:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=norik.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=primoz.fiser@norik.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com; 
 s=default;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=xRNLp+DbXlUXf/drQZSlZfmmSSN3LGsmNwBF0y44RIQ=; b=QLdoU6EFU4wf+bgLRLiSGeeHfS
 ZX0e/onK253GMmsmTg7x6uLYcX4Jo7DQ7bBrV0n/AWyMGJF/oNxs2cHbmWyXUCvHSYM8Yr4bwDLX5
 /C0KjXH0A5/OviuBu/RAv8ih20UGdEsooC4tlceQeXu3fCJFhzo4IjMAiEDE25Nt7C3n/Cy52MDH0
 yn7Icmgbf0OUgRzKSURLifnBYJJNjZt+Lss4yepqU82tTZUfi04z9/y0oCc44+orS15HJcyA9nQwT
 MFGIoEaK/rCkg4B1MLtwgL4kTSgb5RpSx1Fe1dStfs9CEERUnwE7I3gHA9P6O1fPcBlC65c1ZLFT8
 EyvzIdfA==;
Received: from 89-212-21-243.static.t-2.net ([89.212.21.243]:57312
 helo=[192.168.69.116])
 by cp2.siel.si with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
 (Exim 4.99.1) (envelope-from <primoz.fiser@norik.com>)
 id 1wCzcH-000000048Sw-2tdE; Wed, 15 Apr 2026 14:45:10 +0200
Message-ID: <f13a6b0e-7409-468c-a9a2-e597165b1e68@norik.com>
Date: Wed, 15 Apr 2026 14:45:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] imx: imx9: Select ARCH_MISC_INIT for all i.MX9 SoCs
To: Peng Fan <peng.fan@nxp.com>, Stefano Babic <sbabic@nabladev.com>,
 Fabio Estevam <festevam@gmail.com>, dl-uboot-imx <uboot-imx@nxp.com>,
 Tom Rini <trini@konsulko.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "upstream@lists.phytec.de" <upstream@lists.phytec.de>
References: <20260415114658.3321643-1-primoz.fiser@norik.com>
 <DB9PR04MB8461701ACC88F0AE7F5B89CE88222@DB9PR04MB8461.eurprd04.prod.outlook.com>
Content-Language: en-US
From: Primoz Fiser <primoz.fiser@norik.com>
Autocrypt: addr=primoz.fiser@norik.com; keydata=
 xjMEZrROOxYJKwYBBAHaRw8BAQdAADVOb5tiLVTUAC9nu/FUl4gj/+4fDLqbc3mk0Vz8riTN
 JVByaW1veiBGaXNlciA8cHJpbW96LmZpc2VyQG5vcmlrLmNvbT7CiQQTFggAMRYhBK2YFSAH
 ExsBZLCwJGoLbQEHbnBPBQJmtE47AhsDBAsJCAcFFQgJCgsFFgIDAQAACgkQagttAQducE+T
 gAD+K4fKlIuvH75fAFwGYG/HT3F9mN64majvqJqvp3gTB9YBAL12gu+cm11m9JMyOyN0l6Os
 jStsQFghPkzBSDWSDN0NzjgEZrROPBIKKwYBBAGXVQEFAQEHQP2xtEOhbgA+rfzvvcFkV1zK
 6ym3/c/OUQObCp50BocdAwEIB8J4BBgWCAAgFiEErZgVIAcTGwFksLAkagttAQducE8FAma0
 TjwCGwwACgkQagttAQducE8ucAD9F1sXtQD4iA7Qu+SwNUAp/9x7Cqr37CSb2p6hbRmPJP8B
 AMYR91JYlFmOJ+ScPhQ8/MgFO+V6pa7K2ebk5xYqsCgA
Organization: Norik systems d.o.o.
In-Reply-To: <DB9PR04MB8461701ACC88F0AE7F5B89CE88222@DB9PR04MB8461.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - cp2.siel.si
X-AntiAbuse: Original Domain - lists.denx.de
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - norik.com
X-Get-Message-Sender-Via: cp2.siel.si: authenticated_id: primoz.fiser@norik.com
X-Authenticated-Sender: cp2.siel.si: primoz.fiser@norik.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
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

Hi Peng,

On 4/15/26 14:17, Peng Fan wrote:
>> Subject: [PATCH] imx: imx9: Select ARCH_MISC_INIT for all i.MX9 SoCs
>>
>> Instead of adding select ARCH_MISC_INIT for each i.MX 9x SoC, select it
>> at the i.MX9 family Kconfig level. The corresponding arch_misc_init() is
>> already defined in the common arch/arm/mach-imx/imx9/soc.c file
>> and will print out ELE firmware BuildInfo for all i.MX9 SoCs now instead
>> of just
>> i.MX91 and i.MX95.
> 
> This will also make the Kconfig being select for i.MX93 and i.MX94.
> I think this is ok. But please mention that in commit log, then:
> 

I think commit message is already clear here?

"...will print out ELE firmware BuildInfo for all i.MX9 SoCs now..."

Do you think explicitly spelling out each SoC from i.MX9 family will
help anyhow? Then I also have to mention i.MX 952, right? :)

I explicitly mentioned i.MX91 and i.MX95 just because they were already
selecting ARCH_MISC_INIT option.

Anyhow I was only able to test this on i.MX93 since I don't have any
i.MX94 board at hand. But I am pretty confident it should work there too.

Finally, should I send v2 with improved commit message or are you fine
with current explanation?

BR,
Primoz


> Reviewed-by: Peng Fan <peng.fan@nxp.com>
> 
> Regards
> Peng.

-- 
Primoz Fiser
phone: +386-41-390-545
email: primoz.fiser@norik.com
--
Norik systems d.o.o.
Your embedded software partner
Slovenia, EU
phone: +386-41-540-545
email: info@norik.com


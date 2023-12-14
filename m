Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFD33C4332F
	for <u-boot@archiver.kernel.org>; Thu, 14 Dec 2023 20:28:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F91487B07;
	Thu, 14 Dec 2023 21:28:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="BR+rA1UR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B58C87ABA; Thu, 14 Dec 2023 21:28:51 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 80F6C87B22
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 21:28:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3BEKSWuT020788;
 Thu, 14 Dec 2023 14:28:32 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1702585712;
 bh=VYZqLSbUfaJA6Lj0V5pNXKFoYtzAaAPstxjQHHJnHLI=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=BR+rA1URikuFEpsnSQ04Q7nPboKsTTO2yF5VIgQ9psD3TJC126w6A76QgLG5bNbgG
 GQWsJoRvMffgIq6viqXIVrindXxPtHcElI66o/Jv6t54p7PGomqcSewr81jlmNqOqv
 j9X8JJd/Ygoo52xWtJGtXYNMHKlkBTVNILcMKdEA=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3BEKSWsO018252
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 14 Dec 2023 14:28:32 -0600
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 14
 Dec 2023 14:28:31 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 14 Dec 2023 14:28:31 -0600
Received: from [10.247.16.251] (ula0226330.dhcp.ti.com [10.247.16.251])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3BEKSVGe043916;
 Thu, 14 Dec 2023 14:28:31 -0600
Message-ID: <1a97e28b-34ad-44e5-8fbd-ced7a5a69d68@ti.com>
Date: Thu, 14 Dec 2023 14:28:31 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 00/17] Introduce initial TI's J784S4 and AM69 support
Content-Language: en-US
To: "bb@ti.com" <bb@ti.com>, Marcel Ziswiler <marcel.ziswiler@toradex.com>
CC: "jh80.chung@samsung.com" <jh80.chung@samsung.com>,
 "ralph.siemsen@linaro.org" <ralph.siemsen@linaro.org>, "nm@ti.com"
 <nm@ti.com>, "u-kumar1@ti.com" <u-kumar1@ti.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, "n-francis@ti.com" <n-francis@ti.com>,
 "kamlesh@ti.com" <kamlesh@ti.com>, "a-nandan@ti.com" <a-nandan@ti.com>,
 "seanga2@gmail.com" <seanga2@gmail.com>,
 "lukma@denx.de" <lukma@denx.de>, "hnagalla@ti.com" <hnagalla@ti.com>,
 "a-bhatia1@ti.com" <a-bhatia1@ti.com>,
 "m-chawdhry@ti.com" <m-chawdhry@ti.com>, "j-choudhary@ti.com"
 <j-choudhary@ti.com>, "rasmus.villemoes@prevas.dk"
 <rasmus.villemoes@prevas.dk>, "christian.gmeiner@gmail.com"
 <christian.gmeiner@gmail.com>, "marek.vasut+renesas@mailbox.org"
 <marek.vasut+renesas@mailbox.org>, "sinthu.raja@mistralsolutions.com"
 <sinthu.raja@mistralsolutions.com>, "sabiya.d@ti.com" <sabiya.d@ti.com>,
 "sjg@chromium.org" <sjg@chromium.org>, "xypron.glpk@gmx.de"
 <xypron.glpk@gmx.de>, "rogerq@kernel.org" <rogerq@kernel.org>
References: <20231206123753.1486031-1-a-nandan@ti.com>
 <51eeab25314144926eaefaa2e83353ffec9309fe.camel@toradex.com>
 <20231214201019.5bjxb5ki67yjn4ku@bryanbrattlof.com>
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20231214201019.5bjxb5ki67yjn4ku@bryanbrattlof.com>
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

On 12/14/23 2:10 PM, bb@ti.com wrote:
> On December 14, 2023 thus sayeth Marcel Ziswiler:
>> Hi Apurva
>>
>> Thanks!
>>
>> On Wed, 2023-12-06 at 18:07 +0530, Apurva Nandan wrote:
>>> Hello Everyone!
>>>
>>> This series will introduce basic support (SD and UART) support for Texas
>>> Instruments J784S4 EVM.
>>
>> For the whole series:
>>
>> Tested-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
>>
>> However, one thing I noticed is that with upstream TF-A I do get the following errors:
>>
>> NOTICE:  BL31: v2.10.0  (release):v2.10.0-76-g02091541d
>> NOTICE:  BL31: Built : 18:13:08, Dec 14 2023
>> ERROR:   Failed to get response (-19)
>> ERROR:   Transfer send failed (-19)
>> ERROR:   Unable to query firmware capabilities (-19)
>>
>> While with latest TF-A from downstream TI BSP (both 9.0 and 9.1 use the same versin) I do not get any errors:
>>
>> NOTICE:  BL31: v2.9(release):v2.9.0-614-gd7a7135d3
>> NOTICE:  BL31: Built : 18:40:38, Dec 14 2023
>>
> 
> What version of TIFS are you running? Not getting a response usually
> means firmware is dead or we're not using the right thread to talk.
> 

In this case the early versions of TIFS/DM for J784S4/AM69 had
a bug where the "query firmware capabilities" API was left disabled.
This is fixed in the next version of firmware, this error message
is harmless today anyway (no LPM yet).

Andrew

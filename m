Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A674C46CA2
	for <u-boot@archiver.kernel.org>; Fri, 15 Dec 2023 14:52:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 28F2087C24;
	Fri, 15 Dec 2023 15:52:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="hddY5dH6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BBB8C87C28; Fri, 15 Dec 2023 15:52:02 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D50D87C24
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 15:51:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3BFEpmur026820;
 Fri, 15 Dec 2023 08:51:48 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1702651908;
 bh=1XtT6eVQtPt+nlS6qUJw7zrSNgvFMRdxFLGZDUbjJOs=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=hddY5dH6fQ1YT0YqcdB9gFWu0yrVDbja8ghVX0AC4of2/0IC6J4eqRT14qdf18xQh
 IFNKLLlH7qXzuTJiLE1/Uz1UDCM3k0S7cwSfVgR3b2sh9w8kIrcnoyEGHuykwCsw7E
 kKQNnRJM1BaE2sxzM3xwFglPIu89Wk9RpnwdAryM=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3BFEpmDX051527
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 15 Dec 2023 08:51:48 -0600
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 15
 Dec 2023 08:51:48 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 15 Dec 2023 08:51:47 -0600
Received: from [10.247.16.251] (ula0226330.dhcp.ti.com [10.247.16.251])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3BFEpljq078351;
 Fri, 15 Dec 2023 08:51:47 -0600
Message-ID: <1f2ffe78-2771-4ff7-be74-ab8ef92adf05@ti.com>
Date: Fri, 15 Dec 2023 08:51:47 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 00/17] Introduce initial TI's J784S4 and AM69 support
To: Marcel Ziswiler <marcel.ziswiler@toradex.com>, "bb@ti.com" <bb@ti.com>
CC: "jh80.chung@samsung.com" <jh80.chung@samsung.com>, "sjg@chromium.org"
 <sjg@chromium.org>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "n-francis@ti.com" <n-francis@ti.com>, "kamlesh@ti.com" <kamlesh@ti.com>,
 "marek.vasut+renesas@mailbox.org" <marek.vasut+renesas@mailbox.org>,
 "a-nandan@ti.com" <a-nandan@ti.com>, "j-choudhary@ti.com"
 <j-choudhary@ti.com>, "lukma@denx.de" <lukma@denx.de>, "hnagalla@ti.com"
 <hnagalla@ti.com>, "a-bhatia1@ti.com" <a-bhatia1@ti.com>,
 "m-chawdhry@ti.com" <m-chawdhry@ti.com>,
 "seanga2@gmail.com" <seanga2@gmail.com>,
 "rasmus.villemoes@prevas.dk" <rasmus.villemoes@prevas.dk>,
 "christian.gmeiner@gmail.com" <christian.gmeiner@gmail.com>,
 "sinthu.raja@mistralsolutions.com" <sinthu.raja@mistralsolutions.com>,
 "nm@ti.com" <nm@ti.com>, "ralph.siemsen@linaro.org"
 <ralph.siemsen@linaro.org>, "u-kumar1@ti.com" <u-kumar1@ti.com>,
 "sabiya.d@ti.com" <sabiya.d@ti.com>,
 "rogerq@kernel.org" <rogerq@kernel.org>,
 "xypron.glpk@gmx.de" <xypron.glpk@gmx.de>
References: <20231206123753.1486031-1-a-nandan@ti.com>
 <51eeab25314144926eaefaa2e83353ffec9309fe.camel@toradex.com>
 <20231214201019.5bjxb5ki67yjn4ku@bryanbrattlof.com>
 <1a97e28b-34ad-44e5-8fbd-ced7a5a69d68@ti.com>
 <b8777dbd0fae3ce00f41e00601cc8ad62b171b87.camel@toradex.com>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <b8777dbd0fae3ce00f41e00601cc8ad62b171b87.camel@toradex.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
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

On 12/15/23 2:51 AM, Marcel Ziswiler wrote:
> On Thu, 2023-12-14 at 14:28 -0600, Andrew Davis wrote:
>> On 12/14/23 2:10 PM, bb@ti.com wrote:
>>> On December 14, 2023 thus sayeth Marcel Ziswiler:
>>>> Hi Apurva
>>>>
>>>> Thanks!
>>>>
>>>> On Wed, 2023-12-06 at 18:07 +0530, Apurva Nandan wrote:
>>>>> Hello Everyone!
>>>>>
>>>>> This series will introduce basic support (SD and UART) support for Texas
>>>>> Instruments J784S4 EVM.
>>>>
>>>> For the whole series:
>>>>
>>>> Tested-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
>>>>
>>>> However, one thing I noticed is that with upstream TF-A I do get the following errors:
>>>>
>>>> NOTICE:  BL31: v2.10.0  (release):v2.10.0-76-g02091541d
>>>> NOTICE:  BL31: Built : 18:13:08, Dec 14 2023
>>>> ERROR:   Failed to get response (-19)
>>>> ERROR:   Transfer send failed (-19)
>>>> ERROR:   Unable to query firmware capabilities (-19)
>>>>
>>>> While with latest TF-A from downstream TI BSP (both 9.0 and 9.1 use the same versin) I do not get any
>>>> errors:
>>>>
>>>> NOTICE:  BL31: v2.9(release):v2.9.0-614-gd7a7135d3
>>>> NOTICE:  BL31: Built : 18:40:38, Dec 14 2023
>>>>
>>>
>>> What version of TIFS are you running? Not getting a response usually
>>> means firmware is dead or we're not using the right thread to talk.
>>>
>>
>> In this case the early versions of TIFS/DM for J784S4/AM69 had
>> a bug where the "query firmware capabilities" API was left disabled.
>> This is fixed in the next version of firmware, this error message
>> is harmless today anyway (no LPM yet).
> 
> No, I was always running the latest from the ti-linux-firmware branch:
> 
> SYSFW ABI: 3.1 (firmware rev 0x0009 '9.1.2--v09.01.02 (Kool Koala)')
> 
> So, it is really TF-A which seems to cause the issue here.
> 

When I said "fixed in the next version" I meant the next to
be released, as in not yet out (I'd guess out in a week or so).
Sorry for any confusion here.

I added support for this new API to TF-A only recently,
which is why the old TF-A versions don't print this error.
Nishanth gives more details in the other thread, but as
said this error is harmless and will go away in with
the next firmware update.

Andrew

>> Andrew
> 
> Cheers
> 
> Marcel

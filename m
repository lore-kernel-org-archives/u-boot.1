Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AB26E77197
	for <u-boot@archiver.kernel.org>; Thu,  9 Jan 2025 07:12:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 51FE4801FD;
	Thu,  9 Jan 2025 08:12:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="sYO9mukJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A0B68801F5; Thu,  9 Jan 2025 08:12:20 +0100 (CET)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F2F5B80085
 for <u-boot@lists.denx.de>; Thu,  9 Jan 2025 08:12:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=c-vankar@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 5097C6BL3227773
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 9 Jan 2025 01:12:06 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1736406726;
 bh=aAr/uVkpvU8Ic44FiRIMhSH61t7BpRJo+S4CJrwYh+0=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=sYO9mukJyS9NarUahOoWJwohsNE1KLwNyEUCX6EQR0RrBvmBxe4aHq0/U+ll81jDI
 XtuJ3fMw5vrKWOrVYK1rQtawArirbmRl02dIxrj2gdZ64mS2/coviGmCV5mprduOiF
 nybBOkjifodrzxaljlhsPouctoi8FQrtE9q6zBf4=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 5097C6Wo008423
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 9 Jan 2025 01:12:06 -0600
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 9
 Jan 2025 01:12:06 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 9 Jan 2025 01:12:05 -0600
Received: from [10.249.135.49] ([10.249.135.49])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 5097BvO5067884;
 Thu, 9 Jan 2025 01:11:57 -0600
Message-ID: <91021f80-2d2e-47f9-bdad-a652ebea7986@ti.com>
Date: Thu, 9 Jan 2025 12:41:56 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/13] net: tftp: Increase TFTP pkt string length to
 include null character
To: Tom Rini <trini@konsulko.com>
CC: AKASHI Takahiro <akashi.tkhro@gmail.com>, Mikhail Kshevetskiy
 <mikhail.kshevetskiy@iopsys.eu>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Sughosh Ganu
 <sughosh.ganu@linaro.org>, Nishanth Menon <nm@ti.com>, Roger Quadros
 <rogerq@kernel.org>, Hari Nagalla <hnagalla@ti.com>, Jonathan Humphreys
 <j-humphreys@ti.com>, Andreas Dannenberg <dannenberg@ti.com>, Simon Glass
 <sjg@chromium.org>, Jayesh Choudhary <j-choudhary@ti.com>, Aniket Limaye
 <a-limaye@ti.com>, Aradhya Bhatia <a-bhatia1@ti.com>, Neha Malcom Francis
 <n-francis@ti.com>, Andrew Davis <afd@ti.com>, Ramon Fried
 <rfried.dev@gmail.com>, Joe Hershberger <joe.hershberger@ni.com>, "Bryan
 Brattlof" <bb@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, Manorit
 Chawdhry <m-chawdhry@ti.com>, <srk@ti.com>,
 <s-vadapalli@ti.com>, <danishanwar@ti.com>, <u-boot@lists.denx.de>
References: <20250107093840.2211381-1-c-vankar@ti.com>
 <20250107093840.2211381-2-c-vankar@ti.com>
 <20250107142258.GH3476@bill-the-cat>
Content-Language: en-US
From: "Vankar, Chintan" <c-vankar@ti.com>
In-Reply-To: <20250107142258.GH3476@bill-the-cat>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
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



On 1/7/2025 7:52 PM, Tom Rini wrote:
> On Tue, Jan 07, 2025 at 03:08:28PM +0530, Chintan Vankar wrote:
> 
>> 'sprintf()' function defined in 'tiny-printf.c' is returning length of the
>> string excluding null character. Fix this by increasing TFTP pkt length by
>> 1 to avoid TFTP error of request being not-null terminated while
>> requesting length of packet.
>>
>> Signed-off-by: Chintan Vankar <c-vankar@ti.com>
> 
> Erm, if tiny-printf's sprintf doesn't work like lib/vsprintf.c's sprintf
> in this regard, we should be fixing tiny-printf.
> 

Hello Tom, I have observed that 'sprintf()' defined in lib/vsprintf.c
at here:
https://github.com/torvalds/linux/blob/master/lib/vsprintf.c#L3035
also behaves the same way, that returns length of the string excluding
null character.


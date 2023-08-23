Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C220DC3DA6F
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 20:31:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 194AB864CB;
	Wed, 23 Aug 2023 22:31:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1692822671;
	bh=PZqSSNV3gduXseSOzMczvP+Tg73PWjOaXDx0uf8KJ3E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mKaIkAZXdVgUITPx1jXgzqfXVaWogmEbAnj1OLW4Cp5jTeuq+SoPMhu+KDYV/Qr52
	 gmIPSsuFCXXVLavnE/u9c4F1ZHCW7YL1/NGtp8UHakwCnQQ95zBBRKiLby2wP/up0I
	 dUfGI7+51HjhGr++/AWsA0CCueENh0+JVriFXBiWUZSc5BOehquFK/z18yScOA8TZ7
	 5pUw99Q+Yb1BMmVo5zhaPPFrk269nBe5TwX3kc98dcdDePHeltmpcaM/dsiP+okU1B
	 6QOYUQZ1skjufPOWeUIKR97JS0kAwDdWQ+llL0ezWtCfBv6Arc1NXWJ/CIFYCtSIB6
	 PW/cwoa0p4tzg==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 16E268640E;
 Wed, 23 Aug 2023 22:31:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1692822670;
 bh=PZqSSNV3gduXseSOzMczvP+Tg73PWjOaXDx0uf8KJ3E=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=XeDDvhkADx6wteC0uvGCEZyRSjC/1A4C1I0uKqFTuPrkBcMV3EZG6DYEG/sZUN2Rn
 zjulkhAe6R0IJIEok0vhxVuwvoROkjquUJnsWogFU3NxuKwRde9AMyu1rtlqzOtQSX
 no4bvsLNZ27HcEdhEhnqKKAzn1cVMPQYX6qCDE3OmQW6QbUaRBZL/m1Lq+oU7SCwg0
 M/DwCaBwl0dajEsoBW/shBylRr5RH8k0yIsqUI4HQx78rka9voFEO+PVj9Qq9nfdc8
 IvdyNWg9IIRt4xnO4LYWa3et4NJGKvyVnBMKYXqhqRNKPRjAaCAoP8VHCSHqAcg8Zt
 vx//LIW18sL3w==
Message-ID: <43d7298d-682b-5011-f76c-7d951fbfe065@denx.de>
Date: Wed, 23 Aug 2023 22:31:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 1/1] doc: describe TPL/VPL/SPL boot
Content-Language: en-US
To: =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Mayuresh Chitale <mchitale@ventanamicro.com>, Stefan Roese <sr@denx.de>,
 Sean Anderson <sean.anderson@seco.com>, Bin Meng <bmeng.cn@gmail.com>,
 u-boot@lists.denx.de
References: <20230823195728.39438-1-heinrich.schuchardt@canonical.com>
 <20230823201400.m4l6hl7zy6x6srzd@pali>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20230823201400.m4l6hl7zy6x6srzd@pali>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 8/23/23 22:14, Pali Rohár wrote:
> On Wednesday 23 August 2023 21:57:28 Heinrich Schuchardt wrote:
>> +Booting from TPL/SPL
>> +====================
>> +
>> +The main U-Boot binary may be to large to be loaded directly by the Boot ROM.
>> +This was the main driver for splitting up U-Boot into multiple boot stages with
>> +successively larger binaries.
>> +
>> +U-Boot typically goes through the following boot phases where TPL, VPL, and SPL
>> +are optional. While many boards use SPL only few use TPL.
>> +
>> +TPL
>> +   Very early init, as tiny as possible. This loads SPL (or VPL if enabled).
> 
> This is not truth. SPL loads TPL. Or at least it was about year ago for powerpc plat.

It goes both ways.
- It can be either TPL as the Tiny Program Loader, usually hand-rolled 
in assembly, used e.g. on OneNAND devices to fit into the OneNAND memory 
mapped window and used to load the next stage (SPL) from that OneNAND 
memory into SoC SRAM, and then jump to that next stage.
- It can be SPL that loads TPL as Tertiary Program Loader , apparently 
on PPC.

>> +VPL
>> +   Optional verification step, which can select one of several SPL binaries,
>> +   if A/B verified boot is enabled. Implementation of the VPL logic is
>> +   work-in-progress. For now it just boots into SPL.
>> +
>> +SPL
>> +   Secondary program loader. Sets up SDRAM and loads U-Boot proper. It may also
>> +   load other firmware components.
> 
> SPL initializes NAND then loads TPL from NAND, TPL initialize DDR and then loads U-Boot.

Nope.

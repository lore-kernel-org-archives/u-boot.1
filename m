Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 820CCC4345F
	for <u-boot@archiver.kernel.org>; Sun, 14 Apr 2024 21:25:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A02D787F00;
	Sun, 14 Apr 2024 23:25:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1713129909;
	bh=xUsO84cLafhyncvZzjdllueln0o191l+VDmOFUwnLpQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0CclHooSnijQXH4IQa/zl2odGgN/WLifVRNOzSQX1tglivVqn4kGAD2XNxqFyIFWp
	 WKxqTA4HxiuyfXkMzcYMPP5Mc2lqx83nwNBD7K4eJjSdiLRA02Gt+rO6BXlTs/M13s
	 Z3BnKeChj3IWfCR1S7f3IEONcb3WE0fBGIQ8IsVwv12B7prQIobVe1vSMkCAFQTpBI
	 yzUTi1yRYQXgxGGYbGBpGJKlPtD+cHttkOyXDqfuqU9GHsrxOj1Nd8hEppup8NaG9/
	 stTYqrl+ensvKjotjT6p4otW+TYLtlmbCHAP9BzI8c2uuNPN8HgkAobmCsG/VuJLJm
	 4Mw23mO8rMj/w==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 78AF187F00;
 Sun, 14 Apr 2024 23:25:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1713129907;
 bh=xUsO84cLafhyncvZzjdllueln0o191l+VDmOFUwnLpQ=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=ptA78cE+TBki2vwIdCA3abmsUkbOvUXBhg1aw+9bDbtEAWdI+SwH7Vb1k8l4TQY16
 M5dpysOWMdPhbkTSw77rCTSL8CB+vTCCGh27ljAnRqWw/+uAfnl9wcM0cEgesN4XS2
 +QXQcjhZFoTdnyduxBCJjmVHlOlGoAzQGhxQM2H7/ViFopRPjBu9H94jQdWn8Y9LyG
 roivEPwBQxKtK6/RfX43e7ju83FdlSqqbP+X9vj2JqejlJagCSDgTOFdt/+hMPpoi3
 pgp85zYb90H9wQG8zq/OBEkJ+8NA1r10LjWw962cVdASiCX5qsJINgN+sAfHvq49+D
 sZ++C56Bl0SMg==
Message-ID: <a881fc20-c555-40b9-9ee7-ea28c4913dda@denx.de>
Date: Sun, 14 Apr 2024 23:25:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] boot: fdt: Turn all addresses and sizes into u64
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: u-boot@lists.denx.de,
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
References: <20240414183759.146925-1-marex@denx.de>
 <20240414192904.GA7117@pendragon.ideasonboard.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240414192904.GA7117@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 4/14/24 9:29 PM, Laurent Pinchart wrote:
> Hi Marek,
> 
> Thank you for the patch.
> 
> On Sun, Apr 14, 2024 at 08:37:20PM +0200, Marek Vasut wrote:
>> In case of systems where DRAM bank ends at the edge of 32bit boundary,
>> start + size calculations would overflow. This happens on STM32MP15xx
>> with 1 DRAM bank starting at 0xc0000000 and 1 GiB of DRAM. This is a
>> usual 32bit system DRAM size overflow, fix it by doing all DRAM size
>> and offset calculations using u64 types.
> 
> I'm not sure I like this much, as it removes a useful indication
> regarding what the variables store.

That's what the variable name is for, not variable type.

> Wouldn't it be better if the code's
> logic could be modified to avoid those overflows ?

I'd prefer to keep the code simple and blanket avoid the overflows for a 
very long time, rather than play whack-a-mole with various odd corner 
cases here.

Note that this is a fix for a previous series which changed from 
u64/ulong to phys_addr/size_t , which clearly was incorrect .

>> This also covers a case where
>> a 32bit PAE system might be able to address up to 36bits of DRAM.
> 
> Shouldn't phys_addr_t be a 64-bit type on PAE systems ?

That depends on CONFIG_PHYS_64BIT , on am57xx this is not set for 
example, so there phys_addr_t is 32bit .

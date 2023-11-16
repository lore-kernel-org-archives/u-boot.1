Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD698C47071
	for <u-boot@archiver.kernel.org>; Thu, 16 Nov 2023 20:42:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CBFE18718B;
	Thu, 16 Nov 2023 21:42:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="el7EPrYP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A06B686ED6; Thu, 16 Nov 2023 21:42:37 +0100 (CET)
Received: from madras.collabora.co.uk (madras.collabora.co.uk
 [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B958286D2E
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 21:42:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=collabora.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eugen.hristev@collabora.com
Received: from [100.94.55.57] (cola.collaboradmins.com [195.201.22.229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: ehristev)
 by madras.collabora.co.uk (Postfix) with ESMTPSA id BCF966607349;
 Thu, 16 Nov 2023 20:42:29 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1700167350;
 bh=JeMWTAi33wg/eu6CuTWulsmfhkFBpySZTZRH0cg7AYU=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=el7EPrYPGTHcSZSZD+UPtFpTg6rrnjv5pK6hMcYFZfhVIS7o4qSoxTXJzoDKY+myC
 CFGEmv4c2vsAg31+5P6piMLFwABtzzhIX/9Se8Hks59u5aKRUjIpf+RWLvVAvXAYVu
 UyfWgenE1/a/NRVjFj2m6xw2eXh1tlCElT94agWVeJSW4jPqIjL2nn7/jwLV2HM7QQ
 DSUsaOaF0taw+xJ5BirwQ99uI2yP6Vfc73vcsiN+wL37lVJWdF1Htr+bAOT0EMvwlo
 +C17tBqoTNCMDZMLuS0CsacSzdmCuz/dwcbGZlK/057zrPDNzZ4rQ4NGEHsWnGA2Gz
 PP1qmmPlSSBTg==
Message-ID: <4906942a-8140-4264-afaa-3072f2eaed98@collabora.com>
Date: Thu, 16 Nov 2023 22:42:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm: Enable SYS_THUMB_BUILD on AT91
To: Tom Rini <trini@konsulko.com>, Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de, Nicolas Ferre <nicolas.ferre@microchip.com>,
 Aubin.Constans@microchip.com, Mihai Sain <mihai.sain@microchip.com>
References: <20231105022742.632175-1-seanga2@gmail.com>
 <20231116184702.GA344953@bill-the-cat>
Content-Language: en-US
From: Eugen Hristev <eugen.hristev@collabora.com>
In-Reply-To: <20231116184702.GA344953@bill-the-cat>
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

On 11/16/23 20:47, Tom Rini wrote:
> On Sat, Nov 04, 2023 at 10:27:42PM -0400, Sean Anderson wrote:
> 
>> Several AT91 boards are quite close to their SPL size limit. For example,
>> sama5d27_wlsom1_ek_mmc is just 173 bytes short of its limit and doesn't
>> even fit with older GCCs.
>>
>> All AT91 processors should have thumb support. Enable SYS_THUMB_BUILD. This
>> shrinks SPL by around 30%.
>>
>> Signed-off-by: Sean Anderson <seanga2@gmail.com>
>> ---
>> This has been BUILD TESTED ONLY!
> 
> We in turn need this for Sean's other cleanup series to go in. Is this
> OK? Would it be safer if it was only for CPU_V7A ? I do have
> recollections of thumb being sometimes buggy prior to v7a cores. Thanks!
> 

Hi Tom,

I would like this to be tested on a few boards at least. There are 
boards with Cortex A5, A7 and ARM926 which are important, one of each of 
them and booting Linux should be enough I think.
Nicolas, Aubin ? I remember you guys have also a CI tool that is fairly 
easy to use if you just push a branch/commit.

+ Mihai as well.

Eugen

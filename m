Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43D51D12D72
	for <u-boot@archiver.kernel.org>; Mon, 11 Nov 2024 06:00:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C12ED891AC;
	Mon, 11 Nov 2024 07:00:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1731304822;
	bh=NxbyTWfzDFVlIBTxQJXMjVT0AIxTy0AW2s83UFkZSP0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=trb3IYuPdnPa63Q+7/mKKTF2D1Z7LwMYZbQCiltPQ7jrf8In13VbpGrUCj+jzG93r
	 85zcCsgaBfjomRZJnP0ppTdHZvzytSOKaRiYHHR5C+kDu3glmqg1SBWSQUTKHEToDh
	 NR2CykKr44RDPQ3BFEExXM8f+CaeL5FvblEJZdIdLroc6AnhmeQeDpLgbUQkZSpadM
	 VZgCc/cmZDpq2Di7PQmW/HKccLrcEE1JSyTIBkXJE+JKgKRb/Gv9J+v6WBl+0JT3M1
	 PIU/OBIKdBcp+ggldSMFCBTsGOvkSip3+AiujTZ14sUTonL5uME8V45f12o34yPaWk
	 RtMpw5JS+NfYg==
Received: from [192.168.1.107] (87-97-106-70.pool.digikabel.hu [87.97.106.70])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id EC6A58911D;
 Mon, 11 Nov 2024 07:00:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1731304821;
 bh=NxbyTWfzDFVlIBTxQJXMjVT0AIxTy0AW2s83UFkZSP0=;
 h=Date:Subject:To:Cc:References:Reply-To:From:In-Reply-To:From;
 b=UnNpVL8Zi0UJOBYyc52X8Wl9r9TIMK0VedJNvi4h+Bdpr1HC4qY56eQLtDZKNxUce
 jsGfl54LTQKJJBpSKxlNfXVWQMm2EwsCE+tGz7yOqsU3/a3fPJVFtNKHZj122anOab
 zZbZ9NwRBXzAvgefoNrMY1iP0APUT1tXgJqT7CoWk8AuOq+HjWYLFZ6YXBsbjGcFEq
 fcQGtZWYrJKsva6c4KOiQxxe5A5K59tZwTCIbfFBqwSCDwEa225niOYpMZK7uLf04M
 zyfS3f/lp+0oH8mKHe6VC+SHq1uwNAu3oK4nAMcb/3i0EFLTcFtyzezECRqPpPgn+s
 y4CP29SqECdnA==
Message-ID: <3e484e5f-07c3-7317-370f-1ff77b674beb@denx.de>
Date: Mon, 11 Nov 2024 06:57:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v1 17/22] siemens: capricorn: add HW version information
 to boot log
Content-Language: en-US
To: Fabio Estevam <festevam@gmail.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Enrico Leto <enrico.leto@siemens.com>,
 Walter Schweizer <walter.schweizer@siemens.com>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Alessandro Zini <alessandro.zini@siemens.com>,
 Anatolij Gustschin <agust@denx.de>, Michal Simek <michal.simek@amd.com>,
 Nishanth Menon <nm@ti.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
References: <20241108052143.26874-1-hs@denx.de>
 <20241108052143.26874-18-hs@denx.de>
 <CAOMZO5CaibRaKg6N+70B3BmzsN3oJcC1-4okpbV6oU1KA7WWeA@mail.gmail.com>
From: Heiko Schocher <hs@denx.de>
In-Reply-To: <CAOMZO5CaibRaKg6N+70B3BmzsN3oJcC1-4okpbV6oU1KA7WWeA@mail.gmail.com>
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
Reply-To: hs@denx.de
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hello Fabio,

On 09.11.24 13:09, Fabio Estevam wrote:
> On Fri, Nov 8, 2024 at 2:24 AM Heiko Schocher <hs@denx.de> wrote:
>>
>> Add the HW version read directly from EEPROM.
>>
>> EEPROM chip data structure is now in a .h file common to draco
>> and capricorn.
>>
>> Therefore move out the definitions in drace board to siemens
> 
> s/drace/draco
> 
>> common place.
>>
>> Signed-off-by: Alessandro Zini <alessandro.zini@siemens.com>
>> Signed-off-by: Heiko Schocher <hs@denx.de>
> 
> It's not clear to me who the author of this patch is. If it is
> Alessandro, then a From line with his name is missing.
> 
> Please clarify.

It is from Alessandro, I will add it in next version, thanks!

bye,
Heiko
-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de

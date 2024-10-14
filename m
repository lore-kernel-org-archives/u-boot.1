Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AD05CF2590
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 04:34:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 02B9888CEA;
	Mon, 14 Oct 2024 06:34:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Wrkdm01H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB95488AB2; Mon, 14 Oct 2024 06:34:41 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 703F288CEA
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 06:34:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 49E4YXWg043731;
 Sun, 13 Oct 2024 23:34:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1728880473;
 bh=DmU+Xv+MNWptto7vSfHcv0132dapokV19rJ9Inbah+A=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=Wrkdm01HvEMo11YRQydhBlK81XaG8jHAIpPZwKW+79EH9Pbvkmb9RoyVnV8harNau
 7uUMdOKWGbF9AT6Bh7uFK4R1sCWCQXVdEBsRq3dBLSQ5nN5dl38aZiVIxJP20m46YD
 ovC3v13P+Aso9cauXHY5EvYZw3zZaFoKCJ1CZyOA=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49E4YXwe035515;
 Sun, 13 Oct 2024 23:34:33 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 13
 Oct 2024 23:34:33 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 13 Oct 2024 23:34:33 -0500
Received: from [172.24.227.36]
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.227.36]
 (may be forged))
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49E4YUoI046387;
 Sun, 13 Oct 2024 23:34:30 -0500
Message-ID: <862d2389-8509-4599-a276-18d125f3e068@ti.com>
Date: Mon, 14 Oct 2024 10:04:29 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] boardf: Modify DRAM message
To: Simon Glass <sjg@chromium.org>, "Raghavendra, Vignesh" <vigneshr@ti.com>, 
 Tom Rini <trini@konsulko.com>
CC: <devarsht@ti.com>, <jonas@kwiboo.se>, <richard@nod.at>,
 <raymond.mao@linaro.org>, <u-kumar1@ti.com>, <u-boot@lists.denx.de>
References: <20241010070909.288313-1-n-francis@ti.com>
 <CAFLszTjJ1GJNd5Fn8U2O5WSnKMn99XW_pGLmejkYy_PBfxSEGg@mail.gmail.com>
Content-Language: en-US
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <CAFLszTjJ1GJNd5Fn8U2O5WSnKMn99XW_pGLmejkYy_PBfxSEGg@mail.gmail.com>
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

Hi Simon

+ Vignesh

On 11/10/24 00:20, Simon Glass wrote:
> Hi Neha,
> 
> On Thu, 10 Oct 2024 at 01:09, Neha Malcom Francis <n-francis@ti.com> wrote:
>>
>> The message "DRAM:  2 GiB (effective 32 GiB)" can be a little confusing,
>> modify the message to show exactly what is meant:
>>
>> "DRAM:  2 GiB (available for U-Boot out of total 32 GiB)"
>>
>> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
>> ---
>>   common/board_f.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/common/board_f.c b/common/board_f.c
>> index 154675d0e40..b7add8f7d3d 100644
>> --- a/common/board_f.c
>> +++ b/common/board_f.c
>> @@ -254,7 +254,7 @@ static int show_dram_config(void)
>>
>>          print_size(gd->ram_size, "");
>>          if (!sizes_near(gd->ram_size, size)) {
>> -               printf(" (effective ");
>> +               printf(" (available for U-Boot out of total ");
>>                  print_size(size, ")");
>>          }
>>          board_add_ram_info(0);
>> --
>> 2.34.1
>>
> 
> I've forgotten why the first number can be so much lower than the
> second. What is causing that?
> 

AFAIK, U-Boot supports up to 39-bit addressing and possibly since there are 
systems that have RAM sizes exceeding 39-bit, addressing has been capped to the 
first bank to avoid any possible problems. So U-Boot sets gd->ram_size to the 
first bank while it acknowledges that the system RAM is more than that. Tom can 
probably confirm if this is right.

In an offline discussion with Vignesh, he mentioned that a cleaner solution 
would be to extend out fdtdec_* functions to support all memory within a 39-bit 
address space.

> This is quite a long string...could we say "(total 32 GiB)" ? Then
> perhaps add something to doc/ to talk about the banner that U-Boot
> prints?
> 
> Regards,
> Simon

-- 
Thanking You
Neha Malcom Francis

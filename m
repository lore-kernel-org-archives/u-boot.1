Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46042C02192
	for <u-boot@archiver.kernel.org>; Tue,  4 Feb 2025 01:15:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 733A7800C1;
	Tue,  4 Feb 2025 02:15:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=freemail.hu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=freemail.hu header.i=@freemail.hu header.b="GnwY4Ex+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A782800CF; Tue,  4 Feb 2025 02:15:29 +0100 (CET)
Received: from smtp-out.freemail.hu (fmfe26.freemail.hu [46.107.16.231])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 15E2C80050
 for <u-boot@lists.denx.de>; Tue,  4 Feb 2025 02:15:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=freemail.hu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=egyszeregy@freemail.hu
Received: from [192.168.0.16] (catv-178-48-208-49.catv.fixed.one.hu
 [178.48.208.49])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp.freemail.hu (Postfix) with ESMTPSA id 4Yn55T5QQbz1vn;
 Tue, 04 Feb 2025 02:15:25 +0100 (CET)
Message-ID: <a332585e-8af6-4c54-8a1f-ced1a9164d21@freemail.hu>
Date: Tue, 4 Feb 2025 02:15:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] zynqmp: Save "bootseq" environment variable in dec format
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, michal.simek@amd.com, love.kumar@amd.com
References: <20250203163250.1618-1-egyszeregy@freemail.hu>
 <CAFLszTg9NgXUYB_LpWidXruzrV5YoS=o2Mn6m0DQNSHxefTWMg@mail.gmail.com>
Content-Language: hu
From: =?UTF-8?Q?Sz=C5=91ke_Benjamin?= <egyszeregy@freemail.hu>
In-Reply-To: <CAFLszTg9NgXUYB_LpWidXruzrV5YoS=o2Mn6m0DQNSHxefTWMg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=simple/relaxed; t=1738631726; 
 s=20181004; d=freemail.hu;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
 l=1297; bh=UlNf2tnC9z0ybmBhfP+X0v58ugEyVOxEE2dguRCwXmI=;
 b=GnwY4Ex+k4QMkWyL8rEvSLWDm04M99/ieGKtitzGS68uo5r+OGRIjbBw/dvlKEnj
 yaebo/DwRXMvhQRiwbmb3zGQjmiVYD9vJIxtMSpvzSKdiZmSXsaNlf02S9XU6WK5dpx
 x1rc7cdwQsojOPKpIIPHicZd93OyzrOALboU6f6yirBo4kQN3thFvZEWDmRQa6UvcDO
 hS61M0CXwaGUlXLG39hCrCBVX4h97yntmlFt9T2qW+UhlZ1BfHfO7TVysWbeZIF/6tr
 JS3NHodtzEZJaDdbXJUerjPbCKOTsK043apvPzpvjQCv+flwVuwHG4A3iqjur9bKbdi
 4hZKIS9aZw==
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

2025. 02. 04. 1:38 keltezéssel, Simon Glass írta:
> Hi Benjamin,
> 
> On Mon, 3 Feb 2025 at 09:33, <egyszeregy@freemail.hu> wrote:
>>
>> From: Benjamin Szőke <egyszeregy@freemail.hu>
>>
>> Save "bootseq" environment variable in decimal format.
>>
>> Signed-off-by: Benjamin Szőke <egyszeregy@freemail.hu>
>> ---
>>   board/xilinx/zynqmp/zynqmp.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/board/xilinx/zynqmp/zynqmp.c b/board/xilinx/zynqmp/zynqmp.c
>> index 8cdd9d8600..820fb252a3 100644
>> --- a/board/xilinx/zynqmp/zynqmp.c
>> +++ b/board/xilinx/zynqmp/zynqmp.c
>> @@ -488,7 +488,7 @@ static int boot_targets_setup(void)
>>                  if (bootseq >= 0) {
>>                          bootseq_len = snprintf(NULL, 0, "%i", bootseq);
>>                          debug("Bootseq len: %x\n", bootseq_len);
>> -                       env_set_hex("bootseq", bootseq);
>> +                       env_set_ulong("bootseq", (unsigned long)bootseq);
>>                  }
>>
>>                  /*
>> --
>> 2.47.1.windows.2
>>
> 
> That seems confusing; why use decimal?
> 

Because in a U-boot command this variable have to be used in decimal format 
sure, like "mmc dev ${bootseq}" or in root params of kernel arguments like 
"root=/dev/mmcblk${bootseq}p2".

Here is a conversation about it:
https://lists.denx.de/pipermail/u-boot/2025-February/579253.html

> Regards,
> Simon


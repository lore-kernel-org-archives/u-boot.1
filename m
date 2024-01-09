Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2C1AC46CD2
	for <u-boot@archiver.kernel.org>; Tue,  9 Jan 2024 15:34:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E88FF87807;
	Tue,  9 Jan 2024 16:34:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1704814461;
	bh=+UzNwQDAfbQ+tuSf/qaAeZeozdRGhUeE4CwAW7UpanI=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xNcFOh+JXOXdwkNxSoslr7JM2MJnlSYMwv2OqUNsUx0bTR2T8z9+6DNeIkt/M18EG
	 5cS9WNdFjqSrQJzbTHVcFLWFwNMvt19wCQ7HVFC+y0KrDZCPAEsSji8unCjAJrW1h0
	 cGOglUH6oWnc4k/tu+TyXFGA6zDL6OzWjbQCG/a7FY17MFAySzKtVC/ZTxNbwURaRI
	 UJgnJCklj4KVbUhUSyWYxmcfgPC6GjkILAniIxSvB1TnTeHhDoU7EpACXRDr+uPOf8
	 MzZ1/e8Ly7Iw9R0RDjySVm/klrfv2SCk/fzrV3kF+e7nF8LQizZYGW9nGm1MdKT2Lj
	 a88wFDy9Fl/6g==
Received: by phobos.denx.de (Postfix, from userid 109)
 id E767087824; Tue,  9 Jan 2024 16:34:20 +0100 (CET)
Received: from mout-u-107.mailbox.org (mout-u-107.mailbox.org
 [IPv6:2001:67c:2050:101:465::107])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 13CA886EEC
 for <u-boot@lists.denx.de>; Tue,  9 Jan 2024 16:34:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-107.mailbox.org (Postfix) with ESMTPS id 4T8ZjF0Dj3z9sr1;
 Tue,  9 Jan 2024 16:34:09 +0100 (CET)
Message-ID: <2f81957a-ab26-4220-9125-d0a788446e60@denx.de>
Date: Tue, 9 Jan 2024 16:34:03 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v3 1/3] arm: mvebu: Espressobin: move FDT fixup into a
 separate function
Content-Language: en-US
To: Robert Marko <robert.marko@sartura.hr>, u-boot@lists.denx.de
References: <20231129101117.60177-1-robert.marko@sartura.hr>
 <CA+HBbNFbLjSwY9QRP09SXVDMm=TJ1q4isgkce6p-H7LAnwZZ2g@mail.gmail.com>
From: Stefan Roese <sr@denx.de>
In-Reply-To: <CA+HBbNFbLjSwY9QRP09SXVDMm=TJ1q4isgkce6p-H7LAnwZZ2g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4T8ZjF0Dj3z9sr1
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

Hi Robert,

On 1/9/24 14:16, Robert Marko wrote:
> On Wed, Nov 29, 2023 at 11:11 AM Robert Marko <robert.marko@sartura.hr> wrote:
>>
>> Currently, Esspresobin FDT is being fixed up directly in ft_board_setup()
>> which makes it hard to add support for any other board to be fixed up.
>>
>> So, lets just move the FDT fixup code to a separate function and call it
>> if compatible matches, there should be no functional change.
>>
>> Signed-off-by: Robert Marko <robert.marko@sartura.hr>
>> Reviewed-by: Stefan Roese <sr@denx.de>
> 
> 
> Hi Stefan,
> Since 2024.01 was released, can this series be pulled in now?

It's on my list. I actually already started with some CI build tests.
Hope to get this done by end of this week, before I leave for a
short vacation.

Thanks,
Stefan

> Regards,
> Robert
> 
>>
>> ---
>>   board/Marvell/mvebu_armada-37xx/board.c | 14 +++++++++-----
>>   1 file changed, 9 insertions(+), 5 deletions(-)
>>
>> diff --git a/board/Marvell/mvebu_armada-37xx/board.c b/board/Marvell/mvebu_armada-37xx/board.c
>> index 04124d8014..1471caa9a6 100644
>> --- a/board/Marvell/mvebu_armada-37xx/board.c
>> +++ b/board/Marvell/mvebu_armada-37xx/board.c
>> @@ -363,18 +363,14 @@ EVENT_SPY_SIMPLE(EVT_LAST_STAGE_INIT, last_stage_init);
>>   #endif
>>
>>   #ifdef CONFIG_OF_BOARD_SETUP
>> -int ft_board_setup(void *blob, struct bd_info *bd)
>> +static int espressobin_fdt_setup(void *blob)
>>   {
>> -#ifdef CONFIG_ENV_IS_IN_SPI_FLASH
>>          int ret;
>>          int spi_off;
>>          int parts_off;
>>          int part_off;
>>
>>          /* Fill SPI MTD partitions for Linux kernel on Espressobin */
>> -       if (!of_machine_is_compatible("globalscale,espressobin"))
>> -               return 0;
>> -
>>          spi_off = fdt_node_offset_by_compatible(blob, -1, "jedec,spi-nor");
>>          if (spi_off < 0)
>>                  return 0;
>> @@ -459,6 +455,14 @@ int ft_board_setup(void *blob, struct bd_info *bd)
>>                  return 0;
>>          }
>>
>> +       return 0;
>> +}
>> +
>> +int ft_board_setup(void *blob, struct bd_info *bd)
>> +{
>> +#ifdef CONFIG_ENV_IS_IN_SPI_FLASH
>> +       if (of_machine_is_compatible("globalscale,espressobin"))
>> +               return espressobin_fdt_setup(blob);
>>   #endif
>>          return 0;
>>   }
>> --
>> 2.43.0
>>
> 
> 

Viele Grüße,
Stefan Roese

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-51 Fax: (+49)-8142-66989-80 Email: sr@denx.de

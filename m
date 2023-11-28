Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4D98C4167B
	for <u-boot@archiver.kernel.org>; Tue, 28 Nov 2023 15:44:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DB49D8754D;
	Tue, 28 Nov 2023 16:44:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1701186283;
	bh=pqZDue1GtmyEI6xzZtip2iCdB6Xspau0C/O0uySIvH0=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zHr+q6FOFLPmF7OOn9CmbWtQfAgFVDK/BwXqj2R8hK0m88FWAghdF6DCI8tIl9V3N
	 UGtxQZ22axA8+6zlHWoFtERbtDmZe8c3nP4VsCABpf178PJ3CzEDsGbwNF5OHAnKXD
	 lzv+BfQoCfcnYUTCq6XcSnGtL/qGdhXmaKgZm8EsbrEujE//ejwWFSyzgQqIqCnUL1
	 IHpANcE5+hO6kgENXv98OVqpG5p4CQSRMQbnU2iPnbRQ7egtr/9xSumle+EboGa4E3
	 PmG4W8TNjiPQ7h/4eniGfwKsZSTOoII1IKRGfUCqiBIR2/2/yfsq+92djhdaTVXo9u
	 InVA6KP/20e3A==
Received: by phobos.denx.de (Postfix, from userid 109)
 id B4F0C87630; Tue, 28 Nov 2023 16:44:42 +0100 (CET)
Received: from mout-u-107.mailbox.org (mout-u-107.mailbox.org [80.241.59.207])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7FD1F8754D
 for <u-boot@lists.denx.de>; Tue, 28 Nov 2023 16:44:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-107.mailbox.org (Postfix) with ESMTPS id 4Sfmwk2Dnjz9spb;
 Tue, 28 Nov 2023 16:44:38 +0100 (CET)
Message-ID: <8b1005a0-3960-4f8d-8dfc-ad9e858a68f3@denx.de>
Date: Tue, 28 Nov 2023 16:44:37 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v2 1/3] arm: mvebu: Espressobin: move FDT fixup into a
 separate function
To: Robert Marko <robert.marko@sartura.hr>, u-boot@lists.denx.de
References: <20231020102117.1583572-1-robert.marko@sartura.hr>
 <CA+HBbNHa_a2hnU9HgxsYjAaUijsgmb0ndDMOVaBz7GLP4JOVUA@mail.gmail.com>
Content-Language: en-US
From: Stefan Roese <sr@denx.de>
In-Reply-To: <CA+HBbNHa_a2hnU9HgxsYjAaUijsgmb0ndDMOVaBz7GLP4JOVUA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4Sfmwk2Dnjz9spb
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

On 11/28/23 11:19, Robert Marko wrote:
> On Fri, Oct 20, 2023 at 12:21 PM Robert Marko <robert.marko@sartura.hr> wrote:
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
> Hi Stefan,
> 
> Is there anything I can do to get this series merged?

I just looked at it (again). My recollection was that something was
missing here - so I was waiting for a new version. Does not seem to
be the case though. So I guess I forgot to pull it (sorry for that)
and now with rc3 out it seems a bit too late in the release cycle.
I hope you don't mind that it's postponed to the next merge window.

Thanks,
Stefan

> Regards,
> Robert
> 
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
>> 2.41.0
>>
> 
> 

Viele Grüße,
Stefan Roese

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-51 Fax: (+49)-8142-66989-80 Email: sr@denx.de

Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCC24C4167B
	for <u-boot@archiver.kernel.org>; Tue, 28 Nov 2023 15:49:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2DB74875F0;
	Tue, 28 Nov 2023 16:49:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1701186581;
	bh=C3kXoov6qq29EDLRoG6wyw6w4vMjUUzSa01nlygIsQc=;
	h=Date:Subject:From:To:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Qp1MZsYbU80muSMrFiXN3uM2zDvm+zJoeJ7hdhAKombGE+DwPoJsXH3ON7rkKv7fT
	 Me5zaFxHQ13LUajXY1+dRkkJifgv3lj0GNZSTJQrJSWy0v837x3EBtF4Bu276ZEH63
	 joOZt+Y5zGFTLhXR67jj0udTOdEBIjfbFDbPGdsmEy8YI4xv5Dkw/CMNKYe//6Gl+P
	 Gx9h9rKAsQnTy7Mg0DxGxhsLTDf4Wx0BZZ+vPr5YCAY5GAeEAtI5ALRq+4uDpyBWoQ
	 QrFTu30VLOBhsEf/DqHXgVuh4XAM6jF/zADU21AFE8zUHjcEgZPNVxeZIABU8H+nVz
	 b7ro+tMjggzvA==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8B302875FB; Tue, 28 Nov 2023 16:49:40 +0100 (CET)
Received: from mout-u-204.mailbox.org (mout-u-204.mailbox.org [80.241.59.204])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9FB248758C
 for <u-boot@lists.denx.de>; Tue, 28 Nov 2023 16:49:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-204.mailbox.org (Postfix) with ESMTPS id 4Sfn2S3Sw3z9smp;
 Tue, 28 Nov 2023 16:49:36 +0100 (CET)
Message-ID: <f98674e7-82b8-48c6-aac9-825f4311824d@denx.de>
Date: Tue, 28 Nov 2023 16:49:35 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v2 1/3] arm: mvebu: Espressobin: move FDT fixup into a
 separate function
Content-Language: en-US
From: Stefan Roese <sr@denx.de>
To: Robert Marko <robert.marko@sartura.hr>, u-boot@lists.denx.de
References: <20231020102117.1583572-1-robert.marko@sartura.hr>
 <CA+HBbNHa_a2hnU9HgxsYjAaUijsgmb0ndDMOVaBz7GLP4JOVUA@mail.gmail.com>
 <8b1005a0-3960-4f8d-8dfc-ad9e858a68f3@denx.de>
In-Reply-To: <8b1005a0-3960-4f8d-8dfc-ad9e858a68f3@denx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4Sfn2S3Sw3z9smp
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

On 11/28/23 16:44, Stefan Roese wrote:
> Hi Robert,
> 
> On 11/28/23 11:19, Robert Marko wrote:
>> On Fri, Oct 20, 2023 at 12:21 PM Robert Marko 
>> <robert.marko@sartura.hr> wrote:
>>>
>>> Currently, Esspresobin FDT is being fixed up directly in 
>>> ft_board_setup()
>>> which makes it hard to add support for any other board to be fixed up.
>>>
>>> So, lets just move the FDT fixup code to a separate function and call it
>>> if compatible matches, there should be no functional change.
>>>
>>> Signed-off-by: Robert Marko <robert.marko@sartura.hr>
>>> Reviewed-by: Stefan Roese <sr@denx.de>
>>
>> Hi Stefan,
>>
>> Is there anything I can do to get this series merged?
> 
> I just looked at it (again). My recollection was that something was
> missing here - so I was waiting for a new version. Does not seem to
> be the case though. So I guess I forgot to pull it (sorry for that)
> and now with rc3 out it seems a bit too late in the release cycle.
> I hope you don't mind that it's postponed to the next merge window.

Seems my memory is not that bad after all. A world CI build fails with
these 3 commits. Could you please have a look?

Completed: 84 total built, 84 newly), duration 1:01:11, rate 0.02
+ ret=100
+ [[ 100 -ne 0 ]]
+ tools/buildman/buildman -o /tmp -seP am33xx at91_kirkwood mvebu omap 
-x siemens
Summary of current source for 84 boards (2 threads, 1 job per thread)
    aarch64:  w+   x240 turris_mox mvebu_ac5_rd eDPU 
mvebu_espressobin-88f3720 uDPU clearfog_gt_8k mvebu_db_armada8k 
mvebu_mcbin-88f8040 mvebu_puzzle-m801-88f8040 mvebu_crb_cn9130 
mvebu_db_cn9130 +   mvebu_db-88f3720
        arm:  w+   am335x_shc am335x_shc_ict am335x_shc_netboot 
am335x_shc_sdboot brsmarc1 cm_t43 chiliboard am335x_igep003x am335x_sl50 
am43xx_evm_qspiboot am43xx_hs_evm_qspi controlcenterdc db-88f6720 
db-88f6820-gp igep00x0 sniper omap3_beagle omap4_panda omap4_sdp4430
+aarch64-linux-ld.bfd: board/Marvell/mvebu_armada-37xx/board.o: in 
function `is_edpu_plus':
+board/Marvell/mvebu_armada-37xx/board.c:94:(.text.last_stage_init+0xb4): 
undefined reference to `dm_mdio_read'
+make[1]: *** [Makefile:1765: u-boot] Error 139
+make[1]: *** Deleting file 'u-boot'
+make: *** [Makefile:177: sub-make] Error 2


Thanks,
Stefan


> Thanks,
> Stefan
> 
>> Regards,
>> Robert
>>
>>> ---
>>>   board/Marvell/mvebu_armada-37xx/board.c | 14 +++++++++-----
>>>   1 file changed, 9 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/board/Marvell/mvebu_armada-37xx/board.c 
>>> b/board/Marvell/mvebu_armada-37xx/board.c
>>> index 04124d8014..1471caa9a6 100644
>>> --- a/board/Marvell/mvebu_armada-37xx/board.c
>>> +++ b/board/Marvell/mvebu_armada-37xx/board.c
>>> @@ -363,18 +363,14 @@ EVENT_SPY_SIMPLE(EVT_LAST_STAGE_INIT, 
>>> last_stage_init);
>>>   #endif
>>>
>>>   #ifdef CONFIG_OF_BOARD_SETUP
>>> -int ft_board_setup(void *blob, struct bd_info *bd)
>>> +static int espressobin_fdt_setup(void *blob)
>>>   {
>>> -#ifdef CONFIG_ENV_IS_IN_SPI_FLASH
>>>          int ret;
>>>          int spi_off;
>>>          int parts_off;
>>>          int part_off;
>>>
>>>          /* Fill SPI MTD partitions for Linux kernel on Espressobin */
>>> -       if (!of_machine_is_compatible("globalscale,espressobin"))
>>> -               return 0;
>>> -
>>>          spi_off = fdt_node_offset_by_compatible(blob, -1, 
>>> "jedec,spi-nor");
>>>          if (spi_off < 0)
>>>                  return 0;
>>> @@ -459,6 +455,14 @@ int ft_board_setup(void *blob, struct bd_info *bd)
>>>                  return 0;
>>>          }
>>>
>>> +       return 0;
>>> +}
>>> +
>>> +int ft_board_setup(void *blob, struct bd_info *bd)
>>> +{
>>> +#ifdef CONFIG_ENV_IS_IN_SPI_FLASH
>>> +       if (of_machine_is_compatible("globalscale,espressobin"))
>>> +               return espressobin_fdt_setup(blob);
>>>   #endif
>>>          return 0;
>>>   }
>>> -- 
>>> 2.41.0
>>>
>>
>>
> 
> Viele Grüße,
> Stefan Roese
> 

Viele Grüße,
Stefan Roese

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-51 Fax: (+49)-8142-66989-80 Email: sr@denx.de

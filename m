Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31514C3DA64
	for <u-boot@archiver.kernel.org>; Thu,  1 Aug 2024 22:13:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 76E9788B68;
	Fri,  2 Aug 2024 00:13:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="sno0kD2h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CDAC5889D2; Fri,  2 Aug 2024 00:13:49 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4AC82885F2
 for <u-boot@lists.denx.de>; Fri,  2 Aug 2024 00:13:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=d829=PB=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1722550419;
 bh=Dj6xFTatHd+EM4Tl4YPgJGN/PJNWu1uvcMzqE8wARnw=;
 b=sno0kD2hxhafDLXX7Cn0lOweJfzS62Z4gtHgZYBJBtzgOzng8PPyGVlhO4BukJred2IxNNrg9
 UmirCxRVRhGENWI1Hf2pAP+ecwxRyBf4qpsM7MjvtjqO4PN/3ep0Prmv87/opf7RGmlIfjTLTNJ
 HeXCKmWQM3UMMogpfuID7t963SQ88vIJvDarmcBovpqZznL2KpSuAQyxb0MS6bOZ0h1diFd1xNG
 36qJuKJktX2Kn3VCSLkdoUMvSfOANn5Y8pItbuFOhQQXb3P3nZalaAM2ONYHFMgdSgV/skYwi9z
 ilOm2IrOyJkM4Nlh6poso/SnVr7q/aDVZtlTKXj4VWXg==
Message-ID: <794af916-0f5e-45d1-87ee-252a7a1bdf71@kwiboo.se>
Date: Fri, 2 Aug 2024 00:13:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] rockchip: rk3399: Migrate to use TPL on bob and kevin
To: Simon Glass <sjg@chromium.org>
Cc: Philipp Tomsich <philipp.tomsich@vrull.eu>, Kever Yang
 <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>, Alper Nebi
 Yasak <alpernebiyasak@gmail.com>, u-boot@lists.denx.de
References: <20240801083656.1936910-1-jonas@kwiboo.se>
 <CAFLszTi6=T3Tv0JXjBereHcqHcBn9kvYVxzquH+gAsSJ1cLg5A@mail.gmail.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <CAFLszTi6=T3Tv0JXjBereHcqHcBn9kvYVxzquH+gAsSJ1cLg5A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 66ac089006984f15ed09f780
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

Hi Simon,

On 2024-08-01 15:07, Simon Glass wrote:
> Hi Jonas,
> 
> On Thu, 1 Aug 2024 at 02:37, Jonas Karlman <jonas@kwiboo.se> wrote:
>>
>> All Rockchip aarch64 boards, beside bob and kevin, use TPL to initialize
>> DRAM and SPL to load FIT with U-Boot proper and TF-A.
>>
>> Bob and kevin currently does not use TPL and instead initialize DRAM
>> in SPL and directly after tries to load FIT with U-Boot proper and TF-A.
>>
>> This RFC try to migrate bob and kevin to also use TPL to uniform TPL/SPL
>> use for all Rockchip aarch64 boards.
> 
> Thanks for doing this!
> 
>>
>> Notes and questions:
>> - Is u-boot.rom even used for bob/kevin? It use u-boot-img, yet SPL
>>   expect to load FIT and does not permit use of raw imgage.
> 
> Yes it does use u-boot.rom
> 
>>
>>   Q: Can we remove what looks to be a faulty u-boot.rom definition and
>>      just use u-boot-rockchip-spi.bin instead?
> 
> Maybe, but we do need the image to be the correct size.

Maybe just changing the u-boot-img to something like following could
possible work for the u-boot.rom output?

	fit {
		type = "blob";
		filename = "u-boot.itb";
		offset = <CONFIG_SYS_SPI_U_BOOT_OFFS>;
	};

Similar to how it is done for the u-boot-rockchip-spi.bin output.

> 
>>
>> - FIT location moved from 0x40000 to 0xE0000 in SPI flash to allow for a
>>   larger SPL, up to 256 KiB, same as on other RK3399 boards.
>>
>>   Q: Can we use this location?, or is there something external that
>>     expects fit or u-boot-img at this location?
> 
> It should be fine.
> 
>>
>> Features that is now used:
>> - Use of Rockchip aarch64 common bss and stack addresses
>> - Checksum/signature check of FIT images in SPL
>> - Use of dcache to speed up checksum check in SPL
>> - SDMA use for eMMC access to speed up read/write in U-Boot proper
>>
>> Changes that would be good for future:
>> - Include and use pinctrl in SPL
> 
> Yes

Looks like the pinctrl driver is already include in SPL, so we probably
only need to include the pinctrl-0 props and pinctrl nodes in SPL FDT.

Should help fix some of the pinctrl_select_state_full errors seen in
your output log below.

> 
>> - Use dm gpio instead of spl_gpio functions in SPL
> 
> Where are you looking for spl_gpio? I'm not seeing it.

board_debug_uart_init() in rk3399.c contains some special code for
bob and kevin using spl_gpio_output() and spl_gpio_set_pull().

led_setup() in roc-pc-rk3399.c is the only other user of these
functions, so would be nice if we can remove them and use full
dm_gpio variants instead.

Something for a separate series.

> 
>>
>> I do not have any bob or kevin so this has only been compile tested.
>>
>> This should be broken down into smaller logical patches if this is
>> accepted and works on real hardware.
> 
> I forgot that I broke my bob and need to fix it. For kevin (which is
> very similar):
> 
> before:
> 06:57 $ ub-int kevin
> Building U-Boot in sourcedir for chromebook_kevin
> Bootstrapping U-Boot from dir /tmp/b/chromebook_kevin
> Writing U-Boot using method em100
> Channel 0: LPDDR3, 933MHz
> BW=32 Col=10 Bk=8 CS0 Row=15 CS1 Row=15 CS=2 Die BW=16 Size=2048MB
> Channel 1: LPDDR3, 933MHz
> BW=32 Col=10 Bk=8 CS0 Row=15 CS1 Row=15 CS=2 Die BW=16 Size=2048MB
> 256B stride
> 
> U-Boot SPL 2024.07-rc4-00009-g0ae095f4664 (Aug 01 2024 - 06:57:12 -0600)
> Bloblist at 100000 not found (err=-2)
> Trying to boot from SPI
> ns16550_serial serial@ff1a0000: pinctrl_select_state_full:
> uclass_get_device_by_phandle_id: err=-19
> 
> 
> U-Boot 2024.07-rc4-00009-g0ae095f4664 (Aug 01 2024 - 06:57:12 -0600)
> 
> Model: Google Kevin
> DRAM:  4 GiB (effective 3.9 GiB)
> Core:  329 devices, 33 uclasses, devicetree: separate
> MMC:   mmc@fe320000: 1, mmc@fe330000: 0
> Loading Environment from MMC... Reading from MMC(0)... *** Warning -
> bad CRC, using default environment
> 
> edp_rockchip dp@ff970000: failed to set rate on clock index 0 (362) (error = -2)
> edp_rockchip dp@ff970000: failed to set rate on clock index 0 (362) (error = -2)
> In:    serial,cros-ec-keyb
> Out:   serial,vidconsole
> Err:   serial,vidconsole
> Model: Google Kevin
> Net:   No ethernet found.
> 
> Hit any key to stop autoboot:  0
> =>
> 
> with your patch:
> 06:53 $ ub-int kevin
> Building U-Boot in sourcedir for chromebook_kevin
> Bootstrapping U-Boot from dir /tmp/b/chromebook_kevin
> Writing U-Boot using method em100
> 
> U-Boot SPL 2024.07-rc4-00010-g14d97804e94 (Aug 01 2024 - 06:53:17 -0600)
> Checksum 0 != 68
> Bloblist at 100000 not found (err=-5)
> Trying to boot from SPI
> ## Checking hash(es) for config conf-1 ... OK
> ## Checking hash(es) for Image firmware-1 ... crc32+ OK
> ## Checking hash(es) for Image fdt-1 ... crc32+ OK
> ns16550_serial serial@ff1a0000: pinctrl_select_state_full:
> uclass_get_device_by_phandle_id: err=-19
> 
> 
> U-Boot 2024.07-rc4-00010-g14d97804e94 (Aug 01 2024 - 06:53:17 -0600)
> 
> Model: Google Kevin
> DRAM:  4 GiB (effective 3.9 GiB)
> Core:  330 devices, 34 uclasses, devicetree: separate
> MMC:   mmc@fe320000: 1, mmc@fe330000: 0
> Loading Environment from MMC... Reading from MMC(0)... *** Warning -
> bad CRC, using default environment
> 
> edp_rockchip dp@ff970000: failed to set rate on clock index 0 (362) (error = -2)
> edp_rockchip dp@ff970000: failed to set rate on clock index 0 (362) (error = -2)
> In:    serial,cros-ec-keyb
> Out:   serial,vidconsole
> Err:   serial,vidconsole
> Model: Google Kevin
> Net:   No ethernet found.
> 
> Hit any key to stop autoboot:  0
> =>

Thanks for testing!

I am guessing the output from TPL was just not captured or could
there be an issue with debug uart/serial in TPL?

Also the FIT image names and hash method does not match the ones defined
for binman image in rockchip-u-boot.dtsi, are you building a custom FIT?

I will split into logical smaller patches and send a series later.

Regards,
Jonas

> 
> Regards,
> SImon


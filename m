Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2086C531F9
	for <u-boot@archiver.kernel.org>; Fri, 24 Jul 2026 12:36:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A02E540793;
	Fri, 24 Jul 2026 12:36:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rPnNB4t6nJ2k; Fri, 24 Jul 2026 12:36:34 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5D96740732
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784896594;
	bh=e68D/IM7aHxI//X7RdLHypTIc6sYPbgV3NztIldZTvk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vl31+oRC9/qt8ZdOtVkoowPzSJM0LhebknExEd1ZrudVPeHj4VgsfSeEKQcSjwo7u
	 rctr2h0kPjvfw2BAznTzpeqQZYyEq0UpHm7V2GaHpbwMtMxqQYpapwp+YsYFNKN5lO
	 o3fAQuSA/seUmi9on7YKmNeoKaJXPmR0hWSwkW3hRZ22yxhaeLV249v9Mbxv3qjAL5
	 rfeIYdqHhQNr0x03YmxosSDwCFPI9FwVqTz2pT9D8c3nQ3M0m3CjkvEkeZDjaph5BM
	 X4B4CEwbbC8SD2B1/pdb2ZhON6KeOSOLG5BXNvsSMk9D2CjSK4tbb+uzAmolF5IY9y
	 wr++M0uxGvK7w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5D96740732;
	Fri, 24 Jul 2026 12:36:34 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 92A7C224
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 12:36:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7815A404CE
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 12:36:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dtHzJVMBGaM8 for <u-boot@lists.u-boot-project.org>;
 Fri, 24 Jul 2026 12:36:32 +0000 (UTC)
X-Greylist: delayed 332 seconds by postgrey-1.37 at util1.osuosl.org;
 Fri, 24 Jul 2026 12:36:31 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 346E7404C9
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 346E7404C9
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=149.28.215.223;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=9cbe=ft=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 346E7404C9
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 12:36:31 +0000 (UTC)
X-Forward-Email-ID: 6a635afed383fd7c7d10795f
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 2.12.3
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <e4bcf339-6ced-4f4d-88dd-b033abc431b6@kwiboo.se>
Date: Fri, 24 Jul 2026 14:30:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] rockchip: binman: Add support for Falcon mode FIT
 images with ATF+Linux
To: Alexey Charkov <alchark@flipper.net>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, Anshul Dalal <anshuld@ti.com>,
 Peng Fan <peng.fan@nxp.com>, Tien Fong Chee <tien.fong.chee@altera.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Andre Przywara <andre.przywara@arm.com>, Andrew Davis <afd@ti.com>,
 Hrushikesh Salunke <h-salunke@ti.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>
References: <20260609-atf-falcon-v1-0-2b20c5e83615@flipper.net>
 <20260609-atf-falcon-v1-4-2b20c5e83615@flipper.net>
 <baf04b5d-ef0a-4c58-a796-d09edd6c84b7@kwiboo.se>
 <CAKTNdwEQx6SfKgD=RbbznVgLuMLA5P1UbJ3b+KR4j4L4GyCfoA@mail.gmail.com>
 <b8908639-94e7-4538-8a40-d40d00dc57e6@kwiboo.se>
 <CAKTNdwF68AZT6FHSzPCXKy9QBE16eO-AB+0Ggs9oZXicOSp4_Q@mail.gmail.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <CAKTNdwF68AZT6FHSzPCXKy9QBE16eO-AB+0Ggs9oZXicOSp4_Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kwiboo.se; 
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1784896590;
 bh=e68D/IM7aHxI//X7RdLHypTIc6sYPbgV3NztIldZTvk=;
 b=htrKJB/S/kFPi+5hKO7LtHwOnYK7wLQc3fOz+WEaHXhclSxIzdp8FEx2ZBPznAhTOp3fjxpBe
 Cy1iJi/wO69dF01ebvvPA5wLJBAK/NvhQ5ZJQKVgqQsx3kTcbCdEN/xnLiyLCfaUeJOlRjGd7O0
 BDxE3bNMnhoPQ8QqSv0S1n6Gt3WpnWxt0UR7nXgiMJNSietjsiziBbKvAeI/hebP5s3Ln52mUdS
 66cMyxTH63AxrLSmNLPSFzdeAcDGDrvowBDBziyWU367t1XBQ804+DWwGkZVVT8t2MXOx5Sn+ok
 PFe0WUZsKtKVSPyB0eDSWRYNiEjYx/HVQSrddndPqR7g==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b=htrKJB/S
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Alexey,

On 7/24/2026 11:48 AM, Alexey Charkov wrote:
> On Wed, Jun 10, 2026 at 2:06 AM Jonas Karlman <jonas@kwiboo.se> wrote:
>>
>> Hi Alexey,
>>
>> On 6/9/2026 8:26 PM, Alexey Charkov wrote:
>>> Hi Jonas,
>>>
>>> On Tue, Jun 9, 2026 at 9:54 PM Jonas Karlman <jonas@kwiboo.se> wrote:
>>>>
>>>> Hi Alexey,
>>>>
>>>> On 6/9/2026 6:52 PM, Alexey Charkov wrote:
>>>>> Modern Rockchip SoCs such as RK3576 require ATF to be running to provide
>>>>> firmware services to the OS. To enable booting Linux in Falcon mode on
>>>>> such SoCs, add binman support for generation of FIT images containing
>>>>> appropriately split ATF raw binaries (as is currently done by binman for
>>>>> U-boot proper images), externally preprocessed DTB and a Linux kernel.
>>>>>
>>>>> Signed-off-by: Alexey Charkov <alchark@flipper.net>
>>>>> ---
>>>>>  Makefile                           |   2 +
>>>>>  arch/arm/dts/rockchip-u-boot.dtsi  | 109 +++++++++++++++++++++++++++++++++++++
>>>>>  tools/binman/etype/falcon_fdt.py   |  26 +++++++++
>>>>>  tools/binman/etype/linux_kernel.py |  22 ++++++++
>>>>>  4 files changed, 159 insertions(+)
>>>>>
>>>>> diff --git a/Makefile b/Makefile
>>>>> index 4e5c1dd6a1c4..844e5adb7b31 100644
>>>>> --- a/Makefile
>>>>> +++ b/Makefile
>>>>> @@ -1690,6 +1690,8 @@ cmd_binman = $(srctree)/tools/binman/binman $(if $(BINMAN_DEBUG),-D) \
>>>>>               $(foreach f,$(BINMAN_INDIRS),-I $(f)) \
>>>>>               -a atf-bl1-path=${BL1} \
>>>>>               -a atf-bl31-path=${BL31} \
>>>>> +             -a linux-kernel-path=${LINUX_KERNEL} \
>>>>> +             -a falcon-fdt-path=${FALCON_FDT} \
>>>>>               -a tee-os-path=${TEE} \
>>>>>               -a ti-dm-path=${TI_DM} \
>>>>>               -a opensbi-path=${OPENSBI} \
>>>>> diff --git a/arch/arm/dts/rockchip-u-boot.dtsi b/arch/arm/dts/rockchip-u-boot.dtsi
>>>>> index 4ba6a87e78ab..866a6ab654ca 100644
>>>>> --- a/arch/arm/dts/rockchip-u-boot.dtsi
>>>>> +++ b/arch/arm/dts/rockchip-u-boot.dtsi
>>>>> @@ -161,6 +161,96 @@
>>>>>                       };
>>>>>               };
>>>>>       };
>>>>> +
>>>>> +#ifdef CONFIG_SPL_OS_BOOT
>>>>> +     fit_falcon_template: template-falcon {
>>>>
>>>> Not sure it is possible, but this looks to add lots of duplicated
>>>> content. Could we try to re-use more, e.g. is it possible to extract
>>>> @atf-SEQ, and I also think we may want to support loading of TEE-OS?
>>>
>>> Makes sense, will try to refactor a bit to reduce duplication.
>>>
>>>>> +             type = "fit";
>>>>> +             description = "FIT image for Falcon Linux with bl31 (TF-A)";
>>>>> +             #address-cells = <1>;
>>>>> +             fit,fdt-list-val = "u-boot";
>>>>> +             fit,external-offset = <CONFIG_FIT_EXTERNAL_OFFSET>;
>>>>> +             fit,align = <512>;
>>>>> +
>>>>> +             images {
>>>>> +                     @atf-SEQ {
>>>>> +                             fit,operation = "split-elf";
>>>>> +                             description = "ARM Trusted Firmware";
>>>>> +                             type = "firmware";
>>>>> +                             arch = FIT_ARCH;
>>>>> +                             os = "arm-trusted-firmware";
>>>>> +                             compression = "none";
>>>>> +                             fit,load;
>>>>> +                             fit,entry;
>>>>> +                             fit,data;
>>>>> +
>>>>> +                             atf-bl31 {
>>>>> +                             };
>>>>> +#ifdef FIT_HASH_ALGO
>>>>> +                             hash {
>>>>> +                                     algo = FIT_HASH_ALGO;
>>>>> +                             };
>>>>> +#endif
>>>>> +                     };
>>>>> +
>>>>> +                     kernel {
>>>>> +                             description = "Linux kernel";
>>>>> +                             type = "kernel";
>>>>> +                             arch = FIT_ARCH;
>>>>> +                             os = "linux";
>>>>> +                             compression = "none";
>>>>> +                             load = <0x48000000>;
>>>>> +                             entry = <0x48000000>;
>>>>
>>>> We should not hard-code these here, they seem to be RK3576 specific.
>>>
>>> Fair enough. Should probably come from configs.
>>>
>>>>> +
>>>>> +                             linux-kernel {
>>>>> +                             };
>>>>> +#ifdef FIT_HASH_ALGO
>>>>> +                             hash {
>>>>> +                                     algo = FIT_HASH_ALGO;
>>>>> +                             };
>>>>> +#endif
>>>>> +                     };
>>>>> +
>>>>> +                     fdt-1 {
>>>>> +                             description = "falcon-fdt";
>>>>> +                             type = "flat_dt";
>>>>> +                             arch = FIT_ARCH;
>>>>> +                             compression = "none";
>>>>> +                             load = <0x52000000>;
>>>>
>>>> Same here.
>>>
>>> Ack
>>>
>>>>> +
>>>>> +                             falcon-fdt {
>>>>> +                             };
>>>>
>>>> If I am not mistaken we can already inject an external DT to be used as
>>>> control fdt during U-Boot build using EXT_DTB env, maybe it is better to
>>>> use that instead of passing in a new FDT?
>>>>
>>>> We probably also want to use @fdt-SEQ and @config-SEQ to be able to
>>>> dynamically load a config based on e.g. board_fit_config_name_match()
>>>> that some boards already use to select config/fdt for U-Boot proper.
>>>
>>> Indeed, that would be quite interesting to have to make it all less
>>> hardcoded. Does board_fit_config_name_match() also work in SPL?
>>
>> Yes, that is where I know it is currently being used for Rockchip on
>> such boards, e.g. rk3566-zero3 and similar.
>>
>> spl_load_simple_fit()
>> - spl_simple_fit_parse()
>>    - fit_find_config_node()
>>       - board_fit_config_name_match()
>>
>> And in U-Boot proper the board model/variant is mostly used to set
>> correct fdtfile env var so that correct FDT can be loaded from e.g.
>> fdtdir when doing pxe_utils booting.
>>
>>>
>>>>> +#ifdef FIT_HASH_ALGO
>>>>> +                             hash {
>>>>> +                                     algo = FIT_HASH_ALGO;
>>>>> +                             };
>>>>> +#endif
>>>>> +                     };
>>>>> +             };
>>>>> +
>>>>> +             configurations {
>>>>> +                     default = "config-1";
>>>>> +                     @config-SEQ {
>>>>> +                             description = "RK3576 Falcon Linux via ATF";
>>>>
>>>> This is rockchip-u-boot.dtsi, drop RK3576 specific parts :-)
>>>
>>> RK3576 is the whole world to me! :-D
>>>
>>> Will do, thanks for pointing out
>>>
>>>>> +                             fit,firmware = "atf-1", "kernel";
>>>>> +                             fit,loadables;
>>>>> +                             fdt = "fdt-SEQ";
>>>>> +#ifdef FIT_HASH_ALGO
>>>>> +                             hash {
>>>>> +                                     algo = FIT_HASH_ALGO;
>>>>> +                             };
>>>>> +#endif
>>>>> +                     };
>>>>> +             };
>>>>> +     };
>>>>> +
>>>>> +     falcon-fit {
>>>>> +             filename = "u-boot-rockchip-falcon.itb";
>>>>
>>>> Do we need to export this file? the old .itb-file is exported because
>>>> some distro build scripts or flash instructions still use the older
>>>> files instead of the preferred u-boot-rockchip.bin.
>>>
>>> Yes, this is the file you would actually flash onto, say, dedicated
>>> UFS LUN to preserve Linux-to-U-boot fallback path.
>>>
>>> I'm currently overwriting my main U-boot by `rockusb write-file 16384
>>> u-boot-rockchip-falcon.itb` but in a normally working setup one
>>> wouldn't want to do that, so a pre-packed image with the SPL and the
>>> rest is less helpful in Falcon mode. The combo of
>>> `idbloader.img`+`u-boot-rockchip-falcon.itb` is what I believe should
>>> be used, with the former going to W-LU-A and the latter going wherever
>>> there's enough space for a Linux image.
>>>
>>>>> +
>>>>> +             fit {
>>>>> +                     insert-template = <&fit_falcon_template>;
>>>>> +             };
>>>>> +     };
>>>>> +#endif
>>>>>  #endif /* HAS_FIT */
>>>>>
>>>>>       simple-bin {
>>>>> @@ -260,6 +350,25 @@
>>>>>               };
>>>>>               };
>>>>>       };
>>>>> +
>>>>> +#ifdef CONFIG_SPL_OS_BOOT
>>>>> +     simple-bin-usb472-falcon {
>>>>
>>>> Do we really need this? As you notice the BootROM loader is not really
>>>> optimized for large payloads, I thought using a 1-2 MiB payload with
>>>> TF-A + U-Boot proper was stretching it, sending a full Linux kernel seem
>>>> like a big stretch, as evidenced by the 6 minute load time?
>>>
>>> It's neat for CI workloads and quick testing to jump straight to Linux
>>> without persistent storage or TFTP servers. I'm hoping to resolve the
>>> slow boot ROM execution one way or another, maybe by poking some CRU
>>> registers from boost.bin.
>>
>> On RK3576 the extra long load time could likely be improved by adjusting
>> core clocks before/after DRAM init runs. I have not tried to figure out
>> what boost.bin v1.03 does to improve UFS boot speeds but likely some
>> clock tuning is going on.
>>
>>>
>>> There have also been attempts at enabling opensource TPL on RK3576 and
>>> RK356x, so if/when they land we would be free to adjust clocks much
>>> earlier, hopefully making the boot faster. After all, it works
>>> brilliantly when booting from fixed storage, so there isn't much
>>> reason for it not to work from Maskrom, apart from the particular boot
>>> ROM on RK3576 being capricious (not sure if it applies to other RK
>>> SoCs).
>>
>> Based on testing on quite a few RK SoCs there seem to be a mix of fast
>> and slow crc16 implementations, possible some can be due to slow clock
>> speed, but I also fear a few are using a very basic implementation that
>> starves even cores running at full rates.
>>
>> E.g. on my decent x86 labgrid exporter using similar basic crc16
>> implementation loading 472 image of about 2-3 MiB could take 30-60
>> seconds, and using table lookup, it went down to a few seconds.
>> I can only imagine load times on some of the weaker SoCs :-)
>>
>> This is the main reason behind commit 9d3d4d619252 ("rockchip: Reduce
>> size of ramboot usb472 payload"), removing 1-2 MiB zero-padding could
>> help load time by several seconds, even on faster SoCs that normally
>> does not have core clocks adjusted in SPL/proper.
> 
> Hi Jonas,
> 
> I've done some further investigation into why usb472 takes so long
> (with my trusty SWD probe). Turns out the boot ROM runs a bit-by-bit
> CRC calculation on the usb472 payload, which is not done for any other
> boot mode. Since the sole core runs with the MMU and caches off, it
> effectively hits full DRAM latency on every byte, and then it spends
> dozens of instructions on every byte performing unoptimized bit-by-bit
> arithmetic for the checksum.
> 
> The throughput I measured for this calculation is around 124 kB/s on
> my RK3576 based Flipper One dev prototype. That's 5.47 min for my 39
> MB Falcon Linux + initrd payload.
> 
> On a bright side: if the checksum (last two bytes) in the uploaded
> image is set to zero, it skips the whole CRC routine and jumps right
> into the uploaded image with no delay.
> 
> Thought this is worth sharing in case more people want to take the shortcut.

Nice find!

I did some quick remote tests with setting crc=0 and can confirm this
works on rk3506, rk3528, rk3576 and rv1106, so likely also on following
RK SoCs:

  ("2207", "110c"),  # RV1106
  ("2207", "110e"),  # RV1103B
  ("2207", "110f"),  # RV1126B

  ("2207", "350c"),  # RK3528
  ("2207", "350d"),  # RK3562
  ("2207", "350e"),  # RK3576
  ("2207", "350f"),  # RK3506
  ("2207", "351a"),  # RK3572
  ("2207", "351b"),  # RK3538

Using crc=0 does not work on RK3568 or RK3588, will test more once I am
closer to all my boards sometime next week :-)

I tested using labgrid PR1721 and something like following diff:

@@ -261,7 +262,12 @@ class RKUSBMaskrom:
             data.append(0)

         # append crc16 of data
-        crc = crc16_ccitt_false(data)
+        if self._dev.idProduct in (0x110c, 0x350c, 0x350e, 0x350f) and \
+           len(data) > 0x40000:
+            crc = 0
+        else:
+            crc = crc16_ccitt_false(data)
+        print(f"Loading {code:x} image of size {len(data)} and crc {crc:04x}")
         data.append(crc >> 8)
         data.append(crc & 0xff)


Best regards,
Jonas

> 
> Best regards,
> Alexey


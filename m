Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEC32106B535
	for <u-boot@archiver.kernel.org>; Wed, 25 Mar 2026 13:25:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 21DE183FED;
	Wed, 25 Mar 2026 14:25:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=fairphone.com header.i=@fairphone.com header.b="C7aAmVU0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 13641838BB; Wed, 25 Mar 2026 09:38:26 +0100 (CET)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 878CF81E18
 for <u-boot@lists.denx.de>; Wed, 25 Mar 2026 09:38:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=fairphone.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=luca.weiss@fairphone.com
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-b8f9568e074so385828466b.0
 for <u-boot@lists.denx.de>; Wed, 25 Mar 2026 01:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fairphone.com; s=fair; t=1774427903; x=1775032703; darn=lists.denx.de;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1RHIM3bBwM1s13VJblhu41sC4kAE/fdoDCArqBiwQ9s=;
 b=C7aAmVU0sXi9L1s2VHtUFb1OA7EQCbvLFSLRX45c8gGDVRbHM9sR5z1cqKnP/azADO
 NJlcW2fT5VG4GtHm9O8kux6iEko2Q/mpDU4l0lrNfVy9+tS5iS6jXpNaYPTlMpmwfm37
 sL2UXq+KEK8st/LIrdD7PKO0SSskqlSsHUm38rggawfIKEmMKEdcBiLCvrMWU8p7DFNV
 17jBsdS0IQ3Hvb6kg3oH4XoJdX7g++8ZMllcgrDHLleu0pcP1ZbEVyiAECv2lg4eUZNm
 qQEiwkBYN1WUH9OQZyGQDABs46gM8nw89tDkNr0kZ0Xokfgfo3JJcXlLZHUyVoPEyO6C
 ANZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774427903; x=1775032703;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1RHIM3bBwM1s13VJblhu41sC4kAE/fdoDCArqBiwQ9s=;
 b=fh9tGOx/fATUjuPx6FTVckUQEaxmzb4K+kYDdtrwQ/5QJbhesE9W9g2cTIcRGy+lkl
 OAv0CcRNdqMDGLA8EGig8DCwX0Utdho5nNNCxTm+aoDualjh1yNCOqgzo3ec0rfSi2e/
 bqm6fq7zpc5HkxDRSYq+596A8UjAHD8jr80XdDCWfwiL8Qfls7sbSpXeVR9scg9F4DhB
 HE4PPAcs1pu53SnFZyMptl655vpE+HEeEgAtq+T9Nsfham9oJ0/+ltJ2jwbnKcV96l7b
 3GK8eVChf4RVUxOrnQKIoUoY8Lr5s+4EmRGYQTHX7xPS5lFzRB464w8tttXi+qq3HHEA
 c3Xg==
X-Gm-Message-State: AOJu0Ywdk+HOM+Vx9ZeM95LKDh0Rx5MUcyczWxQM2kIJdNbRnM5ieyiI
 jYTox5cIjv6VfQPA1cZtheGiSe0Xrjxy62ku12kZK1DI5QsmpHTkdBhOlWLAVUWQsvc=
X-Gm-Gg: ATEYQzzByshO/M3/gGtaJ8AVGfBJVGmjvGhYO7BDisLyT+jDLSKUBCAVMFvQT6O7e+J
 /o/y5m4tb8XEuGTVwq9WDkf8jqktVS6DUTpRQSOHv6AADjt9cwZyQbzgV9rCgf+ZP5IBNxmh5Xd
 UMCLMk7dkgPKuBFF5tY0dJx2doOE1Q/RBSjdzrw8YMDxrV9GnQjjE10bhHi0tf/ezxojxrLySJV
 Lts1Pm5bpqMqj0Yzf3QK9ZZEYOiSgxEN2PoWESUYtAWOfTzXm4RgMldqw8d2KwW/WP9Fny4Zb5N
 Q8tzxijngfHbykEiLbbyL7El+tvD1LZMc8czd6V+Rv8M4XFa/wSyQtyv5wNDOZS7W+b23v/zIIA
 PUUfR1ablxX7lEPckwd7m4Aer1iSV3rRYglDOhRdJ3/PFHuNvUmW3CXhUpusJG1jtEnW1FreaWi
 A/g+JvICgM9ALWtUlx6j5wpRd08xuWBMn/Do+EbFZKzYxi7QBH6L6Ac/hh4uzhV0YKVLv7
X-Received: by 2002:a17:907:8748:b0:b98:3b5d:e12b with SMTP id
 a640c23a62f3a-b9a3f1925damr153550666b.22.1774427902749; 
 Wed, 25 Mar 2026 01:38:22 -0700 (PDT)
Received: from localhost (144-178-202-139.static.ef-service.nl.
 [144.178.202.139]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b9832beecf4sm764764766b.0.2026.03.25.01.38.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Mar 2026 01:38:21 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 25 Mar 2026 09:38:20 +0100
Message-Id: <DHBQ7041HAZJ.26BPYQZRRDC7T@fairphone.com>
Cc: <u-boot@lists.denx.de>, <u-boot-qcom@groups.io>, "Anatolij Gustschin"
 <ag.dev.uboot@gmail.com>, "Tom Rini" <trini@konsulko.com>, "Igor Belwon"
 <igor.belwon@mentallysanemainliners.org>, "Casey Connolly"
 <casey.connolly@linaro.org>, "Neil Armstrong" <neil.armstrong@linaro.org>
Subject: Re: [PATCH] video: simplefb: Map framebuffer region on probe on ARM64
From: "Luca Weiss" <luca.weiss@fairphone.com>
To: "Sumit Garg" <sumit.garg@kernel.org>, "Luca Weiss"
 <luca.weiss@fairphone.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260318-simplefb-map-v1-1-edec1ee81df1@fairphone.com>
 <acIpDkBPdC0DGW8y@sumit-xelite>
In-Reply-To: <acIpDkBPdC0DGW8y@sumit-xelite>
X-Mailman-Approved-At: Wed, 25 Mar 2026 14:25:38 +0100
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

Hi Sumit,

On Tue Mar 24, 2026 at 7:02 AM CET, Sumit Garg wrote:
> Hi Luca,
>
> On Wed, Mar 18, 2026 at 04:07:17PM +0100, Luca Weiss wrote:
>> The framebuffer buffer might not be mapped on some devices.
>>=20
>> This is #ifdef'ed for ARM64 since mmu_map_region() is not defined for
>> any other architecture.
>
> This isn't an appropriate fix to the problem.
>
>>=20
>> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
>> ---
>> Map 0x1000 extra due to unknown reason, but otherwise it's not enough
>> and we still get a "Synchronous Abort" when drawing at the bottom of the
>> framebuffer.
>>=20
>> For milos-fairphone-fp6 the framebuffer is reg=3D0xe3940000
>> size=3D0xa932c0 (2484*1116*4).
>>=20
>> When just calling mmu_map_region with plat->size, then it's crashing at
>> 0xe43d3000 even though everything up to 0xe43d32c0 should be mapped.
>> With size+0x800 (or less) it was also still crashing, only size+0x1000
>> then worked.
>>=20
>> Possible I just don't know enough about memory mapping things, so
>> suggestions welcome! :)
>
> This sounds more likely the synchronous aborts caused by cache prefetch
> of nearby reserved memory regions. I see there are some reserved mememory
> regions around the address space you have mentioned on Milos.
>
> On Qcom platforms, the default memory map strategy is to map the overall
> DRAM space without excluding reserved reqions. One can exclude reserved
> regions in a SoC specific manner here [1] but it adds some runtime
> overhead. Give it a try for Milos as well in case it resolves your
> issue.

Casey's verdict from dump_pagetable() was that the ABL doesn't include
the framebuffer in the memory map it provides, so we need to map it
ourselves. I honestly have less understanding of how that works, so
please correct me/us if that's wrong.

As a reminder, the framebuffer is reg =3D <0xe3940000 (2484 * 1116 * 4)>,
so 0xe3940000 - 0xe43d32c0

<debug_uart>


U-Boot 2026.04-rc2-00021-gbae2991415b0-dirty (Mar 05 2026 - 16:37:20 +0100)

Model: The Fairphone (Gen. 6)
DRAM:  38 GiB (total 7.4 GiB)
Walking pagetable at 00000009fff00000, va_bits: 36. Using 3 levels
[0x000009fff01000]                        |  Table |            |          =
     |         =20
  [0x000009fff02000]                      |  Table |            |          =
     |         =20
    [0x00000000001000 - 0x00000000200000] |  Pages | PXN UXN    | Device-nG=
nRnE | Non-shareable  =20
  [0x00000000200000 - 0x00000040000000]   |  Block | PXN UXN    | Device-nG=
nRnE | Non-shareable  =20
[0x00000040000000 - 0x00000080000000]     |  Block | PXN UXN    | Device-nG=
nRnE | Non-shareable  =20
[0x000009fff03000]                        |  Table |            |          =
     |         =20
  [0x00000080000000 - 0x00000080e00000]   |  Block | PXN UXN    | Device-nG=
nRnE | Non-shareable  =20
  [0x00000080e00000 - 0x00000081800000]   |  Block | RWX        | Normal   =
     | Inner-shareable=20
  [0x000009fff04000]                      |  Table |            |          =
     |         =20
    [0x00000081cf5000 - 0x00000081cff000] |  Pages | RWX        | Normal   =
     | Inner-shareable=20
  [0x000009fff05000]                      |  Table |            |          =
     |         =20
    [0x00000081f20000 - 0x00000082000000] |  Pages | RWX        | Normal   =
     | Inner-shareable=20
  [0x00000082000000 - 0x00000082400000]   |  Block | RWX        | Normal   =
     | Inner-shareable=20
  [0x000009fff06000]                      |  Table |            |          =
     |         =20
    [0x00000082400000 - 0x000000824a0000] |  Pages | RWX        | Normal   =
     | Inner-shareable=20
  [0x00000082800000 - 0x0000008ac00000]   |  Block | RWX        | Normal   =
     | Inner-shareable=20
  [0x000009fff07000]                      |  Table |            |          =
     |         =20
    [0x0000009ea9c000 - 0x0000009eb00000] |  Pages | RWX        | Normal   =
     | Inner-shareable=20
  [0x000009fff08000]                      |  Table |            |          =
     |         =20
    [0x0000009f300000 - 0x0000009f400000] |  Pages | RWX        | Normal   =
     | Inner-shareable=20
  [0x0000009f400000 - 0x000000a6400000]   |  Block | RWX        | Normal   =
     | Inner-shareable=20
  [0x000000a7000000 - 0x000000c0000000]   |  Block | RWX        | Normal   =
     | Inner-shareable=20
[0x000009fff09000]                        |  Table |            |          =
     |         =20
  [0x000000c0000000 - 0x000000e0600000]   |  Block | RWX        | Normal   =
     | Inner-shareable=20
  [0x000000e0a00000 - 0x000000e1e00000]   |  Block | RWX        | Normal   =
     | Inner-shareable=20
  [0x000009fff0a000]                      |  Table |            |          =
     |         =20
    [0x000000e1e00000 - 0x000000e1f00000] |  Pages | RWX        | Normal   =
     | Inner-shareable=20
  [0x000009fff0b000]                      |  Table |            |          =
     |         =20
    [0x000000e2500000 - 0x000000e2600000] |  Pages | RWX        | Normal   =
     | Inner-shareable=20
  [0x000000e2600000 - 0x000000e3800000]   |  Block | RWX        | Normal   =
     | Inner-shareable=20
  [0x000009fff0c000]                      |  Table |            |          =
     |         =20
    [0x000000e3800000 - 0x000000e3940000] |  Pages | RWX        | Normal   =
     | Inner-shareable=20
  [0x000009fff0d000]                      |  Table |            |          =
     |         =20
    [0x000000e6440000 - 0x000000e6600000] |  Pages | RWX        | Normal   =
     | Inner-shareable=20
  [0x000000e6600000 - 0x000000e8800000]   |  Block | RWX        | Normal   =
     | Inner-shareable=20
  [0x000009fff0e000]                      |  Table |            |          =
     |         =20
    [0x000000e8800000 - 0x000000e8900000] |  Pages | RWX        | Normal   =
     | Inner-shareable=20
  [0x000009fff0f000]                      |  Table |            |          =
     |         =20
    [0x000000f0d00000 - 0x000000f0e00000] |  Pages | RWX        | Normal   =
     | Inner-shareable=20
  [0x000000f0e00000 - 0x00000100000000]   |  Block | RWX        | Normal   =
     | Inner-shareable=20
[0x000009fff10000]                        |  Table |            |          =
     |         =20
  [0x00000880000000 - 0x000008afa00000]   |  Block | RWX        | Normal   =
     | Inner-shareable=20
  [0x000009fff11000]                      |  Table |            |          =
     |         =20
    [0x000008afa00000 - 0x000008afafe000] |  Pages | RWX        | Normal   =
     | Inner-shareable=20
  [0x000008b0000000 - 0x000008b9600000]   |  Block | RWX        | Normal   =
     | Inner-shareable=20
  [0x000009fff12000]                      |  Table |            |          =
     |         =20
    [0x000008b9600000 - 0x000008b9700000] |  Pages | RWX        | Normal   =
     | Inner-shareable=20
  [0x000008bf800000 - 0x000008c0000000]   |  Block | RWX        | Normal   =
     | Inner-shareable=20
[0x000008c0000000 - 0x00000a00000000]     |  Block | RWX        | Normal   =
     | Inner-shareable=20
Core:  124 devices, 32 uclasses, devicetree: board
MMC:   mmc@8804000: 0
Loading Environment from nowhere... OK
"Synchronous Abort" handler, esr 0x96000047, far 0x0
elr: 000000000003bdac lr : 000000000003bdac (reloc)
elr: 00000009ffe05dac lr : 00000009ffe05dac
x0 : 00000000fffffffe x1 : 00000009ffec5170
x2 : 0000000000000003 x3 : 0000000000000001
x4 : 0000000000000063 x5 : 0000000000000000
x6 : 00000009efd9c7f0 x7 : 0000000000000000
x8 : 000000000000000a x9 : 0000000000000034
x10: 000000000000000d x11: 0000000000000006
x12: 00000009efd9ca38 x13: 00000000b7dfe000
x14: 00000000fffffffb x15: 00000009ffefbb9c
x16: 00000009ffe30cec x17: 0000000000000001
x18: 00000009efdaac30 x19: 0000000000000000
x20: 00000009efde2990 x21: 00000009ffecd110
x22: 00000009ffeb2e8e x23: 00000009efdb1430
x24: 00000009efdd8290 x25: 00000000e3940000
x26: 0000000000000002 x27: 0000000000000002
x28: 0000000000000002 x29: 00000009efd9c840

Code: 90000602 9105c021 91047842 9400291b (f900027f)=20
Resetting CPU ...

### ERROR ### Please RESET the board ###


Regards
Luca

>
> I think we still need to revisit that reserved memory strategy where
> default should rather be we unmap the reserved regions.
>
> [1] https://github.com/u-boot/u-boot/blob/master/arch/arm/mach-snapdragon=
/board.c#L743
>
> -Sumit
>
>> ---
>>  drivers/video/simplefb.c | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>=20
>> diff --git a/drivers/video/simplefb.c b/drivers/video/simplefb.c
>> index 8d0772d4e51..e144fde697b 100644
>> --- a/drivers/video/simplefb.c
>> +++ b/drivers/video/simplefb.c
>> @@ -9,6 +9,7 @@
>>  #include <log.h>
>>  #include <video.h>
>>  #include <asm/global_data.h>
>> +#include <asm/system.h>
>> =20
>>  static int simple_video_probe(struct udevice *dev)
>>  {
>> @@ -37,6 +38,11 @@ static int simple_video_probe(struct udevice *dev)
>>  	plat->base =3D base;
>>  	plat->size =3D size;
>> =20
>> +#ifdef CONFIG_ARM64
>> +	/* The framebuffer buffer might not be mapped on some devices */
>> +	mmu_map_region((phys_addr_t)plat->base, (phys_addr_t)plat->size + 0x10=
00, false);
>> +#endif
>> +
>>  	video_set_flush_dcache(dev, true);
>> =20
>>  	debug("%s: Query resolution...\n", __func__);
>>=20
>> ---
>> base-commit: ba7bf918dafcd093ad733b07ba490baeb20cf5da
>> change-id: 20260318-simplefb-map-abb9dba0eed1
>>=20
>> Best regards,
>> --=20
>> Luca Weiss <luca.weiss@fairphone.com>
>>=20


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF5F2E77188
	for <u-boot@archiver.kernel.org>; Sat,  4 Jan 2025 22:23:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 522288043F;
	Sat,  4 Jan 2025 23:23:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="akzRI8WK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 95A6A803DC; Sat,  4 Jan 2025 23:23:31 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [207.246.76.47])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7612F8056B
 for <u-boot@lists.denx.de>; Sat,  4 Jan 2025 23:23:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=80b6=T5=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1736029407;
 bh=AD6yXlcYwaxD5KH+Q03US9rXi0xAQeeVqfrZzdheWeo=;
 b=akzRI8WKDUkA2NiTBjUKbJh1yQ6ai6HSU2RK4yz+eXSYJETFFubSQ3Pz15NUagK1ljs5KJYPV
 A4ZCtFOQr8fsbgM3pgXlLQAXcG/r8A+OoHMzgt2RGkYlunA1CsuCSaV9wLvC9m5EGjnUer5/qLU
 usEWJcyEPT13uXUAXqYYvwIKSjK3nG8Cp/sk4baQetC1AEU5tuD7Uth+pkYDebfruTxGPkA1jg8
 4YpE9NPhH5kXMr8ifDKQeBBEt6cUPMJlS0TtNSdbojoapRoU706Xku0R2HJ1uus7jcRMI8EC7Aq
 CmAxthOS0l1fOH7IQ6yD//HMyhXFzPc5bgTyrbUI2aeg==
X-ForwardEmail-Version: 0.4.40
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Received: from [192.168.2.234] ([78.69.151.207]
 78-69-151-207-no600.tbcn.telia.com) by smtp.forwardemail.net (Forward
 Email) with ESMTPSA (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384); Sat,
 04 Jan 2025 22:23:16 +0000
Message-ID: <754d7695-f184-4096-980e-90df66fb2b87@kwiboo.se>
Date: Sat, 4 Jan 2025 23:23:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] tools: amlimage: Add support for GXBB eMMC header
To: Simon Glass <sjg@chromium.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini
 <trini@konsulko.com>, Ferass El Hafidi <funderscore@postmarketos.org>,
 u-boot-amlogic@groups.io, u-boot@lists.denx.de
References: <20250103215904.2590769-1-jonas@kwiboo.se>
 <20250103215904.2590769-3-jonas@kwiboo.se>
 <CAFLszTgehJLKF+ty4jig=JGpb9Z2rBu50+8_KcrX4ZzM4bD-Cw@mail.gmail.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <CAFLszTgehJLKF+ty4jig=JGpb9Z2rBu50+8_KcrX4ZzM4bD-Cw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 207.246.76.47
X-ForwardEmail-ID: 6779b4d77402a36e73d823be
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

On 2025-01-04 20:31, Simon Glass wrote:
> Hi Jonas,
> 
> On Sat, 4 Jan 2025 at 10:59, Jonas Karlman <jonas@kwiboo.se> wrote:
>>
>> GXBB BL1 only tries to read boot image from sector 0 on eMMC and sector
>> 1 on SD-card. GXL and newer read boot image from sector 1 on both eMMC
>> and SD-card.
>>
>> Vendor BL2 have solved the issue with different offsets by considering
>> where BL2 was loaded from to adjust the offset where BL3 is read from.
>>
>> This provide a different solution to create a boot image that can be
>> booted from both eMMC and SD-card and where the offset for reading next
>> stage loader can be shared for both boot options.
>>
>> Inject code, that relocate the payload located at 0x1200 offset in TZRAM
>> to the expected offset of 0x1000, into the padding area at offset 0x200
>> when a normal GXBB boot image is created. A special GXBB eMMC header can
>> then be created that have the payload offset point to this relocate
>> code, BL1 will jump to this relocate code when booted from eMMC instead
>> of the normal payload start. One effect of this is that the payload size
>> limit must be reduced by 512 bytes on GXBB.
>>
>> Example of how to use it:
>>   # Create a normal boot image
>>   tools/mkimage -T amlimage -n gxbb -d u-boot-spl.bin bl2.bin
>>
>>   # Create a boot image with a special eMMC header
>>   tools/mkimage -T amlimage -n emmc -d bl2.bin bl2-emmc.bin
>>
>>   # Write normal boot image to sector 1 of eMMC/SD-card
>>   dd if=bl2.bin of=/path/to/dev bs=512 seek=1
>>
>>   # Write eMMC header, 112 bytes, to start of eMMC
>>   dd if=bl2-emmc.bin of=/path/to/dev bs=1 count=112
>>
>> Or with binman using something like:
>>   binman {
>>         multiple-images;
>>
>>         u-boot-gxbb-sd {
>>                 filename = "u-boot-gxbb-sd.bin";
>>                 pad-byte = <0xff>;
>>
>>                 mkimage {
>>                         filename = "bl2.bin";
>>                         args = "-n", "gxbb", "-T", "amlimage";
>>
>>                         u-boot-spl {
>>                         };
>>                 };
>>         };
>>
>>         u-boot-gxbb-emmc {
>>                 filename = "u-boot-gxbb-emmc.bin";
>>                 pad-byte = <0xff>;
>>
>>                 mkimage {
>>                         filename = "bl2-emmc.bin";
>>                         args = "-n", "emmc", "-T", "amlimage";
>>
>>                         blob-ext {
>>                                 filename = "bl2.bin";
>>                         }
>>                 };
>>         };
>>   };
>>
>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>> ---
>>  tools/amlimage-gxbb-relocate.c | 79 ++++++++++++++++++++++++++++++++++
>>  tools/amlimage.c               | 37 ++++++++++++++++
>>  2 files changed, 116 insertions(+)
>>  create mode 100644 tools/amlimage-gxbb-relocate.c
>>
> 
> I sent [1] some years ago and would quite like to enable the odroid-c2
> in my lab. Is that an older version of what you are supporting here?

The amlimage type in this series is only for creating an image format
that the SoCs BootROM (BL1) can understand. This image type will most
likely only be useful together with Ferass El Hafidi's U-Boot SPL work
or for someone wanting to run bare metal code from SRAM on these SoCs.

Vendor bl2.bin blobs is based on TF-A, is already in correct image
format and expect next stage payload to be signed using a Amlogic FIP
format. For this you will still need to use vendor tools or open source
tools like meson-tools, gxlimg or meson64-tools.

The amlogic-boot-fip repo [2] has blobs, vendor tools and Makefiles to
combine the blobs with a U-Boot proper u-boot.bin to create a firmware
image that should boot for a wide range of boards.

[2] https://github.com/LibreELEC/amlogic-boot-fip

> 
> I heard that there are people working on open source tools, but it has
> been a few years and I'd be quite OK to just use vendor tools.

Open-source tools exist to replace the binary-only Amlogic tools:
- https://github.com/afaerber/meson-tools (GXBB, GXL & GXM only)
- https://github.com/repk/gxlimg (GXBB, GXL, GXM & AXG only)
- https://github.com/angerman/meson64-tools (developed for G12B, should work on G12A & SM1)

Would be nice if someone would combine those into a mkimage amlfip type
or similar (a different format than this amlimage format).

> 
> For your docs, could you put them in doc/ instead?

Not fully sure what you want me to put in doc/, please be specific. The
code comments and commit message should already document as much as
possible until there is upstream use of the GXBB eMMC header workaround.

At such time something like following could be documented:

  Write image to SD-card or eMMC module:
    dd if=u-boot-amlogic.bin of=/path/to/dev bs=512 seek=1 conv=fsync,notrunc

  Write the eMMC header to eMMC module:
    dd if=u-boot-gxbb-emmc.bin of=/path/to/dev bs=1 count=112 conv=fsync,notrunc

Until Ferass El Hafidi's U-Boot SPL work has made its way upstream such
commands and information would purely be speculative and will be easier
to document in a future series.

Regards,
Jonas

> 
> [..]
> 
> Regards,
> Simon
> 
> [1] https://patchwork.ozlabs.org/project/uboot/patch/20211124040954.699821-8-sjg@chromium.org/


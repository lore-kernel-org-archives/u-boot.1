Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 157E4CA5FCE
	for <u-boot@archiver.kernel.org>; Sun,  4 Oct 2026 23:16:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8B60F4067C;
	Sun,  4 Oct 2026 23:16:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sxulDYwAWX2j; Sun,  4 Oct 2026 23:16:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 8B7E940649
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791155807;
	b=N7npWuOASilYgnfpAWcT+uTDegZP1uW2rIKsF+6TC+10FFdkk/E9xkpM/Hrd8FWTIr3W
	 vUjbPcTH51QaMK18/LZaBSYRmamJz0u42o+tWootx+4Uq9rRMtEqURGO2x6L3cM5Un0w6
	 itrkgsB2H51JmI4SvEJnaLTuFVdc6RTkHYyx2NSBLq1B6zWr+az8lB1QaD4Nvm7kci3n4
	 8oSNVcoOM1s29y2Eob3vReMjqcxc8x/YV16fQveabLojmJdWawdrdTaeR+NTw1PA8CeP8
	 9BnFPUbYX9PE19S8fIOa+LzR5bO/PUsFHgPBchC13v3lNWaf7uVuFvXelZMzu7mfT1A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791155807;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:From:To:Cc:References:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=tCRrkjD7JeKhuhyfwNlxpP11TqUDJ/PCc8cpIjEO8s8=;
	b=TrKmoHywdZiWmlh9DgSVDrE/Vq90ZX7do/lz6lSyyW28JTkLZAPb1k5iaBooRqgWdqxm
	 UFU8ksuNDbeTAVYGTxGEhJPQtVrciV4snKiXIigGJhEjBPTPByrVXVWQveO+Xez71wvbT
	 vExdWAu1P8WaIHtE8Ppwgs5xcRj5juttY+HpT4qyUuyMG/dy6OZUHUUmZNGuoUzmX/UMK
	 VzQCHMN4Q5tE7kxePJEhd1+dBOBe9q/p2bpUPf5a7q88my46L5qmXTxx0TzfGqShgjFRv
	 +JxatiopBA3Fh751ggh+IbFDVEUL6VTBSOeDtXfuayYO0mG9YOftdnz3khKh9mQxECg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=pass header.from=freeshell.de;
	dkim=pass header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256 header.s=s2025 header.b=d7Z7WD90;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791155807;
	bh=tCRrkjD7JeKhuhyfwNlxpP11TqUDJ/PCc8cpIjEO8s8=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LkWJVAbpoA/oegLfQoBht5pBtlX3/nkwL4GTttmFN1Eq5GzVN0ERjo24HmirkwbGb
	 uV60XZkMa0nNbkdromWpjyDHPBQUa4tepzuD5K3NyEaGBVS/wCbQ2kdg4FDimRSFAE
	 KSzY44b/NGf6yN9ENUQ7WyIN1oXNK3MLv4tkL49oBArb7jBQwmyU2UydI1d38kJoup
	 wDmt/WToPIbpJblZB6dva3I5XIBBG24e4Htl6ntGGlKzC0AMOV1qEg2IG/qZulwNXt
	 Gj5E4MsGJFSJlTVxDYyI/Sqx5ll6H8XgmvZOSFxPN2xuJiuhGIP+68QTxpAMHBFFKj
	 3rYtfaNAO09UQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8B7E940649;
	Sun,  4 Oct 2026 23:16:47 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 45AD11A6
 for <u-boot@lists.u-boot-project.org>; Sun,  4 Oct 2026 23:16:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4330B40648
 for <u-boot@lists.u-boot-project.org>; Sun,  4 Oct 2026 23:16:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id p1SlGoiv75nC for <u-boot@lists.u-boot-project.org>;
 Sun,  4 Oct 2026 23:16:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org C67804065B
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a01:4f8:231:482b::2"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791155804;
 b=iE6VRjfSET3M0+wC4Ic63TEnMVA5vRhYZrFtv9UP4PM9Er6jXQWmpHtu1qdFacH0fhMO
 rPZpOz5g+e86SLONgToI/yiI39mPhCnH/bYALTvMjDheL375ee/HlgioqkLADvZhQNb+Q
 ixmvl1RqC39FhWcn8/vp8IIxFazs3WRXbPww6Vx9n6j5qzOmbyT4cIjVmMbgoTSkN81Ot
 vaRFXzXsRZ10qTgD7GMR5UDZUjdm5C6m0zlawnu4hqCeeYxnnoXNMyI+73HVhjodDfz0B
 CWNvfpoLyax5k6OIHmxoX/wTQeNYdw60z6U8jsrR3vFKqDcJeVXAuG9shnmgjRY0cGg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791155804;
 h=Received-SPF:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
 User-Agent:Subject:From:To:Cc:References:Content-Language:In-Reply-To:
 Content-Type:Content-Transfer-Encoding;
 bh=tCRrkjD7JeKhuhyfwNlxpP11TqUDJ/PCc8cpIjEO8s8=;
 b=NJ3LNCYvLUnwh8ufROzIq/PCBdY8lycKteIeKnY0kPHxGFJk8wFd7DTaqsUuw9/O5kjN
 nnpTZMJB7+pafxAmmqd+HEwuJflr9eN/J1yuAjtX0zwW5NRh6H15ryftmC7Lon9MGOHMl
 elutozqV12n8b5XPSd8HkcQZuyLCPfol2vV5wH9fT39nZQhaNHf3aLUqVHZWsquez8bwd
 38YTJd5Eo0kMrkbHkcGb0YIQxNpQvGlCRdvaDG8tBTlz6FdaZyuZpQZOLSx2iJ8c+TYrz
 nRDx9UcFbo9PR3WmA0xua23VQGbNjWHiV7igQaRAn43b12Mw/jyZfYQd/i+gNrk99jA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=freeshell.de; 
 dkim=pass header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b=d7Z7WD90; 
 arc=none smtp.remote-ip="2a01:4f8:231:482b::2"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:4f8:231:482b::2;
 helo=freeshell.de; envelope-from=e@freeshell.de; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=freeshell.de
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b=d7Z7WD90
Received: from freeshell.de (freeshell.de [IPv6:2a01:4f8:231:482b::2])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C67804065B
 for <u-boot@lists.u-boot-project.org>; Sun,  4 Oct 2026 23:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
 s=s2025; t=1791155776;
 bh=tCRrkjD7JeKhuhyfwNlxpP11TqUDJ/PCc8cpIjEO8s8=;
 h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
 b=d7Z7WD90F9CjzyJDdXKnEWDYowjpagDmHISxfD4SIozCuMlpCCxZ8lmWEg1qGZS7d
 JcyvLbEMzx8lRdUAFik96U5cJGocIlb9HA+rskDsDBNwJRzbpV+keBqW0jfz8mlw6k
 cUfjnYzvr8IwsGND7dr4c+ujl69/TPgzC1xcUIFjU7FMpe5wXHr6JnLQWS55fvQ8am
 reIh5shYz3QkhvZuHvyHDtc4HM6H4v6uZOYN553xkNvq04Rubxuav5wEeHQJB8qnbQ
 JIWC5ySN+xHoiPO9FMIqiZuqAdkNWXgOyr/TMZe7y4S2vMJfnDxzxo6iAA+k3TGnim
 0NKy7CuxanNNw==
Received: from [IPV6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc] (unknown
 [IPv6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 7E981B2204F9;
 Mon,  5 Oct 2026 01:16:14 +0200 (CEST)
Message-ID: <c20b8c2c-4f50-47e7-88fb-8305319d5a52@freeshell.de>
Date: Sun, 4 Oct 2026 16:16:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] doc: board: spacemit: document the SpacemiT boot
 image format
From: E Shattow <e@freeshell.de>
To: Junhui Liu <junhui.liu@pigmoral.tech>, u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Simon Glass <sjg@chromium.org>, Daniel Golle <daniel@makrotopia.org>,
 Randolph Sapp <rs@ti.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Kory Maincent <kory.maincent@bootlin.com>, Yixun Lan <dlan@kernel.org>,
 spacemit@lists.linux.dev
References: <20260909-spacemit-aihd-v2-0-780e98cf2fec@pigmoral.tech>
 <20260909-spacemit-aihd-v2-2-780e98cf2fec@pigmoral.tech>
 <95e17452-4f40-4e1e-96b5-3c83f4389005@freeshell.de>
Content-Language: en-US
In-Reply-To: <95e17452-4f40-4e1e-96b5-3c83f4389005@freeshell.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

On 10/4/26 14:22, E Shattow wrote:
> Hi Junhui,
> 
> On 9/9/26 08:51, Junhui Liu wrote:
>> Document the boot image layout shared by the SpacemiT K1 and K3
>> BootROMs, including the metadata headers and authentication areas.
>>
>> Describe the K3 non-secure CRC32 path supported by mkimage and provide
>> an example using the "smtimage" image type with "-n k3".
>>
>> Tested-by: E Shattow <e@freeshell.de>
>> Signed-off-by: Junhui Liu <junhui.liu@pigmoral.tech>
>> ---
>>  doc/board/spacemit/index.rst    |   2 +-
>>  doc/board/spacemit/smtimage.rst | 143 ++++++++++++++++++++++++++++++++++++++++
>>  2 files changed, 144 insertions(+), 1 deletion(-)
>>
>> diff --git a/doc/board/spacemit/index.rst b/doc/board/spacemit/index.rst
>> index a5e35ee12ab6..5797ada37d15 100644
>> --- a/doc/board/spacemit/index.rst
>> +++ b/doc/board/spacemit/index.rst
>> @@ -7,4 +7,4 @@ SpacemiT
>>  
>>     bananapi-f3
>>     k1-spl
>> -
>> +   smtimage
>> diff --git a/doc/board/spacemit/smtimage.rst b/doc/board/spacemit/smtimage.rst
>> new file mode 100644
>> index 000000000000..edcc3091e8e7
>> --- /dev/null
>> +++ b/doc/board/spacemit/smtimage.rst
>> @@ -0,0 +1,143 @@
>> +.. SPDX-License-Identifier: GPL-2.0-or-later
>> +
>> +SpacemiT boot image format
>> +=========================
>> +
>> +The SpacemiT K1 and K3 BootROMs load a SpacemiT boot image as the first-stage
>> +bootloader (FSBL), either from persistent storage or over USB in MaskROM mode.
> 
> Introduce the topic of SpacemiT boot image format without the unrelated
> boot flow. If the BootROM of both K1 and K3 are identical then use "K1
> and K3", else if they are distinct and being described sharing the same
> data structure format as input then use "K1 or K3".
> 
> Try instead, "BootROM on SpacemiT K1 or K3 System-on-Chip expects the
> First Stage BootLoader to be wrapped in a specially constructed image
> layout."
> 
>> +
>> +Image layout
>> +------------
>> +
>> +K1 and K3 share the same layout. A fixed 4 KiB prefix contains two 32-byte
> 
> Drop the redundant sentence "K1 and K3 share the same layout", as it is
> implied above and cannot be anything else by the later description.
> 
>> +metadata headers, key slots, and signature slots. The aligned SPL payload and
> 
> The reasoning of alignment should be written if it is known, by changing
> "The aligned SPL payload" to e.g. "The word-aligned SPL payload" or "The
> half-word aligned SPL payload" or "The nibble-aligned SPL payload" etc.
> whatever that is actually, or disregard my suggestion here if it is not
> known the reason for this.
> 
>> +a trailing authentication area follow::
>> +
>> +    offset                                    size
>> +    0x000  +-------------------------------+
>> +           | root RSA-2048 modulus         |  0x100
>> +    0x100  +-------------------------------+
>> +           | header0                       |  0x020
>> +    0x120  +-------------------------------+
>> +           | key-selection metadata        |  0x1e0
>> +    0x300  +-------------------------------+
>> +           | OEM public-key slots          |  0x800
>> +    0xb00  +-------------------------------+
>> +           | signature0                    |  0x100
>> +    0xc00  +-------------------------------+
>> +           | reserved                      |  0x3e0
>> +    0xfe0  +-------------------------------+
>> +           | header1                       |  0x020
>> +    0x1000 +-------------------------------+
>> +           | SPL payload (32-byte aligned) |
> 
> Keep as-is when discussing byte-layout to describe alignment as "n-byte"
> and not word or half-word or nibble etc. when considering my previous
> suggestion, FYI.
> 
>> +           +-------------------------------+
>> +           | signature1                    |  0x100
>> +           +-------------------------------+
>> +
>> +For payload size ``P`` and ``A = ALIGN(P, 32)``, the image size is
>> +``0x1000 + A + 0x100``.
>> +
>> +Metadata header
>> +---------------
>> +
>> +Both header0 and header1 use the following format:
>> +
>> +.. list-table::
>> +   :header-rows: 1
>> +
>> +   * - Offset
>> +     - Size
>> +     - Field
>> +     - Description
>> +   * - 0x00
>> +     - 4
>> +     - ``magic``
>> +     - ``AIHD``
>> +   * - 0x04
>> +     - 1
>> +     - ``version``
>> +     - Anti-rollback image version
>> +   * - 0x05
>> +     - 1
>> +     - ``secure``
>> +     - Zero selects anti-rollback bank 0
>> +
>> +       Non-zero selects anti-rollback bank 1
>> +   * - 0x06
>> +     - 2
>> +     - ``reserved``
>> +     - Reserved
>> +   * - 0x08
>> +     - 8
>> +     - ``image_size``
>> +     - header0: prefix information
>> +
>> +       header1: aligned payload size
>> +   * - 0x10
>> +     - 8
>> +     - ``load_addr``
>> +     - Unused by the common authentication code
>> +   * - 0x18
>> +     - 4
>> +     - ``header_crc``
>> +     - K3: CRC32 over header bytes ``[0x00, 0x18)``
>> +   * - 0x1c
>> +     - 4
>> +     - ``image_crc``
>> +     - K3: CRC32 over the payload in header1 only
>> +
>> +``header1.image_size`` records the aligned payload size and therefore
>> +determines the location of signature1.
>> +
>> +Authentication
>> +--------------
>> +
>> +K1 and K3 apply different authentication policies:
>> +
>> +.. list-table::
>> +   :header-rows: 1
> 
> list-table format on this axis orientation is confusing to review
> without first rendering the formatted output, and is a problem for
> 'diff' tool output in future changes. Please flip the axis i.e.:
> 
> Category 1
>   SoC 1
>   SoC 2
>   SoC 3
> 
> Category 2
>   SoC 1
>   SoC 2
>   SoC 3
> 
> Write instead this as:
> 
> SoC 1
>   Category 1
>   Category 2
> 
> SoC 2
>   Category 1
>   Category 2
> 
> SoC 3
>   Category 1
>   Category 2
> 
>> +
>> +   * - Area
>> +     - K1
>> +     - K3 non-secure boot mode
>> +     - K3 secure boot mode
>> +   * - Root and OEM keys
>> +     - RSA-2048 moduli with an eFuse root-hash check when secure boot is
>> +       enabled
>> +     - Unused
>> +     - RSA-2048 moduli with an eFuse root-hash check
>> +   * - Header CRC
>> +     - Not checked separately
>> +     - header1 verified
>> +
>> +       header0 ignored
>> +     - Both verified and covered by RSA
>> +   * - Image CRC
>> +     - Not checked separately
>> +     - Payload CRC32 in header1
>> +     - Covered by RSA but not checked separately
>> +   * - signature0
>> +     - Verified with the root key over ``[0x100, 0xb00)``
>> +     - Unused
>> +     - Verified with the root key over ``[0x100, 0xb00)``
>> +   * - signature1
> 
> Why the mixed-use of square brackets and parenthesis?
> 
>> +     - Verified with the SPL key over header1 and the aligned payload
>> +     - Unused
>> +     - Verified with the SPL key over header1 and the aligned payload
>> +
>> +K1 verifies both signatures even without a programmed root-key hash. In this
>> +case, the root key comes from the image and is not authenticated by hardware,
>> +so the image, keys, and signatures can be replaced together.
>> +
>> +K3 uses CRC32 in non-secure boot mode and hardware-rooted RSA in secure boot
>> +mode.
>> +
>> +Creating an image
>> +-----------------
>> +
>> +U-Boot currently creates only K3 images for non-secure boot mode. Package an
>> +SPL payload with::
>> +
>> +    $ tools/mkimage -T smtimage -n k3 -d u-boot-spl.bin FSBL.bin
> 
> Use lowercase letters for the output filename if it is not any CONFIG_
> symbol or preprocessor define symbol, and re-use an existing filename
> stem as for example any of:
> 
> u-boot-spl.smtimage
> u-boot-spl-mkimage.bin
> u-boot-spl.bin.smtimage
> spl.bin
> 
> A distro package of u-boot or later user of the build system may copy
> this output to "FSBL.bin" but that is nothing to do with us here. In
> fact for documentation purpose here it is useful to retain "FSBL.bin" as
> a distinct description of the vendor firmware SPL and not get this
> confused for mainline u-boot.
> 
>> +
>> +K1 images and RSA-authenticated K3 images are not yet supported.
>>
> 
> This statement may be simply deleted. It is obvious that support does
> not exist when it is not described here. If you would like to keep this
> line it is not any problem. I think it is more unnecessary work for
> later to update and remove it.
> 
> -E

P.S. I somehow miss there is v3 of this series posted due to mail
configuration problem, ignore this response to v2 and I will re-send as
review of v3. Sorry for the noise. -E

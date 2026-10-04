Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4D16CA5FF0
	for <u-boot@archiver.kernel.org>; Sun,  4 Oct 2026 21:23:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 913214067C;
	Sun,  4 Oct 2026 21:23:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IQHjizIH5zo1; Sun,  4 Oct 2026 21:23:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 4E3AD40687
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791149008;
	b=nanI/mqfXlORWMaldbyN94VEvnGOINcDjJ+fjTrLWxXCFT+8IFO8fyBIjWBm8HDh71QU
	 YQxIdizKCGcwxGN5gsX3xEjKAegv7qIJRYSAM8uvRN0bSWyOal1K+P6Y3p9hE3RH10c/p
	 44bQreWA+A43lbUQCz45JZ+jdzHsZIpYz8nuD2Rmh8SeW85blzsKXVEAvDYFFIsaA9THe
	 ZAGDBqPEvBPPXdMPuF0im2IEN+uGJeGELh7xOh+KMu9L9Zw2cFWK03unXK5dsLLqkqKnz
	 k+p12jU54abUfWijXRsPmEJ4WTpn0etW0qLRuy8Zx/xUhcmEIJSDmkWJl0syq34bfwQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791149008;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=/OUHZFnIbV9AReA94bQ08fxAoIzWGAOEjs0GbrA4Vo4=;
	b=n2fLHg4uWx0prEuV0kcQC4TDZS7tQu4NQwtglChvKXbXCGKKp2qBOwi9vomYyveAcpRg
	 mBJ8sW6u3HvOBL9tlYr1kG5Uau2UJhIszA2PLBDvStCtiaySBBZ+cWxv/jlyY6qBTZfFa
	 ncuKBJk26Heov52TPBTuHcWoeIgxp0CLTYmc7lRDo7yCAxY+gPlOyhcil7ugJ+M8JIfrO
	 v0sqPFmeifFnO/3/Ksvgk9SNjCOhn0K7Nq2CKO70CwbXnhp53ZJsYt14TVTqkrnymR+kz
	 opGrnaQAhil/jfZDtdtwtTuONDuwVtJKHh5YQxeIlOAC6PUZQscF/5ZtQFYZ9D3W2JA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791149008;
	bh=/OUHZFnIbV9AReA94bQ08fxAoIzWGAOEjs0GbrA4Vo4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ybkeAGjFvX5pExbgY5Lym/Hhf/CTD4T1M3tCOQJcaVZ9wkgkmTrZqYIws/aDFDRor
	 pC6SiJpTDcIGn+d+ftPjMxHN05lVPuoWpKER9p90XZNmU+BzNt+TKedCxoT67wxRzH
	 xAyoH/iUNYApZtmKhy44jTOXjxSRR9RN+Ih/6TNQHcjVtUFNJ5aMItfY4cZhMF2Ons
	 6Ytpl+9Leev8gQVNgSlNddbYgXJx3s+XieslnS49rfW5LjttrclJArR0ufAy2kqP6M
	 psOM4Rhe/zkhbEdaqCTYXZhxAm5nhRviMoRvGHkwx1eRO3T38fC4cSAPaTD1Fm199E
	 /Z7+tZFNjgpCQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4E3AD40687;
	Sun,  4 Oct 2026 21:23:28 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 026B232F
 for <u-boot@lists.u-boot-project.org>; Sun,  4 Oct 2026 21:23:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DC12340049
 for <u-boot@lists.u-boot-project.org>; Sun,  4 Oct 2026 21:23:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HknkB2We517A for <u-boot@lists.u-boot-project.org>;
 Sun,  4 Oct 2026 21:23:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org BC3F440004
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=116.202.128.144
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791149005;
 b=f0ckaofz93xMUkfEbJyhCcT66Kxr76qkUALOr5Qv+sa7YezFAAxKg8LLVDw8ujvE2dAD
 HPWlX4vkrU6mUfxXvAtVPks9mBYXPJb0HJbEiM4vMWylCsqQFy8vzlVddr2dFcBlxFG8X
 hXv4OBBrchPWt8wKkFX2Qg5rhttlUIipPY+rnsYWpVa6EZIY8pV9gep1jpwKiqs91lpPb
 wtsGp0esqq/HDBg2a3F4UAyal8J/OjXsrJb37t3e+bfcVezEHcewQny89Uhsk9bRw8ro5
 TIVI+2ceHgb25EPW3BFOHQsoOFN4YuIdoCEO9DxGn2fLdV22vQTSTlU0JWWFOxtOOvg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791149005;
 h=Received-SPF:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding;
 bh=/OUHZFnIbV9AReA94bQ08fxAoIzWGAOEjs0GbrA4Vo4=;
 b=lwslOL+X3I0ABBJT/gK0eiJe0j7FJJp+w8uKwdCcFdjShcR0bGt5M7SS3j0kuaImQUip
 uv2pCHp683EhgJBddJ/ovyiMJ/pyPX6D3k3dVspFxsGwz4LK7Qc8k/HZEvf5UQh/FOyG3
 Etvjz2qqP0ywIHX7OVvmTe2BThz7nUTTF/btPGxd+10tHZ8/xFWw11saU619vip31GE6j
 nNkrLM5rMhFRxSyDv5/Ns+MHurOsriuDpRpWOzd8rofmf3N/3tXPvbCHrbI+Hl2azP01k
 Zer9JmkmMgwX8pfy996KzTP+iLsR+qGUSwECgGc8nt69NoqNRMVFzu2SJVa0L3GJpXw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=freeshell.de; 
 dkim=pass header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b=ZKsaRWB2; 
 arc=none smtp.remote-ip=116.202.128.144
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=116.202.128.144;
 helo=freeshell.de; envelope-from=e@freeshell.de; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=freeshell.de
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b=ZKsaRWB2
Received: from freeshell.de (freeshell.de [116.202.128.144])
 by smtp2.osuosl.org (Postfix) with ESMTPS id BC3F440004
 for <u-boot@lists.u-boot-project.org>; Sun,  4 Oct 2026 21:23:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
 s=s2025; t=1791148966;
 bh=/OUHZFnIbV9AReA94bQ08fxAoIzWGAOEjs0GbrA4Vo4=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=ZKsaRWB2Y+Ej5oPOJNTY5vcks1khVooolSRqlHoqit3WApGzx6pa2C4Z+mXKl53Vm
 /UKhYULEQM+BFDV0IHBUwSyHLnLYCgs3N/yCjyVxX7LLjacicjXPcdRRyCMUvVrD35
 UJETwum44MOpGcpczMRT6HGg7BVRtjcE1qNHa7Tu19NkchrroiFUam65W48kQk3zhe
 uo55uy891z657/mOL/xDj7Sl8Wne+bc2NcsNUHC4SItFx0K455eezOrTFserlm2J45
 d85s/3B5wTl4q/RtWqSiOD4YM4EXvGACGkRd8f9wMwTvH4RlkOAPSWoO89gbiW9ZHJ
 gQIqs7rpoNAYw==
Received: from [IPV6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc] (unknown
 [IPv6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id B1008B220271;
 Sun,  4 Oct 2026 23:22:44 +0200 (CEST)
Message-ID: <95e17452-4f40-4e1e-96b5-3c83f4389005@freeshell.de>
Date: Sun, 4 Oct 2026 14:22:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] doc: board: spacemit: document the SpacemiT boot
 image format
To: Junhui Liu <junhui.liu@pigmoral.tech>, u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Simon Glass <sjg@chromium.org>, Daniel Golle <daniel@makrotopia.org>,
 Randolph Sapp <rs@ti.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Kory Maincent <kory.maincent@bootlin.com>, Yixun Lan <dlan@kernel.org>,
 spacemit@lists.linux.dev
References: <20260909-spacemit-aihd-v2-0-780e98cf2fec@pigmoral.tech>
 <20260909-spacemit-aihd-v2-2-780e98cf2fec@pigmoral.tech>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <20260909-spacemit-aihd-v2-2-780e98cf2fec@pigmoral.tech>
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

Hi Junhui,

On 9/9/26 08:51, Junhui Liu wrote:
> Document the boot image layout shared by the SpacemiT K1 and K3
> BootROMs, including the metadata headers and authentication areas.
> 
> Describe the K3 non-secure CRC32 path supported by mkimage and provide
> an example using the "smtimage" image type with "-n k3".
> 
> Tested-by: E Shattow <e@freeshell.de>
> Signed-off-by: Junhui Liu <junhui.liu@pigmoral.tech>
> ---
>  doc/board/spacemit/index.rst    |   2 +-
>  doc/board/spacemit/smtimage.rst | 143 ++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 144 insertions(+), 1 deletion(-)
> 
> diff --git a/doc/board/spacemit/index.rst b/doc/board/spacemit/index.rst
> index a5e35ee12ab6..5797ada37d15 100644
> --- a/doc/board/spacemit/index.rst
> +++ b/doc/board/spacemit/index.rst
> @@ -7,4 +7,4 @@ SpacemiT
>  
>     bananapi-f3
>     k1-spl
> -
> +   smtimage
> diff --git a/doc/board/spacemit/smtimage.rst b/doc/board/spacemit/smtimage.rst
> new file mode 100644
> index 000000000000..edcc3091e8e7
> --- /dev/null
> +++ b/doc/board/spacemit/smtimage.rst
> @@ -0,0 +1,143 @@
> +.. SPDX-License-Identifier: GPL-2.0-or-later
> +
> +SpacemiT boot image format
> +=========================
> +
> +The SpacemiT K1 and K3 BootROMs load a SpacemiT boot image as the first-stage
> +bootloader (FSBL), either from persistent storage or over USB in MaskROM mode.

Introduce the topic of SpacemiT boot image format without the unrelated
boot flow. If the BootROM of both K1 and K3 are identical then use "K1
and K3", else if they are distinct and being described sharing the same
data structure format as input then use "K1 or K3".

Try instead, "BootROM on SpacemiT K1 or K3 System-on-Chip expects the
First Stage BootLoader to be wrapped in a specially constructed image
layout."

> +
> +Image layout
> +------------
> +
> +K1 and K3 share the same layout. A fixed 4 KiB prefix contains two 32-byte

Drop the redundant sentence "K1 and K3 share the same layout", as it is
implied above and cannot be anything else by the later description.

> +metadata headers, key slots, and signature slots. The aligned SPL payload and

The reasoning of alignment should be written if it is known, by changing
"The aligned SPL payload" to e.g. "The word-aligned SPL payload" or "The
half-word aligned SPL payload" or "The nibble-aligned SPL payload" etc.
whatever that is actually, or disregard my suggestion here if it is not
known the reason for this.

> +a trailing authentication area follow::
> +
> +    offset                                    size
> +    0x000  +-------------------------------+
> +           | root RSA-2048 modulus         |  0x100
> +    0x100  +-------------------------------+
> +           | header0                       |  0x020
> +    0x120  +-------------------------------+
> +           | key-selection metadata        |  0x1e0
> +    0x300  +-------------------------------+
> +           | OEM public-key slots          |  0x800
> +    0xb00  +-------------------------------+
> +           | signature0                    |  0x100
> +    0xc00  +-------------------------------+
> +           | reserved                      |  0x3e0
> +    0xfe0  +-------------------------------+
> +           | header1                       |  0x020
> +    0x1000 +-------------------------------+
> +           | SPL payload (32-byte aligned) |

Keep as-is when discussing byte-layout to describe alignment as "n-byte"
and not word or half-word or nibble etc. when considering my previous
suggestion, FYI.

> +           +-------------------------------+
> +           | signature1                    |  0x100
> +           +-------------------------------+
> +
> +For payload size ``P`` and ``A = ALIGN(P, 32)``, the image size is
> +``0x1000 + A + 0x100``.
> +
> +Metadata header
> +---------------
> +
> +Both header0 and header1 use the following format:
> +
> +.. list-table::
> +   :header-rows: 1
> +
> +   * - Offset
> +     - Size
> +     - Field
> +     - Description
> +   * - 0x00
> +     - 4
> +     - ``magic``
> +     - ``AIHD``
> +   * - 0x04
> +     - 1
> +     - ``version``
> +     - Anti-rollback image version
> +   * - 0x05
> +     - 1
> +     - ``secure``
> +     - Zero selects anti-rollback bank 0
> +
> +       Non-zero selects anti-rollback bank 1
> +   * - 0x06
> +     - 2
> +     - ``reserved``
> +     - Reserved
> +   * - 0x08
> +     - 8
> +     - ``image_size``
> +     - header0: prefix information
> +
> +       header1: aligned payload size
> +   * - 0x10
> +     - 8
> +     - ``load_addr``
> +     - Unused by the common authentication code
> +   * - 0x18
> +     - 4
> +     - ``header_crc``
> +     - K3: CRC32 over header bytes ``[0x00, 0x18)``
> +   * - 0x1c
> +     - 4
> +     - ``image_crc``
> +     - K3: CRC32 over the payload in header1 only
> +
> +``header1.image_size`` records the aligned payload size and therefore
> +determines the location of signature1.
> +
> +Authentication
> +--------------
> +
> +K1 and K3 apply different authentication policies:
> +
> +.. list-table::
> +   :header-rows: 1

list-table format on this axis orientation is confusing to review
without first rendering the formatted output, and is a problem for
'diff' tool output in future changes. Please flip the axis i.e.:

Category 1
  SoC 1
  SoC 2
  SoC 3

Category 2
  SoC 1
  SoC 2
  SoC 3

Write instead this as:

SoC 1
  Category 1
  Category 2

SoC 2
  Category 1
  Category 2

SoC 3
  Category 1
  Category 2

> +
> +   * - Area
> +     - K1
> +     - K3 non-secure boot mode
> +     - K3 secure boot mode
> +   * - Root and OEM keys
> +     - RSA-2048 moduli with an eFuse root-hash check when secure boot is
> +       enabled
> +     - Unused
> +     - RSA-2048 moduli with an eFuse root-hash check
> +   * - Header CRC
> +     - Not checked separately
> +     - header1 verified
> +
> +       header0 ignored
> +     - Both verified and covered by RSA
> +   * - Image CRC
> +     - Not checked separately
> +     - Payload CRC32 in header1
> +     - Covered by RSA but not checked separately
> +   * - signature0
> +     - Verified with the root key over ``[0x100, 0xb00)``
> +     - Unused
> +     - Verified with the root key over ``[0x100, 0xb00)``
> +   * - signature1

Why the mixed-use of square brackets and parenthesis?

> +     - Verified with the SPL key over header1 and the aligned payload
> +     - Unused
> +     - Verified with the SPL key over header1 and the aligned payload
> +
> +K1 verifies both signatures even without a programmed root-key hash. In this
> +case, the root key comes from the image and is not authenticated by hardware,
> +so the image, keys, and signatures can be replaced together.
> +
> +K3 uses CRC32 in non-secure boot mode and hardware-rooted RSA in secure boot
> +mode.
> +
> +Creating an image
> +-----------------
> +
> +U-Boot currently creates only K3 images for non-secure boot mode. Package an
> +SPL payload with::
> +
> +    $ tools/mkimage -T smtimage -n k3 -d u-boot-spl.bin FSBL.bin

Use lowercase letters for the output filename if it is not any CONFIG_
symbol or preprocessor define symbol, and re-use an existing filename
stem as for example any of:

u-boot-spl.smtimage
u-boot-spl-mkimage.bin
u-boot-spl.bin.smtimage
spl.bin

A distro package of u-boot or later user of the build system may copy
this output to "FSBL.bin" but that is nothing to do with us here. In
fact for documentation purpose here it is useful to retain "FSBL.bin" as
a distinct description of the vendor firmware SPL and not get this
confused for mainline u-boot.

> +
> +K1 images and RSA-authenticated K3 images are not yet supported.
> 

This statement may be simply deleted. It is obvious that support does
not exist when it is not described here. If you would like to keep this
line it is not any problem. I think it is more unnecessary work for
later to update and remove it.

-E

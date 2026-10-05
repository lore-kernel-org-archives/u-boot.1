Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C508DCA5FF5
	for <u-boot@archiver.kernel.org>; Mon,  5 Oct 2026 00:41:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E95A980D29;
	Mon,  5 Oct 2026 00:41:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4ZX0g7NJXcig; Mon,  5 Oct 2026 00:41:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org DCBDA80D1C
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791160869;
	b=ON9c2ir2xJrCXss/sbmcJKh/l+GRQtP/G7jJ0AEb2Z/zosYkVKLF9uq6uHZ9TtBtjqOy
	 DcUHEkcGNIPc7+bIpiqyAwCuR+xmuGmxAxkypI5vz6WuDKRvLYB8rWRpm5r9CnApMbW0J
	 dx6Uvvv7HXgg/cXDp9YAuJi92JPDcbUS057z2PUdzwkBjrDXF+OXPq5R69J2HLNzxgfMy
	 YD74nnnx9HZzJOeDiNbZVHhO45lUWULt3ny4BY7cOa+B2iQXAbfbrKMjSp7Agm8emIPHB
	 g39ng6z5jZrkHU8wjUx6mJfbsfx1mew/KwZG2PR+eIINVae1DqqEjf2ffqMXpn3aJLQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791160869;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=QLEvGHaVfiQz8fa/G0GAU36A7Zcf4zBqCnZtcMywtuY=;
	b=DUwwWIEM0aKS8xShFS+5RcqfaL3Z+GgBHziqLgRKUmAKEEViAOOlW4sK398fTfktxTxT
	 ZxVL4jqBJVZSPBdoCQhXKE0FchzXOUD5IrjZwCGLkMi2kMdJIGPtTZnrNuP4V24/0MlQP
	 c5EDeeAPBs2Bgr7pnuGbNc7CsAsjaXqjHKSICjY/zpkemsEkLeDNHeEWT+X9fX61ZxS6K
	 mNDmihWwEmqBZNjlQ+ThVaiSxcrwGSrth0FppBt9NfgARx3HgHr/uItP91Mug1yhFja42
	 TOf+C8YJynfvg5pR+39rm0aaRPva515SaG1lyS8bybGXCgS7GLlcEBfP0XJATW6Vu8w==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=pass header.from=freeshell.de;
	dkim=pass header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256 header.s=s2025 header.b=Nv+XLF3v;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791160869;
	bh=QLEvGHaVfiQz8fa/G0GAU36A7Zcf4zBqCnZtcMywtuY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=P6qSOodUVN4htf4fCxqOxbx6VtmHsmnz7J0r5rSvJe39acYHVcaXIUlmXV/PIUAua
	 coLjAgaSDdPAqWXnTyyLKjZ2KPi5lX0kzHoNoc9W7ZtkV+lEq6lf++qCWiEC7/Spln
	 E1BWeNaadno4V+5Gyenlny2KAYIgaC3MFuSvZHMNhlRToXCR5HrFk6GL2tovdhrQOr
	 oTt5oXHgKufYK7bBh47Xqq2PjVTXjE5zewgZWduou9VLLN5mF3RHhxy7NaYuRLevZh
	 Jq3N907h938cjcXtKrPXt79QaJSma3xA0Zenetee1NqkFkAeX/UWdmY6uObu4MZ5+S
	 qwt+g9nywTrBA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id DCBDA80D1C;
	Mon,  5 Oct 2026 00:41:08 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id B03832E0
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 00:41:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9559180D1C
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 00:41:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UBB82dG_eoXM for <u-boot@lists.u-boot-project.org>;
 Mon,  5 Oct 2026 00:41:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org B356880CF0
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a01:4f8:231:482b::2"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791160866;
 b=DpHZElaJGqJCm98T+8jFB4/JPLad9Xx1N4zdibLkso6gQc1P/Mvuj36DP5PNDY3E+mdQ
 FX2OLM+bMVP3v6nsKF4kEX4otz6lwPzL8jUOwy6c/jhAspWik+UvwFTiUFF6iRSQwICNN
 bowxhvyVP2rjaWmMb7KQ1Oze7phwOKrg+Evsj1qsjvvszfisapTthkkYhVI1mh4nrP0qL
 PRcwJ7plMT6UgFrebz7M05N+WoazsTWspweTvCCpI+KkHxLNATVRf/iV7hfnqgHMBnHgc
 ylbIfki7O/CC89GUPOFkWFXyCTpYYWu2efQ7FXmZl72hFNlcajm0N5vaXLI9U7JQUvA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791160866;
 h=Received-SPF:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding;
 bh=QLEvGHaVfiQz8fa/G0GAU36A7Zcf4zBqCnZtcMywtuY=;
 b=eWvk77SUPAWzegeYSjB2ZnY+zdiDDjH3wY+Bcwk7saq9MsUgVyZKFovWaButW8MWxWFc
 6lsUrC9DugMnv31PO/aQ0ZgHLLNBw2Fpynmn9vFr3utrZJCXWhj3sulTW1WfHqMJeDtH6
 0fGoPczkA1kTcI2JbppwJn4YRv+MSEcJLw6YG6+yxagrmHnmbBF0QB1l5ER4HXXZQnkvY
 OBVtacWhv38v86Tr678Kfa1x541KfkZyPMh2UKmVbqKkHX8hOsKdIshJmpyNdYBQd2MZl
 TLmW3YymptZu0QL8qTjEqcZrW1HKFyxdlwhLPTJH7ry9iKiIhOWObVvjwGyinZnqLvA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=freeshell.de; 
 dkim=pass header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b=Nv+XLF3v; 
 arc=none smtp.remote-ip="2a01:4f8:231:482b::2"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:4f8:231:482b::2;
 helo=freeshell.de; envelope-from=e@freeshell.de; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=freeshell.de
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b=Nv+XLF3v
Received: from freeshell.de (freeshell.de [IPv6:2a01:4f8:231:482b::2])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B356880CF0
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 00:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
 s=s2025; t=1791160836;
 bh=QLEvGHaVfiQz8fa/G0GAU36A7Zcf4zBqCnZtcMywtuY=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=Nv+XLF3vPODlmc6fX/cgp/L1ii00yXX+58i9WwQHVnnKo65E/Zb9GAYRgBE1oVaHw
 hmLvsVBxPqQqaKicGXiccWtIDRcfbOz1Cmt0VxD7WssebMQSLOGr6gp/uCcImwqg2g
 D/5bMToMvdmBNUh8ahh5v8vwPz2Ov/P0MQyGs8GVKSpe4wSTwOEvDLUiNsaFTN5jiX
 DeCJoW26CgA8n5bH21hXI1tJv9wsfATDlDZFf2yVy6qzuU4PcFNHbtzJ9aWo6qMMHY
 YF7CHwjsw4pRZocM3PIncqYs7Bt+1ouu8pwXmh680RhlwbDo/nI3afF5PyQqlTsY4X
 kyeC7XwxZSvCA==
Received: from [IPV6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc] (unknown
 [IPv6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id B3EE0B2200D9;
 Mon,  5 Oct 2026 02:40:34 +0200 (CEST)
Message-ID: <24dbd483-6b93-4d68-ae5b-e61f2af66857@freeshell.de>
Date: Sun, 4 Oct 2026 17:40:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] doc: board: spacemit: document the SpacemiT boot
 image format
To: Junhui Liu <junhui.liu@pigmoral.tech>, u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Simon Glass <sjg@chromium.org>, Daniel Golle <daniel@makrotopia.org>,
 Randolph Sapp <rs@ti.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Kory Maincent <kory.maincent@bootlin.com>, Yixun Lan <dlan@kernel.org>,
 Yao Zi <me@ziyao.cc>, spacemit@lists.linux.dev
References: <20260921-spacemit-aihd-v3-0-f660fc85d2a5@pigmoral.tech>
 <20260921-spacemit-aihd-v3-2-f660fc85d2a5@pigmoral.tech>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <20260921-spacemit-aihd-v3-2-f660fc85d2a5@pigmoral.tech>
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

On 9/21/26 07:54, Junhui Liu wrote:
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
> index 000000000000..19a5c9972f75
> --- /dev/null
> +++ b/doc/board/spacemit/smtimage.rst
> @@ -0,0 +1,143 @@
> +.. SPDX-License-Identifier: GPL-2.0-or-later
> +
> +SpacemiT boot image format
> +==========================
> +
> +The SpacemiT K1 and K3 BootROMs load a SpacemiT boot image as the first-stage
> +bootloader (FSBL), either from persistent storage or over USB in MaskROM mode.

"BootROM on SpacemiT K1 or K3 System-on-Chip expects the First Stage
BootLoader to be wrapped in a specially constructed image layout." and
delete the unrelated fact about boot flow.

> +
> +Image layout
> +------------
> +
> +K1 and K3 share the same layout. A fixed 4 KiB prefix contains two 32-byte

Delete redundant sentence "K1 and K3 share the same layout", as it is
implied above and cannot be anything else by the later description.


> +metadata headers, key slots, and signature slots. The aligned SPL payload and
> +a trailing authentication area follow::

The architectural reasoning of payload alignment should be part of this
sentence if it is known. From my experience looking at disassembled
BootROM of another SoC there is a trend of structs and string data
sections to be extended to 8-byte alignment (word-aligned for 64-bit
RISC-V); Why would the payload be extended to quad-word alignment, is
this related to the NOR flash page size and/or a cryptography
requirement? Disregard my inquiry here if it is not known the reason for
this.

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

Keep "n-byte" as-is when discussing byte-layout to describe alignment
and not i.e. word or half-word or nibble etc. considering my previous
suggestion.

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

The previous list-table of offsets is okay for review and diff output,
however the following list-table is not acceptable.

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

Why the mixed-use of square brackets and parenthesis?

> +   * - signature1
> +     - Verified with the SPL key over header1 and the aligned payload
> +     - Unused
> +     - Verified with the SPL key over header1 and the aligned payload
> +

I don't know what is preferred here by documentation reviewers but this
above list-table is not reviewable as-is. Maybe try to flip the axis, or
split into a series of tables as one-per-name of K1, K3 non-secure boot
mode, and K3 secure boot mode?  The purpose of restructuring this should
be readability before being rendered, and minimal 'diff' impact for
future changes.

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
line it is not any problem. Similarly for the sentence "U-Boot currently
creates only K3 images for non-secure boot mode." which is not really
accurate to say, as there is no makefile target or binman setup for any
of this yet. Technically U-Boot does nothing at all regarding this
documentation. It would just have to be more diff lines to review later
and can be omitted now.

-E

Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36AB9CA5FCE
	for <u-boot@archiver.kernel.org>; Mon,  5 Oct 2026 04:25:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D1EED80CC2;
	Mon,  5 Oct 2026 04:25:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6INETdNXOU0f; Mon,  5 Oct 2026 04:25:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 0D99080CB6
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791174351;
	b=RFZrNCck6UnsbJ2oCMdF0cTWhoksJLlKk90CVv19cFePiSZSdxafH99bIQRIFPFr+p47
	 1HktxnjUAr71mgkkL2vrsKEHvue/eLwNT/yIeyvpy5V3RQKaaFM4t2sfexsSuqng7M24z
	 wa7Nya3wc9zAcDHx+7C1vi94WAyalxpF8LhBAiwF7dachJYEQUFmW4d6BzLvZ2FcZN7tO
	 KajDMfRKZgyLZ0lPcY7OWzBNDRQ8UvpWa1Rxp1OvPuVfQAj4msBGW+sm30zL0G/sAATq9
	 4+FAev/njeWdtLg7DMygt/ofG7YcetO/ABWx/VoXY4JPFHfbyO7qcaIYpieDbLxTlMw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791174351;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Mime-Version:Content-Transfer-Encoding:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:X-Mailer:References:
	 In-Reply-To:X-ZohoMailClient:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=U0GicZGauaqC5KguU2OElXVN4VBE7ExIoCC9RItBHfE=;
	b=a2RYv5GwWXi6nE3oirYf1pJ2dUKcdWLLUzA+fvIw1GYOoc3ApQJyXjJRUowqnoIbMRMM
	 Y5CNkxXMOpZ2HUgZVsjtR0+S7nU+1xh6gfYR2CnlZxLVvpqAw4svFQiZGQoiVW0c0tVmR
	 RirQYe6Zb/NjXQcuqNdUNjjRvs+PX59O/TTRJC05oZKKyPvOzeVNgwzLYJwfjnYkVpt7J
	 692i8OO1aXl/ghgTMRZhJBX/KSk3g0m+WuHtVmTfj+PUkAQRjj+x9fsIpja/5qeU0w7mh
	 jbfCiqpWVtuPc2jrzoCdiV1e8e/LkepbwQPVVWzL6nzU6oE4rab6ZapqhEsmiKtcS6g==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791174351;
	bh=U0GicZGauaqC5KguU2OElXVN4VBE7ExIoCC9RItBHfE=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kotvHEoaoTAwLco5CPzhSk+pc6Ykc4wqu3JTeuGAFi5WxNbkoA8TWglWdLi0kmtZU
	 eze3kNm0YnGViTW7aiuUbn7B6kMW0qskmMan4893T6o38HC2qW8KiiQFm02N1rTO5U
	 IPhXp1qFXMnKETEA/qizh+j/DeEAMBvO8AwhM3nUDVP4FoxYa3wiVc1wGpI0zUMRyC
	 kG4kP6PQNaeHgQT/2nfcWhNS9CneRTZmA9jlCP+GZrQ7w83s6utvJNu2qxKCMmSju2
	 oTSj7BKMJySD7lB3IA7maTtNqOV6oA3Ir4ILBtX23YlxMt9ikMjIEdRI0Bba9F8sC6
	 sRwexuzdRkj7w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0D99080CB6;
	Mon,  5 Oct 2026 04:25:51 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id D99371A6
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 04:25:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B36674007E
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 04:25:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id whth2sF80Fej for <u-boot@lists.u-boot-project.org>;
 Mon,  5 Oct 2026 04:25:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 13ECC40068
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.182.15
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791174347;
 b=pZMDLfUaEmP9NFmEVEIlw5DEvx6Uo6FdKKi4iP37zYV+3wRYj+CjJ7k2yxgwbl7J/41m
 uJ+vs/GaoUPYfdv2+dTDeKArrR3ZIeNstWXk4fHfR1LKkOY3by+F+sMu68r7Zt9dOZlsP
 3jJkcsP/6tHSccX2oYxhwMMckvhE5wvLIFEBobu6U8L55zLhhUMzDCZdkcwa3aimP1mv2
 kDqIcxV/vS7/RkCyBv6TbOpplFrcuEVeFRdPeCBvLG/Grz9gU1YqzwItjvUtoeOaRTZf2
 G08i1HaraAEDEhy6IrgMKDNs6pk5EHkdGUKrOC4nMLK7vBeoeZtUDdK/AGD94n0F2TQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791174347;
 h=Received-SPF:DKIM-Signature:Received:Mime-Version:
 Content-Transfer-Encoding:Content-Type:Date:Message-Id:Cc:Subject:
 From:To:X-Mailer:References:In-Reply-To:X-ZohoMailClient;
 bh=U0GicZGauaqC5KguU2OElXVN4VBE7ExIoCC9RItBHfE=;
 b=si4CyUo49Z/gXwADiCEbuvL8t1x96BDK7AtTuXKe7Z9i7G+C3UrXmc1gGnXSLz6NDDEQ
 vcDcKJMIugadjdOubEG9Tj8ycT3VFAhDLR0zv3LbFPYJ0eauS0amzDdRyNJkIfpKyRYjb
 r7TIFq9evwZM1PH2Nu1C0cewoB7y9DlRAHfH6DiJjgSqP23Ueoq17peL70+RSzNBvgzAO
 jHiiqiXar2A9QmfGjKe/3K0fnI/LjU9iz0b+KdIbRDZ2SwvphGt07kUBsQpm02mT9TjAR
 MRhuamTLX5CfTJ/dVOI8Rtv0ug05sRI7SIHMxXc5vJNeNK6kXali03x4nijBR49N8uw==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=none header.from=pigmoral.tech; 
 dkim=pass header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech
 header.a=rsa-sha256 header.s=zmail header.b=fMOO+gK7; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.15
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.182.15;
 helo=sender5-op-o15.zoho.com; envelope-from=junhui.liu@pigmoral.tech;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=pigmoral.tech
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech
 header.a=rsa-sha256 header.s=zmail header.b=fMOO+gK7
Received: from sender5-op-o15.zoho.com (sender5-op-o15.zoho.com
 [165.173.182.15])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 13ECC40068
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 04:25:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1791174309; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=EDrKik3yTxUteYsRA8ngvNZwOqL53v4dR5763I24BKjrVrlA5ypcmd/4BYuF96oYAM45M7Hj7s5jLIN5nFJdVG1FLPoJHDoTqLS/tsUX0p/zN/cXKA9PeK6IF2EBRL7PJTTKZBUfPTb3pqI1Dm1x56lDsQT2Ow4gh18EQ66y0uU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1791174309;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=U0GicZGauaqC5KguU2OElXVN4VBE7ExIoCC9RItBHfE=; 
 b=XI5hb/YwIv9YkZJnbUaDKtU9MS7hTUcQ8LzgnfU696CAEiZYHuxaqn3A+c4BykFhCyfEedvOKTj2ayYEQyFUwyOf36+Olqxy586uBMsZJPh4hHnwe7L/n0g18RUQ1D9IaxKtiPaZG52OSrk2m5ekwKaxfzTjSzpOW2MGJ8k6MQM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=pigmoral.tech;
 spf=pass  smtp.mailfrom=junhui.liu@pigmoral.tech;
 dmarc=pass header.from=<junhui.liu@pigmoral.tech>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1791174309; 
 s=zmail; d=pigmoral.tech; i=junhui.liu@pigmoral.tech;
 h=Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Date:Message-Id:Message-Id:Cc:Cc:Subject:Subject:From:From:To:To:In-Reply-To:Reply-To;
 bh=U0GicZGauaqC5KguU2OElXVN4VBE7ExIoCC9RItBHfE=;
 b=fMOO+gK7x5J4xHJBHJNbZcFfLBY3VI1eDMucom57rzC3NPnwsD1APPY95sZ0vNyL
 HR23c2n6MCtGMevQETnX9/M2Grjr/NJivrvlQkKwqyWYluA/7rNz1ln+WzMEmSBbEB/
 nBywwVOuaPpz0jmkIqDnHw85pRIXOWsR765jWPDQ=
Received: by smtp.zohomail.com with SMTPS id 1791174308064131.85596656595453; 
 Sun, 4 Oct 2026 21:25:08 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 05 Oct 2026 12:25:01 +0800
Message-Id: <DLWMAQASY7WL.2ZOX8PGPWR6XP@pigmoral.tech>
Cc: "Tom Rini" <trini@konsulko.com>, "Quentin Schulz"
 <quentin.schulz@cherry.de>, "Simon Glass" <sjg@chromium.org>, "Daniel
 Golle" <daniel@makrotopia.org>, "Randolph Sapp" <rs@ti.com>, "Ilias
 Apalodimas" <ilias.apalodimas@linaro.org>, "Kory Maincent"
 <kory.maincent@bootlin.com>, "Yixun Lan" <dlan@kernel.org>, "Yao Zi"
 <me@ziyao.cc>, <spacemit@lists.linux.dev>
Subject: Re: [PATCH v3 2/2] doc: board: spacemit: document the SpacemiT boot
 image format
From: "Junhui Liu" <junhui.liu@pigmoral.tech>
To: "E Shattow" <e@freeshell.de>, "Junhui Liu" <junhui.liu@pigmoral.tech>,
 <u-boot@lists.u-boot-project.org>
X-Mailer: aerc 0.22.0
References: <20260921-spacemit-aihd-v3-0-f660fc85d2a5@pigmoral.tech>
 <20260921-spacemit-aihd-v3-2-f660fc85d2a5@pigmoral.tech>
 <24dbd483-6b93-4d68-ae5b-e61f2af66857@freeshell.de>
In-Reply-To: <24dbd483-6b93-4d68-ae5b-e61f2af66857@freeshell.de>
X-ZohoMailClient: External
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

Hi E,

On Mon Oct 5, 2026 at 8:40 AM CST, E Shattow wrote:
> Hi Junhui,
>
> On 9/21/26 07:54, Junhui Liu wrote:
>> Document the boot image layout shared by the SpacemiT K1 and K3
>> BootROMs, including the metadata headers and authentication areas.
>>=20
>> Describe the K3 non-secure CRC32 path supported by mkimage and provide
>> an example using the "smtimage" image type with "-n k3".
>>=20
>> Tested-by: E Shattow <e@freeshell.de>
>> Signed-off-by: Junhui Liu <junhui.liu@pigmoral.tech>
>> ---
>>  doc/board/spacemit/index.rst    |   2 +-
>>  doc/board/spacemit/smtimage.rst | 143 +++++++++++++++++++++++++++++++++=
+++++++
>>  2 files changed, 144 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/doc/board/spacemit/index.rst b/doc/board/spacemit/index.rst
>> index a5e35ee12ab6..5797ada37d15 100644
>> --- a/doc/board/spacemit/index.rst
>> +++ b/doc/board/spacemit/index.rst
>> @@ -7,4 +7,4 @@ SpacemiT
>> =20
>>     bananapi-f3
>>     k1-spl
>> -
>> +   smtimage
>> diff --git a/doc/board/spacemit/smtimage.rst b/doc/board/spacemit/smtima=
ge.rst
>> new file mode 100644
>> index 000000000000..19a5c9972f75
>> --- /dev/null
>> +++ b/doc/board/spacemit/smtimage.rst
>> @@ -0,0 +1,143 @@
>> +.. SPDX-License-Identifier: GPL-2.0-or-later
>> +
>> +SpacemiT boot image format
>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
>> +
>> +The SpacemiT K1 and K3 BootROMs load a SpacemiT boot image as the first=
-stage
>> +bootloader (FSBL), either from persistent storage or over USB in MaskRO=
M mode.
>
> "BootROM on SpacemiT K1 or K3 System-on-Chip expects the First Stage
> BootLoader to be wrapped in a specially constructed image layout." and
> delete the unrelated fact about boot flow.

I will update it.

>
>> +
>> +Image layout
>> +------------
>> +
>> +K1 and K3 share the same layout. A fixed 4 KiB prefix contains two 32-b=
yte
>
> Delete redundant sentence "K1 and K3 share the same layout", as it is
> implied above and cannot be anything else by the later description.
>

I will update it.

>
>> +metadata headers, key slots, and signature slots. The aligned SPL paylo=
ad and
>> +a trailing authentication area follow::
>
> The architectural reasoning of payload alignment should be part of this
> sentence if it is known. From my experience looking at disassembled
> BootROM of another SoC there is a trend of structs and string data
> sections to be extended to 8-byte alignment (word-aligned for 64-bit
> RISC-V); Why would the payload be extended to quad-word alignment, is
> this related to the NOR flash page size and/or a cryptography
> requirement? Disregard my inquiry here if it is not known the reason for
> this.

Both the K1 and K3 RSA authentication paths require 32-byte payload
alignment when determining the signed length and the location of
signature1. Although the K3 non-secure CRC32 path does not have this
requirement, we use the same alignment for a consistent image layout and
to follow the behavior of the vendor packaging tool.

I will add a short note about this.

>
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
> Keep "n-byte" as-is when discussing byte-layout to describe alignment
> and not i.e. word or half-word or nibble etc. considering my previous
> suggestion.
>
>> +           +-------------------------------+
>> +           | signature1                    |  0x100
>> +           +-------------------------------+
>> +
>> +For payload size ``P`` and ``A =3D ALIGN(P, 32)``, the image size is
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
> The previous list-table of offsets is okay for review and diff output,
> however the following list-table is not acceptable.
>
>> +
>> +   * - Area
>> +     - K1
>> +     - K3 non-secure boot mode
>> +     - K3 secure boot mode
>> +   * - Root and OEM keys
>> +     - RSA-2048 moduli with an eFuse root-hash check when secure boot i=
s
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
>
> Why the mixed-use of square brackets and parenthesis?

I think this is a fairly common mathematical notation for a half-open
interval. If you find it less readable in this context, I can change it
to [0x100, 0xaff] instead.

>
>> +   * - signature1
>> +     - Verified with the SPL key over header1 and the aligned payload
>> +     - Unused
>> +     - Verified with the SPL key over header1 and the aligned payload
>> +
>
> I don't know what is preferred here by documentation reviewers but this
> above list-table is not reviewable as-is. Maybe try to flip the axis, or
> split into a series of tables as one-per-name of K1, K3 non-secure boot
> mode, and K3 secure boot mode?  The purpose of restructuring this should
> be readability before being rendered, and minimal 'diff' impact for
> future changes.

I combined the three cases in one table intentionally, so readers can
compare the treatment of each field across the K1, K3 non-secure, and K3
secure paths side by side. Splitting it into three tables would make
that comparison less direct and require readers to move back and forth
between them. It would also duplicate the field names across the three
tables.

Given that trade-off, I would prefer to keep the current table layout.

>
>> +K1 verifies both signatures even without a programmed root-key hash. In=
 this
>> +case, the root key comes from the image and is not authenticated by har=
dware,
>> +so the image, keys, and signatures can be replaced together.
>> +
>> +K3 uses CRC32 in non-secure boot mode and hardware-rooted RSA in secure=
 boot
>> +mode.
>> +
>> +Creating an image
>> +-----------------
>> +
>> +U-Boot currently creates only K3 images for non-secure boot mode. Packa=
ge an
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

Okay. I prefer .bin as the filename suffix. I think I will use
u-boot-spl-smtimage.bin.

>
> A distro package of u-boot or later user of the build system may copy
> this output to "FSBL.bin" but that is nothing to do with us here. In
> fact for documentation purpose here it is useful to retain "FSBL.bin" as
> a distinct description of the vendor firmware SPL and not get this
> confused for mainline u-boot.
>
>> +
>> +K1 images and RSA-authenticated K3 images are not yet supported.
>>=20
>
> This statement may be simply deleted. It is obvious that support does
> not exist when it is not described here. If you would like to keep this
> line it is not any problem. Similarly for the sentence "U-Boot currently
> creates only K3 images for non-secure boot mode." which is not really
> accurate to say, as there is no makefile target or binman setup for any
> of this yet. Technically U-Boot does nothing at all regarding this
> documentation. It would just have to be more diff lines to review later
> and can be omitted now.

I will remove it.

>
> -E

--=20
Best regards,
Junhui Liu


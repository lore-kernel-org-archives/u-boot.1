Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4D8BCA5FFC
	for <u-boot@archiver.kernel.org>; Mon,  5 Oct 2026 14:21:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2827580A95;
	Mon,  5 Oct 2026 14:21:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nsNC7wVaeKy8; Mon,  5 Oct 2026 14:21:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org EF84A80AA6
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791210110;
	b=aij3jYNVcM2LRYAEbo8aR2ZJv7Ho39avnaiic1S7IpBxKtuuk99HoT0zFHYRxzbUAkJh
	 DYeeIvgr8maoPHqHprB2va3HDv0/zGzGQR5YTupbBL0cmdB1EMNA80VPPcSX3frznV/uz
	 m4wwm3/91NHO1SwnuKBr0AfZR7NBzyk7IpImxyFy1VlOvncRbqI+VOVIpXV5zsCAX4aIX
	 SJJRHqXCQYOW4PENpTUT4/RMvbXEIDkXrP8N3R0zYjfh7aRd6wNTPG5Cx8hOvHqLRt2u+
	 qEWxjFShFaCORpIQWLVGNt7VLCwIfOq0i3V6vvl5EGkurC/CAOZ0DJBLzzTTvBqRiLg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791210110;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=KWh1uW3nR0vEsf9pEA61mQQmL+TNxr3zlgdRqp2rkq8=;
	b=kopRYpIUH+RnxttZTJazbNeVjinhyebSR0GE5Est+BCpkRhcJfxLz7T0cyDgmVYiL3Yq
	 xKcbpIgQC8zhtOlhzdONLHe8xcYjmaZZVtLpD/Rs7jQF/7Q3HnqS2TufA4phy5xTikuGi
	 CIwa1uzQ9I6/sRGEdahE1EEL+WOMk8Zeykuvefbod7DQy+bChrnGQcNJciYsiRTC/bdlq
	 Dauu+ndwaDayhn38fOqYPxfwQzVEzy3JQsgwF9VYnwlja2RP+puz1AvjFckPYpXTS0smc
	 Wegx/XNbTRkwF26kNCyeyV2isiVKC1xk9wiDRWBxtZIL0Rn5w1mYGApWy6+j5P07iBA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791210110;
	bh=KWh1uW3nR0vEsf9pEA61mQQmL+TNxr3zlgdRqp2rkq8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CIprO8puAUPASbFQvc6IKEArXwGolwzkKXL0hpyFKGDz0jDhMLECeGEZGy26ibp+q
	 lWNxeX63HIT17AcutmmjxmWPdhy/j3q7vr2tRo1SQI+0hkBuhA4B21eJOBicLWBZth
	 PzpFyXQlh3e5FZBHAdNzhhXa+w4kzw0nvf1Am4bPL9Fg/DQMv1D1Swxc2SdWmwAJpZ
	 rQDr5Uc8+uccv/aj4FgaLBxGHuWgpDYrUu2lhpa3SKWyGVEQYJMhXVvOQHpzCiWtDg
	 QIWZqOHfwbIU6D1GozyQDEZYLJZ/uE/OwU/iA/qz9GBk8aIfegdlcEkyjE8Pkhvoeq
	 3DYodio3ayrkQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id EF84A80AA6;
	Mon,  5 Oct 2026 14:21:49 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 24574338
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 14:16:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0A9DD40648
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 14:16:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uVwH28BI7shB for <u-boot@lists.u-boot-project.org>;
 Mon,  5 Oct 2026 14:16:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 1EBB9405EE
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a01:4f8:231:482b::2"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791209785;
 b=pGzKtHC8oDcDoYj8blseCZ6sj0RigZeQ6ToDuTGIam0kyN+W6yLDTXMivYzpTXzUUE5R
 X25iFjuqNFh8XJ6yaZ2qR8Gq1YBGXcGvOR6oGjx5OoRJuZgd4pqCGGyvH5BGOKhjOX1Bk
 1EE4U3l8iYlSroTQAmUzxdmWDrG0gXsDEIj9y/riydxp+iSvGoVFmxI+EanhEF3umw4uy
 BcXXMIIPaqtcjZhVf4dh6WC9OMBGnmKoh9iiRostxWPcac1418Jpj8bm3UDRHBPHiqiKm
 fLGLoAuim0fl1W7uPGzY9y0uvAynxkf0E09QIqXG7/HFAf4yTzMDN4+DMQZcQo5zoTw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791209785;
 h=Received-SPF:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding;
 bh=KWh1uW3nR0vEsf9pEA61mQQmL+TNxr3zlgdRqp2rkq8=;
 b=ZHG+afj1ORV/Nn304oY6osS01lKfIbni1KdcSPQbZR3TuWfIi00WmkHOyKRfZX8bpvcT
 SUQgaVmmzDfYFB9ODSQSx3g195pccvBUTLnCcWzgwzIgnkpSEKSe2g8qVSiMDQg1lXseP
 ZJrgSDSUP30kb0LJD1HbbL1DKoZG7aWj9u8+7cvbPbdYhkOXaRyVFWlhhDmp3wAmyIxFB
 pi8x3Ij6/vPYwfZMicJ2SFnLhRPSMyzPvy75yzbNPhvMBbq3ro2Vp2FpUZ4U7ihm8jCBJ
 EbR9YdvyLHV2/B91QJyiaM8WadWr7WaQZN86n4bxa210L5o8ipsyyoRMp9fLCImnWNQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=freeshell.de; 
 dkim=pass header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b=ktpsjT0r; 
 arc=none smtp.remote-ip="2a01:4f8:231:482b::2"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:4f8:231:482b::2;
 helo=freeshell.de; envelope-from=e@freeshell.de; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=freeshell.de
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b=ktpsjT0r
Received: from freeshell.de (freeshell.de [IPv6:2a01:4f8:231:482b::2])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1EBB9405EE
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 14:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
 s=s2025; t=1791209751;
 bh=KWh1uW3nR0vEsf9pEA61mQQmL+TNxr3zlgdRqp2rkq8=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=ktpsjT0rQAPhcclUMXwG0xI8sM0sUffNRuSYZ1a8YxqUR/yxaZ/QiuE2+AAcmeh8S
 OOVc5/oCAxLiLfWPOlJ52tkB+1hl8soxGQS7hHheaLmqDCphiQ8n+qdULHV+tyljD+
 tmEMbekil2HrXNQiXfWam+S4njrDNqVQJdiXpRnPxjxX2B+7SDMGt7/42IJNU6LPXN
 TfTmilLPQj8EApm51XwbLfg4k3pk1sajG6EKs9a/HkNr8/foqIi/6xTOsogQzc6MHT
 E1WZ5oBSIPsofdHbzKJuDbJIQQmkf0hWKIgBIZke5nshbjcUJ9Exf1GOIE2A/+XOa4
 q93Vt0BXa4adw==
Received: from [IPV6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc] (unknown
 [IPv6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 02973B2200FC;
 Mon,  5 Oct 2026 16:15:48 +0200 (CEST)
Message-ID: <84099410-44e0-4d6c-aa62-674a5f9e9bf9@freeshell.de>
Date: Mon, 5 Oct 2026 07:15:35 -0700
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
 <24dbd483-6b93-4d68-ae5b-e61f2af66857@freeshell.de>
 <DLWMAQASY7WL.2ZOX8PGPWR6XP@pigmoral.tech>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <DLWMAQASY7WL.2ZOX8PGPWR6XP@pigmoral.tech>
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

Hi Junhui, I have some follow-up to add to the discussion,

On 10/4/26 21:25, Junhui Liu wrote:
> Hi E,
> 
> On Mon Oct 5, 2026 at 8:40 AM CST, E Shattow wrote:
>> Hi Junhui,
...
>>
>> The previous list-table of offsets is okay for review and diff output,
>> however the following list-table is not acceptable.
>>
>>> +
>>> +   * - Area
>>> +     - K1
>>> +     - K3 non-secure boot mode
>>> +     - K3 secure boot mode
>>> +   * - Root and OEM keys
>>> +     - RSA-2048 moduli with an eFuse root-hash check when secure boot is
>>> +       enabled
>>> +     - Unused
>>> +     - RSA-2048 moduli with an eFuse root-hash check
>>> +   * - Header CRC
>>> +     - Not checked separately
>>> +     - header1 verified
>>> +
>>> +       header0 ignored
>>> +     - Both verified and covered by RSA
>>> +   * - Image CRC
>>> +     - Not checked separately
>>> +     - Payload CRC32 in header1
>>> +     - Covered by RSA but not checked separately
>>> +   * - signature0
>>> +     - Verified with the root key over ``[0x100, 0xb00)``
>>> +     - Unused
>>> +     - Verified with the root key over ``[0x100, 0xb00)``
>>
>> Why the mixed-use of square brackets and parenthesis?
> 
> I think this is a fairly common mathematical notation for a half-open
> interval. If you find it less readable in this context, I can change it
> to [0x100, 0xaff] instead.

Let's qualify the interval notation with verbose "interval", for example:

-     - Verified with the root key over ``[0x100, 0xb00)``
+     - Verified with the root key over ``[0x100, 0xb00)`` interval

With this verbose qualifier I have some hope to search Wikipedia for
"interval" and learn about the symbolic representation. I assume here a
half-open interval representation is one of many forms of a
classification of "interval", so simply adding "interval" is enough context.

> 
>>
>>> +   * - signature1
>>> +     - Verified with the SPL key over header1 and the aligned payload
>>> +     - Unused
>>> +     - Verified with the SPL key over header1 and the aligned payload
>>> +
>>
>> I don't know what is preferred here by documentation reviewers but this
>> above list-table is not reviewable as-is. Maybe try to flip the axis, or
>> split into a series of tables as one-per-name of K1, K3 non-secure boot
>> mode, and K3 secure boot mode?  The purpose of restructuring this should
>> be readability before being rendered, and minimal 'diff' impact for
>> future changes.
> 
> I combined the three cases in one table intentionally, so readers can
> compare the treatment of each field across the K1, K3 non-secure, and K3
> secure paths side by side. Splitting it into three tables would make
> that comparison less direct and require readers to move back and forth
> between them. It would also duplicate the field names across the three
> tables.
> 
> Given that trade-off, I would prefer to keep the current table layout.
> 

No complaint about the rendered output it is very useful.

What I am meaning by "flip the axis" is for example:

.. list-table:: Authentication policy
   :header-rows: 1

   * - Image Variant
     - Root and OEM keys
     - Header CRC
     - Image CRC
     - signature0
     - signature1
   * - K1
     - RSA-2048 moduli with an eFuse root-hash check when secure boot is
       enabled
     - Not checked separately
     - Not checked separately
     - Verified with the root key over ``[0x100, 0xb00)`` interval
     - Verified with the SPL key over header1 and the aligned payload
   * - K3 non-secure
     - Unused
     - | header1 verified
       | header0 ignored
     - Payload CRC32 in header1
     - Unused
     - Unused
   * - K3 secure
     - RSA-2048 moduli with an eFuse root-hash check
     - Both verified and covered by RSA
     - Covered by RSA but not checked separately
     - Verified with the root key over ``[0x100, 0xb00)``
     - Verified with the SPL key over header1 and the aligned payload

Reviewability is improved yet it remains confusing and is less readable
on the rendered output.

Next, to then delete the column headers, move column descriptions to
natural-language descriptions, and keep a single-table format:

.. list-table:: Authentication policy

   * - K1
     - RSA-2048 moduli root and OEM keys with an eFuse root-hash check
       when secure boot is enabled
     - No additional header verification
     - No additional image checksum
     - Verified signature0 with the root key over ``[0x100, 0xb00)``
       interval
     - Verified signature1 with the SPL key over header1 and the aligned
       payload
   * - K3 non-secure
     - Unused root and OEM keys
     - header0 ignored, header1 verified
     - Image payload CRC32 in header1
     - Unused signature0
     - Unused signature1
   * - K3 secure
     - RSA-2048 moduli root and OEM keys with an eFuse root-hash check
     - header0 and header1 both verified and covered by RSA
     - No additional image checksum
     - Verified signature0 with the root key over ``[0x100, 0xb00)``
       interval
     - Verified signature1 with the SPL key over header1 and the aligned
       payload

I can now read this comfortably both in source and in rendered output.
What do you think?

>>
>>> +K1 verifies both signatures even without a programmed root-key hash. In this
>>> +case, the root key comes from the image and is not authenticated by hardware,
>>> +so the image, keys, and signatures can be replaced together.
>>> +
>>> +K3 uses CRC32 in non-secure boot mode and hardware-rooted RSA in secure boot
>>> +mode.
>>> +
>>> +Creating an image
>>> +-----------------
>>> +
>>> +U-Boot currently creates only K3 images for non-secure boot mode. Package an
>>> +SPL payload with::
>>> +
>>> +    $ tools/mkimage -T smtimage -n k3 -d u-boot-spl.bin FSBL.bin
>>
>> Use lowercase letters for the output filename if it is not any CONFIG_
>> symbol or preprocessor define symbol, and re-use an existing filename
>> stem as for example any of:
>>
>> u-boot-spl.smtimage
>> u-boot-spl-mkimage.bin
>> u-boot-spl.bin.smtimage
>> spl.bin
> 
> Okay. I prefer .bin as the filename suffix. I think I will use
> u-boot-spl-smtimage.bin.

Let's re-use "u-boot-spl-mkimage.bin" and
"u-boot-spl-mkimage.signed.bin" since you prefer ".bin" suffix and not
"smtimage" suffix?

`uniq` counts:

4  "spl/boot.bin"
4  "u-boot-spl-mkimage.bin"
4  "u-boot-spl-mkimage.signed.bin"
8  "spl.bin"
17  "u-boot-spl-ddr.bin"

SpacemiT K1 boards do use "u-boot-spl-ddr.bin" filename for the
processed SPL image but that is a binman artifact of some DDR training
blob from before support for smtimage is added to mkimage.

It may be a benefit for distro packagers and CI/CD workflow to have
distinct filenames for unsigned and signed output, so
"u-boot-spl-mkimage.bin" and "u-boot-spl-mkimage.signed.bin", otherwise
I would say "spl.bin" is short and popular for re-use.

> 
>>
>> A distro package of u-boot or later user of the build system may copy
>> this output to "FSBL.bin" but that is nothing to do with us here. In
>> fact for documentation purpose here it is useful to retain "FSBL.bin" as
>> a distinct description of the vendor firmware SPL and not get this
>> confused for mainline u-boot.
>>
>>> +
>>> +K1 images and RSA-authenticated K3 images are not yet supported.
>>>
>>
>> This statement may be simply deleted. It is obvious that support does
>> not exist when it is not described here. If you would like to keep this
>> line it is not any problem. Similarly for the sentence "U-Boot currently
>> creates only K3 images for non-secure boot mode." which is not really
>> accurate to say, as there is no makefile target or binman setup for any
>> of this yet. Technically U-Boot does nothing at all regarding this
>> documentation. It would just have to be more diff lines to review later
>> and can be omitted now.
> 
> I will remove it.
> 
>>
>> -E
> 

With all that, and I'll confirm my R-by tag again in the next round so
not to delay the series,

Reviewed-by: E Shattow <e@freeshell.de>


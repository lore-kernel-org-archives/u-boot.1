Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46828CA5FF5
	for <u-boot@archiver.kernel.org>; Mon,  5 Oct 2026 21:46:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 01E8B80A4A;
	Mon,  5 Oct 2026 21:46:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id g4JGK_3uJ207; Mon,  5 Oct 2026 21:46:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 7F96E809CE
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791236805;
	b=I/WT2yIMn514cQQWRpKA0/fI9bguiEgde+Moc/dfrctKgecpqhMrMN8PpBWmzp0wMWTG
	 3xWIXyXnh44ezwXKGeM3dALv9fW0ZF+xbAkK/mz7aSBrFzLd1Y5uMzPtrVra81hvyCbid
	 CgsGuBFzPlX1zNNOv4eTpDVZ0haHmwva//6283TgUDVboh6T4W0OVgtFxy7uhj4c+0KQP
	 XFy7bhuW9mmHgXpflRnf7EGjdBuR5jQCCTr6/VUmzzJaXxaEQtYFRv4IasCrLfQyzFc8a
	 CwgLelOdRNSkOCSLNKWZWSQ8TxBLIqGw2qVOCwJ1rmmSccw2X6/ESt5+6n7h8B5ALng==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791236805;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=v0Fh4Y2ZRNhPJk9+tSFuiEKS3XJ0OS8LH29qflc/NrA=;
	b=rBROyw5svKjOTFWE9ui0xv2zxP6JEwNgWpx/FIozVWZdcS3onpSUHNeC/A2s9HhaP9tD
	 /pDn7ttssRH5YpLDWMecOjw9LPgWmYHXNc8XDAFRuexxG6AoannMJhdPWPQz5+DMnpKgy
	 5w0WrqHFBcnvZXT/P+CJiApYcq+MpgEWv93sLcDK+vzYpv3nQCwWs1WOqBQEeZgyGBNvc
	 VNUFDcjDXnEs65Hdy4A6OXoP2UuDW2z3XUXCY2kiYwwmN4wqV6Im4T0z+yWGvkC0U7ocZ
	 JVw4UYypi8YDprldyYTiskwAoLbSY6XvFoHRKXItPnDzoaNOl9zfZHFDuo+6F8ogMJw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=pass header.from=freeshell.de;
	dkim=pass header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256 header.s=s2025 header.b=VnCOcbMj;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791236805;
	bh=v0Fh4Y2ZRNhPJk9+tSFuiEKS3XJ0OS8LH29qflc/NrA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pVmgiQmJPIvp8leSV9oJ/VvHyTaj9YB3U1l9oCk0dS5oyGg0VyTqfYmCSYEK63Qjz
	 uVP2/4P6CvQ5kxuafi6E4KKUDlrG+5/dniPtNmdqesUf03c8e0xJSBYThNRSG41C3/
	 XSO66i2sk5Z/FCdgVEectgJsdwa/GpCc2mEhAOBifUGWDzdgZZ7e90rLvdzIB5N3R6
	 g2OWZwYegKNK0ncbbIqhLElGqm0Av7wL7z+2/xPOXC4hCR+FMMls4FISPeUhhsbs2E
	 H6SkmW6Ap6yJfOAOd/lSJFQ2oQ+ACkx0Bo8qe94pca4m33qPB0meVU72D/SKwxDGX4
	 vjNWLBDNxHRlQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7F96E809CE;
	Mon,  5 Oct 2026 21:46:45 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 3F4C32E0
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 21:34:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2562B808BB
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 21:34:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Vrgqbs0Eyj0O for <u-boot@lists.u-boot-project.org>;
 Mon,  5 Oct 2026 21:34:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org B313C808AE
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=116.202.128.144
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791236059;
 b=Fl/xtH9TPdRh6VsWKsiBNnH6+m4qTuUjhmloxJXNqFqw3XFAxoU7VNNV+OI3/quTSOOS
 DHnnhuSTtutZKiSY0/PlGKn9h6NadCSq+UZKexcz5nDUq/+T52O8k1yhtiydVSjHZX4L9
 80P/QhOEr+qy1xLWxqddcMDwgQlxVvsl2B1191vWRC6e5oww94gorhUVurm9K+hIkFc4w
 gPq2k14zfneXXswQxlGqeZZMjaQjd9Lo/rrH5HF9N3Uaou26YIqPQpbE60IPjmVnIERWp
 4Vql2/957OrOtNb0eKF/1TjTB0I+iVU/XRfvZ5kJwCKVmcw9X5d+r0qCq+U8yVBlUaA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791236059;
 h=Received-SPF:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding;
 bh=v0Fh4Y2ZRNhPJk9+tSFuiEKS3XJ0OS8LH29qflc/NrA=;
 b=Wm5juwk5IUhzDZyXdnaxdzsOGJ/OJa8W+ECKfPprmFA+ZGwx7pl4wVamxn+m4NBYpvcg
 dE4fbOoB8A6UToLJhn2W3YHXqYfrduCEIkFMpC3Jts2XezY6H+qj3JYO9E4zLk+G6sxk3
 vGtXmPsyh11yUHWLKUPHaFT0kGKhMU4Uu46PYRF7W5OLwQCZOkDxSZq00pUCRMqykHG3U
 Hhm1KkmJ8u3sQT8KwtR78pqX3hsnRDdefUMelrMGteXVeuCBp7VDEu9iYctvOMMVVDalc
 Y2W0TrDV/oQzTAoJ8xHVBYbPYawljVwLiS0xoSPyXtZVlBr+YJANNeSHbSjuBt5sx4w==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=freeshell.de; 
 dkim=pass header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b=VnCOcbMj; 
 arc=none smtp.remote-ip=116.202.128.144
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=116.202.128.144;
 helo=freeshell.de; envelope-from=e@freeshell.de; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=freeshell.de
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b=VnCOcbMj
Received: from freeshell.de (freeshell.de [116.202.128.144])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B313C808AE
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 21:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
 s=s2025; t=1791236018;
 bh=v0Fh4Y2ZRNhPJk9+tSFuiEKS3XJ0OS8LH29qflc/NrA=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=VnCOcbMjLm6jjVcc8doDm0YtY5bkD18WeFPOPu9o+F5hvH6Kb3FawFrm3E+km3zto
 xBp4ddngdfNyM9n8KuP6cjcL0CFFYiFQu+i+QMaSf5muviCBmJkvtPHQrKCLwXqdBC
 mxJjNgskZzgSudv/tHz/A7N/mXSwYEPBT3d4IERwTDWVlVoEr1B7YZkIkPCeEhjFf1
 8L83tW4Ge5WauQkSooAMHF/twThJKVhfeHmLTD4KwKUigjoX2luGUsD2czkKcVnSUL
 +tTASRMUerMQFNip/a5dNt6Fkg9pfE/vXPyj2jbalMFq6Qr6kMjE0+XjjIcIS38F1p
 HnetZO3KBOo8A==
Received: from [IPV6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc] (unknown
 [IPv6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 2EB20B2206D5;
 Mon,  5 Oct 2026 23:33:32 +0200 (CEST)
Message-ID: <8a53fca3-c1c9-4dd4-86d0-cb40c7ca597f@freeshell.de>
Date: Mon, 5 Oct 2026 14:33:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 7/7] spacemit: k1: fix product name detection and DTB
 matching in SPL
To: Eric Chung <eric.chung@riscstar.com>, Andre Heider <a.heider@gmail.com>
Cc: u-boot-spacemit@groups.io, u-boot@lists.u-boot-project.org,
 Yao Zi <me@ziyao.cc>, Tom Rini <trini@konsulko.com>,
 Tim Ouyang <tim609@andestech.com>, Leo Liang <leo.liang@sifive.com>,
 Wei Fu <wefu@redhat.com>, Scott Bambrough <scott@riscstar.com>,
 Huan Zhou <pericycle.cc@gmail.com>, Raymond Mao <raymond.mao@riscstar.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Anshul Dalal <anshuld@ti.com>, Siu Ming Tong <smtong@axiado.com>,
 Johan Jonker <jbx6244@gmail.com>
References: <20260912-m4-v13-0-71043b29630f@riscstar.com>
 <20260912-m4-v13-7-71043b29630f@riscstar.com>
 <d1a8bab8-4d88-48f2-9ddb-89e8c0e323b8@gmail.com>
 <CAH22mJw3MfVyEva=CGgaEp4y_V2cCv-=n3vz9oKpHtkjsScAPQ@mail.gmail.com>
 <2575486d-429d-4044-9b78-bf9b13bb0aa9@gmail.com>
 <CAH22mJy=Ea-QG3uEY2pTJCPSrxyymOmcLdRCXm6zmbe7HYSVtA@mail.gmail.com>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <CAH22mJy=Ea-QG3uEY2pTJCPSrxyymOmcLdRCXm6zmbe7HYSVtA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

On 10/5/26 08:34, Eric Chung wrote:
> On Mon, Oct 5, 2026 at 3:23 PM Andre Heider <a.heider@gmail.com> wrote:
>>
>> On 05.10.26 6:01 AM, Eric Chung wrote:
>>> On Fri, Oct 2, 2026 at 8:58 PM Andre Heider <a.heider@gmail.com> wrote:
>>>>
>>>> Hi,
>>>>
>>>> just a general question related to this patch, not about the patch itself, see below:
>>>>
>>>> On 12.09.26 2:37 PM, Eric Chung wrote:
>>>>> +static const struct {
>>>>> +     const char *eeprom_name;
>>>>> +     const char *fit_name;
>>>>> +} k1_board_map[] = {
>>>>> +     { "k1-x_MUSE-Pi-Pro",   "spacemit/k1-musepi-pro"    },
>>>>> +     { "k1-x_deb1",          "spacemit/k1-bananapi-f3"   },
>>>>> +     { "k1-x_milkv-jupiter", "spacemit/k1-milkv-jupiter" },
>>>>> +};
>>>> This maps the EEPROMs product_name to the dtb, just like the vendor fork, nice.
>>>>
>>>> But does the BPI F3 really have "k1-x_deb1" in there?
>>>> I know that's the fallback dtb of the vendor's fork [0][1], in case there's nothing there, and I thought that was the case for the F3?
>>>>
>>>
>>> k1-x_deb1 means the internal development board. And it could work
>>> smoothly on the Banana Pi F3.
>>
>> Yes, but maybe someone with a F3 board can verify via `tlv_eeprom` if that string is actually in there?
>>
>>>
>>>
>>>> Because it seems it's not set for BPI-CM6 IO board either [2], which then makes it impossible to distinguish, at least based on the EEPROM value :\
>>>>
>>>
>>> What's BPI-CM6 IO board? Is the BPI-CM6 IO board similar to the Banana
>>> Pi F3? Is it supported by linux kernel now?
>>
>> This one:
>> https://docs.banana-pi.org/en/BPI-CM6/BananaPi_BPI-CM6
>>
>> Supported by mainline via:
>> arch/riscv/boot/dts/spacemit/k1-bananapi-cm6-io.dts
>>
>> Apparently sinovoip *edited* k1-x_deb1.dts for CM6 and even ship that hack in their OS images (visible in the logs on that OpenWrt PR):
>> https://github.com/BPI-SINOVOIP/pi-linux/commit/333b99e8cd9b18e98bf71821518548df345dbb61
>> /o\
>>
>>>
>>>> Are there any ideas how to handle that, yet?
>>>>
>>>> Can we distinguish between those boards in the SPL based on something different?
>>>>
>>>> Or can we make up our own strings and let users write that to EEPROM? Mainline and vendor technically allows it via e.g.:
>>>>     tlv_eeprom set 0x21 "k1-x_BPI-CM6-IO"
>>>>     tlv_eeprom write
>>>> But that's assuming the EEPROM is writable, which I haven't checked.
>>>> (And I neither have a F3 nor a CM6).
>>>>
>>>
>>> tlv_eeprom should support to write EEPROM. If it fails, we could
>>> enable ENV in SPL. I have a patch in the mailing list to enable ENV.
>>> But that patch was abandoned. You could review the mailing list to
>>> reuse it.
>>
>> In the meantime a board owner verified the EEPROM write as working:
>> https://github.com/openwrt/openwrt/pull/23231#issuecomment-5972395785
>>
>> For the record, I made up "k1-x_BPI-CM6-IO" as product name with a matching vendor fork device-tree file name, which makes u-boot as well as the kernel pick up their matching device-trees via CONFIG_FIT_BEST_MATCH.
>>
>> In case mainline u-boot goes the same way (let CM6 owners add a value to EEPROM) to properly make multi-dtb fit images boot, can we agree on a value? Or maybe someone here has connections to sinovoip and ask them to put that/anything in there?
>>
> 
> Yes, adding "k1-x_BPI-CM6-IO" to the EEPROM sounds good to me. Feel
> free to format a patch and send it to the mailing list.

If we are inventing EEPROM data based on vibes then I think it is
appropriate to give at least one or two characters in the EEPROM data to
the company names respectively; "BananaPi" and "OrangePi" are brands
astroturfing the Raspbery Pi Foundation trademark.

"Orange Pi is an open source product brand of Shenzhen Xunlong Software
Co., Ltd" from www.orangepi.org website.

FYI for the StarFive JH-7110 SoC Xunlong OrangePi RV board I made up
this EEPROM value in board/starfive/visionfive2/spl.c:

        } else if (!strcmp(name, "starfive/jh7110-orangepi-rv") &&
                    !strncmp(get_product_id_from_eeprom(), "XOPIRV", 6)) {

and in board/starfive/visionfive2/starfive_visionfive2.c:

        } else if (!strncmp(get_product_id_from_eeprom(), "XOPIRV", 6)) {
                fdtfile = "starfive/jh7110-orangepi-rv.dtb";

It is the situation that a few products on the market with JH-7110 SoC
have shipped having an EEPROM product name data identical to the
reference StarFive VisionFive2 1.3b board and where the vendor edits
this corresponding dts file in their own u-boot fork. Eventually I would
like this to be a bare-minimum default for boards in mainline u-boot
that get it wrong to boot with just enough peripheral support to write a
new EEPROM value. As it is now we fail the boot with a message for the
user when no match is found.

While we're inventing new values for boards with SpacemiT SoC we should
also add such for the Banana Pi F3 and not leave it with the generic
reference board product name (unless that is in fact what its purpose is
historically). I suggest a logical-or to the existing comparison for
compatibility until a decision is formed about what should be the
default when no match is found.

The EEPROM data examples are derived from vendor u-boot filenames so not
necessary to arbitrarily upcase; Add for example "k1-x_svbpi-cm6" for
the System-on module or "k1-x_svbpi-cm6-io" for the baseboard, whichever
has the EEPROM device. In fact we might also derive this as
"k1-bananapi-cm6" or "k1-bananapi-cm6-io" from upstream Linux. The
pattern with "k1-x_" prefix appears to be representing vendor dts
filenames for boards with the taped-out K1 SoC; and "k1-pro_" is
pre-production dts filename related. That is very arbitrary and I don't
see any reason why we should invent something on vibes about a filename
that does not exist... but anyways it would be lowercase and not upcase.

Suggested thus any of:
k1-x_bpi-cm6(-io)
k1-x_svbpi-cm6(-io)
k1-x_svbp-bpi-cm6(-io)
k1-x_bpbpi-cm6(-io)
k1-x_bpi-cm6(-io)
k1-bananapi-cm6
k1-bananapi-cm6-io
k1-bananapi-f3

My strong preference is for referring to mainline Linux dts filenames if
we are just making it up when the overwhelming trend is to refer to
actual filenames, somewhere.

-E

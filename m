Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D530CA5FED
	for <u-boot@archiver.kernel.org>; Tue,  6 Oct 2026 13:00:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 077BA80CD4;
	Tue,  6 Oct 2026 13:00:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id q9pjbRcTUZGB; Tue,  6 Oct 2026 13:00:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 8D701808C6
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791291621;
	b=drOX6Q6BkWYGN2ofmTIuACyR++xpuZyI+beMsowEGLO5T3noR+t9vusBGz9c2fOTRWM7
	 GiKJx+ltjTjqG+Xdxz+6BB9Xe7weYaISiwiOGnw/q3j9DJIMR7CgvOeMTN5j2NZK0FHEa
	 3B4IgqOgKgS8f1h2wlOMnwIqcVFHf3KhM23EIIRRQo2w34WyBY6J6G21+B6Zucuh656Cp
	 35gHaQRd/7eb1OaSVUky1eiFjY1w5CPVlwJ8PJ4iSJdqI3NVijK16YosB3WdtEfetFvUJ
	 dJufUBWJjg0L7YwV6uokFak+V2ca/SImSschm+GemSFB9C7FRfHQ+fY3rCtZ5P4TXiw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791291621;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=koFklnamHHryYJCiUQ7E+np+LQ4z4My4lWgjN6Q+ogc=;
	b=hfNyywLlSJDcsMVJQQJsQ98E9jU/TrKxJizqhh3ei8kvjk38ff+OCOP8Cgnp7SDnX8pK
	 /bsi5/erF18rJtClyxanhI6D7VP7VVq4qh847/xCZw/rYSfXi+r+MD8A3EukWqgr9gs8Z
	 HwldzNyy7g90CMowtD7gEGtk9CnFoxKFFORc85esra5MEKE+UWnRBYPxSoLu88IWee5Mj
	 OPsWExU35Ve8cr11f3RtBhQjGy0zxBxxpnwz5obTuJFlz5DShGw6X+57sLSuBgF+CuErA
	 acb1jesiif/6cVFytE3iVGzdbv4sXj7Jg/w+wQPtBk0IXB2xqaJRPUMc8jp097zb+/g==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791291621;
	bh=koFklnamHHryYJCiUQ7E+np+LQ4z4My4lWgjN6Q+ogc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yy8OyIiedlNiIeyMlSxrv4kIEtmYr04d3PA3wNZMmE1I1vKyZkejDztH2PDdgEQ/C
	 /G4eS8vUX9UkhraQ0fr194yHRohohhQCKimmw8h834EmQjw7Kp9f+6cKpzv6E7LxS6
	 NdD7TmL/J+CllKiPFhbdMfBiUNqCCk2maO89fInrH2DWERBmZaL8hU4/ZDgsFzBHHW
	 wmcTMbHRr0O3aGMfJEc4xGz56ba9ODU4YLhk37rhE30aE4mjMVRf91GJWDu9FH3xFx
	 XEb/WRvs+CEFsQMmgflQLvcntdfuDBSO18IcpgdHzBwEBuNKQ9sSZtiUKmYWSV1Yhw
	 fHN2vtapNqqmw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8D701808C6;
	Tue,  6 Oct 2026 13:00:21 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id D40371D2
 for <u-boot@lists.u-boot-project.org>; Tue,  6 Oct 2026 06:57:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id ABF9F605D8
 for <u-boot@lists.u-boot-project.org>; Tue,  6 Oct 2026 06:57:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id f4Ig2PIw8BYm for <u-boot@lists.u-boot-project.org>;
 Tue,  6 Oct 2026 06:57:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 4DA77605D2
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::335"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791269850;
 b=AI2/Pzcz20amFi0LylNF01pOH3qJPbINxJXUeEt0IplP+I7D4fy33T8l/nH/jhgYb4OS
 BIuq8vQVoJmdvYP3nBQMnBSYCzR5v/7x635ZVBJ+9myv4H8XhMmG6o2/eRhKSSTGZgvWr
 03wjYU1CJMmZ1KNWQ8wWN6edvbtDImcyTJZTUK7k3pYTNcO8s/4OGQh83k48o+IeSBQY3
 8IqwDtl6zZU6I88Hs3V5v67kcaAuZvCj25Qjnum0o+OE0+js7DnE7IllerH/78ygwtutt
 +3cyCFvlgMB8YrJzFdwznQ+zrcAdngN+2gr5GtaoGfSN0wgsBAnnSpbp8+epq1IL9zQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791269850;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
 bh=koFklnamHHryYJCiUQ7E+np+LQ4z4My4lWgjN6Q+ogc=;
 b=QvAkWf4/OnIxAoTwk7vPxOfWjyhF5PGH0lM9o+NZJB/5FT8TaJSA9O4pfv9ubLczLSkL
 wdIYe0amZf9ZXC8hQbeW4QETFbU8RAwjDAP8/gZ3SXfw2C/9GxhK9CPVQl4appMTMbX7a
 IFhPkz3KtrKjkRodm0r0baSEUhySR2NTQJnxVzO+5ZRm3vWcAbIVOOInHWZ8ifDr0gEM/
 QTYf7DsMesfNhLz+kiTnGDN0SbxVtmb/9ky8rmbB9JRkzj4OBX62gv2u0o23BBBFubCR6
 rXnAPHOBCw1BUTTscOFE3cGAg1TV0t8zUB2yYQJiQ+tK/cL0fPAD6bnCujKKERzeN3Q==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=PktIwgx4; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::335"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::335; helo=mail-wm1-x335.google.com;
 envelope-from=a.heider@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=PktIwgx4
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4DA77605D2
 for <u-boot@lists.u-boot-project.org>; Tue,  6 Oct 2026 06:57:29 +0000 (UTC)
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4a0213948d3so2510005e9.2
 for <u-boot@lists.u-boot-project.org>; Mon, 05 Oct 2026 23:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791269848; x=1791874648;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=koFklnamHHryYJCiUQ7E+np+LQ4z4My4lWgjN6Q+ogc=;
 b=PktIwgx4rh7eMWmmwzLiM+/fOGcnYnuk5eEL4n9VdEjNpQbG7d+1uGeAdeSP7lwfbR
 iABAKejN6X5OLTo9ugEQ6RuOvAvu/9EQvlsG661KWI+KvXMrPHy8oKLeKNwQfQelnx5M
 UjxcAtpEEllcFEc0jQ42olWRKdxduGXOefd90y650aKR31/oBtgUBHVo1eza06ddUbnN
 5VoxwZJzia+OYOnD1pCE/4tMcqb/Rf1vFIqtTA1bJSKupD7tQ/tK33L00KwgWXVQLBxH
 uFqbGckk6XLyst6Gl/Yc+7KqB14j+LfauYt3I2BYsML2OmT/KVoC46c2eqP8I70IpI2T
 zaXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791269848; x=1791874648;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=koFklnamHHryYJCiUQ7E+np+LQ4z4My4lWgjN6Q+ogc=;
 b=nepMurTVgwDLY9LIaCo99gUCkFjOOIpCA4UtAd8szSa+k6v/9pbSHI6WLjK66Py/lt
 Gagr3FJm43nDWEQJdXCoVmBJyIRWT3kcgYR3fDYmxHh0bmsCNwvTaQIaDoleNuqaWaqJ
 jRo/ZsF168SdQIFh6BIFleUIqPI6lXrV9KkK1DStVjSZJQA50EC5ZUlSRlzyDI2TBy/8
 pBbqVasxLdlBQEFu8Q/AA6Bnik5Dn6S5SYgE6CppFM72wW0B7NF7lilFf35oOnsLRKIT
 pFNBizOxBvccZ22HER1KUOsZ8r21QJc/9SwuBCGTYG7VRKtSL2/IHyICb9GrYVAPUhn7
 FIrw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwtGq3pxGIO0hYgVnMsSOgBLSThv4gsHQLwlzyACvHt0xDSyAErYI3InN/PUEkuV2vjNv3ZyKw=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++n7k6jFrqgGMhVqQVna//RR6paA38SeYbpeasApkFg6GzbdVZWi
 2DR/Ohbd/l7DaOqqu5uJgjLP1lpo9o8kpJr6s+N8Z5o70Zsty6TzzQcd
X-Gm-Gg: AYBFou3/DwMX56m0er7nq1su/0WQS/8Imp8DaYy38ARI54f3c/DmwzVnhQ05jlmvgrE
 zUkuTOhC6WL+BXYALpPTa1zZgKK2s+HT2JHEzjXoUuAWpMs2ESSVDng29pLwVR3wmysWOQGDGju
 UjePF577k3FmAAWLRX0CnLzh5xzcLlG6+6X889iEJtOXhx8PXtgylRbM7R7aSDXE3Xye65EMyZI
 qHY7+vJuvQ1ranG+mcjvDa6LzfoKe5WhinL5MPCZvY2/Gb9pSB1CyI9muF8mD1oIcMvT2etsqm/
 gtgUeHxQPS4dhwPr3aN3fIt9c+yzkxVQZsxvIHhux3DcNj07LsXuL5f3YY5+tQf0xdoSQrxIMzF
 M7Zu9bzpOFrCg3qu7HwAQew7SZtwFI+Jb3hwwtMnO/lAwDg6yA5weNp5FRYqZlgYjUmmXAKAiXX
 yHuOU3XamsFyhqTzFSLvYqjtqN4Hx9w204a2Wq90OiVLsQ2JqdhalBgzUpClTJqa4X8olgDiy2c
 KZuXapC
X-Received: by 2002:a05:600c:8b08:b0:49f:fe7e:dc61 with SMTP id
 5b1f17b1804b1-4a17b4b6c75mr8387595e9.0.1791269847600; 
 Mon, 05 Oct 2026 23:57:27 -0700 (PDT)
Received: from ?IPV6:2a02:560:4eeb:e100::a1e? ([2a02:560:4eeb:e100::a1e])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a178a175aesm63917005e9.2.2026.10.05.23.57.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Oct 2026 23:57:27 -0700 (PDT)
Message-ID: <873ea90e-e5af-4f9f-aadc-12989cd49786@gmail.com>
Date: Tue, 6 Oct 2026 08:57:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 7/7] spacemit: k1: fix product name detection and DTB
 matching in SPL
To: E Shattow <e@freeshell.de>, Eric Chung <eric.chung@riscstar.com>
Cc: u-boot-spacemit@groups.io, u-boot@lists.u-boot-project.org,
 Yao Zi <me@ziyao.cc>, Tom Rini <trini@konsulko.com>,
 Tim Ouyang <tim609@andestech.com>, Leo Liang <leo.liang@sifive.com>,
 Wei Fu <wefu@redhat.com>, Scott Bambrough <scott@riscstar.com>,
 Huan Zhou <pericycle.cc@gmail.com>, Raymond Mao <raymond.mao@riscstar.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Anshul Dalal <anshuld@ti.com>, Siu Ming Tong <smtong@axiado.com>,
 Johan Jonker <jbx6244@gmail.com>, Yixun Lan <dlan@kernel.org>
References: <20260912-m4-v13-0-71043b29630f@riscstar.com>
 <20260912-m4-v13-7-71043b29630f@riscstar.com>
 <d1a8bab8-4d88-48f2-9ddb-89e8c0e323b8@gmail.com>
 <CAH22mJw3MfVyEva=CGgaEp4y_V2cCv-=n3vz9oKpHtkjsScAPQ@mail.gmail.com>
 <2575486d-429d-4044-9b78-bf9b13bb0aa9@gmail.com>
 <CAH22mJy=Ea-QG3uEY2pTJCPSrxyymOmcLdRCXm6zmbe7HYSVtA@mail.gmail.com>
 <8a53fca3-c1c9-4dd4-86d0-cb40c7ca597f@freeshell.de>
From: Andre Heider <a.heider@gmail.com>
Content-Language: de-DE
In-Reply-To: <8a53fca3-c1c9-4dd4-86d0-cb40c7ca597f@freeshell.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 06 Oct 2026 13:00:03 +0000
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

Hi,

just noticed that Yixuan wasn't part of cc:, adding.

On 05.10.26 11:33 PM, E Shattow wrote:
> On 10/5/26 08:34, Eric Chung wrote:
>> On Mon, Oct 5, 2026 at 3:23 PM Andre Heider <a.heider@gmail.com> wrote:
>>>
>>> On 05.10.26 6:01 AM, Eric Chung wrote:
>>>> On Fri, Oct 2, 2026 at 8:58 PM Andre Heider <a.heider@gmail.com> wrote:
>>>>>
>>>>> Hi,
>>>>>
>>>>> just a general question related to this patch, not about the patch itself, see below:
>>>>>
>>>>> On 12.09.26 2:37 PM, Eric Chung wrote:
>>>>>> +static const struct {
>>>>>> +     const char *eeprom_name;
>>>>>> +     const char *fit_name;
>>>>>> +} k1_board_map[] = {
>>>>>> +     { "k1-x_MUSE-Pi-Pro",   "spacemit/k1-musepi-pro"    },
>>>>>> +     { "k1-x_deb1",          "spacemit/k1-bananapi-f3"   },
>>>>>> +     { "k1-x_milkv-jupiter", "spacemit/k1-milkv-jupiter" },
>>>>>> +};
>>>>> This maps the EEPROMs product_name to the dtb, just like the vendor fork, nice.
>>>>>
>>>>> But does the BPI F3 really have "k1-x_deb1" in there?
>>>>> I know that's the fallback dtb of the vendor's fork [0][1], in case there's nothing there, and I thought that was the case for the F3?
>>>>>
>>>>
>>>> k1-x_deb1 means the internal development board. And it could work
>>>> smoothly on the Banana Pi F3.
>>>
>>> Yes, but maybe someone with a F3 board can verify via `tlv_eeprom` if that string is actually in there?
>>>
>>>>
>>>>
>>>>> Because it seems it's not set for BPI-CM6 IO board either [2], which then makes it impossible to distinguish, at least based on the EEPROM value :\
>>>>>
>>>>
>>>> What's BPI-CM6 IO board? Is the BPI-CM6 IO board similar to the Banana
>>>> Pi F3? Is it supported by linux kernel now?
>>>
>>> This one:
>>> https://docs.banana-pi.org/en/BPI-CM6/BananaPi_BPI-CM6
>>>
>>> Supported by mainline via:
>>> arch/riscv/boot/dts/spacemit/k1-bananapi-cm6-io.dts
>>>
>>> Apparently sinovoip *edited* k1-x_deb1.dts for CM6 and even ship that hack in their OS images (visible in the logs on that OpenWrt PR):
>>> https://github.com/BPI-SINOVOIP/pi-linux/commit/333b99e8cd9b18e98bf71821518548df345dbb61
>>> /o\
>>>
>>>>
>>>>> Are there any ideas how to handle that, yet?
>>>>>
>>>>> Can we distinguish between those boards in the SPL based on something different?
>>>>>
>>>>> Or can we make up our own strings and let users write that to EEPROM? Mainline and vendor technically allows it via e.g.:
>>>>>      tlv_eeprom set 0x21 "k1-x_BPI-CM6-IO"
>>>>>      tlv_eeprom write
>>>>> But that's assuming the EEPROM is writable, which I haven't checked.
>>>>> (And I neither have a F3 nor a CM6).
>>>>>
>>>>
>>>> tlv_eeprom should support to write EEPROM. If it fails, we could
>>>> enable ENV in SPL. I have a patch in the mailing list to enable ENV.
>>>> But that patch was abandoned. You could review the mailing list to
>>>> reuse it.
>>>
>>> In the meantime a board owner verified the EEPROM write as working:
>>> https://github.com/openwrt/openwrt/pull/23231#issuecomment-5972395785
>>>
>>> For the record, I made up "k1-x_BPI-CM6-IO" as product name with a matching vendor fork device-tree file name, which makes u-boot as well as the kernel pick up their matching device-trees via CONFIG_FIT_BEST_MATCH.
>>>
>>> In case mainline u-boot goes the same way (let CM6 owners add a value to EEPROM) to properly make multi-dtb fit images boot, can we agree on a value? Or maybe someone here has connections to sinovoip and ask them to put that/anything in there?
>>>
>>
>> Yes, adding "k1-x_BPI-CM6-IO" to the EEPROM sounds good to me. Feel
>> free to format a patch and send it to the mailing list.
> 
> If we are inventing EEPROM data based on vibes then I think it is
> appropriate to give at least one or two characters in the EEPROM data to
> the company names respectively; "BananaPi" and "OrangePi" are brands
> astroturfing the Raspbery Pi Foundation trademark.
> 
> "Orange Pi is an open source product brand of Shenzhen Xunlong Software
> Co., Ltd" from www.orangepi.org website.
> 
> FYI for the StarFive JH-7110 SoC Xunlong OrangePi RV board I made up
> this EEPROM value in board/starfive/visionfive2/spl.c:
> 
>          } else if (!strcmp(name, "starfive/jh7110-orangepi-rv") &&
>                      !strncmp(get_product_id_from_eeprom(), "XOPIRV", 6)) {
> 
> and in board/starfive/visionfive2/starfive_visionfive2.c:
> 
>          } else if (!strncmp(get_product_id_from_eeprom(), "XOPIRV", 6)) {
>                  fdtfile = "starfive/jh7110-orangepi-rv.dtb";
> 
> It is the situation that a few products on the market with JH-7110 SoC
> have shipped having an EEPROM product name data identical to the
> reference StarFive VisionFive2 1.3b board and where the vendor edits
> this corresponding dts file in their own u-boot fork. Eventually I would
> like this to be a bare-minimum default for boards in mainline u-boot
> that get it wrong to boot with just enough peripheral support to write a
> new EEPROM value. As it is now we fail the boot with a message for the
> user when no match is found.

Ack, that sounds like a good idea.

> While we're inventing new values for boards with SpacemiT SoC we should
> also add such for the Banana Pi F3 and not leave it with the generic
> reference board product name (unless that is in fact what its purpose is
> historically). I suggest a logical-or to the existing comparison for
> compatibility until a decision is formed about what should be the
> default when no match is found.
> 
> The EEPROM data examples are derived from vendor u-boot filenames so not
> necessary to arbitrarily upcase; Add for example "k1-x_svbpi-cm6" for
> the System-on module or "k1-x_svbpi-cm6-io" for the baseboard, whichever
> has the EEPROM device. In fact we might also derive this as
> "k1-bananapi-cm6" or "k1-bananapi-cm6-io" from upstream Linux. The
> pattern with "k1-x_" prefix appears to be representing vendor dts
> filenames for boards with the taped-out K1 SoC; and "k1-pro_" is
> pre-production dts filename related. That is very arbitrary and I don't
> see any reason why we should invent something on vibes about a filename
> that does not exist... but anyways it would be lowercase and not upcase.

While mainline u-boot for K1 progresses nicely, it's not ready yet (think bootstrapping spl/proper/kernel on all boards from bootrom via fastboot).
Which is why the OpenWrt PR has the vendor u-boot for now (with some patches and compatibles added to boot mainline opensbi/linux).
So I actually created a k1-x_BPI-CM6-IO.dts file in there. I just derived the name based on what else is in there:

k1-x_baton-camera.dts
k1-x_BPI-CM6-IO.dts
k1-x_deb1.dts
k1-x_deb2.dts
k1-x_evb.dts
k1-x_FusionOne.dts
k1-x_InnoBoard-Pi.dts
k1-x_lpi3a.dts
k1-x_LX-V10.dts
k1-x_milkv-jupiter.dts
k1-x_MINI-PC.dts
k1-x_MUSE-Book.dts
k1-x_MUSE-Card.dts
k1-x_MUSE-N1.dts
k1-x_MUSE-Paper2.dts
k1-x_MUSE-Paper-mini-4g.dts
k1-x_MUSE-Pi.dts
k1-x_MUSE-Pi-Pro.dts
k1-x_som.dts
k1-x_spl.dts
k1-x_uav.dts
k1-x_ZT001H.dts
k1-x_ZT_RVOH007.dts
x1_orangepi-r2s.dts
x1_orangepi-rv2.dts

- the k1-x_ prefix is to keep it in line
- there's a mix of upper and lower case
- the mainline dts has no "sv" or "sinovoip" either, it even uses the "bananapi" vendor for the compatible
- both orangepi boards are already covered. The patches are from armbian IIRC, but didn't require adding a product name to EEPROM

> Suggested thus any of:
> k1-x_bpi-cm6(-io)
> k1-x_svbpi-cm6(-io)
> k1-x_svbp-bpi-cm6(-io)
> k1-x_bpbpi-cm6(-io)
> k1-x_bpi-cm6(-io)
> k1-bananapi-cm6
> k1-bananapi-cm6-io
> k1-bananapi-f3
> 
> My strong preference is for referring to mainline Linux dts filenames if
> we are just making it up when the overwhelming trend is to refer to
> actual filenames, somewhere.
I don't really have a preference, the name I made up was the first thing that made sense to me. Whatever can be agreed upon ;)

Cheers,
Andre

Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E593CCA5FCE
	for <u-boot@archiver.kernel.org>; Mon,  5 Oct 2026 08:37:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C20E540641;
	Mon,  5 Oct 2026 08:37:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 188RNt1Synrx; Mon,  5 Oct 2026 08:37:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org EE1514064A
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791189431;
	b=GDwbiB01Tr6u838r7iEWbGKLTcKXZnwy9N3HBzyHiRFCzlgTWyekBjZza0dyguKGkPyQ
	 Kq3i92xi9a8UbtlOowA52rwNE8rcE5lXOGSy8Yg6dkKNsczyRcwWouOgP/W8BDRo4ZJd1
	 1UkSsKwY0AIYo4PQzvTRWuHIDvb833OPTBtJI7haFR2uFT9EttWNgXVvBSqMi57nlBdA6
	 InL0xrqAHhmfb5nHCbQBMQMlC76SyrZOlooJnXhmu0Rbk5a3SQQarNZ4AZ8fhaK1M2r2X
	 ZWKTPydXXxoGUSQMCIKC1k7XSU3sZSriOgMxS/peOFmcY0WEoX70QRCIE5pr8nGRYtA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791189431;
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
	bh=N9b8HOhPxElsMAODAzEec52YVbl0Lus7wJ6g7313tOk=;
	b=sOSIEn0kIgGTWX3XNn+Gl7ug9VAQmMDxxb4PI7kXwVwR5FyXkYM4WbOxM6vXuTpM5lG7
	 iLZ8ktKXWAGP1oyt0g+xBXvnYyvMwnOcrPgKoRrE2ZkhYvf92Tkk6qI7QPDIUD2GqHvC7
	 +1x03u+radr+VGNZFn40b5Y9BFG962YJYfwLggvfrBuRrCqgXLDkb7i2EMdeKCKdaz+L9
	 bzwLN6qXCYh+rRC31FuVCzRW9U+QGEBVJV7h2fQk54/AfuyrBeZ0vYq8q0+k38jbbS2l8
	 Ad7N24YZPNzL5rrJHZdGb4XC33S0+35zozRo+g1CMsd9SN3Ul1KZTIaFFbR9EiBEcqw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="r/V2VZN4";
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791189431;
	bh=N9b8HOhPxElsMAODAzEec52YVbl0Lus7wJ6g7313tOk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yHxltLzyh/GhcHEgk4rwdYdLQTT2N8Y3weTA8p7sTOuh51YEuolqWCFdEUKsjyG9V
	 J9wgJwjz0AeML/2mzndcRKvHjkVF16KT325kzT+BmzYCH/CrT83jmedNVhAEaRXw0E
	 aJLP3DQFK7QUo0PgNcL+wleIwTRkK0HwPYNIB89Ks4rX+gviaDK+IZg/99+FY+50/K
	 8YY5qHzi4dggdT3zz5eUF0AsuUyIFC4uzP/7eKT48hEYNLIETtXZFMavVKanbYwm6I
	 vyjNoywq+KGvzta43T/lFWRsxCOx+GdifiVXligBg8lDWk/0/jVSunE3txGX83ZakZ
	 3P1htllPzkyiw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id EE1514064A;
	Mon,  5 Oct 2026 08:37:10 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 2BE9734E
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 07:23:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1DE95405D6
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 07:23:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Une5FjGH35H0 for <u-boot@lists.u-boot-project.org>;
 Mon,  5 Oct 2026 07:23:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org D168A405CD
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:30::e"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791185032;
 b=YTZxOX2fbyeYdDRaHyGHQr2Rmg2devAtjGmPIqN4/SdmSUfCTXL3xK1x17dyrByU/AhD
 Kaa1NoOUOCbhY55R7N6naH4sFgX/6GOU21CgUZ0+F3DqyyByLvWbJLyuVAMLinGZ7VIi/
 atqLsB4bxLB1FuCZ1x41CH05hdu0DbC0dOjm3NpKu+FK99PweiyP8D8QpDeoYCCpyhG/I
 GDRzBl7WtIORHBXGkIXX92uIu01iPlqKMQBW8ayMDxc6PbRsfRI2k+0GgEwMGzc9ZUUF/
 HfWg459hBMjC+tx6rxEP53VXwzYCEaM5TXsTOVr3dEwZAK5fNjVelBoAF3bFrLilfDA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791185032;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
 bh=N9b8HOhPxElsMAODAzEec52YVbl0Lus7wJ6g7313tOk=;
 b=oC6yjFDbIRT46VTqJS6B4wWSITq45v0wNSLBqUbt4QFQ2ND1SYIoqZUkbcn1ntXNwM2a
 Bq6ZSusDtj1ay+FbPGhdCkrQzmbO3lKDHLkjTrIfptOt0PCXX5NrWq2RbH9gdPTQewj4U
 BsbnFc9gDe9UCm4CiYL0Bq3YOcd7+YaSBc5SNt00eKY/ylNdI69aW1KRHEwjVOF72/dqD
 csKImgJyCGMfW7FRulIt6E1CA1eX3FI8etEGf+l8OW4ZpPseFOFKjhdcm1aPehFnX9B9Z
 H7nDFnIQ7HPlDQFKbKKKuXhM46p88wct6m5Ff3oCHG3hXGTiSLDXWNw7Ukhd4zvd6MQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b="r/V2VZN4"; 
 arc=none smtp.remote-ip="2a00:1450:4864:30::e"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:30::e;
 helo=mail-wr2-x0e.google.com; envelope-from=a.heider@gmail.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=r/V2VZN4
Received: from mail-wr2-x0e.google.com (mail-wr2-x0e.google.com
 [IPv6:2a00:1450:4864:30::e])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D168A405CD
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 07:23:51 +0000 (UTC)
Received: by mail-wr2-x0e.google.com with SMTP id
 ffacd0b85a97d-48b01c41135so854023f8f.0
 for <u-boot@lists.u-boot-project.org>; Mon, 05 Oct 2026 00:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791185029; x=1791789829;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=N9b8HOhPxElsMAODAzEec52YVbl0Lus7wJ6g7313tOk=;
 b=r/V2VZN4Zn+ewLp6NdItFX7VFXcN+lt0Jb5nQPSwdV4z88VkiH3zN5hkycZpCxPv7B
 geUixb1xPO+Cy/+EUbsAiwwubVbBmd4jcRByv6m/rg3JRNF2buV6omrL2FXWHJAw2I6v
 hgFJ9rMKW5pY29I8nVQENDOTKCmggeDuJCRtuYSmO7MDSYMxnQWbLeWOy6i5tP+nbDb6
 kB7pWrNfyalpCHB7n4enjYtrSCZU/hKqhi4pjBsXA57a2CZHkQ2//EjWydW4mPkDulen
 qdWuIA/j29LsUHCi8UiNFV+8SQ+ggqZ999akKgLlJMwNgHyqXi/AMpeEmExucBaBmoUA
 WVbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791185029; x=1791789829;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=N9b8HOhPxElsMAODAzEec52YVbl0Lus7wJ6g7313tOk=;
 b=Pw96LC9s2c/aPJStyyKNdIWG8NHSDWrDlPq6GLQsLyThtc8ap9z/hk7+isVfvE37tl
 c4IjPUg9TachOTEdjCA9iTgEheb6hM+Q4S3qyCqofu4CE1IGKm5HlIUSL4tZIBauX7T+
 STCewf9Ax3xYXAVwgAFWJpySWsieyXv92CRDyDhl6mQwLUYuaJ7USO51CxRla5mhQAtg
 2mXFlAZMNlPSje2dBciPDHf5l/clCeNGzNnqCdF1LNFWdz5o99ppaAUy65cNZRqFFP5R
 RJcz+FkqXkgDk0hIHJQKtcCkllIUL+ZWknsXpIM/hLOs96yzJyH3tANawc3BYm8tXNZM
 d2Ag==
X-Forwarded-Encrypted: i=1;
 AKwUvBymhYwHSXuq0LlBD+XYBFBX1s1aeEb3STulEAZSz3CU26Gs5rRU2ZRCmfExOyUDU3s4SowyaAk=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYI6zZzihYPaTlFvToGCSo9E6vNGwxgA6HUqJDyB6CB6x9Yzpa3I
 j5A6+QmHFvrrbuclaPUsI5EfxIChBv3rkn8JPQ3tuSVUYFGESOc+s6EK
X-Gm-Gg: AYBFou1ZYkqoBpxCZ9nMnHovbvYErz82klGA6zQUmaTB3oivsiqBpCEimsHispm0exM
 CDSNGf1DhmwapNVxRWJf2Nw+O3F/ALwDqWtEplU/3MBVTHztz8Vr021m+WH2l2c64QfcC389FrH
 CRv5LYkBW7y2+qmYzxMbNovKfExP5YdzyV/0KVzM1CbtWS8SbiltAHHQJFkMir0hX3/RiampvuJ
 MzB4L2T54zLKHtAaoU14k8oosRKBcOhXRnjJA7T98MEyLyG29fv3uxEL+5B3fiX5tNKZmq8VXvN
 uPCeReP7S/rUTxHkXB8jMXucd45aPiPR7yqBmv4E/XPe1ps9Zi725ermzIvEUOggb5FE2tuBiIU
 mtql0dQJ7yPYiIrxvyv5izxShgQChIbx78CBEH1znuakET/OdkOEOasBXPMeYwGQ3d28O6hQS/M
 sRQ56w/Bi377htClLvi7Bnhr81yj5QdfU60NQz/eWPocaiLkuSEGSHgJtomKw7ZeUARcCCobXtB
 WLc/hmDhKISGXT0Prs=
X-Received: by 2002:a5d:64c9:0:b0:488:8437:b8b7 with SMTP id
 ffacd0b85a97d-48b126f1596mr18414082f8f.7.1791185029393; 
 Mon, 05 Oct 2026 00:23:49 -0700 (PDT)
Received: from ?IPV6:2a02:560:4eeb:e100::a1e? ([2a02:560:4eeb:e100::a1e])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48c63550d1esm1255732f8f.18.2026.10.05.00.23.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Oct 2026 00:23:48 -0700 (PDT)
Message-ID: <2575486d-429d-4044-9b78-bf9b13bb0aa9@gmail.com>
Date: Mon, 5 Oct 2026 09:23:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 7/7] spacemit: k1: fix product name detection and DTB
 matching in SPL
To: Eric Chung <eric.chung@riscstar.com>
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
From: Andre Heider <a.heider@gmail.com>
Content-Language: de-DE, en-US
In-Reply-To: <CAH22mJw3MfVyEva=CGgaEp4y_V2cCv-=n3vz9oKpHtkjsScAPQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 05 Oct 2026 08:34:58 +0000
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

On 05.10.26 6:01 AM, Eric Chung wrote:
> On Fri, Oct 2, 2026 at 8:58 PM Andre Heider <a.heider@gmail.com> wrote:
>>
>> Hi,
>>
>> just a general question related to this patch, not about the patch itself, see below:
>>
>> On 12.09.26 2:37 PM, Eric Chung wrote:
>>> +static const struct {
>>> +     const char *eeprom_name;
>>> +     const char *fit_name;
>>> +} k1_board_map[] = {
>>> +     { "k1-x_MUSE-Pi-Pro",   "spacemit/k1-musepi-pro"    },
>>> +     { "k1-x_deb1",          "spacemit/k1-bananapi-f3"   },
>>> +     { "k1-x_milkv-jupiter", "spacemit/k1-milkv-jupiter" },
>>> +};
>> This maps the EEPROMs product_name to the dtb, just like the vendor fork, nice.
>>
>> But does the BPI F3 really have "k1-x_deb1" in there?
>> I know that's the fallback dtb of the vendor's fork [0][1], in case there's nothing there, and I thought that was the case for the F3?
>>
> 
> k1-x_deb1 means the internal development board. And it could work
> smoothly on the Banana Pi F3.

Yes, but maybe someone with a F3 board can verify via `tlv_eeprom` if that string is actually in there?

> 
> 
>> Because it seems it's not set for BPI-CM6 IO board either [2], which then makes it impossible to distinguish, at least based on the EEPROM value :\
>>
> 
> What's BPI-CM6 IO board? Is the BPI-CM6 IO board similar to the Banana
> Pi F3? Is it supported by linux kernel now?

This one:
https://docs.banana-pi.org/en/BPI-CM6/BananaPi_BPI-CM6

Supported by mainline via:
arch/riscv/boot/dts/spacemit/k1-bananapi-cm6-io.dts

Apparently sinovoip *edited* k1-x_deb1.dts for CM6 and even ship that hack in their OS images (visible in the logs on that OpenWrt PR):
https://github.com/BPI-SINOVOIP/pi-linux/commit/333b99e8cd9b18e98bf71821518548df345dbb61
/o\

> 
>> Are there any ideas how to handle that, yet?
>>
>> Can we distinguish between those boards in the SPL based on something different?
>>
>> Or can we make up our own strings and let users write that to EEPROM? Mainline and vendor technically allows it via e.g.:
>>     tlv_eeprom set 0x21 "k1-x_BPI-CM6-IO"
>>     tlv_eeprom write
>> But that's assuming the EEPROM is writable, which I haven't checked.
>> (And I neither have a F3 nor a CM6).
>>
> 
> tlv_eeprom should support to write EEPROM. If it fails, we could
> enable ENV in SPL. I have a patch in the mailing list to enable ENV.
> But that patch was abandoned. You could review the mailing list to
> reuse it.

In the meantime a board owner verified the EEPROM write as working:
https://github.com/openwrt/openwrt/pull/23231#issuecomment-5972395785

For the record, I made up "k1-x_BPI-CM6-IO" as product name with a matching vendor fork device-tree file name, which makes u-boot as well as the kernel pick up their matching device-trees via CONFIG_FIT_BEST_MATCH.

In case mainline u-boot goes the same way (let CM6 owners add a value to EEPROM) to properly make multi-dtb fit images boot, can we agree on a value? Or maybe someone here has connections to sinovoip and ask them to put that/anything in there?

> 
>> Cheers,
>> Andre
>>
>> [0] https://gitee.com/spacemit-buildroot/uboot-2022.10/blob/k1-bl-v2.2.y/include/configs/k1-x.h#L28
>> [1] https://gitee.com/spacemit-buildroot/uboot-2022.10/blob/k1-bl-v2.2.y/board/spacemit/k1-x/spl.c#L558
>> [2] https://github.com/openwrt/openwrt/pull/23231#issuecomment-5943699070


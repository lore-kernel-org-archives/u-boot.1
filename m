Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5AF1CD4F2E
	for <u-boot@archiver.kernel.org>; Fri, 22 Sep 2023 08:04:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9DD5186504;
	Fri, 22 Sep 2023 10:04:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="C7E+kBGv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 023DB8652B; Fri, 22 Sep 2023 10:04:35 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 76EA186575
 for <u-boot@lists.denx.de>; Fri, 22 Sep 2023 10:04:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38M84OB7040691;
 Fri, 22 Sep 2023 03:04:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1695369864;
 bh=khJbGnVm0xc7GZTPYXvPqa+TcUh7C8cfIBYvFbojgcw=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=C7E+kBGvWc+lWYOPZ6AQmWla+mfSIrLpzSdfxYYa5sgMKC8oF97fcGW2+SIeWeuLI
 v9gawvlq2x5n8wWJdBpvBp4MyD5/WYGcyeJHw0apsvgN+zPT7OsnoF57E7eCKNESBU
 COkS2q/KAOdv6Gz11VRzOR+ole6eW1SaDCymQFDY=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38M84Od3025998
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 22 Sep 2023 03:04:24 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 22
 Sep 2023 03:04:24 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 22 Sep 2023 03:04:24 -0500
Received: from [10.24.68.114] (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38M84LD7010766;
 Fri, 22 Sep 2023 03:04:22 -0500
Message-ID: <93be618e-b095-32f6-9bc6-e1bb5d8c24e6@ti.com>
Date: Fri, 22 Sep 2023 13:34:21 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [Question] TI's u-boot.img is built twice
Content-Language: en-US
To: Masahiro Yamada <masahiroy@kernel.org>
CC: U-Boot Mailing List <u-boot@lists.denx.de>, Simon Glass
 <sjg@chromium.org>, Nishanth Menon <nm@ti.com>,
 <srk@ti.com>, <s-vadapalli@ti.com>, <m-chawdhry@ti.com>
References: <CAK7LNASYfwjuCQ70BZ5Gco+rme=H_fArxyT5rFsE334p2viSoA@mail.gmail.com>
 <3cd1e2b4-47b9-a3b3-d8c3-9f6c0481f479@ti.com>
 <CAK7LNAQg-x9L9s3j2d6DYdoW7WuHKfhMq5n=4GfrMLvjO9vQmg@mail.gmail.com>
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <CAK7LNAQg-x9L9s3j2d6DYdoW7WuHKfhMq5n=4GfrMLvjO9vQmg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

Hi Masahiro

On 22/09/23 12:48, Masahiro Yamada wrote:
> On Fri, Sep 22, 2023 at 2:27 PM Neha Malcom Francis <n-francis@ti.com> wrote:
>>
>> Hi Masahiro
>>
>> On 21/09/23 21:06, Masahiro Yamada wrote:
>>> Hi.
>>>
>>> Since the TI platform migrated to binman,
>>> u-boot.img is built twice.
>>>
>>> It is created by "mkimage -E",
>>> then overwritten by binman.
>>>
>>>
>>> So, the data are embedded in the FIT structure
>>> instead of being appended.
>>>
>>> Is this intentional?
>>>
>>> To me, it looks weird.
>>>
>>>
>>
>> I haven't added the fit,external-offset property in the binman.dtsi so it was
>> not appended as external data and I did not find reason to. Is there any benefit
>> in having the data appended than embedded?
> 
> 
> 
> Placing payload data outside the FIT structure is a U-Boot hack.
> 
> 
> The motivation was explained in the commit log of
> 722ebc8f84d5bccd2e70fad1079a0dd40cceddec
> 
> 

Thanks for this! Makes sense, I think we should make it appended again in 
binman. Can reduce boot time.

> 
> Before TI migrated to binman,
> u-boot.img was the "payload outside" structure
> but it is not any more.
> 
> I do not mind the implementation details as long as
> U-Boot is able to boot the Linux kernel.
> 
> 
> I was just suffering from the AM64-SK boot failure
> (as I asked in another thread) and just noticed
> something odd when I was poking the SPL code.
> 
> 
> At least, .u-boot.img.cmd is not telling the truth.
> 
> Usually, the build command is saved in a *.cmd file
> but this does not reflect the reality, because
> it is binman that created the final u-boot.img
> 
> 
> $ cat .u-boot.img.cmd
> cmd_u-boot.img := ./tools/mkimage -f auto -A arm -T firmware -C none
> -O u-boot -a 0x80800000 -e 0x80800000 -p 0x0 -n "U-Boot
> 2023.10-rc4-00047-gb9b83a86f0-dirty for am64x board" -E  -b
> arch/arm/dts/k3-am642-evm.dtb -b arch/arm/dts/k3-am642-sk.dtb  -d
> u-boot-nodtb.bin u-boot.img >/dev/null
> 
> 
> I will not track it down any further, though.
> It is too complicated.
> 
> 
> 

I am not too sure about the .cmd files but looks like its misleading probably 
because the replacing of the binman generated image takes under cmd_binman and 
not directly from the Makefile (just a guess).
> 
> 
>>>
>>>
>>> To confirm it, apply the following hack.
>>>
>>> Since u-boot.img is overwritten by binman,
>>> copy it to u-boot.img.backup.
>>>
>>>
>>>
>>>
>>> diff --git a/Makefile b/Makefile
>>> index 87f9fc786e..4cffa8a061 100644
>>> --- a/Makefile
>>> +++ b/Makefile
>>> @@ -1112,6 +1112,7 @@ endef
>>>    # Timestamp file to make sure that binman always runs
>>>    .binman_stamp: $(INPUTS-y) FORCE
>>>    ifeq ($(CONFIG_BINMAN),y)
>>> +       cp u-boot.img u-boot.img.backup
>>>           $(call if_changed,binman)
>>>    endif
>>>           @touch $@
>>>
>>>
>>>
>>> Then, build it for the main core.
>>>
>>>
>>> make -j$(nproc) CROSS_COMPILE=aarch64-linux-gnu-
>>>      am64x_evm_a53_defconfig all
>>>      TEE=~/ref/OP-TEE/optee_os/out/arm-plat-k3/core/tee-raw.bin
>>>      BL31=~/ref/trusted-firmware-a/build/k3/lite/release/bl31.bin
>>>      BINMAN_INDIRS=~/ref/ti-linux-firmware
>>>
>>>
>>>
>>>
>>> Compare the two files.
>>> Run fdtdump to see what happened to them.
>>>
>>>
>>> $ diff -u u-boot.img  u-boot.img.backup
>>> Binary files u-boot.img and u-boot.img.backup differ
>>>
>>>
>>> $ fdtdump u-boot.img
>>>       => u-boot and dt are embedded.
>>>
>>> $ fdtdump u-boot.img.backup
>>>       => u-boot and dt are appended after the
>>>          FIT structure
>>>
>>>
>>>
>>
>> --
>> Thanking You
>> Neha Malcom Francis
> 
> 
> 

-- 
Thanking You
Neha Malcom Francis

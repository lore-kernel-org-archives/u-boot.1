Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9004ACD4843
	for <u-boot@archiver.kernel.org>; Fri, 22 Sep 2023 16:35:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD55F86504;
	Fri, 22 Sep 2023 18:35:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="PLNIK1Hn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C0EA585DFA; Fri, 22 Sep 2023 18:35:26 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E73B85DFA
 for <u-boot@lists.denx.de>; Fri, 22 Sep 2023 18:35:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38MGZJr6043985;
 Fri, 22 Sep 2023 11:35:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1695400519;
 bh=XkE+uur3xlGHR8NMl0fMZPoblbt60/S2mURB6efvMd4=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=PLNIK1HnzsSkoYUQInchQuEqkJpF1NLFihR0Hub2Dgcv6XP0s96BuQHd86BhwYzY0
 1wyYYqXfr3RzNEv9oiFFcozkQuyo+DqU/pJqNIU0uE1T9wTTkFXDWJ6DoecQerzEbJ
 lsNMzPM+iw30/IQyxsYmqiwKJDUitOmnnkG8PV/Q=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38MGZJdB054921
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 22 Sep 2023 11:35:19 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 22
 Sep 2023 11:35:19 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 22 Sep 2023 11:35:18 -0500
Received: from [10.250.38.120] (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38MGZIkM099136;
 Fri, 22 Sep 2023 11:35:18 -0500
Message-ID: <41a5e281-9dcd-9720-380a-ea59566d7dc1@ti.com>
Date: Fri, 22 Sep 2023 11:35:18 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [Question] TI's u-boot.img is built twice
Content-Language: en-US
To: Simon Glass <sjg@chromium.org>, Masahiro Yamada <masahiroy@kernel.org>
CC: U-Boot Mailing List <u-boot@lists.denx.de>, Nishanth Menon <nm@ti.com>,
 <srk@ti.com>, <n-francis@ti.com>, <s-vadapalli@ti.com>, <m-chawdhry@ti.com>
References: <CAK7LNASYfwjuCQ70BZ5Gco+rme=H_fArxyT5rFsE334p2viSoA@mail.gmail.com>
 <CAPnjgZ2W_2d-xhdKPbatR4L3BjE08ZEH4SdBSi6YVDWqs7Swmw@mail.gmail.com>
From: Andrew Davis <afd@ti.com>
In-Reply-To: <CAPnjgZ2W_2d-xhdKPbatR4L3BjE08ZEH4SdBSi6YVDWqs7Swmw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
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

On 9/22/23 10:01 AM, Simon Glass wrote:
> Hi Masahiro,
> 
> On Thu, 21 Sept 2023 at 09:36, Masahiro Yamada <masahiroy@kernel.org> wrote:
>>
>> Hi.
>>
>> Since the TI platform migrated to binman,
>> u-boot.img is built twice.
>>
>> It is created by "mkimage -E",
>> then overwritten by binman.
>>
>>
>> So, the data are embedded in the FIT structure
>> instead of being appended.
>>
>> Is this intentional?
>>
>> To me, it looks weird.
>>
>>
>>
>>
>> To confirm it, apply the following hack.
>>
>> Since u-boot.img is overwritten by binman,
>> copy it to u-boot.img.backup.
>>
>>
>>
>>
>> diff --git a/Makefile b/Makefile
>> index 87f9fc786e..4cffa8a061 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -1112,6 +1112,7 @@ endef
>>   # Timestamp file to make sure that binman always runs
>>   .binman_stamp: $(INPUTS-y) FORCE
>>   ifeq ($(CONFIG_BINMAN),y)
>> +       cp u-boot.img u-boot.img.backup
>>          $(call if_changed,binman)
>>   endif
>>          @touch $@
>>
>>
>>
>> Then, build it for the main core.
>>
>>
>> make -j$(nproc) CROSS_COMPILE=aarch64-linux-gnu-
>>     am64x_evm_a53_defconfig all
>>     TEE=~/ref/OP-TEE/optee_os/out/arm-plat-k3/core/tee-raw.bin
>>     BL31=~/ref/trusted-firmware-a/build/k3/lite/release/bl31.bin
>>     BINMAN_INDIRS=~/ref/ti-linux-firmware
>>
>>
>>
>>
>> Compare the two files.
>> Run fdtdump to see what happened to them.
>>
>>
>> $ diff -u u-boot.img  u-boot.img.backup
>> Binary files u-boot.img and u-boot.img.backup differ
>>
>>
>> $ fdtdump u-boot.img
>>      => u-boot and dt are embedded.
>>
>> $ fdtdump u-boot.img.backup
>>      => u-boot and dt are appended after the
>>         FIT structure
> 
> That seems like a bug to me...at some point we might consider building
> u-boot.img with Binman, but for now it is built by the Makefile.
> 

This is not true for K3 as we now use Binman for u-boot.img generation
(we need this as we have a signing step injected at this point).

So as Masahiro suggested in the other branch of this thread, we need
to disable the Makefile generation of u-boot.img for K3.

Neha,

Can you take this action? I assume you can add it as part of your
work in making the data external again, which would make the u-boot.img
identical to before and hence Makefile version could be disabled at
the same time/series.

Andrew

>>
>>
>>
>> --
>> Best Regards
>> Masahiro Yamada
> 
> Regards,
> Simon

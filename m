Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98DB8CD484B
	for <u-boot@archiver.kernel.org>; Fri, 22 Sep 2023 18:14:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A6F2B869F1;
	Fri, 22 Sep 2023 20:14:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="K8PWP7Z4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3FD17869F6; Fri, 22 Sep 2023 20:14:15 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B157985E44
 for <u-boot@lists.denx.de>; Fri, 22 Sep 2023 20:14:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38MIE7fw064142;
 Fri, 22 Sep 2023 13:14:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1695406447;
 bh=xiu5czr+mbaTx1CMscCp5Xer9nZfIOdHwpehV6VgfMI=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=K8PWP7Z4pbWU9c3NBWAbVYFVqY0MSabDj+etJl3AwK53+eDqw2fx5fJC5wr5mV8qo
 bfA1JfY7ArhnrFoi119Nbg/gXMYfemXPCQoJNsXbZDU67mS+ViyLpWwIqfiVUcC1La
 69+fqZ+pSO3UgQ7qEVDuoPGLwkslCzQHLvA6d+q4=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38MIE7FT113982
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 22 Sep 2023 13:14:07 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 22
 Sep 2023 13:14:07 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 22 Sep 2023 13:14:07 -0500
Received: from [10.250.38.120] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38MIE6DL029403;
 Fri, 22 Sep 2023 13:14:06 -0500
Message-ID: <eaf56065-9f9e-70b4-e901-3e6dc2934cd1@ti.com>
Date: Fri, 22 Sep 2023 13:14:06 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [Question] TI's u-boot.img is built twice
Content-Language: en-US
To: Simon Glass <sjg@chromium.org>
CC: Masahiro Yamada <masahiroy@kernel.org>, U-Boot Mailing List
 <u-boot@lists.denx.de>,
 Nishanth Menon <nm@ti.com>, <srk@ti.com>, <n-francis@ti.com>,
 <s-vadapalli@ti.com>, <m-chawdhry@ti.com>
References: <CAK7LNASYfwjuCQ70BZ5Gco+rme=H_fArxyT5rFsE334p2viSoA@mail.gmail.com>
 <CAPnjgZ2W_2d-xhdKPbatR4L3BjE08ZEH4SdBSi6YVDWqs7Swmw@mail.gmail.com>
 <41a5e281-9dcd-9720-380a-ea59566d7dc1@ti.com>
 <CAPnjgZ34hW-61MNEORQU8xofBaoBu_piau4rKd2hdTJgFbSZnA@mail.gmail.com>
From: Andrew Davis <afd@ti.com>
In-Reply-To: <CAPnjgZ34hW-61MNEORQU8xofBaoBu_piau4rKd2hdTJgFbSZnA@mail.gmail.com>
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

On 9/22/23 11:40 AM, Simon Glass wrote:
> Hi Andrew,
> 
> On Fri, 22 Sept 2023 at 10:35, Andrew Davis <afd@ti.com> wrote:
>>
>> On 9/22/23 10:01 AM, Simon Glass wrote:
>>> Hi Masahiro,
>>>
>>> On Thu, 21 Sept 2023 at 09:36, Masahiro Yamada <masahiroy@kernel.org> wrote:
>>>>
>>>> Hi.
>>>>
>>>> Since the TI platform migrated to binman,
>>>> u-boot.img is built twice.
>>>>
>>>> It is created by "mkimage -E",
>>>> then overwritten by binman.
>>>>
>>>>
>>>> So, the data are embedded in the FIT structure
>>>> instead of being appended.
>>>>
>>>> Is this intentional?
>>>>
>>>> To me, it looks weird.
>>>>
>>>>
>>>>
>>>>
>>>> To confirm it, apply the following hack.
>>>>
>>>> Since u-boot.img is overwritten by binman,
>>>> copy it to u-boot.img.backup.
>>>>
>>>>
>>>>
>>>>
>>>> diff --git a/Makefile b/Makefile
>>>> index 87f9fc786e..4cffa8a061 100644
>>>> --- a/Makefile
>>>> +++ b/Makefile
>>>> @@ -1112,6 +1112,7 @@ endef
>>>>    # Timestamp file to make sure that binman always runs
>>>>    .binman_stamp: $(INPUTS-y) FORCE
>>>>    ifeq ($(CONFIG_BINMAN),y)
>>>> +       cp u-boot.img u-boot.img.backup
>>>>           $(call if_changed,binman)
>>>>    endif
>>>>           @touch $@
>>>>
>>>>
>>>>
>>>> Then, build it for the main core.
>>>>
>>>>
>>>> make -j$(nproc) CROSS_COMPILE=aarch64-linux-gnu-
>>>>      am64x_evm_a53_defconfig all
>>>>      TEE=~/ref/OP-TEE/optee_os/out/arm-plat-k3/core/tee-raw.bin
>>>>      BL31=~/ref/trusted-firmware-a/build/k3/lite/release/bl31.bin
>>>>      BINMAN_INDIRS=~/ref/ti-linux-firmware
>>>>
>>>>
>>>>
>>>>
>>>> Compare the two files.
>>>> Run fdtdump to see what happened to them.
>>>>
>>>>
>>>> $ diff -u u-boot.img  u-boot.img.backup
>>>> Binary files u-boot.img and u-boot.img.backup differ
>>>>
>>>>
>>>> $ fdtdump u-boot.img
>>>>       => u-boot and dt are embedded.
>>>>
>>>> $ fdtdump u-boot.img.backup
>>>>       => u-boot and dt are appended after the
>>>>          FIT structure
>>>
>>> That seems like a bug to me...at some point we might consider building
>>> u-boot.img with Binman, but for now it is built by the Makefile.
>>>
>>
>> This is not true for K3 as we now use Binman for u-boot.img generation
>> (we need this as we have a signing step injected at this point).
> 
> No, no.
> 
> You must not mess with the outputs of Makefile - create a new file
> with what you need, e.g. u-boot-ti.img
> 
> While we could use Binman to produce the .img we are quite a way from
> doing that as not that many boards have been converted to binman.
> 

Too late, we already use Binman to generate u-boot.img on K3, why
would we want to go back to using Makefile?

Let's go with what you suggest below and add a Kconfig that can
be used for boards that have already switched to binman that disables
the Makefile generator for u-boot.img.

Once all boards have switched to Binman, then we could refactor
the implementations into something more common.

Andrew

>>
>> So as Masahiro suggested in the other branch of this thread, we need
>> to disable the Makefile generation of u-boot.img for K3.
>>
>> Neha,
>>
>> Can you take this action? I assume you can add it as part of your
>> work in making the data external again, which would make the u-boot.img
>> identical to before and hence Makefile version could be disabled at
>> the same time/series.
> 
> If you are suggesting that we slowly migrate boards away from
> generating the .img using Makefile...perhaps that makes sense? I'm not
> really sure. But in that case we need another Kconfig option.
> 
> Regards,
> Simon

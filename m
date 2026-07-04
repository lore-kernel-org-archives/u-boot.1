Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DEB4C43458
	for <u-boot@archiver.kernel.org>; Sat,  4 Jul 2026 21:12:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E639846FD;
	Sat,  4 Jul 2026 23:12:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="KmLA14Ih";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E4C78341A; Sat,  4 Jul 2026 23:12:18 +0200 (CEST)
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 27E5A8484C
 for <u-boot@lists.denx.de>; Sat,  4 Jul 2026 23:12:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marex@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 77EA410A269; Sat,  4 Jul 2026 23:12:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1783199534;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=vA8t3goxaImVuxQpcc1cOLu+bfwQuOTF362hG1K+hok=;
 b=KmLA14IhgO40AYR5/IACZ3w8qE2F2iZLH6k1OBm6WP2USo73Y61oPNUd15zveLbZ3TkOwg
 Yk8NYWqRDIzG5+OHRWZfgZoDHZJ+QG5jq8U2utDIFOoNvXvGpRGvZGFeARXK0goP7HoP7+
 yrHt9Nd+/v9rPKddy/zB9rwd3hY6fJvhh3PCLrz0ULqyvmT2YTrDXa24qMfhh/kwV14BcD
 1oVajNrD6iGvV6U7bCuU4vg8nNv4I1bL75fCvvfoPk95gR/51LNbyNfM8+ULhJOijrmKyA
 AIeJrb5se93Bpfht2S5bHFWQCsssXP/20hQQabc442/rzvskc1A3vJMKJpQXiA==
Message-ID: <95b68d7f-e0e6-46b2-af35-8da68c2a9b6a@nabladev.com>
Date: Sat, 4 Jul 2026 22:13:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: imx8m: Reinstate TEE ifdeffery
To: Yannic Moog <Y.Moog@phytec.de>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Fabio Estevam <festevam@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Simon Glass <sjg@chromium.org>, Stefano Babic <sbabic@nabladev.com>,
 Tom Rini <trini@konsulko.com>, Ye Li <ye.li@nxp.com>
References: <20260630160951.122230-1-marex@nabladev.com>
 <0e9071095b0b590c45a139eacb210192e160823f.camel@phytec.de>
 <3200f8b6-6e5e-4275-8442-03ecb6a48597@nabladev.com>
 <5147fb9ef450d4a6963b57dbfdd6ee03eb2ae29a.camel@phytec.de>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <5147fb9ef450d4a6963b57dbfdd6ee03eb2ae29a.camel@phytec.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
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

On 7/3/26 8:16 AM, Yannic Moog wrote:

Hello Yannic,

[...]

>>> is not accurate. You were able to package OP-TEE without needing to enable support in U-Boot.
>>> And
>>> afaik this is a perfectly valid use-case.
>>
>> When you include optee-os in the U-Boot fitImage, what do you do with
>> that optee-os which U-Boot does not support ? Details please ?
> 
> Sure, sorry. OS can/will use it. There is no requirement, that I know, of any bootloader
> interfacing with OP-TEE for proper functionality and its purpose is to work with Linux kernel.

At minimum, if CONFIG_OPTEE is not enabled, U-Boot won't execute 
optee_copy_fdt_nodes() and won't transfer any optee-os firmware and 
reserved-memory DT nodes to the Linux DT when starting the kernel, so 
Linux DT will be buggy and Linux may possibly misbehave.

> I guess the only job bootloader needs to do is load it into memory. I don't know details about
> specific uses within the security context and if there are any that require bootloader support.

If in your use case, U-Boot is supposed to only load optee-os into 
memory , why not load it from U-Boot command line or as part of fitImage 
when booting Linux kernel ?

It seems in your use case, optee-os does not have to be part of the 
bootloader image at all ?

>>> With this change you can no longer do that, so this change is a regression.
>>>
>>> About the warning message. I understand that you find it confusing; binman is designed so that
>>> it
>>> emits a warning when an optional blob is not found.
>>
>> Please see above.
>>
>>> I prefer that approach to no message at all. You may want to package OP-TEE (e.g. you have an
>>> tf-a
>>> blob which jumps to OP-TEE addr) and being alerted to a possible mistake is important; Let's
>>> say
>>> tee path was incorrect during build.
>>
>> Is this some sort of a board-specific configuration ?
> 
> kind of. We have tee path set in <soc>-u-boot.dtsi: filename = "tee.bin";
> 
> Could happen that TEE=teee.bin is set or file is named tee-raw.bin and then it helps to get a
> warning that binman was not able to package the blob.
> 
>>
>> Why does U-Boot not enable OPTEE-OS support in this case ?
> 
> No need to. Maybe to conserve space, or by principle only enable the configs that are actually
> needed? I believe PHYTEC boards used to do that before KASLR support.

This does not seem correct, please see above.

At this point, I would suggest that if you want to retain this kind of 
configuration for your hardware, it should be moved into board specific 
DT, it should not be part of the common DTs.

>>> Also, keeping optional when using if defs is not a good idea. Binman will still build you an
>>> image
>>> when no OP-TEE blob is present, but should not since you enabled OPTEE configs. If you enable
>>> OPTEE, you should have an OP-TEE blob packaged.
>>> We could add ifndef OPTEE around the optional property.
>>
>> The optional keyword is actually kept in this case, it is not a full revert.
>>
>> You did however miss one vital point -- the tee node is part of the
>> U-boot fitImage, even if the tee.bin binary is not present and OPTEE
>> support in U-Boot is disabled. Binman prints a confusing message, and
>> generates a bogus empty tee {} node in the fitImage. That is incorrect.
> 
> Yes, forgot to address that. I don't think it is confusing, at least content wise. Visually, I can
> see how that is confusing. I want to neither agree nor disagree on the correctness part because I
> don't really know the fitImage spec. Having the tee node be part of the fitImage is a design
> choice, all optional blobs behave that way from my understanding.

It is a broken node introduced by commit b57ed147939c ("dts: 
imx8m{m,n,p,q}: Make optee packaging optional") , it is not supposed to 
be part of the fitImage unless optee-os is bundled into the fitImage.

> I guess it means that there is a bug in binman if you say having empty tee node is incorrect.
> And so it should be fixed in binman itself imo, not here for imx8.
No, this is not a bug in binman, please see above.

Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 300F3C43458
	for <u-boot@archiver.kernel.org>; Thu,  2 Jul 2026 23:06:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C93C84994;
	Fri,  3 Jul 2026 01:06:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="WuRXZZH9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4014E84A75; Fri,  3 Jul 2026 01:06:39 +0200 (CEST)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 428D984857
 for <u-boot@lists.denx.de>; Fri,  3 Jul 2026 01:06:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marex@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 9E542118AC1; Fri,  3 Jul 2026 01:06:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1783033596;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=Doy62Fp1maHrQCmldrBQQ+T/SyxxIcviOKQf4rghogg=;
 b=WuRXZZH90XF+EA1boBES0HHcLXvOChrx8kxUbhMlONYKudomMDnZqtteBLZe0JZA9coyk0
 gvAxj2yZfQyBMxRh+USz0gEtqTMCzSTpMH7iwDaSl02tnPAtqIIGBQQNVHNaoMAux8CfRC
 Fknv8vZ+JgrHbgbDYeUKXEKT+2ZYWWmp3xop7sP2sB2EytixbNOj0qitigntVDAD9v6usU
 c6CccqgLgahKHDTmP05Q6NtU9xdDlAMeOfanGvaDJzqy6RGNq2nAxFXLJmxODjo9xJW6j5
 LHxqV1k++8k07GknUx9ymfoUoTHbeg+gDyw/x1IY0Wvx4Vo889BRxBfuEH8Z+g==
Message-ID: <3200f8b6-6e5e-4275-8442-03ecb6a48597@nabladev.com>
Date: Fri, 3 Jul 2026 00:25:10 +0200
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
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <0e9071095b0b590c45a139eacb210192e160823f.camel@phytec.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 7/2/26 9:04 AM, Yannic Moog wrote:

Hello Yannic,

> On Tue, 2026-06-30 at 18:08 +0200, Marek Vasut wrote:
>> Since b57ed147939c ("dts: imx8m{m,n,p,q}: Make optee packaging optional")
>> the TEE node is always present in U-Boot proper fitImage, even if the
>> CONFIG_OPTEE is disabled because the u-boot.itb should not contain any
>> tee.bin. This is wasteful, and produces the following warning which is
>> also confusing to users:
>>
>> "
>> Image 'image' is missing optional external blobs but is still functional: tee-os
>>
>> /binman/section/fit/images/tee/tee-os (tee.bin):
>>     See the documentation for your board. You may need to build Open Portable
>>     Trusted Execution Environment (OP-TEE) and build with TEE=/path/to/tee.bin
>> "
>>
>> Reinstate the CONFIG_OPTEE ifdeffery to mitigate the problem, but retain the
>> binman "optional" keyword at tee.bin .
> 
> I disagree. You are removing a feature and cause further problems with this commit.

I tried to avoid outright reverting the offending commit b57ed147939c 
("dts: imx8m{m,n,p,q}: Make optee packaging optional") which introduced 
the problem I described above.

> Your initial assumption
> 
>> even if the
>> CONFIG_OPTEE is disabled because the u-boot.itb should not contain any
>> tee.bin
> 
> is not accurate. You were able to package OP-TEE without needing to enable support in U-Boot. And
> afaik this is a perfectly valid use-case.

When you include optee-os in the U-Boot fitImage, what do you do with 
that optee-os which U-Boot does not support ? Details please ?

> With this change you can no longer do that, so this change is a regression.
> 
> About the warning message. I understand that you find it confusing; binman is designed so that it
> emits a warning when an optional blob is not found.

Please see above.

> I prefer that approach to no message at all. You may want to package OP-TEE (e.g. you have an tf-a
> blob which jumps to OP-TEE addr) and being alerted to a possible mistake is important; Let's say
> tee path was incorrect during build.

Is this some sort of a board-specific configuration ?

Why does U-Boot not enable OPTEE-OS support in this case ?

> Also, keeping optional when using if defs is not a good idea. Binman will still build you an image
> when no OP-TEE blob is present, but should not since you enabled OPTEE configs. If you enable
> OPTEE, you should have an OP-TEE blob packaged.
> We could add ifndef OPTEE around the optional property.

The optional keyword is actually kept in this case, it is not a full revert.

You did however miss one vital point -- the tee node is part of the 
U-boot fitImage, even if the tee.bin binary is not present and OPTEE 
support in U-Boot is disabled. Binman prints a confusing message, and 
generates a bogus empty tee {} node in the fitImage. That is incorrect.

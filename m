Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F060BC43602
	for <u-boot@archiver.kernel.org>; Mon,  6 Jul 2026 22:36:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 30EB8846B4;
	Tue,  7 Jul 2026 00:36:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="g6/o9k/5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5AB9C84844; Tue,  7 Jul 2026 00:36:28 +0200 (CEST)
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2EF95801A9
 for <u-boot@lists.denx.de>; Tue,  7 Jul 2026 00:36:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marex@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 773F9118DB0; Tue,  7 Jul 2026 00:36:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1783377384;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=kYcPtju+EK/q81nCpg1SF5SCO3ONIk7HPo54qaiKlpo=;
 b=g6/o9k/5YlcmruxIan67Lp9Ko3ReJH9Q1YoLhXVB8Hbt/Cw1J1lj0FwZ5H9pfbthvP64Xk
 uOXCWL5j5Zo4b5UUgBYNpLOq8hL4o9NfZoeb15aTYiyy9CLC296lW+rQlXil0u/t7GR6dV
 KSEpiM/JZOP+VJFh4Toxuf3NGUfyCPLp9/smB7QOZ3KGD7tzzw6QIYLfqO3GEsfySEfNi5
 XlUSlVIXBEZjOAfpAHKoVlsM/9scvBxuEuxchtK0Pl0plIGhVlpDH7RIC+Iet2O+d+Cq/O
 U5qa5q5oyV6ZH08gR8vW5kU+4fBcsKUw4voVDOrTR7dNSW584UlOCdWg88QPEw==
Message-ID: <6da789b2-de94-4e9a-80dd-3125e8df36ba@nabladev.com>
Date: Tue, 7 Jul 2026 00:36:21 +0200
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
 <95b68d7f-e0e6-46b2-af35-8da68c2a9b6a@nabladev.com>
 <8b8468aedb4510d4956ffd548e6e6a8c69cbafe3.camel@phytec.de>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <8b8468aedb4510d4956ffd548e6e6a8c69cbafe3.camel@phytec.de>
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

On 7/6/26 2:36 PM, Yannic Moog wrote:

Hello Yannic,

>>>> When you include optee-os in the U-Boot fitImage, what do you do with
>>>> that optee-os which U-Boot does not support ? Details please ?
>>>
>>> Sure, sorry. OS can/will use it. There is no requirement, that I know, of any bootloader
>>> interfacing with OP-TEE for proper functionality and its purpose is to work with Linux kernel.
>>
>> At minimum, if CONFIG_OPTEE is not enabled, U-Boot won't execute
>> optee_copy_fdt_nodes() and won't transfer any optee-os firmware and
>> reserved-memory DT nodes to the Linux DT when starting the kernel, so
>> Linux DT will be buggy and Linux may possibly misbehave.
> 
> Got it. I tested your theory and with all TEE configs off and OP-TEE packaged, kernel device tree
> still has the necessary device tree nodes. Is there something I missed (am using phycore-imx8mp
> board) ? How does your Linux dtb look like in that scenario?

I cannot answer this question, the test you performed is not well 
documented -- kernel version is unknown, whether the kernel was in any 
way modified is also unknown, etc. Maybe your kernel tree already 
contains some optee-os node ?

>>> I guess the only job bootloader needs to do is load it into memory. I don't know details about
>>> specific uses within the security context and if there are any that require bootloader support.
>>
>> If in your use case, U-Boot is supposed to only load optee-os into
>> memory , why not load it from U-Boot command line or as part of fitImage
>> when booting Linux kernel ?
> 
> I figured via the u-boot.dtsi is the easiest solution.
> 
>>
>> It seems in your use case, optee-os does not have to be part of the
>> bootloader image at all ?
> 
> I believe it does. The init phase looks the following (on imx8m)
> 
> ROM -> U-Boot SPL -> tf-a -> OP-TEE -> tf-a -> U-boot proper
> 
> and something has to load OP-TEE into main memory when tf-a is done with init and jumps to the
> OPTEE load addr. That's what U-Boot does.

In that case, U-Boot should be aware of that optee-os , i.e. enable 
CONFIG_OPTEE .

[...]

>>>>> Also, keeping optional when using if defs is not a good idea. Binman will still build you
>>>>> an
>>>>> image
>>>>> when no OP-TEE blob is present, but should not since you enabled OPTEE configs. If you
>>>>> enable
>>>>> OPTEE, you should have an OP-TEE blob packaged.
>>>>> We could add ifndef OPTEE around the optional property.
>>>>
>>>> The optional keyword is actually kept in this case, it is not a full revert.
>>>>
>>>> You did however miss one vital point -- the tee node is part of the
>>>> U-boot fitImage, even if the tee.bin binary is not present and OPTEE
>>>> support in U-Boot is disabled. Binman prints a confusing message, and
>>>> generates a bogus empty tee {} node in the fitImage. That is incorrect.
>>>
>>> Yes, forgot to address that. I don't think it is confusing, at least content wise. Visually, I
>>> can
>>> see how that is confusing. I want to neither agree nor disagree on the correctness part because
>>> I
>>> don't really know the fitImage spec. Having the tee node be part of the fitImage is a design
>>> choice, all optional blobs behave that way from my understanding.
>>
>> It is a broken node introduced by commit b57ed147939c ("dts:
>> imx8m{m,n,p,q}: Make optee packaging optional") , it is not supposed to
>> be part of the fitImage unless optee-os is bundled into the fitImage.
> 
> This I still do not understand how you come to the conclusion that it (tee node) is not supposed to
> be part of the fitImage. Can you point me to the doc that disallows this?

The empty tee node is dead code, that is why it should not be in the 
fitImage. Before b57ed147939c ("dts: imx8m{m,n,p,q}: Make optee 
packaging optional") that tee node was correctly not part of the 
fitImage unless explicitly configured in by the user (CONFIG_OPTEE=y).

>>> I guess it means that there is a bug in binman if you say having empty tee node is incorrect.
>>> And so it should be fixed in binman itself imo, not here for imx8.
>> No, this is not a bug in binman, please see above.
> 
> Also, assuming that it is indeed illegal: Binman looks at an external blob and does not remove the
> parent node when it is the only child and found to be missing.
> Can you please clarify what should happen when no tee blob could be found and packaged?

In case of CONFIG_OPTEE=y and "optional" keyword and missing tee.bin 
blob , I think the node should be retained, because the user might 
inject tee.bin into the u-boot.itb after the build with some "mkimage -F 
..." invocation.

In case of CONFIG_OPTEE=n , there should be no tee node.

> I am asking because you wanted to keep the optional property which will cause us to end up in the
> same situation you said is illegal: Having the tee node in the fitImage but no tee blob.
Please see above.

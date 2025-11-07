Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67A92CCF9F8
	for <u-boot@archiver.kernel.org>; Fri,  7 Nov 2025 14:52:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BEA4A83DAE;
	Fri,  7 Nov 2025 15:52:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="UQ2VghIH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6641E83DBD; Fri,  7 Nov 2025 15:52:16 +0100 (CET)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 187B983D90
 for <u-boot@lists.denx.de>; Fri,  7 Nov 2025 15:52:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 51E074375F;
 Fri,  7 Nov 2025 14:52:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7DA6C16AAE;
 Fri,  7 Nov 2025 14:52:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1762527132;
 bh=dnO+QnETnaoRXhIvwMb0CpSQDB4St0Q/mTg0GXSlj0Y=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=UQ2VghIHMv0PR050vnyV+Yx+X42+mYa97xZqddxjQhWhDwQvJSUA8Qk67C3bETjuh
 WA/J5X7Bfr35332RwTGbsirtDwlurGrai6occbhuWtRycUC18146VM328DO1+rxAI4
 WiNolJL8VU38D9Hy9K3V7c9mrXBfVyv+EsQooZvdBbWE1Z7FJW0ufEaiDzOVfYPKGI
 5r3p0Rv9Yut2gh1GwB0CYaDNYfeW0+m1Xj0fdkLKRbbFqdNXOzsEBOuPYOvTR9Pu3W
 rvVgWFl6yRvpfCGFqmpy9yP0dy2pDu2evMTDWL4LPTrJYW78suAuwrSPP58zLkSWHI
 CGrqqTwAnPsfQ==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Guillaume La Roque <glaroque@baylibre.com>, Mattijs Korpershoek
 <mkorpershoek@kernel.org>, Tom Rini <trini@konsulko.com>
Cc: Julien Masson <jmasson@baylibre.com>, u-boot@lists.denx.de, Simon Glass
 <sjg@chromium.org>, Nicolas Belin <nbelin@baylibre.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Andrew Goodbody <andrew.goodbody@linaro.org>,
 Aaron Kling <webgeek1234@gmail.com>, George Chan <gchan9527@gmail.com>,
 Sam Day <me@samcday.com>, Jerome Forissier <jerome.forissier@linaro.org>,
 Maxime Fournier <mfournier@baylibre.com>
Subject: Re: [PATCH v2 3/5] boot: android: Add bootconfig support
In-Reply-To: <5c42a166-1ff4-478a-b76c-9573874a0ca3@baylibre.com>
References: <20251017-bootconfig-v2-0-8c7c2f2e5474@baylibre.com>
 <20251017-bootconfig-v2-3-8c7c2f2e5474@baylibre.com>
 <87cy635ahz.fsf@kernel.org>
 <5c42a166-1ff4-478a-b76c-9573874a0ca3@baylibre.com>
Date: Fri, 07 Nov 2025 15:52:09 +0100
Message-ID: <87frapao9y.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
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

On Mon, Nov 03, 2025 at 19:52, Guillaume La Roque <glaroque@baylibre.com> wrote:

> Hi,
>

[...]

>>> +		unmap_sysmem(ramdisk_dest);
>> We are here in the "if (img_data.header_version > 2) {" block.
>> What about boot image v3? Why are we forcing bootconfig upon them?
>
> our right it's not good bootconfig come with version 4 i will fix it in v3.
>
>>
>> Also, please move this to a seperate function. It makes
>> android_image_get_ramdisk() quite long and difficult to read otherwise.
> i will.
>>
>> Finally, what happens if a kernel does not have bootconfig enabled ?
>> I imagine that everything will crash due to this change. Even if
>> bootconfig is mandatory for boot image v4, I believe we should make this
>> behaviour optional to avoid breaking existing kernels.
>
> it's enable in android kernel since android-12-5.4.xx so if you enable 
> boot image version 4 and move androidboot.x in booconfig instead of 
> kernelcmdline it's because you decide to enable it with 
> BOARD_KERNEL_CMDLINE += bootconfig and you support android boot image 
> version 4. it's explained in aosp doc 
> :https://source.android.com/docs/core/architecture/bootloader/implementing-bootconfig 

Ok, so if I understand correctly, boot image v4 without bootconfig
enabled is not a supported use-case.

>
>
>>
>>>   	} else {
>>>   		/* Ramdisk can be used in-place, use current ptr */
>>>   		if (img_data.ramdisk_addr == 0 ||
>>>
>>> -- 
>>> 2.34.1

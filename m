Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39A3CC282D6
	for <u-boot@archiver.kernel.org>; Tue,  4 Mar 2025 14:36:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ADDD78006D;
	Tue,  4 Mar 2025 15:36:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1741098960;
	bh=R4R1VCleyK3CjvDfGJnpBZWnXjIAvk62y5o+6btURqg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Ot0LBDAuElMvSbIJLe74/VdjUnbbP0mXuzJoXq1YGUVi7uPZ4fNywnl3hQb4yrl9X
	 HQ+lAzVjsikcYrCbU7hanku3xCiQ6MCP2sFReV+ilipCfraHYFVNb091QVJjERZHOL
	 IIkVUYBr+wxeYthYa7VrSgNUQ4qE+I4TdMZnraMDWxX+RUInNQvLQffO1BIFFiYPh1
	 IEfHL592UTOu/dUhunH5OOMPX1WeGddCc7YX1ktiZpLUZYPkiSDG0NfEtpWmt/p1xU
	 GqyuR+BdZV3lJRHIV/m3bm4E+5Qjkni/cZFgOTn4A1PSeC/yat0iJ7OFbqAsiI9XSv
	 0sS9LfjDbKeXg==
Received: by phobos.denx.de (Postfix, from userid 109)
 id B08E5800C1; Tue,  4 Mar 2025 15:35:58 +0100 (CET)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF6A580017
 for <u-boot@lists.denx.de>; Tue,  4 Mar 2025 15:35:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="RkME1OAK"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 8514010382C18; Tue,  4 Mar 2025 15:35:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1741098956; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=R4R1VCleyK3CjvDfGJnpBZWnXjIAvk62y5o+6btURqg=;
 b=RkME1OAKwxnVGzqi74fXPKRlaC1SnA4a/ixQV80S5mO6RI+XX/q0BOeDO9V4JSxjXKVJI+
 WaN6sQzocbP71otc2mSbGmvPbKOZzp7rLHZnlklcj0Sy6oQh42PFp874d6RuhV40NTTVRO
 zC2aFgp9yYCCNlKY/XGbYmrwUzojwk74lgcr0lhe5vFJM5pOdprrW+Yo7qB4LPYAaCda3x
 oblP1hVOcy0NtznC+49oQQEqLOHArwydt2AcuHgv9Qg15kNXj7Nbgo22Caz5sF3Q3Bpx9N
 1SNEXZqJKSOUd7ELw7rBUeHPwjo+EOTanhQxEcFLR7pSSVdGWD9ga8y5DodJzA==
Message-ID: <4ef833aa-49b3-4af8-b77b-4b3f3f6b184e@denx.de>
Date: Tue, 4 Mar 2025 15:28:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scripts/setlocalversion: Reinstate .scmversion support
To: Rasmus Villemoes <ravi@prevas.dk>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
References: <20250302183128.326418-1-marex@denx.de> <87tt895etl.fsf@prevas.dk>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <87tt895etl.fsf@prevas.dk>
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

On 3/4/25 10:24 AM, Rasmus Villemoes wrote:
> On Sun, Mar 02 2025, Marek Vasut <marex@denx.de> wrote:
> 
>> The .scmversion is used by oe-core to append U-Boot version string.
>>
>> LOCALVERSION is not fully compatible replacement as it adds trailing
>> "-dirty" string at the end of version string in case the U-Boot git
>> tree contains uncommitted changes. This behavior itself is correct.
>> However, OE builds do clone U-Boot sources from git and may apply
>> additional patches on top, which are not tracked in U-Boot git tree,
>> but rather in the OE metalayer git tree, which leads to the addition
>> of "-dirty" string as well.
>>
> 
> ... which is then _also_ correct, no?

No

> It means that U-Boot is built from
> v2024.10-321-gabcd1234 plus some entirely unknown additional patches,

This is not true, the patches are known and tracked in the OE layers.

They are not uncommited ad-hoc local changes.

> which can be anything from fixing a typo in a printf string to
> completely overhauling everything.
> 
>> The .scmversion used by oe-core used to replace the version string
>> suffix fully, including the "-dirty" string. Reinstate support for
>> the .scmversion to let OE core do exactly that as it used to do it.
> 
> No, please don't. Let's not let this script deviate from upstream linux
> again, and let's instead try to fix the bug in oe-core

There is no bug in oe-core.

U-Boot commit Fixes: 5c02350fa03d ("scripts/setlocalversion: sync with 
linux v6.9") introduced breaking change, the removal of .scmversion 
support . This patch fixes it. It is as simple as that.

> that (ab)uses
> this legacy .scmversion file. The fundamental bug is that oe-core
> creates these .scmversion files unconditionally, even if they end up
> empty, making CONFIG_LOCALVERSION_AUTO completely useless. I have long
> since worked around those bugs in my own u-boot and linux recipes, but
> I'd much rather be able to eventually drop those workarounds.
> 
> Why doesn't doing what kernel.bbclass has done,
> 
> export LOCALVERSION = "${UBOOT_LOCALVERSION}"
U-Boot and Linux builds in OE-core work differently.

Linux uses SCC to apply patches onto a git tree (i.e. it behaves like 
"git am *patch") and therefore the "-dirty" suffix is not added.

U-Boot recipe uses plain bitbake do_patch to apply patches, and 
therefore the build tree is effectively dirty and the "-dirty" suffix is 
added. The .scmversion overrides the dirty suffix.

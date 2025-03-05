Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D47BC19F32
	for <u-boot@archiver.kernel.org>; Wed,  5 Mar 2025 03:56:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 84BD6807B1;
	Wed,  5 Mar 2025 04:56:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1741146968;
	bh=HAVkXLyGTTpsm1J8BNehsLdeaqRo96MZuOjobFFenvs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=a+fhTUIjWOJXAxYzT+TcI4dc0sPYM+eQf1r4s90d0diDkbJHZCqri7qBF5YrlciMs
	 LLX4aDrhGpVZOsQMF3+hj8zL5QB+u0WTnRKWuvi/aa0T21mSr5XEg4rI/aHEs7qYLq
	 OaAfFDx8NrNkJz/Is+wpCREL6rx/j0PQr2ukQ/nqDglblXObLeG1yu4zh8Qh70Emhn
	 AxENW0+DQhvefWkQd0ydKeQ5wXdp3+mU0ArQDXjTd2cM6T1Lnl545arUa0GuuwTYxZ
	 +jp2uRkivnzWpVHC+vFOmplh1ASRFyo/XyOhhNuDkOt0KLHaExwh5UcIYDUdcvhDo6
	 6zwEL3+onF1yg==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 041D1809D0; Wed,  5 Mar 2025 04:56:07 +0100 (CET)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0EF93800C1
 for <u-boot@lists.denx.de>; Wed,  5 Mar 2025 04:56:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="VR80Bxhi"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id BBAEF10382C18; Wed,  5 Mar 2025 04:55:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1741146949; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=HAVkXLyGTTpsm1J8BNehsLdeaqRo96MZuOjobFFenvs=;
 b=VR80BxhigLjfKHcqtL6aA0Rkmld4m603tHnpURn5DxjV6XAODd4idVZPjHLqZUPz5tkO4a
 fDxdt94O85Ld5OVuv9v46Gpbtc3gNOEcEDlkLEm4CZGxM0MlI3uWOo5QoULTcTAReuhZ9t
 x9T7Oa5ZfWF4hBAqONv2eQl6NVLPdEKkWuZKT05gxNyTjw4gJm/ZvmIwACdkV48GR4DBdG
 J4j8gx9+AJXAihPTIvMf7hsCdlpG9spqCJhSRDA7go2h+tlJ/BV7z/7Akt0j2lk1OrJP9u
 g6X6H7TYjgMmc4QxDtzSVv4DACGhr72qa+4cPUTgRMmXiD7s9KvEmLjy8j2/Bw==
Message-ID: <62483581-a4fc-4551-8dd2-38d923fad58c@denx.de>
Date: Wed, 5 Mar 2025 01:41:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scripts/setlocalversion: Reinstate .scmversion support
To: Tom Rini <trini@konsulko.com>
Cc: Rasmus Villemoes <ravi@prevas.dk>, u-boot@lists.denx.de
References: <20250302183128.326418-1-marex@denx.de> <87tt895etl.fsf@prevas.dk>
 <4ef833aa-49b3-4af8-b77b-4b3f3f6b184e@denx.de>
 <20250304144249.GY2640854@bill-the-cat>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20250304144249.GY2640854@bill-the-cat>
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

On 3/4/25 3:42 PM, Tom Rini wrote:

[...]

>>> export LOCALVERSION = "${UBOOT_LOCALVERSION}"
>> U-Boot and Linux builds in OE-core work differently.
>>
>> Linux uses SCC to apply patches onto a git tree (i.e. it behaves like "git
>> am *patch") and therefore the "-dirty" suffix is not added.
>>
>> U-Boot recipe uses plain bitbake do_patch to apply patches, and therefore
>> the build tree is effectively dirty and the "-dirty" suffix is added. The
>> .scmversion overrides the dirty suffix.
> 
> Yes, but that's Rasmus' point isn't it?
> 0592671fbba8c96df043d537d1f6415492de886e (v2025.01 hash) in oe-core
> isn't the same as in mainline because there's patches on top and it's
> non-obvious.
That still does not mean the repository is dirty , it only means the 
patches are tracked in a different git tree (the OE layer one).

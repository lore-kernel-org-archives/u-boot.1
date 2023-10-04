Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 359F5E7B601
	for <u-boot@archiver.kernel.org>; Wed,  4 Oct 2023 12:33:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 613D887524;
	Wed,  4 Oct 2023 14:33:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="QZF2PYrw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 17AE2863DD; Wed,  4 Oct 2023 14:33:13 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4251A87456
 for <u-boot@lists.denx.de>; Wed,  4 Oct 2023 14:33:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4S0vH92WpLz9sqw;
 Wed,  4 Oct 2023 14:33:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1696422789;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7kLeDhNx7al+H9Im++Y3MZr2LWuweF98BakRzrhwzo4=;
 b=QZF2PYrwZSc9rZjN3DMNpRhOW5OiaxF0jKaAJAadw/8KlIsplwtDKs80ZY0jK0AIQW4brr
 Fj9mxB71ait6i/fO2Z4kFOXIjhRg4Dhk8OjV+tMV13+DG5tFU9UNL8NaDGghsmpW1TIijB
 Y3W1VL5Ip/TOis4+Q4WlLxCJk7C5gTnjUAyqY2Fe6LD24eg9yrUaUL9fF8rsBZwmh4oTt6
 R7mt1mq/efTjbgmDG85Bhkyezns43DZxuE9qpUfZoCN4HsfVb9SLnOS+Kihc3HKicPw1B2
 9WF7Bpmv82Cd1HYDJucbr0Eb5i1x0EV+UqcrlrpY4V99Yqygejreyjjb6sR4zA==
Message-ID: <26a440db-073b-4615-9e20-03a74cc46b23@mailbox.org>
Date: Wed, 4 Oct 2023 14:33:07 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 16/16] board: rzg2l: Add RZ/G2L SMARC EVK board
Content-Language: en-US
To: Paul Barker <paul.barker.ct@bp.renesas.com>, u-boot@lists.denx.de,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Hai Pham <hai.pham.ud@renesas.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20230920124212.63535-1-paul.barker.ct@bp.renesas.com>
 <20230920124212.63535-17-paul.barker.ct@bp.renesas.com>
 <37900365-9d1c-6248-635c-5f6566a08bfb@mailbox.org>
 <52c1d2c3-9b43-9519-b014-02a107a4cc28@bp.renesas.com>
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <52c1d2c3-9b43-9519-b014-02a107a4cc28@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 7fdbbf4d18249034369
X-MBO-RS-META: e63ua4udf5iad8m3pxciwimtnxi5k3jz
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

On 10/4/23 11:36, Paul Barker wrote:

[...]

>>> +int dram_init(void)
>>> +{
>>> +	return fdtdec_setup_mem_size_base();
>>> +}
>>> +
>>> +int dram_init_banksize(void)
>>> +{
>>> +	fdtdec_setup_memory_banksize();
>>
>> This and the one function above can likely go into arch/mach-rmobile/
> 
> We're not able to test every supported mach-rmobile board so we've
> preferred to keep changes to RZ/G2L specific code where possible. I'm
> happy to merge this into mach-rmobile (along with the similar code in
> board/renesas/rcar-common/common.c), but it will only be tested on the
> boards we have in our team.

Don't you already have a G2L specific file in arch/arm/mach-rmobile/ ?

(I can test whatever changes on R-Car if needed)

>>> +	return 0;
>>> +}
>>> +
>>> +void __weak reset_cpu(void)
>>> +{
>>
>> Is this platform missing a way to reset the system ?
>> Please fix.
> 
> Adding reset support is on my todo list. I'm prioritising Ethernet
> support above this right now, but we don't mind too much what order we
> do things. Let me know if you'd prefer us to prioritise reset support.

Isn't the reset like really really simple ? Enable SYSRESET config 
option and do TFA/SMC reset I guess ?

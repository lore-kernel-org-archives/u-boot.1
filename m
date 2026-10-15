Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AA2ACC6B38
	for <u-boot@archiver.kernel.org>; Fri, 16 Oct 2026 08:00:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D4BCF4084E;
	Fri, 16 Oct 2026 08:00:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id i0G4uJ2t5wUm; Fri, 16 Oct 2026 08:00:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 0213D4090C
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792137657;
	b=cgVvb6kcVXVEjecjsEkkmAG9Drr3LMrLowQroZFVVPqCAXdjdWdHwNiXhuUK5Lw22D3S
	 xwe0xqCk90+wA53sLl9rOUJJn5tiv3igSP0DPTeYLhI6f5i8Lam1wP5jkxPfmDQMF/THP
	 Ye9a7Cn29lKwpj1uKXeqW6vO/FYTc8MvYaPeMYH3hzmZMrp4kUXPItTqO/irDL9SfADxE
	 +1n8bwzHan4iSFKOjvryJtg+KAMYX9ew9mDZGD7NLwrcprQY9ytWrpkqFGBvX1+8+1jE3
	 3M//18WWsuUIVxIYIxmfTWUak35bK2P37TKLneK4i9iKEnb38HOTojYoWZtTCKM93uA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792137657;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Infomaniak-Routing:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=eZGWNabe7RINee73S73n965UFA4c0EhTHn6X6R06c/8=;
	b=WBna8qFTBED2vfxcCIs1jaL3XtQ66UWSUV5NC5pBtbzTFhNMx2e3qhw5b6CcVdhPbKFk
	 L4nuqX0V6fOsGEccUXfRIjZRR9qyZ08jG7cnUTnqbL1q7dR2yPIT7DGITOKbpWg8bvsFu
	 X4+5leU0lSDNhbDhYf+KcYYRiL4dUNxZ+7dTKJ0On5WLxz2KnLMbrBy3MGrOUSP02XA+I
	 ldS9R0AsOPCbhF1p80SWocw2gI4fTPX7KB5VBO8CP7sGMMpYuEL1K1FMpphjBJRWKRd2g
	 AqUHmmfN5uMPpwpwb1EvC9ybA1iVyWesZjTcn68wg16n9ade7SBz38SE9HY4JM1OF0g==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792137657;
	bh=eZGWNabe7RINee73S73n965UFA4c0EhTHn6X6R06c/8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=T8jjInGFHhFC2t2eJPUISg0oPO2dwI5E1fVoc3SzKjaQnVPFwUvbpQNboQMOD6fok
	 N3Xc4fnzTwA9Wb7jlkFi2UHyiJYpoc1oR/m/aEH5S30yq9O2EaFKJK175yqjxlgpOW
	 8jRmr3JFulvfYI6mR7rOk0fceRVvtsV5XsBvx29nvtT8y2EL10xmmnVDx70hyeHz9w
	 UKKk9Fozk/djtZaUxwiMtQu/VgJ5xl2S/Y5p4a9TEd/hc25Nn6NV/RVrbW/8iFLmbE
	 92dFx9fWwWoyApp1QBy4tahWEfs/cx9Wqww/bbrs27GiZgzEZ1YApX2Cea0DLJZ4vc
	 7m1rNNcBiRbSw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0213D4090C;
	Fri, 16 Oct 2026 08:00:57 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id AEA7C362
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 08:00:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9464C812B4
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 08:00:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GQ1qNFIxm4ur for <u-boot@lists.u-boot-project.org>;
 Fri, 16 Oct 2026 08:00:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E36FB80A76
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=84.16.66.170
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792137653;
 b=PwGxLGDHG6tK1c70IVZJSegPgMB85EPiJje6G5XfDg8NquPfC1y4oq7Qo23lrM0J+V1a
 j1kJPY/S7Gkz8Y76EnhJ4KFeELy14UaDSyAgmeNQ9obnFivePJaApQdf112WV9mgnsttK
 ocKQxhhElBY/W+1Y9DBKioGCF/LHe5F1Mmg8JH+Sl0EGmcgNbTSpuT1pEfqcaVHYGH4zr
 yEB9z8UOsGxCNj24TGjAhbjTkpiIqw0BY+hTV+iWODb3GFqhMdeHaYrktmiyCedvV/uNg
 xdDe6D5Dh7x8QodqaQuCQW9uNFUTnHI4UZj//kSUMsMIg2kRIVVolS3QzSUNwerW3Kg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792137653;
 h=Received-SPF:Received:DKIM-Signature:Received:Message-ID:Date:
 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
 X-Infomaniak-Routing;
 bh=eZGWNabe7RINee73S73n965UFA4c0EhTHn6X6R06c/8=;
 b=Gt7YmpIR7HUaCC5taEcq6SQiRJawy/BPdvwrqvL2HCVb/WsnKQcc3LYoDTxj2VK2euNP
 MtwFrVkdDp10Cii8nmSBbQCvNFGEakCsroh3pQ4QK/v3o5H575GNvJun+RQ42MoQTJv+U
 iOOk5U1+iw8eJ24co6wiIknXJbQE6Pbo/5Dp3RErN9o+KndTi6UAkRBhDUkftvOFMxXiE
 CHsT3Ab24wPwjoOyGLxXVQI7EhipNX1zxUPWv0e7zMtj4qmMuFw9XlqJe6pGzWeFcoDxj
 P7NZN3yDyTQkIZszZz9v9RAb/9H83Akg8jycTCWcBSBQ3s1+9Z+IM9zsVgzpFJWJetQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=0leil.net;
 dkim=pass header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256
 header.s=20231125 header.b=achEugWp; 
 arc=none smtp.remote-ip=84.16.66.170
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=84.16.66.170;
 helo=smtp-42aa.mail.infomaniak.ch; envelope-from=u-boot@0leil.net;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256
 header.s=20231125 header.b=achEugWp
Received: from smtp-42aa.mail.infomaniak.ch (smtp-42aa.mail.infomaniak.ch
 [84.16.66.170])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E36FB80A76
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 08:00:51 +0000 (UTC)
Received: from smtp-4-0000.mail.infomaniak.ch (unknown
 [IPv6:2001:1600:7:10::a6b])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4j5cnX2p85z16sG;
 Fri, 16 Oct 2026 10:00:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1792137648;
 bh=eZGWNabe7RINee73S73n965UFA4c0EhTHn6X6R06c/8=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=achEugWpwbtxhuDdmX9nVhV5OBKV8sP+HRjdL6CpMaMSUoA/952ywOx5BG/RM/P/5
 IuqhY9FK3bpUETrsKuISuIg1vO24tu5MIbTmhX16/YqaKkrgiEzAMRM5Zb++m+fX3G
 rR950tGcL6tOaJ1O6ouShRIXomG8ppSEfjlDtzpvlkbaAPJk5V7x+J2rlHHN/EoggM
 Fv0/YbvZTZMp6aorilgG8IgyxRpvauW/ggf6aSum3Y8tlbnols7aP9P9vXy9doDZK1
 TdrPBYF41TijKKC88uamHyL0acD1XfuYnDQftoNI5y9vVYfFGSZcBYRjMa2DiHdclI
 qjLhCEt5SOVjg==
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4j5cnT6rJ1zWg1; Fri, 16 Oct 2026 10:00:45 +0200 (CEST)
Message-ID: <b208a8ff-207e-43c8-9779-4960e49590f2@0leil.net>
Date: Thu, 15 Oct 2026 17:47:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] arm: rockchip: Avoid TPL_LDSCRIPT configuration when
 unneeded
To: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.u-boot-project.org,
 Tom Rini <trini@konsulko.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Jonas Karlman <jonas@kwiboo.se>,
 Kever Yang <kever.yang@rock-chips.com>, Johan Jonker <jbx6244@gmail.com>
References: <20261002-config-v1-0-11bb20983682@gmail.com>
 <20261002-config-v1-2-11bb20983682@gmail.com>
 <f142680e-b94b-47a8-ae9d-f793a5d043fd@0leil.net>
 <CAC928HYUq6rijik177mTxMt7Khu8QBwywrt2H2f6CX8z1r0aVQ@mail.gmail.com>
Content-Language: en-US
From: Quentin Schulz <u-boot@0leil.net>
In-Reply-To: <CAC928HYUq6rijik177mTxMt7Khu8QBwywrt2H2f6CX8z1r0aVQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Infomaniak-Routing: alpha
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Hi Massimo,

On 10/14/26 8:07 PM, Massimo Pegorer wrote:
> Hi Quentin,
> 
> Il giorno mer 14 ott 2026 alle ore 11:31 Quentin Schulz ha scritto:
>>
>> Hi Massimo,
>>
>> On 10/2/26 6:35 PM, Massimo Pegorer wrote:
>>> There is no need to define TPL linker script file through TPL_LDSCRIPT
>>> configuration option value when CONFIG_TPL is not selected. Avoid this
>>> useless row in the configuration with no side effect on binary outputs.
>>>
>>
>> What is this helping with?
> 
> If you make generic-rk3328_defconfig which has ROCKCHIP_EXTERNAL_TPL=y (and
> therefore CONFIG_TPL is not selected), you will see in the .config the line:
> 

OK, clear now, thanks for the explanation. Please consider saying 
".config" instead of "configuration", or "defconfig" whenever 
appropriate, I think this would have made things clear from the beginning.

> CONFIG_TPL_LDSCRIPT="arch/arm/mach-rockchip/u-boot-tpl-v8.lds"
> 
> which is useless and misleading. As an example, if you use the qconfig tool,
> it will report that generic-rk3328 is using TPL_LDSCRIPT. Indeed, the
> generic-rk3328 configuration profile does not need any definition of
> TPL_LDSCRIPT because it does not build TPL, being CONFIG_TPL not selected.
> 

OK, I was about to say that I don't really care about the final .config 
but if this breaks qconfig.py, then it's not good.

We also have a bunch of other things in there that don't belong. A 
simple grep on TPL returns:

# CONFIG_TPL_SKIP_LOWLEVEL_INIT is not set
CONFIG_ROCKCHIP_EXTERNAL_TPL=y
CONFIG_TPL_LDSCRIPT="arch/arm/mach-rockchip/u-boot-tpl-v8.lds"
CONFIG_TPL_TEXT_BASE=0xff091000
CONFIG_TPL_STACK=0xff098000
CONFIG_TPL_SYS_MALLOC_F_LEN=0x800
# CONFIG_TPL_SILENT_CONSOLE is not set
CONFIG_SUPPORT_TPL=y
# CONFIG_TPL is not set
# CONFIG_TPL_GZIP is not set

CONFIG_TPL_SKIP_LOWLEVEL_INIT seems to be depending on SPL, but 
shouldn't that rather be TPL? I think that's a typo introduced in 
a2ac2b964bfb ("Convert CONFIG_SKIP_LOWLEVEL_INIT et al to Kconfig").

CONFIG_TPL_LDSCRIPT, CONFIG_TPL_TEXT_BASE, CONFIG_TPL_STACK, 
CONFIG_TPL_SYS_MALLOC_F_LEN being redefined in 
arch/arm/mach-rockchip/*/Kconfig means we need to respect the visibility 
of the "main" symbol otherwise we may actually define (and not 
redefine/extend it) the symbol. For those, I think the easiest solution 
is to guard them with an
if TPL
config ...
[...]
endif # TPL

We need the same mechanism in arch/arm/mach-rockchip/Kconfig.

CONFIG_TPL_SILENT_CONSOLE (as well as the SPL_SILENT_CONSOLE) should 
depend on TPL (respectively SPL).

CONFIG_SUPPORT_TPL shouldn't be hidden, the SoC supports it, we just 
decide to not use it (and use the external blob instead via ROCKCHIP_TPL).

CONFIG_TPL_GZIP depends on TPL_ZLIB which doesn't depend on TPL, but 
should. Same for SPL_GZIP/SPL_ZLIB, VPL_LZMA, SPL_LZMA_SIZE_OPTIMIZATION 
(probably should depend on SPL_LZMA?).

We may have to think about stopping to "redefine" symbols in 
arch/arm/mach-rockchip and instead have our defaults/additional 
restrictions added to the main symbol. The downside is that the Rockchip 
maintainer (me) won't necessarily see those patches as I wouldn't be 
automatically in Cc via get_maintainer.pl anymore. The other option is 
what we do today and start monitoring the visibility (or rather, 
reachability) of the symbol.

Cheers,
Quentin

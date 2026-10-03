Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0033ECA5FDD
	for <u-boot@archiver.kernel.org>; Sat,  3 Oct 2026 11:19:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B7A07412D6;
	Sat,  3 Oct 2026 11:19:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Quz2GsN9eFY0; Sat,  3 Oct 2026 11:19:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 4780F412AB
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791026347;
	b=F+jvVqcSKihlC5V+um0sMr64B5FKRJrPZHlGBkX1MFMZyRzLpwM3WqqlDiU1K+dtyw/D
	 0roR4MtjunNtLc6BLaTMAd8WBSONouKQwfs38F3771xdFKtu2jh2CkBQVb/YyTSiYERcf
	 8lo8DlXJc6QtfZzHh64JYPgblzzciAWGdAGmdszKvB35FMHOv6DYpEtroU2Il1RA1Fje5
	 d174v41lII9dtFboQMec+5MYDOYrD8fBzkXcnneHSKi0EsvydWm2MEQ0E2JKJI01nxOWP
	 g4AuvJJnEOyxcVGsyD5URnISNM0gl35XdC8lhWYOam/bLrLLY3a/s0jMdMRjVt0TzWw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791026347;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:From:
	 Subject:To:Cc:References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=A0cYgGERAyj1MGhKvQNYQi4ClinLQI4l9LiiGFnrVcU=;
	b=G6erJhloM9BnGhenOqbdWIHHEKO5SUI0nJQdMGMbAYW8UziOSvcRqxj+C+K58019nyN2
	 bjr2I77xg8e4j+eMJkjLgvBVdEbjn8cTVxZWZdJPZy2XumSi9504Q7DVYkmCPhuddhfvA
	 zJZu4KKSzArlLH4Bm1Lnyh+g5sDDgVEZ0a7LzZRtsiv9vpMyd/VzNJUwjKfCiAMT2sPcd
	 vfxF//3cCu24JQd62jJvT5vxc9lVMZOhKY3yWSe5G0IgPJjHyD2lQDGYapyX82/YlrfvC
	 DEv2kld9LjsKU36z4XKQG/tzSLP6YsJYAAnO/Aveo2Tk67Xu91+FuArgnlpQernp0/A==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791026347;
	bh=A0cYgGERAyj1MGhKvQNYQi4ClinLQI4l9LiiGFnrVcU=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oINrxTMUvj2MKpexDwu8CB8vn0afRj6r/92gVDT0h4g2L35MA9KtGpf8XbrCj+Xxq
	 yg2sR9vLAGyrNj9re7KcpdiCGzwIoHk5NuZljYXDkG+tksMT5qzeHOOcGiCQiI/sO8
	 hqWT6YnGzHjNcBPszuCqXSnaCz9X4MbslSgkR7r/VQ9kpIdersZVe9VIhNoRd+OFvH
	 /WII3tAjIVTO2zzdALwWEbum2RMh8rmLRY6KKHk1bkjxnLEi6Q5PMX9xJ6QF/PpY80
	 qCc5ggqpKsLKvC4aCAlmlEhf8nOjpHxGzJcxWVi243ptfDRxwB8k8P/m3DEb8OPiLh
	 h363wP0CiSwuw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4780F412AB;
	Sat,  3 Oct 2026 11:19:07 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id ECC5C335
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 11:19:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D262080FF9
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 11:19:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IWsiGuHZx1eV for <u-boot@lists.u-boot-project.org>;
 Sat,  3 Oct 2026 11:19:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 5C79580FF7
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a01:4f8:231:482b::2"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791026344;
 b=jOEkUZXsf/J5aAEQ/DHyMhkO8DDmTE/WCm/R/6opQNjeFeQwHFl4QKCj+JtHEpaAx+Ix
 GSEMDt4plvlcG6jacxFvWUHDBHo7Iil4wYOhgIFk/ePdyzUyk4UVV1VBFGgu7Jyy3A8YJ
 9zfhu5QLVwdFuN+e9+DS56EpOl1ajX+4GqtWkBh8HjB1zV/rK/8cJPEtO3knb5uqm2XwX
 Rqhb7K/qDx4AKPnTrATwdWg1Qtt7DxLC2HFxIBOzYF2DGpx8bnxnjEhTUkXFsU0KKumPO
 EdBY9U+dzgc9qWNvqKCkUuCJyQjuoX+Vpb5btCW3cVRAuCe2i03PNuFSERo5dsMuJ7A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791026344;
 h=Received-SPF:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
 User-Agent:From:Subject:To:Cc:References:Content-Language:In-Reply-To:
 Content-Type:Content-Transfer-Encoding;
 bh=A0cYgGERAyj1MGhKvQNYQi4ClinLQI4l9LiiGFnrVcU=;
 b=lOVx1WDjCBmwwAhHwtaoHkMUZsq5wmXMywwN00yhffrpuCbGeykYfGh9ioSnCqt5JHKr
 Va3C8tjp+1nvtpo6S2wEPrHuCXfcAZIdRK2v4FQDgW4yqEq3nP77mLb4sriqw7JOxpQ42
 t8Q5LEl5x2HwIHHnz9P5OQ0s+zQ8laB+wVCEaqaY3Njlrh6T/iCkacdL1TTFmPcDJsuhr
 cbatBHoEUEFuvoW/dsKb4wJYVegIwkTL408crszV5uBwxoObmnbqI86jba8Gv90iRxdSB
 Qam6HtCpDS7I1uSTapfrJV/Kd0+j6G8uqAHzVADd6anHVzfbLyO4xD0jCkzu8m5gThw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=freeshell.de; 
 dkim=pass header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b=nOgfQvBr; 
 arc=none smtp.remote-ip="2a01:4f8:231:482b::2"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:4f8:231:482b::2;
 helo=freeshell.de; envelope-from=e@freeshell.de; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=freeshell.de
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b=nOgfQvBr
Received: from freeshell.de (freeshell.de [IPv6:2a01:4f8:231:482b::2])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5C79580FF7
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 11:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
 s=s2025; t=1791026307;
 bh=A0cYgGERAyj1MGhKvQNYQi4ClinLQI4l9LiiGFnrVcU=;
 h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
 b=nOgfQvBrgbO6pveGPfqu84/qki4OxpKc0y79oqG15b0vltx3uQy5YZNRaiyZuweXT
 WkzHh3eQcN/0yhlBtKWrw7uW9bNObxbMWgT6irlRqd2xv+lQaq0FE2r9LwTthphcq5
 GX22vaN1hReO0GMl8cKe8EMncbt8zGibFwxkqWn43zakH5mvdV7ZYVI0K14qJqsSQx
 YKRVt4Irq+Ll3pu+lZMX0OiWWwav0zaC4MJBbkZjVhldyvIyoRqZPGjsf2CvoaiOn6
 edaQkjrZQTACMK+LOhgwkF9t+dGrp2bQtZz1lrLrXshQ2LcuangnqsDP3h0wxyFO3F
 fcAsZ+P5cZk1g==
Received: from [IPV6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc] (unknown
 [IPv6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id A837DB2202F0;
 Sat,  3 Oct 2026 13:18:25 +0200 (CEST)
Message-ID: <bb2cdb3e-31f6-4c3c-9c8d-7627b5bb6795@freeshell.de>
Date: Sat, 3 Oct 2026 04:18:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: E Shattow <e@freeshell.de>
Subject: Re: [PATCH v3 1/4] board: spacemit: add SpacemiT K3 Pico-ITX
To: Yixun Lan <dlan@kernel.org>
Cc: u-boot@lists.u-boot-project.org, Yao Zi <me@ziyao.cc>,
 Tim Ouyang <tim609@andestech.com>, Leo Liang <leo.liang@sifive.com>,
 Tom Rini <trini@konsulko.com>, Michal Simek <michal.simek@amd.com>,
 Raymond Mao <raymond.mao@riscstar.com>,
 Hiago De Franco <hfranco@baylibre.com>, Junhui Liu <junhui.liu@pigmoral.tech>
References: <20261003-00-basic-spacemit-k3-v3-0-dea68cd1bd7d@kernel.org>
 <20261003-00-basic-spacemit-k3-v3-1-dea68cd1bd7d@kernel.org>
 <b8a9bb83-7839-4833-8750-1ca55e318f03@freeshell.de>
 <20261003110802-GKB68132@kernel.org>
Content-Language: en-US
In-Reply-To: <20261003110802-GKB68132@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

On 10/3/26 04:08, Yixun Lan wrote:
> Hi E Shattow, 
> 
> On 03:02 Sat 03 Oct     , E Shattow wrote:
>> Hi Yixun,
>>
> ..
>>> diff --git a/board/spacemit/k3/Kconfig b/board/spacemit/k3/Kconfig
>>> new file mode 100644
>>> index 00000000000..1a63c73b6bb
>>> --- /dev/null
>>> +++ b/board/spacemit/k3/Kconfig
>>> @@ -0,0 +1,30 @@
>>> +# SPDX-License-Identifier: GPL-2.0-or-later
>>> +#
>>> +# Copyright (C) 2026 Yixun Lan <dlan@kernel.org>
>>> +
>>> +if TARGET_SPACEMIT_K3
>>> +
>>
>>> +config SYS_BOARD
>>> +	default "k3"
>>
>> Let's arbitrarily change user-facing SYS_BOARD to "spacemit_k3" stem of
>> u-boot config filename "spacemit_k3_defconfig":
>>
>> +config SYS_BOARD
>> -	default "k3"
>> +	default "spacemit_k3"
>>
>> The use of SYS_BOARD is compiled-in as various runtime outputs e.g.
>> SMBIOS data structure. 
> Could you iterate a bit more on this? I've not seen K3 used SMBIOS or will
> 

Disregard, I got this detail wrong.


>> I think "spacemit_k3" is not a very interesting
>> or descriptive name to communicate all the boards that may be supported,
>> but it is better for a user to see this defconfig filename stem than
>> simply "k3" as the board name. I do not have any better suggestion
>> because it is a compile-time substitution and board selection is likely
>> to be at runtime.
>>
> I incline to simply keep it as "k3", I've checked all places refer to SYS_BOARD
> which all will be used under SYS_VENDOR realm or somehow has connection with it,
> so there should be no conflicts, to me, it's kind of redudant to change to
> 'spacemit_k3', for reference to arch/Kconfig
> 
> config SYS_BOARD
>         string
>         help
>           This option should contain the name of the target board.
>           If it is set, either board/<CONFIG_SYS_VENDOR>/<CONFIG_SYS_BOARD>
>           or board/<CONFIG_SYS_BOARD> directory is compiled depending on
>           whether CONFIG_SYS_VENDOR is set or not.
> 
>           This is optional.  For those targets without the board directory,
>           leave this option empty.
> 
> 
> On the other hand, I do not see SYS_BOARD should strictly follow
> the name of defconfig, various board did so
> 
> some other source code I checked
> 

Yes, keep SYS_BOARD as "k3" is fine. I forgot then that it will affect
the build in this way and that is not any benefit worth changing the
path and everything u-boot build system is looking for. I wish there is
a better name for it than the SoC on a build target that is not just any
one board name, but what we have is not any problem itself.

> cmd/pxe.c:20:   "default-" CONFIG_SYS_ARCH "-" CONFIG_SYS_SOC "-" CONFIG_SYS_BOARD,
> config.mk:29:BOARD := $(CONFIG_SYS_BOARD:"%"=%)
> env/Kconfig:20:   the file board/<vendor>/<board>/<SYS_BOARD>.env exists. Otherwise the
> include/env_default.h:93:#ifdef CONFIG_SYS_BOARD
> tools/buildman/boards.py:194:        'board' : 'SYS_BOARD',
> 
>>> +
>>> +config SYS_VENDOR
>>> +	default "spacemit"
>>> +
> 

Keep R-by tag, no changes requested to SYS_BOARD, thanks!

-E

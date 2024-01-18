Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 116E9C4707B
	for <u-boot@archiver.kernel.org>; Thu, 18 Jan 2024 15:11:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 65C2987BAD;
	Thu, 18 Jan 2024 16:11:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="AdWBtLfa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B78C087BA9; Thu, 18 Jan 2024 16:11:21 +0100 (CET)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 543778795B
 for <u-boot@lists.denx.de>; Thu, 18 Jan 2024 16:11:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mwalle@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 88DFECE1F9D;
 Thu, 18 Jan 2024 15:11:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3C1EC43390;
 Thu, 18 Jan 2024 15:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1705590674;
 bh=tEAKgLDSkw2bTNQv+vzAqzC7q8w6oU38pGIQtaPhB+o=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=AdWBtLfa/K3O519p/dQrTjdyVPxJ614ncqWDl9tbHpKLgM8NjX/9e0wT1wwT/I5rk
 y4b4KaOxstL6GbPggz3j2kBTyDkv3U0OBJzr3q/yjT2fniqNAMZed6Dp66XkyppKhA
 +1ZJDZVmTanR0XHQpy5d3q2LiQPdcGlLISJ3HQhjQ7hZQiOcBr17+y3eescSd4u1W9
 EU822q4R7DLj694qJG29BgJyC9pVcAkr0rFeEcjB9a6cVTOdPCNJCF3EQPxarf2ZGU
 348rz2xq12TPSTZxT1Vc4fJiCWIsP7s6Y9Euqznvb43SyTJJK3h71epM6jqjDcSYfH
 NO250P43JIXFQ==
MIME-Version: 1.0
Date: Thu, 18 Jan 2024 16:11:10 +0100
From: Michael Walle <mwalle@kernel.org>
To: Dragan Simic <dsimic@manjaro.org>
Cc: Caleb Connolly <caleb.connolly@linaro.org>, clamor95@gmail.com,
 sjg@chromium.org, sumit.garg@linaro.org, trini@konsulko.com,
 u-boot@lists.denx.de
Subject: Re: [PATCH v2] boot: add support for button commands
In-Reply-To: <bf263fe8e2cb0bb841efed72372ba954@manjaro.org>
References: <3c76c99b-4d18-48a4-902a-9d547091d3d7@linaro.org>
 <20240111093808.3678028-1-mwalle@kernel.org>
 <5af4762a66ab630ea8e391183eb7ee4f@manjaro.org>
 <15c65f2d0d66826cd1cf1c5a18ca7f26@kernel.org>
 <bf263fe8e2cb0bb841efed72372ba954@manjaro.org>
Message-ID: <b12a7bc0cbadba250b1de613236f9f85@kernel.org>
X-Sender: mwalle@kernel.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
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

>>> Using CONFIG_EXTRA_ENV_SETTINGS should be good enough to provide
>>> the fallback defaults.  However, the users can still mess the things 
>>> up,
>>> but again, they can do that already in many places.
>> 
>> I disagree. In my case that is a last resort recovery. And it should
>> work in any case. Even if the user has messed up anything (except
>> from erasing the bootloader in the SPI flash ;)).
> 
> Maybe the solution could be another compile-time option to "lock down"
> the built-in defaults provided through CONFIG_EXTRA_ENV_SETTINGS?  If
> that new option is selected, changes to the environment would make no
> changes to the built-in defaults, i.e. those parts of the environment
> would actually be ignored.

Not sure locking down the whole environment is a good idea.

>>>> In summary, the registered (compiled-in) command should always take
>>>> precedence. If one wants to supply a default command which can be
>>>> changed later, that can go via the (compiled-in) default 
>>>> environment.
>>> 
>>> Sorry, this is a bit confusing to me.  Didn't you write above that
>>> the users should be able to change the associated commands through
>>> the environment variables?
>> 
>> I had two kinds of button commands in mind: immutable ones and mutable
>> ones. The first can be achieved with compiled-in commands, the second
>> with a default environment and environment variables.
>> 
>> Also, whether a command is a mutable one or not is the decision of
>> the developer (or the one who's compiling/configuring u-boot),
>> not the user.
> 
> I believe that the additional compile-time option, which I proposed
> above, could be extended to specify which of the built-in default
> button-command associations are immutable, and which are allowed to
> be modified through the environment variables.

IIRC there is already a mechanism for that. Environment hooks
or something like that. But I'm not sure that has other implications
and qualify as simple and lightweight for this use-case.

Anyway, we digress. I just wanted to make you aware of another
use-case, which btw. is already done today in the lsxl board for
example.

-michael

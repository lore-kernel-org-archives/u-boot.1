Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0625C369B1
	for <u-boot@archiver.kernel.org>; Wed, 16 Apr 2025 08:25:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 387F982D17;
	Wed, 16 Apr 2025 10:25:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="N5OeADY3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0D3B882D1B; Wed, 16 Apr 2025 10:25:39 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 89DF582CE7
 for <u-boot@lists.denx.de>; Wed, 16 Apr 2025 10:25:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id CE1BF6115F;
 Wed, 16 Apr 2025 08:25:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 989EFC4CEE2;
 Wed, 16 Apr 2025 08:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1744791935;
 bh=SUxECwTV2YtlGw3pidMjEcOy6R1oBw9fOX9Lxec/QL8=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=N5OeADY3cWFRNcJSpeCBZhN+kv9UMDELTP8y63qcNlPzBv1HMqO1xHlDJcBky2Gk2
 3Da/2zaN3AQw8ybwBTr88DRH98cTXQjwJB1wC5I46Sed/dOonl7495H8a3EDvwb4Uq
 SwVwf4ZFeQeJ/HsZuhVasm7YVcoMnwYNTvLCSwzsRZIOSHrBKF8D5+jQt+ClrlMILT
 Am35NPUCB1AvWBrlcKpU36oYB1b8p6s0P5cFrp1mT7o1gZiUuBVpglBSKSSklsPeBu
 RR5n4RPhzFCTU8KsQd5Y0BOm/1apt4PUKEauyHHuKGQ+KwjcFi0Z8OiMhAoPzODdYi
 Yfi822SOtcz0g==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Tom Rini <trini@konsulko.com>, Mattijs Korpershoek
 <mkorpershoek@kernel.org>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Subject: Re: [PATCH] tools/make_pip: Use virtualenv when invoking pip
In-Reply-To: <20250415175944.GA650630@bill-the-cat>
References: <20250409-ubuntu-24-04-v1-1-056728207b6c@kernel.org>
 <20250415175944.GA650630@bill-the-cat>
Date: Wed, 16 Apr 2025 10:25:32 +0200
Message-ID: <87ikn44io3.fsf@kernel.org>
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

Hi Tom,

On mar., avril 15, 2025 at 11:59, Tom Rini <trini@konsulko.com> wrote:

> On Wed, Apr 09, 2025 at 09:46:34AM +0200, Mattijs Korpershoek wrote:
>
>> Recent Ubuntu versions (24.04+) disallow pip by default when
>> installing packages. The recommended approach is to use a virtualenv
>> instead.
>> Because of this, "make pip" is failing on such versions.
>> 
>> To prepare CI container migration to Ubuntu 24.04, use a virtualenv
>> in the make_pip script.
>> 
>> Note: This has been reported on [1]
>> 
>> [1] https://source.denx.de/u-boot/custodians/u-boot-dm/-/issues/37
>> 
>> Signed-off-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
>> Reviewed-by: Tom Rini <trini@konsulko.com>
>> ---
>> This has been tested in docker on ubuntu:24.04 after running:
>> $ apt install python3 python3-virtualenv
>> 
>> with:
>> $ ./scripts/make_pip.sh u_boot_pylib "-n"
>> 
>> And shows:
>> Successfully built u_boot_pylib-0.0.6.tar.gz and u_boot_pylib-0.0.6-py3-none-any.whl
>> 
>> Also tested with "$ make pip".
>> ---
>>  scripts/make_pip.sh | 6 ++++++
>>  1 file changed, 6 insertions(+)
>
> So, this ends up failing with Ubuntu 22.04 thusly:
> https://source.denx.de/u-boot/u-boot/-/jobs/1103567

Argh, sorry I did not test that.

>
> And in short, I think your original plan to use venv not virtualenv is
> correct, sorry for the noise. I'll post something to install
> python3-venv to our container shortly and switch to venv not virtualenv
> as that seems to be the long term best answer.

Ok, will send a v2 to use venv instead.

>
> -- 
> Tom

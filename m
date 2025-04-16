Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96643C369BD
	for <u-boot@archiver.kernel.org>; Wed, 16 Apr 2025 12:38:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 19C7781E14;
	Wed, 16 Apr 2025 14:38:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Y2TQ58Rg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BFC1082DF2; Wed, 16 Apr 2025 14:38:06 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B3FB80FDA
 for <u-boot@lists.denx.de>; Wed, 16 Apr 2025 14:38:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 70BCF61135;
 Wed, 16 Apr 2025 12:37:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7128DC4CEE2;
 Wed, 16 Apr 2025 12:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1744807082;
 bh=jGrXogK6N4bCIUkVLLmW2LZq/HK5nuYTKWAJDf5FXCU=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=Y2TQ58RgK+5f2D35FuphXKoXRyEiogLgmdNPesmnnOZ7gQCsQZ3HewX6TLslrlJpV
 Ify4KH0nXwlY9LfWlwL3uACFUas3bWZQn6w67hjM4zE/uRmNo9oi+uxde/VGQFkcmH
 FX76B3+HfMzf4iEVLyUDYR7+3V6qq1oJaus8C1ogJwTQRvGjXBKhOylrazN+q59mtc
 iuiTzjQClOeDWZnCjLP2PesmY8B9Cy23/GaeuKmtcyRZ7tqj1dKBEgsH9XOW/82qtP
 7G/2ziYx7SwZXFYGwuHQFzTEpIUmZuJkpCpCjtcgNzKk45dMwcXDevgpj8iW7YD/mT
 9TrW5N7jzh6UA==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Mattijs Korpershoek <mkorpershoek@kernel.org>, Tom Rini
 <trini@konsulko.com>, Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Subject: Re: [PATCH] tools/make_pip: Use virtualenv when invoking pip
In-Reply-To: <87ikn44io3.fsf@kernel.org>
References: <20250409-ubuntu-24-04-v1-1-056728207b6c@kernel.org>
 <20250415175944.GA650630@bill-the-cat> <87ikn44io3.fsf@kernel.org>
Date: Wed, 16 Apr 2025 14:38:00 +0200
Message-ID: <87fri846zb.fsf@kernel.org>
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

On mer., avril 16, 2025 at 10:25, Mattijs Korpershoek <mkorpershoek@kernel.org> wrote:

> Hi Tom,
>
> On mar., avril 15, 2025 at 11:59, Tom Rini <trini@konsulko.com> wrote:
>
>> On Wed, Apr 09, 2025 at 09:46:34AM +0200, Mattijs Korpershoek wrote:
>>
>>> Recent Ubuntu versions (24.04+) disallow pip by default when
>>> installing packages. The recommended approach is to use a virtualenv
>>> instead.
>>> Because of this, "make pip" is failing on such versions.
>>> 
>>> To prepare CI container migration to Ubuntu 24.04, use a virtualenv
>>> in the make_pip script.
>>> 
>>> Note: This has been reported on [1]
>>> 
>>> [1] https://source.denx.de/u-boot/custodians/u-boot-dm/-/issues/37
>>> 
>>> Signed-off-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
>>> Reviewed-by: Tom Rini <trini@konsulko.com>
>>> ---
>>> This has been tested in docker on ubuntu:24.04 after running:
>>> $ apt install python3 python3-virtualenv
>>> 
>>> with:
>>> $ ./scripts/make_pip.sh u_boot_pylib "-n"
>>> 
>>> And shows:
>>> Successfully built u_boot_pylib-0.0.6.tar.gz and u_boot_pylib-0.0.6-py3-none-any.whl
>>> 
>>> Also tested with "$ make pip".
>>> ---
>>>  scripts/make_pip.sh | 6 ++++++
>>>  1 file changed, 6 insertions(+)
>>
>> So, this ends up failing with Ubuntu 22.04 thusly:
>> https://source.denx.de/u-boot/u-boot/-/jobs/1103567
>
> Argh, sorry I did not test that.
>
>>
>> And in short, I think your original plan to use venv not virtualenv is
>> correct, sorry for the noise. I'll post something to install
>> python3-venv to our container shortly and switch to venv not virtualenv
>> as that seems to be the long term best answer.
>
> Ok, will send a v2 to use venv instead.

Posted here:
https://lore.kernel.org/all/87ikn44io3.fsf@kernel.org/

As mentioned in the cover letter, this requires python3-venv to be added
in the container and I've assumed you will be doing that, Tom.

Thanks!

>
>>
>> -- 
>> Tom

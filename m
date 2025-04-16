Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0666CC369BD
	for <u-boot@archiver.kernel.org>; Wed, 16 Apr 2025 14:22:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3EA7A82F00;
	Wed, 16 Apr 2025 16:22:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="adxQmujb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2525A82C49; Wed, 16 Apr 2025 16:22:04 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C5F6882E3F
 for <u-boot@lists.denx.de>; Wed, 16 Apr 2025 16:21:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 2323544498;
 Wed, 16 Apr 2025 14:21:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FA1DC4CEE2;
 Wed, 16 Apr 2025 14:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1744813318;
 bh=jZL0AOAgSuinKQ3FfV2UnsErXRDA2yTnaRIaRD35qmM=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=adxQmujbWgup9HwUgS0pBpoWedn/fieyNeShokDsPfCSHggua09Cn/cU7Q/eZ0m9d
 Lxry7IGlaWzS/fjXGGaEC6hmOkBiHPxqfERVWMTZNyp1MOeh0Ayu1jJZ+JPVHtSNpr
 oBbmXQAppfPxO2Z18N9/1SD8XmPs/022HSYOVv+coJYZHAm+QEoyGVFGbKD8zxmPIJ
 oKPTxrLfDEkAEik6XJVuicZdmqNXGkCvavCeQyAnQgzrH5fyKD1I51Tzs4fOS8iR/L
 nBeAKuPjzMvAEWn7e2bcW3QBDoPcWAJpQRdCuCvi4bECYyw4SzZ5W01sqB6UtViILx
 FuvbEDAsq/w0g==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Quentin Schulz <quentin.schulz@cherry.de>, Mattijs Korpershoek
 <mkorpershoek@kernel.org>, Tom Rini <trini@konsulko.com>, Simon Glass
 <sjg@chromium.org>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH v2] tools/make_pip: Use venv when invoking pip
In-Reply-To: <7278a03f-57d3-4e50-9c84-8b329c2032e8@cherry.de>
References: <20250416-ubuntu-24-04-v2-1-bad2be600857@kernel.org>
 <7278a03f-57d3-4e50-9c84-8b329c2032e8@cherry.de>
Date: Wed, 16 Apr 2025 16:21:55 +0200
Message-ID: <87cydc4264.fsf@kernel.org>
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

Hi Quentin,

Thank you for the review.

On mer., avril 16, 2025 at 14:47, Quentin Schulz <quentin.schulz@cherry.de> wrote:

> Hi Mattijs,
>
> On 4/16/25 2:36 PM, Mattijs Korpershoek wrote:
>> Recent Ubuntu versions (24.04+) disallow pip by default when
>> installing packages. The recommended approach is to use a virtual
>> environment (venv) instead.
>> Because of this, "make pip" is failing on such versions.
>> 
>> To prepare CI container migration to Ubuntu 24.04, use a venv in the
>> make_pip script.
>> 
>> Note: This has been reported on [1]
>> 
>> [1] https://source.denx.de/u-boot/custodians/u-boot-dm/-/issues/37
>> 
>> Signed-off-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
>> ---
>> This has been tested in docker on ubuntu:24.04 after running:
>> $ apt install python3 python3-venv
>> 
>> with:
>> $ ./scripts/make_pip.sh u_boot_pylib "-n"
>> 
>> And shows:
>> Successfully built u_boot_pylib-0.0.6.tar.gz and u_boot_pylib-0.0.6-py3-none-any.whl
>> 
>> Also tested with "$ make pip".
>> ---
>> Changes in v2:
>> - Use venv instead of virtualenv (Tom)
>> - Link to v1: https://lore.kernel.org/r/20250409-ubuntu-24-04-v1-1-056728207b6c@kernel.org
>> ---
>>   scripts/make_pip.sh | 6 ++++++
>>   1 file changed, 6 insertions(+)
>> 
>> diff --git a/scripts/make_pip.sh b/scripts/make_pip.sh
>> index d2639ffd6e43..33ad51ada703 100755
>> --- a/scripts/make_pip.sh
>> +++ b/scripts/make_pip.sh
>> @@ -106,6 +106,10 @@ fi
>>   mkdir ${dir}/tests
>>   cd ${dir}
>>   
>> +# Use virtual environment
>> +python3 -m venv .venv
>
> Do we want to make sure there are no leftovers from previous runs? If 
> so, maybe add --clear here?

I've thought about this, and looking at the script itself it already
suffers from those issues. For example, the $dir created with mktemp is
also not removed.

>
>> +source .venv/bin/activate
>> +
>>   # Make sure the tools are up to date
>>   python3 -m pip install --upgrade build
>>   python3 -m pip install --upgrade twine
>> @@ -122,6 +126,8 @@ if [ -n "${upload}" ]; then
>>   	echo "Completed upload of ${tool}"
>>   fi
>>   
>> +# Finish using virtual environment
>> +deactivate
>
> Maybe you want this in a trap so that if we exit early (which may happen 
> due to the script doing `set -e`), we're out of the venv?
>
> And I tested otherwise, with:
>
> #!/usr/bin/env bash
> python3 -m venv .venv
> source .venv/bin/activate
>
> and it seems that once I exit the script it's deactivated anyways?

Ah, interesting to know. I just added it to have a "symetric cleanup".

>
> So, I guess no need for the trap or the deactivate, but we can play it 
> safe and still have it :)

I think using a trap makes sense, but this should also be done for the
${dir} directory.

I'd also argue that this would more be the candidate for another patch
than to be part of this one.

>
> Cheers,
> Quentin

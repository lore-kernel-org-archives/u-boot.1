Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7BB2C369BD
	for <u-boot@archiver.kernel.org>; Wed, 16 Apr 2025 15:07:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2190F82F00;
	Wed, 16 Apr 2025 17:07:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="B6xJblWW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3948A82F3B; Wed, 16 Apr 2025 17:07:00 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 87CA282ED4
 for <u-boot@lists.denx.de>; Wed, 16 Apr 2025 17:06:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 3D4A861567;
 Wed, 16 Apr 2025 15:06:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F871C4CEE2;
 Wed, 16 Apr 2025 15:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1744816015;
 bh=oeb2x+PGJzsxX3d+kPl+iDzyw6upszYcjU3hEy5Osko=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=B6xJblWWIiNc07aYq30pbUzvlw+DB7+hqfiDC1pAqjl6/YO2DDFXuMewHzgJqhP2S
 c5INGMrixCV7nzGgfPwxuNYTaYnDx5fjTgJzceLdWlyn7Gtz2nzQMGSZmb1Vl37iew
 F4XUU28RMBP3ELceTIjhDrfExgD8i4s5tIX88OOkS223dbiWiZtXPEa9R8w+dvlpDW
 6iF0oNx39VpqlmfSCiDR6GhzKOAe8EbR7PrammGcNTZa0Q1sl1OetFsXaVMQ7fEprY
 wXT6TfaCXFuakVQeOwsBc9lOb/ual4DYS61G8wJTRmairVvCiw8elxOKqFZdNbOrqQ
 yfrG8Pwq4QXXA==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Quentin Schulz <quentin.schulz@cherry.de>, Mattijs Korpershoek
 <mkorpershoek@kernel.org>, Tom Rini <trini@konsulko.com>, Simon Glass
 <sjg@chromium.org>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH v2] tools/make_pip: Use venv when invoking pip
In-Reply-To: <b9421f29-1b84-478b-8237-782b3fd0bbb2@cherry.de>
References: <20250416-ubuntu-24-04-v2-1-bad2be600857@kernel.org>
 <7278a03f-57d3-4e50-9c84-8b329c2032e8@cherry.de>
 <87cydc4264.fsf@kernel.org>
 <b9421f29-1b84-478b-8237-782b3fd0bbb2@cherry.de>
Date: Wed, 16 Apr 2025 17:06:53 +0200
Message-ID: <87a58g4036.fsf@kernel.org>
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

On mer., avril 16, 2025 at 16:26, Quentin Schulz <quentin.schulz@cherry.de> wrote:

> Hi Mattijs,
>
> On 4/16/25 4:21 PM, Mattijs Korpershoek wrote:
>> Hi Quentin,
>> 
>> Thank you for the review.
>> 
>> On mer., avril 16, 2025 at 14:47, Quentin Schulz <quentin.schulz@cherry.de> wrote:
>> 
>>> Hi Mattijs,
>>>
>>> On 4/16/25 2:36 PM, Mattijs Korpershoek wrote:
>>>> Recent Ubuntu versions (24.04+) disallow pip by default when
>>>> installing packages. The recommended approach is to use a virtual
>>>> environment (venv) instead.
>>>> Because of this, "make pip" is failing on such versions.
>>>>
>>>> To prepare CI container migration to Ubuntu 24.04, use a venv in the
>>>> make_pip script.
>>>>
>>>> Note: This has been reported on [1]
>>>>
>>>> [1] https://source.denx.de/u-boot/custodians/u-boot-dm/-/issues/37
>>>>
>>>> Signed-off-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
>>>> ---
>>>> This has been tested in docker on ubuntu:24.04 after running:
>>>> $ apt install python3 python3-venv
>>>>
>>>> with:
>>>> $ ./scripts/make_pip.sh u_boot_pylib "-n"
>>>>
>>>> And shows:
>>>> Successfully built u_boot_pylib-0.0.6.tar.gz and u_boot_pylib-0.0.6-py3-none-any.whl
>>>>
>>>> Also tested with "$ make pip".
>>>> ---
>>>> Changes in v2:
>>>> - Use venv instead of virtualenv (Tom)
>>>> - Link to v1: https://lore.kernel.org/r/20250409-ubuntu-24-04-v1-1-056728207b6c@kernel.org
>>>> ---
>>>>    scripts/make_pip.sh | 6 ++++++
>>>>    1 file changed, 6 insertions(+)
>>>>
>>>> diff --git a/scripts/make_pip.sh b/scripts/make_pip.sh
>>>> index d2639ffd6e43..33ad51ada703 100755
>>>> --- a/scripts/make_pip.sh
>>>> +++ b/scripts/make_pip.sh
>>>> @@ -106,6 +106,10 @@ fi
>>>>    mkdir ${dir}/tests
>>>>    cd ${dir}
>>>>    
>>>> +# Use virtual environment
>>>> +python3 -m venv .venv
>>>
>>> Do we want to make sure there are no leftovers from previous runs? If
>>> so, maybe add --clear here?
>> 
>> I've thought about this, and looking at the script itself it already
>> suffers from those issues. For example, the $dir created with mktemp is
>> also not removed.
>> 
>>>
>>>> +source .venv/bin/activate
>>>> +
>>>>    # Make sure the tools are up to date
>>>>    python3 -m pip install --upgrade build
>>>>    python3 -m pip install --upgrade twine
>>>> @@ -122,6 +126,8 @@ if [ -n "${upload}" ]; then
>>>>    	echo "Completed upload of ${tool}"
>>>>    fi
>>>>    
>>>> +# Finish using virtual environment
>>>> +deactivate
>>>
>>> Maybe you want this in a trap so that if we exit early (which may happen
>>> due to the script doing `set -e`), we're out of the venv?
>>>
>>> And I tested otherwise, with:
>>>
>>> #!/usr/bin/env bash
>>> python3 -m venv .venv
>>> source .venv/bin/activate
>>>
>>> and it seems that once I exit the script it's deactivated anyways?
>> 
>> Ah, interesting to know. I just added it to have a "symetric cleanup".
>> 
>
> Yup, absolutely makes sense.
>
>>>
>>> So, I guess no need for the trap or the deactivate, but we can play it
>>> safe and still have it :)
>> 
>> I think using a trap makes sense, but this should also be done for the
>> ${dir} directory.
>> 
>
> Indeed.
>
>> I'd also argue that this would more be the candidate for another patch
>> than to be part of this one.
>> 
>
> Fair enough. I believe the --clear addition to python3 -m venv .venv 
> would still make sense though? What do you think?

Hmm I'm a bit mixed about that one:
- .venv will be in a folder created via "mktemp -d"
- this folder will be different each time we run the script

So per my understanding, adding the --clear is not necessary here.
However, I don't feel strongly about not adding it. So if you wish, I
can spin up a v3 !

>
> Cheers,
> Quentin

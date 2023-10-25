Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81CAAC25B6B
	for <u-boot@archiver.kernel.org>; Wed, 25 Oct 2023 20:10:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 289E3874F7;
	Wed, 25 Oct 2023 22:10:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="o8ZoA6Vo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 15C0A874F8; Wed, 25 Oct 2023 22:09:58 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B4995874F1
 for <u-boot@lists.denx.de>; Wed, 25 Oct 2023 22:09:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1698264589; x=1698869389; i=xypron.glpk@gmx.de;
 bh=aPw9gQJ1C5N6PknTlv0+nOvmsp1pHrj4ZzCxrCRSlAg=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=o8ZoA6VoYdZgAsIcNjBz79qiiPdtnyf0Y8kcT7p4Qc9jacU0CxbEVSRNfiYqRUZh
 eemyTwVMSRHoU81ks0Ca1OQ85RJrOw2H8H+4A8Ge/BnIJGG7GS9YbnzYTcfAh4ukV
 1dyhcDF5v0OHqqEE4aEa3fgV4cJy0CZTDCbfxCDKKjPc3Bc7T3lLuRMbyK9WoEnR/
 z09P7tNCSXjPMymH+kMP8DzmPsTCZwRtJLBeM97uUURvB74h3qbsJbPuIjEAjK6Kr
 yd9R6QOKBUpPoSU/KnAwPlIJsxv3SCXRZq6LE+pX1bLZpvag1iTqgn1fN9Zkpcphx
 1Mv6gBKrMoVOy4RJrQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.94] ([178.202.40.247]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MacOQ-1rTR7X01tq-00c7Yq; Wed, 25
 Oct 2023 22:09:49 +0200
Message-ID: <b5d3846f-0d10-465d-aecd-647200409a24@gmx.de>
Date: Wed, 25 Oct 2023 22:09:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Pull request efi-2024-01-rc2
Content-Language: en-US, de-DE
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Dylan Corrales <deathcamel58@gmail.com>, =?UTF-8?Q?Milan_P=2E_Stani=C4=87?=
 <mps@arvanta.net>, Tom Fitzhenry <tom@tom-fitzhenry.me.uk>
References: <d61eb00b-baa8-4804-801a-045eb56ed617@gmx.de>
 <20231025185719.GV496310@bill-the-cat>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20231025185719.GV496310@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lqDrocKCpOYkpQbZx5dJIVD/9+YeR/1HGCStlQ29lPkNKG9GYcw
 R0bs+Z+GuB49muMllbW6tJ3+loaTmr26NgV/TjXWhmzUS/zq+Z6qLQenXWoX5Ti6LF4Bapg
 rCeO3QA+nEjEjSB56CASnQPtsKuSQLL6QQ+siyHgqt8dRTcHgQ3L3nNGLiDic4ED2KlqHpd
 zvYor8HQBWBihxDWGMJQw==
UI-OutboundReport: notjunk:1;M01:P0:PDhOJIPP4iI=;Mm2rIrFBfH44DjNfTPoW8EubHjp
 t0p7bKmt0zwQ1WV52VHV0yEe3Aukx8eKWERqsE2fEoetA0aircs8zC21t6ROhEDz1Ebn19YSp
 Sm3016MWPUDtAzfCXuqV9KdtxWAI1MY6IETk/zGqv6BZ6l1mS0rKmjY4E4hIe2trkmgLnwBUZ
 zvVS9A1ozWnSsL/t6j6ByT3xwsheE/pB7ejqTfSMvzIDQExCLoegZOkRG22nLbmazJd74AKiq
 rMBrq74cvT1p0uOxo48juxSS98B/deJZWNKS5jXZBCGtvbtfby2V76hkHHkTtLejXdPxHd0Fp
 fvgr7YVy+rd5y8vELIlC3nQze5sETKsckCWTlsZ7PmKvMu+OjzeOe3nHlkgdeSzuWc9WsCTk3
 IQRoKYIE0aRX2mFskq31zvXN1mANcGKF72+NlLuxpYV7Y/ygekeawvPD4Uz5jMHzIqqFC3OeV
 M6wcmj3Q+pow4ORhLEkwb3uJRsQxBNZW+BDeyRiyugjNQ9/LemnhDTeBTTuNEmZX62rWVIC2B
 YCzcrIjkHRbf4oCC1YYhRea9Dmm7L4F2VOT7WABGFh8Kf5BKr3Ul56JfB/Axu0uI8JVF3JbPp
 znmQjtLFYVcOAvOyF58yqYy4rwkvkcF/jy3b76zwZZwfuWHl7dhjBlQqtVbfWzzRpU7a370St
 Ogljc7oYqbNj22AApNGwQfE8SlW9aq/vYgtDPVLg60qSjpH2HaCo786kQr3HXBu6KzXB+vCkf
 QSQ5vIYLFg+tigjZnUwTlqLMqrFGS4MrFiS88467I0UnqNRVj3wNUWoiu/Z0THP2FH1DsKS/J
 K9wx0VaTvJjwAHD1n2HVQ8D7tp/fOJ5Lx4SRfVLSReh0FcZbvsRNCOzP+3UBNYYeVEJIPAgDw
 qrHGU2zhLmxwPkIj0+2MrEhpqBf4k1spp+DGxOkGnFGA8u74fgj+Fv+C0PjT4xegGtQ+T+/a1
 R1nPu3vrdKgmOJVrH4tgmlqV53I=
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

On 10/25/23 20:57, Tom Rini wrote:
> On Wed, Oct 25, 2023 at 04:20:06AM +0200, Heinrich Schuchardt wrote:
>
>> Dear Tom,
>>
>> The following changes since commit 5cab3515f8c9796015739c1750b8933291c8=
16be:
>>
>>    Merge tag 'u-boot-rockchip-20231024' of
>> https://source.denx.de/u-boot/custodians/u-boot-rockchip (2023-10-24
>> 09:39:52 -0400)
>>
>> are available in the Git repository at:
>>
>>    https://source.denx.de/u-boot/custodians/u-boot-efi.git
>> tags/efi-2024-01-rc2
>>
>> for you to fetch changes up to 916dad34af0e53181dfe21f5764d3a787cb24bdc=
:
>>
>>    efi_loader: fix EFI_ENTRY point on get_active_pcr_banks (2023-10-24
>> 23:56:43 +0200)
>>
>> Gitlab CI showed no issues:
>> https://source.denx.de/u-boot/custodians/u-boot-efi/-/pipelines/18293
>>
>
> So, there's not been enough time for "efi_loader: expose the device-tree
> file name" as there's still comments on how to word things there (and
> I'm fine taking this eventually for the release, we don't need it
> today).

You and Ilias marked this patch as reviewed.

Which comments should I look at?

> And since we're here anyways, "efi_loader: fix efi_dp_from_eth"
> isn't needed as with "sandbox: eliminate unused functions from binaries"
> we can build sandbox with EFI_LOADER=3Dy NET=3Dn LTO=3Dn (and CMDLINE=3D=
n with
> the rest of my v4 + an unrelated to this fix for fastboot) and since I'm
> asking for changes anyhow, lets just drop this. Thanks.
>

I am fine with dropping the patch. Will you be moving that sandbox patch?

Best regards

Heinrich

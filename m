Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FB7BC71136
	for <u-boot@archiver.kernel.org>; Mon, 16 Jun 2025 07:24:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 00DA181E18;
	Mon, 16 Jun 2025 09:24:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="K7rMM2Sz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3609B82B00; Mon, 16 Jun 2025 09:24:56 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1EBA181E06
 for <u-boot@lists.denx.de>; Mon, 16 Jun 2025 09:24:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 7D9D44A47B;
 Mon, 16 Jun 2025 07:24:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04EB1C4CEEA;
 Mon, 16 Jun 2025 07:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1750058692;
 bh=zI5Mp0mW9gao/4U0ZclF3iWGIOb6ScTKb1rrsHQCsz0=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=K7rMM2Sz3NtPk03hn/Gr1GgfTRyt50kPZvsEeB5YNJjjQ895IjXjkWdLWjOycDgJ9
 L2wFjRMH3fpdvKA25U5r8rrBskm/PpviVNx1wNDoDPMsgeTX2aTfs1LMKROV1t5xGr
 yeHMaYpzORKVB6ZWcIQnSfFsSChSUV4kZA/Zi6Bwj8b7pqUKhxSUdhDLX9oEMm0geo
 3b+R+PBV2G7ru/mV3PrGCLWlFRnDeOJJR/rb2tGxJ0F2A847bBaEB+kGn9vycFAH9S
 SYiZrtfAf0n02luZhyAehaYsLrngGIiDnG8WekarhARKh6b3s7yGGhAi+0B8fUm1vr
 DlAypmfhptKIg==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Zixun LI <admin@hifiphile.com>, Mattijs Korpershoek
 <mkorpershoek@kernel.org>
Cc: Eugen Hristev <eugen.hristev@linaro.org>, Lukasz Majewski
 <lukma@denx.de>, Marek Vasut <marex@denx.de>, Tom Rini
 <trini@konsulko.com>, Mihai Sain <mihai.sain@microchip.com>,
 u-boot@lists.denx.de
Subject: Re: [PATCH] usb: gadget: atmel: reliably generate disconnect by
 disabling controller instead of toggling PULLD_DIS
In-Reply-To: <CA+GyqeYhMBW2Hpa0cr=ruA+LJiOm4ycL0mzcKfkaF8w68JVdJw@mail.gmail.com>
References: <20250602-pullup-v1-1-edcde5a050dd@hifiphile.com>
 <87iklbuddu.fsf@kernel.org>
 <dd3a3cad-75df-43b7-862f-a51cacda3de6@linaro.org>
 <CA+GyqeaPEiwu7b3E-Gm+QMntGgcAVufAhy3jXZ4DzL9O9GANLw@mail.gmail.com>
 <87tt4k3sit.fsf@kernel.org>
 <CA+GyqeYhMBW2Hpa0cr=ruA+LJiOm4ycL0mzcKfkaF8w68JVdJw@mail.gmail.com>
Date: Mon, 16 Jun 2025 09:24:49 +0200
Message-ID: <878qlsgncu.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

On Fri, Jun 13, 2025 at 16:45, Zixun LI <admin@hifiphile.com> wrote:

> On Fri, Jun 13, 2025 at 11:22=E2=80=AFAM Mattijs Korpershoek
> <mkorpershoek@kernel.org> wrote:
>>
>>
>> Mihai, Zixun, do you have any update on case No.01589331 ?
>>
>> I'd like to pick this up and some point so please keep me informed.
>>
>> Thank you
>> Mattijs
>>
>
> Hi Mattijs,
>
> The case was reported in early May and MCHP have also observed the
> missing of detach event on host.
>
> My latest measure shows a differential signal level about +-350mV
> between DP&DM lines when
> DETACH and PULLD_DIS bits are 1, much lower than the detachment
> threshold of 625mV from
> USB 2.0 specification Table 7.3.
>
> From my view the patch can be picked, even on an unaffected family it
> won't have side effects.
> Unless one day we decide to implement SAM9RL and SAM9G45 errata then
> it needs to be retested.

Ok, I will apply it. Since it's a bit late in the release cycle, I'll
send this out for -next.

Thanks again for your contribution!

Mattijs

>
> Best Regards,
> Zixun

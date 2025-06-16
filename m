Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56F29C71135
	for <u-boot@archiver.kernel.org>; Mon, 16 Jun 2025 07:28:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C48EC81E18;
	Mon, 16 Jun 2025 09:28:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="t1bKWEFT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF27A82AFD; Mon, 16 Jun 2025 09:28:18 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5CC9A80C93
 for <u-boot@lists.denx.de>; Mon, 16 Jun 2025 09:28:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id A15985C5730;
 Mon, 16 Jun 2025 07:25:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67BA6C4CEEE;
 Mon, 16 Jun 2025 07:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1750058894;
 bh=HPKBRRQeCYsEdrtvMB+crUFT0GD7ypr200B2Fs9BLQ4=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=t1bKWEFTTmW7ZkQ/B0Bng9JjiqZmA5slPOQ32PGV2xwEc1lSnNwyHhMyZ9ys2ydG7
 PwlcGCyTiKnBcBnHMVj272MDsEZNoARJK0B3oTWgLCWz9Sf4PCLQrb3SZv8dIM9vtv
 XRfRkCKNJXP0PnCzX+Hsy1PMpMdmyOmoYtNjwkkHw4gcD8aCTfSr0LUuCKW4W//qnL
 8iRDgBVPbGYU2bkRY6wqUby+aX2RqDiEZ5kAEr3cgzUa4xByxZ0BeyxHBC617+DiLF
 Dj0w8lNJOnllpzgETMIRn/+sLb+Q88b+215RZQvvRPMJab5y0XqINGqFlboskQfgPB
 adXmExzQnb0gQ==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Mattijs Korpershoek <mkorpershoek@kernel.org>, Zixun LI
 <admin@hifiphile.com>
Cc: Eugen Hristev <eugen.hristev@linaro.org>, Lukasz Majewski
 <lukma@denx.de>, Marek Vasut <marex@denx.de>, Tom Rini
 <trini@konsulko.com>, Mihai Sain <mihai.sain@microchip.com>,
 u-boot@lists.denx.de
Subject: Re: [PATCH] usb: gadget: atmel: reliably generate disconnect by
 disabling controller instead of toggling PULLD_DIS
In-Reply-To: <878qlsgncu.fsf@kernel.org>
References: <20250602-pullup-v1-1-edcde5a050dd@hifiphile.com>
 <87iklbuddu.fsf@kernel.org>
 <dd3a3cad-75df-43b7-862f-a51cacda3de6@linaro.org>
 <CA+GyqeaPEiwu7b3E-Gm+QMntGgcAVufAhy3jXZ4DzL9O9GANLw@mail.gmail.com>
 <87tt4k3sit.fsf@kernel.org>
 <CA+GyqeYhMBW2Hpa0cr=ruA+LJiOm4ycL0mzcKfkaF8w68JVdJw@mail.gmail.com>
 <878qlsgncu.fsf@kernel.org>
Date: Mon, 16 Jun 2025 09:28:12 +0200
Message-ID: <875xgwgn77.fsf@kernel.org>
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

On Mon, Jun 16, 2025 at 09:24, Mattijs Korpershoek <mkorpershoek@kernel.org=
> wrote:

> On Fri, Jun 13, 2025 at 16:45, Zixun LI <admin@hifiphile.com> wrote:
>
>> On Fri, Jun 13, 2025 at 11:22=E2=80=AFAM Mattijs Korpershoek
>> <mkorpershoek@kernel.org> wrote:
>>>
>>>
>>> Mihai, Zixun, do you have any update on case No.01589331 ?
>>>
>>> I'd like to pick this up and some point so please keep me informed.
>>>
>>> Thank you
>>> Mattijs
>>>
>>
>> Hi Mattijs,
>>
>> The case was reported in early May and MCHP have also observed the
>> missing of detach event on host.
>>
>> My latest measure shows a differential signal level about +-350mV
>> between DP&DM lines when
>> DETACH and PULLD_DIS bits are 1, much lower than the detachment
>> threshold of 625mV from
>> USB 2.0 specification Table 7.3.
>>
>> From my view the patch can be picked, even on an unaffected family it
>> won't have side effects.
>> Unless one day we decide to implement SAM9RL and SAM9G45 errata then
>> it needs to be retested.
>
> Ok, I will apply it. Since it's a bit late in the release cycle, I'll
> send this out for -next.

Zixun, before applying the patch, I'd like to add the comment I
suggested in the code [1] as well.

Do you you have any objections on that?
PLease let me know

[1] https://lore.kernel.org/all/87iklbuddu.fsf@kernel.org/

>
> Thanks again for your contribution!
>
> Mattijs
>
>>
>> Best Regards,
>> Zixun

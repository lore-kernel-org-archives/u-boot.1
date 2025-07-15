Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84814C83F21
	for <u-boot@archiver.kernel.org>; Tue, 15 Jul 2025 09:24:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 18FB082F14;
	Tue, 15 Jul 2025 11:24:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="BIeVSMZc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 24A9383043; Tue, 15 Jul 2025 11:24:10 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CAAEB82F00
 for <u-boot@lists.denx.de>; Tue, 15 Jul 2025 11:24:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 7C7CC5C56D3;
 Tue, 15 Jul 2025 09:24:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89537C4CEE3;
 Tue, 15 Jul 2025 09:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1752571446;
 bh=mo7OPPnGPQ+Kq9MS/PjT4xvHeMZiHGKWePbDSlaybv8=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=BIeVSMZcqzXNz2AzuJZiQ8qbTSgNryn/FDXSnXiEdV9nzgsB1rCUl/UT28m38aepS
 JBjEyqEvCGHDCoh0+T5N7TZhu29aX3NHc2krim/1re8jxmqLDNS6N6GSlT3usN2DHp
 sqAgbaurgZqSHScW8asEWu7hoBt4Px9u60InJkZMgJJNf+cauu8KRb+Fr4ZyV813yG
 Ikrf+YRUYwSwSwpj7wy0fiyJ3lwPGgOuJGWGf/9f+AH1p/Du/OEYKDBeep4dXoccTW
 rGdf8ksEWgPmydaw13pSXHs7vcsSSdvXm3cHgNfRR5cDrZoVnxiSA/okNLgfg9xbuw
 yrjpzIw+4UvXw==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Sam Protsenko <semen.protsenko@linaro.org>, Mattijs Korpershoek
 <mkorpershoek@kernel.org>
Cc: Lukasz Majewski <lukma@denx.de>, Tom Rini <trini@konsulko.com>, Casey
 Connolly <casey.connolly@linaro.org>, Rasmus Villemoes
 <rasmus.villemoes@prevas.dk>, u-boot@lists.denx.de
Subject: Re: [PATCH] dfu: Fix dfu_config_interfaces() for single interface
 DFU syntax
In-Reply-To: <CAPLW+4=C0rLu5GAFNYHFrraca0azW_t4QR0zN+6tmBD6B4oazg@mail.gmail.com>
References: <20250709042342.13544-1-semen.protsenko@linaro.org>
 <874ivjjgtv.fsf@kernel.org>
 <CAPLW+4=C0rLu5GAFNYHFrraca0azW_t4QR0zN+6tmBD6B4oazg@mail.gmail.com>
Date: Tue, 15 Jul 2025 11:24:03 +0200
Message-ID: <87y0splscs.fsf@kernel.org>
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

On Fri, Jul 11, 2025 at 15:14, Sam Protsenko <semen.protsenko@linaro.org> w=
rote:

> On Fri, Jul 11, 2025 at 3:02=E2=80=AFAM Mattijs Korpershoek
> <mkorpershoek@kernel.org> wrote:
>>
>> Hi Sam,
>>
>> Thank you for the patch.

[...]

>>
>> Good catch! I can indeed reproduce this on sandbox after enabling
>> CMD_DFU:
>>
>> $ ./u-boot -T
>>
>> [...]
>>
>> =3D> setenv dfu_alt_info "rawemmc raw 0 0x747c000 mmcpart 1;"
>> =3D> dfu list
>> [1]    116917 segmentation fault (core dumped)  ./u-boot -T
>>
>> And I confirm it's fixed with this patch.
>>
>> Thanks for all the details, it makes the review and the testing
>> so much easier!
>>
>
> Sometimes it takes longer to write a commit message than to come up
> with the patch itself, hehe. I also tried to come up with some test
> for that use case, but when you run the Py test suite on the sandbox
> -- it just skips the DFU test. I figured some env hooks have to be
> provided to make it work, but it took too much time for me already, so
> I kinda ended up skipping that part.

Yes, we should definitely work on enabling testing DFU with sandbox.
This is out of scope for this patch, but I've opened a TODO item
for that here:

https://source.denx.de/u-boot/custodians/u-boot-dfu/-/issues/7

Thanks again for the fix.

Mattijs

>
>> Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
>>
>> > ---
>> >  drivers/dfu/dfu.c | 2 +-
>> >  1 file changed, 1 insertion(+), 1 deletion(-)
>> >
>> > diff --git a/drivers/dfu/dfu.c b/drivers/dfu/dfu.c
>> > index 756569217bbb..eefdf44ec877 100644
>> > --- a/drivers/dfu/dfu.c
>> > +++ b/drivers/dfu/dfu.c
>> > @@ -147,7 +147,7 @@ int dfu_config_interfaces(char *env)
>> >                       break;
>> >               a =3D strsep(&s, "&");
>> >               if (!a)
>> > -                     a =3D s;
>> > +                     a =3D d;
>> >               do {
>> >                       part =3D strsep(&a, ";");
>> >                       part =3D skip_spaces(part);
>> > --
>> > 2.39.5

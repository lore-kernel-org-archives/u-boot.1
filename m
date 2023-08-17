Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE49AC2FC27
	for <u-boot@archiver.kernel.org>; Thu, 17 Aug 2023 13:41:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 24F6B86B4D;
	Thu, 17 Aug 2023 15:41:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ewG9IT3G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7887286B50; Thu, 17 Aug 2023 15:41:49 +0200 (CEST)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 86FFB86B40
 for <u-boot@lists.denx.de>; Thu, 17 Aug 2023 15:41:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-525bd0b2b48so1454333a12.0
 for <u-boot@lists.denx.de>; Thu, 17 Aug 2023 06:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692279706; x=1692884506;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fhZIrN76zoMg1/GePFauS8GBjZr6RMW8wpobafMjDXc=;
 b=ewG9IT3GpVMfRSYbhUSwvy+I3atI9ypTx6++TQ3UReF8xyJ7SO1sj/Kkzc1CUveW5j
 xUBMoaYah4SeuOC0+C4mRa8uGq7OKTpTItdlljowNSTfhPgaOS4Rx68DJSJ9SrNJJC/s
 DdR4wEUSZBVSzxgkNAleFOu0IvMpxEXOkNU6o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692279706; x=1692884506;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fhZIrN76zoMg1/GePFauS8GBjZr6RMW8wpobafMjDXc=;
 b=e3z/TkO5SFMLZXryM5yGP4D+FdrUrrDgJpYqaGgUt4kLxp2Y278PDPOd4rtjEIqzgn
 8b+yZ444zYi3EHmOjS811dSYFUU9KjKx086/WAMGPUMxyeQR3yea2+RYtYFzygXg6+ah
 n5jZJWmj/0y0YrTg/fqQ2X5zxAtVVFUJJsIljhVfU3pP7egrNb+XbP+jUXKX7i3PhgQH
 EV2s50bP4eLwus9yjyGQB/5jnuxZQ+1s2sbYeuhOU65D7+gXw+jWpsOvwQKansz9Q9g0
 tt84znjzNQkynwrMrNUISIzhD//b2SB9ovBxkSe8fq66tqdNC4dkkFIgsuSzwQG9KLcA
 m4HQ==
X-Gm-Message-State: AOJu0Yz5Pe1rhcTJ38AZ2ZwrHvAKPgAzZHPqK/K18FvpG/CMtyATxZrW
 iBYHBolzfU6C9DG1FQm1aPj1+ac06ZNybJ4z3RNYJI0NnYBJh3myuwQ=
X-Google-Smtp-Source: AGHT+IFpDjwlymUUDI2mhM11rPEg6H7zHW5rK5BdZYuhbkaWkBpLkcKTF1Z0HZ3ljohht8e5PMboPIp4rEqk55s/cO0=
X-Received: by 2002:a05:6402:557:b0:525:76fc:f559 with SMTP id
 i23-20020a056402055700b0052576fcf559mr3493750edx.41.1692279705870; Thu, 17
 Aug 2023 06:41:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230805133208.788000-1-jonas@kwiboo.se>
 <CAPnjgZ216Mm5cv=NhmPdqGiGKjzc3fte4fVAcMLYwwZhq6gbVA@mail.gmail.com>
 <CAPnjgZ0yq8-pm-HQuKy2vUK5i92zmJZwsYxHeoS-4e51ERZcNg@mail.gmail.com>
 <54280a6b-baa7-0885-26a6-0601d3a2a270@kwiboo.se>
In-Reply-To: <54280a6b-baa7-0885-26a6-0601d3a2a270@kwiboo.se>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 17 Aug 2023 07:41:31 -0600
Message-ID: <CAPnjgZ1uRKsJ1yorWZQuoL9xWtLCOh5HzprpAPesKFgS-oW_JQ@mail.gmail.com>
Subject: Re: [RFC] dm: core: Report bootph-pre-ram/sram node as pre-reloc
 after relocation
To: Jonas Karlman <jonas@kwiboo.se>
Cc: u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

Hi Jonas,

On Thu, 17 Aug 2023 at 00:25, Jonas Karlman <jonas@kwiboo.se> wrote:
>
> Hi Simon,
>
> On 2023-08-17 00:29, Simon Glass wrote:
> > Hi Jonas,
> >
> > On Tue, 8 Aug 2023 at 20:03, Simon Glass <sjg@chromium.org> wrote:
> >>
> >> Hi Jonas,
> >>
> >> On Sat, 5 Aug 2023 at 07:32, Jonas Karlman <jonas@kwiboo.se> wrote:
> >>>
> >>> Devices for nodes with e.g. bootph-pre-ram are initialized three time=
s.
> >>> 1. At SPL stage (always bind and probe only if used)
> >>> 2. At U-Boot proper pre-reloc (always bind and probe)
> >>> 3. At U-Boot proper normal (always bind and probe only if used)
> >>>
> >>> Change ofnode_pre_reloc to report a node with bootph-pre-ram/sram pro=
p
> >>> with a pre-reloc status only after U-Boot proper pre-relocation stage=
.
> >>> This prevents the device from being probed at U-Boot proper pre-reloc=
.
> >>>
> >>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> >>> ---
> >>> I am not sure if U-Boot proper pre-reloc behaves like this by design =
and
> >>> if there is some other way to signal that a device should not be prob=
ed
> >>> during U-Boot proper pre-reloc stage if it has been probed at SPL sta=
ge.
> >>>
> >>> For my use-case I added bootph-pre-ram prop to my RK8xx device node t=
o
> >>> make the PMIC usable in SPL. However, I have no need for this device =
to
> >>> probe at U-Boot proper pre-reloc stage just after jumping out of TF-A=
.
> >>> And moments later bind and probe yet again at U-Boot proper normal st=
age.
> >>>
> >>> The bootph-pre-ram prop was used to have the device usable in SPL, el=
se
> >>> I could have used bootph-all or added bootph-some-ram prop to indicat=
e
> >>> use at U-Boot proper pre-reloc stage.
> >>
> >> This is changing how things work...we really need to have something
> >> explicit to use this new behaviour. Perhaps we can augment the binding
> >> in some way?
> >
> > I had another look at this. The binding seems to be silent on this
> > point, so I believe this patch is correct.
>
> I agree, the documentation for binding and also for driver model make
> this a little bit unclear:
>
> """
> ... Only drivers marked with DM_FLAG_PRE_RELOC or the device tree
> =E2=80=98bootph-all=E2=80=99 property are initialised prior to relocation=
. ...
>
> ...
>
> It is possible to limit this to specific relocation steps, by using the
> more specialized =E2=80=98bootph-pre-ram=E2=80=99 and =E2=80=98bootph-pre=
-sram=E2=80=99 flags in the
> device tree node. For U-Boot proper you can use =E2=80=98bootph-some-ram=
=E2=80=99 which
> means that it will be processed (and a driver bound) in U-Boot proper
> prior to relocation, but will not be available in SPL or TPL.
> """
>
> However the documentation for ofnode_pre_reloc contradict this a little:
>
> """
> There are 4 settings currently in use
> - bootph-some-ram: U-Boot proper pre-relocation only
> - bootph-all: all phases
> Existing platforms only use it to indicate nodes needed in
> SPL. Should probably be replaced by bootph-pre-ram for new platforms.
> - bootph-pre-ram: SPL and U-Boot pre-relocation
> - bootph-pre-sram: TPL and U-Boot pre-relocation
> """
>
> Should I send a v2 of this and drop the "and U-Boot pre-relocation" from
> function doc comment? And do we need a new Kconfig option to enable or
> opt-out of this new/changed/fixed behavior?

Yes it needs doc updates but I don't think a new Kconfig option is
warranted at this point. We just need to clearly document how these
options are used.

Regards,
SImon

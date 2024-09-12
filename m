Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B4FCEE57F6
	for <u-boot@archiver.kernel.org>; Thu, 12 Sep 2024 01:04:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E2FEE88E53;
	Thu, 12 Sep 2024 03:01:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="iBWnfTqW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F83388E44; Thu, 12 Sep 2024 03:01:51 +0200 (CEST)
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com
 [IPv6:2607:f8b0:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 53B9788DCF
 for <u-boot@lists.denx.de>; Thu, 12 Sep 2024 03:01:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-718d704704aso293171b3a.3
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 18:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726102907; x=1726707707; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LyOW1vTtHKN+11JevvPEy/kz5mU675cEQFeT8YtB/EI=;
 b=iBWnfTqWqwQTrDHfVSDsQjheCal6uXffBNKrnOfNRFxtVX1J12VeFGTV6pzalUAMYW
 2eAPShM7t8tid8/nCU0kZPyazP0MvTPz5O5fHbxBzwOMTx+DWNEl25RdhmBMiis9iadn
 +6UvqpwAXZWDjTbdepJibWojSxXk/LKeJbIG8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726102907; x=1726707707;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LyOW1vTtHKN+11JevvPEy/kz5mU675cEQFeT8YtB/EI=;
 b=G8M9j9TNK24hn4Hhe0nM3g+W9GvSHaRzVmyPjV2ICfT82wfG9RpVm4Wi44ofLS6rhX
 +emlPmOAjzfGwv3VYXHCatvZzeX7y8WKucoMSf7LDD20ZMout+nvPUzsinnDWHDSkkph
 dslA4KXsLJNGcOtf/WJ0Q7h2ELYLlP9gjfOkTwiVHaOV6qPAq9sOGdNZSl4ZpRnraRrP
 qSAsm7pcXx7QY2Gz/JC8Ub11AiwGfKZp3cCZ5ywNCrHVGHTet0/CtkAheFpvbia3QtFG
 wUd106oTzlKC5NH749RAEjYkDFFbbKPWHRzWSOmZVuTeNAt/I+8Rmfd20CcCjll/Js3+
 WOpw==
X-Gm-Message-State: AOJu0Yy1BOZakdogScTm+pr+nRD2/Cu+ICNjlW7z45LUoofpPHJeNOtC
 5s+yU796tneri7XaojD+pY755E3XPH8NB9Lyx5Kpfn8F+5J3050FNn7QaLPV3BVNrsIKyheuPAF
 YKQgo7i2HXnNHjkfirLVOi8TXe8EWPx7rwd+B
X-Google-Smtp-Source: AGHT+IHxb5ZnpDJFjYf4Ha/xTbl1Fbqe+NHsbhvjJ5FA98CObdJh5osTvXCUVKU36Uz5ZIZ6pQ42VLZq4zmse4snLNE=
X-Received: by 2002:a05:6a00:1a8b:b0:718:d942:3475 with SMTP id
 d2e1a72fcca58-7192607f8aemr1919862b3a.7.1726102906792; Wed, 11 Sep 2024
 18:01:46 -0700 (PDT)
MIME-Version: 1.0
References: <20240727071742.1735703-1-patrick.rudolph@9elements.com>
 <20240727071742.1735703-3-patrick.rudolph@9elements.com>
 <CAFLszTiCvvrp-PcVRsA3A=odKN9-zJCPuAG7O+c=gBtBg4Hxhw@mail.gmail.com>
 <CALNFmy0fBD3G6xqpp6QAF4iiko0wErL8ndWL5iyrnWXZBrW+nQ@mail.gmail.com>
In-Reply-To: <CALNFmy0fBD3G6xqpp6QAF4iiko0wErL8ndWL5iyrnWXZBrW+nQ@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 11 Sep 2024 19:01:35 -0600
Message-ID: <CAFLszThTW3Sxb8H83brGwd7BoghKKw_4PRCBQsUJh=cwKNEv=g@mail.gmail.com>
Subject: Re: [PATCH 02/17] acpi: x86: Write FADT in common code
To: Patrick Rudolph <patrick.rudolph@9elements.com>
Cc: u-boot@lists.denx.de, mbrugger@suse.com, pbrobinson@gmail.com, 
 trini@konsulko.com, bmeng.cn@gmail.com, 
 Maximilian Brune <maximilian.brune@9elements.com>
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

Hi Patrick,

On Mon, 2 Sept 2024 at 03:09, Patrick Rudolph
<patrick.rudolph@9elements.com> wrote:
>
> On Mon, Jul 29, 2024 at 5:28=E2=80=AFPM Simon Glass <sjg@chromium.org> wr=
ote:
> >
> > Hi Patrick,
> >
> > On Sat, 27 Jul 2024 at 01:20, Patrick Rudolph
> > <patrick.rudolph@9elements.com> wrote:
> > >
> > > From: Maximilian Brune <maximilian.brune@9elements.com>
> > >
> > > Write the FADT in common code since it's used on all architectures.
> > > Let the cpu code fill out the FADT body by introducing a new weak
> > > function acpi_fill_fadt().
> >
> > This should be done using the acpi_ops struct...i.e. add a new
> > operation which fills allows a CPU driver to fill out the CPU info.
> >
> Which of the fields in FADT are related to the CPU driver?
> Some fields like "preferred_pm_profile", "iapc_boot_arch" and "flags"
> seem to be board specific.
> How would the board specific code integrate into the acpi_ops?

Using properties int the devicetree, or a driver based on the compatible st=
ring.

> As far as I understand there are no drivers for "mainboard class" devices=
.

You can use SYSINFO as a driver for that sort of thing.

>
> > >
> > > Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> > > Cc: Simon Glass <sjg@chromium.org>
> > > Cc: Bin Meng <bmeng.cn@gmail.com>
> > > ---
> > >  arch/x86/cpu/apollolake/acpi.c    | 20 +++------------
> > >  arch/x86/cpu/baytrail/acpi.c      | 17 +------------
> > >  arch/x86/cpu/quark/acpi.c         | 19 +-------------
> > >  arch/x86/cpu/tangier/acpi.c       | 25 ++----------------
> > >  arch/x86/include/asm/acpi_table.h | 12 ---------
> > >  arch/x86/lib/acpi_table.c         | 23 -----------------
> > >  include/acpi/acpi_table.h         |  9 +++++++
> > >  lib/acpi/acpi_table.c             | 42 +++++++++++++++++++++++++++++=
++
> > >  8 files changed, 59 insertions(+), 108 deletions(-)
> >
> > Regards,
> > Simon

Regards,
Simon

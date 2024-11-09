Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 166CFD5E37A
	for <u-boot@archiver.kernel.org>; Sat,  9 Nov 2024 17:34:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8354C891E1;
	Sat,  9 Nov 2024 18:34:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gS0C1LXS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D935891E9; Sat,  9 Nov 2024 18:34:40 +0100 (CET)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8DD308922D
 for <u-boot@lists.denx.de>; Sat,  9 Nov 2024 18:34:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a86e9db75b9so521044366b.1
 for <u-boot@lists.denx.de>; Sat, 09 Nov 2024 09:34:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1731173676; x=1731778476; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CKkzyt9J1cl7pAbxouxMV4Jb8bx42lqEtBfM9pd6pqE=;
 b=gS0C1LXS9sRwNPIjYOQ3l0zDIAekMgqTnWeNXgm1l6ZFkWefmQ6Yrlnwk7N7qK5vQf
 JL8HxjF+0Aap/2Gtc3N/h0N1oWA4zu9ROTAJ4pmDBqvSGmbBKnPNum6WOaaYK3zqaPVO
 dbzhHw8BKmzhT/6z9AwicSR6B/hUcxS2VYLyo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731173676; x=1731778476;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CKkzyt9J1cl7pAbxouxMV4Jb8bx42lqEtBfM9pd6pqE=;
 b=LrSwF17J70xs3mOglq9iTTNfOLMVdBGyZD4BSFVlRa6hYiQ2Xi2u7qC+9oFbnqJ8h3
 FvI9ifwUB2GtV+Lt2boV09RR1skG9wIChmNqa8UnLAOZNnElGOzZL9tR71omcsy9K29I
 Vss30INSEAQy66NVIbl0+u367SmLC/h4W1bOUilerbV97Z8VWdUo2tobw+zXNyvtMmRn
 s70zym4zz7yn7iX2Wt3Vi+g5D/2707q68TLohmkzdmJskoK72NujAC2l03YezD2LZ9j5
 2dyLUmqjHZ1ZJj9zq/Of6Xdddxgnh7puK9zqivMYop9i6yw6a0iJcwnQV8cpfHdiK4F/
 4tcA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXBBbwvpXZpcqV80thJ9hWWv534doWbYSbDMv9IuDRiACwdixxynY/POIyq3mqJ/A0ly2a7QPo=@lists.denx.de
X-Gm-Message-State: AOJu0YxFpjZGX6CSrXM8aS13+A6aAlbmeMoc6wYJs3vOHSME7fglrbK2
 T7V6JWLn4cQcpYGBI6PN5midBXdp/pjTUtlifPdTeXUhOj5N7mwpXJ3iwW4tE6dIFyRstGncJIR
 xZhpc73sQ2HYSKxOQdTCNEIGFFaFn4s1vSmI4
X-Google-Smtp-Source: AGHT+IGSPfiufAD9J5NSvW/dwCylFAmeVrXsdtQ3WQy6rmTCudu+m8vQ822tqO+fIbmrzDDsrvD3ck+S+lw8BdfWvf8=
X-Received: by 2002:a17:907:84a:b0:a99:f887:ec1d with SMTP id
 a640c23a62f3a-a9ef001b40emr708340766b.49.1731173675827; Sat, 09 Nov 2024
 09:34:35 -0800 (PST)
MIME-Version: 1.0
References: <20241023132116.970117-1-patrick.rudolph@9elements.com>
 <20241023132116.970117-3-patrick.rudolph@9elements.com>
 <4d55f212-ee39-4886-9246-3596fc4268f7@gmx.de>
 <CALNFmy3ZuZwzXUsFt5EN-5VndSP+cavkY0R5=bhYDWEexG_otg@mail.gmail.com>
 <F9A3E58B-ABA7-4864-BBB7-F26AC1445AB7@gmx.de>
In-Reply-To: <F9A3E58B-ABA7-4864-BBB7-F26AC1445AB7@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 9 Nov 2024 10:34:23 -0700
Message-ID: <CAFLszTgDbxnEsUCLHH8MTVeBmASBQEjke7bF-y4dhFA8=AHx3Q@mail.gmail.com>
Subject: Re: [PATCH v10 02/37] acpi: x86: Write FADT in common code
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>, 
 Maximilian Brune <maximilian.brune@9elements.com>,
 Bin Meng <bmeng.cn@gmail.com>, 
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
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

Hi Heinrich,

On Fri, 8 Nov 2024 at 04:19, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote=
:
>
> Am 8. November 2024 08:10:05 MEZ schrieb Patrick Rudolph <patrick.rudolph=
@9elements.com>:
> >Hi Heinrich,
> >On Thu, Nov 7, 2024 at 10:19=E2=80=AFAM Heinrich Schuchardt <xypron.glpk=
@gmx.de> wrote:
> >>
> >> On 10/23/24 15:19, Patrick Rudolph wrote:
> >> > From: Maximilian Brune <maximilian.brune@9elements.com>
> >> >
> >> > Write the FADT in common code since it's used on all architectures.
> >> > Since the FADT is mandatory all SoCs or mainboards must implement th=
e
> >> > introduced function acpi_fill_fadt() and properly update the FADT.
> >> >
> >> > Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> >> > Reviewed-by: Simon Glass <sjg@chromium.org>
> >> > Cc: Simon Glass <sjg@chromium.org>
> >> > Cc: Bin Meng <bmeng.cn@gmail.com>
> >>
> >> This merged patch breaks
> >>
> >> make qemu_riscv64_defconfig acpi.config
> >> make
> >I'm sorry, since the CI doesn't build that target, I was not aware of
> >build failures.
> >
> >>
> >> You are implementing function acpi_fill_fadt() only for x86 and call i=
t
> >> in code that is used by all architectures.
> >>
> >acpi_fill_fadt() is called on all architectures that are ACPI enabled
> >and build by the CI.
> >There might additional ACPI enabled platforms, but since they are not
> >build tested,
> >they aren't officially supported, are they?
>
> I worked on getting ACPI enabled on arm64 and riscv64  QEMU but could hav=
e made better by adding it to CI.
>
> For some features it was decided that we prefer config overlays over deco=
nfigs. But the test concept is kind of missing.

I am not a fan either. But I just sent a patch[1] proposing what we
might do about it, assuming we are going to continue down this 'config
fragment' path. It isn't a good solution, since it will potentially
explode the number of builds, unfortunately. But it does have some
advantages. For example we could build all boards without
CONFIG_CMDLINE or filesystems, to make sure all is well.

>
> Best regards
>
> Heinrich
>
>
> >
> >> ACPI_WRITER(5fadt, "FADT", acpi_write_fadt, 0);
> >> makes no sense for CONFIG_QFW=3Dy because QEMU is providing the table.
> >Good catch. I'll send a follow up series.
> >
> >>
> >> @Tom:
> >> After getting this fixed we should add a build with acpi.config into t=
he CI.
> >>
> >> further comments below:
> >>
> >>
> >>
> >> >
> >> > ---
> >> > Changelog v4:
> >> > - Drop __weak attribute
> >> > ---
> >> >   arch/sandbox/lib/acpi_table.c     |  6 +++++
> >> >   arch/x86/cpu/apollolake/acpi.c    | 20 ++++------------
> >> >   arch/x86/cpu/baytrail/acpi.c      | 17 +-------------
> >> >   arch/x86/cpu/quark/acpi.c         | 19 +---------------
> >> >   arch/x86/cpu/tangier/acpi.c       | 25 ++------------------
> >> >   arch/x86/include/asm/acpi_table.h | 12 ----------
> >> >   arch/x86/lib/acpi_table.c         | 23 -------------------
> >> >   include/acpi/acpi_table.h         |  9 ++++++++
> >> >   lib/acpi/acpi_table.c             | 38 +++++++++++++++++++++++++++=
++++
> >> >   9 files changed, 61 insertions(+), 108 deletions(-)
> >> >   create mode 100644 arch/sandbox/lib/acpi_table.c
> >> >
> >> > diff --git a/arch/sandbox/lib/acpi_table.c b/arch/sandbox/lib/acpi_t=
able.c
> >> > new file mode 100644
> >> > index 0000000000..10b7ce441a
> >> > --- /dev/null
> >> > +++ b/arch/sandbox/lib/acpi_table.c
> >> > @@ -0,0 +1,6 @@
> >> > +// SPDX-License-Identifier: GPL-2.0+
> >> > +#include <acpi/acpi_table.h>
> >> > +
> >> > +void acpi_fill_fadt(struct acpi_fadt *fadt)
> >> > +{
> >> > +}

Regards,
Simon

[1] https://patchwork.ozlabs.org/project/uboot/patch/20241108152350.3686274=
-9-sjg@chromium.org/

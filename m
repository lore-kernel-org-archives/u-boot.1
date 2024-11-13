Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64A8DD597C2
	for <u-boot@archiver.kernel.org>; Wed, 13 Nov 2024 00:41:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 89C9688F4B;
	Wed, 13 Nov 2024 01:41:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="keaUl9nO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 63161894C0; Wed, 13 Nov 2024 01:41:01 +0100 (CET)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DDF2A88E74
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 01:40:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mibodhi@gmail.com
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5c9388a00cfso8001166a12.3
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 16:40:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731458457; x=1732063257; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cbi9kk5vzfvNs+mTLJZvNKdCMbHBTADmEIEki+Kkp2E=;
 b=keaUl9nOmtlc8P7pKaYBjq0wCGGS/kmFAV6RXo4/CRvCZCImkzUceL+VX+7JUGlSso
 BiGjKhuQPqpR2ajxjjsV/o0iW+GV4FxGYg/bLCC6kY6a5rDPA15A6/6vz+FP4JZtBQ8V
 dGeTnr8InYBy+BlHcyPTaVKIZL8F0Apx6e8jV1ZJEMrzc+V6qe/TwUnpjfaCbD6egoCK
 +8XmJLXXmKCNbbTLJezR+aHnLICIGyhTltUtmqN2h3zpp54/vaoBV8JFBy4oSWhtnRKD
 ZK2hptl/qV5c3n6fzAuvOJcA7MYZn+ijaPPdkuYCqrutasVsBfpIyzQnxGDnx3LUhkJ7
 1pYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731458457; x=1732063257;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cbi9kk5vzfvNs+mTLJZvNKdCMbHBTADmEIEki+Kkp2E=;
 b=NJBcvhE1JeYRu3AnhSv/RfUr0j7/ftA5W9nA5T4zJrf2m1aoFon+oStZkhRgeFwM3h
 ZBHaRtYVOi2pddvFXtBBG9LZKtz1fHXnhR3npLSXEhrbYPqi/VZAH+reDV7k75TkFJ6R
 VTGzje23zZrO3xmA0g0QG84VLVzZf2prpKSB0fK+vEbo7lnLzKx+Gk9RupYlPlGYmDzM
 MZaO2ZEu7sGwNgGXDbieb8+hgoNi8qD/UbK0PsfzxBzrmPfClNh07l1UPBu9z2Y5GI6M
 xRpXNNLti+pBWr5R1lhLoyE46wqcqUftnfASDVaYVOCj+tCvusrRyfOQblx+2Zg8duC0
 dd0Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXztJOpS/bdkOFqWuSJXDkH+YCULMJUd2uNDkEW0YToQKH+9YwXqknTFbsmFmsCshvvK42ZuiY=@lists.denx.de
X-Gm-Message-State: AOJu0Yzo8kwm7DGB2UO48cqg2LYGi0I07PiLtZeG8dVz731oC/dADpcJ
 64LgeKx5NXLQBxQSh/EhUGLTYhEL+d/K+2Rc6VeKyen1RKXnU1B0jm/bvhw6hnL7zKQ/mhW0Ilg
 VT2kFHT1g8wz64At2I80qhul9JqE=
X-Google-Smtp-Source: AGHT+IH5j0hPvXMSdzZdFV/eEEIM1wLPehBl3lTLMxpWVYx7NIAHj1P27XxmFpGS+N5meQc1OD7VtfXdqxqUY0UEu4U=
X-Received: by 2002:a05:6402:2786:b0:5cf:3dc3:7a3f with SMTP id
 4fb4d7f45d1cf-5cf3dc37aa2mr8327910a12.5.1731458456998; Tue, 12 Nov 2024
 16:40:56 -0800 (PST)
MIME-Version: 1.0
References: <20240808163153.2069650-1-caleb.connolly@linaro.org>
 <0194AFA0-5D56-46F8-A385-D23AF7CDDD43@gmx.de>
 <c25c559d-97ab-4abf-bee3-77dc38802e71@linaro.org>
 <20240809220255.GC1626301@bill-the-cat>
In-Reply-To: <20240809220255.GC1626301@bill-the-cat>
From: Tony Dinh <mibodhi@gmail.com>
Date: Tue, 12 Nov 2024 16:40:44 -0800
Message-ID: <CAJaLiFy1sAB3GV-2Rbg=LkjkAXk_KfaF06_cniRrxqG-H5uzZQ@mail.gmail.com>
Subject: Re: [PATCH] cmd: add a fetch utility
To: Tom Rini <trini@konsulko.com>
Cc: Caleb Connolly <caleb.connolly@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 AKASHI Takahiro <akashi.tkhro@gmail.com>, Anand Moon <linux.amoon@gmail.com>, 
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Johan Jonker <jbx6244@gmail.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Michal Simek <michal.simek@amd.com>, 
 Simon Glass <sjg@chromium.org>, u-boot-qcom@groups.io, u-boot@lists.denx.de
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

Hi Tom,

On Fri, Aug 9, 2024 at 3:41=E2=80=AFPM Tom Rini <trini@konsulko.com> wrote:
>
> On Fri, Aug 09, 2024 at 07:23:42PM +0200, Caleb Connolly wrote:
> >
> >
> > On 09/08/2024 08:18, Heinrich Schuchardt wrote:
> > >
> > >
> > > Am 8. August 2024 18:24:24 MESZ schrieb Caleb Connolly <caleb.connoll=
y@linaro.org>:
> > > > While U-Boot does a pretty good job at printing information at star=
tup
> > > > about what hardware it's running on, it can be hard to take pretty
> > > > pictures of this to show off on the internet (by far the most
> > > > important aspect of porting a device in 2024!).
> > > >
> > > > Add a small utility "ufetch" for displaying some information about =
U-Boot and
> > > > the hardware it's running on in a similar fashion to the popular ne=
ofetch tool
> > > > for *nix's [1].
> > > >
> > > > While the output is meant to be useful, it should also be pleasing =
to look at
> > > > and look good in screenshots. The ufetch command brings this to U-B=
oot,
> > > > featuring a colorful ASCII art version of the U-Boot logo and a fan=
cy layout.
> > > >
> > > > Finally, tireless device porters can properly show off their hard w=
ork and get
> > > > the internet points they so deserve!
> > > >
> > > > Not everything is fully supported yet, but this seemed good enough =
for initial
> > > > inclusion. Only one MMC device is detected, and other than SCSI oth=
er storage
> > > > devices aren't supported.
> > >
> > >
> > > This command is not very generic. E.g. it supports SCSI drives but no=
t SATA. Many boards have eMMC and SD-card. This lks more ike an RFC tan som=
ething ready to merge.
> >
> > Honestly it didn't even occur to me to send an RFC since this is purely=
 a
> > vanity thing...
> >
> > I'll make it generic over UCLASS_BLK if possible for the next revision.
> > >
> > > Why don't you use a script or an EFI program to print whatever inform=
ation you need?
> >
> > Well , then you'd need to have a way to load the script or EFI binary, =
which
> > might not be possible for an early U-Boot port which doesn't have stora=
ge
> > support yet (or at least, be a bunch of effort).
> >
> > The only motivation to have this in U-Boot is really because
> >
> > a) it's cute
> > b) it motivates "reward oriented" people like myself to get U-Boot boot=
ing
> > on new/interesting devices because now it can be really easily shown of=
f.
> >
> > Maybe it's a cynical take, but I think stuff like this really has the
> > potential to get more folks interested. Nobody likes doing the invisibl=
e
> > background work, so why not bring some visibility to things?
> >
> > Assuming I did a bad job at conveying my intent in the patch descriptio=
n:
> > the point here is not to convey useful debugging information to develop=
ers,
> > it's to show off, look pretty, and be amusing. Plenty of other U-Boot
> > commands can convey information, this one is more like the 2048 port.
>
> So, at the high level, yes, this is something that ought to get merged
> as it's handy enough, but not intended to replace for example smbios
> information.

Up vote for this patch. Can we merge this to next?

All the best,
Tony

>
> --
> Tom

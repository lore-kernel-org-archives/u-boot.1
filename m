Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE033C61D97
	for <u-boot@archiver.kernel.org>; Wed, 22 Nov 2023 20:02:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2741D86F83;
	Wed, 22 Nov 2023 21:02:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ACkXXIx2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A4AF4870BC; Wed, 22 Nov 2023 21:02:37 +0100 (CET)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com
 [IPv6:2a00:1450:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 58F4D86F67
 for <u-boot@lists.denx.de>; Wed, 22 Nov 2023 21:02:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-507a29c7eefso116224e87.1
 for <u-boot@lists.denx.de>; Wed, 22 Nov 2023 12:02:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1700683354; x=1701288154; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zOexmxQKxiAf9chOv+PhgG9cWkgZX/PAwbTyJnDhTrU=;
 b=ACkXXIx2fxCbT1lnkGeKT3ZQKRA95hhL2LG3LyW7AA/nXE0MGukw3EX4YQh8O1dDw9
 X5b06q2zGTTH8LdM+PrAvUzaO4PU03xbvyGVchQQNH7FdtsGz1mmqc9jMepe4uygajOZ
 J6nkXpGLkaSyF/qpGPwTTZZads+LwAH2DJcYLvws6e8QrPvUp7B1ymUtJbqhAuMDLeNv
 +I4o9ch3IMBnR9Vi7JSotQ3WrcafZ7BCmRJHKVczgbMzH2/thP7/MNL2qAJ8ppESym7d
 WqSGvvLFMrpGrRs6JxtuHOn02m3RirsEhSU54LZpoLv3ADTEk4/kWkHXcOEIl3IHqSA8
 o5eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700683354; x=1701288154;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zOexmxQKxiAf9chOv+PhgG9cWkgZX/PAwbTyJnDhTrU=;
 b=eGwGPJhCuxjedPKuVuYU5rfAn8aVYQY501BnCu0xueZ7nPmiyNHwJuuOP4xdB0b9L/
 pO+N+AGQglguqMj7paDXlgcm4XxsHNpxyzqRYrGg8+H6LcZfL0G0zDn4T0tW7jCS+sxn
 DUNWxPSab8Ar0qvF5wKxIfUdLivndbThmpLxmYOu9yFYv78ftIznNIeKV3n0MG9eZyHu
 EnjUBlAAtAElj1JqAJcLm8PA42qG9q7wUEdkG0jIWozL659hpCntevf7H0uq0ptBp+f0
 PDHwjr4i4jEh+Nw9Dgj94xKDQldXmQCmtl5PG8zjA2maB4jUlSuB05hx769J+FASjQHC
 VPNw==
X-Gm-Message-State: AOJu0YyDVPuAlmxPwSpTGiu0nEHwFu8ZgxHcQKXdE8ziX4CXHN4wgBy7
 Pwn9yUZtBclyQ+Ru8XdBLySGSLPKbz8PTDcgh3ucSYuH
X-Google-Smtp-Source: AGHT+IHAz4nm6KgyLsc02wlODAY4tUpGfNXkPZXYEKAY0/jbWuEQTx9IsLbA5W9Qe8O6FCyWBYouKJx329iphLSVxcI=
X-Received: by 2002:a19:f818:0:b0:509:8e22:ae5 with SMTP id
 a24-20020a19f818000000b005098e220ae5mr2313454lff.60.1700683353875; Wed, 22
 Nov 2023 12:02:33 -0800 (PST)
MIME-Version: 1.0
References: <20231120201609.619598-1-trini@konsulko.com>
 <a653e096-cf28-4573-856f-d52dae233b46@linaro.org>
 <20231121131551.GP2513409@bill-the-cat>
 <d59de63c-4d4c-4141-9b4f-9a279da596d4@linaro.org>
 <20231121140929.GV2513409@bill-the-cat>
 <ec846ff6-a60b-4eb8-906c-0de6e11b5d9d@linaro.org>
In-Reply-To: <ec846ff6-a60b-4eb8-906c-0de6e11b5d9d@linaro.org>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Wed, 22 Nov 2023 20:02:22 +0000
Message-ID: <CALeDE9PGErp+wDRR3VDvHNZc6_3ph=vDuvR-dk3TAWBrppayoA@mail.gmail.com>
Subject: Re: [PATCH] libretech-cc: Populate SMBIOS information
To: neil.armstrong@linaro.org
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 u-boot-amlogic@groups.io, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Simon Glass <sjg@chromium.org>
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

On Tue, Nov 21, 2023 at 2:50=E2=80=AFPM Neil Armstrong
<neil.armstrong@linaro.org> wrote:
>
> On 21/11/2023 15:09, Tom Rini wrote:
> > On Tue, Nov 21, 2023 at 02:46:29PM +0100, Neil Armstrong wrote:
> >> On 21/11/2023 14:15, Tom Rini wrote:
> >>> On Tue, Nov 21, 2023 at 10:18:04AM +0100, Neil Armstrong wrote:
> >>>> Hi Tom,
> >>>>
> >>>> On 20/11/2023 21:16, Tom Rini wrote:
> >>>>> Enable CONFIG_SYSINFO_SMBIOS and populate the nodes so that Linux c=
an
> >>>>> eventually display this information
> >>>>>
> >>>>> Signed-off-by: Tom Rini <trini@konsulko.com>
> >>>>> ---
> >>>>> Posting this as this was the easiest platform for me to test some S=
MBIOS
> >>>>> related patches on and I needed to populate the nodes so I could ch=
eck
> >>>>> things in dmidecode once Linux was up.
> >>>>
> >>>> Sorry to be late a the party, but can't this be dynamically found fr=
om DT's compatible & model ?
> >>>> Since I'll probably need to add this to all boards, it seems like a =
duplicate of what's already in the DT.
> >>>
> >>> Part of the "fun" as to why we have the binding here is that while we
> >>> could use the top-level model property, there's not a corresponding o=
ne
> >>> for manufacturer. I'm fine ignoring the patch I posted here and havin=
g a
> >>> longer discussion about populating SMBIOS more usefully, globally, as=
 I
> >>> think has been suggested a time or two.
> >>>
> >>
> >> I'm ok landing it with the same data as from the vendor.
> >> but couldn't we use the first top-level compatible as default smbios d=
ata ?
> >>
> >> compatible =3D "vendor1,board-name", "vendor1,soc-name";
> >>
> >> and translate to:
> >>
> >>
> >> smbios {
> >>      system {
> >>              manufacturer =3D "vendor1";
> >>              product =3D "board-name";
> >>      };
> >>
> >>      baseboard {
> >>              manufacturer =3D "vendor1";
> >>              product =3D "board-name";
> >>      };
> >>
> >>      chassis {
> >>              manufacturer =3D "vendor1";
> >>              product =3D "board-name";
> >>      };
> >> };
> >>
> >> since the vendor name should be already documented in the linux
> >> bindings, same for the board name.
> >> And we would be free to add some custom data in the DT if needed.
> >>
> >> Anyway, not sure it's the right place to discuss about that !
> >
> > That's essentially
> > https://patchwork.ozlabs.org/project/uboot/patch/20220906134426.53748-2=
-ilias.apalodimas@linaro.org/
> > which had a bunch of comments on 1/2:
> > https://patchwork.ozlabs.org/project/uboot/patch/20220906134426.53748-1=
-ilias.apalodimas@linaro.org/
> >
> > But I think that since then some thoughts on the subject have changed
> > and that approach might be more welcome now than it was then.
> >
>
> Thanks for the pointer, seems I had the exact same idea.
> Hope this will be re-spinned, I don't want to add this to the 45 amlogic
> boards when we have the necessary info already available and documented..=
.

Fedora has carried this patch for some time for the same reason, a lot
of the tools in distros around support use dmidecode for HW
information and reporting "Unknown" meant there was lots of reports
against tools all over the place. I'd been asking Ilias to upstream it
for a while so I'm in full agreement here and he did mention he would
resend it soon :)

Peter

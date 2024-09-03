Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F3B0CD37AA
	for <u-boot@archiver.kernel.org>; Tue,  3 Sep 2024 19:29:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E6BAC88B4B;
	Tue,  3 Sep 2024 21:29:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="kjeln8HT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5B77D88327; Tue,  3 Sep 2024 21:29:45 +0200 (CEST)
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com
 [IPv6:2607:f8b0:4864:20::82d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 05EFE88606
 for <u-boot@lists.denx.de>; Tue,  3 Sep 2024 21:29:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82d.google.com with SMTP id
 d75a77b69052e-45683037787so31955011cf.2
 for <u-boot@lists.denx.de>; Tue, 03 Sep 2024 12:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1725391782; x=1725996582; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=w/cXWe/G8BA/f9cC+gCLwW4WM5nuC/wQXvVzspS3H/I=;
 b=kjeln8HTPdf2J0YnNdgu9rSC4EWrqrmCeqeFnZI7LeLO/kuFZ9n08K0naHl8JXP0D8
 lpD8z7c/R2+Fyt/vnaakVaF+yW4ZvYi1cgzGnP74dVUGMA0D34Umm+ViycnjlMcESLd5
 Mun5UtzoS58DVn8YQwzoN7mcSr/B3qr3JQqSc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725391782; x=1725996582;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w/cXWe/G8BA/f9cC+gCLwW4WM5nuC/wQXvVzspS3H/I=;
 b=Q22JRggXhQTA9cOkARVHNUk+WP7Guwn7Bkg9v4Axi+v44Xl/J8Gt7eZ6rTAPNfQC4H
 55rVi0uzC17m/k+EwtByV9EpIYCA9eY7YQUaRmoCrgX9W7YZpnRLmzFTwEtVfTMnTiOL
 2Jb8lMEzcW3xo3VcX3guuBuPEXYv/rxsTsmqiAEv/voFvjLyDmoUK//K7drUGdT7rsvY
 WlPZGHcNzwZC2BP/EejslAVS7NXLx7QaTbvoVf5YMteS2e5IN3zSYu5ZcK6KCdVWi4iu
 jqrwBb1SM5//ld/tSPCRU8yA4P2HlyxVpj/7EVSUGkQhM9snM2DV49SXUnvKadQyA79/
 WU1g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWXKJMZUWOId1Jq/eCb2jtadn7KJub8C1MlgK2gE9EZuR8ezm1loVV1cqEV7tfS573j9SzBL6I=@lists.denx.de
X-Gm-Message-State: AOJu0YzCTYl93G4RtygC7IQmvFnyG2ikuNVE2vFgoF87PL0iHV8PHyna
 UnYdTt6Isav6oPIc9cE2n2LAvh3XwgQnMHNDA/j15LPX4qMbezDYFKuB6AFdbqUErnFAHTOo0Ix
 5
X-Google-Smtp-Source: AGHT+IHGTAt3MEfCwNVhZE+TPUaPCFp6CTDRE+N9aTJuIfr5LjpnNWPX+n5ANey0GSciNcJiasuMVg==
X-Received: by 2002:a05:622a:2b05:b0:447:e40a:f61a with SMTP id
 d75a77b69052e-456fd780507mr189278801cf.18.1725391781682; 
 Tue, 03 Sep 2024 12:29:41 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-45682c82882sm52321991cf.13.2024.09.03.12.29.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Sep 2024 12:29:40 -0700 (PDT)
Date: Tue, 3 Sep 2024 13:29:38 -0600
From: Tom Rini <trini@konsulko.com>
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, E Shattow <lucent@gmail.com>,
 u-boot@lists.denx.de
Subject: Re: [PATCH] cmd: fdt: use U-Boot's FDT by default
Message-ID: <20240903192938.GN2479150@bill-the-cat>
References: <20240831164639.2298097-1-caleb.connolly@linaro.org>
 <CANV2PTM+wevfK7w15j-=a2oakPMMXpTdr7ntzBfkc3jbbv+veg@mail.gmail.com>
 <feff5299-6378-4de9-867d-808c23625af4@linaro.org>
 <CAFLszTiZ75zK2L8=5E9dXOHXqEybh7O=OsQiW5hkJ9xoPiWT4Q@mail.gmail.com>
 <96798312-858e-40e9-b174-a850da8de6e9@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="T2n4UFD8kiGOshZv"
Content-Disposition: inline
In-Reply-To: <96798312-858e-40e9-b174-a850da8de6e9@linaro.org>
X-Clacks-Overhead: GNU Terry Pratchett
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


--T2n4UFD8kiGOshZv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 02, 2024 at 03:07:44PM +0200, Caleb Connolly wrote:
> Hi Simon,
>=20
> On 01/09/2024 21:10, Simon Glass wrote:
> > Hi Caleb,
> >=20
> > On Sun, 1 Sept 2024 at 08:21, Caleb Connolly <caleb.connolly@linaro.org=
> wrote:
> >>
> >> Hi,
> >>
> >> On 31/08/2024 23:22, E Shattow wrote:
> >>> Hi Caleb, the problem here is hidden conditional behavior.
> >>>
> >>> On Sat, Aug 31, 2024 at 9:56=E2=80=AFAM Caleb Connolly
> >>> <caleb.connolly@linaro.org> wrote:
> >>>>
> >>>> When using the FDT command to inspect an arbitrary FDT in memory, it
> >>>> will always be necessary to explicitly set the FDT address. However =
it
> >>>> is also quite likely that the command is being used to inspect U-Boo=
t's
> >>>> own FDT. Simplify that common workflow of running "fdt addr -c" to g=
et
> >>>> the control address and set it by just making $fdtcontroladdr the
> >>>> default FDT if there isn't one.
> >>>>
> >>>> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> >>>> ---
> >>>>   cmd/fdt.c | 9 +++++++++
> >>>>   1 file changed, 9 insertions(+)
> >>>>
> >>>> diff --git a/cmd/fdt.c b/cmd/fdt.c
> >>>> index d16b141ce32d..8909706e2483 100644
> >>>> --- a/cmd/fdt.c
> >>>> +++ b/cmd/fdt.c
> >>>> @@ -276,8 +276,17 @@ static int do_fdt(struct cmd_tbl *cmdtp, int fl=
ag, int argc, char *const argv[])
> >>>>
> >>>>                  return CMD_RET_SUCCESS;
> >>>>          }
> >>>>
> >>>> +       /* Try using U-Boot's FDT by default */
> >>>> +       if (!working_fdt) {
> >>>> +               struct fdt_header *addr;
> >>>> +
> >>>> +               addr =3D (void *)env_get_hex("fdtcontroladdr", 0);
> >>>> +               if (addr && fdt_check_header(&addr))
> >>>> +                       set_working_fdt_addr((phys_addr_t)addr);
> >>>> +       }
> >>>> +
> >>>>          if (!working_fdt) {
> >>>>                  puts("No FDT memory address configured. Please conf=
igure\n"
> >>>>                       "the FDT address via \"fdt addr <address>\" co=
mmand.\n"
> >>>>                       "Aborting!\n");
> >>>> --
> >>>> 2.46.0
> >>>>
> >>>
> >>> The use of `fdt` command in the default action might be depended on by
> >>> some userspace script as a success/fail result. I don't imagine what
> >>> that might possibly be, just that the logic of scripts in u-boot
> >>> depend on that pattern of use.

I don't think anything depends on "fdt addr" returning 1 if nothing is
set.

> >> I'm not sure what the rule is about breaking changes in the CLI, I do
> >> think this is not a realistic concern here though. Maybe Tom or Simon
> >> can weigh in?
> >>>
> >>> Secondly there would need to be a warning to the user that some hidden
> >>> conditional action is being applied? i.e. "No valid FDT address is
> >>> configured to $fdt_addr_r or $fdt_addr so now configuring to use
> >>> $fdtcontroladdr instead." or however you would phrase that.
> >>
> >> Since I call set_working_fdt_addr() it prints a message telling you th=
at
> >> the fdt address was set on the first call.

Yes, but it's not obvious as-is where that address came from / why,
since today that happens because you're passing that to the command.

> >>> Otherwise I agree improvement to the fdt is welcome and my memory of
> >>> first using this command is that it has not-sensible defaults but I
> >>> then assumed it was designed this way because of possible use in
> >>> U-Boot scripts.
> >=20
> > Definitely a useful feature, but how about adding a flag which sets
> > the working fdt to the control one? That would make it less painful
> > than using -c, and will keep existing cases running.
>=20
> Surely we have to /have/ some usecases to justify this??

Well, "fdt" the command was introduced back when Linux started taking
device trees on PowerPC platforms, so there wasn't some default to look
at. U-Boot isn't standardized on "fdtaddr" or "fdt_addr_r" or "fdt_addr"
as where the device tree for the OS is, only that "fdtcontroladdr" is
ours. So yes, I would also prefer a new flag to automatically set the
working address to fdtcontroladdr. But I assume there's a good reason to
not just do like other platforms have historically and fdt addr ... as
needed before other commands? Or is this really just for interactive
development?

--=20
Tom

--T2n4UFD8kiGOshZv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmbXY54ACgkQFHw5/5Y0
tyxs4gwApTl1HvQM0PuBgGSIw6B8C3az+/8TgARMueH+RcN5Kz04wz5iKnFBO8Y0
IIJMnd1dPo7XhnmOWSpDaILIq9Xnvi/3Djw1FzjqQ7qZQh31dkwN1SsRJ7cxk47x
7P+o4suzwMIdsnHpGGLDlnYJNCP34X5SsBd1HryclpTYDTuxGaDPPKHYkz4vYTes
ljxv8b7oiYGi12KyDAXN2n3qfmDWqIMGRs+uqm/dsV/Vc8QdsTAV7u/ZTsB1TwfF
233Tp2EPNrF84auDVfOLbVULC7+yS9FfLLViUrHd74BHiF5ufzwgKsWo46QWHv9B
+XyT4513AOLmra4ukUtw5jQu8H+nMbeO63D/TJpKpIWyV9stqjGkJHfJPWEpuDG0
TqmiEP3kV3yWkFZcI/joYPyPCbwiYpwc48PAKbcSRcE7X0OIuPUaN+ehOxczbKws
lSThKjNVvSP7+yO56mPxlD2inZqdDhKTqHIl453w3O8JQp8maPfv2Qhq/q7FLtiV
Qojqs2pY
=El9Z
-----END PGP SIGNATURE-----

--T2n4UFD8kiGOshZv--

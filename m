Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78303D73606
	for <u-boot@archiver.kernel.org>; Sat, 30 Nov 2024 14:54:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3EA5D88DC7;
	Sat, 30 Nov 2024 15:54:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="U4TlTGHA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 30E7588DDD; Sat, 30 Nov 2024 15:54:42 +0100 (CET)
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com
 [IPv6:2607:f8b0:4864:20::730])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 67CF988DB2
 for <u-boot@lists.denx.de>; Sat, 30 Nov 2024 15:54:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x730.google.com with SMTP id
 af79cd13be357-7b667348bd0so182256985a.3
 for <u-boot@lists.denx.de>; Sat, 30 Nov 2024 06:54:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1732978478; x=1733583278; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=5P4YR0tjPxwjjy1EPg393QZquGopmkP4qG84xPhY79o=;
 b=U4TlTGHAnpDsVjHFAvco9spDSqHn+9ygjOo5Qns5PaiytiBYBVmnszQUbOgGpsCECG
 1yn9GNmkYzDalrDUHsVNn5CPyhyjWx7ZnY+FRVxQwnibH5zV2ewkMfk8U/jvZ+xG7AJr
 Q+fNrrS1a1PmY+jaR5hqfQNCkFOs+3DDcTzq0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732978478; x=1733583278;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5P4YR0tjPxwjjy1EPg393QZquGopmkP4qG84xPhY79o=;
 b=uL0zC4st7lk3hgy5rYlCHfra978cWCQsgR/vbD69i8CctnhIKQ+R0Wkq8fDQ80FTq0
 3WJEe/b48pPQiUBAELHNDQ5NBn+mQmRK1waVQwo44DYkUAcowd/0i5uIUOa9ZMXL763R
 pLuYz0K8FWnqg2zWdtTLGJBTc5jbR5+7hmdQKxMk7QEgV32XwQPyP/1N6LmaWIXBk27v
 x6+bDsw6+Uv7oKpnlzJ2Gvw15lbiJsMc1FbRxq9q03pP52Gv9kHFzRIGk7U0hW2G4+Xp
 XuBRr7ISomNTJWBfNynVKcNvuLOojZkKlNOriwxnAeV0AxuSN9TuO3u+tQxPSHousBPU
 pjWw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVJIXMiNiRpL5U131Wo032Sbrr1mhyPbcbSfUX998HujFI5vGzoj0dhwCaStxVKxgtx+Enim3c=@lists.denx.de
X-Gm-Message-State: AOJu0YxHWQWVgacYrhbQ4KYWpT8h6HTH/jfUbQGWp48zMaSNsouBQ3xv
 iMwI3RvytnDBb3lSbFhBzfhLeLmxLlOO3hbrEftuW39XKYm2PCs8lbUpR5msnbw=
X-Gm-Gg: ASbGncv3qydh7aYxxgqajK3Zr6eJiLqXA8bhPnBL82vziXd3JQJ50P7iHSOzoQWXU5d
 0CxWxgQYlfKtHwRBu6Z3VW6JyjPaauFAJriGQgqhPHhNT//oF4XYxKmoZxAHVEKRk0t20UH3K6X
 yYFFNw0Tv89ElHgHSL8mLK9KzfIWIDkGMvBwyaHTW6H+1xerSsafByROVuaILGmhEMCfGNaZHBM
 VEj/ELrpKAViPqnQVbtyNjc8pQurISVm/W+XdLO9bXTjXc6Uw==
X-Google-Smtp-Source: AGHT+IHxHjw13iwKHgaWgEeeum5uQ3+fVWvM3lvQfyr6CzlF2YxU5jy0TWASMgEYe3IqtHyuHQKxXQ==
X-Received: by 2002:a05:620a:4807:b0:7b1:534b:5385 with SMTP id
 af79cd13be357-7b67c31438amr2606610485a.37.1732978478268; 
 Sat, 30 Nov 2024 06:54:38 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-466c421e3dcsm27844911cf.71.2024.11.30.06.54.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 30 Nov 2024 06:54:37 -0800 (PST)
Date: Sat, 30 Nov 2024 08:54:34 -0600
From: Tom Rini <trini@konsulko.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>, xypron.glpk@gmx.de,
 u-boot@lists.denx.de
Subject: Re: [PATCH v2] efi_loader: Add U-Boot memory to the EFI memory map
Message-ID: <20241130145434.GP3600562@bill-the-cat>
References: <20241129170814.768438-1-ilias.apalodimas@linaro.org>
 <CADg8p97prO=W-Qx2vqwZCnHFXhLvw2dy69UEB9f2rMH3CNZpPw@mail.gmail.com>
 <CAFLszTixsaUG1LeyWycdER5tU_=9tUpLMt0XZ78P4p8kH03iRw@mail.gmail.com>
 <CAFLszThi51_bB8821kTdk7txP6z+0RpaQ47BFb=UTBkK4Ohpxw@mail.gmail.com>
 <20241130034217.GO3600562@bill-the-cat>
 <CAC_iWjJPQ9xUY40xsNHZ-7htwm=2uh3YtvWJK=YEjgeA5nyLJw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="fw4IZUzwrkKSNfFP"
Content-Disposition: inline
In-Reply-To: <CAC_iWjJPQ9xUY40xsNHZ-7htwm=2uh3YtvWJK=YEjgeA5nyLJw@mail.gmail.com>
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


--fw4IZUzwrkKSNfFP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 30, 2024 at 08:13:24AM +0200, Ilias Apalodimas wrote:
> Hi Tom
>=20
> On Sat, 30 Nov 2024 at 05:42, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Fri, Nov 29, 2024 at 04:27:40PM -0700, Simon Glass wrote:
> > > (Sorry, that was supposed to be sent to Ilias)
> > >
> > > - Simon
> > >
> > > On Fri, 29 Nov 2024 at 15:26, Simon Glass <sjg@chromium.org> wrote:
> > > >
> > > > Hi Sughosh,
> > > >
> > > > On Fri, 29 Nov 2024 at 10:26, Sughosh Ganu <sughosh.ganu@linaro.org=
> wrote:
> > > > >
> > > > > On Fri, 29 Nov 2024 at 22:38, Ilias Apalodimas
> > > > > <ilias.apalodimas@linaro.org> wrote:
> > > > > >
> > > > > > This reverts commit ("commit a68c9ac5d8af ("efi_memory: do not =
add U-Boot memory to the memory map")
> > > > > > This code was removed when the EFI subsystem started using LMB =
calls for
> > > > > > the reservations. In hindsight it unearthed two problems.
> > > > > >
> > > > > > The e820 code is adding u-boot memory as EfiReservedMemory whil=
e it
> > > > > > should look at what LMB added and decide instead of blindly ove=
rwriting
> > > > > > it. The reason this worked is that we marked that code properly=
 late,
> > > > > > when the EFI came up. But now with the LMB changes, the EFI map=
 gets
> > > > > > added first and the e820 code overwrites it.
> > > > > >
> > > > > > The second problem is that we never mark SetVirtualAddressMap a=
s runtime
> > > > > > code, which we should according to the spec. Until we fix this =
the
> > > > > > current hack can't go away, at least for architectures that *ne=
ed* to
> > > > > > call SVAM.
> > > > > >
> > > > > > More specifically x86 currently requires SVAM and sets the NX b=
it for
> > > > > > pages not marked as *_CODE. So unless we do that late, it will =
crash
> > > > > > trying to execute from non-executable memory. It's also worth n=
oting
> > > > > > that x86 calls SVAM late in the boot, so this will work until s=
omeone
> > > > > > decides to overwrite/use BootServicesData from the OS.
> > > > > >
> > > > > > Notably arm64 disables it explicitly if the VA space is > 48bit=
s, so
> > > > > > doesn't suffer from any of these problems.
> > > > > >
> > > > > > This doesn't really deserve a fixes tag, since it brings back a=
 hack to
> > > > > > remedy a situation that was wrong long before that commit, but =
in case
> > > > > > anyone hits the same bug ...
> > > > > > Simon sent the original revert in the link, but we need a proper
> > > > > > justification for it.
> > > > > >
> > > > > > Link: https://lore.kernel.org/u-boot/20241112131830.576864-1-sj=
g@chromium.org/
> > > > > > Fixes: commit a68c9ac5d8af ("efi_memory: do not add U-Boot memo=
ry to the memory map")
> > > > > > Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > > > > > ---
> > > > >
> > > > > Acked-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > > > >
> > > > > Like you mention in the commit message, I don't think it warrants=
 a Fixes tag.
> > > > >
> > > > > -sughosh
> > > > >
> > > > > > Apologies for sending v2 so fast but we need this in for the re=
lease
> > > > > > Changes since v1:
> > > > > > - reword the commit message and fix spelling
> > > > > >
> > > > > >  lib/efi_loader/efi_memory.c | 11 ++++++++++-
> > > > > >  1 file changed, 10 insertions(+), 1 deletion(-)
> > > > > >
> > > > > > diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_m=
emory.c
> > > > > > index e493934c7131..edd7da7d8c6e 100644
> > > > > > --- a/lib/efi_loader/efi_memory.c
> > > > > > +++ b/lib/efi_loader/efi_memory.c
> > > > > > @@ -814,7 +814,16 @@ static void add_u_boot_and_runtime(void)
> > > > > >  {
> > > > > >         unsigned long runtime_start, runtime_end, runtime_pages;
> > > > > >         unsigned long runtime_mask =3D EFI_PAGE_MASK;
> > > > > > -
> > > > > > +       unsigned long uboot_start, uboot_pages;
> > > > > > +       unsigned long uboot_stack_size =3D CONFIG_STACK_SIZE;
> > > > > > +
> > > > > > +       /* Add U-Boot */
> > > > > > +       uboot_start =3D ((uintptr_t)map_sysmem(gd->start_addr_s=
p, 0) -
> > > > > > +                      uboot_stack_size) & ~EFI_PAGE_MASK;
> > > > > > +       uboot_pages =3D ((uintptr_t)map_sysmem(gd->ram_top - 1,=
 0) -
> > > > > > +                      uboot_start + EFI_PAGE_MASK) >> EFI_PAGE=
_SHIFT;
> > > > > > +       efi_add_memory_map_pg(uboot_start, uboot_pages, EFI_BOO=
T_SERVICES_CODE,
> > > > > > +                             false);
> > > > > >  #if defined(__aarch64__)
> > > > > >         /*
> > > > > >          * Runtime Services must be 64KiB aligned according to =
the
> > > > > > --
> > > > > > 2.45.2
> > > > > >
> > > >
> > > > Thank you for digging into this. It is helpful to add more things to
> > > > the commit message, but please redo your patch with a 'git revert' =
so
> > > > we get the correct subject and body, as my patch did.
> >
> > I don't have a preference about the subject, but the body above is
> > correct. It says "This reverts commit ..." and then explains _why_ we
> > need to revert it.
>=20
> Yes, we agree and although we are in bikeshedding territory now, I
> don't mind sending a new one with a changed subject. Just let me know.
> In any case feel free to merge this as
> Revert "efi_memory: do not add U-Boot memory to the memory map"

Talking with Ilias and Simon off-list and I'm doing a few tweaks to the
commit message and pushing this shortly, thanks all!

--=20
Tom

--fw4IZUzwrkKSNfFP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdLJx4ACgkQFHw5/5Y0
tyyv7wwArtmnKHIosY2LXWb6/vkPxJ5/fdTnq19UCxd6xB9nVQXalGWhpa9nzYKJ
ZvVgofZjazMCjkWbypVpZtLrGx7lwk6phF//IHmD0AZnBV4ALRiUqENYnGwCAWbQ
KZGR9q37kenrwQtb5saK1j9aDf+Pr0NzGeOTG1+Rn/qC0nUTHQGl+DPtkOlaHMaK
FVHp1mwFtBDbfamD53IglDp+48KiRmqzfn1O7MDEWf/p8uFxBKVN0Tu/hQAKX2xB
uf662/ZoZQiEcqx3cH/FJK8RDErt95ljj3EVLg7NoLFxPsYFoAu+EC3r/xwrF6R6
YnPfZWfLaleFGo6caFUDGYE5U1hOG3BhNnVpGMEAWbKmPp+wKzqjglhAHr3rFyk5
NnQODbA8czcRqrKSi4dLnm3VH8FodZee15JM5JaFmt2AJ4UFbA9e0RhD8ZfPSB35
HhA4HtR9ChxRCZvz/nE0jbWRNAxsCzGo7u+QIOMT0og0iTKGUt5q/HULzYKuusHZ
LXy2HTQJ
=I378
-----END PGP SIGNATURE-----

--fw4IZUzwrkKSNfFP--

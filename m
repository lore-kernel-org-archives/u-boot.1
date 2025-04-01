Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6807BC36008
	for <u-boot@archiver.kernel.org>; Tue,  1 Apr 2025 07:02:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D9CA81F54;
	Tue,  1 Apr 2025 09:02:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ZzFHfeEC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0A1C782006; Tue,  1 Apr 2025 09:02:46 +0200 (CEST)
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com
 [IPv6:2607:f8b0:4864:20::b34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 78C6881F0D
 for <u-boot@lists.denx.de>; Tue,  1 Apr 2025 09:02:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb34.google.com with SMTP id
 3f1490d57ef6-e53ef7462b6so4912932276.3
 for <u-boot@lists.denx.de>; Tue, 01 Apr 2025 00:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743490962; x=1744095762; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a5pyn7x/uyDPMNo8FDiT0/kEz6htJ2Zl9HAKGvbNFd8=;
 b=ZzFHfeECUhxq/+QAoZZXpuWZCrclOH+3RJ7lupna2dVXEh5lSNBeuNRk+U55wbaJdb
 c9l9Ai28wSCpF79IDiU+z1JAq0YtKUeBCpa9O4MQ/KbWlIt/Sb14gfHcwzFvWkNMRrDz
 DesriT3YvhtWTnop6nEp9qkMoJe9bt3lO7Ii2lPw5ZM4rk9wAWM1FBSJylglDQAg/zjE
 oZvpz3zgIqmebuYqMN3QUTkPhUzJD3L/sZdCLWWCfrDJPporxZA1RKX7aGN4X7qkdv9x
 df/gXiMkkWx2UqSKDDUj7LmD7zSzF2rARQ+DMfaa7ZT2/6OdE5VhzQXqAedyuceaPUIQ
 oZ/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743490962; x=1744095762;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a5pyn7x/uyDPMNo8FDiT0/kEz6htJ2Zl9HAKGvbNFd8=;
 b=trzTrBrnVxGA8Tvgq+Vc8zUiys8aQgHkykg2ZeqKpz8w8qPr51m93OnY7sWTgRU5ZC
 ZpJ+HiaT2f6U/SXxjPFTI7jb4UrwnrYMdhSMEAv+nWk9Vea7+md11f/SIUr8dKZpp7m7
 vEHd+GpXoeNmZeLQb050L+j05xH4x7oYAgArVX1dS4C6n63tswKtLtGXtQ1IRurBwA8o
 KDoQW0JlN1V4Tuw/smP9zHj6LCbfEAMZamxVBGLxhnkZkNLtKpj5aLx9zsK8zX2zdEdj
 7slDo1w6g/LnEH/qNIFaf0IaLISIUUpKrcnRSFtQV0Z9sSTcCD7jlBGEwQZwcNVHZDiE
 aDWQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWliVrG4Rj+Pq7+ecZvZGQusr6dXuFyvAhU4C4SfhS4Ks2PgM/DCScTp0B2VjHQfNhMeMoZTEk=@lists.denx.de
X-Gm-Message-State: AOJu0YyoKxz8//hnk1+Bc2wbpbE7/9BhE6Fgov6u46lWRayqI92XMHQR
 zdxIB2zcKKdwEvBbPkrKWw5GS0IJzfvkge+wSooCoVP0GDaDaiHFqGtukCj1iyIgkoKA6KvHMV0
 VVNf04ehGI8dvgCrUTaCDRfNWdV6XaSPg5tUzuQ==
X-Gm-Gg: ASbGnctXXUZ1l2E7AjMT2DCldJoiiDyLbNHc87hi1Jf3GzhlclBJlTpnJgL/jmH5hV4
 M/5ym/EdKN2hZXD5iD89LvbB7f/pTJr7FvZxcFR8r4Nhltq3IiHxSQcczs1tuV0F13srxQzTvR5
 effth/RKtWAj8gDlBgbcUhxlk9
X-Google-Smtp-Source: AGHT+IEdfOE+frNbhZZW8kyJo69Ww68MsEhtHhNiD+7xfarScJLgnipTI1YGZAAWvjG/2FpOK+RI5p3n5kToPF3qYFw=
X-Received: by 2002:a05:6902:2102:b0:e5d:ac3c:9dec with SMTP id
 3f1490d57ef6-e6b83a42df0mr13683036276.35.1743490962243; Tue, 01 Apr 2025
 00:02:42 -0700 (PDT)
MIME-Version: 1.0
References: <20250326054653.273906-1-quic_varada@quicinc.com>
 <CAC_iWj+MPcOcuhM1vcHyXYUF7O7U_y8+KKMZJszTK2aqfgfHZg@mail.gmail.com>
 <Z+TsLpAGAIezgPZS@hu-varada-blr.qualcomm.com>
 <CAC_iWjKyyOHCU2xv-x9BW9w7GtY8ohupxNKTTJC0V91dfPwy8Q@mail.gmail.com>
 <Z+uL1TQlh+ayjF+G@hu-varada-blr.qualcomm.com>
In-Reply-To: <Z+uL1TQlh+ayjF+G@hu-varada-blr.qualcomm.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 1 Apr 2025 10:02:05 +0300
X-Gm-Features: AQ5f1JoPJo8Jex3yY_NndT8UI_fObKnp__rlIEj17F2HTJMEmBFKY_XZ4r4Q2vA
Message-ID: <CAC_iWjK=-qVD2=SM=fT7JujRPZi5HWht6rjbU_174UUyWYezqQ@mail.gmail.com>
Subject: Re: [PATCH v1] efi_loader: Handle GD_FLG_SKIP_RELOC
To: Varadarajan Narayanan <quic_varada@quicinc.com>
Cc: trini@konsulko.com, sjg@chromium.org, EABachinin@salutedevices.com, 
 jerome.forissier@linaro.org, rasmus.villemoes@prevas.dk, ansuelsmth@gmail.com, 
 sughosh.ganu@linaro.org, michal.simek@amd.com, u-boot@lists.denx.de
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

On Tue, 1 Apr 2025 at 09:46, Varadarajan Narayanan
<quic_varada@quicinc.com> wrote:
>
> On Thu, Mar 27, 2025 at 11:22:58PM +0200, Ilias Apalodimas wrote:
> > On Thu, 27 Mar 2025 at 08:12, Varadarajan Narayanan
> > <quic_varada@quicinc.com> wrote:
> > >
> > > On Wed, Mar 26, 2025 at 09:28:04AM +0200, Ilias Apalodimas wrote:
> > > > Hi Varadarajan
> > > >
> > > > On Wed, 26 Mar 2025 at 07:47, Varadarajan Narayanan
> > > > <quic_varada@quicinc.com> wrote:
> > > > >
> > > > > If the EFI runtime services pointers are relocated even though
> > > > > relocation is skipped, it corrupts some other data resulting in s=
ome
> > > > > unexpected behaviour.
> > > > >
> > > > > In this specific case, it overwrote some page table entries resul=
ting in
> > > > > the device memory address range's mappings getting removed. Event=
ually,
> > > > > after the completion of efi_runtime_relocate(), when a driver tri=
es to
> > > > > access its device's registers it crashes since the mappings are a=
bsent.
> > > >
> > > > How were those page table entries added?
> > >
> > > initr_caches ->
> > >         enable_caches ->
> > >                 setup_pgtables (arch/arm/mach-snapdragon/board.c)
> > >
> > > > The runtime service relocation might have overwritten those now, bu=
t
> > > > since they are not in protected memory this can happen arbitrarily.
> > >
> > > To avoid relocating U-Boot, I had OR'ed GD_FLG_SKIP_RELOC to gd->flag=
s
> > > in init_sequence_f -> mach_cpu_init(). Hope that is the right place a=
nd
> > > way to do it.
> >
> > I'll have a look at the relocation stuff, but off the top of my head,
> > I don't remember.
> >
> > >
> > > > > Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> > > > > ---
> > > > >  common/board_r.c | 3 ++-
> > > > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/common/board_r.c b/common/board_r.c
> > > > > index 179259b00de..1dd3b96c2de 100644
> > > > > --- a/common/board_r.c
> > > > > +++ b/common/board_r.c
> > > > > @@ -169,7 +169,8 @@ static int initr_reloc_global_data(void)
> > > > >          */
> > > > >         efi_save_gd();
> > > > >
> > > > > -       efi_runtime_relocate(gd->relocaddr, NULL);
> > > > > +       if (!(gd->flags & GD_FLG_SKIP_RELOC))
> > > > > +               efi_runtime_relocate(gd->relocaddr, NULL);
> > > >
> > > > Have you tested booting with EFI with this change?
> > >
> > > Yes, tested this with both GD_FLG_SKIP_RELOC set and not set.
> > >
> > > Used the command 'bootefi bootmgr' and Linux is able to boot.
> >
> > Have you tried to call any runtime services -- e.g efival -l will dump
> > all the EFI variables
>
> Sorry for the delay. The test setup was busy. My U-boot doesn't seem to
> have this command. Not sure if I'm missing some config.
>
>         =3D> efival -l
>         Unknown command 'efival' - try 'help'
>
> However, 'efidebug boot dump' works. Does that suffice?

This runs at boottime. We want to test the variables at runtime so you
have to boot linux.
One of efibootmgr or efivar -l is enough

Cheers
/Ilias
>
>         =3D> efidebug boot dump
>         Boot0000:
>         attributes: A-- (0x00000001)
>           label: scsi 0
>           file_path:
>         /VenHw(e61d73b9-a384-4acc-aeab-82e828f3628b,0000000000000000)/Ven=
Hw(e61d73b9-a384-4acc-aeab-82e828f3628b,6d00000000000000)/VenHw(e61d73b9-a3=
84-4acc-aeab-82e828f3628b,7d00000000000000)/VenHw(e61d73b9-a384-4acc-aeab-8=
2e828f3628b,6b00000000000000)/Scsi(0,0)
>           data:
>             00000000: 4e ac 08 81 11 9f 59 4d 85 0e e2 1a 52 2c 59 b2
>         N.....YM....R,Y.
>         Boot0001:
>         attributes: A-- (0x00000001)
>           label: scsi 1
>           file_path:
>         /VenHw(e61d73b9-a384-4acc-aeab-82e828f3628b,0000000000000000)/Ven=
Hw(e61d73b9-a384-4acc-aeab-82e828f3628b,6d00000000000000)/VenHw(e61d73b9-a3=
84-4acc-aeab-82e828f3628b,7d00000000000000)/VenHw(e61d73b9-a384-4acc-aeab-8=
2e828f3628b,6b00000000000000)/Scsi(0,1)
>           data:
>             00000000: 4e ac 08 81 11 9f 59 4d 85 0e e2 1a 52 2c 59 b2
>         N.....YM....R,Y.
>         Boot0002:
>         attributes: A-- (0x00000001)
>           label: scsi 2
>           file_path:
>         /VenHw(e61d73b9-a384-4acc-aeab-82e828f3628b,0000000000000000)/Ven=
Hw(e61d73b9-a384-4acc-aeab-82e828f3628b,6d00000000000000)/VenHw(e61d73b9-a3=
84-4acc-aeab-82e828f3628b,7d00000000000000)/VenHw(e61d73b9-a384-4acc-aeab-8=
2e828f3628b,6b00000000000000)/Scsi(0,2)
>           data:
>             00000000: 4e ac 08 81 11 9f 59 4d 85 0e e2 1a 52 2c 59 b2
>         N.....YM....R,Y.
>         Boot0003:
>         attributes: A-- (0x00000001)
>           label: scsi 3
>           file_path:
>         /VenHw(e61d73b9-a384-4acc-aeab-82e828f3628b,0000000000000000)/Ven=
Hw(e61d73b9-a384-4acc-aeab-82e828f3628b,6d00000000000000)/VenHw(e61d73b9-a3=
84-4acc-aeab-82e828f3628b,7d00000000000000)/VenHw(e61d73b9-a384-4acc-aeab-8=
2e828f3628b,6b00000000000000)/Scsi(0,3)
>           data:
>             00000000: 4e ac 08 81 11 9f 59 4d 85 0e e2 1a 52 2c 59 b2
>         N.....YM....R,Y.
>         Boot0004:
>         attributes: A-- (0x00000001)
>           label: scsi 4
>           file_path:
>         /VenHw(e61d73b9-a384-4acc-aeab-82e828f3628b,0000000000000000)/Ven=
Hw(e61d73b9-a384-4acc-aeab-82e828f3628b,6d00000000000000)/VenHw(e61d73b9-a3=
84-4acc-aeab-82e828f3628b,7d00000000000000)/VenHw(e61d73b9-a384-4acc-aeab-8=
2e828f3628b,6b00000000000000)/Scsi(0,4)
>           data:
>             00000000: 4e ac 08 81 11 9f 59 4d 85 0e e2 1a 52 2c 59 b2
>         N.....YM....R,Y.
>         Boot0005:
>         attributes: A-- (0x00000001)
>           label: scsi 5
>           file_path:
>         /VenHw(e61d73b9-a384-4acc-aeab-82e828f3628b,0000000000000000)/Ven=
Hw(e61d73b9-a384-4acc-aeab-82e828f3628b,6d00000000000000)/VenHw(e61d73b9-a3=
84-4acc-aeab-82e828f3628b,7d00000000000000)/VenHw(e61d73b9-a384-4acc-aeab-8=
2e828f3628b,6b00000000000000)/Scsi(0,5)
>           data:
>             00000000: 4e ac 08 81 11 9f 59 4d 85 0e e2 1a 52 2c 59 b2
>         N.....YM....R,Y.
>         Boot0006:
>         attributes: A-- (0x00000001)
>           label: scsi 6
>           file_path:
>         /VenHw(e61d73b9-a384-4acc-aeab-82e828f3628b,0000000000000000)/Ven=
Hw(e61d73b9-a384-4acc-aeab-82e828f3628b,6d00000000000000)/VenHw(e61d73b9-a3=
84-4acc-aeab-82e828f3628b,7d00000000000000)/VenHw(e61d73b9-a384-4acc-aeab-8=
2e828f3628b,6b00000000000000)/Scsi(0,6)
>           data:
>             00000000: 4e ac 08 81 11 9f 59 4d 85 0e e2 1a 52 2c 59 b2
>         N.....YM....R,Y.
>         Boot0007:
>         attributes: A-- (0x00000001)
>           label: scsi 7
>           file_path:
>         /VenHw(e61d73b9-a384-4acc-aeab-82e828f3628b,0000000000000000)/Ven=
Hw(e61d73b9-a384-4acc-aeab-82e828f3628b,6d00000000000000)/VenHw(e61d73b9-a3=
84-4acc-aeab-82e828f3628b,7d00000000000000)/VenHw(e61d73b9-a384-4acc-aeab-8=
2e828f3628b,6b00000000000000)/Scsi(0,7)
>           data:
>             00000000: 4e ac 08 81 11 9f 59 4d 85 0e e2 1a 52 2c 59 b2
>         N.....YM....R,Y.
>
> Thanks
> Varada

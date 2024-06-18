Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74501C27C4F
	for <u-boot@archiver.kernel.org>; Tue, 18 Jun 2024 14:15:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BEB3E88137;
	Tue, 18 Jun 2024 16:15:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="J8g8I4Q+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A2D48819D; Tue, 18 Jun 2024 16:15:32 +0200 (CEST)
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com
 [IPv6:2001:4860:4864:20::29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF66E8812C
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 16:15:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-25c4d8ae511so8989fac.2
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 07:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1718720128; x=1719324928; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=KfZU37cL8dQl1wemUjnyz0XLZ3h7r2pWbFoKNhlBPQo=;
 b=J8g8I4Q+Jzp3iLChCbgqqAitayCQuZSHoYGZeaCHzwRPewGW57xkAl94srf03P+T/L
 fRGBA4EtnfiRJ751D13LLDfv264Y9ZIvfZ1DrdJwkdAXSqI/EBZ5LozzDqhZ2t7cYfBA
 VnVKtBWCrGMZJGxgwSKXQBrVMMEiYC77Sp9RE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718720128; x=1719324928;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KfZU37cL8dQl1wemUjnyz0XLZ3h7r2pWbFoKNhlBPQo=;
 b=Jh6y0+1PoS1ahWElf86Xmo4YvZhAMiNPDipDl3RhNczW5W0Yf7RuvuIO0R7s2Yoc1J
 3MAaz4o2i8Pa3LERoc/e91GIPz0J1syVKtQU70oollbd6iLT3mJaExkvY2RlEOAJBrQf
 KKM/Xn35Tpi6Yh/GOjchusDdlfMFrsgcx+Kj7OKDvaZMCFMGwJTEo1aoKfgIRVtM5+AJ
 3tuzuudcpFILqVhRWuUzETeVUcX42ZVjfpVwOnpXEm6s/cC6q42XjiKfZn0h0LHt0tO8
 QGsanFJgnvuBygQnSw50SQh6o3Af0sV4ptdOi5SwnDKmEimxKF9WhIwUNK/dq4IsGYyI
 Z2xQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU3S8mHUMnOw6zqD5AjO2TGO3rXLDAfRzx2hU+bfK/YGTpX4byfUc6S08wthDJZpAQx6RPJTGAiKb39ZOK3QA+X2yvtgw==
X-Gm-Message-State: AOJu0YznA6oHTagV00LbdpOEWoTrAm0X/P9CQPb05OkjdpFGQ+W5mOnp
 DxSmdkGAmXonzUZEp03ApSoYuFtTAV/BkVoNFgh7hMbnX4xNOKbeQCx7BqsULM0=
X-Google-Smtp-Source: AGHT+IGYOWOO0K093iNe20toDh0cjmu/kMr6VeTLsROJsWZeCmzCKU7bJZa4RFLxvsQN99aXRfWWOg==
X-Received: by 2002:a05:6870:3906:b0:254:b2e8:163d with SMTP id
 586e51a60fabf-258428b4e11mr14659811fac.19.1718720128317; 
 Tue, 18 Jun 2024 07:15:28 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-45.totalplay.net.
 [187.190.205.45]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2569930f69asm3167605fac.45.2024.06.18.07.15.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Jun 2024 07:15:27 -0700 (PDT)
Date: Tue, 18 Jun 2024 08:15:24 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 U-Boot Mailing List <u-boot@lists.denx.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Bin Meng <bmeng.cn@gmail.com>, Eddie James <eajames@linux.ibm.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>, Michal Simek <michal.simek@amd.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Sean Anderson <sean.anderson@seco.com>
Subject: Re: [PATCH v2 2/9] tpm: Avoid code bloat when not using
 EFI_TCG2_PROTOCOL
Message-ID: <20240618141524.GO68077@bill-the-cat>
References: <20240610145920.3302001-1-sjg@chromium.org>
 <20240610145920.3302001-3-sjg@chromium.org>
 <CAC_iWj+fSRt2E3ZcHaXrKjC+Gz7LZu_EWgiegWG3F1MJMJrPNQ@mail.gmail.com>
 <14ae7a31-757a-4220-b2a8-20204e3d7aa9@gmx.de>
 <CAC_iWjKAQwLobcO8virDKKD8cQ4j7-OAzn2nriNmdGUtMRKXnw@mail.gmail.com>
 <8b6f5ad8-911f-4954-8b48-333986be0bf8@gmx.de>
 <CAC_iWjL-W604ne_O+U6B3_oGXJtQqZwak4N2qVRSnqdsAz=TbQ@mail.gmail.com>
 <CAFLszTigrcPCH3wwZUZAk75QttVS+cPMoj=hZJ9Ko9DqyN5vVA@mail.gmail.com>
 <20240617171623.GY68077@bill-the-cat>
 <CAFLszThO9Hnfv90X4yu49h7LcWCfgMztSGtQdGwrCt9UDH_cGA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="NgrSWhFNVDkcVSkg"
Content-Disposition: inline
In-Reply-To: <CAFLszThO9Hnfv90X4yu49h7LcWCfgMztSGtQdGwrCt9UDH_cGA@mail.gmail.com>
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


--NgrSWhFNVDkcVSkg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 18, 2024 at 06:43:51AM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Mon, 17 Jun 2024 at 11:16, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Mon, Jun 17, 2024 at 07:53:22AM -0600, Simon Glass wrote:
> > > Hi,
> > >
> > > On Sat, 15 Jun 2024 at 01:03, Ilias Apalodimas
> > > <ilias.apalodimas@linaro.org> wrote:
> > > >
> > > > Hi Heinrich
> > > >
> > > > resending the reply, I accidentally sent half of the message...
> > > >
> > > > On Fri, 14 Jun 2024 at 12:04, Heinrich Schuchardt <xypron.glpk@gmx.=
de> wrote:
> > > > >
> > > > > On 14.06.24 09:01, Ilias Apalodimas wrote:
> > > > > > On Fri, 14 Jun 2024 at 09:59, Heinrich Schuchardt <xypron.glpk@=
gmx.de> wrote:
> > > > > >>
> > > > > >> On 6/14/24 08:03, Ilias Apalodimas wrote:
> > > > > >>> Hi Simon,
> > > > > >>>
> > > > > >>> On Mon, 10 Jun 2024 at 17:59, Simon Glass <sjg@chromium.org> =
wrote:
> > > > > >>>>
> > > > > >>>> It does not make sense to enable all SHA algorithms unless t=
hey are
> > > > > >>>> needed. It bloats the code and in this case, causes chromebo=
ok_link to
> > > > > >>>> fail to build. That board does use the TPM, but not with mea=
sured boot,
> > > > > >>>> nor EFI.
> > > > > >>>>
> > > > > >>>> Since EFI_TCG2_PROTOCOL already selects these options, we ju=
st need to
> > > > > >>>> add them to MEASURED_BOOT as well.
> > > > > >>>>
> > > > > >>>> Note that the original commit combines refactoring and new f=
eatures,
> > > > > >>>> which makes it hard to see what is going on.
> > > > > >>>>
> > > > > >>>> Fixes: 97707f12fda tpm: Support boot measurements
> > > > > >>>> Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > >>>> ---
> > > > > >>>>
> > > > > >>>> Changes in v2:
> > > > > >>>> - Put the conditions under EFI_TCG2_PROTOCOL
> > > > > >>>> - Consider MEASURED_BOOT too
> > > > > >>>>
> > > > > >>>>    boot/Kconfig | 4 ++++
> > > > > >>>>    lib/Kconfig  | 4 ----
> > > > > >>>>    2 files changed, 4 insertions(+), 4 deletions(-)
> > > > > >>>>
> > > > > >>>> diff --git a/boot/Kconfig b/boot/Kconfig
> > > > > >>>> index 6f3096c15a6..b061891e109 100644
> > > > > >>>> --- a/boot/Kconfig
> > > > > >>>> +++ b/boot/Kconfig
> > > > > >>>> @@ -734,6 +734,10 @@ config LEGACY_IMAGE_FORMAT
> > > > > >>>>    config MEASURED_BOOT
> > > > > >>>>           bool "Measure boot images and configuration when b=
ooting without EFI"
> > > > > >>>>           depends on HASH && TPM_V2
> > > > > >>>> +       select SHA1
> > > > > >>>> +       select SHA256
> > > > > >>>> +       select SHA384
> > > > > >>>> +       select SHA512
> > > > > >>>>           help
> > > > > >>>>             This option enables measurement of the boot proc=
ess when booting
> > > > > >>>>             without UEFI . Measurement involves creating cry=
ptographic hashes
> > > > > >>>> diff --git a/lib/Kconfig b/lib/Kconfig
> > > > > >>>> index 189e6eb31aa..568892fce44 100644
> > > > > >>>> --- a/lib/Kconfig
> > > > > >>>> +++ b/lib/Kconfig
> > > > > >>>> @@ -438,10 +438,6 @@ config TPM
> > > > > >>>>           bool "Trusted Platform Module (TPM) Support"
> > > > > >>>>           depends on DM
> > > > > >>>>           imply DM_RNG
> > > > > >>>> -       select SHA1
> > > > > >>>> -       select SHA256
> > > > > >>>> -       select SHA384
> > > > > >>>> -       select SHA512
> > > > > >>>
> > > > > >>> I am not sure this is the right way to deal with your problem.
> > > > > >>> The TPM main functionality is to measure and extend PCRs, so =
shaXXXX
> > > > > >>> is really required. To make things even worse, you don't know=
 the PCR
> > > > > >>> banks that are enabled beforehand. This is a runtime config o=
f the
> > > > > >>> TPM.
> > > > > >>
> > > > > >> If neither MEASURED_BOOT nor EFI_TCG2_PROTOCOL is selected, U-=
Boot
> > > > > >> cannot extend PCRs. So it seems fine to let these two select t=
he
> > > > > >> complete set of hashing algorithms. As Simon pointed out for
> > > > > >> EFI_TCG2_PROTOCOL this is already done in lib/efi_loader/Kconf=
ig.
> > > > > >
> > > > > > It can. The cmd we have can extend those pcrs -- e.g tpm2 pcr_e=
xtend 8
> > > > > > 0xb0000000
> > >
> > > That's pretty normal for U-Boot though, since we want to avoid lots of
> > > growth for things people might want control over. We can enable or
> > > disable the SHA for the board, if this functionality is used outside
> > > of measured boot and tcg2, but someone is enabling the tpm command.
> > >
> > > > >
> > > > > So this patch should also consider CMD_TPM_V2 and CMD_TPM_V1.
> > > > >
> > > > > TPM v1 only needs SHA-1.
> > > >
> > > > I still prefer to imply all algos.
> > >
> > > 'imply' would be OK in this case as I can disable it for that board. I
> > > don't think it is in the spirit of U-Boot though.
> > >
> > > isn't someone checking the growth in U-Boot? Or do so few boards have
> > > TPMs that it didn't register? The size growth was 3.2KB on
> > > chromebook_link.
> >
> > As always, yes, nearly every PR (I don't check the ones that touch just
> > a single board for example) gets a world build before/after. In this
> > case I likely assumed that it was acceptable growth for enabling
> > features. It sounds like some of the chromebook boards need to be
> > setting the features to cause link failure if a size is exceeded?
>=20
> The problem is that some Intel platforms have binary blobs, so the
> size isn't known unless you have a real blob.

Alright, but can't we put in some limit based on what the current blobs
are, or look at the last few blob releases and see if they change much
in size and put something in? Other platforms have blobs and size
limits...

--=20
Tom

--NgrSWhFNVDkcVSkg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZxlnkACgkQFHw5/5Y0
tywvNAwAobnyiY29hUSedS8yKJdvZYm6jQLx9IPglxoEHe7wJk0FA+WZj1XQl4AO
wrBj1IrVqLp/zoIYHkuyh9t2RifyP3aRkKKWpAU28G65+MYU3se/I6xIkpQpkcH/
D8hIQZfC6C1NT3EKq+T1vtyxbe5UjwBYA9c3zrE2OhhwOqKh7+B1B9D/fCHY1CR+
16eNrQvgcMsSuNiOHFsAyLxioo/IR93kuMy7T0S6utTeT2CRO0GqfJArglNySIBI
kwT+8c0q7d9656BVOWaSHdsiRD3eOh1/FHlO6FXMADVLSzoiXiMVEQ0s3toa5h06
4xenHXnAO1SnEBSJjv/MazIJ+4gpxIqx/Xs/H20Au4eYY3ExOEkUEiDX4ziLWbGt
J40DpTdrnfBtj/bzNW6MZRga8olqlZeJdnGYR7N6dlzcNGZHKyVLj9C7WxVmc8ds
KYLIvNLo1d4ELGb4ZY3sfYN6iGg5CbULrlr5LgkYnPb52KHXDlMwkLlExG5meQgo
sGnR5T9j
=3VgP
-----END PGP SIGNATURE-----

--NgrSWhFNVDkcVSkg--

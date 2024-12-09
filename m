Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F384E7717D
	for <u-boot@archiver.kernel.org>; Mon,  9 Dec 2024 19:23:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C550B8965A;
	Mon,  9 Dec 2024 20:23:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="f9VvwZ+J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 454DB89783; Mon,  9 Dec 2024 20:23:48 +0100 (CET)
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com
 [IPv6:2607:f8b0:4864:20::72f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EEEC18906C
 for <u-boot@lists.denx.de>; Mon,  9 Dec 2024 20:23:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72f.google.com with SMTP id
 af79cd13be357-7b6c3b1ee59so181660885a.0
 for <u-boot@lists.denx.de>; Mon, 09 Dec 2024 11:23:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1733772225; x=1734377025; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=F37tikYC70EgJ6NX0P6j9z9dDuDIZCSdQ32cgXG0VKw=;
 b=f9VvwZ+J5RyWXPi/ugTDRLNYVQhzlP2Bgg5pi7MnWzlTendrBfprux7RLzQ7eg7f1K
 FJWfk3bQ1Tsdyb5pL8SYEb0Ko2qjt4lERKXvX+8nkAU4VHOjPc3RfRtyXrtOZpGlRGmJ
 pHMhv90RBDb7IAcGJwcZctgttSbojQfd4eHJY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733772225; x=1734377025;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F37tikYC70EgJ6NX0P6j9z9dDuDIZCSdQ32cgXG0VKw=;
 b=J/VqEbdLZbtUihCo1RO63I1Y2EDo/lXSBiYy9a/JHIBssgzU1YJvhh3ysGT90gxmLT
 4SFpzJa+vZQROO+0uLU/ABVqV+5jXZv8xLB53p5sCq3du+bGegyQMSMXcQr0YfFfP54V
 F7+uWeIEn2Lq/lOV/EkEPJKU55GokMb4DsyzEWpC/F4a52bzfk6eKqSdectRt/pXbJVd
 jkoon+iWhwQeDQAPPRIVJfhxO0O2Qo/gF1wXQzehn2Qg8LujgTJE3u+lfGwvgatcPWTd
 3ecY8Gi0JhnQXVDQHs4GvTkqtG58v+KJ9E+/8kmBe58xzsWL4Ih+D8x2RW1WidfqfFXr
 KO8Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXoYxRdzEVH+62CFnF+zdQmTQ6kp+YQkDG2V5rLOZ+NURPj9xPR6DA/awFiqQz8sUJZHeSbWD8=@lists.denx.de
X-Gm-Message-State: AOJu0YwODOB+GNJKJwL49GdjYnogcoEbCQe9jzvA4tfhTgdZX5u2MS3v
 8FjfHTrQA4sg+pa1T2Q0ns3SPaFLQqPk7yRP/7ChPxZJhVTJbQsS17AVn+nUo8Y=
X-Gm-Gg: ASbGncuh9DNtezmaupz8hDC2D1fAd3w9P3W0uGDJ7bgTSsuAEqbBYDC1A8wGzDTzqgL
 cyKCApce1gGk/piD0RuhZ0SBJ/nc5xQW789t5IZU2T+3Sv6AZTUEzXvq+1Xpv1b8fqNrzudURck
 9gGp0cziP0X1B5HaoSmP9VFjeqLSkVBlh4AukLOUni2YhiCH2A2bQZOXgNhy4Gkx1hlP3XWuT8n
 DFQzbDZsVq43y3A4KMPUCaxADYV97RV7dfDitJDV7TfDvrqeFk=
X-Google-Smtp-Source: AGHT+IG7W0LLSFQ0vLo2JPtnzYkFTVuHHeG9tGJ2s0lyQ3T4fejlTGKeA6sc3f+1vNrF5pMIovXwwQ==
X-Received: by 2002:a05:620a:6184:b0:7b6:d8aa:7ef8 with SMTP id
 af79cd13be357-7b6dce7be80mr252544485a.37.1733772224737; 
 Mon, 09 Dec 2024 11:23:44 -0800 (PST)
Received: from bill-the-cat ([189.177.125.100])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b6ce23a3fdsm209120985a.99.2024.12.09.11.23.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Dec 2024 11:23:43 -0800 (PST)
Date: Mon, 9 Dec 2024 13:23:40 -0600
From: Tom Rini <trini@konsulko.com>
To: Michal Simek <michal.simek@amd.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de, git@xilinx.com,
 neal.frager@amd.com, Christian Marangi <ansuelsmth@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: Re: [PATCH v2 2/7] common: binman: Calling initr_binman() when
 BINMAN_FDT
Message-ID: <20241209192340.GV2457179@bill-the-cat>
References: <cover.1730452668.git.michal.simek@amd.com>
 <f79dc1fbf796dd5ad290f6080608ee68d7652cfc.1730452668.git.michal.simek@amd.com>
 <CAFLszTiWOdsS8=pm7aSvyC2QYiXbbsciz2yb6s9YPV1FeFFrgg@mail.gmail.com>
 <2ee46698-87c9-47e3-8951-41ac3c50331a@amd.com>
 <20241209153216.GJ2457179@bill-the-cat>
 <CAFLszTjb23qYBS2YDWjTJDFtJ2OnZZ5OQG56i9DBu_NeUT=FzQ@mail.gmail.com>
 <b5145a88-aea0-43c1-8fa0-fe533bd9d169@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="WnRsWHGw8AohL+Ea"
Content-Disposition: inline
In-Reply-To: <b5145a88-aea0-43c1-8fa0-fe533bd9d169@amd.com>
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


--WnRsWHGw8AohL+Ea
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 09, 2024 at 07:34:34PM +0100, Michal Simek wrote:
>=20
>=20
> On 12/9/24 16:47, Simon Glass wrote:
> > Hi,
> >=20
> > On Mon, 9 Dec 2024 at 08:32, Tom Rini <trini@konsulko.com> wrote:
> > >=20
> > > On Mon, Dec 09, 2024 at 04:26:15PM +0100, Michal Simek wrote:
> > > >=20
> > > >=20
> > > > On 12/6/24 20:20, Simon Glass wrote:
> > > > > On Fri, 1 Nov 2024 at 03:18, Michal Simek <michal.simek@amd.com> =
wrote:
> > > > > >=20
> > > > > > Calling empty function when BINMAN_FDT is adding +64B for nothi=
ng which is
> > > > > > not helping on size sensitive configurations as Xilinx mini con=
figurations.
> > > > > >=20
> > > > > > Signed-off-by: Michal Simek <michal.simek@amd.com>
> > > > > > ---
> > > > > >=20
> > > > > > Changes in v2:
> > > > > > - new patch
> > > > > >=20
> > > > > >   From my perspective there is no reason to call empty function=
=2E It is just
> > > > > > increase footprint for nothing and we are not far from that lim=
it now.
> > > > > >=20
> > > > > > ---
> > > > > >    common/board_r.c | 7 +++----
> > > > > >    1 file changed, 3 insertions(+), 4 deletions(-)
> > > > >=20
> > > > > Reviewed-by: Simon Glass <sjg@chromium.org>
> > > > >=20
> > > > > This is a bit odd, though. Do you have LTO enabled?
> > > > >=20
> > > >=20
> > > > yes LTO is enabled. And there are other candidates like this.
> > > > Is LTO able to fix function arrays which is calling empty function?
> > > >=20
> > > > (without this patch)
> > > >=20
> > > > 00000000fffc0eb4 <initr_of_live>:
> > > >      fffc0eb4:   52800000        mov     w0, #0x0                  =
      // #0
> > > >      fffc0eb8:   d65f03c0        ret
> > > >=20
> > > > 00000000fffc0ebc <initr_dm_devices>:
> > > >      fffc0ebc:   52800000        mov     w0, #0x0                  =
      // #0
> > > >      fffc0ec0:   d65f03c0        ret
> > > >=20
> > > > 00000000fffc0ec4 <initr_bootstage>:
> > > >      fffc0ec4:   52800000        mov     w0, #0x0                  =
      // #0
> > > >      fffc0ec8:   d65f03c0        ret
> > > >=20
> > > > 00000000fffc0ecc <power_init_board>:
> > > >      fffc0ecc:   52800000        mov     w0, #0x0                  =
      // #0
> > > >      fffc0ed0:   d65f03c0        ret
> > > >=20
> > > > 00000000fffc0ed4 <initr_announce>:
> > > >      fffc0ed4:   52800000        mov     w0, #0x0                  =
      // #0
> > > >      fffc0ed8:   d65f03c0        ret
> > > >=20
> > > > 00000000fffc0edc <initr_binman>:
> > > >      fffc0edc:   52800000        mov     w0, #0x0                  =
      // #0
> > > >      fffc0ee0:   d65f03c0        ret
> > > >=20
> > > > 00000000fffc0ee4 <initr_status_led>:
> > > >      fffc0ee4:   52800000        mov     w0, #0x0                  =
      // #0
> > > >      fffc0ee8:   d65f03c0        ret
> > > >=20
> > > > 00000000fffc0eec <initr_boot_led_blink>:
> > > >      fffc0eec:   52800000        mov     w0, #0x0                  =
      // #0
> > > >      fffc0ef0:   d65f03c0        ret
> > > >=20
> > > > 00000000fffc0ef4 <initr_boot_led_on>:
> > > >      fffc0ef4:   52800000        mov     w0, #0x0                  =
      // #0
> > > >      fffc0ef8:   d65f03c0        ret
> > > >=20
> > > > 00000000fffc0efc <initr_lmb>:
> > > >      fffc0efc:   52800000        mov     w0, #0x0                  =
      // #0
> > > >      fffc0f00:   d65f03c0        ret
> > >=20
> > > No, but maybe Simon would prefer if we marked all of the could-be-emp=
ty
> > > functions as __maybe_unused and did:
> > >          CONFIG_IS_ENABLED(BINMAN_FDT, initr_binman),
> > > etc in the list instead?
> >=20
> > Yes that looks better.
>=20
> But we are talking about using macro inside array at best with using #ifd=
efs.
> Or maybe I am not seeing what you are saying.

No, nevermind, sorry. I was hoping that:
diff --git a/common/board_r.c b/common/board_r.c
index ff9bce88dc93..c18997446dfa 100644
--- a/common/board_r.c
+++ b/common/board_r.c
@@ -610,9 +610,7 @@ static init_fnc_t init_sequence_r[] =3D {
 	noncached_init,
 #endif
 	initr_of_live,
-#ifdef CONFIG_DM
-	initr_dm,
-#endif
+	CONFIG_IS_ENABLED(CONFIG_DM, initr_dm),
 #ifdef CONFIG_ADDR_MAP
 	init_addr_map,
 #endif
@@ -632,9 +630,7 @@ static init_fnc_t init_sequence_r[] =3D {
 #ifdef CONFIG_EFI_LOADER
 	efi_memory_init,
 #endif
-#ifdef CONFIG_BINMAN_FDT
-	initr_binman,
-#endif
+	CONFIG_IS_ENABLED(CONFIG_BINMAN_FDT, initr_binman),
 #ifdef CONFIG_FSP_VERSION2
 	arch_fsp_init_r,
 #endif

would work, but the macro doesn't evaluate how I'd hope it did and that
just blows up.

--=20
Tom

--WnRsWHGw8AohL+Ea
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdXQ7gACgkQFHw5/5Y0
tyxDCQwAg4H4XD+EJqEnZuwT4eP5qCa13Q3wz7l1k6gKZA9l+P6yKdnhitaIZIu5
htpQbqfXF7Ga2oBNFwE8gwBJchh7OXV1OCU0JvwVzfQmQnhIr3J7+MwG4u/o9b+s
bLTrJFrBzj+Q8a9SQdAREG09Pc8LX3lD2PJ0wwVi2Qg+fUTFKATCw8RKkUD8bdwP
a0vUc+uGXjFMvrgwSOl4N6FGtqIVn01j8jbxs3OkaGXmboFs0KDrj9CP+4U94b2M
m2gkTKF6biK/NtyHhXrdiM8z68BNTKaos6OLcKF0l4OEiYX8mwaoKC6CpcBbUoAl
LrDoucEvPP5ZOf9iMDE/10DKuLc2nRJ1rhVjM7l/zyjXlwUZ0rmnbGnfh4L5PijZ
VIgGe3ZIW+YJhmV6MBMqhqA9MHWoVvUFIsp9eMs66IICxw4DLtFYNunSYxtMqqjx
a0Bl9853bTE+vCycXnIlzfqYcs98E18wTxlOmXBdmcqcSFuKX0XFysTqshNCRRAh
RSuuf3qO
=K9NM
-----END PGP SIGNATURE-----

--WnRsWHGw8AohL+Ea--

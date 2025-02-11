Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17452C0219B
	for <u-boot@archiver.kernel.org>; Tue, 11 Feb 2025 22:30:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D0A880C5A;
	Tue, 11 Feb 2025 23:30:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="iJ5dehHn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2688880C5A; Tue, 11 Feb 2025 23:30:50 +0100 (CET)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com
 [IPv6:2607:f8b0:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B07980BAE
 for <u-boot@lists.denx.de>; Tue, 11 Feb 2025 23:30:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-21f49bd087cso83865955ad.0
 for <u-boot@lists.denx.de>; Tue, 11 Feb 2025 14:30:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1739313046; x=1739917846; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=DaJ321vURmMv2cTanBD97q5OabHGB2PAMRKcggTXfhY=;
 b=iJ5dehHnKM+kffPRvtkQ6KgxzlVtm7pOIKS28dP74CTH+KoRLQwkWSmqP3mXtiHsoZ
 VcQZjBlrY4sdp53JHWVBmKJmAUXek+teYb3SvkryB2ka2/nAvMPVl/dKYCJ0+EpxUzN7
 8Y1WwRJTzI7vaUTBE+L9Un6YoltIz+1sx7GGs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739313046; x=1739917846;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DaJ321vURmMv2cTanBD97q5OabHGB2PAMRKcggTXfhY=;
 b=HwSUQKFCFmjHDjyde7NskVr0HVi1K83OsTL+g50D14wb6TrUsgn7SmJ+VEhfBw7SQ7
 yYlkih7zKYOTfCofByfw/SyZY54HntrCanwAGxUT+RxLdfDc5gTjP7/cYuTUkZ06XiG9
 fFO3MKagXybR00EWmhoYwaagH/vCLqQyjaYpSIW4BXriJq3M7K1HmfKUtnEoYg5u5eTF
 +46RUT2C6ZQDuaVPIFDkdGz6YaDLNC3r8OhrzFHKEvP0uKma46/roEp/nvCKiPM1QUjf
 TffDJXZvDky3dVMR4+6PzfpoMR/k44Fk/rzL6JKwUWMCNG7N9rj4Rol54hcigyqGlSVg
 Y4ew==
X-Gm-Message-State: AOJu0YzfS9H2Ym3hlkHmMuYtqJwjs4k9d0kG8qFKwVXFKSP8SLza3/wF
 hXBEcQyyJQIGH7ANEVYo2XqML+/xkP5vKkEYR9RiD7Y/KhS6Eg46M3G9cZ4SV1A=
X-Gm-Gg: ASbGnctQ+XCOKUkophde5YBK8ZkQq0u+CSIWfZkpkX1UlDjwDRu7lL7nAv05ZWFbcwN
 ms/Wm57TZ3aKLEmk3PiZ8hC1QG4rkuWswRL5U7NYDw0dvizanqxmTTz7Mxs2VFhYNRjQqJ2xhLN
 zBbmyXg6DAJ+8uKnAV/DPinP41/uPDvdvgfdRWQFL5bTbOdbfrpy1Q3xywz6k+LW9IiX3KXhEVh
 m5IX2bk/+BRf/VjqeQwMEz+80TwDTn2UTz1nb2Q3NT6da40aL4hJ/xRkWuRXiXs2SXPidUNPA3J
 oLrrGmsncNR8F+g=
X-Google-Smtp-Source: AGHT+IGieFNDrg0b9yKXlEzcuIax0ec9rSCvOSBpbJDduXwTb9nlUa5j6ObusAdizncaXXwt0V895A==
X-Received: by 2002:a17:902:fc4f:b0:21f:7821:55b6 with SMTP id
 d9443c01a7336-220bbae2543mr15000425ad.13.1739313046060; 
 Tue, 11 Feb 2025 14:30:46 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21f363df2b4sm101231925ad.0.2025.02.11.14.30.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2025 14:30:45 -0800 (PST)
Date: Tue, 11 Feb 2025 16:30:42 -0600
From: Tom Rini <trini@konsulko.com>
To: Heiko Schocher <hs@denx.de>
Cc: u-boot@lists.denx.de, Raymond Mao <raymond.mao@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: Fwd: New Defects reported by Coverity Scan for Das U-Boot
Message-ID: <20250211223042.GK1233568@bill-the-cat>
References: <20250210222622.GS1233568@bill-the-cat>
 <50aac486-a3b7-7f56-b133-b28f1de0ad25@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="7NrznnD/Ei9E6CoZ"
Content-Disposition: inline
In-Reply-To: <50aac486-a3b7-7f56-b133-b28f1de0ad25@denx.de>
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


--7NrznnD/Ei9E6CoZ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 11, 2025 at 07:14:19AM +0100, Heiko Schocher wrote:
> Hello Tom,
>=20
> On 10.02.25 23:26, Tom Rini wrote:
> > Here's the latest report.
> >=20
> > ---------- Forwarded message ---------
> > From: <scan-admin@coverity.com>
> > Date: Mon, Feb 10, 2025 at 4:12=E2=80=AFPM
> > Subject: New Defects reported by Coverity Scan for Das U-Boot
> > To: <tom.rini@gmail.com>
> >=20
> >=20
> > Hi,
> >=20
> > Please find the latest report on new defect(s) introduced to Das U-Boot
> > found with Coverity Scan.
> >=20
> > 3 new defect(s) introduced to Das U-Boot found with Coverity Scan.
> >=20
> >=20
> > New defect(s) Reported-by: Coverity Scan
> > Showing 3 of 3 defect(s)
> >=20
> >=20
> > ** CID 541281:  Insecure data handling  (TAINTED_SCALAR)
> > /lib/tpm-v2.c: 77 in tpm2_scan_masks()
> >=20
> >=20
> > _______________________________________________________________________=
_________________________________
> > *** CID 541281:  Insecure data handling  (TAINTED_SCALAR)
> > /lib/tpm-v2.c: 77 in tpm2_scan_masks()
> > 71      *mask =3D 0;
> > 72
> > 73      rc =3D tpm2_get_pcr_info(dev, &pcrs);
> > 74      if (rc)
> > 75              return rc;
> > 76
> > > > >      CID 541281:  Insecure data handling  (TAINTED_SCALAR)
> > > > >      Using tainted variable "pcrs.count" as a loop boundary.
> > 77      for (i =3D 0; i < pcrs.count; i++) {
> > 78              struct tpms_pcr_selection *sel =3D &pcrs.selection[i];
> > 79              size_t j;
> > 80              u32 hash_mask =3D 0;
> > 81
> > 82              for (j =3D 0; j < ARRAY_SIZE(hash_algo_list); j++) {
> >=20
> > ** CID 541280:  Insecure data handling  (TAINTED_SCALAR)
> > /cmd/tpm-v2.c: 307 in do_tpm2_pcrallocate()
> >=20
> >=20
> > _______________________________________________________________________=
_________________________________
> > *** CID 541280:  Insecure data handling  (TAINTED_SCALAR)
> > /cmd/tpm-v2.c: 307 in do_tpm2_pcrallocate()
> > 301                      * first call
> > 302                      */
> > 303                     ret =3D tpm2_get_pcr_info(dev, &pcr);
> > 304                     if (ret)
> > 305                             return ret;
> > 306
> > > > >      CID 541280:  Insecure data handling  (TAINTED_SCALAR)
> > > > >      Using tainted variable "pcr.count" as a loop boundary.
> > 307                     for (i =3D 0; i < pcr.count; i++) {
> > 308                             struct tpms_pcr_selection *sel =3D
> > &pcr.selection[i];
> > 309                             const char *name;
> > 310
> > 311                             if (!tpm2_is_active_bank(sel))
> > 312                                     continue;
> >=20
> > ** CID 541279:    (TAINTED_SCALAR)
> > /drivers/led/led-uclass.c: 284 in led_get_function_name()
> > /drivers/led/led-uclass.c: 279 in led_get_function_name()
> >=20
> >=20
> > _______________________________________________________________________=
_________________________________
> > *** CID 541279:    (TAINTED_SCALAR)
> > /drivers/led/led-uclass.c: 284 in led_get_function_name()
> > 278                     if (!ret) {
> > 279                             snprintf(uc_plat->name, LED_MAX_NAME_SI=
ZE,
> > 280                                      "%s:%s-%d",
> > 281                                      cp ? "" : led_colors[color],
> > 282                                      func ? func : "", enumerator);
> > 283                     } else {
> > > > >      CID 541279:    (TAINTED_SCALAR)
> > > > >      Using tainted variable "color" as an index into an array
> > "led_colors".
> > 284                             snprintf(uc_plat->name, LED_MAX_NAME_SI=
ZE,
> > 285                                      "%s:%s",
> > 286                                      cp ? "" : led_colors[color],
> > 287                                      func ? func : "");
> > 288                     }
> > 289                     uc_plat->label =3D uc_plat->name;
> > /drivers/led/led-uclass.c: 279 in led_get_function_name()
> > 273             /* Now try to detect function label name */
> > 274             func =3D dev_read_string(dev, "function");
> > 275             cp =3D dev_read_u32(dev, "color", &color);
> > 276             if (cp =3D=3D 0 || func) {
> > 277                     ret =3D dev_read_u32(dev, "function-enumerator",
> > &enumerator);
> > 278                     if (!ret) {
> > > > >      CID 541279:    (TAINTED_SCALAR)
> > > > >      Using tainted variable "color" as an index into an array
> > "led_colors".
> > 279                             snprintf(uc_plat->name, LED_MAX_NAME_SI=
ZE,
> > 280                                      "%s:%s-%d",
> > 281                                      cp ? "" : led_colors[color],
> > 282                                      func ? func : "", enumerator);
> > 283                     } else {
> > 284                             snprintf(uc_plat->name, LED_MAX_NAME_SI=
ZE,
> >=20
> >=20
> > ----- End forwarded message -----
> >=20
>=20
> Just a fast idea:
>=20
> diff --git a/drivers/led/led-uclass.c b/drivers/led/led-uclass.c
> index 27ef890ed0a..fc15a0811e0 100644
> --- a/drivers/led/led-uclass.c
> +++ b/drivers/led/led-uclass.c
> @@ -273,6 +273,10 @@ static const char *led_get_function_name(struct udev=
ice *dev)
>         /* Now try to detect function label name */
>         func =3D dev_read_string(dev, "function");
>         cp =3D dev_read_u32(dev, "color", &color);
> +       // prevent coverity scan error CID 541279: (TAINTED_SCALAR)
> +       if ((color < LED_COLOR_ID_WHITE) || (color >=3D LED_COLOR_ID_MAX))
> +               cp =3D -EINVAL;
> +
>         if (cp =3D=3D 0 || func) {
>                 ret =3D dev_read_u32(dev, "function-enumerator", &enumera=
tor);
>                 if (!ret) {
>=20
> If okay, I can send a patch for this.

This is probably fine, thanks.

> Or may better, we move this check into a new function:
>=20
> int dev_read_min_max_u32(const struct udevice *dev, u32 min, u32 max, con=
st char *propname, u32 *outp)
>=20
> which returns -EINVAL, if readden value is not in [min, max] range?
>=20
> So may this function can be used at other places too?

It would be good to spend some time looking at the codebase to see what
sort of generic wrapper may or may not help first I think.

--=20
Tom

--7NrznnD/Ei9E6CoZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmerz5IACgkQFHw5/5Y0
tyzhJQv8CJCR3ZvZAFPunVVXJPSkk4BLNe6y/KhWhPSivheEyycoTyoR9SB8XQh6
QqBMmVnkY/h6gOSCZRCTWrE8YEeCoNg0uKO7IlbwX+4PJJTJqKxKnsPx1FxlVm1p
7fMizXbhYeS/uYz+UCk2O/Jr4aGYbCEc9PZdpPiA51aKHXT8AhMJXxXsSsv4eVT1
RwByuUZmkkOggJsYAL++80gjkikKfmiKNgP2YSvFRNSYDovofqKxSy+lL2RA5Qbp
Ya+dZzZI5VK7Qp3Y2aIzrB2woULsZWsyzX8fbq2s8nKYaHpGHb8yJ24sbyiMz6pp
r3Xv6go5IzqCFGlazDPZlzSEqZjJxZCIL8/RZ8P+iR6qYGFvJxNWNyff23OycNTw
janEn5sUW86vBX26gNN1mtg9zX9a6lJjNL4mVwiao3D5PKxvNlizkiHj3BQYLi1E
frhyEKrucpT+4AaqJd4wimd872dJHS0YhwJj1TABD1+puiIKlNDC8DxD2yZlrubb
iG73DIUb
=L/Jd
-----END PGP SIGNATURE-----

--7NrznnD/Ei9E6CoZ--

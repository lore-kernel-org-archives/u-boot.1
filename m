Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFA01C0219B
	for <u-boot@archiver.kernel.org>; Tue, 11 Feb 2025 22:30:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 20AC1809D0;
	Tue, 11 Feb 2025 23:30:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="fNkrN4Wy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A6BC809D0; Tue, 11 Feb 2025 23:30:44 +0100 (CET)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com
 [IPv6:2607:f8b0:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C59C580842
 for <u-boot@lists.denx.de>; Tue, 11 Feb 2025 23:30:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-21f6022c2c3so3853795ad.0
 for <u-boot@lists.denx.de>; Tue, 11 Feb 2025 14:30:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1739313040; x=1739917840; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=YiLNTVJwgq2UFMFhrpXS+SzhWL2+vinaz0e17D3CVQw=;
 b=fNkrN4WyHoXXmsFMtzQn5jNjx168NNmZ9Q+B6WOJMWnzaZLmWG7pBw8LBq+jOVBjCY
 OOFf+HfIiU9Ge1zjkpRqhGFREEUsf6YwXnyVV5VO5ijdnwGM6dKsNrWIlmnvzd2qlwQC
 SPI7yXikudwSTxub1fifM1VSH0oousbjrJhWI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739313040; x=1739917840;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YiLNTVJwgq2UFMFhrpXS+SzhWL2+vinaz0e17D3CVQw=;
 b=e0JbVZ+aO5Oso5s6ReFhpPbW/E/6D1zSIXJVTdQfUND1viNwRxNZo3vdevA2kHiP7H
 Vi4Jxae+KwREyv+uZaw7CGks5EZnUWIu0itHpudLjlCeakNla4O6xz6TYMEvGEMCngGx
 sI38LE59RpuSnJrjMYR289JqALoZKbWF6oOfCVWHO/pruvg6xDVu3KqEL02OQNWaRb2V
 VDNhgXgzyn+Fl+SHg9UQHl7Rhr8mtkUQ/8YfjmkjfHR4YdeWEmG8DMoB/L2rWCWQ/tss
 uE+Sax1FFsBoVb2WozdQnl66+V9+Qd+dINjLRkpieYE6AFNfz4TcGS4IFtlP6o/Ggu5c
 lkug==
X-Gm-Message-State: AOJu0YyMsu+YwxhhU3YaafSRwZnyEBXeBvmjSHAZWhZ8lsFXwGmTRCNC
 BkkS4MM8Yp487vVSuYKe6gJUoFn9l1TVun1b0CX07RZCHF13EWHs6augAjRx0Rg=
X-Gm-Gg: ASbGncsdtlFWJenPAgI+/aO4WmLnDsxGZYpdGOhuW8UX/8oCDRL5qf+AYoOSIfRmPVn
 orM0bsObbJ4N+WC4FxyUZE6GMqc8+60O6idn078/HAgOwtapQSVR0A4ZnN5Mvp8wzV38Q3kACZn
 R7r/Ba1PFnQ5RxUInKj0oPn8inrWoYoTkFfKrqqdr/pWHGeGAKFlOP5z97cL7hVyzu/meq14YGB
 0FvoRRhbmqB0gm8pjzjiCZK2QuB8aU3W5r/QY7555lHW7dc6rgqP9/2ZucYK+3i3iM4XnQ6+ltI
 ymK4kxnV0iWi0pw=
X-Google-Smtp-Source: AGHT+IFjKts0Jqo5v9N+pkBwTTmJ9c88NAOizm/dLmrCaH357OBDwIAoSv4kfcNWjRz5DHuRih6jMg==
X-Received: by 2002:a05:6a20:d487:b0:1e1:9e9f:ae4 with SMTP id
 adf61e73a8af0-1ee5cf3bdc6mr1287310637.13.1739313040180; 
 Tue, 11 Feb 2025 14:30:40 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-730796ba9e8sm6328551b3a.90.2025.02.11.14.30.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2025 14:30:39 -0800 (PST)
Date: Tue, 11 Feb 2025 16:30:37 -0600
From: Tom Rini <trini@konsulko.com>
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, Heiko Schocher <hs@denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: New Defects reported by Coverity Scan for Das U-Boot
Message-ID: <20250211223037.GJ1233568@bill-the-cat>
References: <20250210222622.GS1233568@bill-the-cat>
 <CAEfUkUJYMKBt3JMMe6rUxgVa5yNOdGZ74d2Ta=3w9GEyqnn8dQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="RSVEVrgsfDb/udCO"
Content-Disposition: inline
In-Reply-To: <CAEfUkUJYMKBt3JMMe6rUxgVa5yNOdGZ74d2Ta=3w9GEyqnn8dQ@mail.gmail.com>
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


--RSVEVrgsfDb/udCO
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 11, 2025 at 05:24:02PM -0500, Raymond Mao wrote:
> Hi Tom,
>=20
> On Mon, 10 Feb 2025 at 17:26, Tom Rini <trini@konsulko.com> wrote:
> >
> > Here's the latest report.
> >
> > ---------- Forwarded message ---------
> > From: <scan-admin@coverity.com>
> > Date: Mon, Feb 10, 2025 at 4:12=E2=80=AFPM
> > Subject: New Defects reported by Coverity Scan for Das U-Boot
> > To: <tom.rini@gmail.com>
> >
> >
> > Hi,
> >
> > Please find the latest report on new defect(s) introduced to Das U-Boot
> > found with Coverity Scan.
> >
> > 3 new defect(s) introduced to Das U-Boot found with Coverity Scan.
> >
> >
> > New defect(s) Reported-by: Coverity Scan
> > Showing 3 of 3 defect(s)
> >
> >
> > ** CID 541281:  Insecure data handling  (TAINTED_SCALAR)
> > /lib/tpm-v2.c: 77 in tpm2_scan_masks()
> >
> >
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
> > >>>     CID 541281:  Insecure data handling  (TAINTED_SCALAR)
> > >>>     Using tainted variable "pcrs.count" as a loop boundary.
>=20
> We don't need to check the pcrs.count here, since tpm2_get_pcr_info()
> will post an error if pcrs.count is not in a value from 1 to 4.
> This is hardcoded in tpm2_get_pcr_info(), please see below:
> ```
> /*
> * We only support 4 algorithms for now so check against that
> * instead of TPM2_NUM_PCR_BANKS
> */
> if (pcrs->count > 4 || pcrs->count < 1) {
> printf("%s: too many pcrs: %u\n", __func__, pcrs->count);
> return -EMSGSIZE;
> }
> ```
>=20
> > 77      for (i =3D 0; i < pcrs.count; i++) {
> > 78              struct tpms_pcr_selection *sel =3D &pcrs.selection[i];
> > 79              size_t j;
> > 80              u32 hash_mask =3D 0;
> > 81
> > 82              for (j =3D 0; j < ARRAY_SIZE(hash_algo_list); j++) {
> >
> > ** CID 541280:  Insecure data handling  (TAINTED_SCALAR)
> > /cmd/tpm-v2.c: 307 in do_tpm2_pcrallocate()
> >
> >
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
> > >>>     CID 541280:  Insecure data handling  (TAINTED_SCALAR)
> > >>>     Using tainted variable "pcr.count" as a loop boundary.
>=20
> Ditto.

OK, thanks!

--=20
Tom

--RSVEVrgsfDb/udCO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmerz4kACgkQFHw5/5Y0
tyzb+gwAo1SL71nny7FkzTF0jBcfF3ed9cC4OLowshUcMwMweLptQ2hmomNZ8vPR
kxT6eDP1PJ7E9jlSLTNLM8zCaC+EKg89J0vEu94EQrhbvN327vM+97qeg9gE/QN4
5hPBVrwqXo3rWrQPbIuO1h57MC9cI3MikNpDyjPm9TuRuJI2Lx3YXP/GkhmV8Rsx
qwe+TFvZ0B/OBvFAnIPkNh6GmEYyW8dnP0JkZy4fq4Org887Ss06S32Du0xim/W3
EXmAH29ARvYQI9DRLAjTKkpqrlmAecxyyZ0xBgU6nbhLCmWAV339htK7IHHotE5Z
pNXpCuAWngI8t56QDon6CKtLsZ4C1HHuuy0m1nNgfE7Yq/D7/Atqfwt1lawm27GD
zRVmG+FQoiwZNWJY+E5IVYIRZZGhlXciwXagNWa6/G6ln252omk6gxqN6v6OHDRC
+/3t2N3UxxUiXehrnkbRZ8cv0Cgj7vYBPVMwKUUDeHRSH+xmutR6Zuy4kBQEXUE6
Y0oFRhJL
=tQxL
-----END PGP SIGNATURE-----

--RSVEVrgsfDb/udCO--

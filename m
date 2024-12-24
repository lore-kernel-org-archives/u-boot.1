Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F3CBE77188
	for <u-boot@archiver.kernel.org>; Tue, 24 Dec 2024 17:21:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7CF09807DA;
	Tue, 24 Dec 2024 18:15:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="RtxHH/pD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C08E807DD; Tue, 24 Dec 2024 18:15:06 +0100 (CET)
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com
 [IPv6:2607:f8b0:4864:20::82f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 38EEA807A7
 for <u-boot@lists.denx.de>; Tue, 24 Dec 2024 18:15:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82f.google.com with SMTP id
 d75a77b69052e-467b955e288so49828281cf.1
 for <u-boot@lists.denx.de>; Tue, 24 Dec 2024 09:15:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1735060499; x=1735665299; darn=lists.denx.de;
 h=content-disposition:mime-version:message-id:subject:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=f0SzqNOgIvc3eqNiJYr9CuEKZlpDGaao42T5/m2b2Eg=;
 b=RtxHH/pD0IfQdKaPkFWKxlW+cdeCggLfod46gCETOXNyV80s/59uFguZmhgf4rqETh
 lwU2ZUnDyZXoSjmGUoqlBt63LGkmzDdy/lHXi6PwD2IBQ84Cgg74fOQAtTnVqjcdhCtv
 3B8+cE0DJQs2/YF086RirE6wyYxi0hQV9wI8I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735060499; x=1735665299;
 h=content-disposition:mime-version:message-id:subject:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=f0SzqNOgIvc3eqNiJYr9CuEKZlpDGaao42T5/m2b2Eg=;
 b=X/w6jH3e0gwBW1De+Ww7PKVZocF0Q6vK+YDJaQPeasfHEsNX0DyO/c6J6TT6zyAspM
 lODuBj1ds7ITcYOjUzGuZPCeusdeNSrwNL7yDMA2oJxWoVxwqmNlQMrzKSUTFlwxuBt5
 3dZAL40GujCMoBkZczrnHHgmr8KFhY/sq4oZ+4BwFVn9AlwQMpru+LtWaROJTJVPrRo7
 Zpi0nZLPJ0xkcPcNhFsRAqLi6WI5BXoADQGXHEsbAc/0KSsl66e1JHjeqHEzbollh89/
 Yq3/09yEXRUoXbNDkrkJJvx14ntxaM2D65x1tFX7KLADPJ4J669dnS++v+0dpPfwxEs+
 kFQQ==
X-Gm-Message-State: AOJu0YxvgNwsHqep40t0ihVf6NHXZ5iSBZTZkRgqXrkNGKneDsS+ZAoo
 dKV4/EvWRdcz5hW6wf0W2t35KMKA4jUmvrt4FJo8btAVwWFFon6HReTXrUcGRaY//jFbTAoxdAC
 r
X-Gm-Gg: ASbGncuQ+CosiOMQ6lC+RfFm7V4MuduQ4nC9dMi9Xov5ZFIdEroX8e9lB/ymOIz3HGM
 xxH5HiKSGW+VuKUJiaU1ZvIS6YNaXIAQyLw1SKrLkneDaiVti2SsafSFu5y+ibKSPox7juOwuXB
 nxMCrFAYUtK0cxGTnb19g+dtbLbGGeqZy/tBEhD4EJgf7HiQb6m2k3ueo6fPlPF2HFORBXkuE8j
 HoDjH45bnLWcGBWb+cmHy70NUGwZBgUGiy1f1RQ9py8S018VoUlMP7saw==
X-Google-Smtp-Source: AGHT+IEajboLzzRLlps79THjwguy8Yp2u/vvsNF6YF3WN/HqlSy/1HRpJG7EhFDkYYSrAv9HMXxXMw==
X-Received: by 2002:ac8:7f51:0:b0:467:86f0:8e63 with SMTP id
 d75a77b69052e-46a4a8b5f7dmr273945911cf.7.1735060499000; 
 Tue, 24 Dec 2024 09:14:59 -0800 (PST)
Received: from bill-the-cat ([189.178.122.190])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46a3e64b845sm55248771cf.6.2024.12.24.09.14.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Dec 2024 09:14:58 -0800 (PST)
Date: Tue, 24 Dec 2024 11:14:55 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Nicolas Belin <nbelin@baylibre.com>
Subject: Fwd: New Defects reported by Coverity Scan for Das U-Boot
Message-ID: <20241224171455.GV1505244@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="qDUQ9ZldqCtLiiVb"
Content-Disposition: inline
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


--qDUQ9ZldqCtLiiVb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey all,

Unfortunately Coverity went a bit weird for a bit and stopped doing
emails, so there's a few other defects missing from this.

---------- Forwarded message ---------
=46rom: <scan-admin@coverity.com>
Date: Tue, Dec 24, 2024 at 11:05=E2=80=AFAM
Subject: New Defects reported by Coverity Scan for Das U-Boot
To: <tom.rini@gmail.com>


Hi,

Please find the latest report on new defect(s) introduced to Das U-Boot
found with Coverity Scan.

1 new defect(s) introduced to Das U-Boot found with Coverity Scan.


New defect(s) Reported-by: Coverity Scan
Showing 1 of 1 defect(s)


** CID 516463:  Null pointer dereferences  (FORWARD_NULL)
/boot/image-android.c: 300 in android_image_get_kernel()


___________________________________________________________________________=
_____________________________
*** CID 516463:  Null pointer dereferences  (FORWARD_NULL)
/boot/image-android.c: 300 in android_image_get_kernel()
294
295             if (*img_data.kcmdline) {
296                     printf("Kernel command line: %s\n",
img_data.kcmdline);
297                     len +=3D strlen(img_data.kcmdline) + (len ? 1 : 0);
/* +1 for extra space */
298             }
299
>>>     CID 516463:  Null pointer dereferences  (FORWARD_NULL)
>>>     Dereferencing null pointer "img_data.kcmdline_extra".
300             if (*img_data.kcmdline_extra) {
301                     printf("Kernel extra command line: %s\n",
img_data.kcmdline_extra);
302                     len +=3D strlen(img_data.kcmdline_extra) + (len ? 1=
 :
0); /* +1 for extra space */
303             }
304
305             char *newbootargs =3D malloc(len + 1); /* +1 for the '\0' */


----- End forwarded message -----

--=20
Tom

--qDUQ9ZldqCtLiiVb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdq7AcACgkQFHw5/5Y0
tyw3mwwAo5IUv750eU1NV3GZJ+YnDnhf6mxeaQIXQzOP1qI2wBU9VL9VANiNEWby
wxMqj/93Dql6VP54yDrGwNziBeF/UWwFsekOrk39Hv11mCXKTA0E99uY8Q/2GEbC
JRh7VyVbvSyHQfxCasnQAW93vF8J79x3vkVgSV6S8/n73ZqL58+Gk/v+tPsWjBrr
YWj9Fu9JbLowJY/sBhE1cTcl/Z0cWQu6dj0GVDHcVgeMkYq3R4wXZuU4RaGdwyw1
G3Ija1pnlcSzrTVOqZYjx3zkYJkPXBO1BNP9tS0TW1uAxGazShGWY+fQYXFAQ+f8
+/vsOwS3mj0y1U8/qYCVCBJoBrFI3sorXUFQxcM9HKAOKjWO/Ne84RipUqm8/AMj
L993wdBzelIlcJGSTPEtRV3Qs0QIYN9x0/gLNWH1hWX72w7jCTMudqQ3ttzHsZpy
mZhk0EjQjgwhZv4Uj5XWjVyRHT9knD+RvTryzh6CXHYxJ1+S+FL2M573d/MWCsNx
x1rEVrOQ
=7oh6
-----END PGP SIGNATURE-----

--qDUQ9ZldqCtLiiVb--

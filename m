Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01703C02198
	for <u-boot@archiver.kernel.org>; Mon, 10 Feb 2025 22:26:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D283C805D7;
	Mon, 10 Feb 2025 23:26:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="CC8qwh7A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 23F75805E7; Mon, 10 Feb 2025 23:26:29 +0100 (CET)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com
 [IPv6:2607:f8b0:4864:20::1130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E5D748043C
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 23:26:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-6f7440444efso40585637b3.2
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 14:26:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1739226386; x=1739831186; darn=lists.denx.de;
 h=content-disposition:mime-version:message-id:subject:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YagNiSB6VL5fAkPlpY/PuZBhq/DnHdxvIJqTcN1mUcg=;
 b=CC8qwh7AKKv/IL4CzgbRtYDQgw2xE2AUQg3p5KFNkCVNeVHWa4EKh5Jtj288+/T0Ar
 /ulCbYTSPq+qMio0BFLMKNdyLHT2BV9R/I2tj4B6XtguRzIrOXfp1bMjyzKdpUvfBPCo
 u1SYvoi1+47BjTmLRXQq7Ob7mn738CZqDJSS0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739226386; x=1739831186;
 h=content-disposition:mime-version:message-id:subject:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YagNiSB6VL5fAkPlpY/PuZBhq/DnHdxvIJqTcN1mUcg=;
 b=SDq7eBqgrLFL/RUuF9nZEWSrog3cRt5Bfj1yf+UMyBHjZUEztiu10R5HO0hDG39znu
 R+jxLsFBBVUMkbkb9YY0nd/n57K+qcXNzal9eLxU/rhOpl6vhFMTijkgjxs1qQkES3H8
 3Pvx5xtuPR/wey1mm3Sq9oukX9zOA5k0TajwPIWU4OXQPia1RMbgnAWEAZb5CB61BMxN
 JxtaFkiFXGmarsFdM41KlKB8YjTvZvbl0qjoX7IJLo7AaG+eo4uFTUvu2Y+8Tsyzm6l4
 s9gP/KJ67tyRrFEzuL8SjitxmwY4NFoWr6fVqguy9vdbc+Dd6m3rVZLJw90b4DszsPPo
 SCQQ==
X-Gm-Message-State: AOJu0Yz16DjWODMUBZ1muCMhrmG8qQutbDSR1w5TqV5Kb9mAZkIsvFY/
 aqF4PSAYbQJoPpzZjJzBu3R0LQvPiJuYs7IRD9jG6cDQwknVXYmXsJQefn74bpuWH9QFmYF6+G5
 v
X-Gm-Gg: ASbGncuyIJNt7wbjP3V6ygV5gf+zV1hw1Wn3EU94I6wG1isbkVb0THt7Ukq7aOe5Gsb
 JE6JDmedFnuaPbKIlQQOTm7keA4s93XU9gp6SR3fZc/sR1YfYMgNtq701+eQxYB/p1b1g2utX1N
 589kLnLA3rHmocG4OpvXeuBtVUFWSA3kVuCfAvPsbZkPGaUtA1ziXQlFFupEJEQ88G/Zw3WTrB8
 2WSTc47JArn+a6IZ/Qbd9UA00xWSmOGm5WER6iJ8VMw7b6OVneGHUF/QHtiJqunyJqVKC/OM2+F
 USgNoctfLI9pfzQ=
X-Google-Smtp-Source: AGHT+IH5AmsheJWWONOQ0DDRdNOys01rpigZJxXjGnhCcnCeLAhZSdlYCCq9Q6tcPY7T3nsq/lMVog==
X-Received: by 2002:a05:690c:c08:b0:6f6:ca9a:e9da with SMTP id
 00721157ae682-6f9b27e86fbmr119582997b3.4.1739226385756; 
 Mon, 10 Feb 2025 14:26:25 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-6f99ff6a2a0sm18787137b3.89.2025.02.10.14.26.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Feb 2025 14:26:25 -0800 (PST)
Date: Mon, 10 Feb 2025 16:26:22 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Heiko Schocher <hs@denx.de>,
 Raymond Mao <raymond.mao@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Fwd: New Defects reported by Coverity Scan for Das U-Boot
Message-ID: <20250210222622.GS1233568@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="DsrCwhwx2WqlLilE"
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


--DsrCwhwx2WqlLilE
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Here's the latest report.

---------- Forwarded message ---------
=46rom: <scan-admin@coverity.com>
Date: Mon, Feb 10, 2025 at 4:12=E2=80=AFPM
Subject: New Defects reported by Coverity Scan for Das U-Boot
To: <tom.rini@gmail.com>


Hi,

Please find the latest report on new defect(s) introduced to Das U-Boot
found with Coverity Scan.

3 new defect(s) introduced to Das U-Boot found with Coverity Scan.


New defect(s) Reported-by: Coverity Scan
Showing 3 of 3 defect(s)


** CID 541281:  Insecure data handling  (TAINTED_SCALAR)
/lib/tpm-v2.c: 77 in tpm2_scan_masks()


___________________________________________________________________________=
_____________________________
*** CID 541281:  Insecure data handling  (TAINTED_SCALAR)
/lib/tpm-v2.c: 77 in tpm2_scan_masks()
71      *mask =3D 0;
72
73      rc =3D tpm2_get_pcr_info(dev, &pcrs);
74      if (rc)
75              return rc;
76
>>>     CID 541281:  Insecure data handling  (TAINTED_SCALAR)
>>>     Using tainted variable "pcrs.count" as a loop boundary.
77      for (i =3D 0; i < pcrs.count; i++) {
78              struct tpms_pcr_selection *sel =3D &pcrs.selection[i];
79              size_t j;
80              u32 hash_mask =3D 0;
81
82              for (j =3D 0; j < ARRAY_SIZE(hash_algo_list); j++) {

** CID 541280:  Insecure data handling  (TAINTED_SCALAR)
/cmd/tpm-v2.c: 307 in do_tpm2_pcrallocate()


___________________________________________________________________________=
_____________________________
*** CID 541280:  Insecure data handling  (TAINTED_SCALAR)
/cmd/tpm-v2.c: 307 in do_tpm2_pcrallocate()
301                      * first call
302                      */
303                     ret =3D tpm2_get_pcr_info(dev, &pcr);
304                     if (ret)
305                             return ret;
306
>>>     CID 541280:  Insecure data handling  (TAINTED_SCALAR)
>>>     Using tainted variable "pcr.count" as a loop boundary.
307                     for (i =3D 0; i < pcr.count; i++) {
308                             struct tpms_pcr_selection *sel =3D
&pcr.selection[i];
309                             const char *name;
310
311                             if (!tpm2_is_active_bank(sel))
312                                     continue;

** CID 541279:    (TAINTED_SCALAR)
/drivers/led/led-uclass.c: 284 in led_get_function_name()
/drivers/led/led-uclass.c: 279 in led_get_function_name()


___________________________________________________________________________=
_____________________________
*** CID 541279:    (TAINTED_SCALAR)
/drivers/led/led-uclass.c: 284 in led_get_function_name()
278                     if (!ret) {
279                             snprintf(uc_plat->name, LED_MAX_NAME_SIZE,
280                                      "%s:%s-%d",
281                                      cp ? "" : led_colors[color],
282                                      func ? func : "", enumerator);
283                     } else {
>>>     CID 541279:    (TAINTED_SCALAR)
>>>     Using tainted variable "color" as an index into an array
"led_colors".
284                             snprintf(uc_plat->name, LED_MAX_NAME_SIZE,
285                                      "%s:%s",
286                                      cp ? "" : led_colors[color],
287                                      func ? func : "");
288                     }
289                     uc_plat->label =3D uc_plat->name;
/drivers/led/led-uclass.c: 279 in led_get_function_name()
273             /* Now try to detect function label name */
274             func =3D dev_read_string(dev, "function");
275             cp =3D dev_read_u32(dev, "color", &color);
276             if (cp =3D=3D 0 || func) {
277                     ret =3D dev_read_u32(dev, "function-enumerator",
&enumerator);
278                     if (!ret) {
>>>     CID 541279:    (TAINTED_SCALAR)
>>>     Using tainted variable "color" as an index into an array
"led_colors".
279                             snprintf(uc_plat->name, LED_MAX_NAME_SIZE,
280                                      "%s:%s-%d",
281                                      cp ? "" : led_colors[color],
282                                      func ? func : "", enumerator);
283                     } else {
284                             snprintf(uc_plat->name, LED_MAX_NAME_SIZE,


----- End forwarded message -----

--=20
Tom

--DsrCwhwx2WqlLilE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeqfQMACgkQFHw5/5Y0
tyz6bAv+OGMLosytoNPCPDUjEkFK5a2+DO83YjPZNUdfZIvNQ4WUPHVDLpZ8daUq
HrTUvjvatnHQwonxhRYzRylkWbzP9h6LHpp0+keXq3OS1jRJn5xviFcQVkWRbTc4
ExdVX8Qm4yOdd8zrfzEaZfqsfrPhVLttRxIuOdbOV43/IAPBZ0fVGz7xVaw0kBvg
5OC7A3oRF0lrGjhW10z0GEda+7bJNbRJ7FxiR3aTTrdsAJNnrzbgmUsgxMvtrCyD
D64HkdHLblIzR/gmxNXf73WiNOySkrPaTstmBg4O10fqmQCsenBf5d0KtXYEFVtr
j0CMqLlZuxg96habitJgEHHuJKyc9ome4SR2fG0SjpAOtYo6l+JADPErUlfwI7Z2
w2EYjdgQXot/w9xd9qiZ3c9s57O9gl6Kv5HLBCbAjaA4jDZe1gx7gGOLEBJoaZIh
CykrsT3hw4x8pt5HfSwfNVev9SI1dk/72/XwjjNZuFpgevJr0eK+xB0NtPrTKLAC
pDKeDyLm
=D8OV
-----END PGP SIGNATURE-----

--DsrCwhwx2WqlLilE--

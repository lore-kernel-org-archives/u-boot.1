Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEEFFC0219B
	for <u-boot@archiver.kernel.org>; Tue, 11 Feb 2025 22:24:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA735809D0;
	Tue, 11 Feb 2025 23:24:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="rz5c9dzp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1AE7780A55; Tue, 11 Feb 2025 23:24:18 +0100 (CET)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A001980842
 for <u-boot@lists.denx.de>; Tue, 11 Feb 2025 23:24:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-21f5660c2fdso88232845ad.2
 for <u-boot@lists.denx.de>; Tue, 11 Feb 2025 14:24:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739312654; x=1739917454; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B5Szam8WgaVh+jYEBd/CrkhgLYQafV6QgIYJwTHJz4w=;
 b=rz5c9dzpxvSMAmQE7i8M3uypgel7cxxvyUBYSf2aQatJaitzUi1/R1g8cp960MdLMp
 ypaPLwiN+k/rXyDsgCSoETO/Eq2PlVJxEnbh9auHHDiSWfA22OpheBE8kikjcZQdtAWV
 oiHCNRmW6NyuBazyAXrf1yb0LHDp9cs2hdT6WWDahnuhXhyxqFEdEkvI1E6K5p292F7T
 BL5d3spDI5Jv14e5y+c5OKLbItbEbw029XGj+sg6BCPvKC0uYYQx8MngaiDg/SSeILD8
 HsEDeO3jzGYmZ7l8uiTk4AJgdxGjOe7YKSoedYFO4efUihWVlfeB81JS/anAWMSVZdyP
 Lqgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739312654; x=1739917454;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B5Szam8WgaVh+jYEBd/CrkhgLYQafV6QgIYJwTHJz4w=;
 b=BZpULvMv4PR8flji63Pah9vajNMr9ZoOg3XD/Hs4tpHkK9T0VfUfsMsNYPZRDe8NeA
 LHfW0/zMtut+blCxQ3+mvXf76qejxCzW43Hn3EJo5vDTv1KQNXk8hQquXvnGNEt7XvH0
 n+zxDytrK8nLktIpL+V+fQmEI1sNDeRclYAt2wwrcETy0MqaqUG8ubbf2qWVQP0OmLpm
 EOrLfkRErNsOh0uUYEd/kAwFcZRCWEJu+YzJKKiW5Z5AEYe5QhBu3FiUk2pmT6YX9cmC
 QVSbIPzQyreKWVSo5UjuIKoWNOjSWqCA96Yrckr6r5w/SwUKNOJM2Bvh7+5K56fI0Use
 PA8w==
X-Gm-Message-State: AOJu0YzYNuJjL+SYTuBqC05InICSmD6ysYz+wg8WAFwBQbODjq7NCxJk
 jGWmTmKkOMw8+3edb9Qep6Wl25gWDeXUlbLP51RgTLgmlS5llKjpyMyOM1X7KQlM5h9fx0qKwsJ
 pDjwyrgWNn7KIiN0cq9Cgur2GkmMNmMMOU6eA8Q==
X-Gm-Gg: ASbGncsB5UW89ZpRR0lnTDWrIhWO+D/HlYQo95ozY0bgjl1gEDJKnVncGDCkSuuKTOM
 uj4iOEE+RMEloH324tAHqVq4S3oyNWlHqZvxorkQMsOjFDmNs/zwAKC73d6IHY+42JDOaACOIWX
 lEHUOvw2BZZfxkpDh6pil/WNbkpjQWwA==
X-Google-Smtp-Source: AGHT+IGPQzLGq3NB+IWtlf4Xuy5bAYZC07CX5JJMzjnzT3CE9TqG4pHUuXQP8dJGKYnFY5rReA7NEk0pGHLdBnrMa08=
X-Received: by 2002:a17:902:fc86:b0:21f:2ded:76ea with SMTP id
 d9443c01a7336-220bbcae651mr19191485ad.36.1739312654112; Tue, 11 Feb 2025
 14:24:14 -0800 (PST)
MIME-Version: 1.0
References: <20250210222622.GS1233568@bill-the-cat>
In-Reply-To: <20250210222622.GS1233568@bill-the-cat>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Tue, 11 Feb 2025 17:24:02 -0500
X-Gm-Features: AWEUYZmaRg5-FyQn3G-yyM0vJA3iOCrVfZTjM2N9xgSX5OpPhf4oii63ztvfD_s
Message-ID: <CAEfUkUJYMKBt3JMMe6rUxgVa5yNOdGZ74d2Ta=3w9GEyqnn8dQ@mail.gmail.com>
Subject: Re: New Defects reported by Coverity Scan for Das U-Boot
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Heiko Schocher <hs@denx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
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

Hi Tom,

On Mon, 10 Feb 2025 at 17:26, Tom Rini <trini@konsulko.com> wrote:
>
> Here's the latest report.
>
> ---------- Forwarded message ---------
> From: <scan-admin@coverity.com>
> Date: Mon, Feb 10, 2025 at 4:12=E2=80=AFPM
> Subject: New Defects reported by Coverity Scan for Das U-Boot
> To: <tom.rini@gmail.com>
>
>
> Hi,
>
> Please find the latest report on new defect(s) introduced to Das U-Boot
> found with Coverity Scan.
>
> 3 new defect(s) introduced to Das U-Boot found with Coverity Scan.
>
>
> New defect(s) Reported-by: Coverity Scan
> Showing 3 of 3 defect(s)
>
>
> ** CID 541281:  Insecure data handling  (TAINTED_SCALAR)
> /lib/tpm-v2.c: 77 in tpm2_scan_masks()
>
>
> _________________________________________________________________________=
_______________________________
> *** CID 541281:  Insecure data handling  (TAINTED_SCALAR)
> /lib/tpm-v2.c: 77 in tpm2_scan_masks()
> 71      *mask =3D 0;
> 72
> 73      rc =3D tpm2_get_pcr_info(dev, &pcrs);
> 74      if (rc)
> 75              return rc;
> 76
> >>>     CID 541281:  Insecure data handling  (TAINTED_SCALAR)
> >>>     Using tainted variable "pcrs.count" as a loop boundary.

We don't need to check the pcrs.count here, since tpm2_get_pcr_info()
will post an error if pcrs.count is not in a value from 1 to 4.
This is hardcoded in tpm2_get_pcr_info(), please see below:
```
/*
* We only support 4 algorithms for now so check against that
* instead of TPM2_NUM_PCR_BANKS
*/
if (pcrs->count > 4 || pcrs->count < 1) {
printf("%s: too many pcrs: %u\n", __func__, pcrs->count);
return -EMSGSIZE;
}
```

> 77      for (i =3D 0; i < pcrs.count; i++) {
> 78              struct tpms_pcr_selection *sel =3D &pcrs.selection[i];
> 79              size_t j;
> 80              u32 hash_mask =3D 0;
> 81
> 82              for (j =3D 0; j < ARRAY_SIZE(hash_algo_list); j++) {
>
> ** CID 541280:  Insecure data handling  (TAINTED_SCALAR)
> /cmd/tpm-v2.c: 307 in do_tpm2_pcrallocate()
>
>
> _________________________________________________________________________=
_______________________________
> *** CID 541280:  Insecure data handling  (TAINTED_SCALAR)
> /cmd/tpm-v2.c: 307 in do_tpm2_pcrallocate()
> 301                      * first call
> 302                      */
> 303                     ret =3D tpm2_get_pcr_info(dev, &pcr);
> 304                     if (ret)
> 305                             return ret;
> 306
> >>>     CID 541280:  Insecure data handling  (TAINTED_SCALAR)
> >>>     Using tainted variable "pcr.count" as a loop boundary.

Ditto.

Regards,
Raymond

> 307                     for (i =3D 0; i < pcr.count; i++) {
> 308                             struct tpms_pcr_selection *sel =3D
> &pcr.selection[i];
> 309                             const char *name;
> 310
> 311                             if (!tpm2_is_active_bank(sel))
> 312                                     continue;
>
> ** CID 541279:    (TAINTED_SCALAR)
> /drivers/led/led-uclass.c: 284 in led_get_function_name()
> /drivers/led/led-uclass.c: 279 in led_get_function_name()
>
>
> _________________________________________________________________________=
_______________________________
> *** CID 541279:    (TAINTED_SCALAR)
> /drivers/led/led-uclass.c: 284 in led_get_function_name()
> 278                     if (!ret) {
> 279                             snprintf(uc_plat->name, LED_MAX_NAME_SIZE=
,
> 280                                      "%s:%s-%d",
> 281                                      cp ? "" : led_colors[color],
> 282                                      func ? func : "", enumerator);
> 283                     } else {
> >>>     CID 541279:    (TAINTED_SCALAR)
> >>>     Using tainted variable "color" as an index into an array
> "led_colors".
> 284                             snprintf(uc_plat->name, LED_MAX_NAME_SIZE=
,
> 285                                      "%s:%s",
> 286                                      cp ? "" : led_colors[color],
> 287                                      func ? func : "");
> 288                     }
> 289                     uc_plat->label =3D uc_plat->name;
> /drivers/led/led-uclass.c: 279 in led_get_function_name()
> 273             /* Now try to detect function label name */
> 274             func =3D dev_read_string(dev, "function");
> 275             cp =3D dev_read_u32(dev, "color", &color);
> 276             if (cp =3D=3D 0 || func) {
> 277                     ret =3D dev_read_u32(dev, "function-enumerator",
> &enumerator);
> 278                     if (!ret) {
> >>>     CID 541279:    (TAINTED_SCALAR)
> >>>     Using tainted variable "color" as an index into an array
> "led_colors".
> 279                             snprintf(uc_plat->name, LED_MAX_NAME_SIZE=
,
> 280                                      "%s:%s-%d",
> 281                                      cp ? "" : led_colors[color],
> 282                                      func ? func : "", enumerator);
> 283                     } else {
> 284                             snprintf(uc_plat->name, LED_MAX_NAME_SIZE=
,
>
>
> ----- End forwarded message -----
>
> --
> Tom

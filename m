Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3148E10F6FDB
	for <u-boot@archiver.kernel.org>; Wed,  1 Apr 2026 22:12:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A84F683CE3;
	Thu,  2 Apr 2026 00:12:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="lRGaRM6L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5D29183CE3; Thu,  2 Apr 2026 00:12:22 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5D13680517
 for <u-boot@lists.denx.de>; Thu,  2 Apr 2026 00:12:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-b982b0889d8so28967666b.2
 for <u-boot@lists.denx.de>; Wed, 01 Apr 2026 15:12:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775081540; cv=none;
 d=google.com; s=arc-20240605;
 b=GSJe84kycOap6ijzlSXEpZwMj2KJPn0SgvUEzSlA5tCzZ0W1sLosoRUIrU1rQTBfSE
 i/0XiwNUF+FNbgzTyFgf44uRTo+krP1AoOj/sqmtGzuTFIXD89CUGFCLJrb6vPG2RvdP
 q8UUXA6+OF8pnGF9TSkNRyNHzH913ZtzNOPOxZwwMiM9Qs3IhIhZ/bjgyW2fbEqsyNsD
 NIDsY8xBcRDk0TDSBOVBcGzLGxkNmsLBpF/kyj9q+r7gNrMBtuXyIkHvk5OVLrcj60pL
 YuH5oeZ4PhhOA+j/69oQm5g4TjjTFP+oE1YZjQcq9SmZQq7ZIyMgazmJtlpzZVBuc0UD
 Odqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=1OiTDql8T5Taqh51hUruz6sTFfTcoN11PzWK1IRBbWA=;
 fh=6EAtsUOOpZmiFHGTKS74hrkuA05NvCESXCa86IGBRhg=;
 b=Bx+NND9mbvjxc7UVFnNwW/Ii3r3iOuq6cZKM15pjiwSLMQZXQ28RP5lAKmlJrZed/R
 9BOXcvmNkN8RXtcp7TrWo5r0cVKLHsZIWjUMnZ6VHlIdKFJUUhfJc49BAFcWmvgRpx3S
 7QXbxTIX1nEtbiXoQigVcNEaiv57hmeYeiBD8nkC4QtIueYpHfYJlo5q02XBDfUsghsp
 pKZW18z5Rkk91rQdsA9zJInm4EjWZoDohzNbjik07Jl4mDmlBHCn1XQJ4y7iy3R4ZXh8
 K9JA5NkS36+9DLEAe8qbGOEJo3HG/vsu6PUu8YE0FKc7pAYim8idnIur7AjgMdKYEbl8
 p7VQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1775081540; x=1775686340; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1OiTDql8T5Taqh51hUruz6sTFfTcoN11PzWK1IRBbWA=;
 b=lRGaRM6LS1ncFUy1blyZyocxKIPY7KGCBckIQaCNb14GVGdR+hNOWFdKScGnIrwaJt
 tfR0IqjexSd6YVXXvvviWqbceVxc3EUUi/xkaqTDeaCnY3+J5YpFo8bYajLp7dRG3X2f
 tN/2kdE03YAqTg5/vsyv3s28pg5FRpyNCs9ZI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775081540; x=1775686340;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1OiTDql8T5Taqh51hUruz6sTFfTcoN11PzWK1IRBbWA=;
 b=PI/iWHx2YOeLmJN5LLS1NuL1RGSoAPd+DBg6+nVqPiTR4wBdV8jMDJRcKTPLabJeFk
 x+kqyGQ5uBw9c9xsJl2T/y++602DLQPgwHD6t/e6sROV35hfamX8ENv5a53yGmJEfG/v
 gNv+Kj80mXlN4A7xYJCdy39P9XNvDwK+xp257+u+lNbYhyLjupYx9bRfBKloTL4AiRzW
 ZzBo9eer25pnW/cB5yVJGdgjbtXpqaImIUADe0sMuA/szf2aju2S9ue6V4+NbYb/tpKT
 MgUwBo3DEZiLzUDDGcXhtOzYtVMiByf/1Pd9CQDWufAR1+BD9T8+KuJiYVWE+zsyW8EI
 Uokw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWQ9b9TqwDflGj8u6AQBVsNvamOUuGiEKlM8pNPsyoE1Kp4S2WG+bxiJrg8PKW9Xfo5E8uXTXo=@lists.denx.de
X-Gm-Message-State: AOJu0Yz0bMZyu44z+0ZYt+gNxYOBbfxw+/5Alb5H1cK5bz4W+JyKCRnS
 hBPrLu+FTkbbmVbuSrsy/9RauDTl56A+5BQnYNfhMYoC6WU9g1muyjd4HedZUPvr/f7W4AHkiY4
 0WPWclq0L7f6uUKqOOdFNH6BURc/jF76JNPCppDXr
X-Gm-Gg: ATEYQzzLDKbdPo5xmUvKs0FS2gL5s4F9Joxh3qCMem/dvJOkuWQIQXvtAZAw9ljLltu
 iilKL+dXwmWz+FSO+lJxC0lDNW57/NIsSwZF6IX3aATTvGjPE3Ctu+O6MBFv/iJ/UmmjxyeLSgI
 H74NfqIb2cLP+fyW1G1OiVFxsesgap3mnthBLQ5ewCYmsiEEn5bpNZz5MCcAyydPET03mg8OKTr
 Ty6Iu049z6Lv0jL9k+qep+BSgDAnqNio1/kTlyA8NshTY1LsQ+j8WAAQoTUoAeFIYVeuPaVBGm+
 wKdn1g==
X-Received: by 2002:a17:906:48da:b0:b98:411a:116f with SMTP id
 a640c23a62f3a-b9c137a7fa5mr293136466b.2.1775081539789; Wed, 01 Apr 2026
 15:12:19 -0700 (PDT)
MIME-Version: 1.0
References: <20260331100047.34618-1-philippe.reynes@softathome.com>
 <20260331100047.34618-10-philippe.reynes@softathome.com>
In-Reply-To: <20260331100047.34618-10-philippe.reynes@softathome.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 1 Apr 2026 18:12:04 -0400
X-Gm-Features: AQROBzBT5ZxA6Jd0Qg-NONPwvXMHOhj5DY0Q08rCHW8ngj4T2_v9YAGaiBobR5k
Message-ID: <CAFLszTh2pRCwiupRD+qDY0HzvuoJGYOX0fBha-mh3=KNaQB7jQ@mail.gmail.com>
Subject: Re: [v3,09/15] tools: mkimage: pre-load: add support of ecdsa
To: philippe.reynes@softathome.com
Cc: marko.makela@iki.fi, jonny.green@keytechinc.com, raymondmaoca@gmail.com, 
 trini@konsulko.com, simon.glass@canonical.com, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

Hi Philippe,

On 2026-03-31T10:00:34, Philippe Reynes <philippe.reynes@softathome.com> wrote:
> diff --git a/tools/image-host.c b/tools/image-host.c
> @@ -1244,13 +1245,62 @@ err_cert:
> +static int fit_pre_load_data_key_ecdsa(const char *keydir, void *keydest,
> +                                    int pre_load_noffset, const void *key_name,
> +                                    const void *algo_name)
> +{
> +     struct image_sign_info info;
> +     int keynode;
> +
> +     memset(&info, 0, sizeof(info));
> +     info.keydir = keydir;
> +     info.keyname = strdup(key_name);
> +     info.name = strdup(algo_name);

Memory is allocated via strdup() for info.keyname and info.name but
never freed - please free these before returning.

> diff --git a/tools/image-host.c b/tools/image-host.c
> @@ -1244,13 +1245,62 @@ err_cert:
> +static int fit_pre_load_data_key_ecdsa(const char *keydir, void *keydest,
> +                                    int pre_load_noffset, const void *key_name,

The pre_load_noffset parameter is passed in but not used - the
function re-calculates the same offset itself.

> diff --git a/tools/image-host.c b/tools/image-host.c
> @@ -1244,13 +1245,62 @@ err_cert:
> +     info.required_keynode = keynode;
> +
> +     ecdsa_add_verify_data(&info, keydest);
> +
> +     return 0;

The return value of ecdsa_add_verify_data() is not checked. If it
fails, the error is silently ignored. Please can you check the return
value and propagate any error.

> diff --git a/tools/image-host.c b/tools/image-host.c
> @@ -1277,17 +1327,21 @@ int fit_pre_load_data(const char *keydir, void *keydest, void *fit)
> +     /* Is it a RSA or an ECDSA key */
> +     name = strchr((const char *)algo_name, ',');
> +     if (!name)
> +             return -EINVAL;

This should use 'goto out' rather than direct return to be consistent
with the other error paths in this function.

Regards,
Simon

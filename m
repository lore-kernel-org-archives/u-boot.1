Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCA9BEA71B5
	for <u-boot@archiver.kernel.org>; Mon, 20 Apr 2026 02:11:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F7688419E;
	Mon, 20 Apr 2026 04:11:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="FKUD/0XA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2DD6C82BF2; Mon, 20 Apr 2026 04:11:44 +0200 (CEST)
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com
 [IPv6:2607:f8b0:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB31C82BF2
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 04:11:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-82f351ca23cso1116481b3a.2
 for <u-boot@lists.denx.de>; Sun, 19 Apr 2026 19:11:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776651100; cv=none;
 d=google.com; s=arc-20240605;
 b=RPpeBPH6PrEqkJBu4XF70xjSQFPgE4AaJsx22a+5ZAxsT/ORnY0zy40TCer/Ad+vVW
 EmvtCE6tZLeRw/Wz6boOxazQemWLzdhWtjbwrmhiFVrcHFBPygafQ3L1zac5HPKBnBMP
 4OU6oGjZUQZixgsQfq+w63TGMcItWM/c9rxRdkGsbwiEVl9pefKp8X0B1V7o5rXYBsdS
 yRBS+bhb/AMx3z1fD12GjTOFW49lsFc4FBCz925OWRXsAe2E3bbT10JICuRxX0q1MXNU
 1KZF88pUzEfVQiASG7MN7/RQdYpzHsWX8UplERinrkybohpJ5Xr59lWBVjaOmK2fGtcK
 uXeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=zJxLCUZjfbzLZDERefk8Su5xijL+PR2gcUceA2H0W7k=;
 fh=/zdyLayrje+NlQCHW/wcoE4at6j2IwcM7dkIsMB87vM=;
 b=hvI4xEYCNiWIkwezESNp3WBe/11ggdzqPKCUS7rW1f6s2X3hNHDprl6IqsR7hJcBv+
 Brq4Ji2fBPHQ9bYpEXdHJoRi1ZHz5QxsURn1PBKEPObOsUEU0PclPY4bVmQCBX/BjMKf
 KWeMg3rvgXUWr8ONhfcbcgtTQlWmNZUqyqbAOK2sYWPFTAFmfN5mKrdvqKsfuLImCqL1
 2anv0nKV/jJEzAUd341ANa+F3cFarjZScMWlzr4vh0Rl6kY0iudOUrEf8LkR85U+A+TT
 xss/o79Ihswn4NxG4HwY8wIJHPCsOqYXo6J9ziE9Sz5xOG249ViCHoxjMxvoR7l0iQMM
 0I5A==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776651100; x=1777255900; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zJxLCUZjfbzLZDERefk8Su5xijL+PR2gcUceA2H0W7k=;
 b=FKUD/0XA0+mzUR1x56i8lbIidxfwcLLS8B/farAOwEgotH432UkFmp1x+zyJMSFHW2
 /ZS3UFKQoQzpy+B6oymhlsRROq4v96+F2Sh+hsyMPvQmABF1PG3FWIigPUU0dKgJM8UY
 iD+6C0ppONlrwVoStBlJR0mRUWcdEdGVzAdBE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776651100; x=1777255900;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zJxLCUZjfbzLZDERefk8Su5xijL+PR2gcUceA2H0W7k=;
 b=dfwYmpNC4QczZ8SrVSZWqERRwfkvcKzVPLt/877xbGyD/aUkk+6ZE2nbpdUNTcVuoo
 T1haiEa8rPil5y+6N7rELFsYKT6ww649xpjra81H3uktEw7CaXhh4EFkkys2Ok1yU22A
 FOo9baJGlT7BK1BeRL07NBJH2SyxnvDBQQJfKobn4MmWizqwYdoJoOze7PtEInxydJo5
 f5OJFEgEcs7mSG75Db20yfShC9cwKjDeqqv/+2Rkb7v0m0GoWKZOJGqxDd+iJyfqmbkt
 lKo9Lm/pfvjfltNtqGvMwIJYyTPeogzxwUkcwkaWDxwpwrAgxv0PYTrlDEiHZP3psRkj
 Fg/w==
X-Forwarded-Encrypted: i=1;
 AFNElJ+Py7dKXgaYaxK15haN7FEq2WUpHp0iThxW6Tp84t1G8V0QBQYawZ9s3l5Vu0Lb61r1ZjLqLNU=@lists.denx.de
X-Gm-Message-State: AOJu0YzxPsBjvQfToipvtk7W3LHo+K7eog5SeP1+trhXRU/Zmx2bFiHz
 PZFcEJCnAUOHHCFijVCl/Jb0CbLsvLHaqs66NErbOMKpV0JsFJwDo9kckbnO70rX2/Xq0eirTbC
 RR3Cf5y1DYuIVUuAgdd6arTekRBqvcYrLfcefVHsT
X-Gm-Gg: AeBDieukVX8vdXGYkto8uarINHYiHE5T/+apjwOAw3MrlH0cw19+NNYOunbgZvPS9Cf
 WjAXCc5OP+cjUNoAlcCs/6+fxjhubg7IBrManknScscLr+2lvoFQYl8rKcP6Ly49r+GqVCrwE2x
 S58Oy3dWSSd2c4lsDz4f/oz9vnrarS2boB+3AGUiIcqQ4X73N5z+ZIl/BlKS4PfI29zIj6SxvWr
 6eamaP+rKes15YzZ8JrUwuifsv7T94KMkuXC1EuP6RTTS0PuMzGGg2GQUcaRhUFDY29VKSB1OKS
 2ki5IO7qJfWzZiPwYTFw
X-Received: by 2002:a05:6a00:2d1f:b0:82f:5e65:2e19 with SMTP id
 d2e1a72fcca58-82f8c87963bmr10890313b3a.22.1776651100488; Sun, 19 Apr 2026
 19:11:40 -0700 (PDT)
MIME-Version: 1.0
References: <20260417130204.49896-1-philippe.reynes@softathome.com>
 <20260417130204.49896-3-philippe.reynes@softathome.com>
In-Reply-To: <20260417130204.49896-3-philippe.reynes@softathome.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 20 Apr 2026 14:11:19 +1200
X-Gm-Features: AQROBzCmAax1Ue1ztCqIeWIaUJjupApwK7LZY5HM_conqSuWpsAjDfhz-MrXaTI
Message-ID: <CAFLszTgVq+036_KFj2QiTgZPps53GQfsqL9P5XVcxAURBJv3-g@mail.gmail.com>
Subject: Re: [PATCH v4 02/14] ecdsa: initial support of ecdsa using mbedtls
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

On 2026-04-17T13:02:04, Philippe Reynes <philippe.reynes@softathome.com> wrote:
> ecdsa: initial support of ecdsa using mbedtls
>
> Adds an initial support of ecdsa verify using mbedtls.
>
> Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
>
> include/crypto/ecdsa-uclass.h   |  15 +----
>  include/crypto/internal/ecdsa.h |  28 ++++++++
>  lib/mbedtls/Makefile            |   3 +
>  lib/mbedtls/ecdsa.c             | 146 ++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 178 insertions(+), 14 deletions(-)

> diff --git a/lib/mbedtls/ecdsa.c b/lib/mbedtls/ecdsa.c
> @@ -0,0 +1,146 @@
> +     err = mbedtls_mpi_read_binary(&Q.Y, pubkey->y, key_len);
> +     if (err) {
> +             log_debug("could not read value y of the public key (err = %d)\n",
> +                       err);
> +             err = -EINVAL;
> +             goto out2;
> +     }
> +     mbedtls_mpi_lset(&Q.Z, 1);
> +     if (err) {
> +             log_debug("could not set value z of the public key (err = %d)\n",
> +                       err);
> +             err = -EINVAL;
> +             goto out2;
> +     }

Shouldn't this be:

    err = mbedtls_mpi_lset(&Q.Z, 1);
    if (err) {

> diff --git a/include/crypto/internal/ecdsa.h b/include/crypto/internal/ecdsa.h
> @@ -0,0 +1,28 @@
> +int ecdsa_hash_verify(const struct ecdsa_public_key *pubkey,
> +                   const void *hash, size_t hash_len,
> +                   const void *signature, size_t sig_len);

Please can you add a kerneldoc comment documenting the parameters and
return value?

Regards,
Simon

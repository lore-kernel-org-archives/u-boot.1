Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D17ABCD6E45
	for <u-boot@archiver.kernel.org>; Fri, 29 May 2026 08:33:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D12084671;
	Fri, 29 May 2026 10:33:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DwvtKb5X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0EEF6846A5; Fri, 29 May 2026 10:33:55 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0698B844CF
 for <u-boot@lists.denx.de>; Fri, 29 May 2026 10:33:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-bd8f6ef4ba6so2067041666b.3
 for <u-boot@lists.denx.de>; Fri, 29 May 2026 01:33:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780043631; cv=none;
 d=google.com; s=arc-20240605;
 b=e7RV2pY946gwFJ5vh+D3QA0Ko0c3/dwiNCp+XViGZBmqYkkecFgOrf4zzqtoBNfG53
 3oGZzFB2VbF7p+vrvjQVOrgO3NIFVC6TSqFMa/qYtiUeiBC5tdL6dXIYbLaql3z9s/7g
 nq+t1sPoasTo2ZA3TQJyMixlfGjZAc8WLoR+3SCd9XjyxrQh2oIzfZmeNJJeoHRWLuy3
 i8gcJQR3v67mKBKzCKdUwBA86dE+Yd/n7+ZTG20gFl0a4x5DIPFetkOyKb8lbBWM7jiv
 SblgsX7fnGqKuXjKJEteThC2puhiIoL3l2EfZJ13tfFs+pGCR6cH1lQ2eY9AfJE1Qytc
 fdaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=moV9XAAF1bWP/JLWkWE4J/xbHDFM7CCzBhpoAHlvcuA=;
 fh=fW5S/oR6fb9XndMDWEKEULKbruJpdu0wjswkwMZLQQM=;
 b=XIuYERpnq8tb4D9MUjboq7eNmrLKvDcAFTCwAjoaqAI885hm+3sxkIUkieku1lG5rC
 Ci7+85ZVz/3hSsKCBjXdzswivsBQOm++tZHN63EdOL9WO5g2rSw1WwhrrRDRshGNdxNm
 xTNDz4fIJDmJ4kkHAmO+Sqxs6OgxHFMD0plaqOWIfuw9HlpfWMsB2E1L0/HU9nUHkacW
 aQMgJxgeXb1zN6IHr2ApjayCrMuBOWjdxgm3PeHiuQWKhg5dTSv2Gz/dZF7ARgThY4C1
 GghzNGzB6gR6P2Wae49q9mDzatIuaUovu87KZjy+6lPK26Ahdz0SSOYtbNopDvxLn4mm
 q9VQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1780043631; x=1780648431; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=moV9XAAF1bWP/JLWkWE4J/xbHDFM7CCzBhpoAHlvcuA=;
 b=DwvtKb5XREnc5/1YvkmInH6TzFSptDr7E2sEu5KmgHuKEysylRyeRWPf1BcPR9FBai
 FqCIWJ3WgTn3DbxqFnI+bsKhNZDquuG8T9t5qcVb3Yc9sLM7avT72hqlssFzH8WS2Umu
 i6XhWI04ZzqPHBkqaPVsK+Lw+FXgfp30wPAG0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780043631; x=1780648431;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=moV9XAAF1bWP/JLWkWE4J/xbHDFM7CCzBhpoAHlvcuA=;
 b=IzInoduZhnGL2cOIb19Z2RHOPLTDV36ZKEhxs2Hi/VwHcX3E4OXakL9lr2Fy1iROpe
 mn4u0jO7mlxfmSN7USlX1RVfFXydwElE48NtlC6d+AdKEHk9QfMI7GSt7YISszjHz12q
 +Saa2kmdKljibGZn41DajUfmOsuwrgGXL+QhvP85ky3GnCRiySOnv/7+1TDF5rDWzjuj
 KucyMvTNqXyzhNYYi173+3FwojSoT76c1DpLPMzmsYM+kUOcdgVgAbANTVX9q9Sl7KUT
 NB8HVbF85JB7IerUoDFGfpZKpjTUGqMtET0Z+LwQzn6X+wxlTSZMqqq/WvVf1SG1eWm5
 2jzw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/+EllFfr/XQUj3l1bChqgadgyPTPy8pET058giAy2CsEPRLhDhFvbrXk5gDCPB6Lc0AajND7c=@lists.denx.de
X-Gm-Message-State: AOJu0YxsEESLrmI6EWu97JEnnzM8JON7UjG+szT45pQzHA+o11rxzOqx
 Es0plmuerJkV1sLeuakF56ziB6TAdV5LuLF6tlw1ZjmiC5y5ZZlMPnW4cUQHPQ2gaKMGz4VLc27
 i/mSuxSa59xvE6kcwe0etI5v9C+j3+vMYQvwQCiW1
X-Gm-Gg: Acq92OEZDIGc78F/E+SIF2+zh/Ug9lQQGqtT0yVDQXd4KuyL1Yg75nlyD2t4g5/awCk
 y6TVdJ8qXX9Nozos5f3YDqVZPvl95rNwlVSsxrmsN7cIfy8Rc6eao2QYkhOxST/v6Ioe2py9wjP
 XEMXBG3Kj3WMsa/2ftZnVgj14dD7C4bgZ8i5tE3A/2B7TgXOhhSZm1+DG6AsQKvsfhbUEbTa4uk
 +Anb5ndx1RuIKnQlfcgQwoT033nk/x40JZESBnb+ClqFobEQiLk/iRGkPieVCcvLbxZEKDTfaz6
 /AFM/FKu+e9el+p0euQ=
X-Received: by 2002:a17:906:518f:10b0:bea:3ebb:19d2 with SMTP id
 a640c23a62f3a-bea3ebb1a38mr5270866b.25.1780043631235; Fri, 29 May 2026
 01:33:51 -0700 (PDT)
MIME-Version: 1.0
References: <20260528081916.11355-1-philippe.reynes@softathome.com>
 <20260528081916.11355-4-philippe.reynes@softathome.com>
In-Reply-To: <20260528081916.11355-4-philippe.reynes@softathome.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 29 May 2026 03:33:36 -0500
X-Gm-Features: AVHnY4LDuUwiqLe32Plb3bQRw6JB-VvxWTSO0sn9I7LRVsobtJkZmL5scvStggk
Message-ID: <CAFLszTgGdOtJwVekR75Ka066fUQENg+eaCbpXHvbsO+J9NQ8=w@mail.gmail.com>
Subject: Re: [PATCH v7 03/15] ecdsa: initial support of ecdsa using mbedtls
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

On 2026-05-28T08:19:01, Philippe Reynes <philippe.reynes@softathome.com> wrote:
> ecdsa: initial support of ecdsa using mbedtls
>
> Adds an initial support of ecdsa verify using mbedtls.
>
> Reviewed-by: Raymond Mao <raymondmaoca@gmail.com>
> Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
>
> configs/sandbox_defconfig       |   1 +
>  include/crypto/ecdsa-uclass.h   |  15 +----
>  include/crypto/internal/ecdsa.h |  39 +++++++++++
>  lib/mbedtls/Kconfig             |   7 ++
>  lib/mbedtls/Makefile            |   3 +
>  lib/mbedtls/ecdsa.c             | 146 ++++++++++++++++++++++++++++++++++++++++
>  6 files changed, 197 insertions(+), 14 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

nits below

> diff --git a/include/crypto/internal/ecdsa.h b/include/crypto/internal/ecdsa.h
> @@ -0,0 +1,39 @@
> +/**
> + *
> + * ecdsa_hash_verify() - Verify the ecdsa signature of a hash
> + *
> + * @pubkey: ecdsa public key
> + * @hash: Hash
> + * @hash_len: Size of the hash
> + * @signature: Signature
> + * @sig_len: Size of the signature
> + * Return: 0 if all verified ok, <0 on error
> + */

Please drop the stray blank line at the start - the function
description should be on the first line after /**. Also a blank line
is missing before Return: so it gets folded into the @sig_len
description.

> diff --git a/lib/mbedtls/ecdsa.c b/lib/mbedtls/ecdsa.c
> @@ -0,0 +1,146 @@
> +static mbedtls_ecp_group_id ecdsa_search_group_id(const char *curve_name)
> +{
> +     mbedtls_ecp_group_id grp_id = MBEDTLS_ECP_DP_NONE;
> +     const mbedtls_ecp_curve_info *info;
> +
> +     if (!curve_name)
> +             goto out;
> +
> +     if (!strcmp(curve_name, 'prime256v1'))
> +             return MBEDTLS_ECP_DP_SECP256R1;

A brief comment would help here  it is not obvious why prime256v1 is
singled out. My understanding is that it is the OpenSSL alias for
secp256r1 (which is what FIT keys carry), while
mbedtls_ecp_curve_list() only exposes the secp256r1 name. Worth saying
so.

Also, since the only function of the local grp_id is to return
MBEDTLS_ECP_DP_NONE on the !curve_name path, this could be simplified
to an early return MBEDTLS_ECP_DP_NONE; and dropping the out: label
entirely.

> diff --git a/lib/mbedtls/ecdsa.c b/lib/mbedtls/ecdsa.c
> @@ -0,0 +1,146 @@
> +     mbedtls_mpi r, s;
> +     int key_len;
> +     int err = -1;
> +
> +     key_len = DIV_ROUND_UP(pubkey->size_bits, 8);

The err = -1 initialiser is dead - every path to out: sets err
explicitly first. Please drop it, or use a meaningful -Exxx value as a
safety default.

> diff --git a/lib/mbedtls/ecdsa.c b/lib/mbedtls/ecdsa.c
> @@ -0,0 +1,146 @@
> + out4:
> +     mbedtls_mpi_free(&s);
> + out3:
> +     mbedtls_mpi_free(&r);
> + out2:
> +     mbedtls_ecp_point_free(&Q);
> + out1:
> +     mbedtls_ecp_group_free(&grp);
> + out:
> +
> +     return err;
> +}

Please name the labels after what they do rather than counting them -
e.g. free_s, free_r, free_q, free_grp, out. As-is, every edit has to
renumber them, and a reader has to scroll up to figure out what out3
protects. Also drop the blank line between out: and return err;.

Regards,
Simon

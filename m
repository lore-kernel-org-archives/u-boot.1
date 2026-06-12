Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C88DDCD98D2
	for <u-boot@archiver.kernel.org>; Fri, 12 Jun 2026 18:32:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6812583FEC;
	Fri, 12 Jun 2026 20:32:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="KNrEDRmR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6878F8485F; Fri, 12 Jun 2026 20:32:28 +0200 (CEST)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 793F48063E
 for <u-boot@lists.denx.de>; Fri, 12 Jun 2026 20:32:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-bf84a2b2077so145763866b.2
 for <u-boot@lists.denx.de>; Fri, 12 Jun 2026 11:32:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781289146; cv=none;
 d=google.com; s=arc-20240605;
 b=RDGxss9IduRQNcuJ+0b3YBvBg0g91PFU0RFLZC7oLwUTcUOVUgDlOse0OxZKd7mOGs
 fPIVUNdMAi0Fy8vnGbi0hU/cfBiN4mbaGAaijGszYj8jCvWLsFGW0eZceJUMDBdCPdei
 ++MV7NZtOeGo8Q4KmMjP2eqJniKOxaXZ/eGfIqEl1+7QG8VtL17O9jaivatmpJeykjCk
 Alzzk2hQqLJAs9WGxuFU5rFzWoAWvOmMeOZcCU4423j+wBO6Om3EtiX6jgm6J3Npd/Te
 Q9W09hgYLe/IxU9p7Zb65qByofpzlt2c73t4w8XPQRryozJH0Ycbl/r/6M3QZKmJFRBt
 d/YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=DxT1VUp/nWd6diIqRzjsMrvjuTbH46h1YeBq7LXLQQU=;
 fh=Wkbpfk6frBtceyR8kui0ZBUEUep7FY3kC7EcdX1e2dE=;
 b=bnVWON1ty4OT+CvWw/CiNObhIuFp0l0LO0oY9UNbAtNBTGrQ30+7Ar/C4evMzmeuCp
 nKgYXtn8hSBxD11U7X9vmlZKkykNDmq1R5e+Gu+uvNgaPRKZHTsn9qg/2q6EyWtOZFuO
 90+b6Dg/zm1nJM+gb0NOoIF2SSGoyrXdf9B2CzAzc5R0e2ScXGt7Isd+qYha3rJt/Q5X
 e2lwmwIKNh/6cIEuv/kq6tM775AaiTEphIfTNJrleaLAPdNDyWSXWaxVOZ7VEeIyLwJp
 Ql5UCwMq1OTZLlNbKkqXsJz6IxlWv1rskH1Orcx9LL4rWnZ4aJ6Y/gmeDqeQDtbpB/lj
 FOvQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1781289146; x=1781893946; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=DxT1VUp/nWd6diIqRzjsMrvjuTbH46h1YeBq7LXLQQU=;
 b=KNrEDRmR3we2Tph3KniNLATOdCNOjX/afrG7Fc4J78ed6zLberHCMJk/LkyvPLc0fi
 amuJjyYOWsBmiIAWAccAKg4mUFWJKzWJbIi3btSmI0XytVwOywk/dS/2N26NjLH7Qahj
 ISMYT7dYfS+mT/R9G6Nh0s3fCqZPQX0ZjXlqA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781289146; x=1781893946;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DxT1VUp/nWd6diIqRzjsMrvjuTbH46h1YeBq7LXLQQU=;
 b=XxKtR/1LW0XVzPfdaJv+ANJx9WbG+jstX6BaYMokJjiD8KPrvi2+R3lRr1kU7ZXvJ7
 u1aF/fofifJlRuzfZDU9bv0YzFedbLzS51eGB/qfhLinphKurAmudat+cgMaQZa6IdMm
 NJ0t4cEFT/pJFY051EhKeZxFEJt4BnteWH2XLV4MmvZ4rWrQuvUyZiXaSoLEV12DZsz8
 aP54fh2aMtOPQiZsWWgQxdAefC/BhgeEjwgilKwnpRWHKo22EDBV/xh5WqqXDNMKCvvw
 IJu9trAjNRVyeXpTO6vxOVJhaLtuaxXuufui0x3PqEye+DhY4ENPEdwYSTEoQIY9zl0V
 TgsQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+Lf4SUh0I21YnriMWqw051fi7nkmtfG056qZMCGYCYG6+7IyFC+CLULYO8Lm98gPeCJdlJ+cE=@lists.denx.de
X-Gm-Message-State: AOJu0YyZ3K2+EFDetJCdSvbsrvfE+LZDDXr6nNiGmXsCBkYpsvRjwt3o
 vddguadQ2t9mnRgWDuly66jrBpkX5wrodmta3TFqE8cm2FBUYFvbxeiHFDUX4Ys6AT4ru3NctjK
 cMMpA/IxKyQtrHYllHmFCgmkSlauRJkQPFuIYvaoF
X-Gm-Gg: Acq92OFrsSK+jBbrxGCPWMUvalWadxT5OYO+JW/jI6W2Zdh4LMsoP5aP6wJHNxMTF9G
 QUt0wW2bB8VVXACmWYEu5Hqb2ISsPHE4I5xwOSO3kN5J6XDj2VeI+adnwe5EwIsMxemg1r6r6oU
 4TtNWOmSfTQEA9ohz4Eete/IUTldkDbsD8qYA0ugHbR48snWigJ7UoHhKV6/4sBDMNiaJZqH3gD
 Vxm20fMCajBaJ7tXb7kNH28x0wryaar7IdLFSBaIkmFyyGTP6Ed1CrpzOHfEcU+4Mpls00uz5LA
 a3YmW58pBX26LNSY
X-Received: by 2002:a17:907:6b07:b0:bf7:a616:cafa with SMTP id
 a640c23a62f3a-bfe2aaf718dmr228348766b.34.1781289145808; Fri, 12 Jun 2026
 11:32:25 -0700 (PDT)
MIME-Version: 1.0
References: <20260601134310.2452454-1-philippe.reynes@softathome.com>
 <20260601134310.2452454-7-philippe.reynes@softathome.com>
In-Reply-To: <20260601134310.2452454-7-philippe.reynes@softathome.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 12 Jun 2026 12:32:14 -0600
X-Gm-Features: AVVi8CcuMWYtRHENXB_OQj6xMvo2NHJl99H6-yaqsIF3FJskoGthFELnzavhfcg
Message-ID: <CAFLszTjx=CJxjp-ji+n2MF2znfeN5zPQhTO1TnBhLE3J_WMRpw@mail.gmail.com>
Subject: Re: [PATCH v8 06/15] test: dm: ecdsa.c: clean this test as software
 ecdsa is now implemented
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

On 2026-06-01T13:42:58, Philippe Reynes <philippe.reynes@softathome.com> wrote:
> test: dm: ecdsa.c: clean this test as software ecdsa is now implemented
>
> The test ecdsa was done when ecdsa was only supported by hardware.
> So it wasn't possible to test ecdsa on sandbox, and there is a test
> to check that ecdsa is not supported on sandbox.
> Now, there is a software implementation of ecdsa. So we add a test
> to verify that ecdsa_verify may be used on sandbox.
>
> Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
> Reviewed-by: Raymond Mao <raymondmaoca@gmail.com>
>
> test/dm/ecdsa.c | 107 ++++++++++++++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 97 insertions(+), 10 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

with nits below

> diff --git a/test/dm/ecdsa.c b/test/dm/ecdsa.c
> @@ -3,36 +3,123 @@
> +     ret = fdt_property(fdt, name, value, len);
> +     if (ret)
> +             goto out;
> +
> +out:
> +     free(value);
> +     return ret;

The 'if (ret) goto out' jumps to the very next statement, so it does
nothing - please drop it and fall through to the label. Also, since
this is test code and all callers pass valid pointers, the NULL checks
on fdt, name and data at the top of this helper are not really needed.

> diff --git a/test/dm/ecdsa.c b/test/dm/ecdsa.c
> @@ -3,36 +3,123 @@
> +     /* prepare the signature */
> +     ut_assertok(hex2bin(sig + 0, r, strlen(r) / 2));
> +     ut_assertok(hex2bin(sig + 32, s, strlen(s) / 2));

The 32 here hard-codes the size of r, while you already compute
strlen(r) / 2 on the same line - please use that (or a named constant)
for the offset, so the two cannot get out of sync.

> diff --git a/test/dm/ecdsa.c b/test/dm/ecdsa.c
> @@ -3,36 +3,123 @@
>       ut_assertok(uclass_get(UCLASS_ECDSA, &ucp));
>       ut_assertnonnull(ucp);
> -     ut_asserteq(-ENODEV, ecdsa_verify(&info, NULL, 0, NULL, 0));
> +     ut_assertok(ecdsa_verify(&info, region, 1, sig, sizeof(sig)));

Can you drop ucp now?

Also, the subject says 'clean this test' but the patch actually
extends it to do a real verification against an RFC 6979 vector.
Please can you reword it to describe that, and use 'test: dm: ecdsa:'
rather than 'ecdsa.c:' as the tag, matching the usual style?

Regards,
Simon

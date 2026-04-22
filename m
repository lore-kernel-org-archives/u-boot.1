Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D8B5F94CA2
	for <u-boot@archiver.kernel.org>; Wed, 22 Apr 2026 00:11:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF10B8352B;
	Wed, 22 Apr 2026 02:11:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="MAmDqVXh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F038483BC8; Wed, 22 Apr 2026 02:11:09 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1614F805D7
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 02:11:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-ba8472c1613so430596666b.0
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 17:11:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776816667; cv=none;
 d=google.com; s=arc-20240605;
 b=Apv0wJ+FkOXs06EhvsADTujgNWxQ0Rzrq0PKCXEvf/P3quwjzu6DfvOkDGcHq/XVs2
 +WN+RGytL8tPQdooEbff0xUu2cEjoEGrYO0rJjfalrUVBD92BKy6WoaRH1Cf06g0AvSK
 fOUIrRqDXJ94T/H+p8WnLo7ytmFdRu6JQSiYK+nTDpeEHIAAZsxeCs/oscVQHCs2ccJn
 kgU/w6+RQbgCr/2ekc9p8GnQ0nHNnUBHnpG/p6eti+6nJR6bTexxgFvGvoNAVtGnvEU0
 utNFsEAj/hgKOzBDuXkLKTQDL03Ts+mrR6QFydlZR3fn1LSHeygb9Wsu5zTU98p97M4x
 IEhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=TL4r1tdGjUnwEXTXhpc7lA+MRbNVa5uxrUyWPErcVsc=;
 fh=ayJuwa4Uc6vWMTHhvM545NH9C0PrVSSSMfPknYNDaJQ=;
 b=HG4Zsle5el32iGPcLDxU55SgzthPyvoT0/0QifRvQROnHqi4012b2aKoUyG7NHcHFZ
 IwmkUVYbIw+oZjCh30fFQ2Cgn2h8X0h1IrnCVcri2Sv5sIhKdzyJtKC6bJYruEbRXRCO
 rism80vdD8WsjWN5O6iTP8SqPmkKN1CSQXWLuoWMludz729G5h9o9Gad5dh7ZfNO3caO
 wS5O4VkYCZfvpr9muy07+bQm8phXc5pS9nppcjpuH7pxKeNvzh0XBpKbA+85kEwAuKlm
 u82nzRyFFzGF4pzGSoxN06h8/FJlYW7jzq8WPXmCcag4KBeKL7kzxq2aJkNwnLs0EHai
 g1vw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776816667; x=1777421467; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=TL4r1tdGjUnwEXTXhpc7lA+MRbNVa5uxrUyWPErcVsc=;
 b=MAmDqVXhF/czGc66bb/VRK5cATNiC5mt7zJ4DZ6jZZewZDYSa7p0PcHQI4sMibYWvE
 UBdzBwCSyG3KGRBVBnZLGyDBv/AuokGCJEE4QKQLci1IOBSdz0qmQPr0BSr970wKi5GC
 YIcnU21Hn/Xl6FmRvcO9LI68vMVbA0ZDfcKLw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776816667; x=1777421467;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TL4r1tdGjUnwEXTXhpc7lA+MRbNVa5uxrUyWPErcVsc=;
 b=YRCZU+fx8SLrujahHd+CHYdw5K5w9/5lt7/4OYI0soDGe+VU/DI1yJ+DdiOg60jYCI
 dfdaVAUB+wMN578GcosVBJ4PqrFixSjm3e+X17CiST7cKXJBx6X06HvBs4cRq0MDzsjT
 Dyi5hZ8M3EcMzFN8+Rpg2crZ3wtv1/waldQkkdangtlN6G75crn7ZxQ4KLsYgrx5PFKQ
 4yAugro8eMicqgfS7YX9nu/FUWdze79evAj+6gMHUqRls0trpSn6679CsBGbs4tlSu1q
 RmMcEEoTsiCVcU7Jw3ZzIh0JqlnbhWPT3YZ7PWRN/KNL8wz/XnPk/uOW31J5mT9rco1R
 /rlQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9I152UjK3Y0/K4FSg/7tWWAEMip/rseYMEFPYzX8+KCuiE2g6aEWhPpVkBYGvghyotxyiIXfs=@lists.denx.de
X-Gm-Message-State: AOJu0YxakwMhr3i9uLQ20mhtJVLXHQK4ad2UsP7W3WlqhCA9MWCCMK0g
 4b6jpU/+2yt+IMcDo055F82hhGSOfBh1hCIB4Y96IiCvHW4B41/e2xnemJkMQFEZpKGYkveaEUf
 EgqXT/Tn2Fn59BKa2xRgCWt3TLyCH77LE6pN7IVor
X-Gm-Gg: AeBDiesBjNmqEHKw93CrX8uWr7vpbc2wbeF7Zm2Cly7NzIq5Jl1zquJEeCbrMc43qU7
 TBA2ZV6GM1TvAkY8SFrJYrwDBrSGPGb1lKkea00fJjBsCw8NP6fnsrQoZtAimI1Rk7jrMWyVoVe
 6LO5dqfqT/LsoUhM34AFg7y/nR1qZs+1tM9pWsqZ54fyuqLM5eBiybgpwwLDDakKuoNFA9g0V5m
 9FsQMTUCiFv3FHZ7wLJSFMTi1TqtOHCMmXyxMXR2OBs2eh01GPXjvxrWlncL1DE8PTDcprBJdJa
 rsvRgS73277iHI1hEsgE
X-Received: by 2002:a17:907:3f9b:b0:ba8:bcb3:e2d0 with SMTP id
 a640c23a62f3a-ba8bcb3eaabmr449489866b.0.1776816667147; Tue, 21 Apr 2026
 17:11:07 -0700 (PDT)
MIME-Version: 1.0
References: <20260421210954.1170437-1-philippe.reynes@softathome.com>
 <20260421210954.1170437-4-philippe.reynes@softathome.com>
In-Reply-To: <20260421210954.1170437-4-philippe.reynes@softathome.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 22 Apr 2026 12:10:54 +1200
X-Gm-Features: AQROBzBMMiCjVDIi6Sl52vATlSUNDyJ5CsX6Q-w7DW-BVB9fb2kvEkUGhYPETyo
Message-ID: <CAFLszTi7VKhJrr9ejVT+Tg7rbfeoes9WqsggEaXsEK3sVSVeYg@mail.gmail.com>
Subject: Re: [PATCH v5 03/15] ecdsa: initial support of ecdsa using mbedtls
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

On 2026-04-21T21:09:51, Philippe Reynes <philippe.reynes@softathome.com> wrote:
> ecdsa: initial support of ecdsa using mbedtls
>
> Adds an initial support of ecdsa verify using mbedtls.
>
> Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
>
> include/crypto/ecdsa-uclass.h   |  15 +----
>  include/crypto/internal/ecdsa.h |  39 +++++++++++
>  lib/mbedtls/Makefile            |   3 +
>  lib/mbedtls/ecdsa.c             | 146 ++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 189 insertions(+), 14 deletions(-)

> diff --git a/include/crypto/internal/ecdsa.h b/include/crypto/internal/ecdsa.h
> @@ -0,0 +1,39 @@
> + * @pubkey : ecdsa public key
> + * @hash : Hash
> + * @hash_len : Size of the hash
> + * @signature : Signature
> + * @sig_len : Size of the signature

The kernel-doc style uses no space before the colon. Please can you
use @pubkey: etc.

Regards,
Simon

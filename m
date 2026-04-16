Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FF5DF8D766
	for <u-boot@archiver.kernel.org>; Thu, 16 Apr 2026 18:52:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF7B884223;
	Thu, 16 Apr 2026 20:52:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="K6saxIV9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B624484242; Thu, 16 Apr 2026 20:52:33 +0200 (CEST)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 92F1B84214
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 20:52:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-6729c8f9c55so949972a12.0
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 11:52:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776365551; cv=none;
 d=google.com; s=arc-20240605;
 b=DyoS/zG/V83UXX2c3i0FtI+5Ho0CKsNpHGUjKDLdH18RIOy13cHflB3uyHk5mKy1xg
 o2hxm6+ed9VBSPZEZgEvzykhqDaQdDGb//bM3XGepdKetAWWdhHztd2KelKm5QyPPvnt
 /03Fbc2wV/WoJDAKsQT1YyHqK8oE1XCWoF9fhLKVjXjLOhzXYF0vJ75VoZJB7M0/t1g7
 JqgramGwm6v/lTpQOr+GWKBOjXQZYqYbxACL5jNSqkJgOuFD7YiyMYHuGeXYZZ8S4+Li
 s+/QG6zLGyD0LoEFPGxGu2Z0LNqZRq+hqlVdeUxp63iGrQJIkNERbymQMoVqyailcsMZ
 8DDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=SSUzBbuoOm3FFgk2EG2JaRJEytEJr4/xb3ZO84iNNnw=;
 fh=tjiV1P9byL0UH7BqddYqNliTcFRJuda8derD73aVpbI=;
 b=jzhWueBup4920N+dAd6OfDamXiO2bblnQVmx3FQ3SOqqpjKSpFaTZ2a+dO+4uRySTf
 RWEm7m+PykZiDXelNJW4xduMINcicT1JM/o46QxBkW2Y2b0AfeABEvfJ/oZJKCGUGHY8
 XAnH4e0ncrsnHpG/UpeCHzRGwz60Ghzmo/PzPtSvKkykQ3SZOBIBgwWAnM4xyaGWwdVM
 y8LFZchnfrJ9pEM1kCASQzFLGJMYZ+/sTnjaaX7cnoEQSXUmvbx/YWXC/8Ym9ixEQymr
 ERoTK71N632ntqSTR+/ZkoUf7nXIO+g5LV8hkpGCH6d8gK57ab1uI1fFaTD+ewFlItm5
 Q2Jw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776365551; x=1776970351; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=SSUzBbuoOm3FFgk2EG2JaRJEytEJr4/xb3ZO84iNNnw=;
 b=K6saxIV9SWkEPCK/IUcFQQEK1uFEJtdiV37CQvfMe46dQkoEW1RW8ygM6acuL23aJH
 8FNLFg9tONWcW4/uVBDkPVOLCFZ4qIat/vSH4CZKU9ARCr4iPgGZCpaBnvqo3xfU42J0
 r8RoX7c4c8aaecLMoEZQdIMydaGE19SGoxFpc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776365551; x=1776970351;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SSUzBbuoOm3FFgk2EG2JaRJEytEJr4/xb3ZO84iNNnw=;
 b=fOHsj4QjXMihizQzfvbNoRwnU337+n73TA1m/fgXig4p5R68C+jbGS6ttSFwquvW2x
 gCpxlVqsVprd2kxCnPF8+3iqJjGaFCS2h8rJd4E5TiKCKJf9wX3ztdxdb/NK06QGEXH7
 04u2xkVB8qiXqt6Sj5LrneoLFpsnL3Qg2cxZz3hz5iJbwDSsxNgwPjw7HnPuene42LkV
 NMaQkEgwIbE+ZSyqnCbXrzFO8sRpYUmM1cFct+gjW5XKbi8DmIWaxCcYkjHhr3XYmIh6
 1dkayfyrVPazIaEh4NgRYADKwDynTJNMdcDz6OOiLt7U20Ac06wKe9w0W5aQ3p8p3XLJ
 ZsvQ==
X-Gm-Message-State: AOJu0Yy5BQ1648tJ38zdDONeIVz1rioCtFP02nKAp7dytk3uN9ku46f5
 ur2tHnjiZQjSNz2PQZ9qFYhv5wvTUSE2+FF6xloBJPXxsVCuACHLwP6+QXn+P5fArn7PGi49E80
 7OF9hSlbmer0AYSrkLa9CiK2wZew1JPsg7hiAhEHP
X-Gm-Gg: AeBDietNr16DkGJgiRqb9wi07QkoNECKKnFuFr5y+16+0LRT6H7Jdviot5CHA/kpIOP
 KGNRkjDO1Y9hA1bFrxHA8X0TNxxOdWEj3KrKsGHDdOK6y0TTrDSpq2MrhQ9PoaD9xqFJEzXdHVy
 /IOXCxNQBuvoUwOPt7BLDs/pB8ToO7fyfVzWQbAkgIyWOgKiL4cUNTF4hHpH8YAHrc0f8yWZa1l
 DIurgcCTvUD7VsvMvVYFkJin5lcL3n0eiikIDdBPQMg5ldhGVxIlIKro2KWTcf+drwhXS5OSpk/
 LPcpiS+VWyfIYqTONezf
X-Received: by 2002:a17:907:9704:b0:b98:14e:32c0 with SMTP id
 a640c23a62f3a-ba3e3b2a8c1mr23241166b.14.1776365550975; Thu, 16 Apr 2026
 11:52:30 -0700 (PDT)
MIME-Version: 1.0
References: <20260415183250.3031030-1-dario.binacchi@amarulasolutions.com>
 <20260415183250.3031030-7-dario.binacchi@amarulasolutions.com>
In-Reply-To: <20260415183250.3031030-7-dario.binacchi@amarulasolutions.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 17 Apr 2026 06:52:18 +1200
X-Gm-Features: AQROBzCG_Yxnjog92qQUCpExgLJe_pGry7ZHic5rcn2aOb34AOWW9mBZ9TXKBkw
Message-ID: <CAFLszTg+S7xepqVuU7y8mA_LoK531w77+pqp8if6nBnWsMizoA@mail.gmail.com>
Subject: Re: [PATCH v3 6/7] fwu: add helper to get image GUID by type and bank
 index
To: dario.binacchi@amarulasolutions.com
Cc: u-boot@lists.denx.de, linux-amarula@amarulasolutions.com, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Kory Maincent <kory.maincent@bootlin.com>, 
 Michal Simek <michal.simek@amd.com>, Padmarao Begari <padmarao.begari@amd.com>,
 Sughosh Ganu <sughosh.ganu@arm.com>, Tom Rini <trini@konsulko.com>
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

Hi Dario,

On 2026-04-15T18:31:27, Dario Binacchi
<dario.binacchi@amarulasolutions.com> wrote:
> fwu: add helper to get image GUID by type and bank index
>
> Introduce fwu_mdata_get_image_guid() to retrieve a specific image GUID
> from the FWU metadata based on the bank index and image type GUID.
>
> This allows identifying the correct partition in multi-bank (A/B)
> scenarios, ensuring the correct image is targeted depending on the
> current bank.
>
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
>
> include/fwu.h         | 11 +++++++++++
>  lib/fwu_updates/fwu.c | 33 +++++++++++++++++++++++++++++++++
>  2 files changed, 44 insertions(+)

> diff --git a/lib/fwu_updates/fwu.c b/lib/fwu_updates/fwu.c
> @@ -243,6 +243,39 @@ int fwu_sync_mdata(struct fwu_mdata *mdata, int part)
> +int fwu_mdata_get_image_guid(efi_guid_t *image_guid,
> +                          const efi_guid_t *image_type_guid, u32 bank_index)
> +{
> +     struct fwu_data *data = &g_fwu_data;
> +     struct fwu_image_entry *image;
> +     int i;
> +
> +     if (bank_index >= data->num_banks)
> +             return -EINVAL;
> +
> +     for (i = 0; i < data->num_images; i++) {

Using data->num_images here is the proper approach for new code. Some
existing functions still use CONFIG_FWU_NUM_IMAGES_PER_BANK in their
loops but using the runtime value is more correct, especially since
FWU v2 populates num_images from the metadata itself.

Is there a unit test for this new function? Since you have added tests
for the part command in patches 2, 3, and 5, it would be good to add
coverage here as well, e.g. testing success, -EINVAL for invalid bank
index, and -ENOENT for missing image type.

Reviewed-by: Simon Glass <sjg@chromium.org>

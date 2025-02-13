Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 270F4C0219D
	for <u-boot@archiver.kernel.org>; Thu, 13 Feb 2025 08:30:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E7E9801DE;
	Thu, 13 Feb 2025 09:30:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="M0iN69t4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5DC51807F1; Thu, 13 Feb 2025 09:30:06 +0100 (CET)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0620980079
 for <u-boot@lists.denx.de>; Thu, 13 Feb 2025 09:30:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-43946b5920cso3431585e9.1
 for <u-boot@lists.denx.de>; Thu, 13 Feb 2025 00:30:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1739435403; x=1740040203;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=dMlFz3jL8122M8/KKbnvk7/tRLSbJ7pWXDHPOh8dXgo=;
 b=M0iN69t4l15FILsR2WPjTLlFDc7mQ+0g6VZ0rnr324W1ofhogzKYBE3fY6yhzu7Xhv
 aAhvIAqvlSQVz3ik4P5vV3GPjrVvIPM7yNAeddOnA76DLJISN7rofj7R/V5/TBMle6kt
 wrhinbvsx7TWWuuSkvo5DTWCbzbFLS0Wn8E3Cs8MDwuhK9WoaJnVQoYuBeU0w1tR0SVE
 ZjmOyH1q0edG+KtLe/hVivzIRofdBIK6wex/bmx9PQRmJjgZHZr0ea+ReSGAB8YfY42X
 yPlgyw/yRXdYdZKXBz692XZEviXgfQV6KvY6xfq/fM8VJ53anYV0xK8yZg7oxqRRBXsG
 N9PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739435403; x=1740040203;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dMlFz3jL8122M8/KKbnvk7/tRLSbJ7pWXDHPOh8dXgo=;
 b=LLrMsbYjFmDqZ9iy5+drWBpy5YA6cu2Ulqxv+n2XZsyGvGMdDdzJxPH3knEIYU2AvU
 fQx0pTNluzHtw9+BvL9nFe0LWCy99W/qhgWfu7udOYdJWEqTuJd16P7qHvo6c0LXvjkv
 t6iTdO1lROMFNZpBLD78+yHvjm7ozeqbbKdpz1dYMSIZcE8bqw2iwY33iFfk+lpMsaO2
 J7uUAnhKnbjZHxQj9QuCcFs0b9pzRUw2OWd4405Yb145rQYjXiBGiPNJs08WsfEkOsif
 9Ow3ncIbKV3oNp3tCyOvq326Js/lt6TQEVcfUNxvaNKYBYzFt5DoUAvJbDVxXR3rUrBF
 saaQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXL8r47oyRPzz0IrVJRTfHezre1Y8100Zmu7J09oSStm7qhJEBesW9qQL+wD6cLqnYNl4DMWQo=@lists.denx.de
X-Gm-Message-State: AOJu0Yyjy/CYo5mb2CTp09kqRxoxsFcD8SwBhcBaGe6yue7aknnj1XdZ
 Maq+kfQHCSWMLe2OmD67wipnX59DnX8PuE8YpzhY720FrDB+7GCAmPVC5kVuJK4=
X-Gm-Gg: ASbGncuVXQh+0PUPxkj4QLV4eA+zIl6Dvkg2LVC2H2LxR9OAr43USEjdYXj8v3Mo68n
 DOZaDhXfxZMevGjJhl3tA6vyFGwqZgmWHutYvu7mIG9YgfPksIUTY+iuDmxIWcYG7KTQKr/YhJq
 FG2SwUa+qWrt7wFM8pE3Pzv9+K0LkBCJQRjYy4UDfT/Nbi66uGkKEB4IKC3OoDWdu+XjfBb3yEC
 UiCeHx6Reuygk6VKg3okZWgsdWBpQBOZFweyuX7jD/FK5u9IDMQufu64jGZrGtGPfJzDzNPAPj8
 Bh+ky/0mkLaPuaIV7Ds=
X-Google-Smtp-Source: AGHT+IHrau0O7BRylGjMkGL2AgOzt5eEJ/JnBkHntO8lkKJyu7vJQYjh7c+TjVS555TkGyeZSjcJPA==
X-Received: by 2002:a5d:5182:0:b0:38d:e078:43a4 with SMTP id
 ffacd0b85a97d-38f244f9308mr1722301f8f.31.1739435403363; 
 Thu, 13 Feb 2025 00:30:03 -0800 (PST)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f258ddba7sm1215996f8f.38.2025.02.13.00.30.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2025 00:30:02 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Dragan Simic <dsimic@manjaro.org>, Joe
 Hershberger <joe.hershberger@ni.com>, Quentin Schulz
 <quentin.schulz@cherry.de>, Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH v2] env: mmc: Make redundant env in both eMMC boot
 partitions consider DT properties
In-Reply-To: <20250211133116.28833-1-marex@denx.de>
References: <20250211133116.28833-1-marex@denx.de>
Date: Thu, 13 Feb 2025 09:30:00 +0100
Message-ID: <87r042dz7b.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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

Hi Marek,

Thank you for the patch.

On mar., f=C3=A9vr. 11, 2025 at 14:31, Marek Vasut <marex@denx.de> wrote:

> Introduce a new function mmc_env_is_redundant_in_both_boot_hwparts()
> which replaces IS_ENABLED(ENV_MMC_HWPART_REDUND) and internally does
> almost the same check as the macro which assigned ENV_MMC_HWPART_REDUND
> did, and call it in place of IS_ENABLED(ENV_MMC_HWPART_REDUND).
>
> The difference compared to IS_ENABLED(ENV_MMC_HWPART_REDUND) is
> in the last conditional, which does not do plain macro compare
> (CONFIG_ENV_OFFSET =3D=3D CONFIG_ENV_OFFSET_REDUND), but instead does
> mmc_offset(mmc, 0) =3D=3D mmc_offset(mmc, 1). If OF_CONTROL is not
> in use, this gets optimized back to original macro compare, but
> if OF_CONTROL is in use, this also takes into account the DT
> properties u-boot,mmc-env-offset and u-boot,mmc-env-offset-redundant.
>
> Signed-off-by: Marek Vasut <marex@denx.de>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

Some question below.

> ---
> Cc: Dragan Simic <dsimic@manjaro.org>
> Cc: Joe Hershberger <joe.hershberger@ni.com>
> Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> Cc: Quentin Schulz <quentin.schulz@cherry.de>
> Cc: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@lists.denx.de
> ---
> V2: - Rename mmc_env_hwpart_redund() to mmc_env_is_redundant_in_both_boot=
_hwparts()
>     - Return bool
> ---
>  env/mmc.c | 37 +++++++++++++++++++++----------------
>  1 file changed, 21 insertions(+), 16 deletions(-)
>
> diff --git a/env/mmc.c b/env/mmc.c
> index 379f5ec9be7..c4467333263 100644
> --- a/env/mmc.c
> +++ b/env/mmc.c
> @@ -40,18 +40,6 @@
>=20=20
>  DECLARE_GLOBAL_DATA_PTR;
>=20=20
> -/*
> - * In case the environment is redundant, stored in eMMC hardware boot
> - * partition and the environment and redundant environment offsets are
> - * identical, store the environment and redundant environment in both
> - * eMMC boot partitions, one copy in each.
> - * */
> -#if (defined(CONFIG_SYS_REDUNDAND_ENVIRONMENT) && \
> -     (CONFIG_SYS_MMC_ENV_PART =3D=3D 1) && \
> -     (CONFIG_ENV_OFFSET =3D=3D CONFIG_ENV_OFFSET_REDUND))
> -#define ENV_MMC_HWPART_REDUND	1
> -#endif
> -
>  #if CONFIG_IS_ENABLED(OF_CONTROL)
>=20=20
>  static int mmc_env_partition_by_name(struct blk_desc *desc, const char *=
str,
> @@ -217,6 +205,23 @@ static inline s64 mmc_offset(struct mmc *mmc, int co=
py)
>  }
>  #endif
>=20=20
> +static bool mmc_env_is_redundant_in_both_boot_hwparts(struct mmc *mmc)
> +{
> +	/*
> +	 * In case the environment is redundant, stored in eMMC hardware boot
> +	 * partition and the environment and redundant environment offsets are
> +	 * identical, store the environment and redundant environment in both
> +	 * eMMC boot partitions, one copy in each.
> +	 */
> +	if (!IS_ENABLED(CONFIG_SYS_REDUNDAND_ENVIRONMENT))
> +		return false;
> +
> +	if (CONFIG_SYS_MMC_ENV_PART !=3D 1)
> +		return false;

Looking at the description of this KConfig entry:
"""
CONFIG_SYS_MMC_ENV_PART (optional):

Specifies which MMC partition the environment is stored in. If not
set, defaults to partition 0, the user area. Common values might be
1 (first MMC boot partition), 2 (second MMC boot partition).
"""

Makes me wonder: does this work when the environment is stored in the
second MMC boot partition ?

I'm not sure.

This is also out of scope for the patch though, since the original
#ifdefery already has this.

> +
> +	return mmc_offset(mmc, 0) =3D=3D mmc_offset(mmc, 1);
> +}
> +
>  __weak int mmc_get_env_addr(struct mmc *mmc, int copy, u32 *env_addr)
>  {
>  	s64 offset =3D mmc_offset(mmc, copy);
> @@ -336,7 +341,7 @@ static int env_mmc_save(void)
>  		if (gd->env_valid =3D=3D ENV_VALID)
>  			copy =3D 1;
>=20=20
> -		if (IS_ENABLED(ENV_MMC_HWPART_REDUND)) {
> +		if (mmc_env_is_redundant_in_both_boot_hwparts(mmc)) {
>  			ret =3D mmc_set_env_part(mmc, copy + 1);
>  			if (ret)
>  				goto fini;
> @@ -409,7 +414,7 @@ static int env_mmc_erase(void)
>  	if (IS_ENABLED(CONFIG_SYS_REDUNDAND_ENVIRONMENT)) {
>  		copy =3D 1;
>=20=20
> -		if (IS_ENABLED(ENV_MMC_HWPART_REDUND)) {
> +		if (mmc_env_is_redundant_in_both_boot_hwparts(mmc)) {
>  			ret =3D mmc_set_env_part(mmc, copy + 1);
>  			if (ret)
>  				goto fini;
> @@ -477,7 +482,7 @@ static int env_mmc_load(void)
>  		goto fini;
>  	}
>=20=20
> -	if (IS_ENABLED(ENV_MMC_HWPART_REDUND)) {
> +	if (mmc_env_is_redundant_in_both_boot_hwparts(mmc)) {
>  		ret =3D mmc_set_env_part(mmc, 1);
>  		if (ret)
>  			goto fini;
> @@ -485,7 +490,7 @@ static int env_mmc_load(void)
>=20=20
>  	read1_fail =3D read_env(mmc, CONFIG_ENV_SIZE, offset1, tmp_env1);
>=20=20
> -	if (IS_ENABLED(ENV_MMC_HWPART_REDUND)) {
> +	if (mmc_env_is_redundant_in_both_boot_hwparts(mmc)) {
>  		ret =3D mmc_set_env_part(mmc, 2);
>  		if (ret)
>  			goto fini;
> --=20
> 2.47.2

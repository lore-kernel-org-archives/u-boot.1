Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCE11C48260
	for <u-boot@archiver.kernel.org>; Thu,  8 Feb 2024 13:43:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CECC387E40;
	Thu,  8 Feb 2024 14:43:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="q7mOoIrU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 16CBE87E37; Thu,  8 Feb 2024 14:43:55 +0100 (CET)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1AB8A87E42
 for <u-boot@lists.denx.de>; Thu,  8 Feb 2024 14:43:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-41047395814so2991385e9.1
 for <u-boot@lists.denx.de>; Thu, 08 Feb 2024 05:43:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1707399832; x=1708004632;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=4dmssUJXN02tt4kJvHSBMh8dolT/d8nxNjPDvm6RfTs=;
 b=q7mOoIrUw4Yo1kWQUE6uF6P3G1tRgjDL61K/+Hw7tw9iRX0pFAsOY57ONO+Fph0lT/
 w0Ub5i89c58Lgq0jqcUfGMgStDJResFF2iahwl7FcQSpMEtVPDUj0c1JmnnJECpWQu8r
 KqsNULzhEiH3GRPqHy1qCDPhew6yef8Lqm0oxButSJIEJcyeZo8iZSDeCdla9u/+vI3n
 EfdtSvRs3vNqpGyCSAThLDDxoNEHTRK25vFOw0NPtYQEoUi9cftoYz5NTkC8jG20iyhF
 4aM483TmbGf7B3V/5yLl4zSRdO8uhfsCNw6V09C3/zSvMhDkQ0fYEBhu9SouaCgZFVST
 H9Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707399832; x=1708004632;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4dmssUJXN02tt4kJvHSBMh8dolT/d8nxNjPDvm6RfTs=;
 b=LsIfaPZ87VjHmS9xOoI9/iO2lAnR+jMc15aRD8/3mUyj1FT0HqymcugVtcFvUm/A7c
 ECM3davqKV6otvHFgVosUjR4vObjjxYcsvIZA/ZITQ50oE2+UMv7wV/tHqsQYrL2jiFH
 60Y+fCNR2g554ZKuej6oQ5EugPQIR+MOXQI+LTPL3UfpqACQvww6V3XhPWG2GspTxqju
 G+mqfK4v9wx1EUNagR/lh/cIsIqPJmsP6Iro9+NVfVUUW7F7HKf56mT/Rovxchi8VF3/
 4xFi1i5kq8wp4pIV6wwmJig9hGVHcC57mSq0w5KerOMYH7Ev3T6gnjVIJmaJnco2nMec
 WldA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWqUjqT3HvMBNxHXmIaPEgys6RrrI+nC/JU+iREqM2HFJnBHexPioNKDoPikfDn+AdTejCoWJlP2Pbq9x9m1E0cucdGvg==
X-Gm-Message-State: AOJu0YygsSm2lLJoGIgC6xmfwUvgRDJMA+c/1Ln1yW6N5CadQuo1bd/l
 D6jid9mW5nPFjqfrIESwTI9VyL4Rf8EgyPzFdBv7ngGXTZOeJbcVSx1CcBiK0Mo=
X-Google-Smtp-Source: AGHT+IFl/1uPBZpvPn/YPicNxrl5AWl92rcsAsl1hU9atSZFOmAUnHzpMlBIOF/W3sGirQ+xoXRg4g==
X-Received: by 2002:a05:600c:48a5:b0:40f:c5cc:e6dd with SMTP id
 j37-20020a05600c48a500b0040fc5cce6ddmr7753383wmp.24.1707399832527; 
 Thu, 08 Feb 2024 05:43:52 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUMZU9p0NN4By3VWa2OWPl7ksB0BDat7VcfcrKyuHJSg5aHaMEwFPZyGkOpIv7R0zwdXNm0h6Iw66Vu5/fbmEka0qPj1k/HzfbEZXO/p39I5kew1jVr6AhIkFlzNOSmNYhv33F90oTnDmpLlbMk/gh85CZfbURyjpaneNusJ0S7IuROrlsLpxtYQcVk2sjj
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 h10-20020a05600c350a00b0040fd3121c4asm1659445wmq.46.2024.02.08.05.43.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Feb 2024 05:43:52 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Igor Opaniuk <igor.opaniuk@foundries.io>, u-boot@lists.denx.de
Cc: Igor Opaniuk <igor.opaniuk@gmail.com>, Ivan Khoronzhuk
 <ivan.khoronzhuk@gmail.com>, Jens Wiklander <jens.wiklander@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH v1 3/7] common: avb_verify: rework error/debug prints
In-Reply-To: <20240206223153.3060433-4-igor.opaniuk@foundries.io>
References: <20240206223153.3060433-1-igor.opaniuk@foundries.io>
 <20240206223153.3060433-4-igor.opaniuk@foundries.io>
Date: Thu, 08 Feb 2024 14:43:51 +0100
Message-ID: <878r3vjcko.fsf@baylibre.com>
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

Hi Igor,

Thank you for the patch.

On mar., f=C3=A9vr. 06, 2024 at 23:31, Igor Opaniuk <igor.opaniuk@foundries=
.io> wrote:

> From: Igor Opaniuk <igor.opaniuk@gmail.com>
>
> Make error prints more verbose with additional context.
> Also s/print/debug/g for prints, which might be relevant only
> for debugging purposes.
>
> Signed-off-by: Igor Opaniuk <igor.opaniuk@gmail.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
>
>  common/avb_verify.c | 31 ++++++++++++++++++-------------
>  1 file changed, 18 insertions(+), 13 deletions(-)
>
> diff --git a/common/avb_verify.c b/common/avb_verify.c
> index 938a5383b5d..ed58239cf8a 100644
> --- a/common/avb_verify.c
> +++ b/common/avb_verify.c
> @@ -279,9 +279,9 @@ static unsigned long mmc_read_and_flush(struct mmc_pa=
rt *part,
>  	 * Reading fails on unaligned buffers, so we have to
>  	 * use aligned temporary buffer and then copy to destination
>  	 */
> -
>  	if (unaligned) {
> -		printf("Handling unaligned read buffer..\n");
> +		debug("%s: handling unaligned read buffer, addr =3D 0x%p\n",
> +		      __func__, buffer);
>  		tmp_buf =3D get_sector_buf();
>  		buf_size =3D get_sector_buf_size();
>  		if (sectors > buf_size / part->info.blksz)
> @@ -320,7 +320,8 @@ static unsigned long mmc_write(struct mmc_part *part,=
 lbaint_t start,
>  	if (unaligned) {
>  		tmp_buf =3D get_sector_buf();
>  		buf_size =3D get_sector_buf_size();
> -		printf("Handling unaligned wrire buffer..\n");
> +		debug("%s: handling unaligned read buffer, addr =3D 0x%p\n",
> +		      __func__, buffer);
>  		if (sectors > buf_size / part->info.blksz)
>  			sectors =3D buf_size / part->info.blksz;
>=20=20
> @@ -348,30 +349,35 @@ static struct mmc_part *get_partition(AvbOps *ops, =
const char *partition)
>  	dev_num =3D get_boot_device(ops);
>  	part->mmc =3D find_mmc_device(dev_num);
>  	if (!part->mmc) {
> -		printf("No MMC device at slot %x\n", dev_num);
> +		printf("%s: no MMC device at slot %x\n", __func__, dev_num);
>  		goto err;
>  	}
>=20=20
> -	if (mmc_init(part->mmc)) {
> -		printf("MMC initialization failed\n");
> +	ret =3D mmc_init(part->mmc);
> +	if (ret) {
> +		printf("%s: MMC initialization failed, err =3D %d\n",
> +		       __func__, ret);
>  		goto err;
>  	}
>=20=20
>  	if (IS_MMC(part->mmc)) {
>  		ret =3D mmc_switch_part(part->mmc, part_num);
> -		if (ret)
> +		if (ret) {
> +			printf("%s: MMC part switch failed, err =3D %d\n",
> +			       __func__, ret);
>  			goto err;
> +		}
>  	}
>=20=20
>  	mmc_blk =3D mmc_get_blk_desc(part->mmc);
>  	if (!mmc_blk) {
> -		printf("Error - failed to obtain block descriptor\n");
> +		printf("%s: failed to obtain block descriptor\n", __func__);
>  		goto err;
>  	}
>=20=20
>  	ret =3D part_get_info_by_name(mmc_blk, partition, &part->info);
>  	if (ret < 0) {
> -		printf("Can't find partition '%s'\n", partition);
> +		printf("%s: can't find partition '%s'\n", __func__, partition);
>  		goto err;
>  	}
>=20=20
> @@ -684,7 +690,7 @@ static AvbIOResult read_rollback_index(AvbOps *ops,
>  {
>  #ifndef CONFIG_OPTEE_TA_AVB
>  	/* For now we always return 0 as the stored rollback index. */
> -	printf("%s not supported yet\n", __func__);
> +	debug("%s: rollback protection is not implemented\n", __func__);
>=20=20
>  	if (out_rollback_index)
>  		*out_rollback_index =3D 0;
> @@ -730,7 +736,7 @@ static AvbIOResult write_rollback_index(AvbOps *ops,
>  {
>  #ifndef CONFIG_OPTEE_TA_AVB
>  	/* For now this is a no-op. */
> -	printf("%s not supported yet\n", __func__);
> +	debug("%s: rollback protection is not implemented\n", __func__);
>=20=20
>  	return AVB_IO_RESULT_OK;
>  #else
> @@ -766,8 +772,7 @@ static AvbIOResult read_is_device_unlocked(AvbOps *op=
s, bool *out_is_unlocked)
>  {
>  #ifndef CONFIG_OPTEE_TA_AVB
>  	/* For now we always return that the device is unlocked. */
> -
> -	printf("%s not supported yet\n", __func__);
> +	debug("%s: device locking is not implemented\n", __func__);
>=20=20
>  	*out_is_unlocked =3D true;
>=20=20
> --=20
> 2.34.1

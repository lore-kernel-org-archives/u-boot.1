Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C5A7C54E4A
	for <u-boot@archiver.kernel.org>; Fri,  8 Mar 2024 17:48:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B6AE87EE7;
	Fri,  8 Mar 2024 18:48:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="EPNIJZGc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E494A87EEB; Fri,  8 Mar 2024 18:48:28 +0100 (CET)
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com
 [IPv6:2607:f8b0:4864:20::b31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ACC4587EDB
 for <u-boot@lists.denx.de>; Fri,  8 Mar 2024 18:48:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-yb1-xb31.google.com with SMTP id
 3f1490d57ef6-dcbef31a9dbso1760884276.1
 for <u-boot@lists.denx.de>; Fri, 08 Mar 2024 09:48:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709920105; x=1710524905; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e+CS+JFb8bHgjvNd4eScdt6/isws8nRMo6Nx7kU0KmQ=;
 b=EPNIJZGcfemd841IqypZcSi2UTCLfOXWiXNmAIKAxscl3KQLaTfplSyUSNeGmZac7Q
 OHCXx6Ji3nrW1IBcEEP3MKIjFZCNJ33p5jrvxihIpc0YDaLctBGWt7bMNR/XtC3BL4y4
 3gZxHquw3LLfxShjq4TauC3jl1gA3SWSjjzoauDWw2OYN277r4Xg88i3VWbUM84lOnZa
 mkklnBq6xUvH+xFn9LQJpIOepnQl9vQN1tX1SetXg01RGFWpo8lhC659YdIrLkVP6bKw
 72N7Ozpbglx1JD3NG4qMncQIhcWlx+tEF0i67cGWNuoskapS6aVfR6+BwkpAe9TB6eoN
 snMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709920105; x=1710524905;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e+CS+JFb8bHgjvNd4eScdt6/isws8nRMo6Nx7kU0KmQ=;
 b=wy0jKcoblkXGgTTyTg67uI/V931UOGUYFiUiVIcZkMtDnoP3JBnqWW/R2xmGq7jBK5
 oJr+uCTzZ2jIjhCAGzApLgLdh/tZaE+EOBQJkedbiCji1r4MmtcddS0FWQPQ/wWv5pb4
 xHjvv/5VaICUqbVmwOaxgsuvG0zfv2AYiyIrR6CNG83PTi/4GWWCBWu7BVvIuXgVfd4F
 qnQ30weRcaHOxFkQaLqYMCuIPDDi6yg1cN7bWGoWXLqVS1ttT6KQGqL+nc38W5pwklcD
 hJG9wvgL3/fLlyYQ8c4SUoaFBLJbhuHJaWJQjiVpQ4+sQLxpKtKC88uJFmhNwOjh3/hK
 2nBA==
X-Gm-Message-State: AOJu0YyHO5yJ2BIN6V0OECgAOnvM6UJOruuTSqxI+M0igVchGRy+i6eq
 Nz1ZDRSN3VPoH2mW+V21uI2ptT4+cOpVgG2aPnv+kreKyoRKO4mCXojjfP5KpW5KYcUxs0JyjsR
 aoA/WyjljQFmG0j+XIAvWWSmerURUXzyLeCmtDw==
X-Google-Smtp-Source: AGHT+IF+RnlxKiqfw6SHVePmdw1YDIyqisER9nCMhEQh82GsRde8ESucefw2gMa8ZrRPC9TpQMJnh1wNV9KH5rco61g=
X-Received: by 2002:a25:3355:0:b0:dc6:aed5:718a with SMTP id
 z82-20020a253355000000b00dc6aed5718amr19864901ybz.26.1709920105371; Fri, 08
 Mar 2024 09:48:25 -0800 (PST)
MIME-Version: 1.0
References: <20240307161711.3177729-1-colin.mcallister@garmin.com>
 <20240308165937.270499-1-colin.mcallister@garmin.com>
 <20240308165937.270499-2-colin.mcallister@garmin.com>
In-Reply-To: <20240308165937.270499-2-colin.mcallister@garmin.com>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Fri, 8 Mar 2024 11:48:14 -0600
Message-ID: <CAPLW+4mLemkC2vP5o-0Z=31c+hHDgc9DYsGu6c+u=WzU4ToWrQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] android_ab: Add missing semicolon
To: Colin McAllister <colin.mcallister@garmin.com>
Cc: u-boot@lists.denx.de, JPEWhacker@gmail.com, sjg@chromium.org, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Igor Opaniuk <igor.opaniuk@gmail.com>
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

On Fri, Mar 8, 2024 at 11:00=E2=80=AFAM Colin McAllister
<colin.mcallister@garmin.com> wrote:
>
> Found a missing semicolon in code protected by a #if that will never
> evaluate to true due to a separate issue. Fixing this issue before
> addressing the #if.
>
> Fixes: 3430f24bc6 ("android_ab: Try backup booloader_message")
> Signed-off-by: Colin McAllister <colin.mcallister@garmin.com>
> Cc: Joshua Watt <JPEWhacker@gmail.com>
> Cc: Simon Glass <sjg@chromium.org>
> ---

My R-b tag wasn't added in v3, adding it here so that whoever applies
this patch can add it as well:

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>

> v2: No changes
> v3: Added "Fixes:" tag
>
>  boot/android_ab.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/boot/android_ab.c b/boot/android_ab.c
> index c9df6d2b4b..9a3d15ec60 100644
> --- a/boot/android_ab.c
> +++ b/boot/android_ab.c
> @@ -221,7 +221,7 @@ int ab_select_slot(struct blk_desc *dev_desc, struct =
disk_partition *part_info,
>  #if ANDROID_AB_BACKUP_OFFSET
>                 crc32_le =3D ab_control_compute_crc(backup_abc);
>                 if (backup_abc->crc32_le !=3D crc32_le) {
> -                       log_err("ANDROID: Invalid backup CRC-32 ")
> +                       log_err("ANDROID: Invalid backup CRC-32 ");
>                         log_err("expected %.8x, found %.8x),",
>                                 crc32_le, backup_abc->crc32_le);
>  #endif
> --
> 2.43.2
>
>
> ________________________________
>
> CONFIDENTIALITY NOTICE: This email and any attachments are for the sole u=
se of the intended recipient(s) and contain information that may be Garmin =
confidential and/or Garmin legally privileged. If you have received this em=
ail in error, please notify the sender by reply email and delete the messag=
e. Any disclosure, copying, distribution or use of this communication (incl=
uding attachments) by someone other than the intended recipient is prohibit=
ed. Thank you.

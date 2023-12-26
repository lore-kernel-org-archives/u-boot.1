Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F3FAC46CD4
	for <u-boot@archiver.kernel.org>; Tue, 26 Dec 2023 09:52:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 66A33878CD;
	Tue, 26 Dec 2023 10:49:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="GZrQYkJd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 48ECB8791D; Tue, 26 Dec 2023 10:49:05 +0100 (CET)
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com
 [IPv6:2607:f8b0:4864:20::102a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ABCF1878CD
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 10:49:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-28c4673aa30so908201a91.1
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 01:49:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1703584140; x=1704188940; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8TWbzAYUbVaBMNOX5wjWxOITymJ8FplgDoY7fmLZ0tE=;
 b=GZrQYkJdfFWzBRk+L+NwLiva3G1QVLQowEwBrdvefaq8VPsNaGwQZfb3mG3BYqtnl2
 5yh2+Om8tWEGRWeTpthRUgQqh8TLxlM0AOkg/VKV+jUjAg/0mIUVc1qcGdW23OmlSk01
 HoKzaNBR68ceV4fgx/AbYH9F2G948UrNVAvO4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703584140; x=1704188940;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8TWbzAYUbVaBMNOX5wjWxOITymJ8FplgDoY7fmLZ0tE=;
 b=Qg4CJXh/i23vus9nb0nxb1Mea0+n0fgs2t7Ib87o7/HrWIXXAYgc8+h+J3NgXd/lvN
 9gjbwR789UlgL1Bvp6L/BqrvEOMyzgExSRBbI6LmNAJ7WnsZjXOB5LxFVGgi64aVpE5A
 2Ws2TSm2upBkyziK7zr27P+px+SSOW/TOQqDo5k5BHd+4O1aXzE6hCX8WWxYkyIfkBw5
 UvAamFPRpqyFLAjOl+siar+zscmZLi2t30RLemShYWtjq+JzbTNhok6Lul3CSh/wmXLO
 9ppUdP5Qq04TuKoZlkOlDwrggPswSryStWmQlispPjaTBfOQ79GD7Y8UMTyr1PHafnpg
 Z9Hw==
X-Gm-Message-State: AOJu0YzhOP4Msf0DUeqvlOCPSr6PE/lTswLcRWFlH5fG+HNtXpv7+lSJ
 w8nQarVbvlvtoHYXTuCw6YEkUof3Cqcyfvlp7eICvYQiuLYk
X-Google-Smtp-Source: AGHT+IF9htByXXW1dg8WQ95JqE5W3abCvLbHJiP4BciE6FdgOmJKFxAsOA3aCt1i9F18/j8CRW1ljbRZC3CNrhtxPfU=
X-Received: by 2002:a17:90b:4d86:b0:28b:e961:c416 with SMTP id
 oj6-20020a17090b4d8600b0028be961c416mr9253212pjb.10.1703584140069; Tue, 26
 Dec 2023 01:49:00 -0800 (PST)
MIME-Version: 1.0
References: <20231223004429.247301-1-xypron.glpk@gmx.de>
 <20231223004429.247301-2-xypron.glpk@gmx.de>
In-Reply-To: <20231223004429.247301-2-xypron.glpk@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 26 Dec 2023 09:48:21 +0000
Message-ID: <CAFLszTjgj3M4JQYWV4Vjz0KFM+14UMhs7nKL+vg_DOjHepSygg@mail.gmail.com>
Subject: Re: [PATCH 1/5] smbios: correct definition of gd_smbios_start() macro
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, u-boot@lists.denx.de
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

Hi Heinrich,

On Sat, Dec 23, 2023 at 12:44=E2=80=AFAM Heinrich Schuchardt <xypron.glpk@g=
mx.de> wrote:
>
> gd_smbios_start() currently points to a non-existent field.
> It should return the field written by gd_set_smbios_start().
>
> Fixes: 50834884a815 ("Record the position of the SMBIOS tables")
> Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> ---
>  include/asm-generic/global_data.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

See:

https://patchwork.ozlabs.org/project/uboot/patch/20231015024511.3995580-5-s=
jg@chromium.org/

> diff --git a/include/asm-generic/global_data.h b/include/asm-generic/glob=
al_data.h
> index e8c6412e3f..c1f7818817 100644
> --- a/include/asm-generic/global_data.h
> +++ b/include/asm-generic/global_data.h
> @@ -553,7 +553,7 @@ static_assert(sizeof(struct global_data) =3D=3D GD_SI=
ZE);
>  #endif
>
>  #ifdef CONFIG_SMBIOS
> -#define gd_smbios_start()      gd->smbios_start
> +#define gd_smbios_start()      gd->arch.smbios_start
>  #define gd_set_smbios_start(addr)      gd->arch.smbios_start =3D addr
>  #else
>  #define gd_smbios_start()      0UL
> --
> 2.43.0
>

Regards,
SImon

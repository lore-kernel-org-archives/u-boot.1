Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F326EC54747
	for <u-boot@archiver.kernel.org>; Wed, 28 Aug 2024 00:38:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 39C4F887B9;
	Wed, 28 Aug 2024 02:38:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="zjyhavMg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 29DF78897F; Wed, 28 Aug 2024 02:38:23 +0200 (CEST)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com
 [IPv6:2607:f8b0:4864:20::1129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7156F8876E
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 02:38:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-699ac6dbf24so54761037b3.3
 for <u-boot@lists.denx.de>; Tue, 27 Aug 2024 17:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724805499; x=1725410299; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nSMPNvvRE/Fws48aHMLMEeDStMg8yekG8vEPwTabMz0=;
 b=zjyhavMgkKnvaTgatubyNvRRCvByl8UxeTLiQDr/u1hZotwonvsjHGxcxWOGvOVV+E
 qmfTMWF0AJs79VP7sPq11QISOwS0ueojqG8Oe1HHWVXiNtVWSrkHNRlNtwg5STC4vsZQ
 M8As9zcSKTnvOWhBqY5iH4uQPqtuuNMVvV0TILw4tX792JlohScl+mUPNgc+4AyXlCSg
 Nilefmswjm4XKrFcsLZUUm2rS+AJKAvxrD4vTxlJm/jWW/0hlL4cvsN5HXKB0qdz1ohG
 zCQVo3XUtlg+f7O8ITkXWoz2AP9Z8d4LoaYg/fB80e58fHU8BtMo+8yy8BC0cMzc+TUi
 6s+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724805499; x=1725410299;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nSMPNvvRE/Fws48aHMLMEeDStMg8yekG8vEPwTabMz0=;
 b=nwsSReLmjjeC2Tq/svFn4I4kGLqiDCEGBTOeXiQFKSf4Jo4od+kZeXBXV4RXLjhAd+
 Py5zgwBW2FgxtbxAN+Zc5YPu0PeGqsyp19NrhBR6qXogdR2oPQcMv2Mb5i6cZUUQjNr6
 KcdMUjBOdTq4RVDdhSeu8VWVZoZFgXg6sgKid8hladbHZoVgOLdYSmsAR7uTTlCIQwcZ
 0KhpDFamEY7HHTbUCfe4GCVIXcQ2A+zv9kw/7z1SzHYfVcawnyEGvVYehUv3OMOV9MM3
 BMeXY0CwEpmJ5LxrgJhLWg9mHuAk3DJFK59mNDXDnjjrXw+xZ+i5WAiAZuvmRELoJNF/
 BgSg==
X-Gm-Message-State: AOJu0Yypi103caCD+7qDRNFDHxlab0CSRGPZoqOQ8B6WO826PWvu7O2z
 XQPKF6TiIac7uHV6Agxt5LLOBllJ4Ejsx1OwPXna9ilCiUk4Z3qDg9DkrvifTzd2PqKze0e9j8X
 7rLoAascTQhzSgzWMllD5ceMEwOBa56oFaDx5KQ==
X-Google-Smtp-Source: AGHT+IFgM/qdiNOS+VB5k3dTFaW5N2H+jjaYmKVB+qFgNGJ2OhlwbpurRmzyoqXFN2rnFtEqFkbS/b5gADuyd4LT/OE=
X-Received: by 2002:a05:690c:4082:b0:6b2:7bd8:d7b7 with SMTP id
 00721157ae682-6c629fd77a7mr113378077b3.46.1724805499198; Tue, 27 Aug 2024
 17:38:19 -0700 (PDT)
MIME-Version: 1.0
References: <20240807141434.733085-1-JPEWhacker@gmail.com>
In-Reply-To: <20240807141434.733085-1-JPEWhacker@gmail.com>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Tue, 27 Aug 2024 19:38:08 -0500
Message-ID: <CAPLW+4kyTO=c0JCepDd+S67ABDF3y0bK-xHiEOnCUXeA+8vvmg@mail.gmail.com>
Subject: Re: [PATCH] android_ab: Fix backup offset calculation
To: Joshua Watt <jpewhacker@gmail.com>
Cc: u-boot@lists.denx.de, Igor Opaniuk <igor.opaniuk@gmail.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, Tom Rini <trini@konsulko.com>
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

On Wed, Aug 7, 2024 at 9:14=E2=80=AFAM Joshua Watt <jpewhacker@gmail.com> w=
rote:
>
> The backup offset is in bytes, but was incorrectly be interpreted as
> blocks, leading to it being written to the wrong location. Fix the
> calculation and clarify that ANDROID_AB_BACKUP_OFFSET is in bytes and
> must be a multiple of the block size.
>
> Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
> ---

In addition to what Mattijs said, I think it makes sense to add
"Fixes:" tag for this patch.

>  boot/android_ab.c | 4 ++--
>  common/Kconfig    | 3 ++-
>  2 files changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/boot/android_ab.c b/boot/android_ab.c
> index 143f373aae..b253200161 100644
> --- a/boot/android_ab.c
> +++ b/boot/android_ab.c
> @@ -139,8 +139,8 @@ static int ab_control_store(struct blk_desc *dev_desc=
,
>  {
>         ulong abc_offset, abc_blocks, ret;
>
> -       abc_offset =3D offset +
> -                    offsetof(struct bootloader_message_ab, slot_suffix) =
/
> +       abc_offset =3D (offset +
> +                     offsetof(struct bootloader_message_ab, slot_suffix)=
) /
>                      part_info->blksz;
>         abc_blocks =3D DIV_ROUND_UP(sizeof(struct bootloader_control),
>                                   part_info->blksz);
> diff --git a/common/Kconfig b/common/Kconfig
> index 83c81edac2..e1b8557e0c 100644
> --- a/common/Kconfig
> +++ b/common/Kconfig
> @@ -986,7 +986,8 @@ config ANDROID_AB_BACKUP_OFFSET
>         help
>           If non-zero, a backup bootloader message starting at this offse=
t in
>           the partition will tried in the event that the primary one (sta=
rting
> -         at offset 0) fails its checksum.
> +         at offset 0) fails its checksum. The offset is in bytes and mus=
t be
> +         multiple of the block size.
>
>  endmenu
>
> --
> 2.45.2
>

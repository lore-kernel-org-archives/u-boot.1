Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD64FE6781B
	for <u-boot@archiver.kernel.org>; Sun,  3 Nov 2024 09:54:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B89A8909F;
	Sun,  3 Nov 2024 10:54:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XHGI22o/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C91EE890B9; Sun,  3 Nov 2024 10:54:17 +0100 (CET)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC3268907E
 for <u-boot@lists.denx.de>; Sun,  3 Nov 2024 10:54:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=igor.opaniuk@gmail.com
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4315839a7c9so28234815e9.3
 for <u-boot@lists.denx.de>; Sun, 03 Nov 2024 01:54:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730627654; x=1731232454; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wQzeNlBoRs7GzrQeHd6MG9ceCCPQkgVTcfJ1c0M5v/U=;
 b=XHGI22o/BQ5cxVQj2hGjGRFDQR/yXWj7N0M/qcoMhUSKtpTAK3B608tL+15V0J0I+H
 6HuiYe8UFz7qAzva07wN4UlDxX6Xc1yVwv2H0S9kS2GHH5vJUmFwVqqj6+iJuYougRWk
 EqpjBCySI84r2Ort7eZVWbhbIsJ58LaqyJOU8sRo0sTeQ+8PsegrOX1Oi+BuoDCKt8By
 kWuZa47kiR+X2h01WMyq4+XqzQMX5sZk7mZ0y1STc6UIFwq8quVnAdzxwTcAlmg6G2v9
 Dr8Xlv7bOlvRtF4xxMzgwSxWuA5C4Jz89D8Fq30yBR+iphH2dXYaL2pSx87n4m4WTcAe
 luag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730627654; x=1731232454;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wQzeNlBoRs7GzrQeHd6MG9ceCCPQkgVTcfJ1c0M5v/U=;
 b=aNuNMyl0iEKIBgz/u/ihC1cakdS37Ss37bimb/s1HD+V91v6OTBpjxW88MzPeTlf70
 xzPlXM12nqwDVY8L6VV9msjvIZ7/08F0eGThbNd1o4x6q3lL41qZRaQ6t2S7UJ/3Lu7X
 evjpdhpXx7rGZ2V45tqaLBa37nVPr6Khzd1GBXNZPhckOdcEN3JcVnC2ckhIac181d5K
 MW0KxO8z6FrvJkzegNFwomUOiAFllYgwbKXXa8KP4mn7Z/pON+Ehb32ukZuslKjMk8Z+
 Ubr/+ZhAN0qITq229ZdLO4heSHAiRZqfml5QJm/Pfl2xyWgpsbohgnE8NQUTucw1ipIW
 q5Gw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVoVzYtevHTvf08mM0NHfXmZVZs/GqmPVCY38a8EDyn67U+d07FCpxVqkL64ZYG1MaPwh52gzQ=@lists.denx.de
X-Gm-Message-State: AOJu0YwbAJzk6UlBId4aydKOJHqdUpdj0CnTRTexAP/57lAMX+TRl6Ou
 1HrYAZrKDYc9vOuRwr2Hsihy/S/J1afQcBoRZG4nNL6qnt8m3lOhjENGAyIhLplsNlMympi9U6+
 F3mt4l7yWfxVr2bNnpSiikQ8S54g=
X-Google-Smtp-Source: AGHT+IHoc3u3XYh6dPBvcQaZMjtja0ehbWKtRbvNl+klveq2DCu4uTkL1ywgVdwjNulxgUDkXi169D5loC+GhoJwwpg=
X-Received: by 2002:a05:600c:4ec7:b0:42e:93af:61c5 with SMTP id
 5b1f17b1804b1-4319acad2e4mr256516035e9.14.1730627654193; Sun, 03 Nov 2024
 01:54:14 -0800 (PST)
MIME-Version: 1.0
References: <20241102100836.103005-1-heinrich.schuchardt@canonical.com>
 <20241102100836.103005-2-heinrich.schuchardt@canonical.com>
In-Reply-To: <20241102100836.103005-2-heinrich.schuchardt@canonical.com>
From: Igor Opaniuk <igor.opaniuk@gmail.com>
Date: Sun, 3 Nov 2024 10:54:02 +0100
Message-ID: <CAByghJZkj4uQDUYGm46vYFdK5etJ1Fup36VGmrPkjkuEeD2Mkg@mail.gmail.com>
Subject: Re: [PATCH 1/2] cmd: hash: correct parameter count check
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de
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

On Sat, Nov 2, 2024 at 11:09=E2=80=AFAM Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> Since commit 348ea878508d ("cmd: hash: fix param count check") the hash
> command cannot be used without the optional variable name parameter if
> CONFIG_HASH_VERIFY=3Dy. 'hash sha1 $loadaddr $filesize' returns
> CMD_RET_USAGE.
>
> The minimum number of arguments is four no matter if verification is
> enabled or not.
>
> Fixes: 348ea878508d ("cmd: hash: fix param count check")
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  cmd/hash.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/cmd/hash.c b/cmd/hash.c
> index 60d482b7f87..5b40982b098 100644
> --- a/cmd/hash.c
> +++ b/cmd/hash.c
> @@ -25,7 +25,7 @@ static int do_hash(struct cmd_tbl *cmdtp, int flag, int=
 argc,
>         char *s;
>         int flags =3D HASH_FLAG_ENV;
>
> -       if (argc < (HARGS - 1))
> +       if (argc < 4)
>                 return CMD_RET_USAGE;
>
>  #if IS_ENABLED(CONFIG_HASH_VERIFY)
> --
> 2.45.2
>

Reviewed-by: Igor Opaniuk <igor.opaniuk@gmail.com>

--=20
Best regards - Atentamente - Meilleures salutations

Igor Opaniuk

mailto: igor.opaniuk@gmail.com
skype: igor.opanyuk
https://www.linkedin.com/in/iopaniuk

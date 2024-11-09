Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72FBFD5E376
	for <u-boot@archiver.kernel.org>; Sat,  9 Nov 2024 17:10:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7433A88D90;
	Sat,  9 Nov 2024 18:10:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VguNwgHj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2040D890C1; Sat,  9 Nov 2024 18:10:12 +0100 (CET)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com
 [IPv6:2a00:1450:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 280E788C0F
 for <u-boot@lists.denx.de>; Sat,  9 Nov 2024 18:10:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-53b13ea6b78so5427079e87.2
 for <u-boot@lists.denx.de>; Sat, 09 Nov 2024 09:10:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731172209; x=1731777009; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=332amsgZC5s2qVg5m6zvrCB9K96RMRR2kkYmnZxxols=;
 b=VguNwgHjAi+5xnpNliFszJC3phr6BoqHKrK+aA8OTCqUIjIK7bRSxsnkY5zGezqpWq
 oRxeZAWUAP5bH4mxyBflXLIqdQNPXRMe/tYDrV0oj7IEc+5qxmKCOlCiwFsMYHwQJOUI
 hWZFwLgr6qY7Ps6/kCy6hRERzsJP+w1Yub3qO0btOWrSsXz1qe9HVr24zFjgqMKrKsch
 Uax+6IkOyHQ3eMfiC1iSapzj1RyNPz6eBVWKtybDqHkm8Dz4I5maFssJV2TAR7OrluFi
 xnBRAVaj/XN/Aliu+Ll3ppnxESj8FQRGuFFc7/6uCq0hHc970bmDm7autYoorG+rWi46
 L3GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731172209; x=1731777009;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=332amsgZC5s2qVg5m6zvrCB9K96RMRR2kkYmnZxxols=;
 b=NrqtsNpkAknbe2wBMMQlM7lTAqx1SmMkUC8drTOyxDDmvUFpYuzrZ4VnKcAKn/A8Y7
 VZUmhk8t8HDDouRbmIOY3M6ScIExOu9gBR6RGtX/R6TAD1thulUgloWt7jwQQCQ3SIMj
 io6OV5FW9ZmEfmNT6F0AGwH/i3EwHHHa8ZxhCrn4pTxy7Vr8snQdFZWTmX2x3ruhqgBZ
 t//Jr+wA+YTMr2hJh+y+Y0buHrEglI6ZCPbeNPPhVswTBHIYLGG2FViK6r2tHQ1dSv2q
 NslAbRS1+39Iwv0LStDjPuNm+1Cb3TNgk3GJBQgsuNCm9StZazLMc11R0H/2Ql3d6eMK
 t7Qw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXyXz+epzQP7m+KRqV48vjcXUoNxSCkvFWkprnaqrleK4DNWiqdicJBJe4uWArvTQEFfhdisks=@lists.denx.de
X-Gm-Message-State: AOJu0YwJqdLC2gi9PTbvKKs0kqi464k/kdG9DNIwhdvRwLVCYaAGuUgs
 amF8tb4uEkrneIXLTmH2q/w17pikq9qHejMIXNOmXMWw9m6+bH1nWept+iTps34AsIwo4ryHuin
 7/hau8DlOlkJvjcb/cSxZW4Xcp+k=
X-Google-Smtp-Source: AGHT+IHwLrgeOOaapUenXaKt6VhGzTKs3bURndB8iCO0fjP7IYnsC7Mlc0fWScCc0WQHskK7Hcsn9OiNHwa3zvPrSiM=
X-Received: by 2002:a05:6512:b10:b0:53b:2105:18bb with SMTP id
 2adb3069b0e04-53d862f8165mr5140163e87.51.1731172209063; Sat, 09 Nov 2024
 09:10:09 -0800 (PST)
MIME-Version: 1.0
References: <20241101084921.4134231-1-paul.geurts@prodrive-technologies.com>
 <20241101084921.4134231-2-paul.geurts@prodrive-technologies.com>
In-Reply-To: <20241101084921.4134231-2-paul.geurts@prodrive-technologies.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 9 Nov 2024 14:09:57 -0300
Message-ID: <CAOMZO5AQE1_oRkfEmodTi8bJYXUxKgTN2RO45iDd+=NmGTryKg@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] imx: hab: rename imx_sec_config_fuse_t to imx_fuse
To: Paul Geurts <paul.geurts@prodrive-technologies.com>
Cc: sbabic@denx.de, uboot-imx@nxp.com, trini@konsulko.com, peng.fan@nxp.com, 
 ye.li@nxp.com, eduard@lionizers.com, marex@denx.de, fedor.ross@ifm.com, 
 rasmus.villemoes@prevas.dk, xypron.glpk@gmx.de, elena.popa@nxp.com, 
 tharvey@gateworks.com, sjg@chromium.org, u-boot@lists.denx.de, 
 martijn.de.gouw@prodrive-technologies.com
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

On Fri, Nov 1, 2024 at 5:49=E2=80=AFAM Paul Geurts
<paul.geurts@prodrive-technologies.com> wrote:
>
> The imx_sec_config_fuse_t structure is not specific to the sec_config
> fuse, but can be used for all fuse words.
>
> Rename the structure to a more generic name to be reused for other
> fuses.
>
> Signed-off-by: Paul Geurts <paul.geurts@prodrive-technologies.com>

Applied both, thanks.

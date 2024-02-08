Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BC23C48260
	for <u-boot@archiver.kernel.org>; Thu,  8 Feb 2024 14:35:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EEED587E45;
	Thu,  8 Feb 2024 15:35:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="h8Djo9St";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1ACFF87E76; Thu,  8 Feb 2024 15:35:14 +0100 (CET)
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com
 [IPv6:2607:f8b0:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC23F87E36
 for <u-boot@lists.denx.de>; Thu,  8 Feb 2024 15:35:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-5cdbc42f5efso443654a12.0
 for <u-boot@lists.denx.de>; Thu, 08 Feb 2024 06:35:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707402910; x=1708007710; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I61sQ9QtaXu5P5fbklSEzGta9ISfpy6vXQLHPZ2cJa8=;
 b=h8Djo9StUp0TGzguF8rNOquuIBfT6bzYMeV1fIS7S4rFWRIoRWNDW/yTI12CANyKey
 zkTd0N2ED2PEEIWER+qvKjmT7pdIOG76QlI4NudpM1CGr5eMBk6UFjEKDXRT+wXtJzP6
 o8rydgv2mmuWlEJ6iQ7xYF0mbxJRttxs9p6to3G76sCbnyEKa7TQI9pVMA44xdSVXmMx
 SQ7Vbs4TeE/Yhqvty23PInja+LHncEXQss6Yw9L/ePBcj1CWrhXwbK9pU3fFMuTOX3Qb
 JHYcqPLMLOPsRsk5OhzZCbRlVk9p3/64SPLdwACTA0iyUadN+SW+AQEeBZGNVrBgcGbt
 1H6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707402910; x=1708007710;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I61sQ9QtaXu5P5fbklSEzGta9ISfpy6vXQLHPZ2cJa8=;
 b=CINhes4O3HjbP/0ob0ISjo0u/860fKn2nWfCbApyl5wu2+DfUG/GdxtKMG3D9liZXi
 0qoBYBTG0nowGlpVQ0zfLEigGN7/VTbG2Ty540PlfNxAutmVWMYk3FCONjgFAakcLBWA
 DQFh+K7onZxder0nCTLL6t8yyjlMJt8/W1WWiPR/RUzxou5UMUVsR9bcaRWxFO2iATA1
 4tG3fRRNqs87xUr7jyReLBGQLWYy7q04IGUXrWdge3Q17nc6+VFhxjZ1DDak7dQyE0RZ
 CrYSbE8nkA3CDW0qioLy6uvDeFu7QQOhJ6whCJTisAYs3eSOzVyZRYJeFwIvta3eJp8L
 BDGQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX8fE5iD62pbfNZXFHY7RniOqD8oe5XK60taUm5aAcP0ORyS3B/7sqy2Pk+mUrm8TYemLNNQLF7YcT+sSrK3HYsXBzERw==
X-Gm-Message-State: AOJu0YyfCHlwKLRfhfGTT7Ivw7BPlWJrfUiXGjCKFLH05nlUgW1x57p3
 Uyo4fV/Qq4l6sgwb8dPYvVrBpmsD5cQquI3QCQJy0wPJmm/EsRR352mc56e8GnWw6cY+g8/Cxc3
 uW4EbhXQ58wrvsqMMnHNCSb4jtfM=
X-Google-Smtp-Source: AGHT+IFqRFDIQTCUodMM2ftqW+znHAjAcG0R/WiK++bitJfNccTLy1U9KQN1qloeNm9+KhA0x4LI2eHckMhkOO3N/nE=
X-Received: by 2002:a05:6a21:999e:b0:19e:5df9:c0f9 with SMTP id
 ve30-20020a056a21999e00b0019e5df9c0f9mr9375877pzb.6.1707402910308; Thu, 08
 Feb 2024 06:35:10 -0800 (PST)
MIME-Version: 1.0
References: <20240202160405.4126192-1-festevam@gmail.com>
In-Reply-To: <20240202160405.4126192-1-festevam@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 8 Feb 2024 11:34:58 -0300
Message-ID: <CAOMZO5A3tVw+FcXojQVns=XSUFf1P+UHik+W9PdEiQZVo3tdiQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] mx6sabresd: Fix U-Boot corruption after saving the
 environment
To: sbabic@denx.de, trini@konsulko.com
Cc: uboot-imx@nxp.com, u-boot@lists.denx.de, Fabio Estevam <festevam@denx.de>
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

On Fri, Feb 2, 2024 at 1:04=E2=80=AFPM Fabio Estevam <festevam@gmail.com> w=
rote:
>
> From: Fabio Estevam <festevam@denx.de>
>
> U-Boot binary has grown in such a way that it goes beyond the reserved
> area for the environment variables.
>
> Running "saveenv" and rebooting the board causes U-Boot to hang because
> of this overlap.
>
> Fix this problem by selecting CONFIG_LTO so that the U-Boot proper
> size can be reduced.
>
> Also, to prevent this same problem to happen in the future, use
> CONFIG_BOARD_SIZE_LIMIT, which can detect the overlap in build-time.
>
> CONFIG_BOARD_SIZE_LIMIT is calculated as follows:
>
> CONFIG_BOARD_SIZE_LIMIT =3D CONFIG_ENV_OFFSET - u-boot-img.dtb offset
> CONFIG_BOARD_SIZE_LIMIT =3D 0xc000 - 69 * 1024
> CONFIG_BOARD_SIZE_LIMIT =3D 715766
>
> Signed-off-by: Fabio Estevam <festevam@denx.de>

Applied all, thanks.

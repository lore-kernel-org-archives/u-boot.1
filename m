Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B705C19F32
	for <u-boot@archiver.kernel.org>; Thu, 27 Feb 2025 14:19:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D5F6B80FE1;
	Thu, 27 Feb 2025 15:19:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RMjkvMI8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2ECA181026; Thu, 27 Feb 2025 15:19:07 +0100 (CET)
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com
 [IPv6:2a00:1450:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED36B80F12
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 15:19:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-30a29f4bd43so10396651fa.0
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 06:19:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740665944; x=1741270744; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=70FUYiZt2Hyv4FITDTfgM6clphGFkT/fj+nrUMf9mkc=;
 b=RMjkvMI859jYk2mYZ91u2Uacj1oMWx2J5Hbq8X9i1c3xwyLw/GeJj8RuAsUur1egLr
 RZSgu1xqndgwAAsVuoe9xzL2XshvGiXxpLjHDMdF2nzhaczFfhsbe4fI6hRNruuixsYO
 T4ni6WMcopToToY80CTuzmIAlQh1IGoIBYUHFv5pxA0dOHfhd7NuV1mt427RZ/hCYpZK
 NyVX3Gy0co4nZTEOu7j/LZheCGLy6YT/9OROuT855dAtTKpP+bE7AB3RbPSvVgYbF6Z+
 Z+Vo5LPSc2ZUF/OA8g1FJ6TMmz5m7G5aSagvvkOuPUAY1ZbkQM6xpqYWz2FRcQEPgZNn
 OVUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740665944; x=1741270744;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=70FUYiZt2Hyv4FITDTfgM6clphGFkT/fj+nrUMf9mkc=;
 b=CAqARIUHm9JOvcYmPWd0WTKCS81kdoGEIP7t8Wqu724xDG5RABA3qOQcs9hICnQeaM
 2ZIRmbOSK0n2VrWTNTAGsNKjROz+WKqaIg9S2QO/GysbkAGVUrx3VLYoeAOdLxskF2ni
 YizlNX9u9v12U8BXZwB0N8IqktRidfDV33/eGKASOlknzM6aqilPuKn7JKynvXplPKd6
 TR63v6mAYPHk7SZAf2YL7/hckN9HZWN2Xez43Gg5i5qXkabSv14Am/y5WdxpNiOIIPK4
 rY6Ci8Q+Ee3++tslp4ZuABIN1dnCqmcgv74Vy37YDjRbkGCD+xcLPdzRCCAH1l5mTJHd
 2y4w==
X-Gm-Message-State: AOJu0Yy1YcWROxwNmvevndVznFbocKAUGq5cxF4bG0krZwl3PBwSGg6q
 KfSwHvrXxVtI0gm3fp/fFE4F2DCk2pggD5K46PczPabuhysF5sle3p1MliP/bvLsiLEIb20zNK6
 yRQIer8VDgGQ+upm+w5TDr9+doOY=
X-Gm-Gg: ASbGncuXvMLlK5gEkpAS0sj3X0d3ziECNaE5Cpmgu+JP+UseSM52PzuPzirXCHbgRXk
 68YrrBLUGjUTLMF8a/4R2GdJ7ivLSSt6Pa+McWmCXY6sIY6Ls5ftEAkZjvvfVectipL5g1jbCj8
 KGJXzx8wzMBozhE+wkHmZnck6yHwTjwCVvOsGUVKM=
X-Google-Smtp-Source: AGHT+IEGRur9bxmkGU6OdSA8U6Ji2fay324WQK87NZ9bi+KDXv5lK8uEFrauP8eSawfkouvWL6RKjabuRKanMz8ARYQ=
X-Received: by 2002:a2e:934e:0:b0:309:24c1:73e1 with SMTP id
 38308e7fff4ca-30b7915f761mr42819381fa.12.1740665944052; Thu, 27 Feb 2025
 06:19:04 -0800 (PST)
MIME-Version: 1.0
References: <20250221170738.184822-1-marex@denx.de>
 <20250221170738.184822-2-marex@denx.de>
In-Reply-To: <20250221170738.184822-2-marex@denx.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 27 Feb 2025 11:18:51 -0300
X-Gm-Features: AQ5f1JpEn7oG_uFu6uQ9Atml7ro7EM6rKO2Lqrf67ln-HMhlpOHim14vtFv0P70
Message-ID: <CAOMZO5CME_-bxtXSjZdpVZ7F7d3Yxx7s3EFvuUDNYKc6ta7aRw@mail.gmail.com>
Subject: Re: [PATCH 2/2] ARM: imx: Fix CONFIG_BOOTCOUNT_ALTBOOTCMD duplication
 on Data Modul i.MX8M eDM SBC
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Sean Anderson <seanga2@gmail.com>, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
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

On Fri, Feb 21, 2025 at 2:08=E2=80=AFPM Marek Vasut <marex@denx.de> wrote:
>
> Deduplicate the config files again, move CONFIG_BOOTCOUNT_ALTBOOTCMD
> into common imx8m_data_modul.config .
>
> Fixes: 940135eea5df ("Kconfig: Move CONFIG_BOOTCOUNT_ALTBOOTCMD to Kconfi=
g")
> Signed-off-by: Marek Vasut <marex@denx.de>

Applied both, thanks.

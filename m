Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75772C47DAF
	for <u-boot@archiver.kernel.org>; Mon, 22 Jan 2024 13:01:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B208587BB5;
	Mon, 22 Jan 2024 14:01:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YZTAvKE9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C6B6E87BE1; Mon, 22 Jan 2024 14:01:31 +0100 (CET)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9AB5E8796E
 for <u-boot@lists.denx.de>; Mon, 22 Jan 2024 14:01:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1d722740622so3205155ad.0
 for <u-boot@lists.denx.de>; Mon, 22 Jan 2024 05:01:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705928488; x=1706533288; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hPZDaHfL1q9B7ayvakOw6JjtFsWG6QFkGLrLYD8dIAc=;
 b=YZTAvKE9q4Mrobp6u1h1F117NanmnaQxopXcVwciqe0U3slqTge+oFsYsg6C8mT8Ig
 7QF5xrCK0aZ76FDUNvVJ//8H0DRQ1NWTxIVsafJe1hL6QSY73JlItZodlFODA3jVYw6K
 tx9svLXudWE/yb3qq1U2nLCc7IAlXYYlPnAlzJh8TIxQV9d1J5NHowN8BOR0//M1X8nI
 6kmA4hKTV27JlhEf+ioCs/XW2quJfHv7itgh4T9uHkBZieHvHJ46F2Vl2WJEwhTHlv6D
 wahFrNyRaU9RdISaRIJot7rEXFp9hw28qRa0Cun5I2UKkX5U4sHXq4L1e3nSrNxOYwQo
 Kpwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705928488; x=1706533288;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hPZDaHfL1q9B7ayvakOw6JjtFsWG6QFkGLrLYD8dIAc=;
 b=aDRzOHI6dCLEvL4Y/x/FLySamOGrJDrmHdTfBhR/snwBpQcc+I9ajitgV/itsHS7sI
 JtghcL/jOaAmjzyKwp1G9gun8sXZAVTtg3rCrD2zt/k8UyCrOsRqzCDnimp8RN/d9C6g
 sz3T8RiaN1S2oR06N6d/j4Ry+zEpq4y5OCqQowh3KaoLiGAccmU0RmQJYZetsJumpyFE
 Q0H+oNx/q3Fb9V8PadscgeV4exDvKr2lxh80gBi6B/JTTCrnWQXTKmDpikYTxbVqiV6L
 1a8D5VTMkTHN6EKF8yu2xUcGclfOeAjCFnP33+KRlzxWmM4lN9ZcphPLRyZvAxe0xbKy
 M2Pg==
X-Gm-Message-State: AOJu0YzVfm5xAL+aPgC1msNnTyTeD38eTm0+h2E+evLOQqB3ZeSlUAtm
 uk9eU5IW7SI78Q11mty+AdarkG/0CaK0XgdnCCL+ucI1RBqAHqFZly86Hob6Mp24H1PEOmOqNrY
 OQ9y0qrihHJX8ZeWoMElRlYW9BSneTRVd
X-Google-Smtp-Source: AGHT+IHoAEgh5XaPdYdbUQXUj3AKB8ptDhUfa4liyUpFgm6fdkuGbSWcKTACfOte/ikJOAPUNBS9wka0k0B7VVv9E3s=
X-Received: by 2002:a17:90a:cb8c:b0:28e:8e5b:73fd with SMTP id
 a12-20020a17090acb8c00b0028e8e5b73fdmr5209054pju.4.1705928486299; Mon, 22 Jan
 2024 05:01:26 -0800 (PST)
MIME-Version: 1.0
References: <20240119194134.681075-1-festevam@gmail.com>
In-Reply-To: <20240119194134.681075-1-festevam@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 22 Jan 2024 10:01:14 -0300
Message-ID: <CAOMZO5DK+TqZDY5x_U47xXo0+4Bwgu-RrEmiwW_LusqO-BE=qg@mail.gmail.com>
Subject: Re: [PATCH] pico-dwarf/hobbit-imx6ul: Convert to CONFIG_DM_SERIAL
To: sbabic@denx.de
Cc: u-boot@lists.denx.de
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

On Fri, Jan 19, 2024 at 4:41=E2=80=AFPM Fabio Estevam <festevam@gmail.com> =
wrote:
>
> The conversion to CONFIG_DM_SERIAL is mandatory, so select
> this option.
>
> Signed-off-by: Fabio Estevam <festevam@gmail.com>

Applied, thanks.

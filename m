Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C90ED5E376
	for <u-boot@archiver.kernel.org>; Sat,  9 Nov 2024 17:10:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DAC45890C1;
	Sat,  9 Nov 2024 18:10:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hDftR9d1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E45A88C0F; Sat,  9 Nov 2024 18:10:39 +0100 (CET)
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com
 [IPv6:2a00:1450:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 84FD4890C1
 for <u-boot@lists.denx.de>; Sat,  9 Nov 2024 18:10:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-2fb518014b9so25051221fa.3
 for <u-boot@lists.denx.de>; Sat, 09 Nov 2024 09:10:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731172237; x=1731777037; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s7rNw+CvOj91RHFWO90TT2y0v1CH9BcxwyNb3JkZDZk=;
 b=hDftR9d1y1iGOtcZ/QvfkMGBA6xCvp1x1bVd4IGnlBXP1zFEbUj+BKGx6xC5qQiinU
 s9m7lQyJ9ZYK9Y8zEqsuKJipwj5kpfMg+1ukcr+4+Ai0ep7Mjji0CE245TerNA3xRacz
 nFEy1sgFoehi+fKtZsnN8KT3JY+Rwp2EgSRltDYHLjXA6UL+3olpN0v/wh6/eTaGX8Xw
 LD8+ER8k4Cl0EdFIcmtVSVtoyahZzNh8CZjEKS7oQxWS5TZrAY5nrmxjJZgRo7dHHYq8
 o/GHaGqtRBbYe4/4y/cLtBWXmkXIlWnC3XLbdrisfnF+WzPqoQdWTDF0vCj6zW1odLiz
 PZ3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731172237; x=1731777037;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s7rNw+CvOj91RHFWO90TT2y0v1CH9BcxwyNb3JkZDZk=;
 b=t+PCoxOxwSbY9rtgfIK9sKSl+hSsKMhWR8MPS8RcEaUHFr6eVsbXYiB24ZdBXWtwGP
 KvqDkw2lTONiwgvztZgNBmsI+crXQdEb8Vkn27Y57K9SX/S+OqVahiEUbx5Udnhf9qST
 KMkW4sRrW5T33iXgVJmJD6G1XMb6VxRIdmmlsifL2TirQDjrmWRM3w91Fh+BAUuGjdRm
 uI0WjruTvyCv+y0Qr8nTRyJi4KXEa+6HEGiKsgxCGYYxWuuqv/NUAu7xiRmVttNd9Qrb
 LfGPH5NSl14aGK/MUGii0YeD3QdrTL+sSvrhvT6W9PCfDPglxZLemM4322W2b0D3K+mk
 WlXg==
X-Gm-Message-State: AOJu0YzI6O2JauSZy8+DZ5RcmlQas4shdwqEjED6UjHWBsPG9eWwtbt4
 3UGZdCG7uCos3QPmMPuTprfyl4soHantwer6wvW22KUJq8ZHJm8G2G5xpjyjtYA0BgpNcCjqmm+
 uXErRaVLRIR235YFUQ5ObpMQoTqY=
X-Google-Smtp-Source: AGHT+IGK8+texI6ryBOfwt9ss/brESso2bAJMPfopdmQJFrYC6geM0+hCtjzff2j+s2DT96oFsiSxZaWAaLculzY8u4=
X-Received: by 2002:a2e:a9a4:0:b0:2fb:4abb:6fe1 with SMTP id
 38308e7fff4ca-2ff2015279fmr32141971fa.4.1731172236446; Sat, 09 Nov 2024
 09:10:36 -0800 (PST)
MIME-Version: 1.0
References: <20241101152618.1118-1-egyszeregy@freemail.hu>
In-Reply-To: <20241101152618.1118-1-egyszeregy@freemail.hu>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 9 Nov 2024 14:10:25 -0300
Message-ID: <CAOMZO5AbywqyNefoaeX6aHhYKaqh4amGUkxSW9xn6WY4AZ0OUw@mail.gmail.com>
Subject: Re: [PATCH v2] imx9: Improve boot mode autodetection
To: egyszeregy@freemail.hu
Cc: u-boot@lists.denx.de, sbabic@denx.de, peng.fan@nxp.com
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

On Fri, Nov 1, 2024 at 12:28=E2=80=AFPM <egyszeregy@freemail.hu> wrote:
>
> From: Benjamin Sz=C5=91ke <egyszeregy@freemail.hu>
>
> Improve "mmcautodetect=3Dyes" boot mode autodetection to able to use it
> if CONFIG_ENV_IS_NOWHERE=3Dy is used for i.MX9 SoCs and i.MX93 EVK board.
>
> If both CONFIG_ENV_IS_IN_MMC=3Dy and CONFIG_ENV_IS_NOWHERE=3Dy are in the
> defconfig, CONFIG_ENV_IS_IN_MMC=3Dy will be overiden default
> CONFIG_ENV_IS_NOWHERE settings.
>
> Goal is in this patch to able to use the boot mode autodetection
> if defconfig use only CONFIG_ENV_IS_NOWHERE=3Dy option
> (without CONFIG_ENV_IS_IN_MMC) for any i.MX9 SoC.
>
> Signed-off-by: Benjamin Sz=C5=91ke <egyszeregy@freemail.hu>

Applied, thanks.

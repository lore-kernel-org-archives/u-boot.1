Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C943AC4345F
	for <u-boot@archiver.kernel.org>; Sat, 20 Apr 2024 18:34:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4635788792;
	Sat, 20 Apr 2024 20:34:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OuB3ulVJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B5BFA88794; Sat, 20 Apr 2024 20:34:41 +0200 (CEST)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com
 [IPv6:2607:f8b0:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6973388785
 for <u-boot@lists.denx.de>; Sat, 20 Apr 2024 20:34:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1e84787b0a8so4327975ad.1
 for <u-boot@lists.denx.de>; Sat, 20 Apr 2024 11:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713638078; x=1714242878; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xgHyhtL7JNTBBwLC9N3i2ppo27sHtw/urG7uOHkCz2s=;
 b=OuB3ulVJ8ylFNdL8lVm6Un74qByIPmhQmZF9XDZBIMRx+daF28Uh49axqk63wvXWYs
 nUMa/CsOICXYGnlhhFppNyUMHzPPAPhbWqpHGCskjn5M47Hf6FOoHQosMcO6vb+G0Xvx
 F5yN2mJg2dNw4ymfHEteFEeaFnyXX5hBF9fCn7+8CkcU9SJL3SwGuvh4uhmEg3Q254n0
 fV7MHrNW84oLJV5SMzJp9u3ZeMt4Co6tbyyvGsAHt0bRef0wm+LdnKxeJEEIZiven2M2
 2pJQGLgIcUq5LGZYhPZtlW/QmdIqIbFxn+ppI68XHrXmkAbSQt7Ki+FvkBTFJIcDgm6e
 oWTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713638078; x=1714242878;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xgHyhtL7JNTBBwLC9N3i2ppo27sHtw/urG7uOHkCz2s=;
 b=nqi+XWXMb8SOR8cUOHRIqImkgX5XT5n6/Ini+PyCezg9N5gesnO3uJtGWUCh7oMySR
 8ngBpdStxRUpevKP1lmjV+4+8OYQAyXrfG40GrZy0gFD30/g+VwuUZQ54fteaVtzCuip
 A1MNGbB2CwcnsZPfMFSwHwSPbAymw/7vuVBmsQXmDstJTLRLJGYDZUNmvBov38T1PCLU
 RcZFQVyQX0qHFjC/C579X4IGGipPZfzVmucQLt2SezpnbwF+5zTuVproJDOAVpP2ZHSJ
 VGHGlWTM14IY/P1h6WqCwsC/CYLlMdMryNh0lTas6T1Po1uvI+U+bkgGjqTozPJmNy71
 CJKQ==
X-Gm-Message-State: AOJu0YzEvIj3rcdA/ZhDbMt1oEES52FfOcWlAyHOapQcY1l7ZPcMHc57
 neWKq108KgRwCoEN0NPfAWehHOY4wmfLXd/QxHZuCrdfBNAPTKYI5RVRZcTnIuFjcyiIQpN1b+J
 4Xhln0fIHmR9nhURTDxELo3n5NZ0=
X-Google-Smtp-Source: AGHT+IFwZ3QLfKQeewUUtTex/ywR78b+RW6end3ZthMbfeikNaN3vGmYAe2jek+ZgMVBOsEKNx1OJUEyVm2mrs4wfg4=
X-Received: by 2002:a05:6a20:afa8:b0:1ab:7107:d968 with SMTP id
 ds40-20020a056a20afa800b001ab7107d968mr6576601pzb.2.1713638077875; Sat, 20
 Apr 2024 11:34:37 -0700 (PDT)
MIME-Version: 1.0
References: <20240325162739.1350665-1-tharvey@gateworks.com>
In-Reply-To: <20240325162739.1350665-1-tharvey@gateworks.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 20 Apr 2024 15:34:26 -0300
Message-ID: <CAOMZO5AtYqPEvR0zNDMYSouzwGDQ0JNqPRbubaQ3X8=nWProAw@mail.gmail.com>
Subject: Re: [PATCH] imx8m*-venice: enable TPM support
To: Tim Harvey <tharvey@gateworks.com>
Cc: u-boot@lists.denx.de, Stefano Babic <sbabic@denx.de>, 
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>
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

On Mon, Mar 25, 2024 at 1:27=E2=80=AFPM Tim Harvey <tharvey@gateworks.com> =
wrote:
>
> Enable support for TPM2 devices. As the ATTPM20P TPM2 used on the
> Gateworks Venice boards hangs off the SPI bus we enable SPI support
> as well.
>
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>

Applied, thanks.

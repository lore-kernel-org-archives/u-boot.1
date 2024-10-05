Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E968CFB420
	for <u-boot@archiver.kernel.org>; Sat,  5 Oct 2024 16:48:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA30888CBB;
	Sat,  5 Oct 2024 18:48:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cWj+IuNV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F40888CC1; Sat,  5 Oct 2024 18:48:56 +0200 (CEST)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com
 [IPv6:2a00:1450:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B34598897F
 for <u-boot@lists.denx.de>; Sat,  5 Oct 2024 18:48:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-5398d171fa2so3642408e87.0
 for <u-boot@lists.denx.de>; Sat, 05 Oct 2024 09:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728146934; x=1728751734; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vy3EgYMGNLJII+ccT0MUNGl87bSEN1Bf0V7XxkhMU7c=;
 b=cWj+IuNVZKzJNb7rQ9WienuJuSdWqdVuO/GK5reOGFpsV5qmRgoZNicVCXDb3QSYrr
 O5XUvLsEChR8BBhWg3KYjE51j1+hjjWWV+A2mV2pNY/UIjA/nMfXd0MTRe2Ev4YhXzjm
 f5AWn6Mh9oq6oMonavpDuTDQwMiuIcBJ/dcOfPxzjLwQRe/OxGJgkUPm5mb4v2WY3Iu1
 yRjetFzE3W2SXDdbvB4tJJrJxOf0uy7WjaidtFBYwZ/Bf1EtgdKt41sDVtLHl4cmvCJq
 agRCrzDMQ3Mt8xZaoJ4UDCqGBnWJIrSsIQ2V6ZEdg+hHhfixGNBC8NMH949YijPYjN1z
 EzIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728146934; x=1728751734;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vy3EgYMGNLJII+ccT0MUNGl87bSEN1Bf0V7XxkhMU7c=;
 b=gM4w+pkGYo6iKT3D5pXbLnMFdh9Oaq/KdRUqGv5YPvsdLk7TEqP5w3rXas95YoDaXo
 WcBNSkInk2WPoHTkRk3mMPi041/JbOMt6Y/n7v3zGAe2gqeA1+pW0GDbJlsROGG5x3if
 7RJnVbqVVJ57t5kV03oDlD0UUoiXzM2Rbaq7wiKvAja2nh9nejaIM0igdOJMfOutPxLR
 4L9UzEhayanGlogU8zKD3jbpXhJ5dukb9vZbQvOIIbbVq910U4Y4IIl1RgDtdCtav3Hi
 6mcnIjtnDJZArTlaE6N4GIwxAw9hOXVLx127RmKn2uoOvPxyMhjZzV8hk6nXmFGgSomt
 844w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXeGFVQ0rmzLCdXxHce58U+Y2/tBT+5pTsDZPUbOzTCOjzV7PtjdeD/W4/7UUvwssMdgQ3Ni0Y=@lists.denx.de
X-Gm-Message-State: AOJu0YyQU2R/xX6d1l16IriEN1sxxxeyjv+aAU7rEa368cb4sz6TRPOg
 hRgpEZZQ13J08fkBYVRXdGYjvTCJqMqCOxVot9aNSzVAmANDegmafTH6E7NBjEIrl65DwfB3Xk0
 v+LN7cCRL7G0cYPQQagvNtE42tE0=
X-Google-Smtp-Source: AGHT+IGgFS+OmxB7rF+OEkKv7ShbxGKYFwwqNjY5ytbzgqq+U+35A/O8B5UvuSA2D3AO6jLpi4/5IM3cmZk/ERwkb5M=
X-Received: by 2002:a05:6512:2348:b0:52e:7542:f469 with SMTP id
 2adb3069b0e04-539ab6d903emr3484085e87.0.1728146933693; Sat, 05 Oct 2024
 09:48:53 -0700 (PDT)
MIME-Version: 1.0
References: <20241001160152.336121-1-ivitro@gmail.com>
In-Reply-To: <20241001160152.336121-1-ivitro@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 5 Oct 2024 13:48:42 -0300
Message-ID: <CAOMZO5DPKyeZBfseOdcZigahC9-F1YpOyiTa4UnxtNCrmfJffw@mail.gmail.com>
Subject: Re: [PATCH v1] arm: imx: imx8m: soc: Fix VPU fdt disable fixup
To: Vitor Soares <ivitro@gmail.com>
Cc: Stefano Babic <sbabic@denx.de>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Tom Rini <trini@konsulko.com>, 
 Vitor Soares <vitor.soares@toradex.com>, u-boot@lists.denx.de
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

On Tue, Oct 1, 2024 at 1:02=E2=80=AFPM Vitor Soares <ivitro@gmail.com> wrot=
e:
>
> From: Vitor Soares <vitor.soares@toradex.com>
>
> With the introduction of downstream Linux 6.6, the iMX8MP VPU block
> control node in DTS was renamed "blk-ctl@38330000" and will not match
> the ones found in `node_path_imx8mp` resulting in the node not being
> disabled on the VPU-less variants.
>
> Add an extra node_path entry for imx8mp VPU block control that match
> with downstream Linux.
>
> Signed-off-by: Vitor Soares <vitor.soares@toradex.com>

Applied to u-boot-imx/next, thanks.

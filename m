Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF403CCD18E
	for <u-boot@archiver.kernel.org>; Tue, 14 Oct 2025 09:28:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 44F3780422;
	Tue, 14 Oct 2025 11:28:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=googlemail.com header.i=@googlemail.com header.b="LdMMrJOZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 62FE9807B1; Tue, 14 Oct 2025 11:28:21 +0200 (CEST)
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com
 [IPv6:2a00:1450:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 59F1B802C1
 for <u-boot@lists.denx.de>; Tue, 14 Oct 2025 11:28:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=googlemail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=yegorslists@googlemail.com
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-36d77de259bso38064271fa.3
 for <u-boot@lists.denx.de>; Tue, 14 Oct 2025 02:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20230601; t=1760434098; x=1761038898; darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U3x1KLzXycEYZBDesydnnapjBOU1/QooG3q3308qmUA=;
 b=LdMMrJOZ6XoUESq1pM15w3miMJ2Lu21JACj99NM2fTnuY/kVh12+8AiLuArI4JC5D5
 s5YdFVnQMFXfE+LueC97Bsjjcrkjpq7RargisYFw74BJ7r/uF4KU3uiBVKnXOqMhEibT
 gYlaLG6SgFcycs9g6CbASrNPd1GOfbO+jwnUPf4eZB9tuF8G9xO+47dV8e/zFbgvVFUc
 MdZcdt+bSzfEbKr28KpHvYLlmzQw4kZkwcwUEHnKVLMimvKMJGZHgAQvv9IlDmj6g4iE
 seZSc3RBSXvufaMmsmFL6Gwr49lBAiL7Jm+jHj908nnczVx1RteKjFiIDtwAvLPchvIp
 ptEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760434098; x=1761038898;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=U3x1KLzXycEYZBDesydnnapjBOU1/QooG3q3308qmUA=;
 b=iq8oF9yvg020M+/DaHrqscXh4/lg62dpUihQ2YKddWQfQksS+WPg2RFc31B8TnNTg8
 O8meCB1RVMlIBAUptDrYej1PtGEhy4g5W4QnH1qkgyeGrnyV8m8qMgXEDZob0Yw022Mt
 9Gyyyw6SQiOTjAhsAvF6RiAytf5MuwG5odPJ7yLd7YG1STlmGjCCgQFSeFETSaO7EyQE
 uzMIGDUl8/hw4gpQwflMn8gB6bVxgE498vnLiese9cZ93wOD+ZmIbzYyuxn1JkRcyrgs
 Oh/y5YWctubThQPeNCxAptychOZe5URVRT3STSG/h+3l2/9xCp6ZhZEe6tASheA/IXkL
 rtjg==
X-Gm-Message-State: AOJu0YwfncgxGN9w28D/dsGkSHYZeAVJl1gl8Ly+18YBSEK20u1G9Op5
 INufoXs/QvtqfIrOuJJb+9VJcvRx+7l4mAYC34Jiwv/yZfIO0pA93HRN+rcu1zEdQ9Ea5nS52/l
 SQinJYY/T8jHkuN6wTianRW0N1WjS+7c+e3Ks
X-Gm-Gg: ASbGncs8Mg7gJFabR+/E77FeB8K02MKTTtsxUIWRjAAVPRY8udOZhrauB4Oe2QCSGnq
 OodjYaXRa3d28tqq5RNhqSgMG+jf0L2uN7DNggOe41MCtec4qmDx7wK+LBhN8PFy/fG51dn+VOC
 BYLeEWdAUr30HUfY1qU1BCX1PQoPA+fWwdugn2vX0wkWZo7WAOCGd61zIXG83uShSMQFXJskPz0
 fuHkVAg++AgFZOe4rXhYtEJ32haOy15veYT8fGwDJUusg9b
X-Google-Smtp-Source: AGHT+IEDjTPDkaPbE8qBY0en4y4NaYQdpOn3F5Vr51Azw6BzRtsgArU2EvtmCQitDXdQBWPDpraBCwQCyNKCGUUMrY4=
X-Received: by 2002:a2e:bc14:0:b0:36d:501:76e2 with SMTP id
 38308e7fff4ca-37609d40f16mr61907801fa.17.1760434098380; Tue, 14 Oct 2025
 02:28:18 -0700 (PDT)
MIME-Version: 1.0
References: <20251013130902.74719-1-yegorslists@googlemail.com>
 <DDHQS4TT6S6Y.1N61MTMFVTJBP@ti.com>
In-Reply-To: <DDHQS4TT6S6Y.1N61MTMFVTJBP@ti.com>
From: Yegor Yefremov <yegorslists@googlemail.com>
Date: Tue, 14 Oct 2025 11:28:05 +0200
X-Gm-Features: AS18NWCuJyBFMfAdMoi8njzF074vjk84lhDR6uRQ0C60MpnqbiNqn7LuUrZq8G4
Message-ID: <CAGm1_ktEZBu+MRThxW_BMF-S3qqPQ0AErArDoLGjC4qwTse9fw@mail.gmail.com>
Subject: Re: [PATCH] arm: baltos: enable TI_SYSC and CLK drivers
To: Anshul Dalal <anshuld@ti.com>
Cc: u-boot@lists.denx.de, trini@konsulko.com
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

Hi Anshul, Tom,

On Tue, Oct 14, 2025 at 5:58=E2=80=AFAM Anshul Dalal <anshuld@ti.com> wrote=
:
>
> Hi Yegor,
>
> On Mon Oct 13, 2025 at 6:39 PM IST, yegorslists wrote:
> > From: Yegor Yefremov <yegorslists@googlemail.com>
> >
>
> Could you explain a bit more about why this change is needed in the
> commit description?

Both are required for GPIO drivers to work. At least, for the OF setup.

Should I add this description or can we embed them as dependencies for
CONFIG_OMAP_GPIO?

Regards,
Yegor

> Regards,
> Anshul
>
> > Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
> > ---
> >  configs/am335x_baltos_defconfig | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/configs/am335x_baltos_defconfig b/configs/am335x_baltos_de=
fconfig
> > index 5c43503ff32..93a5fb94adf 100644
> > --- a/configs/am335x_baltos_defconfig
> > +++ b/configs/am335x_baltos_defconfig
> > @@ -53,8 +53,9 @@ CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=3Dy
> >  CONFIG_VERSION_VARIABLE=3Dy
> >  CONFIG_NET_RETRY_COUNT=3D10
> >  CONFIG_BOOTP_SEND_HOSTNAME=3Dy
> > -# CONFIG_TI_SYSC is not set
> >  CONFIG_BOOTCOUNT_LIMIT=3Dy
> > +CONFIG_CLK=3Dy
> > +CONFIG_CLK_TI_CTRL=3Dy
> >  CONFIG_DM_I2C=3Dy
> >  CONFIG_SPL_SYS_I2C_LEGACY=3Dy
> >  CONFIG_SYS_I2C_EEPROM_ADDR=3D0x50
>

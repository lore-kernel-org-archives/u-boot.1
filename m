Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39530C10F1A
	for <u-boot@archiver.kernel.org>; Tue,  7 May 2024 14:30:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AFAAA88719;
	Tue,  7 May 2024 16:30:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BKSasrqI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4EE0E88723; Tue,  7 May 2024 16:30:32 +0200 (CEST)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 06080886EB
 for <u-boot@lists.denx.de>; Tue,  7 May 2024 16:30:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=igor.opaniuk@gmail.com
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-34de22deac9so258888f8f.0
 for <u-boot@lists.denx.de>; Tue, 07 May 2024 07:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715092229; x=1715697029; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ayhUEHczI5vMOLOvi9REtaPfbU76QKlQH4QsvfmA3lc=;
 b=BKSasrqIKN0ax3QUG1KzYRlZf6hxHCfxj3gAVfiFDfGAi4OMfQY869ErlcPQh+CrdR
 Zxr9QhK0QDD9FOSxBP3lTsBUkja4+yFBA8wHTpf0lu+iylhUjBCiG2KkMWn2oGz60Tpx
 FFaHUrGN4qNo1btE3wP3ywciKZSRBsodTR/UpzK5s8n00BX0Z57agr0uaVE5gFvt2bxj
 Dvz/2fTsFqlJ6JdikwZVo5KRt3EhmJckMNOGefjgxjcN+9nAtv+8f540LHn/QYOKbdw4
 XHR800x6ISzgckhY9hueKUiblQnNKhNs6es6LnOfGGdfvqyyT75IVJNbF+avaxlzuv5O
 fK6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715092229; x=1715697029;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ayhUEHczI5vMOLOvi9REtaPfbU76QKlQH4QsvfmA3lc=;
 b=oX99Q/DdYtopX6pFCDCbSGZ/9WYbYzU1mkU5UBimTH56Cemt60W9mxmmSR5gT6Gfki
 l7PA/fYxLt0F842tBy0o+Nair5fdhczAFye31/1N8ACdnxo5acooUGNCFVG72eiEQ8pY
 nq9uIBmvplhCUvwUXsfEhpQMYkXFpGgISjOvP/4mnLhiVSgM0lQt4nOK7j4aeVwMJWtG
 9Q/sFxMAh9hR7D6AsjrBquUbvNd37LKYEJ1lbIvKLtpM3TiWSXUA5VzxRmPTF4/xqh5Q
 C1BTkvQha0joVRL1JvevVooUleHNPolzFQVLDpxTj75hWua/FWg9yU+J1Q8wFVDS0yYD
 e2bg==
X-Gm-Message-State: AOJu0YwCTT/oMe/WFwFhArlCbFi6GugiuUhRkgtDQxfWzDzVd458RB8c
 yKYg/87lbyjjXyRV3RuEUlWSqKsOZJ5QrotGMozFWHDy5lbL570N34IfiExgG3RUnc4trm2I9E9
 ssCxP/Oa2yT2fcGxs01ATRFUEzK0/rcMnKfIvYA==
X-Google-Smtp-Source: AGHT+IEM9I5Bs0HqOPb9XN3l5pi+Ej4JkCyZsAGAEkuydhlDYqV2XtbhcYbyKvwTJxJz7t3/cTpA5F6qI/S53OinHrs=
X-Received: by 2002:a5d:63d1:0:b0:34c:f989:dc25 with SMTP id
 c17-20020a5d63d1000000b0034cf989dc25mr8425615wrw.6.1715092229044; Tue, 07 May
 2024 07:30:29 -0700 (PDT)
MIME-Version: 1.0
References: <CAM4sPk-un78JmrMQpAe24nWMp0ytrieyL3zrZd_Qg9HOm--gtg@mail.gmail.com>
In-Reply-To: <CAM4sPk-un78JmrMQpAe24nWMp0ytrieyL3zrZd_Qg9HOm--gtg@mail.gmail.com>
From: Igor Opaniuk <igor.opaniuk@gmail.com>
Date: Tue, 7 May 2024 16:30:17 +0200
Message-ID: <CAByghJZx=KFcygY2=N13=Tw94e3=7+gg7h6Usad2McjaBV2KKw@mail.gmail.com>
Subject: Re: Distro Boot instructions with examples
To: Antoni Jankowski <antoni.s.jankowski@gmail.com>
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

Hello Antoni,

On Tue, May 7, 2024 at 4:14=E2=80=AFPM Antoni Jankowski
<antoni.s.jankowski@gmail.com> wrote:
>
> Hi,
>
> I've recently learned about the Distro Boot feature of u-boot. This sound=
s
> interesting, however the official instructions are sparse and examples se=
em
> to be non-existent.
>
> The platform I'm working with at the moment is a raspberry pi CM4, are
> there any examples of how to implement this concept? Distro Boot seems to
> be suitable for updating all the rootfs at once, including what usually i=
s
> a separate boot partition.
>
> Best regards,
> Antoni

There is a nice manual from Toradex about Distro Boot integration [1].
You can also find a bunch of examples of integration of existing boards
just by grep-ing:

u-boot.git$ grep -ine "config_distro_bootcmd" -r ./include/configs/
./include/configs/pico-imx6ul.h:86:#include <config_distro_bootcmd.h>
./include/configs/kp_imx6q_tpc.h:84:#include <config_distro_bootcmd.h>
./include/configs/imx8mp_venice.h:21:#include <config_distro_bootcmd.h>
./include/configs/stm32f746-disco.h:30:#include <config_distro_bootcmd.h>
...

Hope this helps.

[1] https://developer.toradex.com/linux-bsp/os-development/boot/distro-boot=
/

--=20
Best regards - Atentamente - Meilleures salutations

Igor Opaniuk

mailto: igor.opaniuk@gmail.com
skype: igor.opanyuk
https://www.linkedin.com/in/iopaniuk

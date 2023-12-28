Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B917C3DA6E
	for <u-boot@archiver.kernel.org>; Thu, 28 Dec 2023 19:49:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 35F9687A81;
	Thu, 28 Dec 2023 20:48:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="KFx4KL8U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D00487B4D; Thu, 28 Dec 2023 20:48:27 +0100 (CET)
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com
 [IPv6:2607:f8b0:4864:20::732])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D3DC87B01
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 20:48:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qk1-x732.google.com with SMTP id
 af79cd13be357-781045f1d23so577155085a.1
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 11:48:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1703792902; x=1704397702; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/sCYaa/a4H3qyIlbnjXbbkUKsUurR9aiL2gqkLLx0XQ=;
 b=KFx4KL8ULPj9dfPvR1SksNAmhQvZteExUK9t0iTYk68sLMiv3JbNpKFO6bMzth8W65
 4PTWM+kDEltD4VJrkqbZuxLMmU41FnnTbxW+V/6hIWovoyDfffT7m2NxyQpxcDIfyIRc
 8FNwYhFjLkkmD2a6r/7waLMuCTAeg0cvvOwR4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703792902; x=1704397702;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/sCYaa/a4H3qyIlbnjXbbkUKsUurR9aiL2gqkLLx0XQ=;
 b=E0DXgeA5VyHZzsa7LINs/JOlqQrpdCWXCePujBfrDUvrCWqjhdSlwOwTwY8gLrB4f3
 sQoqx/ZsX8VSRrhx+vN3jxOpgMd6QoI06xzMJGM1NNsW2Rzk32W2zLP0ENcHn1XoAUt/
 y/YZVRrfhW+SofgdGyyblBSUfKXMQv5RS/kwzSfT4LF9A1pwa+LhLcgcXvECxU7QqFhf
 HqgqcZEOQWwkvQEOb0y43DkW9QA5AG9xhUQ2eG6qmmvEVpFFWINqJTq/hnu0JQiuKGAj
 1kc2LeZHAUklsSjS0Fif0Na/MKdoegZcgYv5sGC097F1C2GxPl7+RhWT9/cpseZXQuMj
 BshA==
X-Gm-Message-State: AOJu0YwoqGKDSA6PsISKk6EDYyfs23dDB6AluroQ1UfL1Snkn9Bw2qMR
 MtIn0hi/iLv4Wy3Y4Db3f1U8J29H/X61MlOXWVtwaqmGRo60
X-Google-Smtp-Source: AGHT+IFU5N1hG6VVmd3ODXpsTWdPxOWduCYxZPgbSAG9dQ4GbrCDbZBR5IoVzUyY1d8833yIhdU2Hbm+QkpHt6c7jBA=
X-Received: by 2002:a05:6214:20c7:b0:67a:52c7:b181 with SMTP id
 7-20020a05621420c700b0067a52c7b181mr20710081qve.32.1703792902339; Thu, 28 Dec
 2023 11:48:22 -0800 (PST)
MIME-Version: 1.0
References: <20231228180154.50473-1-clamor95@gmail.com>
 <20231228180154.50473-5-clamor95@gmail.com>
In-Reply-To: <20231228180154.50473-5-clamor95@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 28 Dec 2023 19:48:11 +0000
Message-ID: <CAFLszThd95iSPMOBr_21_Zckg74BtgA23EVpfXQKqnArFc-UDQ@mail.gmail.com>
Subject: Re: [PATCH v6 4/6] common: console: record console from the beginning
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Lukasz Majewski <lukma@denx.de>, Marek Vasut <marex@denx.de>, 
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried <rfried.dev@gmail.com>, 
 Bin Meng <bmeng@tinylab.org>, Ion Agorria <ion@agorria.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Harald Seiler <hws@denx.de>,
 Sean Anderson <sean.anderson@seco.com>, 
 Heiko Schocher <hs@denx.de>, Dmitrii Merkurev <dimorinny@google.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>, u-boot@lists.denx.de
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

On Thu, Dec 28, 2023 at 6:02=E2=80=AFPM Svyatoslav Ryhel <clamor95@gmail.co=
m> wrote:
>
> From: Ion Agorria <ion@agorria.com>
>
> Set flag to enable console record on console_record_init
> and not only on console_record_reset_enable. This fixes
> missing start of U-Boot log for fastboot oem console
> command.
>
> Signed-off-by: Ion Agorria <ion@agorria.com>
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> ---
>  common/console.c | 3 +++
>  1 file changed, 3 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>

OK, I can see the use of this...but I wonder if we can now get rid of
the same line of code from console_record_reset_enable() ?

>
> diff --git a/common/console.c b/common/console.c
> index 6f2089caa0..e6d7ebe935 100644
> --- a/common/console.c
> +++ b/common/console.c
> @@ -821,6 +821,9 @@ int console_record_init(void)
>         ret =3D membuff_new((struct membuff *)&gd->console_in,
>                           CONFIG_CONSOLE_RECORD_IN_SIZE);
>
> +       /* Start recording from the beginning */
> +       gd->flags |=3D GD_FLG_RECORD;
> +
>         return ret;
>  }
>
> --
> 2.40.1
>

Regards,
Simon

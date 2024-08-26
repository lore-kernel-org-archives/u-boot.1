Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0746CC5321D
	for <u-boot@archiver.kernel.org>; Mon, 26 Aug 2024 21:07:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4146188AF0;
	Mon, 26 Aug 2024 23:07:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AbjzziEZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B3F2987FA7; Mon, 26 Aug 2024 23:07:35 +0200 (CEST)
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com
 [IPv6:2a00:1450:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 34C6988B55
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 23:07:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-53343bf5eddso6318909e87.1
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 14:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724706451; x=1725311251; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lvrcHDP3p2GZ0wvdNQ8Yj9bnXBF6CA+uoV+Gv7bDAzU=;
 b=AbjzziEZS5L+hzK8epIpTV4r5yL8rIMrnenqhXrJJx2DwI7NTMm0jzmK4Ugbb83bDj
 LMM75DpWG90YuOvwvdTG5g8QcW//B3ecTupctJMpX7s9LuLRoVGTRsnzZ0QiHWYGW8My
 oMuvOrrYtwq/INDWAGQrUce9asRygnxKCkhljseninEJevO8lra+RjmhO0PDICSz5fg9
 BLkps7qxZ8pJGwVHdq7dBGn92WyUXEi0z9968hmpwgojt9WZ6lU5iR6F5jC5edwirNeV
 r2x1PZBeHpkfLFMei/TKunSguqVXCyulNYuVTTe2gUtSt/nZshgyVXImMP1hlX/DIoIx
 MDNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724706451; x=1725311251;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lvrcHDP3p2GZ0wvdNQ8Yj9bnXBF6CA+uoV+Gv7bDAzU=;
 b=V4vQDToUpwBCZyHCPdugrDW2yfERABrOHMu/1GQo9mlrj+Xk6zkci9LQExxhF797Bl
 CR1d/m/bcKmS44j78gLdyW7OH0dY4z5lUNfYLq2arrG6+ySd+NUbPeXUTNQNyggvY/Rb
 5WGDoK8f1GfdVaJk4kJAF9fMAqcZPtDwUTTusGi9wYL6bqDIdegK8/vdsFk/Nj8mczCD
 0XNp/xkH7u+aaZWFQhoaiNIYhV93W8UWM8jAw4TuzQ5cYPqotctvZTVLDmfmQye91Js3
 jd1XlxSWpgVWcZBp4ces9L2k7rwxEor4Xfk+9uvoSQ53vI+oHFYuD8wr006VIAIGJlt8
 w1Dg==
X-Gm-Message-State: AOJu0YwTZUiPH3BnCsubCH7J1sBQjfvswOUA0M9dXRwv23YTiivtvPcr
 niEQy4MVTATKXrr9HjiIF/4OTl4tnDsNHubDVJDjIoRpeFjDjbLblhj2RHXdZAJFnKjfFUm67vA
 npU7C/XZZvBkQ/sPSDqu7t23/luQ=
X-Google-Smtp-Source: AGHT+IGw8/xrEC58IKog0U8jG+IeEvU8eftco+bMrz21rW4TSFQgJBLY0qfGl08YAISuyhO0KtSFZxmKDY1PfAgnlpo=
X-Received: by 2002:a05:6512:1392:b0:533:46cc:a71e with SMTP id
 2adb3069b0e04-5344e4fb867mr316794e87.54.1724706450892; Mon, 26 Aug 2024
 14:07:30 -0700 (PDT)
MIME-Version: 1.0
References: <20240816032217.267689-1-festevam@gmail.com>
 <CAJ+vNU32x+MieDJj3urBs7q_Rc+u+4zMinGGOLDY43rnih04FA@mail.gmail.com>
In-Reply-To: <CAJ+vNU32x+MieDJj3urBs7q_Rc+u+4zMinGGOLDY43rnih04FA@mail.gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 26 Aug 2024 18:07:19 -0300
Message-ID: <CAOMZO5C7wNcmfqxzP7EvfwtSW7HR+xPxd=+eiuoTiqhZmKNfSA@mail.gmail.com>
Subject: Re: [PATCH] gw_ventana: Remove unneeded comments
To: Tim Harvey <tharvey@gateworks.com>
Cc: u-boot@lists.denx.de, Fabio Estevam <festevam@denx.de>
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

Hi Tim,

On Mon, Aug 26, 2024 at 4:06=E2=80=AFPM Tim Harvey <tharvey@gateworks.com> =
wrote:

> Looks like there isn't much left to be moved to Kconfig. I'm not sure
> if your interested or have the time (I know I currently don't) but the
> USB defines can be cleaned up pretty easily:
> - '#define CFG_MXC_USB_PORTSC     (PORT_PTS_UTMI | PORT_PTS_PTW)' can
> be removed from mx6/mx7/mx8m includes as its defaulted in
> drivers/usb/host/ehci-mx6.c
> - CFG_MXC_USB_FLAGS is only used for drivers/usb/host/ehci-mx5.c so
> can be removed for all mx6/mx7/mx8m and the mx51evk.h is the only
> place its not set to 0

Good point. I will work on cleaning these two CFG symbols.

Thanks

Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39636C4332F
	for <u-boot@archiver.kernel.org>; Thu, 14 Dec 2023 14:02:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A212E87A6A;
	Thu, 14 Dec 2023 15:02:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=shantur-com.20230601.gappssmtp.com header.i=@shantur-com.20230601.gappssmtp.com header.b="GueMviGO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A9B5E87A71; Thu, 14 Dec 2023 15:02:08 +0100 (CET)
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com
 [IPv6:2607:f8b0:4864:20::92a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 746C787A4D
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 15:02:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=i@shantur.com
Received: by mail-ua1-x92a.google.com with SMTP id
 a1e0cc1a2514c-7c5060a9e5bso2513286241.0
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 06:02:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=shantur-com.20230601.gappssmtp.com; s=20230601; t=1702562525; x=1703167325;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HKPH9KJ55hQhL3GJo1bOL228WlJm/Heqzwiw5ZfLVeU=;
 b=GueMviGOaxdRoeCL459Hpj/1f3tcmXOmVu3QhYUPHfJpURXrlCkYSgYq0yHu5dhn0l
 GL9OrETAmagCnEwkjsnhYN6JBT7VAwkJ5iU1wlBZ20IwfYPXsE3+9TMUfAjMyriV+9uZ
 SULtVJ2sAIq2KMWZFwQNPCzw3Tek6JshhXVdQuHa3beu22GdRCI4Gv/Yyj4gV/Wzg1MC
 /js8lF/0335563BsqR54tzByPmzQmrP8+GpIXCTWkvyJ3IulzqWgAHU8R3aZdqmPPVas
 /njmoRv6HqTTaGhKwIxDREeDIVyuaZVOQfM63BKZo2JscGJPahFrMwxYKiiXfoOUIe6t
 /RaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702562525; x=1703167325;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HKPH9KJ55hQhL3GJo1bOL228WlJm/Heqzwiw5ZfLVeU=;
 b=ni9PP/hlf5GzdKwCpNS6oDFTVGymnCfkh5dgsBgqYf9+C6gQz+000DqLe8I1AP+Lax
 4ntYSmpM70qQJzpV5vTIY5v9EC9eNvDhI0mcdylNJtox7qrzFcRNFUejlJM7HuCUeHF7
 kaWwn3dSSTBVwnAOlw4EsSNjDfeOzHoeuguNR/5AYgPhExu8PG837UdOEAmbeA6DZzil
 UegwBR7SeEVbdEo5TVk6MT8aHHta0kQ6JlEcf0e7b/HOy7sCtlaGA2s+UToLZZU/PuCQ
 VObXOykWrd3i8c3epG7xxdyKoslTd3WZkRHDuYC6gL2DdXvG7/mqQKTZ52gWy7QckN8w
 vXPg==
X-Gm-Message-State: AOJu0Yx7W/utmR4MhsTpxW0tBBtyJ+6HXs+GEjWXORt3VGyizfkFOMA8
 YeoHIE3UVtaJzHOYhJxLECvs3LnX72thCa8jf8Rf/A==
X-Google-Smtp-Source: AGHT+IGrUJ38fz6eCIJ+Z4a+78eFF6Z4yS1e5UpJTUN+9FSd7wLVb8Z2nhjzFXzVtu7qsmvPU2K/lSZuiYxUfiN1doE=
X-Received: by 2002:a05:6122:d09:b0:4b2:f5f9:948a with SMTP id
 az9-20020a0561220d0900b004b2f5f9948amr9074653vkb.8.1702562524969; Thu, 14 Dec
 2023 06:02:04 -0800 (PST)
MIME-Version: 1.0
References: <20231124120431.115717-1-i@shantur.com>
 <20231213230604.GQ2513409@bill-the-cat>
In-Reply-To: <20231213230604.GQ2513409@bill-the-cat>
From: Shantur Rathore <i@shantur.com>
Date: Thu, 14 Dec 2023 14:01:54 +0000
Message-ID: <CABEcMwXE_6gVMzCbZDaEUrJmTi19yTSuRjdzK5n_YGU1KpKaKw@mail.gmail.com>
Subject: Re: [PATCH] maintainers: rk3399: remove maintainer
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Jagan Teki <jagan@amarulasolutions.com>, 
 Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Simon Glass <sjg@chromium.org>
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

On Wed, Dec 13, 2023 at 11:06=E2=80=AFPM Tom Rini <trini@konsulko.com> wrot=
e:
>
> On Fri, Nov 24, 2023 at 12:04:31PM +0000, Shantur Rathore wrote:
>
> > Remove Akash Gajjar <akash@openedev.com> from
> > MAINTAINERS as email is bouncing.
> >
> > Signed-off-by: Shantur Rathore <i@shantur.com>
> > Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
>
> Applied to u-boot/master, thanks!

Great, thanks
>
> --
> Tom

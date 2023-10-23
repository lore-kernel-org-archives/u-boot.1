Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E9D4C25B45
	for <u-boot@archiver.kernel.org>; Mon, 23 Oct 2023 19:37:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA1FC877C3;
	Mon, 23 Oct 2023 21:37:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NORuXXOk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 273A287898; Mon, 23 Oct 2023 21:37:32 +0200 (CEST)
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com
 [IPv6:2a00:1450:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 94C0F87754
 for <u-boot@lists.denx.de>; Mon, 23 Oct 2023 21:37:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mibodhi@gmail.com
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-507b9408c61so5083659e87.0
 for <u-boot@lists.denx.de>; Mon, 23 Oct 2023 12:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698089849; x=1698694649; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OwyWvqv4Ff+ZnjeLapSYA+BjrTrDXCUDqUFALXbApj0=;
 b=NORuXXOkHpVrdGye5foUrg5NpjxhZsNMc0pXwVqu5paB/wBvdmiM05iE7UCxRbVOId
 IbjGeMgD8IFW7rXE6/r2Moi/Msrhc+Am7uOCqmBIos93c12cB2T24LegIrGIvdBTKPEl
 4C8M/WFx6YO9YXzpIHyhFLERF5TuNSIeHIJQCcxMIUrX5ZD0vEbv94+rb3AvgiwG9YQS
 +Fju1888U+E1nkE5i3Enf040L7RqPgwkULVMbX5mUhTHWYm3YHBcDdzcE0Oh/9XQ1Zkt
 /B2ky/ve7wcml1cL38smZZfg4y0ClYIxLhgLf9dJfpXXiZK/+MfzSvOmHdD8JiWymprv
 y7FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698089849; x=1698694649;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OwyWvqv4Ff+ZnjeLapSYA+BjrTrDXCUDqUFALXbApj0=;
 b=vmpQxxJiOwgrD1pRWRTWUNY6UMF7xHwS9orFTVIGVPk823W86UJ+JPhrp3FPAlmZEL
 JdD2tumLUu2TICCkCGBRG/MpdAvIzwhnSuWMi+Or4uuGVQFQWIs8xqZ8s58eYwcsqm83
 H8atmdHateAQYQr4567E5u88qCcMwpeiiCu/9AoqqILbiJqvnxCO4YhthBFCOcr81zQ7
 AXi9E96rT2PcN9Fhg01T+eRF77otNOqWkREs/cQwhGI8kyA9FkgtypsemM6PuQlbGO6C
 u5A+mvPkdUvmiqqNAyo2e/ySROohPazrLqgQorToJx30noV/TNTzkchMoNESv8WyFSky
 weYw==
X-Gm-Message-State: AOJu0Yw2xITyV7SHzirqJzy1I03zCuUhJpZPcmW2iayUpQYLpenygEcb
 1uviILs/rx1syOR4Q59oR0em4XxJ1cTJK0RTo0M=
X-Google-Smtp-Source: AGHT+IEKBKjf4Yky11Aed+L9FohMhL/jpSjKOYMnpL2Ei349VsMhBg+x3ykWR5G9te4bk9v3y9D0v82UA0V8cheSYR4=
X-Received: by 2002:a19:2d02:0:b0:507:9ff3:d6ec with SMTP id
 k2-20020a192d02000000b005079ff3d6ecmr7746717lfj.50.1698089848577; Mon, 23 Oct
 2023 12:37:28 -0700 (PDT)
MIME-Version: 1.0
References: <20231011202643.9194-1-mibodhi@gmail.com>
 <169808766154.2558485.14888786871905858063.b4-ty@konsulko.com>
In-Reply-To: <169808766154.2558485.14888786871905858063.b4-ty@konsulko.com>
From: Tony Dinh <mibodhi@gmail.com>
Date: Mon, 23 Oct 2023 12:37:02 -0700
Message-ID: <CAJaLiFxmVwPf+dgLSav=fHR86Gerhz+n08pNv4dgAOwPqorgyQ@mail.gmail.com>
Subject: Re: [PATCH v5] bootstd: sata: Add bootstd support for ahci sata
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Stefan Roese <sr@denx.de>
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

On Mon, Oct 23, 2023 at 12:08=E2=80=AFPM Tom Rini <trini@konsulko.com> wrot=
e:
>
> On Wed, 11 Oct 2023 13:26:42 -0700, Tony Dinh wrote:
>
> > Add ahci sata bootdev and corresponding hunting function.
> >
> >
>
> I know this is recent but given their importance, applied to u-boot/maste=
r,
> thanks!
>
> --
> Tom
>

Thanks Tom!

All the best,
Tony

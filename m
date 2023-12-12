Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0437C4332F
	for <u-boot@archiver.kernel.org>; Tue, 12 Dec 2023 17:05:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6111787509;
	Tue, 12 Dec 2023 18:05:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LYkUB+Yi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 804A4877D0; Tue, 12 Dec 2023 18:05:51 +0100 (CET)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com
 [IPv6:2607:f8b0:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1627787710
 for <u-boot@lists.denx.de>; Tue, 12 Dec 2023 18:05:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aford173@gmail.com
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1d32c5ce32eso13205615ad.0
 for <u-boot@lists.denx.de>; Tue, 12 Dec 2023 09:05:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702400746; x=1703005546; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=70Xe7pcqkvlg8/2cka9H2bxG4X6aLZ736OHfoZm6zSY=;
 b=LYkUB+YiwZAK17UV1M2/2UpvMJaWeH8KA+AeRouQwZmKwGe5gG0PE9woQgpVHxRE/3
 RlFYEqoI86PaNZsSoMvqouF+2dBbCImXGUTx7/yX3S0NLr1Ozhg2//oiB7Vchi1dQvvI
 Gv7+nsAgiR/Bq4S0wcfvx+HotEW7l/xAaVkj0LIgainOp2X0gPOzuujHBLVidYa3c4r6
 H4ABAuZOWfsGxzKxI18o3gSBaRDA2ksIjxpPkfUhQ9NROtVVBp3RlSeWZXUXbTqmqi2Q
 15va/Kao2cDhc8kGc5+OECTl5D46s14CeHVVB1Olhw6JbELkHmhxgbCd/Zyn/VEx3eoK
 TMew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702400746; x=1703005546;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=70Xe7pcqkvlg8/2cka9H2bxG4X6aLZ736OHfoZm6zSY=;
 b=A9R1rtnE0sYjHo4ii5LnhxrM4fxDKkC9Q94vdpcBBQDuYsIHndkBkq0eR+7XoI7C47
 Q+7EUlBjQ2xhaitXRi8RsSsqHRDKxsKkx/nq8zYi9yKJheCGfZBCqF7hZQW6EwOfWPA0
 GFNyYVhEfePaen2SqL3/lgxmPiAqC4YrdcV8AKKyrB1zGnxkbhgeHhbZrkbTtorIJ15M
 LqQizdZzvg59CWoKtb15yH3lzyyIqisYP5DRIkNDb4UicrHUu72wFl8n2w3+GQjxuKW4
 0RAEFjlnCPlq+KChua32kfDZRkLsLwb4h+szWvf06/42uSF2gBCpYuf/Cyvvl2VooCI2
 rInw==
X-Gm-Message-State: AOJu0YwFK6CT/OX0IHv18Re46/pksgcEQIizwVVHDV+wrkuEkXuIyFGU
 qW1I4Z9Vao677+XbiCtB1QzYp16K7NRUaNqSV3k=
X-Google-Smtp-Source: AGHT+IEFuot9r1Itth2eJIEmjvso3DumVPYjh1csUYXEB4FjulVIQgAq/TScGmLgWb3AUGbjW9T901eXRBKaUz4hQ80=
X-Received: by 2002:a17:90b:1989:b0:28a:d552:db9c with SMTP id
 mv9-20020a17090b198900b0028ad552db9cmr471684pjb.3.1702400746138; Tue, 12 Dec
 2023 09:05:46 -0800 (PST)
MIME-Version: 1.0
References: <20231025230456.7924-1-aford173@gmail.com>
 <CAOMZO5B-QMKUB7rFAqvXPyMNJVm0PX+PPZoTuwQVo3uYhsX_-A@mail.gmail.com>
In-Reply-To: <CAOMZO5B-QMKUB7rFAqvXPyMNJVm0PX+PPZoTuwQVo3uYhsX_-A@mail.gmail.com>
From: Adam Ford <aford173@gmail.com>
Date: Tue, 12 Dec 2023 11:05:34 -0600
Message-ID: <CAHCN7xLzZexpsZ=wS0Mu-vXdEmq4564bYz6vZYmp8Ej=jFb2Zg@mail.gmail.com>
Subject: Re: [PATCH 1/5] configs: imx8mp_beacon: Do not set
 SYS_CONSOLE_IS_IN_ENV
To: Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.denx.de, sbabic@denx.de, aford@beaconembedded.com
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

On Thu, Oct 26, 2023 at 9:20=E2=80=AFAM Fabio Estevam <festevam@gmail.com> =
wrote:
>
> On Wed, Oct 25, 2023 at 8:05=E2=80=AFPM Adam Ford <aford173@gmail.com> wr=
ote:
> >
> > The hardware only supports a specific console port, so  remove the
> > option to change the console location in the environment.
> >
> > Signed-off-by: Adam Ford <aford173@gmail.com>
>
> For the series:
>

Fabio / Stefan,

Is there any chance this series can be applied to imx-next?


> Reviewed-by: Fabio Estevam <festevam@gmail.com>

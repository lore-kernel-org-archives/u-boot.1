Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77F9ACD54A9
	for <u-boot@archiver.kernel.org>; Tue, 19 Sep 2023 08:47:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F2D7086B16;
	Tue, 19 Sep 2023 10:47:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bTbNuNNW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D9DF086B23; Tue, 19 Sep 2023 10:47:36 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A9F086A8A
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 10:47:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bmeng.cn@gmail.com
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-9ae22bf33a0so199986566b.0
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 01:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695113254; x=1695718054; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gfjzZbJCTDN9VMIprYzaKysQkFfPB/uXUbCrghQ0TKk=;
 b=bTbNuNNWp3PQsYYL8jAXgLABMeocn4t8dPREND3XVdclRekUKwC6YwCjOiR4a5p+u5
 0/4+xf5HZVTGAYNdarokC1F86taK2CkpGh/AMMisjlK4KBinLHjHj/GRpYofAYAjhEZ4
 Z/Hyk7BTmpL9izd67cYylum/Yo/IQF52Mh5cTebmrxTTddTzlXw4fR+47NKGw0xzRm8l
 TQBPv22mTOaABqH0F5fZCBoIN6vLVajFrqGP4qhrIQyoRVDRMuJyTd7cU89gjf5QTmyF
 SAnx7ZuP+CnnNQRb6bz1iU6iFh5ukTq5Cs3fCmZlmnbKmRIXoUbElC8AEXjkaZXYwPSx
 umSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695113254; x=1695718054;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gfjzZbJCTDN9VMIprYzaKysQkFfPB/uXUbCrghQ0TKk=;
 b=wUb6vVsHPLh8fVT+p2E1RwfpqpHauE9wJf8hnzFeF5wxMbvhWOVtoxlG2iE57rK23/
 0RfAtkSXy3IdDK0C2b3Oo3iy2v88Lxw6jQZ35WNC1GXqrAPoPl5a5hZWbZZ3/qKh8GyB
 mAR9sdyRL4nVh38Zt83Wgu4JRLYfYQ2bTPsI7daASyBtUwLGkMbReUd3t44bIxLXQGym
 jnoO187iumQWX0G8rH/WoER84cSO6BIm6RLOchWQIVnrRq4nSr6mJvUoRPLh2YhlsDcI
 O1FSUEtWRH6O6clve12PTUkeXEs1EGIBGDkuQ/zXUqwhI7bXj8GApsn62pIfDBanzDEc
 HdPg==
X-Gm-Message-State: AOJu0YxqSEjWkquwKzli6+dnGU3o0fH4slF/xbTTy6AvUbAoHPiokKZz
 GX3PQEVtcvqFFdy0Pzl7b5JGXSknFgWdhHnaSZI=
X-Google-Smtp-Source: AGHT+IHVZw1BicC82MIYdiG70tOSri54CGybJegrhWfKswtCMy/9JbUwkgoCAuOp7BTDM9ih7Zn5XTlgc9jFK3Ev550=
X-Received: by 2002:a17:906:8456:b0:9ad:c79d:2a23 with SMTP id
 e22-20020a170906845600b009adc79d2a23mr2525295ejy.36.1695113254624; Tue, 19
 Sep 2023 01:47:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230910191304.191580-1-sjg@chromium.org>
In-Reply-To: <20230910191304.191580-1-sjg@chromium.org>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Tue, 19 Sep 2023 16:47:22 +0800
Message-ID: <CAEUhbmWSaE=bpgMrDBxXMzQQkXEXfxkt=FtDjZ2p9Rv31n9isA@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] x86: coreboot: Document cbmem console struct
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Alex Sadovsky <nable.maininbox@googlemail.com>, 
 Paul Menzel <pmenzel@molgen.mpg.de>
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

On Mon, Sep 11, 2023 at 3:13=E2=80=AFAM Simon Glass <sjg@chromium.org> wrot=
e:
>
> Coreboot changed a few years ago to include an overflow flag. Update the
> structure to match this.
>
> This comes from coreboot commit:
>
>    6f5ead14b4 ("mb/google/nissa/var/joxer: Update eMMC DLL settings")
>
> Note: There are several implementations of this in coreboot. I have chose=
n
> to follow the one in src/lib/cbmem_console.c
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
> Changes in v4:
> - Reword commit and change title
>
> Changes in v3:
> - Drop __packed as it does nothing useful
>

Reviewed-by: Bin Meng <bmeng.cn@gmail.com>

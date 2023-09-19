Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DC26CD3445
	for <u-boot@archiver.kernel.org>; Tue, 19 Sep 2023 07:21:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5026786AA9;
	Tue, 19 Sep 2023 09:20:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Hp7fiqP5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C5DF086ABB; Tue, 19 Sep 2023 09:19:59 +0200 (CEST)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com
 [IPv6:2a00:1450:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE65286AA2
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 09:19:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bmeng.cn@gmail.com
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-502e6d632b6so8233370e87.0
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 00:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695107997; x=1695712797; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rb5DVFihts/OQkez0ORUbg4CXZq4pxNi46Vgx8RMPkw=;
 b=Hp7fiqP5CHe6kqotLhR2XAr0iM7bdSwxc5FrbID5SXPBq/tuG8vG0K8PO9IeNPLvQe
 9s2/+UtnMOFuS5SG4EzkN+bQ8sDfQmVN/n8ZiQZPSLf7UrRONACOL7bESd9QgCCKu39N
 FKHa04Jl5Sqh2VGiVFEnL6ahxHan2EzTIPoyin5OIBKIh2cG6sTIR+IXd8vmNbkNMcBy
 8ICkIOMHzmzMH1f3VeqJPfshjCdjdg/sTatkkGQnnyoQTIJqdKom1D2n/X9rthg8N+Li
 kPUnhZ1sP1GRlnTkBpseJjLhrXvKCuDoTRE9zEEbZQyqr7f/SkruitMDcVRasgFIgROC
 YUuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695107997; x=1695712797;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rb5DVFihts/OQkez0ORUbg4CXZq4pxNi46Vgx8RMPkw=;
 b=BoFHoyZl6nCFYP9k2W9vRnhwcFLO4g4ovHC/PSFgn+mmM50py1EVCOn5QRcK+4PLhx
 i67/RvxFH5JW6mow69UNUScmDIoj5dRmGfesvkdjG9bidH8AMmruqnrahMUNZihdw9GX
 6sWQ5PuEJUzzhsP1cSnKOti4Zz+CKwZWSZXrDGXMzvBcTlPg6iSW9Rq55TDUlcFmaGwQ
 eRL1MMtKOuLQn4LIWWXSHCpQWbWnD8rH9WDTfbsQrpRrb/jgySCnB/+aHj6RS41SVC6l
 ApZdpqJsLCQ05QfkbsZlzOz0dIqgj1bjhitrrauV75UHJ7x7TF+R0ecYaf9lL+LDHBHW
 dPXg==
X-Gm-Message-State: AOJu0Yx5OpzF6kPiUtJK+DflPk/S2yRrbtSR6L35YHLoSsd6eqsP0Ad5
 a2JCnvum7yN8YIH9APqC2lPlP3tKrZUz6PlspMbZUx+q
X-Google-Smtp-Source: AGHT+IE0BvWzaPECE6JXYwpOUG8GTmdfv7rkP4gGVBYwyWr0t9J4gUNVfwqDUTezpijJPteqRPyDADF5YQv9AL1bws0=
X-Received: by 2002:ac2:58e3:0:b0:503:3644:4a99 with SMTP id
 v3-20020ac258e3000000b0050336444a99mr129648lfo.51.1695107997061; Tue, 19 Sep
 2023 00:19:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230823211059.1235147-1-sjg@chromium.org>
 <20230823211059.1235147-10-sjg@chromium.org>
In-Reply-To: <20230823211059.1235147-10-sjg@chromium.org>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Tue, 19 Sep 2023 15:19:41 +0800
Message-ID: <CAEUhbmURTtjHYaPG97uwo7OJqU2wMGPbL0v69p35SzQUMYikcA@mail.gmail.com>
Subject: Re: [PATCH v4 09/20] x86: coreboot: Align options between coreboot
 and coreboot64
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
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

On Thu, Aug 24, 2023 at 5:11=E2=80=AFAM Simon Glass <sjg@chromium.org> wrot=
e:
>
> These two builds are similar but have some different options for not good
> reason. Line them up to be as similar as possible.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
> (no changes since v2)
>
> Changes in v2:
> - Update the malloc size too
>
>  configs/coreboot64_defconfig | 7 +++++++
>  configs/coreboot_defconfig   | 9 ---------
>  2 files changed, 7 insertions(+), 9 deletions(-)
>

Reviewed-by: Bin Meng <bmeng.cn@gmail.com>

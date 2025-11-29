Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ECC4CFD2F6
	for <u-boot@archiver.kernel.org>; Sat, 29 Nov 2025 21:23:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D69F3838A0;
	Sat, 29 Nov 2025 22:23:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nPoVMLrd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 39C90838A5; Sat, 29 Nov 2025 22:23:02 +0100 (CET)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com
 [IPv6:2a00:1450:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4103883759
 for <u-boot@lists.denx.de>; Sat, 29 Nov 2025 22:23:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-594285c6509so3494457e87.0
 for <u-boot@lists.denx.de>; Sat, 29 Nov 2025 13:23:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764451379; x=1765056179; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iPEteGTpCHHk7XO2PZpSpg8I5fXWUFrHEONxG/xq5bE=;
 b=nPoVMLrdlUb1eL0hbIGIFwmuxQ4st+9fJAJGi6NmN03Jpn9LNBfI7bxVlbMvOAR9qi
 J76sg2Dly60ys3TXpnlT+nDjM5cajO9YS4abWlVub8EvkD/iUBzDqr+cmquV8pME+N+f
 K0K8Wo0SXFss5RzhNbRq25vJgJY3piYWdQKqCwRlU2wNVUn3rQbqRa7emWAXqD0jo70z
 Zo+apFLLTm8t5NtYtDAZSWvrPrJtlVZdVMEKSP3UHWJxf3/3w0MoqX08f4XN4zbufs7E
 q+rpoKu3xWLDv38YwhEqrpVBn4o/Hky1Zkr2C5y3w4Lu5snFyNTKYBk5MN6rGQIolil3
 Yj7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764451379; x=1765056179;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iPEteGTpCHHk7XO2PZpSpg8I5fXWUFrHEONxG/xq5bE=;
 b=plFCUZulR4t6HvCiQpb5pF5TZ60hoURo11HrEaJBaHmbA8+eCyNUnukSYpgpyi46kx
 wI0Vpd0GqiYKqEYAp4iK551Y9xBplOjx017ou6mTKjl6S+08nPkIG5UL6c/2eJ7+qnuJ
 GOhrCkjIakXyMaCGyRSgbtjyBnrti7DYypFp7Nnu2GrO86pRCqWsA1z3fiRmLDXjMAkH
 PTYIw7QiDIuSUA1DdsLkeB/JY5ouUI9IMz/ClU3Sw3u0pwblCBoddSnm4z8SzgFab00O
 /p6oHg/nneWz+gXn4rGAzz3TkWGP5ecluXVuPjljOwWIMVBNKNzpRcRRI/BXWm2Yba6J
 oXiw==
X-Gm-Message-State: AOJu0Yx8dZnG3EhrPt96Vp5hpcX7hcuz4+orf3E//sfSsKnM7qwuZCkJ
 paTVVgJ7i5a/4FyRLqg+SChnOt3PHusRDjcEcJly2UUiAo07ikFWubES8SY4sw4mkvbN5qSrIG3
 c5Yx/EMmLel9xE0Osv0WQ0ghbgRDmH/AFtrUE
X-Gm-Gg: ASbGncuYln49D1HrQCP62rQj7QunGDXasicHps/2GlmrNBOV5bpoJ+lwZtr6zKsR1uD
 tssSx9ReDDb2UZIW8VdsEtSQqkgqg8iphfu/QFMiGyYHl7gnvdmYXilNPTLwWA8KAAib5JTsYES
 kmWiItgThfRBHOHp8qAkxFg6UiGy+v6/zJUcCJjooYFsQtLG27AlTMtTflv+jzNIdf2XD43nsxp
 LWSI7dcMW8Mx+hiDkBAfCV+OHXiexoG2Rj73S40ZVwdawtnbKaWVHG4eN1patUFsI5gFKPSluCT
 vAPcUYGpRCXbEBC2JNT2rDHIv9y2Cng0mBNXlA==
X-Google-Smtp-Source: AGHT+IHZkhbiyZg01LSoAH7FNpv14xuWrC8sbfvKigyxtfufUo1AUBs9tr2NLbGCFejqWPWDkhh57TwbQmrEoHaVlzo=
X-Received: by 2002:a05:6512:3188:b0:594:2835:e73e with SMTP id
 2adb3069b0e04-596a3edddf5mr11670858e87.37.1764451379277; Sat, 29 Nov 2025
 13:22:59 -0800 (PST)
MIME-Version: 1.0
References: <20251113151858.1072774-1-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20251113151858.1072774-1-marek.vasut+renesas@mailbox.org>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 29 Nov 2025 18:22:47 -0300
X-Gm-Features: AWmQ_bmTcBnENRN0pupn-yQKbOW1VeqYRMb72Kc4uOLh3v8o4QjFtDVmleuMiJ8
Message-ID: <CAOMZO5ANFcpfyT2SRSrmEgQHac5Y=vuyhqJWStqxxKbpbgpYmw@mail.gmail.com>
Subject: Re: [PATCH] board: tbs2910: Disable EFI partition, MP, sysboot,
 bind commands
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Dragan Simic <dsimic@manjaro.org>,
 Soeren Moch <smoch@web.de>, Tom Rini <trini@konsulko.com>
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

On Thu, Nov 13, 2025 at 12:48=E2=80=AFPM Marek Vasut
<marek.vasut+renesas@mailbox.org> wrote:
>
> This board is just short of overflowing the size limit, disable
> support for EFI partition since EFI support is already disabled,
> and disable a couple of commands which are also likely unused to
> keep the board below limit.
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Applied to u-boot-imx/next, thanks.

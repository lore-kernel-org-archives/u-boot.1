Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EC49CA1013
	for <u-boot@archiver.kernel.org>; Fri,  5 Sep 2025 12:44:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F6F383858;
	Fri,  5 Sep 2025 14:44:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Chy683jI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF0EC83BBE; Fri,  5 Sep 2025 13:30:35 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1CCB5838C5
 for <u-boot@lists.denx.de>; Fri,  5 Sep 2025 13:30:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sidharthseela@gmail.com
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-afcb7322da8so406508666b.0
 for <u-boot@lists.denx.de>; Fri, 05 Sep 2025 04:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757071833; x=1757676633; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7+khDOOdytamHToTN+lw5izWmhB20o4Hay6Ep38nXmw=;
 b=Chy683jIlIGNw3Lt228OUIGGiTxwur/HL897YDh2N9PZllg3PkgCIXeVZeXmSSLHUV
 mtn26eMVEbvvrWg3H7Jx+iLUH4PeajsCytDKYV1b6S4FwsABsU7Uyevh+/HwOc7FQcOh
 jdd2xwUs7xInWv1T1cBCF326eXSATultb5N2qySXhAqmrWskVslHKKjupqrZnJEndVZQ
 vcMXoNgWnFwPyBsS/4TxXN0fey60i0reQNPMTAp4FSyM9ZxbSbG/Srx31KqhcsPC3E9i
 3roa/+yNDmRZrhjHcTu0cYTEQvnK+rDPauvSgXnqlABBIMX3X+tuCYWxIpA3Dn6GoN3B
 YT1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757071833; x=1757676633;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7+khDOOdytamHToTN+lw5izWmhB20o4Hay6Ep38nXmw=;
 b=D8bO41xvJ+PSpi1veeU+jgOCWfMV8KbSU0nEpWtrOBo/NDaEuPJ/s6TucFP8oKEAD2
 V7wwccW8WkKr4y9l70F/ZxsZXIt1lRcmei+7YUcifcD+J8ewrpF/4cPyF1eBY4fEDGYb
 S1IQUO9dQwmtvVZ01zXrlg7aXLSJ6xVpseNcAHB3oyaK6nWH6JYerCduwUQ2TiwJeKcU
 b3VjjnPgm5Ak/h5dNenGH4aNNmkoW8lELZYHXzeE24s7dJyN+ssP1lcg+NhnJmCKzQgk
 2zcsuhLLmCgs/VYmCbmhYcNSK5HSwT4n/YwzTDib6+vpmoS6owHWvvEOgH3GylaRTlGb
 MvgA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVhZIRfqvavq3BKFZQPg+OLbADJzBIjZWSPb6vrw9JeSCZiQ+/m3FHQVEgSxHUHUbIZf5oU2iA=@lists.denx.de
X-Gm-Message-State: AOJu0YxXDSL6eOX2sjR0TRPCJyF5f8fdYacIHYJ59kSgKkGfNJtEoWHV
 xITjCwBXhSlrda+x+yBI8qvheNJqBI3O68qgCtcvARXvAUPWKcSJGhrN0/dudB1D9vwUJDQjTGa
 q6FTTwwJ62vIcMay0uIYa/uaZ1USgSqs=
X-Gm-Gg: ASbGncvC36cxD6H5UrLyRUxq04DwSitiSr8Smg1nAvUHn40a1QbXXCAOQa65QY1fy9K
 KND1GMI9PTrjml16LvnI0ZICjTwTry/MCb7b2pheXUCcKe7Is1U2Qc2R6mWaZfQ9W+EoKaBGlqx
 jDI4xzh41eLYp+AtO+UZRAbkoz3pTWwP5FXhChT+ImNMiobyEXc8TiufDmaDgwv/ZbGbSbqiSX2
 V0nXVduYPgQGsFlW//D+OiIIoJiq+eS9mneHPyheg==
X-Google-Smtp-Source: AGHT+IGJkzp7ViswYdERUgXABDBJx9PVdQIbMIbzfG+POWr5w1lX3St5nUDfGMEwbeUCE+8HoVHiZDWiZZ4QHpqL8bg=
X-Received: by 2002:a17:907:2d20:b0:b04:57f3:ac9a with SMTP id
 a640c23a62f3a-b0457f3e439mr1129305266b.64.1757071833308; Fri, 05 Sep 2025
 04:30:33 -0700 (PDT)
MIME-Version: 1.0
References: <20250905104534.382508-1-sidharthseela@gmail.com>
 <20250905132510.500d5777@kmaincent-XPS-13-7390>
In-Reply-To: <20250905132510.500d5777@kmaincent-XPS-13-7390>
From: Sidharth Seela <sidharthseela@gmail.com>
Date: Fri, 5 Sep 2025 17:00:21 +0530
X-Gm-Features: Ac12FXwgXMNjba2e6vIchhXFCrqeW1kvQ65OIZdCiu31Xl0uh1wkgjV_PbSlUag
Message-ID: <CAJE-K+AYm6nbbSCkNm23KoPHPVvRNGjwzjWSOnEMJw5q6hO92Q@mail.gmail.com>
Subject: Re: [PATCH v1] board: ti: am33xx: Fix serial_getc comparision in
 spl_start_uboot()
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: trini@konsulko.com, sjg@chromium.org, ilias.apalodimas@linaro.org, 
 jerome.forissier@linaro.org, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Fri, 05 Sep 2025 14:44:10 +0200
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

On Fri, Sep 5, 2025 at 4:55=E2=80=AFPM Kory Maincent <kory.maincent@bootlin=
.com> wrote:
>
> This seems weird. =3D=3D precede in terms of priority to &&, therefore th=
e
> parentheses should not be needed here.
>
is the issue maybe left to right interpretation of code?
--=20
Thanks,
Sidharth Seela

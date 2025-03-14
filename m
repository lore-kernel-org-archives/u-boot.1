Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AF30C282EC
	for <u-boot@archiver.kernel.org>; Fri, 14 Mar 2025 16:47:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D9EB681E64;
	Fri, 14 Mar 2025 17:47:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QxaZGCKX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E72B81E81; Fri, 14 Mar 2025 17:47:40 +0100 (CET)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 98D3781E5B
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 17:47:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-39149bccb69so2092619f8f.2
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 09:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741970858; x=1742575658; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uztIJbIBSKX1K5LFVL64OZk5fX5uLU9wwEL1D9ja3Mo=;
 b=QxaZGCKXcBMkkg1OnKqaG+FpkGsor1IpN63n0ILhRTbDFoio5aePrQgI7uCpHJNSIc
 bz3fl71ufpV3l9Co/MV7Bc10h2EtXsiVtPhNzT1ZIYiMz/sJF60vwbtGlVEhmc7kO5Y/
 CFm28KRxZJeE4yJzMsAEih2reMHrWtnpzN3awLYjEdgtyFSkEwGx7hmS+t7/yYO/GpXv
 gmXBF9uQsunEw06/EUX9IieUPUBDsfMtgn2g1Hd/EpCxayg52y2Bqd2UCqWAF2csyxxT
 M2hhByoD5HwYvLmk+nts3SFOlawoo7VxjsadaK5TV8ijdK2HVJUtNR/b23UOMGEWhpPj
 83kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741970858; x=1742575658;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uztIJbIBSKX1K5LFVL64OZk5fX5uLU9wwEL1D9ja3Mo=;
 b=aEYhQHE98SazNgMp206lXjV6OcWEMplbFSGosYthM/laf63KKr+oyhYRCrDZRysY0A
 XJdGCun/7YVe+YZJrPVB22b4vsQ8WmjItQGu5td8F2mAE74kxN6yXvwqtM6+/WbmqrIu
 +I4mSQKlxRtU33zMILDt31yveUeU/EBSr7JQ8ck5eK/LN7m81MfFOvy7KGl2+Rc1NYoM
 pD8Ub5dgTeaG5mczuGTckgamO3sRMnVbuvZD2LKtdND1TcdWYlnd8TGjXZ7ysqKU4uAf
 39NEB9ITYnSpYW5Yasi98cufTDePZP5TipPV2pvMm979Sv6kxwSecDsJQ1DoLUQQ1KWf
 cXag==
X-Forwarded-Encrypted: i=1;
 AJvYcCV5ISjK+GmSpop+z8JU6L7apg5S2xKJ2R/AtViJd+7D4hpEWkMrR7FA/wEZszumVhAJxI5mYLQ=@lists.denx.de
X-Gm-Message-State: AOJu0YxGA3kkzocf7ceZIt9Xl1rOB86GN6m99FYPoud0pxZIyIv92wUM
 PWP1muek3+5dCwp3JcEy+8fzYT8jJOFcU1g3cG5xvqiq08YXoZVywUnLeJhrLx0EFySxLhu2Kpy
 9Kc8tE9AQrciuMIRoksVKmlEDNpY=
X-Gm-Gg: ASbGnctPrlsAme+7ztGEYvatYfKSJ0/a9dhfW9/pvRJa8a4zcKmmUDkFvvDlHTeQzWv
 EGbznzLd2B5mtWwWv2PTM/1C2rU5WGhrBaDh7qSd8b7uV4LCLwXpzNOy/MrHJ13MBGUAThPQ56k
 10fuEs0YPCIu6EA6nkEAsTSgKuPMA=
X-Google-Smtp-Source: AGHT+IE529iMhkZFMaNQwMlGwiiKnHZszS1r5Ie4kC6sA8wymSbJGlgAle9Pc5BMKl/qA59+ytE9JLDpDKpfzD2X2CU=
X-Received: by 2002:a5d:5f93:0:b0:38d:d69e:1326 with SMTP id
 ffacd0b85a97d-3971cd569b0mr4687193f8f.9.1741970857780; Fri, 14 Mar 2025
 09:47:37 -0700 (PDT)
MIME-Version: 1.0
References: <20250314064720.5767-1-clamor95@gmail.com>
 <20250314162118.GU2640854@bill-the-cat>
In-Reply-To: <20250314162118.GU2640854@bill-the-cat>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Fri, 14 Mar 2025 18:47:26 +0200
X-Gm-Features: AQ5f1JrUHfuT1PNURZYeHxDm3kOjtOk7WnJJRU3cPqbjJDAnOs0tEmPXQz52r-Q
Message-ID: <CAPVz0n0GyC2EdzaGKynCGmMpEyZLb3YG8La-3fxvkWHnWvWdog@mail.gmail.com>
Subject: Re: [PATCH v1 0/1] video: edid: guard standard timings EDID expansion
 behind kconfig
To: Tom Rini <trini@konsulko.com>
Cc: Anatolij Gustschin <agust@denx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 =?UTF-8?Q?Jonas_Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>, 
 Simon Glass <sjg@chromium.org>, Anton Bambura <jenneron@protonmail.com>,
 u-boot@lists.denx.de
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

=D0=BF=D1=82, 14 =D0=B1=D0=B5=D1=80. 2025=E2=80=AF=D1=80. =D0=BE 18:21 Tom =
Rini <trini@konsulko.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Fri, Mar 14, 2025 at 08:47:19AM +0200, Svyatoslav Ryhel wrote:
>
> > Since EDID only indicates supported standard timings, a large table wit=
h
> > detailed timing information is necessary, consuming significant space. =
To
> > mitigate this, the table is made configurable via kconfig, allowing it =
to
> > be excluded when not needed.
> >
> > Svyatoslav Ryhel (1):
> >   video: edid: guard standard timings EDID expansion behind kconfig
> >
> >  common/edid.c         | 6 ++++++
> >  drivers/video/Kconfig | 6 ++++++
> >  2 files changed, 12 insertions(+)
>
> To be clear, when the flag is not enabled do we have something similar
> to the old behavior, at least in the correctly functions case?
>

As long as I2C_EDID_STANDARD is disabled the old behavior isn't
changed, there were performed a bit of code refactoring, in the
previous patch by Jonas, to simplify readability but nothing more then
that. Significant size increase is not detected as well, as long as
I2C_EDID_STANDARD=3Dn

> --
> Tom

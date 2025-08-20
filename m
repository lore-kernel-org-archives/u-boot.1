Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E4E5CA0EF5
	for <u-boot@archiver.kernel.org>; Wed, 20 Aug 2025 13:25:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E605382B07;
	Wed, 20 Aug 2025 15:25:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KNkl/Ahu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E776882F03; Wed, 20 Aug 2025 15:25:10 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6A1028211F
 for <u-boot@lists.denx.de>; Wed, 20 Aug 2025 15:25:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-45a1b065d58so49287195e9.1
 for <u-boot@lists.denx.de>; Wed, 20 Aug 2025 06:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755696307; x=1756301107; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=27Zymh5Qqac51eETDNDaRARv8Z9dOL4nQOR64rO885U=;
 b=KNkl/AhuBVD3jSLTRlV2z4HYJabIq3DS917A3785/OdQGPGaVYVlukMRPeaJyXBRpx
 +R8vO/0K7DNhwOnDeVR19/Havflg69gTwxfeP9UE6S+HOeoa65nNTJ9Fa8EE7+dNmbDF
 peomzg0BAJHI4BfTP8V33UKAw5kVEWJHM/mfjENmEbhkC6pvlmHw6U8Ez28LnDxRY2fz
 CWnQG5v1i97PLkBnfYPXOeZNxePn88WRePM1OAmUtEHQ9vUygaZ3yIyYGFVdI0SUYTsi
 UW1vEhdsJOqBn1VHJgSI1O41fWn7tjQ2eYqw0xYZs571BSGtMDeiZEdvTcSZfnJvF2lN
 16cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755696307; x=1756301107;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=27Zymh5Qqac51eETDNDaRARv8Z9dOL4nQOR64rO885U=;
 b=JxW8r+pSoqtEufzf9awX2BoB9KT7cIeCWm20bEv6ZYfL9qmmcOzTW1LEUqvSonJMY1
 yotM56lbN/BD+EoqIIP3B+NH7OWyXNbJXS3T0OZsA+wOliW74MklD8z5Lsc6qeJ8wsW9
 Uj4DbluUfLNKpx5aQzMKjBX7+AI/U0Ny00AQWeidbs7owyR+mQZml+a8CgbdktJAMiQ4
 vSpcP/c5LkwBZsDlQoVqltxWsQ3ldTxtyu8ATGYH+gJ3jpYEnJ/RTHiENnssjtxTnY8A
 PwISctkSLY8wDsh/KQ/W4x8AbE724z34IHiYrL/VRAaYMRjIcHU06LUJFys86SyRlP59
 Firw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQF/RUWuxVCmmdG+Dm76ov+30W64bLbI3tML/tIbhIkUHebhm6u67f6/ZQP9xNpZs9V31+5Dw=@lists.denx.de
X-Gm-Message-State: AOJu0YxhRLysrnvdX3T80pcqAaq8e4x55YxXg7Jz5ARPitcRiS/m3KE1
 +FPgxCZjXLh/C7xAbJwPp9nzUsUgwfbeswabMlHXzFhWRcByEsWJ+NEmKPj92DdabvK0F09jmVI
 o2936QRMrqucAVcDerYh3Z7FpUOUJC98=
X-Gm-Gg: ASbGnctDwjVRKGqOiullkw4pLIpKwhqbigRmp3Ax0yFTNhOgpitZ9kuYoBTsVbaUh3m
 BPeDa1Zbg3cM5Jy6/QF0Kq8mq2DGwAQcvxmwVTLLLnwzDc7k5ECKjvbXLmK+HUYYQ3d/DG0ikX2
 TyxEgLsef7ghnvDCbDTtPAELiPwzy/Pu2ZKiriI6dNl4Ah8SCN7E8PfOs+d76nvRg+dGpxqaUA7
 WUgLyVz
X-Google-Smtp-Source: AGHT+IHPK3IlQkeWnC1ChjCiWAFwEXWBcfpngZ+DAyoaQggUzhu3xWsVb3aHHo4xA0+tjPB5QlDOeiV/Z7Z5aNiwzu0=
X-Received: by 2002:a05:6000:2887:b0:3b7:9589:1fd1 with SMTP id
 ffacd0b85a97d-3c32e6fb1fcmr2481400f8f.44.1755696307176; Wed, 20 Aug 2025
 06:25:07 -0700 (PDT)
MIME-Version: 1.0
References: <20250819154025.604784-1-pbrobinson@gmail.com>
 <mvb65rhgfd6opwxzusjrmcczmp2ovsqvsn2y4dgvnl663keqyc@56sd6lovajqv>
In-Reply-To: <mvb65rhgfd6opwxzusjrmcczmp2ovsqvsn2y4dgvnl663keqyc@56sd6lovajqv>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Wed, 20 Aug 2025 16:24:54 +0300
X-Gm-Features: Ac12FXxOilkjnREqtmwl7-esn_2vKnr4qye9Sz8CpRRKdgt9L9t45VcS1n27Hq4
Message-ID: <CAPVz0n2iJH4zWekqqJ=-hWC0UneqgHa8+8grvfzeoSxc1QxFwA@mail.gmail.com>
Subject: Re: [PATCH 1/2] p3450: reduce size of Jetson Nano u-boot.bin
To: Peter Robinson <pbrobinson@gmail.com>
Cc: Thierry Reding <treding@nvidia.com>, Tom Rini <trini@konsulko.com>, 
 Tom Warren <twarren@nvidia.com>, u-boot@lists.denx.de
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

=D1=81=D1=80, 20 =D1=81=D0=B5=D1=80=D0=BF. 2025=E2=80=AF=D1=80. =D0=BE 13:0=
6 Thierry Reding <treding@nvidia.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Tue, Aug 19, 2025 at 04:40:13PM +0100, Peter Robinson wrote:
> > The Jetson Nano contains all it's firmware on a 4Mb SPI
> > flash, the allocated size in that flash for U-Boot is
> > 753664 bytes so we need to ensure the u-boot.bin doesn't
> > exceed that else it will fail.
> >
> > Add a BOARD_SIZE_LIMIT and drop a few large, and somewhat
> > esoteric, options to bring us back under that limit.
> >
> > Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
> > ---
> >  configs/p3450-0000_defconfig | 8 ++++++++
> >  1 file changed, 8 insertions(+)
>
> Acked-by: Thierry Reding <treding@nvidia.com>

Reviewed-by: Svyatoslav Ryhel <clamor95@gmail.com>

Applied to u-boot-tegra/staging, thank you!

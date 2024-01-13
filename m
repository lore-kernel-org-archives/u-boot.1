Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AEBFC4707B
	for <u-boot@archiver.kernel.org>; Sat, 13 Jan 2024 21:14:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B68DF87579;
	Sat, 13 Jan 2024 22:14:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZFMRrxMQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A98778795E; Sat, 13 Jan 2024 22:14:44 +0100 (CET)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com
 [IPv6:2607:f8b0:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 91BB38721A
 for <u-boot@lists.denx.de>; Sat, 13 Jan 2024 22:14:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1d3b84173feso14795165ad.1
 for <u-boot@lists.denx.de>; Sat, 13 Jan 2024 13:14:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705180481; x=1705785281; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ia9ET/HtiQESbrWpl1pIn4Z6sb9rp/qTNfZSuM0ipE8=;
 b=ZFMRrxMQR4GMfUnz8KEE9A1Ea4sFNP06uYLpAidaPD4zbb4xwDWvyFHTMITFNMlaEo
 Yx5IYIUSoa7mS2SLx+YmA8J6c0fzj77rNhHBwSMceOJ4UUvHFhVd/t0aO3SvBus85h8f
 M3OEU1E6drKXh/OIZBhZM/rQWnJwQYNYkXniaWqjBgodoF3h/tyl5pd8UkGDaTTlgDJB
 aBzFrPV73H0iY7HLnCVfNGcEEf1u3VYJNtMxgtnKWUpFWKA8r/9OQHy5eQrurt2M/fOO
 RNm+MEaZ8EgUcg+XkcKtftEQ5s6vgMGsjyQymuWvOPN90trKF3x4IBKpS2dB6ii4MAUC
 btsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705180481; x=1705785281;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ia9ET/HtiQESbrWpl1pIn4Z6sb9rp/qTNfZSuM0ipE8=;
 b=cBY4WNCtS+Br3CeHfHTOod8R235ekEmI69gewUhbHpsTAwEJrTkvRKpSzhhp/oufjR
 TrresXEjgLU+RKphZ6psXPXAhkFn/kK3zb2/9H1Db8rexkIejiUhR8Zq3+ITJhNgtllK
 jyNa7uFnwv+YvwLFrWLb13IrF9C80nSY/TGA1TwRf1cahfX0EbWjTDhHxWhvGnjKzcG5
 sm1F+Fei0Q558NOOV1+6QuoEpAWS27OtZCVUdu5eB6EPnYtxfiACBX3JIHWBVEOdxqZ7
 lhvYQDN/E1siStW4US6Dp8RvSejpWfInGY0CUb6Sbwo/59W0g1VCAkpSURgfpZDTZrjm
 uIkQ==
X-Gm-Message-State: AOJu0YytplAm6Qo0irA4rY/LO5plpmqmwu0CLYe4wq6XmfetuPOtH1cf
 sJhHWOGPBON1ZXxFhsZo9K522GTUZk/pVYq17zzA4AGq
X-Google-Smtp-Source: AGHT+IF8lNI4AmITgqJxVj3Pb0Qb3jZSBNam1A13gJfYSB5lPcGpdX3mRGjU/F5CQjceI0GOeZ4aN3gvXhHeCQNruK4=
X-Received: by 2002:a17:90a:734c:b0:28e:1e79:c5c2 with SMTP id
 j12-20020a17090a734c00b0028e1e79c5c2mr3955320pjs.1.1705180480822; Sat, 13 Jan
 2024 13:14:40 -0800 (PST)
MIME-Version: 1.0
References: <CAOMZO5APcHhdkvd40Pm+WzSAoxtHS0kcdVpkRTs8yqwXdUSaRQ@mail.gmail.com>
 <e07c0ace3d9db05e80795a949a449506d7a3247e.camel@toradex.com>
 <20240113204542.GA3000@francesco-nb>
In-Reply-To: <20240113204542.GA3000@francesco-nb>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 13 Jan 2024 18:14:29 -0300
Message-ID: <CAOMZO5DFUr+uo8Qu4eJ_NSxdtK=qXqT5=1LAo19UeGnA_HXP2g@mail.gmail.com>
Subject: Re: [RFC][PATCH] ARM: imx: verdin-imx8mm: Set CAN oscillator
 frequency based on model
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 "marex@denx.de" <marex@denx.de>, 
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "uboot-imx@nxp.com" <uboot-imx@nxp.com>, 
 "sbabic@denx.de" <sbabic@denx.de>,
 Francesco Dolcini <francesco.dolcini@toradex.com>
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

On Sat, Jan 13, 2024 at 5:45=E2=80=AFPM Francesco Dolcini <francesco@dolcin=
i.it> wrote:

> Fabio, you were too fast ... please revert it.

I have dropped this patch from u-boot-imx master-next.

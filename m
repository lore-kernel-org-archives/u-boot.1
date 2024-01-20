Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1E7DC47258
	for <u-boot@archiver.kernel.org>; Sat, 20 Jan 2024 12:17:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C462987CFA;
	Sat, 20 Jan 2024 13:16:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PpHDBA4D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 54D0D87D15; Sat, 20 Jan 2024 13:16:57 +0100 (CET)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com
 [IPv6:2607:f8b0:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 29AED87BC9
 for <u-boot@lists.denx.de>; Sat, 20 Jan 2024 13:16:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1d437a2a4c7so2848025ad.0
 for <u-boot@lists.denx.de>; Sat, 20 Jan 2024 04:16:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705753013; x=1706357813; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LG/8rCEkTV6a4JJihFMh6vl2Jg2PuluU2TCsptjyHOg=;
 b=PpHDBA4Da5+obZ6jnADkBVebaP2k4JMYhnfWfCBguTTxtxaAq33zV3eQJYJE9SOQ2R
 81XSO9D2TVGSrMZ7YTIMiQzdwYnJW42aZicU9g3caDCDIwPWDRF2Yw52CiDsBtcyV+ER
 aeA+8s95E6u1/sAalOCvxoRahiCALG4kuNx7Kjrk+jZT+y6I/f4lIJlXlVy2/qO37qBR
 0oZLaeG7SnLzdKcsYEQ+yo8JhujccsTuE0vvMXlnET5RcnQs6nh+YKHe06c7WTWg9iB+
 xYIFE5MipojxuBW8kaxozfpN/bmXTeMzCD/wpW0gxaQotcmVgQlZYMXN4+FyOjRgO0TU
 CO3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705753013; x=1706357813;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LG/8rCEkTV6a4JJihFMh6vl2Jg2PuluU2TCsptjyHOg=;
 b=s/9vK0lbjvRVhg2Q7gmggKYVXABjohiztCOogywlLsvumXZllZZt4Ga/5PqIMRk/k5
 Pdi4JJwMwIDunYudilREPWSxUvP8yRmzk+LOA5LPE7e+MBaEJAE1RL8dgDKaJqtuF0Q/
 6qBILS0Z+FaJoarne/sjkdsrTRp9NiXubN+D29PGnI75cur2nDTDkvxFt0vNfEb63jrJ
 mDgVPsn2o4LrhLY6lvSH4U8fAl18GrG0peYVGmSVORpZc393b9coZF5WG4PLUJ5MQRAz
 1+icWjqdSoLCJcwLikl+6ypp4mLlci7hS+PJY1u6ZB6e7fnUr1iXiMMpQgu4VTCORivC
 67Vw==
X-Gm-Message-State: AOJu0YzlkRCRNy9UmUjREa38IMO00iVt/fxvtFzxIX4de6OXgojefTdU
 TQkg8aNXBk194aJ7NuJZu1XCYHV10tlDW36gPGnJGxMWCTxoexotz+AkTclzgDe702aXj3rhg7U
 y9YPlm8aPSfSgDisIN9z4eimPOOFyMSi5qEI=
X-Google-Smtp-Source: AGHT+IFoUeqSt67vPDrBZpBS9ag9Azdd/zbzeyZ8heZCXu0kpHdZ56MJ++hh/l2xClCNjl87TYdnv7Y4OCQUGIr/W7M=
X-Received: by 2002:a17:902:ab83:b0:1d6:f243:9be8 with SMTP id
 f3-20020a170902ab8300b001d6f2439be8mr2840498plr.3.1705753013436; Sat, 20 Jan
 2024 04:16:53 -0800 (PST)
MIME-Version: 1.0
References: <20240120003610.124981-1-marex@denx.de>
In-Reply-To: <20240120003610.124981-1-marex@denx.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 20 Jan 2024 09:16:41 -0300
Message-ID: <CAOMZO5CKO+89k5y2901pMcPsdeM6RTfOhxs8Qeiu97Ob998g5Q@mail.gmail.com>
Subject: Re: [PATCH] ARM: imx: Enable kaslrseed command on DH i.MX8M Plus DHCOM
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, Fabio Estevam <festevam@denx.de>,
 Stefano Babic <sbabic@denx.de>, u-boot@dh-electronics.com
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

On Fri, Jan 19, 2024 at 9:36=E2=80=AFPM Marek Vasut <marex@denx.de> wrote:
>
> Linux 6.6.y with KASLR enabled would print the following message on boot:
> "
> KASLR disabled due to lack of seed
> "
> Enable the 'kaslrseed' command so a random number seed can be pulled
> from CAAM and inserted into the /chosen node 'kaslr-seed' property of
> Linux kernel DT before boot, thus letting KASLR work properly.
>
> Signed-off-by: Marek Vasut <marex@denx.de>

Reviewed-by: Fabio Estevam <festevam@denx.de>

Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20959C3DA5D
	for <u-boot@archiver.kernel.org>; Mon, 22 Jul 2024 21:06:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A0ED884B2;
	Mon, 22 Jul 2024 23:05:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AvwUtUB9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3FA0C884B2; Mon, 22 Jul 2024 23:05:58 +0200 (CEST)
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com
 [IPv6:2a00:1450:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5659C87F82
 for <u-boot@lists.denx.de>; Mon, 22 Jul 2024 23:05:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2ef243cc250so3984261fa.0
 for <u-boot@lists.denx.de>; Mon, 22 Jul 2024 14:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721682356; x=1722287156; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FSkMePlIabU3WgnhAwDqKQgCZdxOGmzHfSGRJA+uejA=;
 b=AvwUtUB9VZx57cnFLcaIkIwtfqD3vprAcyl/1yFbIvyFVBeZwDynJVaLggSNuhojrh
 yesNcz8ACWy3+28M+U3100Sk/JIGKUP3cjPALPR/N2Cm/eEVNcOA6qv7UqTwFvm6A6sc
 PMzBznKdNH800FiAyjloiRwpB1gpny/5ioxTqrPv6/+2OnziPNgpcArYG8TPEsy6tC00
 fCq0uZ6PWhZx7tk74QfcUWGzKNZH11mnsxrplAK9CqFXNk6Aax6O0mnOGu83Zyn1OgLr
 k4Brn2hfJXrSNY4B3ceMM2g2OlSj444DBS1OH+4/hNa8cF5iv/Xpk8vCVNpUH8Kc5MXl
 XxXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721682356; x=1722287156;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FSkMePlIabU3WgnhAwDqKQgCZdxOGmzHfSGRJA+uejA=;
 b=XU1fLxZU1QZq3pz/cmUl08O31S2v7ZPzNu5rGRtlcxssAYlINyYopyZ7fXN2LbeIYI
 FmnXF3pZ2GbLhIP/pTfRJlbmmU4CasrJH1omcJWHIxEr+yD3uwVEE1bEHj+qbv7pUNrq
 mIihLckyradXnuLZzkyoO+JnqPr8LHFpAShg2o3Wb1xnT0W7n+yaiOONfxSAvpJGgiCE
 0aHanUvSXeSb99V53UeXSMJDxmVdpTh2X/9JaCZbnGwDH37ewGpf6Kxnh/cZ/ouf38+v
 Tq2ncbwCTPdwIa6jnPTphMPW/oLuezmsqo7DGMY5xX04gAszNQhLmiHIOgTgpSYnF2tF
 rXew==
X-Forwarded-Encrypted: i=1;
 AJvYcCXfhcZTB3hpZWe1OOHh4mvqO+rQDLJJ9ECHs/Ep6F0ydOrUQ+5Ch6Fv/TcL0urCP5eB9ujNh7ygcu3g08kMir53GvWvww==
X-Gm-Message-State: AOJu0YymnGdFDVlFN5/EGAW4fc0LjBT6bJiQB4yLZKLAE+z4yyq4OCJB
 7YCbXDR4qmL89DudSDA6uhBBqy8SNFL7fvpQ5y6jpNQ5EXp/ST5O5/QyCqqm+RoWS5HOlC91Em8
 RR8SFEn9D7atBwf6ETj2XlNNXNoI=
X-Google-Smtp-Source: AGHT+IH0CiMQ3czxZMqOHyGE2cLTU8ktAcU9yVWNPrEiGLnPnilhsmGAAy9aMt5Nzwn0ERwl1ugnzkbSMrgF5no9oak=
X-Received: by 2002:a05:6512:4007:b0:52f:2bd:966 with SMTP id
 2adb3069b0e04-52f02bd0b6fmr1697024e87.1.1721682355511; Mon, 22 Jul 2024
 14:05:55 -0700 (PDT)
MIME-Version: 1.0
References: <20240718165454.904763-1-festevam@gmail.com>
In-Reply-To: <20240718165454.904763-1-festevam@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 22 Jul 2024 18:05:44 -0300
Message-ID: <CAOMZO5D63A0_na46tenYEn6mZC+fQfC0Mpa899z5aY3WCjB8tg@mail.gmail.com>
Subject: Re: [PATCH] imx93-u-boot: Describe the CPU clocks in the devicetree
To: peng.fan@nxp.com
Cc: uboot-imx@nxp.com, m.othacehe@gmail.com, u-boot@lists.denx.de
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

On Thu, Jul 18, 2024 at 1:55=E2=80=AFPM Fabio Estevam <festevam@gmail.com> =
wrote:
>
> Currently, there is an error when the i.MX93 CPU frequency is
> read:
>
> Could not read CPU frequency: -2
> CPU:   NXP i.MX93(52) Rev1.1 A55 at 0 MHz
>
> Fix it by describing the A55 clock nodes in the devicetree, like done
> on other i.MX SoCs.
>
> With this change, the CPU frequency error is gone and it can be correctly
> retrieved:
>
> CPU:   NXP i.MX93(52) Rev1.1 A55 at 1700 MHz
> CPU:   Industrial temperature grade  (-40C to 105C) at 35C
>
> As the upstream imx93.dtsi does not describe the CPU clocks,
> keep the clock node in imx93-u-boot.dtsi for now.
>
> Signed-off-by: Fabio Estevam <festevam@gmail.com>

Applied, thanks.

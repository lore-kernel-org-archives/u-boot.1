Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6D36D116F1
	for <u-boot@archiver.kernel.org>; Tue,  2 Dec 2025 02:34:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0DABE83DE4;
	Tue,  2 Dec 2025 03:34:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="X5+UM17y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C61083DE9; Tue,  2 Dec 2025 03:34:25 +0100 (CET)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com
 [IPv6:2a00:1450:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3613483DB6
 for <u-boot@lists.denx.de>; Tue,  2 Dec 2025 03:34:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-5957d7e0bf3so5879361e87.0
 for <u-boot@lists.denx.de>; Mon, 01 Dec 2025 18:34:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764642862; x=1765247662; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0y7W9BU0iA1rfflIvT1x0U0Nuiz+JnMCgSouG/H3zHo=;
 b=X5+UM17ytKrpAemd3PsFMXahggwrhN9j2XyItlR6tipA9IQAvDmWYl49DX+dHt+32o
 zoGf8xy1x6jA5mV7HEKwVP+CCFM676rKD7ULdkmInSI7jLyLCmMdFV5FSoHTorRIFG1j
 pTHZ8qSObV/u/nhN6hUKp7x98pLNLV5oKu1TpvU/hRde3UhyHaM7jMYQhRl9jD/FqMWY
 ouIlU2rOdEVgL0jNxCN1PdeioSZ++Wj1dp5viPQ/H05euQEksKgE01Wzah8aA1ffDBPd
 zVVcoKvulBJk/tOEMMRmob6Fw1pJVn75N6LnXcovoOUlZwi6E3xK1Adcu2GlD0/SU9kR
 ZRxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764642862; x=1765247662;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0y7W9BU0iA1rfflIvT1x0U0Nuiz+JnMCgSouG/H3zHo=;
 b=AiKrvKFRxd7JmQkKex0q6jJdKIyhoOsWLjDsjWYcKh8HkJ6lh9w9uHLOvCUBC7psKG
 emYn7sqTiPtVHhM8xW5FcxKMw5VZr4ASw0ZYDVLbvpkUihOtD23pvflUClDz2iAen3cH
 dUhUcIBM9Y6W/QyMfb7klYQxrVRGJmRox97S4lRHPKcR8E6OcXzyTA1QiREgmJawwBrt
 +NJ8R04xtaR9zyoUm/y9o0PG4eWB4B5sUWGYqv1oe+6lzEmpzre0QgfiUxykdTOu9e2a
 90fsLKNzDK4DtfOMevjDVmp0bhedP0BrRdEnv+ITKedelMfIWl6SebN0PnE5cySVVK0N
 lJag==
X-Forwarded-Encrypted: i=1;
 AJvYcCWh7OnQ+fRmsNffePUs3HNFMPR1NuhyQh2l8aCbACGh3xKtSZYIat+QjANR6TNdbXgqV0PiP7g=@lists.denx.de
X-Gm-Message-State: AOJu0YxZkK7zvUdVhfACNbbIi2gVVb4TXzu1aRRczjCFuGd8mKL5YlE7
 SOVnu5jhvlukrKGVHuiH+XfiwEVDC8Z8aLvKI0a4f3x0Si555HMQwOgByVYPmCyiJPLi00WWlqY
 qBQq6G1+Zt7F5MpPU2gHFXpWoCU6QKzc=
X-Gm-Gg: ASbGncuGsD72nmchksh7D52gkkmRSTyCx/KHtzlxQ55J5+5dV27KIq3Ys/gHlCFNVzk
 dJHEhItbAx2adUyXj74bqAKgQDCSGADO+YU5EBULf2xOkxkVp/dQGghVUfppwcOkxcjPJ8LWMui
 4FIqutFHLxdzgBJlKVmsycWgs2Y6TBeSmA3S1xkL/VPhFSIMIl9HUY0YQ9BFqQGvGUdz/myuTR0
 IZ2XxqG492/pWN4cqLm9SX0LNEoZ0gJn3fbxn3btm6L057X6eR8bKEnGQKlMsdr6K0gXxruPwny
 XlTNECqF2aU3TrWqSoC9OS1yow==
X-Google-Smtp-Source: AGHT+IF0ru3xjshgwh+PhB8QaJ3vpi+vw9D+AdhmqBn4vLhHta9ODCRnnZTK6m2kO6SNjDxFkRDDKvj3p4SY3UPfVdo=
X-Received: by 2002:ac2:5692:0:b0:595:9a17:9678 with SMTP id
 2adb3069b0e04-597cfb0b695mr216481e87.12.1764642862147; Mon, 01 Dec 2025
 18:34:22 -0800 (PST)
MIME-Version: 1.0
References: <20251127-imx91_frdm-v1-0-8f42646d89ad@nxp.com>
 <20251127-imx91_frdm-v1-2-8f42646d89ad@nxp.com>
 <CAOMZO5Dxi52OzFEBWU1hnn2HfHc9EZcgmwW=p-N-+Oy+JHQBHg@mail.gmail.com>
 <aS5PECe5b8576MTk@lsvm11u0000395.swis.ap-northeast-2.aws.nxp.com>
In-Reply-To: <aS5PECe5b8576MTk@lsvm11u0000395.swis.ap-northeast-2.aws.nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 1 Dec 2025 23:34:10 -0300
X-Gm-Features: AWmQ_bkXnV6LgZoH86jMYoFpcEUTqqJqu2frOMaaEqLyZELq9n74lG3cIzdweMM
Message-ID: <CAOMZO5CbYn544xKUb6QApg0bzc_cQEqqTSSC1r9SUgyfpQGSEA@mail.gmail.com>
Subject: Re: [PATCH 2/2] imx: Support i.MX91 11x11 FRDM board
To: Joseph Guo <qijian.guo@nxp.com>
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de, 
 Stefano Babic <sbabic@nabladev.com>, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>, 
 Sumit Garg <sumit.garg@oss.qualcomm.com>, Ye Li <ye.li@nxp.com>, 
 Alice Guo <alice.guo@nxp.com>, Adam Ford <aford173@gmail.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Simon Glass <sjg@chromium.org>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
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

On Mon, Dec 1, 2025 at 11:29=E2=80=AFPM Joseph Guo <qijian.guo@nxp.com> wro=
te:

> ECC is to detect and correct errors in data of the ddr.
> It is needed. I will add a common include to reduce duplicate code.

Ok, but why can't we have a single configs/imx91_11x11_frdm_defconfig
with ECC enabled?

If the DDR controller supports ECC, why can't it be enabled by default?

I want to understand why we need both defconfigs instead of just one.

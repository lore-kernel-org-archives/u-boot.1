Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04527C02182
	for <u-boot@archiver.kernel.org>; Mon, 20 Jan 2025 12:46:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 08148805C5;
	Mon, 20 Jan 2025 13:46:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hvsyDm2f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9AA5C805CD; Mon, 20 Jan 2025 13:46:08 +0100 (CET)
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com
 [IPv6:2a00:1450:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8BD5780077
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 13:46:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-3072f8dc069so28198341fa.3
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 04:46:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737377166; x=1737981966; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0g4B5bivsvfQUiAnp3T1kzLLK8PTUbFNfuvzhNJicp4=;
 b=hvsyDm2fkqyGNTXosj3RLA8FRqH9ZymJism3xLpn/PYimtxn8v2vQx+sresor8ivs1
 zCzlWZFBNCHtWRTrIVHZeo6bE6RQcVP5OthU1Mtt4pZlEz8/fEoqV37a+kQg2T8vFWxs
 Ri9OIVpUeGFM8c0lO9aBr2sM7IF8ExR5GO7Eh4dn43z5cQzuf0bkrdPaBFn8rS3LqciC
 TwJ/fGTkK70vCWBN0TutqR3MkG8h0Qu1xPwkrXAwv/fUe7qRgvJ7NandDBfit5eHfKJj
 C3G1E1/wlVpXPKiz+NA+0y0tBiQDpVXMY/SEZ28kQDprFjfOgE9tbau6fhPSVezxcarZ
 KUwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737377166; x=1737981966;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0g4B5bivsvfQUiAnp3T1kzLLK8PTUbFNfuvzhNJicp4=;
 b=EXgGKblFHzrSa3IjH3zY0u8xa7mnsM47RfetsY0fb3qUAwXz6xRRxMaUuVxVtdqoUf
 sN/evC7Zur3oqohCTjwRguDqiT5l4t9PpAlMYlAQY/f+ChzorCEyXd0Dy0DVLotP5Fw2
 OF+djCzCFbsa/4+n1P4FCA6LI69Rm7jWKYF77iEeEWKXJ1ZQMO+2xzbBkNc/3oUWrLF9
 eh68c7pKaJVkFAPQki+mCvVP3QGnJbeMp3REMAEhhqAzP6FYX+0CdDSMKmEsfk9GPIj/
 /nctiAG/a8HjHG1IUudoYvh04H0DVhrjvM3RyhpVrd1MZr6PYHjjKVwCSkaM46eJYHjU
 sYqQ==
X-Gm-Message-State: AOJu0Yw4/+oZLRWAruqgYx6jt7y1t6JPvoBhAwkGQqlO9Pgrb5q0BhLB
 WSJdzaZMLgV8Gw8QZ099Y65+2iErnu+0ZK61JsIrCxoNS1SiOaILqnTs8uXr5JDgE5owwJT0XfS
 wSMPdMH+gAZBq9u/omvgo9ETivds=
X-Gm-Gg: ASbGncutVJUvbSaMSxLy8RLGcCvulIr022VreGu5dV+Z3x3ODQe+CXVNk68Krt2aTjy
 CcfcRL1akhGqaRxXCVkxwLl3zWrFdYkZTXngrzYxp7ewMXqpjs9Gyf3OF+t66xvLmgCiFaEOR9j
 Ov0k/tK7s=
X-Google-Smtp-Source: AGHT+IG4rAjPHRc+jZBpvYCYD+B9DbZtVKEcPXIBD2EOZT4sRin0VBrcLPL7+6JNP16Zr/ldD3tFb18UlRl+3Ui5vvU=
X-Received: by 2002:a2e:a544:0:b0:302:4a61:8bd3 with SMTP id
 38308e7fff4ca-3072ca5e1b2mr47689331fa.7.1737377165584; Mon, 20 Jan 2025
 04:46:05 -0800 (PST)
MIME-Version: 1.0
References: <20250117163750.3918082-1-Mr.Bossman075@gmail.com>
 <20250117163750.3918082-2-Mr.Bossman075@gmail.com>
In-Reply-To: <20250117163750.3918082-2-Mr.Bossman075@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 20 Jan 2025 09:45:54 -0300
X-Gm-Features: AbW1kvYwDMvo7O1cevklu2bCOPkgQi7bzZbLJTD5pajCLUFptW2PlrA8OTRwxCo
Message-ID: <CAOMZO5D2zObAvJpDv8YHhcZaSjb=ECj6Qy2M7ZsE1-+5zXUdBw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] ARM: dts: imxrt1050: Migrate to OF_UPSTREAM
To: Jesse Taube <mr.bossman075@gmail.com>
Cc: u-boot@lists.denx.de, Stefano Babic <sbabic@denx.de>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>, 
 Giulio Benetti <giulio.benetti@benettiengineering.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>, 
 Sean Anderson <seanga2@gmail.com>
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

On Fri, Jan 17, 2025 at 1:37=E2=80=AFPM Jesse Taube <mr.bossman075@gmail.co=
m> wrote:
>
> The device tree for imxrt1050 is now
> available in the /dts/upstream directory.
> Migrate board to use OF_UPSTREAM.
>
> Signed-off-by: Jesse Taube <Mr.Bossman075@gmail.com>

This breaks the build of imxrt1020-evk_defconfig:

arm: + imxrt1020-evk
4140+make[3]: *** No rule to make target
'arch/arm/dts/imxrt1050-evk.dtb', needed by 'dtbs'. Stop.
4141+make[2]: *** [dts/Makefile:60: arch-dtbs] Error 2
4142+make[1]: *** [Makefile:1168: dts/dt.dtb] Error 2
4143+make: *** [Makefile:177: sub-make] Error 2
4144 arm: + imxrt1170-evk
4145+make[3]: *** No rule to make target
'arch/arm/dts/imxrt1050-evk.dtb', needed by 'dtbs'. Stop.
4146+make[2]: *** [dts/Makefile:60: arch-dtbs] Error 2
4147+make[1]: *** [Makefile:1168: dts/dt.dtb] Error 2
4148+make: *** [Makefile:177: sub-make] Error 2

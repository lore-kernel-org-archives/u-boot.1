Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A624C5B543
	for <u-boot@archiver.kernel.org>; Fri, 30 May 2025 12:13:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 26A2582BF6;
	Fri, 30 May 2025 14:13:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hYAWk5+q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 15F5382C44; Fri, 30 May 2025 14:13:21 +0200 (CEST)
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com
 [IPv6:2a00:1450:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 27C5782AB9
 for <u-boot@lists.denx.de>; Fri, 30 May 2025 14:13:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-3105ef2a08dso17546451fa.0
 for <u-boot@lists.denx.de>; Fri, 30 May 2025 05:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748607198; x=1749211998; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xfsxYlhG2m3cuKcpJQicNmKfEtDr7/1okVpZPzVnbYw=;
 b=hYAWk5+qMTEqoNsGRTC4LDLJrbQ+Gzk5WxVhbS+ce0mbJ3ojtzRgSDHOtFfzHVBzln
 Ldk7pjfVuTF/0oVnuPSdUHV0DA7d3pKs11h5bK72nm8GfwRUdGuUdrx69tn4ZNKguxED
 Nt538PTQ0o+LQuUTqwncjtwSDtMFuhNn/hyoKQ9WSUPrRpP4tDdjDEFZ/xF9Xo97nugZ
 /gKHBMVya7tb61L5pB0tHEdwNaAprkBBLmq68pieuQp7WOs8qRE0wylwZr7YLuQUGO37
 Kdc69MbVq3azk7bqNgGmNx3PNp4B/0gA68ecy3NO/1ddOwQ4gfAPYOkjsDgEEcQi1whM
 2caw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748607198; x=1749211998;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xfsxYlhG2m3cuKcpJQicNmKfEtDr7/1okVpZPzVnbYw=;
 b=YNxNLgKToP9G2j+7UOGgIvV5dCx5NOVf7ajp/xOvJiNl9J34gMsGc1tNjItumyEXXR
 mMu+q2wLg1mxZIyD6TlHaN7iYAtc00WAuo6XnKwFvNGUqIOSClxARsJCbUuIKeI/SpuO
 Q8LxyQHUZRQSqvTz2G9r2ggCQ73zLH7SwFOeEp+6Osf6PqJh8pk5luV9l7llEp9WoROj
 Hio3ABiGQwV30q7DXG7+n98dWp7yyugnO0iITJACmf1hN9n7UdFs78FPpxhpiKyiepLv
 orySY7qhBIbioi+JfhEsBefyJzV4hFvaloZI79ih5/F+myTtSYvD2xmGnZaPaJAtUNv5
 RkFA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWK8QE55ETxMqiiy6pUcbAGRu1RpCS4AoYFRF7Nd4yIu2HPBSJM4gVMvW/GnjLJU2zF8b9n8d4=@lists.denx.de
X-Gm-Message-State: AOJu0Yz3SiCCKh5ALm0f20KkU5DMJxhc01Fv1QRshxd7JyLboxHToWZY
 DxatJezgu+0YV7hTZ/+qIvf3uW7DEe632UWRJ1d5BdZMMwtD44CldYY7dE5PTeMNUOkrlnatRNj
 4tFbtsDXgOfjtBlxqv8j01U4L2NJaVM4=
X-Gm-Gg: ASbGncuZg5RFJf/NQJHN1WP1um/D9LasuSPEd//YPc2uBZP7bjRR1YyWbkOmo3x1rNm
 +kdBFtUpNEbeQHFTPXQPLfzJS0vK16Jf421AwuP9fonpGUKp6lvl9BQWwtVXCHV8T3VVXSnzl4e
 PMYjzhbE0lipmu4pPKvZs/DFNTgtfuiWAY/Am2rQu9bdLNaowoFolPExJL5IADFQBbIHmZIS8MC
 sw=
X-Google-Smtp-Source: AGHT+IGFUxzNgY9VGvMjix2VRQzgIE0LZQnXfVPToy/orL9kcWKLyD7VDuSe5p//+3DfuaoEcW713DqWFG+WkRNvCdA=
X-Received: by 2002:a05:6512:1328:b0:553:37b0:d992 with SMTP id
 2adb3069b0e04-5533b8f4266mr936149e87.19.1748607198309; Fri, 30 May 2025
 05:13:18 -0700 (PDT)
MIME-Version: 1.0
References: <20250520084120.4175862-1-olaf.baehring@draeger.com>
 <CAJ+vNU1Ge_s4mEFYCn0TPhuKW5X1J-jcV3GyZqc_70GjgsqRtA@mail.gmail.com>
 <CAOMZO5CtK=Z4-60Ny+H8TQqAAT7B3jyqkPs75M7GrtGiq6tfqw@mail.gmail.com>
In-Reply-To: <CAOMZO5CtK=Z4-60Ny+H8TQqAAT7B3jyqkPs75M7GrtGiq6tfqw@mail.gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 30 May 2025 09:13:07 -0300
X-Gm-Features: AX0GCFuFySsAIJOirE6xnBNNGl7XKd9mRxTPn_qHVpFKySe8UjsrkVbfDt0F9eQ
Message-ID: <CAOMZO5BiPP9-S9sUsa6quR_gUgo4zwHZH-H81Y=wgpi8uBdWng@mail.gmail.com>
Subject: Re: [PATCH v2] caam: bugfix CAAM error on startup
To: Tim Harvey <tharvey@gateworks.com>
Cc: Olaf Baehring <olaf.baehring@draeger.com>, u-boot@lists.denx.de, 
 Gaurav Jain <gaurav.jain@nxp.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Peng Fan <peng.fan@nxp.com>, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
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

On Fri, May 30, 2025 at 9:09=E2=80=AFAM Fabio Estevam <festevam@gmail.com> =
wrote:

> u-boot=3D> rng 0 10
> Reading RNG failed
> u-boot=3D> rng 0 10
> 00000000: 27 42 f0 b8 92 c8 ca 29 6f 6a c3 98 ff 61 2b ae  'B.....)oj...a=
+.
> u-boot=3D> rng 0 10
> 00000000: 48 fb 52 44 29 ea 83 f9 a4 1d 68 20 82 c5 af b5  H.RD).....h ..=
..
> u-boot=3D> rng 0 10
> 00000000: 92 63 76 fc 1c 12 4b cd 68 50 8c fa 2b 51 21 50  .cv...K.hP..+Q=
!P
> u-boot=3D> rng 0 10
>
> (always hang in the fifth attempt)

Correction: it does not hang in the fifth attempt. It works on all
subsequent calls, as Tim reported.

Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3512C5B543
	for <u-boot@archiver.kernel.org>; Fri, 30 May 2025 12:09:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5C26082BF6;
	Fri, 30 May 2025 14:09:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="f1EBdYkg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1ACEE82C44; Fri, 30 May 2025 14:09:26 +0200 (CEST)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com
 [IPv6:2a00:1450:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1302582AB9
 for <u-boot@lists.denx.de>; Fri, 30 May 2025 14:09:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-54e98f73850so2226773e87.1
 for <u-boot@lists.denx.de>; Fri, 30 May 2025 05:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748606963; x=1749211763; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b7BNuZGaMCe9AfFzPVh9BmC9FrdeMZ7pJoYGuB7G/eE=;
 b=f1EBdYkgGTGitaPSRdy+I4y3Kr8LdXCBObgpYgCnM/7zV/q8Qgnd+5bvLt6KNh2LS/
 oytgiZhd2aii6mcVnAw7vJUxnHh5YeSlMC7DKS/l/hLbpvQ0g3ZORfmTSyv7VAvoyOn9
 aqnxY+IAh6uuaEo/rkl1NR+x5WBM6IU0cXPAQj10D0bfFU7EHOxJmt/3OiSPq0UIWTtk
 IUpMMUehSuuatcSjvNuxahTdYZ/TLo3QDXmyaREFPSUkIC7jaYXFnmGhBaaBCi2BpZkj
 E6z43siHD8XG0Xz8KGY4xs9oQwv9z4B39gUcp2iyOnhyMDfEU9NXwc7mZcqVWlZWJH66
 rHPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748606963; x=1749211763;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b7BNuZGaMCe9AfFzPVh9BmC9FrdeMZ7pJoYGuB7G/eE=;
 b=Hjm8cVYhYmY6aRr65sErzqLzJLva5VTajnzUGac/gJtCySZLo7jxL8U6F7g116gLBR
 nB6yMo2niT+yofJQoeCZ/wXtHbZViZE+UOtTl9rJHOL5v4wOiNGpO/7joPQqcORYnjw9
 LkAkSEsXxOMI3W0VM9gcCOB2549Kr9egLIsxLkcg4jod0WhjYaTeQNE6ZNrHwB61HY+y
 Njd4BUmQw4W/6u7XuB5g4ZAq3pCNPY3yygdql7iwhdBmgT9yUjmwAQVe885wPjMqmUkA
 ijyJFxzvjDk1BWM+ZL5Ce6vpsQh/DASy7OOCiL1Nlo7dkGCR23FHZcdEjFN1i0DAAqD5
 2xvw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVER1+NSsOVeDWRt9LKtYblaPBn1DjuTPZOZoP0S4ZcbctuOvKE7ki61TyIm6RXr0ynq32Q8xE=@lists.denx.de
X-Gm-Message-State: AOJu0YwO+apO1/Nyz8MwmxE9LcDzUP9Q992Apg2oaCp5pTkTZ7lHtWPd
 dd0XRaxkwebqtGXnQVRSBoXVbA7c6oDcvh4OlS2nb1gz3aysN1Fy+oadFyTDsctYp9dEmZzsXzz
 F2calsVCpZk+Jpo6f3T/iKt2wsYCjNLzSCtHh
X-Gm-Gg: ASbGnct12OGDFA33MtdebiyllMkT0wDVVGoxaCkE2ew5V3B41PZ8qRh8v9B0/Qz7Fro
 BHeZNbxrTFJj5g8sayflQqF2bgypmYdnQ18DJPcPFHx1uICcXBmdFhCvrZWWxa2nOE9+/Vby5Ll
 H5dlpMGYA1EJE9+PzzbjfHWhDklU9UIecOB2XC/LtHkdn/qKUvkNSzZoM2yjhjXvvA
X-Google-Smtp-Source: AGHT+IGmSRc9OiAx367JBbtT+LRoTWagX3AG2buktdVYpR/n2hDJtwZLpRCPUsLfGFgEwu49rSsRQvHpZUFECI1v0Co=
X-Received: by 2002:ac2:4c4a:0:b0:553:2438:8d02 with SMTP id
 2adb3069b0e04-5533b93b6cfmr1088397e87.47.1748606962973; Fri, 30 May 2025
 05:09:22 -0700 (PDT)
MIME-Version: 1.0
References: <20250520084120.4175862-1-olaf.baehring@draeger.com>
 <CAJ+vNU1Ge_s4mEFYCn0TPhuKW5X1J-jcV3GyZqc_70GjgsqRtA@mail.gmail.com>
In-Reply-To: <CAJ+vNU1Ge_s4mEFYCn0TPhuKW5X1J-jcV3GyZqc_70GjgsqRtA@mail.gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 30 May 2025 09:09:11 -0300
X-Gm-Features: AX0GCFtajnQqGwlEqWkjK9Aboa3yjIPAzr94EMIA1SVk7gVjzYVRiFiBY5XecPY
Message-ID: <CAOMZO5CtK=Z4-60Ny+H8TQqAAT7B3jyqkPs75M7GrtGiq6tfqw@mail.gmail.com>
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

Hi Tim,

On Thu, May 29, 2025 at 6:39=E2=80=AFPM Tim Harvey <tharvey@gateworks.com> =
wrote:

> I've found that this patch causes a regression on an imx8mm board
> (imx8mm_venice_defconfig) where the first call to caam_rng_read fails
> here in jr_dequeue but if you call it again it works. With some
> debugging added:
> SEC0:  RNG instantiated
> ...
> Hit any key to stop autoboot:  0
> u-boot=3D> rng list
> RNG #0 - caam-rng
> u-boot=3D> rng 0 10
> caam_rng_read caam-rng len=3D16
> run_descriptor_jr_idx idx=3D0
> Error in SEC deq: -1
> caam_rng_read_one run_descriptor_jr failed: -1
> caam_rng_read caam-rng caam_rng_read_one failed: -5
> Reading RNG failed
> u-boot=3D> rng 0 10
> caam_rng_read caam-rng len=3D16
> run_descriptor_jr_idx idx=3D0
> 00000000: ad 2e ad c0 2a 12 27 c4 65 82 66 19 be ef f6 07  ....*.'.e.f...=
..
>
> If I revert your patch caam_rng_read works initially and on subsequent ca=
lls.

Thanks for the report.

On an imx8mm_evk board, I see:

u-boot=3D> rng 0 10
Reading RNG failed
u-boot=3D> rng 0 10
00000000: 27 42 f0 b8 92 c8 ca 29 6f 6a c3 98 ff 61 2b ae  'B.....)oj...a+.
u-boot=3D> rng 0 10
00000000: 48 fb 52 44 29 ea 83 f9 a4 1d 68 20 82 c5 af b5  H.RD).....h ....
u-boot=3D> rng 0 10
00000000: 92 63 76 fc 1c 12 4b cd 68 50 8c fa 2b 51 21 50  .cv...K.hP..+Q!P
u-boot=3D> rng 0 10

(always hang in the fifth attempt)

With the path reverted, it always works:

u-boot=3D> rng 0 10
00000000: b4 14 26 f8 1f 78 65 b2 8f 0a a6 c4 6b 47 f5 61  ..&..xe.....kG.a
u-boot=3D> rng 0 10
00000000: 6e 5f 7c fa 13 d2 b7 b5 cf 5d 3d e6 82 c7 a6 3e  n_|......]=3D...=
.>
u-boot=3D> rng 0 10
00000000: 25 84 1b 86 89 ae 20 a8 a2 53 9a 7a 8a a5 6d 45  %..... ..S.z..mE
u-boot=3D> rng 0 10
00000000: 94 05 b6 7c a4 38 5a 89 0b 5b 38 86 61 ba d0 32  ...|.8Z..[8.a..2
u-boot=3D> rng 0 10
00000000: 57 c2 36 dc eb 68 3b c3 f5 1b f9 76 3c a6 1b d5  W.6..h;....v<...
u-boot=3D> rng 0 10
00000000: 2a 34 95 03 27 75 d3 9e 75 1b 99 0d 25 87 78 1a  *4..'u..u...%.x.
u-boot=3D> rng 0 10
00000000: 4e e4 b8 ca 97 91 c8 53 67 85 28 51 a1 11 39 3d  N......Sg.(Q..9=
=3D
u-boot=3D> rng 0 10
00000000: 30 fb 41 d7 a7 18 63 64 8a 9f 37 84 b3 bd 57 dc  0.A...cd..7...W.
u-boot=3D> rng 0 10
00000000: 9b 5e 46 89 5c 59 5c 85 30 e4 58 be 56 7b 20 31  .^F.\Y\.0.X.V{ 1
u-boot=3D> rng 0 10
00000000: c9 41 27 73 f8 8e 33 65 ca bb bb c1 b1 b7 7b a3  .A's..3e......{.
u-boot=3D> rng 0 10
00000000: f2 9f 8e 26 b6 93 4e 24 71 18 3f 72 2a 19 20 ef  ...&..N$q.?r*. .
u-boot=3D> rng 0 10
00000000: 1d c2 5e 55 ec 27 d7 5f 2b 65 a1 46 e4 2a 55 a5  ..^U.'._+e.F.*U.
u-boot=3D>

I will wait for Olaf to submit a fix for this issue.

Otherwise, we will have to revert the patch.

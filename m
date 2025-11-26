Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72DEBD10F21
	for <u-boot@archiver.kernel.org>; Wed, 26 Nov 2025 11:06:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E5A7D84011;
	Wed, 26 Nov 2025 12:06:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lruGkeTA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D7C2841B1; Wed, 26 Nov 2025 12:06:46 +0100 (CET)
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com
 [IPv6:2a00:1450:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC687836D3
 for <u-boot@lists.denx.de>; Wed, 26 Nov 2025 12:06:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-37a2dcc52aeso63160721fa.0
 for <u-boot@lists.denx.de>; Wed, 26 Nov 2025 03:06:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764155203; x=1764760003; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yzRbB5BBRZPRFCmSkF7F2LIS/ZVbtOY01ovKNi03s6c=;
 b=lruGkeTAdvgT+k3+UMCAau6JPFLLfHs2oIVtzwev79KQ0dB8IF0JC9ijgkycEUI8YU
 7I/N5YvUZVwwO9wrX3crCldlGtS+lSMNLZCUYwydDkj4lQ4okMkNFoKBH/nKQbUmWPXE
 yBcWHhrocRMvN1a4wt8qEI3mbQ32DswqF2F9lIrezzYRwLjl/eule+NXL3hDu4Cl1qEH
 V2ndP4RwA04PnxRsSMBoutpViBKBnHd2DgDpO02WPWD0G5DsgWXuJH20u+17RtICm/r3
 cIxs3T0rkuPkgf5IvEPZWYPiNOGLlR1qy1ORGyu9e8TY5Ssu745yzl2EWZki5fs//Fy5
 KGDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764155203; x=1764760003;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yzRbB5BBRZPRFCmSkF7F2LIS/ZVbtOY01ovKNi03s6c=;
 b=Sf1wWXX24vwbo7aQy5/wTod+xGR5KY6Tnyc4QIHSqPXDUEqQh8kNutWD4TsFr92bsB
 5cwHeibmw9inBt3qzviUT72Fjk1m9WkABvQ9CdcgJ44zuq3Hq2ErLP3YO1pT4nhjVDXS
 OBTTyn04rOuxRbUIZ1zO8LnCvg0xefSijni0zroh5fGGpZdBar4oKJdEnppCZLh9KmxS
 eUyhCuziXUDAJLBccQiiEQaySI1x5lmUxjyGB8wN2TlM+FpblD4cFufKzeY7x7guCbBD
 64As7ADIsqAM2nV+VD2+ZXY5EcNy+Wuyl+QAZPKPan6K0WSPICuRe1/x4BMGItxgPeoq
 uX0g==
X-Gm-Message-State: AOJu0YzmwkSw77hBv++iv22/nAD3oHgoawDnyKdcC1QBs3GRk66rAgMj
 7YUiCjgYRGpoukLnCQAFJFs1AL9oPKguVSOaGlxtvQLO3BWTfVZIILcnhqRdh7+eCnzavvoQ5MC
 tw3OjUELFSvkdFnxpaT2+BQF7Fhw/WOU=
X-Gm-Gg: ASbGncuKJVey7YRw1mQxJYzfJ9j2fYQwqzReuOH82GvF48ZjOL5UnAY0qe0GJaqWFS7
 kdf+LpOd73VFNqb7dKb2ov/v0Zw2neZnQM4itNoU6wHCc+dNTugKQkFGczJt1T7mtuz4Dre3Up/
 BhMuuzequ7Gt4Amm0fHE1694qpCvTClURPI9lx0W2Z5GWx5nFmcMNNbw/bpy9IIxWQJS8RDASLD
 fiUj6PNIncizNMgZZmuQvJsK5PkIFLeFUBy4cOLNp1a+a4OsMSsfjxx/Hc91EZ12TLTPdu6YBmN
 hJvR4QgeC2JxDclRJfkTGP8+9yAS3eeBxlXo
X-Google-Smtp-Source: AGHT+IGXhN5i2o1J+BmiKn6jfdPbTEtPfOS0uk1UY+wxvQAStgEC8P0vmEXPRI4KAGVFICz+U1QKMVxP6N3Qpk1P9gI=
X-Received: by 2002:a05:6512:3c83:b0:596:9d35:b62a with SMTP id
 2adb3069b0e04-596b5062a46mr2317663e87.33.1764155202667; Wed, 26 Nov 2025
 03:06:42 -0800 (PST)
MIME-Version: 1.0
References: <20251120112300.1242106-1-alice.guo@oss.nxp.com>
In-Reply-To: <20251120112300.1242106-1-alice.guo@oss.nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 26 Nov 2025 08:06:31 -0300
X-Gm-Features: AWmQ_bmZad6rLlXDyLhmuc8E-CmPda_laPOVWjxHBwD7B3-gM2z9W2952yNbteo
Message-ID: <CAOMZO5A+Jos1UfoE9R20ToERuLuGgAxB+2=Jq8-YDW9kga89tA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] arm: dts: imx8ulp: Ensure mu@27020000 and lpuart5
 availability during all boot phases
To: alice.guo@oss.nxp.com
Cc: u-boot@lists.denx.de, uboot-imx@nxp.com, sbabic@nabladev.com, 
 trini@konsulko.com, alice.guo@nxp.com, peng.fan@nxp.com, lukma@denx.de
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

On Thu, Nov 20, 2025 at 8:24=E2=80=AFAM <alice.guo@oss.nxp.com> wrote:
>
> From: Alice Guo <alice.guo@nxp.com>
>
> mu@27020000 is required for communication with ELE firmware, and
> lpuart5 is the standard output device. Both peripherals must be
> available before U-Boot relocation. Use bootph-all instead of
> bootph-pre-ram so these nodes are retained across all boot phases.
>
> Signed-off-by: Alice Guo <alice.guo@nxp.com>

Applied the series to u-boot-imx/master, thanks.

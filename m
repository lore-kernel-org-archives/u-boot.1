Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9746ECEF17A
	for <u-boot@archiver.kernel.org>; Tue,  8 Oct 2024 14:10:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 11E8288CF1;
	Tue,  8 Oct 2024 16:10:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RWmrvalr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 543AF88CC8; Tue,  8 Oct 2024 16:10:47 +0200 (CEST)
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com
 [IPv6:2a00:1450:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D71B88CF1
 for <u-boot@lists.denx.de>; Tue,  8 Oct 2024 16:10:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2fabc9bc5dfso65064351fa.0
 for <u-boot@lists.denx.de>; Tue, 08 Oct 2024 07:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728396644; x=1729001444; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pqHYD3isOr8iU0dGuPYtck/2BcZIolBZBO0j/08JaWA=;
 b=RWmrvalrx/ZSwScST2B8DCobx3TIdY1srefDIigEK/UDZCE5XiaNpEhTkv4ORU+dwH
 k4rM1vXS15q+hN2Uwk5vHysM3okAkdHOZh99blURnaxjostX10a+xttTgKl/CZzixU1J
 nXUrrchZ4CFnHBXF1rFGUgBNn1Xo8BH0bqpR8Ys9ZiKRlLZvcUVcA9APogKgmF82kMmE
 NMSA/6z9Y81lrI/IGAgNbZhVTEyFSSRx7/3YvMHQotEH4XhlS9dEUMZFZeVVGSNiRno5
 wwMeYlKpf3HGEMDmn5lJIzK2m33Q8f9M2TBroUwWeR5xoFTccw6Mtm082Bz0vy0vx3Gw
 alIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728396644; x=1729001444;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pqHYD3isOr8iU0dGuPYtck/2BcZIolBZBO0j/08JaWA=;
 b=cDPBKN9It2GszzkOEYglAXx+d83nocLhl7rqEQq57gCywrEKohD20G3k++DoQ8K+Qc
 JQLIhZLVEQhjxD1K55O5kRddf9cEeQqRyBNu1lLwFz0MtKeoNrfPWIupYcMG+sQgH8NH
 /whTUNe3KfJnwd/TOwOHlg22T6643VhAMiFEHsWigc9LvAaGDo1htyfdkOpxVJrDAhxU
 7bFWDngloeEa5PBGAe0lpNTqsqWaJyOTKrZqp7wxxI9WGRuGIHjEV7rPXxSvIvtnNPpT
 A6wuDNmBQkUEGkE5gVj473fRGgcEEtpjCtVElPkiGhuiC35kAYgQjYmNW1CzSo/1y5nK
 /AUw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXcVyT3ITwq1J7eGf1otnJbVrUPE7MjaJDWzi0i12J2FQWnoCaO61U3/oh5OGXXt59Q9NYCwl4=@lists.denx.de
X-Gm-Message-State: AOJu0Yxi2zj+EwoDB9/lcC2UXFEw/8ed+X3c/K0znLV4oCHzW9B/AlGk
 GdAkw/8M67qEd1Qca3WCpRXsaVTSXB9iqp+UjILNH4vq3B8zpz/luqNJmSMnCtTeqbzx0rCZUHl
 va6RG8zC8PrM3sxoiWaxRV3eS8+c=
X-Google-Smtp-Source: AGHT+IG7BIfvPFlo6bA4guYikrVHaKRALbQ8ZeDF7GEZDjQznXA81BUQH0IGDu8Z51Jaq8O70kBzaVOlx5xHRq35iaU=
X-Received: by 2002:a05:6512:2245:b0:536:52c4:e45c with SMTP id
 2adb3069b0e04-539ab87db5emr8031820e87.31.1728396643505; Tue, 08 Oct 2024
 07:10:43 -0700 (PDT)
MIME-Version: 1.0
References: <20240930161006.41052-1-brian.ruley@gehealthcare.com>
 <20241001135810.96-1-brian.ruley@gehealthcare.com>
 <20241001135810.96-2-brian.ruley@gehealthcare.com>
In-Reply-To: <20241001135810.96-2-brian.ruley@gehealthcare.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 8 Oct 2024 11:10:31 -0300
Message-ID: <CAOMZO5DarURuedfyC-v5c7kfPh0BX6f+2tLYtdZcxQh2FBKoyw@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] binman: add fast authentication method for i.MX8M
 signing
To: Brian Ruley <brian.ruley@gehealthcare.com>, Simon Glass <sjg@chromium.org>
Cc: Alper Nebi Yasak <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>,
 ian.ray@gehealthcare.com, Marek Vasut <marex@denx.de>, u-boot@lists.denx.de
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

Hi Simon,

On Tue, Oct 1, 2024 at 2:27=E2=80=AFPM Brian Ruley <brian.ruley@gehealthcar=
e.com> wrote:
>
> Using the PKI tree with SRKs as intermediate CA isn't necessary or even
> desirable in some situations (boot time, for example). Add the possibilit=
y
> to use the "fast authentication" method where the image and CSF are both
> signed using the SRK [1, p.63].
>
> [1] https://community.nxp.com/pwmxy87654/attachments/pwmxy87654/imx-proce=
ssors/202591/1/CST_UG.pdf
>
> Signed-off-by: Brian Ruley <brian.ruley@gehealthcare.com>
> Cc: Marek Vasut <marex@denx.de>
> ---
> Changes for v2:
> - fixed default key length (s/2048/4096) for srk-crt node
> Changes for v3:
> - code formatting
> Changes for v4:
> - fix spelling in commit message
> - code formatting

Are you happy with this series?

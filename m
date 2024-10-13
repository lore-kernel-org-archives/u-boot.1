Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54844CF258E
	for <u-boot@archiver.kernel.org>; Sun, 13 Oct 2024 20:22:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC9D189069;
	Sun, 13 Oct 2024 22:22:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TCaez+xs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A85EC89067; Sun, 13 Oct 2024 22:22:41 +0200 (CEST)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com
 [IPv6:2a00:1450:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BD6B589070
 for <u-boot@lists.denx.de>; Sun, 13 Oct 2024 22:22:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-539f84907caso151820e87.3
 for <u-boot@lists.denx.de>; Sun, 13 Oct 2024 13:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728850959; x=1729455759; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R9oy5+voHsipK7JA7QypjhZiKiFONO5ZNRuKz9e30Z0=;
 b=TCaez+xsjSHGhIk3XpR/xIlpxgmAdsoDLZHCNu+ldd7w1xacBFizVbDgG4MC8pgqrE
 wnsIYoNdDRpEKPFrihQOtfr8LO95HmEs+KF8of1wOH7S/5b4IkMRtN6uzwlz8yQJtyn2
 qlRWBdAuEA+xLd+Nvy6RHyu0Eql/rEeH/4+BoVckw5id0/Q45EYC4Jm0/Xj5ZKKPTuVb
 eT481q7/Y/aNKkaO7Stbo98bnhbMEUJWu3oRjhn+V3JMFcRo2ufoAqT9DR2NcYv+oy6R
 sqpdud6z7533fk3LcB0cc6KCeKmBh5MYFWIne1YibNuhh2lTQqAOmwlxSH8GLPioi4iO
 cNag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728850959; x=1729455759;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R9oy5+voHsipK7JA7QypjhZiKiFONO5ZNRuKz9e30Z0=;
 b=QQXGIu3y/1Ej8mgp70sLj86Hrnw/u99lQdMrdJnuwsZn6Ma6jWMs3Ol7d5SkGxSA6U
 WoFhDqojiWWELWJ3dpiiuOLRJ9nMUn7KCoWlcxGHaY+O6R5wSYI8sM4xGL7952r4WJMV
 c990NrXz96srfpmx5JR39cy4oyDcLj2yjQUieA7j1CWkTR+g+gZGpCc3g9s1WIYbXv3b
 bGlOfKzibPuZ6jl6Anu8V5RZWLSqdM5ZRauxaDanMQMhyaIUV1yaAXmkDUxjBkGKC+qj
 Lc6IaOwI4qvFC+wKiug631FYdUlEJfnNMHNgZGbXtKFgV1oEDnyhsti+k2rgX2D2uxdN
 4vhw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXW0dw+aGZKvPew61wdc/AlnA9wGDNr+aCN7bP9rkvqD5uPiDv3/MWR7f6dvfR0VsiWabbmbM4=@lists.denx.de
X-Gm-Message-State: AOJu0Yx82V+QMbQGKWRRZRIa8tf8NmWnbBfj7KRDNzhlePaAyCtOFxfr
 G+VIK1oWUWsMdVZZ5HZkHMDtyKF//KrFLtyQwLQMwRRwH8ICyYCyhij7K1Nv+yIe7v9n36KTRGw
 XAGBldX0LjaW9UxSz0XF3fz758OI=
X-Google-Smtp-Source: AGHT+IHMfViUFn8wkOSilGb4HdChNWVzcWuun7GK6vl42RxTlgJzA93OyXNfMnIqO0CKPOBvhtaf7bgsANBAV9w/XPE=
X-Received: by 2002:a05:6512:1044:b0:536:7a88:6185 with SMTP id
 2adb3069b0e04-539da3c692amr4182712e87.15.1728850958856; Sun, 13 Oct 2024
 13:22:38 -0700 (PDT)
MIME-Version: 1.0
References: <20241006003006.20162-1-peng.fan@oss.nxp.com>
In-Reply-To: <20241006003006.20162-1-peng.fan@oss.nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sun, 13 Oct 2024 17:22:27 -0300
Message-ID: <CAOMZO5A3PmCZbEOQvkj7uhrRHDXoyMjz9TyDvY30Msx39qG4hA@mail.gmail.com>
Subject: Re: [PATCH 1/4] misc: ele_api: Update ELE read common fuse API
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: sbabic@denx.de, u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 uboot-imx@nxp.com, Peng Fan <peng.fan@nxp.com>
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

On Sat, Oct 5, 2024 at 8:26=E2=80=AFPM Peng Fan (OSS) <peng.fan@oss.nxp.com=
> wrote:
>
> From: Peng Fan <peng.fan@nxp.com>
>
> On iMX8ULP, the word index 1 is used to read OTP_UNIQ_ID with 4 words
> data responsed. However this special index does not apply others.
> So restrict the check to i.MX8ULP to avoid problem when reading from
> fuse word 1 for others, such as i.MX93.
>
> Also update header order
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Applied all, thanks.

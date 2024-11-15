Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B1B6D68BCF
	for <u-boot@archiver.kernel.org>; Fri, 15 Nov 2024 19:03:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC5F789185;
	Fri, 15 Nov 2024 20:03:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QQDLidog";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1BBA989294; Fri, 15 Nov 2024 20:03:30 +0100 (CET)
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com
 [IPv6:2a00:1450:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 240ED88F49
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 20:03:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2fb584a8f81so21529231fa.3
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 11:03:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731697407; x=1732302207; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a8tHIfmQBawhv2OhFI4qFQ082DfUBmzrC/0eVMkmyWc=;
 b=QQDLidogUp72p1dZF3YE+C3qzhf+Iq06jC14NXbIDPDCI+4u7pRetYZwo/Ye5atafc
 LoKYw1GS4XdkXFBgGfs9VBN99YVEWedMRJJVfpxZx3lNsJk3yBWEtUTuwyvYMpBT1u1R
 Ipg2sxwgSzg4Tl4vmhxkoD3DGE65ulOS66kaEVUhXR/wjt+0CxiocNidNDq4NDcecSSa
 Ep5hj6a7rBTrObLFw4v3fLaCcniRWDCfxJidXUgnjTSCE1XGLy1qvV9gnaf0eJfWf9rJ
 5Y68+4S5tTi25XNDMRAofzxU6NIEuitAtvgQmfzNK7GQpEVTdHWq0+7gVyI3ydb/eFC0
 UywQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731697407; x=1732302207;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a8tHIfmQBawhv2OhFI4qFQ082DfUBmzrC/0eVMkmyWc=;
 b=wD0Xhk9cUsZWsYwPWe4CSTtfdUVF3YVwOKPoxJFnW7VzMNppozt/9k/GMOZ+xb59Mv
 QTLOmn5fUK8EIbF8gTtAdpCk0MCshsBksJgf+ql+iVm07uVkeyydMyUMfN4l/fhvhTjQ
 3+a341hLeUzmVXctYrUa20xmm+jt1S8PspHCAeMmf9rY3m9Vfy2iYWKcsbXyPqjgVa5e
 UuZYzvprjC5T5rNNqggJCVpIAXiGnyoG1eoZVFDZQkCCORAcVb1SQTUm90Y01CgpYQLw
 6GoZ5suiqeI7A8eTxFWuwFBxpHj+p7UvOhY2OBbrPkvFdb6Ybb1hzJPkhUVDCm526Vgn
 xR5g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWBT6SigZMvIP41I9ypTg9VhQlmoGB4rf6w7nptgmoxP1FPnMxoj/6iDReSxeJEjabyTH4lMMc=@lists.denx.de
X-Gm-Message-State: AOJu0YyRapDa2bKJ2OPjVsB0DH61KDvifqrq/S/jjU9g9uEhd9Oq2tVg
 N+vXHT2vuwxdrskjBuAlh3pW6jIWSBl0AxgPNUdF6uwjv2hFAthpEwaLLxwrXNjH8XrvCCSNY9A
 ZWdFuXSWeeMNvvtL8bd33QBibiUDOJw==
X-Google-Smtp-Source: AGHT+IGDDH1Ik8TKMGID2pvuI2RhMgo7eM0W+pCWQ9xReVxXKn+M7KLOOYLc7wyoi/RBPWwkhl7fjwcHeUjwnKytbfo=
X-Received: by 2002:a05:651c:245:b0:2fb:4f2e:5be7 with SMTP id
 38308e7fff4ca-2ff6096b5cbmr24002191fa.24.1731697407089; Fri, 15 Nov 2024
 11:03:27 -0800 (PST)
MIME-Version: 1.0
References: <20241112175427.83979-1-francesco@dolcini.it>
In-Reply-To: <20241112175427.83979-1-francesco@dolcini.it>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 15 Nov 2024 16:03:15 -0300
Message-ID: <CAOMZO5BsefivQ_d==W79s=8cpapLJTLNwcTUKpe794-6F3=yKg@mail.gmail.com>
Subject: Re: [PATCH v1] imx: Fix critical thermal threshold
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Stefano Babic <sbabic@denx.de>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Tom Rini <trini@konsulko.com>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>, u-boot@lists.denx.de
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

On Tue, Nov 12, 2024 at 2:54=E2=80=AFPM Francesco Dolcini <francesco@dolcin=
i.it> wrote:
>
> From: Francesco Dolcini <francesco.dolcini@toradex.com>
>
> Fix the critical thermal threshold for i.MX processors, this was changed
> while moving the code from imx8m/imx9 directories into a shared place.
>
> There is no need to keep the critical threshold 5 degrees less than the
> SoC maximum temperature threshold, what is actually going to happen in
> practice is that we are going to power-off the board when the SoC is
> still within its working temperature range.
>
> In addition to that this is a change in the actual behavior, that is
> introducing a regression to users, and it was hidden within a software
> refactoring.
>
> Fixes: d0fe80890ab1 ("imx: Generalize fixup_thermal_trips")
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>

Applied, thanks.

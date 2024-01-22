Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F08ADC4725D
	for <u-boot@archiver.kernel.org>; Mon, 22 Jan 2024 12:59:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6146787B0D;
	Mon, 22 Jan 2024 13:59:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lzjQjrly";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C95EC87B41; Mon, 22 Jan 2024 13:59:50 +0100 (CET)
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com
 [IPv6:2607:f8b0:4864:20::1035])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A4E368796E
 for <u-boot@lists.denx.de>; Mon, 22 Jan 2024 13:59:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-29070f15499so71365a91.0
 for <u-boot@lists.denx.de>; Mon, 22 Jan 2024 04:59:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705928387; x=1706533187; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VojQPAsyxtrxrBwTDv27XjJ4qX+hIASXBvriwDmAO20=;
 b=lzjQjrly00vuleVH5MDtHjwtt9daRHE97Dx0S8BsHTfh9oaONuE7wcqlw5RjGTYU5/
 /GH2nHyzeeSOESWw8T+K0cgjS28I4iM9QyLGcHad9JwO0xJJMCN088jT2TcUHg8WwCuF
 vRRk8RN9EwP32Y+Mb6bAou3kfVEI2bQeXxJE/1aAg+S5d6FkAbvHxqeI9LvAA0m0Z+C/
 ntsktEZfD8fgb4fHOGMksqJo53BPDv9uEO9tdyOy6x52YdUtc9eS/u1TIYxyDwDkkuye
 kcVyNw8yThwTkTwmY0cAoKsTBgEjRtalVQxmjO6xN3xENt/zTu1ASzLvccAHFvCvv3pw
 4QCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705928387; x=1706533187;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VojQPAsyxtrxrBwTDv27XjJ4qX+hIASXBvriwDmAO20=;
 b=Uc/zGOeMNiFAhQzCw4JfOXVx5H2g638g/49X/hFaM2zlKFjAVKNc0pfBpM4S6tuxr+
 5q4lvHIgPfHzQqUG2pVjR2XT65m0LrXLC2hCNAudhgonyW7/TqWhmVYCar9W3sWJHdph
 guUGDCofL8andVfNIgJOYEfwViV7mG+aafBMHGASAb9yWA2pqo7Jh9rT626HjZAVyyJb
 zmtkwaZDMeLtb0BQCQb+/iuO8LpOl84cgBMYTJXuQp8bOXMssiBTOHelA0KwyUoi13th
 Iaf+xR+X2EoGPcj2633sP3bm5ieTYR4+qtLSGZ726G1AY9digkIHJufGaLXn0gSu8/Dq
 B+2g==
X-Gm-Message-State: AOJu0YwlFsw8VCvjl1Wo6wbeoim9Eb2fLPT2diM6bPPAKBzbW2RDSfsk
 RNZC71FSHggXiMTp4u12puBXn79Pz48QABs59m9nBJa7QvCQSxR3pe9Yp8JwfoHZ1/czkQzJE+Y
 R9PTkMVb01yV0BwdQniR9UQ1pYb5/uZRX
X-Google-Smtp-Source: AGHT+IFpXJ9IaVvTPhTNxm2youay2MoWKu3cFVu4Q1yC0UDpJgTLDT3jq6nKuVWledeKPtwejsHCbHiCoxyqjxjaNn0=
X-Received: by 2002:a17:90a:88f:b0:290:239b:8f8e with SMTP id
 v15-20020a17090a088f00b00290239b8f8emr5220086pjc.4.1705928386962; Mon, 22 Jan
 2024 04:59:46 -0800 (PST)
MIME-Version: 1.0
References: <20240118150640.3802089-1-festevam@gmail.com>
In-Reply-To: <20240118150640.3802089-1-festevam@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 22 Jan 2024 09:59:35 -0300
Message-ID: <CAOMZO5ABYo_bsmTiwG6yKhhwnx0XV7qb4_pW_LwQ_1mGZ4JszQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] imx8m: Enable LTO by default
To: sbabic@denx.de
Cc: uboot-imx@nxp.com, marex@denx.de, thomas.schaefer@kontron.com, 
 u-boot@lists.denx.de, Fabio Estevam <festevam@denx.de>
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

On Thu, Jan 18, 2024 at 12:06=E2=80=AFPM Fabio Estevam <festevam@gmail.com>=
 wrote:
>
> From: Fabio Estevam <festevam@denx.de>
>
> In an attempt to select ARMV8_SPL_EXCEPTION_VECTORS, the SPL size
> could not fit into the internal SRAM of some imx8m targets:
>
>    aarch64:  +   imx8mm_phg
> +aarch64-linux-ld.bfd: u-boot-spl section `__u_boot_list' will not fit in=
 region `.sram'
> +aarch64-linux-ld.bfd: region `.sram' overflowed by 1824 bytes
>
> Select LTO to prevent that.
>
> Signed-off-by: Fabio Estevam <festevam@denx.de>

Applied only this one, thanks.

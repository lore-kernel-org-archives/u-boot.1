Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B8BFC10DAA
	for <u-boot@archiver.kernel.org>; Wed, 29 Nov 2023 18:11:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B522B8773A;
	Wed, 29 Nov 2023 19:11:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="P+OlIHUS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9EFA1877B1; Wed, 29 Nov 2023 19:11:26 +0100 (CET)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com
 [IPv6:2607:f8b0:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 613EB86BA8
 for <u-boot@lists.denx.de>; Wed, 29 Nov 2023 19:11:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1cc13149621so124415ad.1
 for <u-boot@lists.denx.de>; Wed, 29 Nov 2023 10:11:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701281482; x=1701886282; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6j95PQ3ruibwt860UmJgR+Vd1s6VDFDVUYBMjkb98Tc=;
 b=P+OlIHUSGQxZnKA310Y+YCaOloHw6wLVRswXMZkbiS0EmQj3Fg1bSnMBvqkYLbFExr
 +fLAMv/7ARlAAP8DXQLCDR848ZkXaGPxO7I2fh9a5kRkcEloWZ5f7/g3U6kzwYx7vGhI
 KPzHAZE+g07MTyqdVfArPJN19N0/bHpph4tv0Wupcodko7gjEjWzZIBo1UVp/mYUupwX
 SX1FTJzKf//vtuqTmlaUmJsxQKhj/fNxPNfQVf4rfKVjn6JIcYig4xr0XS9fJwN/LZYn
 5Fe58yhUiGrSNGHYINhCJYBDSOyi7i13vXx5/C4zCMw94zi+yKDqlh9ecio74bbp5+E7
 NXMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701281482; x=1701886282;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6j95PQ3ruibwt860UmJgR+Vd1s6VDFDVUYBMjkb98Tc=;
 b=AN0HSwcSexIpN88t1d6+UelLTDXrLD7mXVa1cfSL8X1Mu8goVtB9iIPYTPBD4ryTof
 dvqHBkEJq7QKAs9Ia9DwVK91EemgeSEMgKUTX6++7etULR94PLBu2U1BJk3uFmRLt7qQ
 Y1tAELnOlzIBbAhhvCnOE2r9qdIL3unzVBr5c1MWBePYDYJsLB5MXIthomCSIKXzT5Nr
 ONjUnNvITrg/5B6MZ9j1ZFXnKwmK1C5LZdb5eKh/qd2KPZsLSUuuU73I4f04duQbpM2D
 tl/oTXh8GHsjkpr4XQbeyolDE7zw2uOHVXppzbrC8tTkKeE169h4AfNqKUPprJ3msPNr
 62fg==
X-Gm-Message-State: AOJu0YzfOJ5j/wxoaoWt0yr/dIkCS3mu57ocUO1PStdOUgaTq2vEq2jq
 Ii0wMRrhwXk8akBM5kQHa4Pi6lqI2J7cV7LdICg=
X-Google-Smtp-Source: AGHT+IEIhqUZf7lHmXYI5Rb9aqSR1+nhCPfB2UIM+0z2HF5AamF5ZW2uYHrd/ne86/dqQBLYmgBZazyHX7QLTOkzRP4=
X-Received: by 2002:a17:90a:7408:b0:285:6f2b:4e82 with SMTP id
 a8-20020a17090a740800b002856f2b4e82mr19226939pjg.1.1701281482430; Wed, 29 Nov
 2023 10:11:22 -0800 (PST)
MIME-Version: 1.0
References: <20231019194241.2207814-1-hugo@hugovil.com>
In-Reply-To: <20231019194241.2207814-1-hugo@hugovil.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 29 Nov 2023 15:11:12 -0300
Message-ID: <CAOMZO5CgqQHeb1mG8yGyLbqfV5OKqtZUiNExDTFgSATAWJ-nLA@mail.gmail.com>
Subject: Re: [PATCH] imx8mn_var_som: Add myself to MAINTAINERS
To: Hugo Villeneuve <hugo@hugovil.com>
Cc: "Ariel D'Alessandro" <ariel.dalessandro@collabora.com>, 
 Hugo Villeneuve <hvilleneuve@dimonoff.com>, u-boot@lists.denx.de
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

On Thu, Oct 19, 2023 at 4:42=E2=80=AFPM Hugo Villeneuve <hugo@hugovil.com> =
wrote:
>
> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
>
> I would like to help maintaining the imx8mn_var_som symphony board.
>
> Add myself to MAINTAINERS.
>
> Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Reviewed-by: Fabio Estevam <festevam@gmail.com>

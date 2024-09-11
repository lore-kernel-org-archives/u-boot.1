Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE488EE57F6
	for <u-boot@archiver.kernel.org>; Wed, 11 Sep 2024 23:27:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 69DFC88CC7;
	Thu, 12 Sep 2024 01:27:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="N6WytkQg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E078A88CC7; Thu, 12 Sep 2024 01:27:11 +0200 (CEST)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com
 [IPv6:2a00:1450:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC8BA88009
 for <u-boot@lists.denx.de>; Thu, 12 Sep 2024 01:27:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-5365d3f9d34so396033e87.3
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 16:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726097225; x=1726702025; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QTnFNwajuSL/d61ACiQAlao1VL3blH3joqJMIL00W24=;
 b=N6WytkQg9KJszR4cBmLg7Yjy8iwUxEMvT+Zd28dkT5GuP+QaQ4Rd5h0GSjAybCbMRW
 u4kQTMZqiC7y99fft0+7OjM42yHpRwdsT8tTTeo1PILD388FZNXN8LSk2IDy29d7uXKP
 uP4muUcCKjGBVhCZsziz8N4nQRq8kWzvRBKYFqWntuX3TlA41bdk5GJQn7CbkmXpP3EA
 518jGCRSBWcraDp72LErFX/bJQceoW1citW4MgpkuhM4V4da7+rbTH+WYJUpQx6+iqXP
 +UPeY60uy8KKDt4GaITwrCN4NSoq+x8Cjp9dQ6pkhXqA+udMkimv6zoYBqDJ66I7jp90
 vNiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726097225; x=1726702025;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QTnFNwajuSL/d61ACiQAlao1VL3blH3joqJMIL00W24=;
 b=kHWuw9+GTNDxuyq0r64WD0+uipvu0ZoFG9ufmealfXs0moszt6uwsr0er9hmc6jAfv
 nDSa5ZxNcHqM1OEng1x/17CbAAi89g5O4PaM+Mo/6z1cZgo9bUWsglq3S6Xn8QO78gFI
 VtQJVQCpou8BmyHzrjsynQjPq2pv0pHOgTCewZndjOJoQ0vpdzBmwiBDfrN0bm9M35jy
 UeigxOPaLxHO0xlyie3ZwAgkbOjkd8ddUwqlb7VnQYZ8TBbjfphtMkruogXKKDsQMVp8
 Wit01HqhE13pxXtGHImqN2MIIOqVQuBzp602hJHwCuq9AEkrJ1vB3V5XM/Pj1/jkOABn
 oE4A==
X-Gm-Message-State: AOJu0YxQRU7e1vO51B8NQLCiJbDvER67IgxZ6/Ena0Qwhe84ea4cQIlO
 j798jre/r483Cf7UJyzQ6sAV1kEZ8qmQQUP2qtnzW+OT0/q8jE6plE5nLwuPTydXnYPQDDB8G7q
 7faaTT4aXsl2s0i/Dm31Wfupk8AY=
X-Google-Smtp-Source: AGHT+IGXcevva839gF9bbmR8gFTFlO/xPEuq8m3laQTpAYtZDwcHtDlcFrg1RjY9ZcaMafbesNTBbVBla3LjmqLMoBE=
X-Received: by 2002:a05:6512:110f:b0:535:3dae:a14b with SMTP id
 2adb3069b0e04-53678fb8a3cmr491969e87.2.1726097224937; Wed, 11 Sep 2024
 16:27:04 -0700 (PDT)
MIME-Version: 1.0
References: <20240905190826.538309-1-tharvey@gateworks.com>
In-Reply-To: <20240905190826.538309-1-tharvey@gateworks.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 11 Sep 2024 20:26:53 -0300
Message-ID: <CAOMZO5BaUJVQ9MTCNjmkk9pNxjF+PFiUrKL3-ATCLZuxXHwgVQ@mail.gmail.com>
Subject: Re: [PATCH] configs: venice: enable DM_RNG
To: Tim Harvey <tharvey@gateworks.com>
Cc: u-boot@lists.denx.de, Stefano Babic <sbabic@denx.de>
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

On Thu, Sep 5, 2024 at 4:08=E2=80=AFPM Tim Harvey <tharvey@gateworks.com> w=
rote:
>
> Enable DM_RNG so that the kaslr-seed property is set in the dt allowing
> Linux KASLR.
>
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>

Applied to u-boot-imx/next, thanks.

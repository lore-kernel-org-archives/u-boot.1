Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E518DD13587
	for <u-boot@archiver.kernel.org>; Sun, 27 Oct 2024 21:30:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5BCF0885F5;
	Sun, 27 Oct 2024 22:30:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XgYPgUUs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 40102882BE; Sun, 27 Oct 2024 22:30:24 +0100 (CET)
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com
 [IPv6:2a00:1450:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8348188C53
 for <u-boot@lists.denx.de>; Sun, 27 Oct 2024 22:30:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-2fb5743074bso30236611fa.1
 for <u-boot@lists.denx.de>; Sun, 27 Oct 2024 14:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730064618; x=1730669418; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n62RzO2tCF+wIxTnLQmT+tLmdHCqZ2NTFgMi9qIREQM=;
 b=XgYPgUUsRqR6OZ1wXjx9SNKBxNHf3aIiWZ2jvg5OiucCSmB7qOUhg9zN8Y0V7zWl4A
 UhR4BFFJwEor4IyADs34yYa2bDn10mUg2+Qnqr4FxKpUawt97FaqjwhM2qgZd4rKiJgc
 hc2MUuQhlpZeMKcMG7dFrZqYsspmEVry7B/jvMwQLKKw4wjDks/A7Lwh5TlvtY4gMhFy
 JgEZJQGHNz/pGr1MGlAdYqQSsmtw4oVV3Oy2g3kj3uc6wfSkntAkb3ZsaPsNjUj8hSNc
 YRuhOKy6xi4YDqZSAcGeak7dxYfiSeRJd/pYo9z6a3qBpxv6yhB80BUgFCPzPd6inYpb
 7Jeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730064618; x=1730669418;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n62RzO2tCF+wIxTnLQmT+tLmdHCqZ2NTFgMi9qIREQM=;
 b=lyafo35QVjUkdR78BYsfSTOjpKRD6U9NfeGsz+NrmC9VnvXA7sry9h4DOJRrEFAZ99
 e1DLwB72of3z4yaEO1tLNUWBAOeFRywC3hAR+FOkJ/91bXzgyo8rrQ9SqME3mIzAOjP2
 TF4ae0mRQpECMloJkxI5jI+TzGMsip4KGSm9PhiCD6qX/vUfACb5T1WCgCG7h2Q6sIa2
 NARf64qOH04Wl+noAA9xuENSP+Wwr+XLj7PhITphh69ImDfkLplD0jxyclYFIAyRtBN6
 BDtygXs/6rPhktB/IBFCU61sB2dsei7Yw3Ln6uX1gwHizYenh0UQI6qjYcxb6HqmMQ1r
 sxbg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV+5mW+BMTT8vh4nzNc6Ty4srEAiFBMzg0MuJ+wpvZMwaPl1/1dStU+puPLaqUcHKXxG89w2d8=@lists.denx.de
X-Gm-Message-State: AOJu0YxhQMh4APk4gOeh6WmSm0Nit/ffHeecM6FJpe1VC1FKldQHD/kk
 shqqdjJzJU+npyX1oA0b7lHXhndRMTN53x3lB/cYqpN8v5ma9XUL89Lnghk8j0hdG9vmslKA9UY
 T/JJegS+mX7ne0x/oyovpBhSxbsycxg==
X-Google-Smtp-Source: AGHT+IFGBFBRhuA56vcRr1gAToTZ9VqmUB/zD+EC9ZZetBFyOi5tq2H+JZYDrQ4dOREsagMrKPoR3UrVqxX/2gJ1wEA=
X-Received: by 2002:a2e:be85:0:b0:2fb:55b0:82b8 with SMTP id
 38308e7fff4ca-2fca8348bf9mr38399751fa.4.1730064617388; Sun, 27 Oct 2024
 14:30:17 -0700 (PDT)
MIME-Version: 1.0
References: <20241027145241.109809-1-gilles.talis@gmail.com>
In-Reply-To: <20241027145241.109809-1-gilles.talis@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sun, 27 Oct 2024 18:30:05 -0300
Message-ID: <CAOMZO5BonVeQsZieECmrv7VgStbEeo0bSKoq5FD7vnvvekV_Rw@mail.gmail.com>
Subject: Re: [PATCH v3] board: emcraft: Add support for Emcraft Systems NavQ+
To: Gilles Talis <gilles.talis@gmail.com>
Cc: peng.fan@nxp.com, u-boot@lists.denx.de, uboot-imx@nxp.com
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

Hi Gilles,

On Sun, Oct 27, 2024 at 11:53=E2=80=AFAM Gilles Talis <gilles.talis@gmail.c=
om> wrote:
>
> The Emcraft Systems NavQ+ kit is a mobile robotics platform
> based on NXP i.MX8 MPlus SoC.
>
> The following interfaces and devices are enabled:
> - eMMC
> - Gigabit Ethernet (through eQOS interface)
> - SD-Card
> - UART console
>
> The device tree file is taken from upstream Linux Kernel
> through OF_UPSTREAM
>
> Signed-off-by: Gilles Talis <gilles.talis@gmail.com>
> ---
> Changes v2 --> v3
> - Fixed board documentation build error
> - Removed board_phy_config() function
> - Added SPDX to env file
> - Removed PHY_ADDR config variable

This version looks good, thanks:

Reviewed-by: Fabio Estevam <festevam@gmail.com>

Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45F89CFB422
	for <u-boot@archiver.kernel.org>; Sat,  5 Oct 2024 16:50:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC4B988CE2;
	Sat,  5 Oct 2024 18:50:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="caInQK79";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9068F88D25; Sat,  5 Oct 2024 18:50:04 +0200 (CEST)
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com
 [IPv6:2a00:1450:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A6AF988CC1
 for <u-boot@lists.denx.de>; Sat,  5 Oct 2024 18:50:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-2fac787f39fso33225241fa.2
 for <u-boot@lists.denx.de>; Sat, 05 Oct 2024 09:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728147002; x=1728751802; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jDzPXU2eJXyq0xWGxhvPYTU1baUBGS/FEDJXK8GdkH4=;
 b=caInQK79Puok0mX3WWQi1olq4HW0xGPeFLd1RdQCjOJjaWzuqRsDGvWpKLBxLeKDnB
 PqMbLt5DRaX850wm/rhwgPiQryWbNubN8z3JMrKlpLp7duRYP8WAU6iXKdKZevh2PYZ2
 dYM3JZUkoW0pNX/NTcV1ESlsI2nkTApEKVHImCkxJkCljv4zhqnfDjga7t9ot083lNdG
 dB0yTgPa/ZqPZVflDL4jmThl5vYim9RD2SwS6Uc8MCk0p8pDm4oWJVZv76yGc9kOaKLr
 fO2t7urRyvG0EnRN2N2EYS6gpts4+JIrvWO8pcas/E6OHnzdZkfLPvFYG3TDkTv6LxNS
 PLdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728147002; x=1728751802;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jDzPXU2eJXyq0xWGxhvPYTU1baUBGS/FEDJXK8GdkH4=;
 b=PqQ8VlMBE4Jc4HSkeOYlW4gb5SNLXlfu+dYUv2JHBDZurtqyCEBVkoPdIg7/k0BHcA
 UjePH+HUV/90J+J3xZpP4hMp/18oW3XAjp221D8cInttja0iueYhpsLakwKgdUrjyuRY
 0pI5vuaatOhY7pwXFeOiNqRM5O+XwRc3oCV6fycTu7Mwq4uCqmALVv4NuvbvSX63gG1+
 hLuu7E+Xsm6ikW7a8G1qD0czlF4di1A1C/wcd2it/FcOnxe7SNCYcgX8F7S+1IhkNkoG
 9IjMVSVE0uTk+mWMdMNXqO3ORXF79sSFt0PttTjJRHDQgVba21EsNvRMX7xD1CjfVRCq
 tRdA==
X-Gm-Message-State: AOJu0YwEzmyJxChnblARg24XphEjnNSRFaAWL40Pt3Yt3kv2xTYPTTI9
 OyKAk6Alvb+PhLj7kXdGjK/tKG3kek78FHjL7RJyti6xhBVAnjPm5H3Uo0VJfvSZ6uJjQadrP9b
 RgA46WtPxHkvvCv4OC10GyfpOPhY=
X-Google-Smtp-Source: AGHT+IHrtvUu27PWgXiPd+iQsxKr8EPwtRHAigAGTsCuYc7/6BgSUusuw+Y9FCbljs+sSpHeO/8cIabjiByJgp+LKyU=
X-Received: by 2002:a05:651c:1549:b0:2fa:d4ef:f21e with SMTP id
 38308e7fff4ca-2faf3d9107fmr27709871fa.41.1728147001742; Sat, 05 Oct 2024
 09:50:01 -0700 (PDT)
MIME-Version: 1.0
References: <20241002195304.21973-1-marex@denx.de>
In-Reply-To: <20241002195304.21973-1-marex@denx.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 5 Oct 2024 13:49:50 -0300
Message-ID: <CAOMZO5BL6e8feM4_QaC+XSDAwPtYyW1q791P5Vg0AP-DWWvapw@mail.gmail.com>
Subject: Re: [PATCH] ARM: imx: Drop bogus newline
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Stefano Babic <sbabic@denx.de>
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

On Wed, Oct 2, 2024 at 4:53=E2=80=AFPM Marek Vasut <marex@denx.de> wrote:
>
> This shows up in 'help' output and introdues bogus gap:
> "
> mfgprot   - Manufacturing Protection
>
> mii       - MII utility commands
> "
> Drop the newline to fix this.
>
> Signed-off-by: Marek Vasut <marex@denx.de>

Applied to u-boot-imx/next, thanks.

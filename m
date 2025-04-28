Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD19BC369D5
	for <u-boot@archiver.kernel.org>; Mon, 28 Apr 2025 16:11:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5912882103;
	Mon, 28 Apr 2025 18:11:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Lar1EnEx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1821A8211F; Mon, 28 Apr 2025 18:11:53 +0200 (CEST)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com
 [IPv6:2a00:1450:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE0438056A
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 18:11:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-54993c68ba0so5940077e87.2
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 09:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745856710; x=1746461510; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WYJV6mAxiQCgEPBORe8zOFrHeW1nQOA6iMu3phRsw9c=;
 b=Lar1EnEx77pvIk7aMTx3ZUdP4YrQNkbwOJRxpwQHq2aO6uNguHMA0mgNutUdE7OC03
 s4HgoSqgpsl5L9CYEpw3rvXtXxoVSQ34UD+JVOZP1Q+5l4qCer5VGkP80WUz1zZ8vZj5
 hFVOXbFY4U3QfUf8PaSk6L42KMSpCB4i3FHOiTvkR1/nbbDm1kg/O25zsRI1HhVKBAgC
 xSBX5pmkh9ltxMRLJlwqky19ewtyDWAuIkcz0rsZqWlHrUehgw4ik+79ew4jT1hA8xsV
 iyJYtO5Z8e+HalYfunVA4t3zYBGOTe11AkOF37mrRWh1Em52rNXnsK2nROWprU0/7hsc
 kHfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745856710; x=1746461510;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WYJV6mAxiQCgEPBORe8zOFrHeW1nQOA6iMu3phRsw9c=;
 b=vyvU/wy7llVHzziRsRkSaYlW9k/FyBnQgz7C6nd2AWjzCx4OIDD11zaic62rn12Q5V
 T9rM6ciwa38C5OQLI/Ww9g9fDk/ZE8YMApAn9yk8pYui5AmZpQf9GoEvQsAidht9bCM5
 JACUSMZtKjlg7dZEEzflgjz3k9UlcPSbh/t8KZlZxFaWzEBAGyiNZB6w3yvephwS0ohJ
 wI8uqGNC53WK4KvCV+mJeDaqJDYn9cLShJHtvryFCI8o/9rpSWiu6krXdOiUsyWdoKbd
 yewEfppeWC2Qj5pBfW6Cx0473qxQnG2q8nELE85GrQmJDyQGYQvOuAnS83N4JzeHZ3tt
 FkDg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUscKwEfUin0UyLvUoMXQJGSErmPVCObMj1x4rIVbRGsel1c5g/4utssdE8M1eG/rFK0WRmlu8=@lists.denx.de
X-Gm-Message-State: AOJu0YzUqy9Qfdn2rSIoUbMkn3BYVl+H5Q2X7Rj51W52XmGXYlky6n2z
 CJ98e8eEwuAiBc6O76GimC5+fD1onAAstI24idXsyNKX0JnpLJ2Tuc31BVWaFzQxOk4VB5zXov7
 smNchSE8Br0TTSTE1aZ3OymUff/w=
X-Gm-Gg: ASbGncsG5YajXQRlBwpT6N2uXBYPoQIXejVjbegmRjzdHMaTHGP+/Qsg4dwldolytG2
 VhB9ozU6YV41PGfgJqwHlmkdL8XxWdpWhP1s5yhXaXNX9l1q7siuLJFx+hH/3hBGj/sCJ/crObv
 7IoQSLtzUG3ALnIRb0hFrHsahOFusz2YpUXCP4Gv5dnvfbJLWEOYUSsg==
X-Google-Smtp-Source: AGHT+IHk6+xzr3haR+REc1BG/2+GtzM4uHwujyPuECOeWFsR35oYsFq5NCxXYNMr++RD/9WZoQbBo1WxaxrLKsk5q5o=
X-Received: by 2002:a05:6512:128a:b0:549:91c6:970d with SMTP id
 2adb3069b0e04-54e8d0530d2mr3676075e87.5.1745856709839; Mon, 28 Apr 2025
 09:11:49 -0700 (PDT)
MIME-Version: 1.0
References: <20250425-ge-ian-display-support-v1-0-8a7a0fe75023@bootlin.com>
In-Reply-To: <20250425-ge-ian-display-support-v1-0-8a7a0fe75023@bootlin.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 28 Apr 2025 13:11:38 -0300
X-Gm-Features: ATxdqUE5NBZga-tC77ZcrRm_ddXtz9JcuwuyGoAlj1k5w2N8CPWSUvrx_WF4s1A
Message-ID: <CAOMZO5Di_qOKL5b80ujzMQzgHk_u-5HffQitgMgHso9nUMJ_-Q@mail.gmail.com>
Subject: Re: [PATCH 0/2] power-domain: Enable uclass refcounting
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 u-boot@lists.denx.de, Samuel Holland <samuel.holland@sifive.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Wadim Egorov <w.egorov@phytec.de>,
 Heiko Schocher <hs@denx.de>, Fabio Estevam <festevam@denx.de>
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

On Fri, Apr 25, 2025 at 11:09=E2=80=AFAM Miquel Raynal
<miquel.raynal@bootlin.com> wrote:
>
> On one side we have a power domain uclass which is mostly clueless about
> the topology of the power domains it manages.
>
> On the other side we have SoCs which are getting more and more complex,
> ie. with several layers of power domains. Sometimes (eg. on TI K3
> platforms) all power domains are defined by a single device tree node
> and the "subdomains" are referenced using an identification
> cell (#power-domain-cells =3D <1 or more>). Sometimes however (eg. on NXP
> i.MX8 SoCs), the description uses many device tree nodes.
>
> When a power domain is referenced several times, it is likely that the
> power_domain_on() function will be called several times in a row, which
> in some cases may lead to glitches or even breakages. This situation is
> problematic on i.MX8MP and only with proper reference counting we can
> safely support the video pipeline.
>
> There was a first attempt to bring refcount support to the power domain
> uclass, but it miserably failed because of the details mentioned
> above:
> https://lore.kernel.org/u-boot/20250403-ge-mainline-display-support-v6-5-=
478b5e3dd872@bootlin.com/
>
> So here is a new version of it, which takes into consideration:
> - the fact that a single power domain udev can target several power
> domain IDs (referred as "subdomains")
> - the fact that some platforms might count on a uneven count of on/off
> calls to work, and "fixing" this may break the platforms.
>
> So refcounting is an opt-in parameter, it is a matter of filling the
> platform (public part of a per-uclass structure) subdomains number with
> the number of subdomains this device nodes features (one per
> power_domain->id) in the probe function of the power domain driver.
>
> This series shows how it can be done by enabling refcounting on i.MX8MP.
>
> Samuel, Neha, Wadim, Heiko, could you please confirm it works on your
> side?
>
> For once, CI is green :-)
> https://github.com/u-boot/u-boot/pull/753

Applied, thanks.

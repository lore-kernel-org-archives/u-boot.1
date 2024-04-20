Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7446FC4345F
	for <u-boot@archiver.kernel.org>; Sat, 20 Apr 2024 18:38:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F236D887D7;
	Sat, 20 Apr 2024 20:38:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KhAB7Fzx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE4C4887D8; Sat, 20 Apr 2024 20:38:13 +0200 (CEST)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com
 [IPv6:2607:f8b0:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 90C3988791
 for <u-boot@lists.denx.de>; Sat, 20 Apr 2024 20:38:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1e84787b0a8so4332905ad.1
 for <u-boot@lists.denx.de>; Sat, 20 Apr 2024 11:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713638290; x=1714243090; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H5PVRI9WYI5WmGt/rEStKo+Hg85iUgMrG+1cY4GO6GI=;
 b=KhAB7FzxuHNDWf6ZUVaIvABLhUcXobXYbIvTDpVbHjnzzbYFUZhhmrIX0Y+1pG+B5T
 OEzNk0S00WOQUDOVyO4vW8EzuQru02JuHsERUjDC+9zoCb1nB7x1b1TM9LZA6iM/DzLv
 p6c6b7YrGf/38sg2r1a33JqMafX0OPM77o/YL6zBBrMq8oGL9UG6gWTVGuDOhCj5oI3/
 6HbxA5c338vPpEMKFku2ej8OsYxP2DhutlTBuvHsccRqLjf6sTBQboCWsq4zyKo6zNUx
 mIuBs1C2tzHjJ2nLKA5Gkb+sur/Yrzi2NyICV9+VLR0EAjMuP1XkINcP/fqTePLVSXvj
 OMig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713638290; x=1714243090;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=H5PVRI9WYI5WmGt/rEStKo+Hg85iUgMrG+1cY4GO6GI=;
 b=fjJUAAS9sI0kRc3z1NP3SOB9rOoHUV27Du1UhpeGiLNgVuqf2bQI6DeyH5yki/jQh9
 HgmNZUZrpypR6ZgpHmLaR0zDRZf0r3Q3+pRhaf9An6D6/gk/g7v+1FBt+9UJ2VLkO9LR
 UwOlva0H9ZDcLs5OYg31WNKGuSP5mAtj9A8j9kvf/AiW8nlQnwbs6iEsXSjDwmCu2xvN
 hKN+V6QVlmPz7nlhQ5SJPXpLlMIPb9idYakqEHw4lR5ssBHUaCfe+RphDcv9wfoPDvDq
 g9uE8kYGKx2YsGmX9/rbIwWT4PiEOkigOqYtRfd7zppVvq2K0pkqWtp0TPr06N5TVkkz
 N2Fw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWh1R8Lj4hL8cCNhRNSKCZZsY6qdL5LofZ/K2LFRUz10JlSlTJjhD5rmhD5lHAKo+Ulb51lVUQ6tg/FL2b/Iff0LWjHGA==
X-Gm-Message-State: AOJu0YysBM3MisM1x527pEhky9pb42LoM0mDSoRMbJbjC/vyHSenAUMl
 MNs2NMdZkipG9xXMtsx9PVgM9ts3l21lWkfuLuNj3J2/vu+trgQihYzhkksBuyWfiHvf+Kd4DnP
 ZB+ziyDKnZepTXHnegGGd2UQqGboisQ==
X-Google-Smtp-Source: AGHT+IH7/7yrDSKaSKYvW0qcRM3bLhPnOM6UqMTfrBnxZmnoSRpHo+lmqqiEdEOhWOG+7tPM3FaNuJejc3F+E2Gn4Pk=
X-Received: by 2002:a17:90a:530d:b0:2ac:26d8:746d with SMTP id
 x13-20020a17090a530d00b002ac26d8746dmr5633438pjh.2.1713638290096; Sat, 20 Apr
 2024 11:38:10 -0700 (PDT)
MIME-Version: 1.0
References: <20240419152902.4156600-1-tharvey@gateworks.com>
In-Reply-To: <20240419152902.4156600-1-tharvey@gateworks.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 20 Apr 2024 15:37:59 -0300
Message-ID: <CAOMZO5A57OTzTWWSs9BB0iLjfM-GaW-6exmMRtWXHjkcQ2GDAQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] clk: imx8mm: Add support for PCIe clocks
To: Tim Harvey <tharvey@gateworks.com>
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, 
 Sumit Garg <sumit.garg@linaro.org>, Martyn Welch <martyn.welch@collabora.com>, 
 Simon Glass <sjg@chromium.org>, Marek Vasut <marex@denx.de>,
 u-boot@lists.denx.de
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

On Fri, Apr 19, 2024 at 12:29=E2=80=AFPM Tim Harvey <tharvey@gateworks.com>=
 wrote:
>
> Add support for PCIe clocks required to enable PCIe support on
> iMX8MM SoC.
>
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> ---
> v3: wrap pcie clk config around IS_ENABLED to avoid SPL growth as
>     suggested by Marek

Applied all, thanks.

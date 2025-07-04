Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6932C83F03
	for <u-boot@archiver.kernel.org>; Fri,  4 Jul 2025 11:38:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A6D782ED0;
	Fri,  4 Jul 2025 13:38:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HjXo+0nv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A302A82F03; Fri,  4 Jul 2025 13:38:15 +0200 (CEST)
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com
 [IPv6:2a00:1450:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4808A82A8D
 for <u-boot@lists.denx.de>; Fri,  4 Jul 2025 13:38:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-32b7cf56cacso8778351fa.1
 for <u-boot@lists.denx.de>; Fri, 04 Jul 2025 04:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751629092; x=1752233892; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CXGAs5XNjKiMQy78MY0o4+6ONlFMW5geUhlIKG2Jk/c=;
 b=HjXo+0nvkVGbS6BBh5DjldHgSv3e+ztpeuOC4KNyvI7pPWlHQ89wofxPLVJ5x6tFCv
 uEEYCHjfqe6XR6ENSVHhMia8OEuSa2bAvzojlU2mcJKC1Q+8JlPQc+ODZHUMzw94m5FP
 RCTumUZIW+T1YG4Uvp8fgZBbOQu86I5HRdb/3TYCaGO8Dplh6xcqnPtMazReLonMHPyS
 gJKCBTz7+n/5LbcVFY86rb00xqLItu8DefuxeVX03ktoJVCY5UaFL33QaV7AG4QaEzPD
 ltU+R9KNzFDXjAQMmKcQZK4NRG+Qt/jcD9PG9EOhkfksBps/MsJ3oA4o36zzxnk6HQVZ
 acLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751629092; x=1752233892;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CXGAs5XNjKiMQy78MY0o4+6ONlFMW5geUhlIKG2Jk/c=;
 b=a4TtKkwbJnGgH4gDf1CEvCP5YhEEbss/tZ/I5k0qHcV6h+muzftx/xvgPVY950qTdZ
 x23x2VsItpRNPG0ZwfS7kS+cy8E0nJmsAAgVTeWdZ0pj3Fa1R0SirFdM65BFDD3e/in/
 NR/c1IMKFP6Awm/8GmUiIG1urLXAJdFYo2ctlmMpY43Hl/LPTLNQO787TRC787NHECGp
 +dCrQmsU/n1fRiQFj99AhIQLZmtNt1Jt/LQQjfRkKvc73dsYwm73qAUKzbLG4p6qU5rI
 +/8ECOI3+jrRoH5+eTzpnbWtZLBvLu3X5wnJuV8Gy7SRooNQqACmfMTt/dcyK9jVE+kf
 HbAA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVCO9/JaCZLrCVMbTyA6ZvxFokNK7St6o9BwMzp7fv9hFEEHXInsB3dWQ3mwTbTPV7AGh0QVYA=@lists.denx.de
X-Gm-Message-State: AOJu0YxY2upVX6YecIcs/5rBme0mguPx4Z1FZnzHGyryX2rf6TrZysDH
 U9vtVPXB1GFIIkozvu/lSNMJagYgHvMJjJ0ZZU3sEMQS2G9dr4lSzpIUa9kSm3nifDC3i/kvXpx
 2D7hiQ67qTh1rzgNAz84LkC36kuHHqLllsw==
X-Gm-Gg: ASbGncvslAmCF1tMP87NicOGV/V6OsfAele9xEwjtZ86Zf86DFsVqAMaAK3VBhJzGHW
 dCgNncGTYs/TWyRjI8qOQDAdFsk7mCEdhOGK6X8MdONd4UVs5dFxaLMqG3bjT4McQ4I2wtXblpb
 MMLPt7vWWQdKxDiQdxQa2I6eqXL8lgG4MJSVtwMYJlvxnxlIF3lYQdVLwlSkoQ7v9HnJgWmt7HF
 Q==
X-Google-Smtp-Source: AGHT+IH1FxfyyQ4pBJ+xzSn8XDNHL2rgO5tBa8FRbeLkl2zniwOWpUmE/XDxbdCLcVCyXZfaPHYHsdRVIKcLajTJPHI=
X-Received: by 2002:a05:651c:411a:b0:30b:c6fe:4529 with SMTP id
 38308e7fff4ca-32e5f55bdbbmr5422851fa.8.1751629092175; Fri, 04 Jul 2025
 04:38:12 -0700 (PDT)
MIME-Version: 1.0
References: <20250404135038.2134570-1-jerome.forissier@linaro.org>
 <CAOMZO5Dhs2GRgvjDCBbwsxxZadsVCrpXaWm4qToYfpak+CAKuw@mail.gmail.com>
 <CAOMZO5Bjxx5tjj75Bo8A4WJWBnV3Q8h1UHK45_xZgOavig0C9w@mail.gmail.com>
 <0b7fcdb0-0d18-41ef-8607-cf060ce3d058@linaro.org>
In-Reply-To: <0b7fcdb0-0d18-41ef-8607-cf060ce3d058@linaro.org>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 4 Jul 2025 08:37:59 -0300
X-Gm-Features: Ac12FXw_-LmX4HDYAj27y6zNheXjJbprA2HnAMMskTBqILl9uACJCpP6FuIjFd8
Message-ID: <CAOMZO5CXyVyoDEUhFbtaHxi=QDp2uqn1U5ccBq6W8uoEipeVxA@mail.gmail.com>
Subject: Re: [PATCH v6 0/3] Static initcalls
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Otavio Salvador <otavio@ossystems.com.br>, 
 dl-uboot-imx <uboot-imx@nxp.com>
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

Hi Jerome,

On Fri, Jul 4, 2025 at 5:33=E2=80=AFAM Jerome Forissier
<jerome.forissier@linaro.org> wrote:

> Have you tried the master branch recently? Hopefully commit 410d59095a9f
> ("arm: kirkwood: fix freeze on boot") should fix the issue.

Yes, I'm using top-of-tree U-Boot, and this commit is present.

Unfortunately, it does not help.

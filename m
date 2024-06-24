Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0599C2D0D1
	for <u-boot@archiver.kernel.org>; Mon, 24 Jun 2024 13:41:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 663E188137;
	Mon, 24 Jun 2024 15:41:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SdjxEF6P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C830488137; Mon, 24 Jun 2024 15:41:26 +0200 (CEST)
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com
 [IPv6:2607:f8b0:4864:20::1030])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 999CA87DEA
 for <u-boot@lists.denx.de>; Mon, 24 Jun 2024 15:41:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2c87a7df96eso196832a91.1
 for <u-boot@lists.denx.de>; Mon, 24 Jun 2024 06:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719236483; x=1719841283; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V+BKRPnmuYDHLnbGvjOQvFQM/H7dQ4T7hzxbfzFM0Hg=;
 b=SdjxEF6PrChYCAwIziWXkGuuOi6elXGA+sHiMKDaf05xZSR8GR6ctzi8Ru1/tCfT77
 oR+fHOIQX4iFMlYxt0sGHOgEecK+0BYL7odoFryu9D386lIraMahyddO9cHnbJ+4Z5u4
 NQiczZ4ITap71upiA47aJHmktujYH6YdxCEWymdWNTBGjtUhGFzGu8DLWWYcmv2tjKhm
 eGN2qe7ajhvLw8D+Xy1D2PO8ZBRzZB9wOR8OAMOp0ryH/mBLJ1DcwSTE/Nm6+s1cCw1q
 54N4r5ErS03YIQ/bwPTLlOvD/mBwjF9P9sakustFrXqJ9jmIFLzRhi9B0RcqogcAGR3J
 S0MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719236483; x=1719841283;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V+BKRPnmuYDHLnbGvjOQvFQM/H7dQ4T7hzxbfzFM0Hg=;
 b=RwYBH8sRlxV3+xbUo7QDMSGDsxW7yv45xCVHPhJB2lIaJDMTRgA8vlNzd+Iz4kVt5h
 vGUYgjVYm6555Gl77HB5MJy8JYbBenUtGPJ054PJUDa34N9V3Jp6uTy26mad849SdSbJ
 fKcHi5W6DIQZadsr6Bi8gdrrLmJtnzTCG4AKL+vQcclYwLR+bpiefBt9uSQWIWgT77+n
 wTCJYMoJD4Z6txrZJYxh3NPupVs77A87dRxNxhFY1tq8A+jWzUC0sCIVjiWzl8FzcGGI
 qOkPFmKqmF9FGNp3AJWaeZEj2/P9IeENC6A3ettYROSc5gFJ0PXTtiNKk+m2AYDVpISv
 XzuQ==
X-Gm-Message-State: AOJu0Yxh+fCKL8B6s+02sthkBK2F1I1YrynGdZJbJIZWwHQMDdX+rDAV
 biqfe5r/Yz+2/Hd8v2LqvbFoG8KRslOS/C6MmgoZCLC7N/+9xk+9xHYUNcmB0ORi63NVGqC+WJ4
 /tDjqQPl+FqwKSMFTAMNgv5cXRSumnDbQ
X-Google-Smtp-Source: AGHT+IGNMGScRmWdwOQELaEZk995HDB7fCh3vt4Gnra3FRQT9aMAUyW7xGeqev46ydHwYZ6Ry/aUKi7jcYc4qNd8Fv4=
X-Received: by 2002:a17:90b:4b52:b0:2c4:d7f3:fb00 with SMTP id
 98e67ed59e1d1-2c845e5e637mr5115687a91.3.1719236483071; Mon, 24 Jun 2024
 06:41:23 -0700 (PDT)
MIME-Version: 1.0
References: <20240623184427.56551-1-marex@denx.de>
In-Reply-To: <20240623184427.56551-1-marex@denx.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 24 Jun 2024 10:41:11 -0300
Message-ID: <CAOMZO5Crz3Zg37YJ6i21P=uOXtard_n85q8DCLWPrSVL-W8RMQ@mail.gmail.com>
Subject: Re: [PATCH] ARM: imx: Enable SPL DTO application support for i.MX8MP
 DHCOM PDK2
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, Fabio Estevam <festevam@denx.de>,
 Tom Rini <trini@konsulko.com>, u-boot@dh-electronics.com
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

On Sun, Jun 23, 2024 at 3:44=E2=80=AFPM Marek Vasut <marex@denx.de> wrote:
>
> Enable SPL DTO support to apply matching SoM specific DTOs to cater
> for the SoM differences in DH i.MX8MP DHCOM PDK2 configuration. This
> is already enabled in DH i.MX8MP DHCOM PDK3 configuration so align
> the two configurations.
>
> Fixes: ad1158c50e0e ("arm64: dts: imx8mp: Switch to DT overlays for i.MX8=
MP DHCOM SoM")
> Signed-off-by: Marek Vasut <marex@denx.de>

Applied to u-boot-imx/next, thanks.

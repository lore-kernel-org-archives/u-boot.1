Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF2F9CAC5B8
	for <u-boot@archiver.kernel.org>; Fri, 26 Sep 2025 17:11:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 25C3183839;
	Fri, 26 Sep 2025 19:11:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OnwgpJG5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 780A98383E; Fri, 26 Sep 2025 19:11:17 +0200 (CEST)
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com
 [IPv6:2a00:1450:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 367FB835FD
 for <u-boot@lists.denx.de>; Fri, 26 Sep 2025 19:11:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-36a6a3974fdso777871fa.0
 for <u-boot@lists.denx.de>; Fri, 26 Sep 2025 10:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758906674; x=1759511474; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yTTgzY4wVtmQGUjNLn3z4TDqNZaSLA3GNqlfr1WNf80=;
 b=OnwgpJG5YVYACRjDPuzkg0S3nIcSs5Ykdl/d1Vwg6g8FtsQfrcEctxciwT/aLPiQjR
 /u5K7QfD+k20C2TcK1n+w29xCMl7d29gtBFDMFcUCMbf++qYszue3x4nN8/WPqA9k9Uq
 wJvU2+0x+XmLuds6abI0x+zIEGmA1Wal7dOqcC6Hu2K02gj93MckSLo52oXOcPK3hMKG
 VmpNtqd1YkHnzOyvw/hUBp1ZtsKqUTjyvADUtEwF/6Fyd+Z5nJCgtPVnH6UurgjN9eTG
 vEkwscR2LD6dZhUvaUPGzy0OP+aEzTlHc39emb9+uK+M2Y4RD0EQNQXBAM7SCsVNJk/2
 pbpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758906674; x=1759511474;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yTTgzY4wVtmQGUjNLn3z4TDqNZaSLA3GNqlfr1WNf80=;
 b=Kr8VPktolFknokF3TLH+ixmUrqAknsXUl2AuBmJbVIyT7JqtpFQZOXH6kdofzx6nHC
 Cuv8sQohSK/KbVoxlfqdXRZDL3EajvC+/7Ne9Kveq4ntmDpZpE9y67zwRr2UJ/q4NqY6
 HsUTiG2t++af+sjkPzRaFLL6esYaBfHaDrLOhNax1rE8XcpyoR/sX929YRKgf1bx3BKk
 sGE2QzQCffKjGmOOP7QLy9Vih1ajrEm42wOtjW//DYxhZgn9gGwlm4dilI/G4NAHbicd
 pims7UIN3x+ZrzRrkp8Qb+GkwODVlbl10+hn/8/E/x5ukEOl2zzIbcjPUIW1bUx37MMi
 J/YQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVHWr4U5xtjNIJXMcJbq1GNYj7/MpeOxaB+QM2Rr6VAKvzFIGC7flvRKpzg/7noErVldRSOkVI=@lists.denx.de
X-Gm-Message-State: AOJu0YzcqrkutKY7Yd0CxLuWK71djyDFUvRDg+DrynFVcyJwPXEPt9lg
 KUy3vD/R34XPt/92ajz64fybAb3aVjAasw5y2yStrP36QesvGwS69BhdbZZ9X88aKNxrgs5Qa9h
 wJhKFn9sNMDBxCS41W693ZTB6Fzsaoec=
X-Gm-Gg: ASbGncvC1wiIWgYvjLULYzgXWBeKkI/b+v2sbtdYVcgsmbGRt15qJ9NGxgK5ehPUlVk
 hdSohmxT9RKk4Uk+pfIfN7OvpVX5D2YM0UflY/iRdq6Jn8K7HqLKIMr/xAuBefzzMaqO0ZoUuD9
 i0Tyk4WUB8xInviS85F8MJoSJbBY5df2T32PzshW12qwSK3oQSnG4X4/Utitl2CQFgFllFu3ppo
 G84znsxIiGU6KKM6cbtJvtHRtgDuNYafqlO/Xk=
X-Google-Smtp-Source: AGHT+IFK1iNJXlc9QFV/bALOEIzsRnDijXIOMVBr1yhHdD+/A+N2Q1qHQx1bxO1Vu1SrG92E+zd7Xqmyh3eqTOOfkVU=
X-Received: by 2002:a05:651c:1990:b0:35e:c1c5:fd12 with SMTP id
 38308e7fff4ca-36f8011570dmr26786351fa.40.1758906674173; Fri, 26 Sep 2025
 10:11:14 -0700 (PDT)
MIME-Version: 1.0
References: <20250923-imx94-v1-0-cb3b65169048@oss.nxp.com>
In-Reply-To: <20250923-imx94-v1-0-cb3b65169048@oss.nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 26 Sep 2025 14:11:02 -0300
X-Gm-Features: AS18NWBs-7w7DKaQQIbAx2LPX7Q-t0qCb53n2QnYeEBREwLmaLukrw6xU6htyPM
Message-ID: <CAOMZO5DNtKVJ6yNxEtLF1ruJ70KiY+7Rkxd5KnNJ6jNVCg+5-A@mail.gmail.com>
Subject: Re: [PATCH v3 00/12] imx: add i.MX94 support
To: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Cc: Stefano Babic <sbabic@nabladev.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 Tom Rini <trini@konsulko.com>, Alice Guo <alice.guo@nxp.com>,
 u-boot@lists.denx.de, Ye Li <ye.li@nxp.com>, Peng Fan <peng.fan@nxp.com>,
 Jacky Bai <ping.bai@nxp.com>
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

Hi Alice,

On Mon, Sep 22, 2025 at 11:15=E2=80=AFPM Alice Guo (OSS) <alice.guo@oss.nxp=
.com> wrote:
>
> Changes in v1:
>  - Addition of i.MX94 CPU type and SoC-level Kconfig entry.
>  - Printing of the LM/system last booted/shutdown reasons.
>  - Definition of base addresses for WDG3, WDG4, GPIO6 and GPIO7.
>  - Support for lifecycle state display.
>  - Introduction of daisy register offset specific to i.MX94.
>
> Changes in v2:
>  - Add support for i.MX94 in get_imx_type_str() to ensure correct CPU typ=
e reporting.
>  - Adjust container header buffer address.
>  - Introduce base DTS files for i.MX943 EVK.
>  - Add board-level code and defconfig for i.MX943 EVK.
>
> Changes in v3:
>  - Add -I$(srctree)/... in the Makefile to specify the path to .h files
>    from the Linux.
>  - Delete initrd_high=3D0xffffffffffffffff in imx94_evk.env.
>
> CI:
> https://github.com/u-boot/u-boot/pull/815/checks

Thanks for sharing the CI link, appreciate it.

Series applied to -next, thanks.

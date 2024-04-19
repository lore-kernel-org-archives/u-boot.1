Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F9ACC4345F
	for <u-boot@archiver.kernel.org>; Fri, 19 Apr 2024 16:11:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5D0E38876E;
	Fri, 19 Apr 2024 18:11:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DRIQ3JRJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9ECDE8877D; Fri, 19 Apr 2024 18:11:03 +0200 (CEST)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B839D88768
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 18:11:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=thierry.reding@gmail.com
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-56c5d05128dso2092228a12.0
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 09:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713543061; x=1714147861; darn=lists.denx.de;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=h4kS8sxRd8BQHVkDlntOCC9P0mzyfLYbzl13IJa1J0c=;
 b=DRIQ3JRJYcnJDcq8hnZrF/H8UfYeE6kl2rlFEPfTkwvLvZGIVIXpT8o283WR62iqZM
 +r7G8RtXFudYZrrFdsPd6Joev68ueLbwNG7UnT0VfZulE+llrla6Uv5cctphYbozu18U
 CpUxsF+ZkovwW+Guo5TnnOE6ZYslxecevYcdFNfBH06ZPc+IbSokyCDZS9SzsdTVTlc8
 zZhBREzRd/o/S8zRkN2J2vIGFa5MBRNAisX2qYH5s26WoPGOKJfDeAoNF6piHoMQ5bPL
 UQ48LwCHBmxXs3f4wJuREFI5hzYkhVXLuiKdnxKZ/2SXhPUxRPTsDSP9jLpgHCbS+Vl3
 R7ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713543061; x=1714147861;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=h4kS8sxRd8BQHVkDlntOCC9P0mzyfLYbzl13IJa1J0c=;
 b=tGENCKMzERio894zoeoqBXUkr3zn+jFmyLhHFz3k30MuO5H720MoeDvhWhl2AnZrgY
 yFZRJRYHjKSQGMQlJaeuEOVpjetjzVmqYQuB39obOJ/d1tcXKSdbfC8tuzDdoK5RazyY
 J92hxLUvlqE5U+vsKZ8rclAnKavoE5ifTPcobUS/Ktc47hwsZYt8MwnPB3v3/B2j1nX2
 MwwE52YhLfFBGXelMf80k6JleR0hB4Qse+O26pkIjRohXnjR4Y0KoctbeyJ6p+G8FB7R
 vq3UMHQCFzDTh6SRzOk+wRgIyyv3GsvTgEVmbp6lnlL38rhW0tUNnPmtblxPP7GtJ7Kb
 SQpA==
X-Gm-Message-State: AOJu0YykgB1fuXUocMzwNW4j61N2BtgrAj01QGavGfv1EEQuN/yX0YwD
 GF3KAMDZyBZndZKFCPQp8KoSPZCfPcxQNo2kCfrnB7eEArZXiIdv9WZQEQ==
X-Google-Smtp-Source: AGHT+IG5JyNNxU5SpvoZW3eKDMv8Z+JZfmV0410jRzxX0hQZw9Za6lwVg+4oPVrD3xpcOKvn9+w8gw==
X-Received: by 2002:a50:c346:0:b0:568:c6a2:f427 with SMTP id
 q6-20020a50c346000000b00568c6a2f427mr1688730edb.27.1713543061010; 
 Fri, 19 Apr 2024 09:11:01 -0700 (PDT)
Received: from localhost
 (p200300e41f162000f22f74fffe1f3a53.dip0.t-ipconnect.de.
 [2003:e4:1f16:2000:f22f:74ff:fe1f:3a53])
 by smtp.gmail.com with ESMTPSA id
 d6-20020a05640208c600b0056e72c4a330sm2275906edz.41.2024.04.19.09.11.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Apr 2024 09:11:00 -0700 (PDT)
Content-Type: multipart/signed;
 boundary=dc8a5ac356b2792cf48abf1100b9b5625a8cc23ade2eb0a44a3b0a4a64b0;
 micalg=pgp-sha256; protocol="application/pgp-signature"
Mime-Version: 1.0
Date: Fri, 19 Apr 2024 18:10:59 +0200
Message-Id: <D0O8BIEZBEMW.1C7FOUOJEQ5K3@gmail.com>
Subject: Re: [PATCH v6 13/18] video: tegra20: add MIPI calibration driver
From: "Thierry Reding" <thierry.reding@gmail.com>
To: "Svyatoslav Ryhel" <clamor95@gmail.com>, "Thierry Reding"
 <treding@nvidia.com>, "Anatolij Gustschin" <agust@denx.de>, "Simon Glass"
 <sjg@chromium.org>
Cc: <u-boot@lists.denx.de>
X-Mailer: aerc 0.16.0-1-0-g560d6168f0ed-dirty
References: <20240123171633.246057-1-clamor95@gmail.com>
 <20240123171633.246057-14-clamor95@gmail.com>
In-Reply-To: <20240123171633.246057-14-clamor95@gmail.com>
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

--dc8a5ac356b2792cf48abf1100b9b5625a8cc23ade2eb0a44a3b0a4a64b0
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Tue Jan 23, 2024 at 6:16 PM CET, Svyatoslav Ryhel wrote:
> Dedicated MIPI calibration driver is used on T114 and newer. Before
> T114 MIPI calibration registers were part of VI and CSI.
>
> Tested-by: Svyatoslav Ryhel <clamor95@gmail.com> # Nvidia Tegratab T114
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  drivers/video/tegra20/Makefile     |   2 +-
>  drivers/video/tegra20/tegra-mipi.c | 188 +++++++++++++++++++++++++++++
>  2 files changed, 189 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/video/tegra20/tegra-mipi.c

This looks like an adequate copy of what we have in the Linux kernel.
It's slightly suboptimal because most of the register values are hard-
coded for Tegra114, but I guess that can always be improved later on.

Reviewed-by: Thierry Reding <treding@nvidia.com>

--dc8a5ac356b2792cf48abf1100b9b5625a8cc23ade2eb0a44a3b0a4a64b0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmYil5QACgkQ3SOs138+
s6EIvA/+N5FFlrljP4Fv78zijkQ35aSiLPQhcZjY+EUXvnk2CxMHok7N687VpyN7
FvoB5e4L26iomKtKiutdBKHIKI7vwr/0ey2R3/bumY/ze6OzY3RfPTPpeEIS6xXz
FLFmlTFslSmhXMDZk3Z8GhHrwgGEZzgtWojssrRLRxF56prw1TlCv3HY1EU/fki8
O93c3fV4Is8BH9Ow2xnLPpHy13pN0oLk9hFkcna+A+MR2Y/sn0KwRPtrzU2ytAtK
OwVlqTh01FS6JlX1mL/8uScMCXr2Ag0zT39qARFWzAMafRBCB7SO5gY7paJ81tLa
cmdBXRiNqQNpC4gv+dqc4lzFwz9r0XLRYB/DrhTAiWvmXKOZz2b3X3c/os3cuQP/
1cTc7MJJg5U7R/PZfuN72KxWYsj63d7ZI61TtEnaOMpfThNZsGNN2ET9Y5EFk5P0
HY4mRR4jwCYT/rnG/YEevE8ZH6XyfgXIBS4cvSCMMZrOl1YxtMsII6yev1gaBS8Q
IRxpL7ibgLCfW4UpBu7eYLA7wtTuLTcxb34/2lrKqTXe8gvOZo9bYRWBYeR2jUTM
Pu42jIAH90S5sX2+5Clkzw4HOIN9REg5UjK+EMFxL2Q5iRZbfNrwdVxM1AbgkaoI
iMpscU/PZ2EtJoge9vHSAP7S1rWTS/j8YwpWEIS15iqs4yqdf34=
=xCH5
-----END PGP SIGNATURE-----

--dc8a5ac356b2792cf48abf1100b9b5625a8cc23ade2eb0a44a3b0a4a64b0--

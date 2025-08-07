Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEEA8C87FCA
	for <u-boot@archiver.kernel.org>; Thu,  7 Aug 2025 11:23:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 40787844EB;
	Thu,  7 Aug 2025 13:23:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZohZ/Vok";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8687D844EC; Thu,  7 Aug 2025 13:23:28 +0200 (CEST)
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com
 [IPv6:2a00:1450:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 47BCD83C46
 for <u-boot@lists.denx.de>; Thu,  7 Aug 2025 13:23:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-55b975b459aso802770e87.3
 for <u-boot@lists.denx.de>; Thu, 07 Aug 2025 04:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754565805; x=1755170605; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q2F5+XfgYhqpkvhPPznoe23Atao9C3GYAzM7btawsDo=;
 b=ZohZ/VokFaGUVqOiWoCmSdZaf2a6LSR86C3kyYLeoxfGE7BW5Hx/hL2JSBYZ+L8v9V
 vLwj0On9/+lAozKtIxLsAFVbNyrK5EAO3T13gD1r/OIaJPDdcfy0vRLm0LAAtZmsKWW2
 +2ZtenrLkeYqS6EgrCcyxhYZydczxZzV/WUhM1bexqt5orc1Tw8baNdOqEw/EpdP5a5S
 Pb7NPAwXGZN/F9hepRr9y4xfQrGQPU/+1jfsIz48ll+q+H/O6XUSPkU/Zwes8PJ+HVyf
 mlXYzFTGuOumu6okJqS436IdyDg4Tevh5hZTrhMNIAnNZj5lD0Adw9yqqK+i/P8HXu3X
 /qFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754565805; x=1755170605;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q2F5+XfgYhqpkvhPPznoe23Atao9C3GYAzM7btawsDo=;
 b=B21ic0cYzoEi0V0LbNhhUQMIIa0XM7qXPmiSFPA5Li7iB0o004XaqSn/b8pi4blbC7
 JA1qo/FMyhMOttA3jjm1Ty93ks+QjbmDEYIqFskBH0cK10LNwnndVBBSTXMNuSbNGV6+
 UophzrjF/Y+0JoKbr6odA0BmQjG8XFQtbbakkOhIJ35CuiWsUeVCOG5WK6/G/uV3TPeo
 sDy0lDVKg7evGIaEuTVna04lQQgHxihFzMvvO5nba95OvcwEJ8AFVee35/wLDJImIVdQ
 UNlmBFf0pCedJo92KBARYswlFrvuSpLA77uNYEh8i96+gcyK4o95LIMP3wYOsoj7v+hA
 +toQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXhxtR4lIcX6UEA+MzrBxiZthoTROPh3qKo1RIWkE8IOFgpMTvmRUI5YGyQBtrCteNOfiKx7FA=@lists.denx.de
X-Gm-Message-State: AOJu0Yw7xv6V5HrsK2fjMcBxty5YX8Zxc206EdRzCvLBTF3SkEsQjLT/
 38QGSgKvNOX2E2tdg97t4LF1t0P3dB2SipsxN51I7UVDk3tsvYTCj1IzQvnuedvC4EJl5Oc/rwD
 NLztNemJIWYmKCtJTSWJUU0jgbgWuqbQ=
X-Gm-Gg: ASbGncs33td6vyeir96HCoSNYCJ5RaJEaiIUyvgYji4aW999LwWI+FP/1rOXKqYI6vm
 zXrWj6B2XiLpPrZAcIl/4wCKuXzWCyJHg6YLam7bIqdpquN8EvC/GTz19a48MeANrLxI70nseVK
 30bE2GvO9lIeBTYAdsNz3iA6lhFCW9n0FIA2onZ3a+7ZkCSkWNLNfcJcGTW0oWu3lNh11RaYFH1
 ymsh63v7jpU31pqMfX/7kEYx/kM/VIavx0BKdw=
X-Google-Smtp-Source: AGHT+IExyp03+iz4OvK7c9NT9iW/yaVq+8AdPH5SAYncu5XaBKxdY46fV3M/DNGHwUYlXldBC0Z6BrBy/KqDF1mV8T4=
X-Received: by 2002:a05:6512:b9f:b0:55b:746a:d164 with SMTP id
 2adb3069b0e04-55cb688e47cmr802841e87.35.1754565805163; Thu, 07 Aug 2025
 04:23:25 -0700 (PDT)
MIME-Version: 1.0
References: <20250728-imx95b0-v1-0-5cdae3764d21@oss.nxp.com>
In-Reply-To: <20250728-imx95b0-v1-0-5cdae3764d21@oss.nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 7 Aug 2025 08:23:13 -0300
X-Gm-Features: Ac12FXxZIjsJq0ulaourL6a4O44C6mMu-xFWHbbP8LrrBRH9brWIDB4ZeY6eSpw
Message-ID: <CAOMZO5CWXLxOoZDpgQ+s-PTdP=AZDJ-5qv-zzyaHko1Gzcsyaw@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Restore support for i.MX95 A0 silicon
To: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Cc: Marek Vasut <marek.vasut@mailbox.org>, Tim Harvey <tharvey@gateworks.com>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Stefano Babic <sbabic@nabladev.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Alice Guo <alice.guo@nxp.com>,
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

Hi Alice,

On Wed, Aug 6, 2025 at 9:40=E2=80=AFAM Alice Guo (OSS) <alice.guo@oss.nxp.c=
om> wrote:
>
> Signed-off-by: Alice Guo <alice.guo@nxp.com>
> ---
> Alice Guo (2):
>       binman: add a new entry type for generating a data file which is pa=
ssed to mkimage with -n
>       imx95_evk: Restore support for i.MX95 A0 silicon

This version looks much better, thanks.

CI detected a problem:

$ ./tools/buildman/buildman --maintainer-check
fatal: detected dubious ownership in repository at
'/builds/u-boot/custodians/u-boot-imx'
To add an exception for this directory, call:
git config --global --add safe.directory /builds/u-boot/custodians/u-boot-i=
mx
WARNING: no maintainers for 'imx95_a0_19x19_evk'
Cleaning up project directory and file based variables00:00
ERROR: Job failed: exit code 1

Please fix this, run CI, and submit a v3, thanks.

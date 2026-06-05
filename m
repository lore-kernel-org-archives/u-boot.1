Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89BDACD6E75
	for <u-boot@archiver.kernel.org>; Fri,  5 Jun 2026 00:12:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A0FF848BF;
	Fri,  5 Jun 2026 02:12:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hlNw1ZO8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BEF3C849A3; Fri,  5 Jun 2026 02:12:23 +0200 (CEST)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com
 [IPv6:2a00:1450:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD19C84874
 for <u-boot@lists.denx.de>; Fri,  5 Jun 2026 02:12:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-5aa66893e9fso1487944e87.1
 for <u-boot@lists.denx.de>; Thu, 04 Jun 2026 17:12:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780618341; cv=none;
 d=google.com; s=arc-20240605;
 b=loGuy8E6SjE0dCXIl87v01BvHLWYpiEtA71JrZaHd3I8uQyWrP7bRchSNcc3ZJx0k/
 7LbdE046OhX/vVedopfJlOj13I/aurPJXc85a+YUq9MsAEzKeM7Vz5P3FPagIN8oxIiH
 bcNbLTEMfIQa50U1N3sGy6LibNI0SkQBa9BKqG+p0/7myP0wz/sfmemR6/R6Ed11Y7/L
 T6DEsRa0txOZFIhwEcsydXrC2TZQE8BF9SQpU8wdd/sAl7997DpxaCIv7+tdckQz37WS
 9oxSJDpPWB1YlYoRpT958zX7aRJJ/9YsTFZ7GeU6YBdXpH7GBUk0GSHnyBWL6NzB2siZ
 SWMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=xowU3OZEoOh9SoPU52XaL65xgaZtUsGMiYRtwvczgPE=;
 fh=C9+8Gak66W3ikkwClI24vfvsOnGd6bgnpk9VNpx2iz0=;
 b=QV31ZlpUKkRAMm4L8773Z7he6nMPDOTfhBwIQcoqh8En8AB5y7DOLgwbOSH2sYaPC0
 pa5qHaQlt+0nGY7OGQ/cRcbh/jhdFjOAjtNsffcIz9zvS02T6K5n9kTXaNPn/od+/sNJ
 k3pPIV0KSzERN76nDE8+Cn61dHhNedJ8aaKqgk4rU4hRzZGzffO2GpQdcuqftCu+mhPM
 NOyFILsYLYQ5NabzAEgXrH3q+fN+eS7EOhnECKE6Pz4/+UC/BclVJX+SMoi/qs09Rgyx
 gzgbKvvD57m4DOGUE1EeWoFrYcwgYmkb8NNIsOhnh1SLhFhCDt4/xGj65q5lyjCrezo3
 eziQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780618341; x=1781223141; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xowU3OZEoOh9SoPU52XaL65xgaZtUsGMiYRtwvczgPE=;
 b=hlNw1ZO8Zx12ZNx8Fti9z7PTqNGgsZCgMRNY0Oxa7MJnVLLbltfcFy7G8ecAeMA4BV
 n41bo2YvCfWaV6zUq7w9bxDbWYQR4ItCo5tpLtg9fV8fXfkR7bYGUa92lXVvSkTnSHmt
 lWoqNS9HE/LPkRCRCi8S5yuDpuc9zYaLuHGud5UGUhHMJpMQfxc0ZSR/D+PVYwwguTY9
 Rr9AubGTzBhnh9iDz836S1rshzoqIFAXh7dty/+HVl5RmfQ7Ui7zUHu3RRR9mKInCeEh
 NcDtTO3NBsTUYcObI5G4Kw/0tzfPt7kVBtHPqQfa9p/U5uGbHziQgA3tdeC5VpAoEqxh
 l0NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780618341; x=1781223141;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xowU3OZEoOh9SoPU52XaL65xgaZtUsGMiYRtwvczgPE=;
 b=YpFcBLPvU/8R8UhMRVFvJ4jkHlRGP77kKSVmEUc/evVR1vm+IDPAtngT/cAzmSPBnw
 0rJEE+Xiyyve+lxNul8Ow6ll4CV/P/z4aymh4/LhwSm2hmSPNTxUPuGWDZ30HxnNtNpR
 JQ/nba+7POG9B+2uPJtkWxk0WnB9c0cBPMKUTsoLNyj+9OCXEeO3DryiI4MX0gq2xbDr
 /lq+Zznm/cihz4g7K3UYKKbkJ87sdEM4yj0WUHfkyBi9+tXa3JfpkL/s17YQfgTjBnQM
 FH80ZQdBxgWUbIWocO+Y459r8Z0DaYHvzMQB6AFY6yy3mCCl48h5orF/ifbZ5gDJwaYH
 iBHw==
X-Gm-Message-State: AOJu0YzA0frxb6WpugGo1MWToL7ldLZNJ2uEEJfjoB8HP1w64FLlq291
 pkOx8wzQ/8SpHfl8c5FfuKEowVVT/gg/k5yDUWuu8WQ06R5f2qMELUG0SmBAjuTC5o2YLmL4mC+
 RnvmJHhPTQY+6gDhkFY8eSrFgDMNPrNU=
X-Gm-Gg: Acq92OG2Wq4YND73GgHkhrQIWx9GsEJGc3N5Am3Mdj6CnzZdWlO6klYvKo5XF2zWZtc
 f57k5MbjifwDiNa7Y45BBNy6HiAKGUZsonvZMKHRaDv76Wr2q1dRJRwICfXDbbI/D3gt2OcBy6T
 m8hNHNU/NCg+NggrgFRS/OEeLEtdjTXAJUFlM/E5AJ2xIj4LMtRdMkMT+aHq+83+qAqjEYxYSuZ
 aE0crhUlkfw/8f6h2Q0vbFSsP01b1kJGwXm8QET26ISVBg1ANrV/A4dvMI1LmvDZT3ZYD6Cy1VE
 NJOyRYaOsDk/vT8MOUzaQ4IlNGG1rtErKco7aGu9mo8eJ2Ne8Q3ZushLGJ9PzRQQSNCbksuvnBT
 BVYvWlA==
X-Received: by 2002:a05:6512:104c:b0:5aa:6b70:325b with SMTP id
 2adb3069b0e04-5aa87b66f3bmr253770e87.7.1780618340873; Thu, 04 Jun 2026
 17:12:20 -0700 (PDT)
MIME-Version: 1.0
References: <20260522135144.1643089-1-ye.li@nxp.com>
In-Reply-To: <20260522135144.1643089-1-ye.li@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 4 Jun 2026 21:12:09 -0300
X-Gm-Features: AVHnY4LClKQxrYmYyylbt_0HQ5XknkFACfKe6vOfjHp6wgdyM1L77Cj7UPU540o
Message-ID: <CAOMZO5B1ZZM+z7OKNhKVbvxB_H4_CHCcZ1E47GUAB3YAmyz9WA@mail.gmail.com>
Subject: Re: [PATCH 1/3] cpu: imx8_cpu: Fix CPU segment information print
To: Ye Li <ye.li@nxp.com>
Cc: u-boot@lists.denx.de, peng.fan@nxp.com, uboot-imx@nxp.com, 
 ye.li@oss.nxp.com
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

On Fri, May 22, 2026 at 10:49=E2=80=AFAM Ye Li <ye.li@nxp.com> wrote:
>
> Should not use CONFIG_IMX_TMU to determine the print of CPU market
> segment information. Only iMX8 platforms don't have segment fuse.
> And there is no extended commercial part on iMX9 (91/93/94/95),
> fix it to extended industrial.
>
> Signed-off-by: Ye Li <ye.li@nxp.com>

Applied this one to u-boot-imx/master, thanks.

Patch 2/3 did not apply. Please rebase and resend 2/3 and 3/3.

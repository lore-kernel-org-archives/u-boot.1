Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1AABCFB422
	for <u-boot@archiver.kernel.org>; Sat,  5 Oct 2024 16:48:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7DF06889BD;
	Sat,  5 Oct 2024 18:48:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VmW84aUw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A7EA889C3; Sat,  5 Oct 2024 18:48:27 +0200 (CEST)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com
 [IPv6:2a00:1450:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 73458889BD
 for <u-boot@lists.denx.de>; Sat,  5 Oct 2024 18:48:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-53992157528so3459492e87.2
 for <u-boot@lists.denx.de>; Sat, 05 Oct 2024 09:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728146905; x=1728751705; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dtwg0OVyEGztyOjzTiYcd14kX0rztXz8eu5ayq8UnLw=;
 b=VmW84aUwntpkn+9DKBnMS7w4nmYPF95cx1xpaDoKfv4fLepkNRGTKHpZ5y3gfShZKT
 iquRZiOW4ix9gRaFqyq3lkqHRbf2ADUpFOP28lb6zAex1W2wimiJrwa6o7Xgg1rX7BIv
 pGjy0IfrvaUOxTiztQfD8XaE6dt3VJLwlaMjiRoEZkeKkqpestG+xzk4q3v7XFWUEIDf
 CLzuPduUTfm407YUUZNMboo4SClN6GD9Wr+Ycz1zGWF9SulC+0y3A/EgTAD94UosHjDZ
 E+GBFq6bhPe15HPMo60PExj1EvCo4KL/lrr+mxxauhSofz6edHA2ermT3kaC/QZrNNlB
 GVCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728146905; x=1728751705;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dtwg0OVyEGztyOjzTiYcd14kX0rztXz8eu5ayq8UnLw=;
 b=r1O+GVnPHWxktPr+L1IxMPvsYNRHbEomF7X6LQ7yZkVogVhcSzIahvOLniFYeuvXuF
 Li4MsY8QCOGy8wBp+p0FLqu7zmzeqoaG7d994+XVeIjPb99Oy1Ylnplkv5eE3uouqWO4
 15UG1uWCovbJdO5sHnO5ysEZdVldQ66ppJHZG9bfiLeJeTO1o4V44OACBdfk5tGRQ2Et
 aKF8/1TAAGMpp3aPu7KgBfaIdfGHlvzLWFhDwOTMpbYDNsP0Odfaeb8xLo19n+e1YcYu
 dh3z1M05GalSHpMceZ+rrXeHqudyc5344CrKxD6K+H9lxDG3Uc5n3QdqsrXVvkaaox98
 /hdA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXuGUCX200V6CU6Z8lasYBS0Tf78HU5nut6p6t8J9ZRwFZasHK3Zc6X7qQEEVu6PZuqdFyBcuA=@lists.denx.de
X-Gm-Message-State: AOJu0YwlcQzU/4H/pqX+NlMhCP0FzWY+1vqvioG1RF7PaVM3yb/iZn9w
 k2Lzd/0R9eyEnT5X3MJ+ohTHUK/Wj8rb+ASDDLZTwXYkJO6BQBhdDf8LgwPDZm0Z39xtyHnZBSy
 NPY3jKMkCfi9ke5bGt6522kZ4qHk=
X-Google-Smtp-Source: AGHT+IFDbkLSdlU+06qtB0jIFKgcFWIXpPVVAvkWzyfaWKhf874wnY9NsWsR/c82an1GJml1+cSD0DDCp0onHDtUpuc=
X-Received: by 2002:a05:6512:159e:b0:530:ae4a:58d0 with SMTP id
 2adb3069b0e04-539ab8593fdmr2653892e87.8.1728146904570; Sat, 05 Oct 2024
 09:48:24 -0700 (PDT)
MIME-Version: 1.0
References: <20241001130758.9810-1-peng.fan@oss.nxp.com>
In-Reply-To: <20241001130758.9810-1-peng.fan@oss.nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 5 Oct 2024 13:48:13 -0300
Message-ID: <CAOMZO5DFG1hGCx8zvXdKygYN_y0L_MOS+ZvxvdahiYeO2vvotA@mail.gmail.com>
Subject: Re: [PATCH V2 1/5] mmc: fsl_esdhc_imx: Enable AHB/IPG clk with clk
 bulk API
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: sbabic@denx.de, u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>,
 uboot-imx@nxp.com
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

On Tue, Oct 1, 2024 at 9:04=E2=80=AFAM Peng Fan (OSS) <peng.fan@oss.nxp.com=
> wrote:
>
> From: Peng Fan <peng.fan@nxp.com>
>
> With partition reset supported for i.MX8QM/QXP/95 and etc, when linux
> mmc runtime suspended, the mmc clks are gated off. While at same time
> system controller reset Cortex-A cores because of various reasons(
> WDOG timeout and etc), with SPL run again, only enable PER clk is not
> enough, also need to enable AHB/IPG clk, here use clk bulk API to enable
> all the clocks.
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>
> V2:
>  Update commit log and use clk bulk API per Fabio.

Applied all to u-boot-imx/next, thanks.

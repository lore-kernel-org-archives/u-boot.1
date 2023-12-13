Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E4B0C4332F
	for <u-boot@archiver.kernel.org>; Wed, 13 Dec 2023 16:29:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9BA2C87844;
	Wed, 13 Dec 2023 17:29:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IZCDmLJU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D5C3887848; Wed, 13 Dec 2023 17:29:45 +0100 (CET)
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com
 [IPv6:2607:f8b0:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 98A3D86564
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 17:29:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-5c6ad67ab7aso433747a12.1
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 08:29:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702484982; x=1703089782; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pplOfyuEbdXhWf/dmrpkuHdcPcuozOBXAivO1ULqIMc=;
 b=IZCDmLJU6D27t7yqoG6WzQMuH1kNnXCbA5bVY9kCZcwXkViezPicAL9BF0AkBqdzZV
 rnHkXgCPWBLbvDNF7C9/KTiJkQVaV07q/x3/6epIVQ7r2rr+Mt6NpYOyfJl/MzxbzQfw
 K8WAFmc6Z50EfUbjhBD46xmIQYI2hBlg8v2Jqc1zh/OtGzDvz5rZY51Gvyv8m1Vi7AoV
 2Bxp1si7bcqKztD7C2FlyUKQwZmqNX6mjXg/IYHc8VJwX3GR0njcwMFnE627nimMH7zG
 OLxRqzYCsMbKVzM1SrbeD1r1xM/nmKg2pSRh8cLoGBjZ+oz6vioXv8VuszTSOIUzSZKo
 ofLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702484982; x=1703089782;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pplOfyuEbdXhWf/dmrpkuHdcPcuozOBXAivO1ULqIMc=;
 b=IZKxjFtjlv8VXmWckr7mpsEy97oRWrxGBkyDpl2pxjXvm6ckEjeno72S1+nbVAuuqt
 lkRpu9TI/YrT/GtqUbMK+mQvueT40HOdkdhsxGNwvzakxejYZMsVwAYNRKkQDpHpZp2i
 MQFlfKVsWdjLLQJqaQCv00XDtU0+a29c+6LSCs80p7kIy1EbAPDWb9M3bVMFGZl5ZlBR
 3jhJ1zxdw9aCYpvbQcjEifu2ZKpy1ixY8b7WvgxVuwZKGXW+GkgvI2aOJLD2G5o9y3Tr
 3sX+3/esAb+z0u1ac/WTlDaqHMSIc9wmakALCSfd9yVXf6CjoUv3QiQmc+WtNb7Wi3/h
 3gdQ==
X-Gm-Message-State: AOJu0Yy7W/I+nBktOlLpbm73x/f7+zdF83pUmXNGvlFTTp3JTPVuSLtH
 qQJpOoNGTVjWWgUvjOmH9PzUzepsCDvT5Z/58Qg=
X-Google-Smtp-Source: AGHT+IFH6c5iEM8JA/8vYtuIgE5fYwpitYsqXZfjCcWCpLH8OQdvcqHG+IeTtNIT/uzZtuEsIVsu7OGHVjCKxjhNdmo=
X-Received: by 2002:a17:90a:7e95:b0:286:6fe0:8a69 with SMTP id
 j21-20020a17090a7e9500b002866fe08a69mr13977659pjl.2.1702484981910; Wed, 13
 Dec 2023 08:29:41 -0800 (PST)
MIME-Version: 1.0
References: <20231020004735.1913081-1-festevam@gmail.com>
In-Reply-To: <20231020004735.1913081-1-festevam@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 13 Dec 2023 13:29:29 -0300
Message-ID: <CAOMZO5B7ZGV3J=f93v63nJ3O2FgXWsmct8dMQ+8Hh2nMUfbeQQ@mail.gmail.com>
Subject: Re: [PATCH] clock_imx8mm: Add a stub for imx8mp_fec_interface_init()
To: sbabic@denx.de
Cc: marex@denx.de, peng.fan@nxp.com, u-boot@lists.denx.de, 
 Fabio Estevam <festevam@denx.de>
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

On Thu, Oct 19, 2023 at 9:47=E2=80=AFPM Fabio Estevam <festevam@gmail.com> =
wrote:
>
> From: Fabio Estevam <festevam@denx.de>
>
> When CONFIG_DWC_ETH_QOS_IMX=3Dy and CONFIG_FEC_MXC is not selected, the
> following warning is seen:
>
> arch/arm/mach-imx/imx8m/clock_imx8mm.c: In function 'board_interface_eth_=
init':
> arch/arm/mach-imx/imx8m/clock_imx8mm.c:914:24: warning: implicit declarat=
ion of function 'imx8mp_fec_interface_init; did you mean 'imx8mp_eqos_inter=
face_init'? [-Wimplicit-function-declaration]
>
> Fix it by adding a stub for imx8mp_fec_interface_init() to handle this
> case.
>
> This follows the same approach done on imx8mp_eqos_interface_init().
>
> Signed-off-by: Fabio Estevam <festevam@denx.de>

Applied to u-boot-imx next, thanks.

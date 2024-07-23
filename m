Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C266FC3DA49
	for <u-boot@archiver.kernel.org>; Tue, 23 Jul 2024 22:51:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D3BDB87E50;
	Wed, 24 Jul 2024 00:51:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HGfV4Mbx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D2BAD887D4; Wed, 24 Jul 2024 00:51:53 +0200 (CEST)
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com
 [IPv6:2607:f8b0:4864:20::f35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 23DA186E1B
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 00:51:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=robertcnelson@gmail.com
Received: by mail-qv1-xf35.google.com with SMTP id
 6a1803df08f44-6b7b28442f9so61382596d6.3
 for <u-boot@lists.denx.de>; Tue, 23 Jul 2024 15:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721775104; x=1722379904; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9sH8NmGmSSQT75YVYP2Xg7tlKSJM0Ify2nD16xQJJdo=;
 b=HGfV4Mbx0u0CqaC8UceTnnbuOYAoU4PHJaDtArX/CP284CCNznl4B2S9izaWZFw3ne
 hQPreLVilGm3J7EH/+AxV4EeqVPxQafsomGTa3hn3lX5Hh9TXO0ZueF8w98Ovhlwegll
 YzculqsUgFimtLVVM2g8QMfO5oQ4uT+5E2N2tYnLPArob3rb5xBgUvhkmxyHBy9Fof6z
 nf902B/zmszWAVnBumgz9bwA9lYclx9vPhuGNtkktGO1ZHNFRY7SeQWMdyyvjIlkhVXH
 QCKZeygx0ItKck7oB6+vbrCCdEIowJlOBxWhf4yDT6y6l833z0jbYYsc8XsOA6doPIVy
 4jNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721775104; x=1722379904;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9sH8NmGmSSQT75YVYP2Xg7tlKSJM0Ify2nD16xQJJdo=;
 b=MY8Bt1FOTZ4ABOi9l0Br38RuWXdKGYvIwJa4Law/p7WruEvM4/QvoO7RPiFE2wlzdi
 fTvkWSnNZgZwUljjWLfayCdHncCjEtIWCzK6It5oG/z5xcv+BlM9Ud8IrWqWFflHtG1k
 tANlvdOiTUUFYFwpWfw4ACA/08D+iJRPjx7npAQi4MC15MAMBouPa9/hiCaxRD6mfl87
 2TIQyy5K3XdCy11hBkGWasQuR4KDNkmvp+PAYdUNbOR9ojTGjcY4BWIDrGAAHb2Ksygn
 ZJ2PJaUAbcmCbK4Rl6EH/YtHDoG2RQcfdNEP7dcYFatoFmHBJF0AnMYtws6M3oFBEsqU
 Kg4A==
X-Gm-Message-State: AOJu0YxUklaYB6jA282FalKFngGMr0g7QsC0Ece18X3z4bGYFUQz7/uh
 JF2uEuuOURYg/9X7c9dp83lT0i0PZPH315zAKMwEugNuT92f6SyIDl0urDK9mEhqGkAA2sMoAkr
 r1paw0jxTj1OkZ/p7q/savSE/tNk=
X-Google-Smtp-Source: AGHT+IHJAMFMVoIRSVTBsCTnrW0QXL0NUACShgj3SEf5KhFTdbL+qrFUXJ+4aWu00l5/LOOoiaGTfg01NeCBIvZW2wI=
X-Received: by 2002:a05:6214:202a:b0:6b2:da3d:999f with SMTP id
 6a1803df08f44-6b9610f04aamr191731876d6.41.1721775103938; Tue, 23 Jul 2024
 15:51:43 -0700 (PDT)
MIME-Version: 1.0
References: <20240520095916.1809962-1-n-francis@ti.com>
 <20240520095916.1809962-4-n-francis@ti.com>
In-Reply-To: <20240520095916.1809962-4-n-francis@ti.com>
From: Robert Nelson <robertcnelson@gmail.com>
Date: Tue, 23 Jul 2024 17:51:17 -0500
Message-ID: <CAOCHtYiqkKpiu5F4U9j1+wUKsox3Up43Bc05pNSY5mZmSsp=pw@mail.gmail.com>
Subject: Re: [PATCH 3/3] arm: dts: k3-j721e: Move to OF_UPSTREAM
To: Neha Malcom Francis <n-francis@ti.com>
Cc: u-boot@lists.denx.de, trini@konsulko.com, sjg@chromium.org, 
 alpernebiyasak@gmail.com, bb@ti.com, nm@ti.com, sumit.garg@linaro.org, 
 michal.simek@amd.com, marex@denx.de, neil.armstrong@linaro.org, afd@ti.com, 
 vigneshr@ti.com, kamlesh@ti.com, m-chawdhry@ti.com, u-kumar1@ti.com
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

On Mon, May 20, 2024 at 8:44=E2=80=AFAM Neha Malcom Francis <n-francis@ti.c=
om> wrote:
>
> Move to using OF_UPSTREAM config and thus using the devicetree-rebasing
> subtree.
>
> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
> ---
>  arch/arm/dts/Makefile                         |    4 +-
>  arch/arm/dts/k3-j721e-binman.dtsi             |    2 +-
>  .../k3-j721e-common-proc-board-u-boot.dtsi    |   14 +-
>  arch/arm/dts/k3-j721e-common-proc-board.dts   |  976 ------
>  arch/arm/dts/k3-j721e-main.dtsi               | 2741 -----------------
>  arch/arm/dts/k3-j721e-mcu-wakeup.dtsi         |  681 ----
>  arch/arm/dts/k3-j721e-sk-u-boot.dtsi          |   20 +-
>  arch/arm/dts/k3-j721e-sk.dts                  | 1074 -------
>  arch/arm/dts/k3-j721e-som-p0.dtsi             |  446 ---
>  arch/arm/dts/k3-j721e-thermal.dtsi            |   75 -
>  arch/arm/dts/k3-j721e.dtsi                    |  176 --
>  configs/j721e_evm_a72_defconfig               |    5 +-
>  configs/j721e_sk_a72_defconfig                |    4 +-
>  13 files changed, 16 insertions(+), 6202 deletions(-)
>  delete mode 100644 arch/arm/dts/k3-j721e-common-proc-board.dts
>  delete mode 100644 arch/arm/dts/k3-j721e-main.dtsi
>  delete mode 100644 arch/arm/dts/k3-j721e-mcu-wakeup.dtsi
>  delete mode 100644 arch/arm/dts/k3-j721e-sk.dts
>  delete mode 100644 arch/arm/dts/k3-j721e-som-p0.dtsi
>  delete mode 100644 arch/arm/dts/k3-j721e-thermal.dtsi
>  delete mode 100644 arch/arm/dts/k3-j721e.dtsi

This commit cut a little too deep for j721e device's on v2024.10-rc1,
beagleboneai64 doesn't make it into U-Boot SPL..

```
git bisect start
git bisect good 3f772959501c99fbe5aa0b22a36efe3478d1ae1c
git bisect bad 123f6f75dfcb5f88d821e4eb91ddedfb7718d601
git bisect bad 005105b11cefe694dcd40572639973fbb9b31646
git bisect bad d8c213c9c7f827a9de0096bb4e5247c9a07bb248
git bisect bad bf3d5baa868a658d4625aaf177096751b8597891
git bisect good 4095df4634b4791d83cf86ad94e43b83057830f4
git bisect good c16aa668fd9fc8e98c74e19cd7cd95aef3873dbd
git bisect good 227be29df37545f74243a98c12a4a33c4160e3cd
git bisect good e9774afedd20bfe8a18b20a63010c1d18cd16cd7
git bisect good 54c93718b38c58160a018bb6a267a6b8b47469c4
git bisect good c9507f07a1d6c92bd1f73fd64384f8c5994be9c2
git bisect good 48639c705026b5556e60320aef01a94a9ee45be3
```

The real fix is to convert beagleboneai64 to of_upstream

It's a little fun, between eMMC re-flashes..

Regards,

--=20
Robert Nelson
https://rcn-ee.com/

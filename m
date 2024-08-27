Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1DC3C5472F
	for <u-boot@archiver.kernel.org>; Tue, 27 Aug 2024 14:53:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1CADE88986;
	Tue, 27 Aug 2024 16:53:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AkEQHsdr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 23AE7889A0; Tue, 27 Aug 2024 16:53:35 +0200 (CEST)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com
 [IPv6:2a00:1450:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D2D468897C
 for <u-boot@lists.denx.de>; Tue, 27 Aug 2024 16:53:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-53436e04447so4696841e87.1
 for <u-boot@lists.denx.de>; Tue, 27 Aug 2024 07:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724770412; x=1725375212; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5DADS2MbpJhavBw3yn68pC1SfqLY8on/Aex91uOlBiM=;
 b=AkEQHsdrGZqWvPH+ZMfkr0aSG+KqPFhL0o+fBbZNXI3qi+2UFmC/bJrggEZ+J6UUA/
 83zm+nzfK32fBLmFAn44EXiAa8aiM6T/6vCrNnqNaQvJz/TUKIZf+aODKDV/CPEga9Dc
 iCatO/q8erqERF2AphKB4ILVTXlRgTgJiu3b3t2WEc2Fk6t3BJY/FXA4+b9vjyXIpEoZ
 j+4j2RxhLsRAQIIyg+LHt0ylrguo6agUNd4dQUA5T/PTFowxFS0ydnMR0N1Hfz5PslpV
 6ojcitNc78l79M55LyzAva2gLHGKjUtq9gGqtf4tUuwifePrSEM+B9tg7F0Xyj9CgqHT
 ckfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724770412; x=1725375212;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5DADS2MbpJhavBw3yn68pC1SfqLY8on/Aex91uOlBiM=;
 b=Iz7aS9aBeW2W8Iaavdi08dcbvBLt+MYpAvMeR6kvnu8sid7wnfg/M5t3Gf/kSZcCsp
 5+lV4ZOMbITzW9c8FRzprU2jZDoTa/FcN/+QvDMDkxSQ6x8X1BwaVpdBLjnyWvwhHgjK
 UNqomWk/ipw1odl2E3xaUsPP/uvfY409JibcBn7F1B9oXkovMgjIT577UfjvjJbT66VX
 IhFSupJIRX18ZlsQeG2aJ60hfBgNPJpGooEOatfC62UZc/CHIlAsUaX2bcXBeGNfbw0D
 LLCkdxp+Lqj3j2AoDVyqHG2pk6jJyoT0g0XcMR59niVHnfOxkjZS2YW6Xvn0Se1Jhjed
 QqRg==
X-Gm-Message-State: AOJu0YyFr+4FYg5tyeIOh5ACQF24bstyuik0SjSQIR/2NDMgferb7V0T
 Kk1a6fCG+q+cSxLPmGy1Xym/H4vaQ+T9lITMTpLZlLU7Ndc/EwspQ/KV2fawMU61woMhcvvC8i2
 F1KdZ9sKKQr1HTT17n+9uktJQYuA=
X-Google-Smtp-Source: AGHT+IFBRvAt1+ui9+8Y32s3/NQ9TT2qae//5llpZUbggwU9Umv7bxK6thNu5ohJrp1vVr/TevBGO+7vkp6Hck5c3gI=
X-Received: by 2002:a05:6512:304f:b0:533:3f6c:f899 with SMTP id
 2adb3069b0e04-5344dd8ae9emr1081625e87.24.1724770411675; Tue, 27 Aug 2024
 07:53:31 -0700 (PDT)
MIME-Version: 1.0
References: <980adca3-27ac-440b-93b4-80146d050584@linaro.org>
In-Reply-To: <980adca3-27ac-440b-93b4-80146d050584@linaro.org>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 27 Aug 2024 11:53:19 -0300
Message-ID: <CAOMZO5A2ZBb9G6krUmfNy3qnoNYgwdb2-DUgeNuvONy9VioEbQ@mail.gmail.com>
Subject: Re: imx8ulp_evk build with buildman fails every other time
To: Jerome Forissier <jerome.forissier@linaro.org>,
 Gary Bisson <bisson.gary@gmail.com>, Peng Fan <peng.fan@nxp.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
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

Adding Gary and Peng on Cc.

On Tue, Aug 27, 2024 at 11:42=E2=80=AFAM Jerome Forissier
<jerome.forissier@linaro.org> wrote:
>
> Hi,
>
> Can someone explain what's happening with the imx8ulp_evk buildman build
> below? It either fails with a mkimage error, or succeeds with a binman
> warning, every other time. 100% reproducible. /me confused :o
>
> =3D=3D=3D=3D8<=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D8<=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> $ docker run -it --rm trini/u-boot-gitlab-ci-runner:jammy-20240808-21Aug2=
024
> uboot@42aa85c2d6b7:/$ cd
> uboot@42aa85c2d6b7:~$ git clone https://github.com/u-boot/u-boot.git
> uboot@42aa85c2d6b7:~/u-boot$ git log --oneline -n 1
> ee2af844ba (HEAD -> master, origin/master, origin/HEAD) Merge tag 'efi-20=
24-10-rc4' of https://source.denx.de/u-boot/custodians/u-boot-efi
> uboot@42aa85c2d6b7:~$ cd u-boot
> uboot@42aa85c2d6b7:~/u-boot$ tools/buildman/buildman imx8ulp_evk
> Building current source for 1 boards (1 thread, 24 jobs per thread)
>    aarch64:  w+   imx8ulp_evk
> +WARNING 'mx8ulpa2-ahab-container.img' not found, resulting binary may be=
 not-functional
> +WARNING 'bl31.bin' not found, resulting binary may be not-functional
> +WARNING 'upower.bin' not found, resulting binary may be not-functional
> +WARNING 'm33_image.bin' not found, resulting binary may be not-functiona=
l
>     0    1    0 /1              imx8ulp_evk
> Completed: 1 total built, 1 newly), duration 0:00:09, rate 0.11
> uboot@42aa85c2d6b7:~/u-boot$ tools/buildman/buildman imx8ulp_evk
> Building current source for 1 boards (1 thread, 24 jobs per thread)
>    aarch64:  +   imx8ulp_evk
> +WARNING 'bl31.bin' not found, resulting binary may be not-functional
> +binman: Error 1 running 'mkimage -d ./mkimage.spl.mkimage -n spl/u-boot-=
spl.cfgout -T imx8image -e 0x22020000 ./mkimage-out.spl.mkimage': Fail open=
 first container file mx8ulpa2-ahab-container.img
> +
> +make[1]: *** [Makefile:1126: .binman_stamp] Error 1
> +make: *** [Makefile:177: sub-make] Error 2
>     0    0    1 /1              imx8ulp_evk
> Completed: 1 total built, 1 newly), duration 0:00:04, rate 0.25
> uboot@42aa85c2d6b7:~/u-boot$ tools/buildman/buildman imx8ulp_evk
> Building current source for 1 boards (1 thread, 24 jobs per thread)
>    aarch64:  w+   imx8ulp_evk
> +WARNING 'mx8ulpa2-ahab-container.img' not found, resulting binary may be=
 not-functional
> +WARNING 'upower.bin' not found, resulting binary may be not-functional
> +WARNING 'm33_image.bin' not found, resulting binary may be not-functiona=
l
> +WARNING 'bl31.bin' not found, resulting binary may be not-functional
>     0    1    0 /1              imx8ulp_evk
> Completed: 1 total built, 1 newly), duration 0:00:04, rate 0.25
> uboot@42aa85c2d6b7:~/u-boot$ tools/buildman/buildman imx8ulp_evk
> Building current source for 1 boards (1 thread, 24 jobs per thread)
>    aarch64:  +   imx8ulp_evk
> +WARNING 'bl31.bin' not found, resulting binary may be not-functional
> +binman: Error 1 running 'mkimage -d ./mkimage.spl.mkimage -n spl/u-boot-=
spl.cfgout -T imx8image -e 0x22020000 ./mkimage-out.spl.mkimage': Fail open=
 first container file mx8ulpa2-ahab-container.img
> +
> +make[1]: *** [Makefile:1126: .binman_stamp] Error 1
> +make: *** [Makefile:177: sub-make] Error 2
>     0    0    1 /1              imx8ulp_evk
> Completed: 1 total built, 1 newly), duration 0:00:04, rate 0.25
> =3D=3D=3D=3D8<=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D8<=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
>
> Thanks,
> --
> Jerome

Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0640CC6FD1F
	for <u-boot@archiver.kernel.org>; Tue, 26 Mar 2024 12:49:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 640C688011;
	Tue, 26 Mar 2024 13:49:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OaIzXx22";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9993D8801F; Tue, 26 Mar 2024 13:49:31 +0100 (CET)
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com
 [IPv6:2607:f8b0:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 48D2A88003
 for <u-boot@lists.denx.de>; Tue, 26 Mar 2024 13:49:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-6ea895eaaadso924804b3a.1
 for <u-boot@lists.denx.de>; Tue, 26 Mar 2024 05:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711457368; x=1712062168; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eRk2IiMRPoigAcZhfpB1iD4Ki2zFcoG9u4H3DFwwmqM=;
 b=OaIzXx221X4cD84txY0AblFp36bzijNOsoX5dhGqlo/RKtg+D/dnqv01vm2RjT1fFQ
 u0fxGYIkqzGd7Pl3lE18/s1UxmNZy+lCPpTQBZ90njp7UEOgPbNNMy0mh2KJ9e/QFbw3
 Ts1Y5amK/aH7tF8CutGBHezYmjp10GUACrewIaaGVuTdMqaWwYSioPOgAX8FLUQO5DRn
 DmUGOE49X1jiBu2PJnEuPoSG3qTY+j9zu0cmp9TqHweOLqC5kMDami2kCC0eGXu9p+hc
 YqzLIbcwQng0HhGgp6LFavcv0HpoV6VRhakx3fvH2bJj/zwBUMHGYG935ecAyp85pSCb
 Znrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711457368; x=1712062168;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eRk2IiMRPoigAcZhfpB1iD4Ki2zFcoG9u4H3DFwwmqM=;
 b=NFcM2qViyA2fXFh96juph2H7Ana6SvlZUa2bc9ULRIh55kcOzA0c/hg6i4sP+gpUpw
 ytIZeA3AY78sfNm7PfgU/LJwZ5yNyn+AZcFXhl5lxtEcWjl3Sxn5wrmD8hgg03c3i6gY
 6FHUXeV1VhJRfl7Az5IOyrMnNqP9MogiD0qQ4irldPx/SaQ0UCqPdfzCaBCNFDnVp/pj
 Otnt6Rs3rOWPHQcfa620J1kTk6sli410XVBUDpwOQGGUdmj90JX9dCCIaf8uEoE38lnW
 MbnqTqsB1GJh6iHJ5X5jv7VPg/mvVWfXrsLq1Gu+1pWj5OUtn/pke2blexATsZVOQqxa
 80rg==
X-Gm-Message-State: AOJu0YyGsJWlPVF5hI5BVlXATryb0kmMRHM9RyVnKbjuM2OK8Wn5a/N3
 9xO6hfVq2EIc5szVydonSPEtis6syQraeTYOel2JIBdMcV+U/DwfuPoeCPBUx6E5w5RwauNqesQ
 wKpID9PrKHBuT6ywpE0euDX7Bkyp7+QR2Dr0=
X-Google-Smtp-Source: AGHT+IGo+P6xInkX6+8jtB1X9BsvwtgorA1WL8+IX6+veJHY6ZYVcMZ626zlM5vcvncoTCDHbFk98cKpqshA/BAGjUA=
X-Received: by 2002:a05:6a20:3d06:b0:1a3:c3a1:b780 with SMTP id
 y6-20020a056a203d0600b001a3c3a1b780mr7910554pzi.1.1711457367675; Tue, 26 Mar
 2024 05:49:27 -0700 (PDT)
MIME-Version: 1.0
References: <BEZP281MB29655E047444C987850ED632AB202@BEZP281MB2965.DEUP281.PROD.OUTLOOK.COM>
 <CAOMZO5BhEmnVsmYdJgabZC1L6GrNc4WvMhRZNrFhemTvD3rpzQ@mail.gmail.com>
 <FRYP281MB2969D2ABC5FF3EB2421E95E8AB202@FRYP281MB2969.DEUP281.PROD.OUTLOOK.COM>
 <CAOMZO5BZETj3yTE1mOVXCmUH+JeyYPs2bSWZ9DGp1qtNqD=JHQ@mail.gmail.com>
 <FRYP281MB296999BB951F57EE51D9C52EAB362@FRYP281MB2969.DEUP281.PROD.OUTLOOK.COM>
In-Reply-To: <FRYP281MB296999BB951F57EE51D9C52EAB362@FRYP281MB2969.DEUP281.PROD.OUTLOOK.COM>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 26 Mar 2024 09:49:17 -0300
Message-ID: <CAOMZO5C3LfFd5fGZiQUh9Kdv24aavL+2o8eQYTKfSQhtS93q-A@mail.gmail.com>
Subject: Re: U-boot fails for khadas-edge -v
To: Vivek Jaiswal <vjaiswal@cinemo.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
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

Hi Vivek,

[Please don't top-post and do not post HTML]

On Mon, Mar 25, 2024 at 1:37=E2=80=AFPM Vivek Jaiswal <vjaiswal@cinemo.com>=
 wrote:
>
> Hello Fabio,
> I tried using the this github repository.
> https://github.com/u-boot/u-boot.git
>
> And the configuration used was following
>
> rockchip-rk3399-khadas-edge-v.conf
>
> UBOOT_MACHINE =3D "khadas-edge-v-rk3399_defconfig"
>
> I got some error during the build from the u-boot.
>
> Please check the attachment BuildError1.txt or BuildError2.txt
>
> make[2]: *** [/home/vjaiswal/dev/Projects/SOLAR/khadas-dev/forTesting/yoc=
to2_actual_meta_rockchip/build/tmp/work/rockchip_rk3399_khadas_edge_v-poky-=
linux/u-boot-rockchip/1_2017.09-r0/git/scripts/Makefile.build:280: cmd/boot=
m.o] Error 1
> make[1]: *** [/home/vjaiswal/dev/Projects/SOLAR/khadas-dev/forTesting/yoc=
to2_actual_meta_rockchip/build/tmp/work/rockchip_rk3399_khadas_edge_v-poky-=
linux/u-boot-rockchip/1_2017.09-r0/git/Makefile:1317: cmd] Error 2
> make: *** [Makefile:157: sub-make] Error 2

You are trying to build U-Boot 2017.09.

U-Boot 2024.01 builds khadas-edge-v-rk3399_defconfig just fine.

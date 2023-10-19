Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90C93CDB465
	for <u-boot@archiver.kernel.org>; Thu, 19 Oct 2023 14:59:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A6398725A;
	Thu, 19 Oct 2023 16:59:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="T3NRmHYG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 28E808725A; Thu, 19 Oct 2023 16:59:39 +0200 (CEST)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0693086FFD
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 16:59:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-53b32dca0bfso1953895a12.0
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 07:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697727575; x=1698332375; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+E+lUjkCBbLvJA90DTrRSa2di0rAD0k1EOzzDu7Scvc=;
 b=T3NRmHYG10sSg4sM18J6tkyIQq0PYd8hW5+QJz1UIg1A3oQzs+atQKLeKBrmGWQd5n
 KeAA2jf94/i+xvtv/e+1GB+dhJxf+OwRck5gxL81ycESTPI+miTqfqRA8Y1Gg9WuRTg7
 0ZvADNmQgPz3gX0TBTbrrqLH+dAjXP4FCLszRkTFqU/zIj4A6cBfxaWt9Bf/UJjV+UYu
 49j6ufZTsA3gxfevMeMkmHnc8B2djc5+CcILFmTj/BQzecJ9r52Ucfp2DJNBNHzxuAhG
 zHyyzcu8jgBEvwDBs64G8k9OCKvwC8HYieaIwLq5u66nGhJwayLo6sAhrCTCiOLILsLA
 uNbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697727575; x=1698332375;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+E+lUjkCBbLvJA90DTrRSa2di0rAD0k1EOzzDu7Scvc=;
 b=tkNjgAGmc09opQ8qASwO2cjOj6hQRQmYcpVyqq5Gy+wc+/X9EdTfh5NGbif4iXGDM6
 0+XCEzv2zO7KP2qRFllNPEwV2exH7CU83ZO0C0MEz32+8CWWLPCRGhLuGTN5wqd+Zz+U
 Js/z43TJA6EU0TG29R2e/nnipY4x3uuxNm/Ep1v75I03lh4eccC6qZHJfop48loHV9+4
 pYWSggnNn3fdkNgc3PqVP1C3S7r2ZD6rp4v2brGcVESWr7OCyn8zD52pXVc53o2PaKJT
 q3IVrHlOXYGEvqbCt7U3fS09zA2zVsX6tbEVnlA6QUeNx4xa9qsT6y58tCfe85K6fRAI
 oxCw==
X-Gm-Message-State: AOJu0Yy2sfEUXRDlNpyUEHv5DMQ3vh6m3YQn1E6NarqlNpRkI62r8HAt
 NW2ux0rShcnYeF5eRhqSUktzqAeA18SGBuFgTiI=
X-Google-Smtp-Source: AGHT+IET5yw0T3gkAV+iqz2NzZL1Pv81clB/Sy1kwTmZ5wu5ZEJPPXD0qmEFjCor4/Dt55lchY+Sn/EwyUq+XEs2Ejs=
X-Received: by 2002:aa7:ca49:0:b0:533:5d3d:7efe with SMTP id
 j9-20020aa7ca49000000b005335d3d7efemr1963240edt.6.1697727575253; Thu, 19 Oct
 2023 07:59:35 -0700 (PDT)
MIME-Version: 1.0
References: <CAMwbjeWur3uKY0fV89PqdrSB7t_e=3Osot6DAocrhA57PCf_UQ@mail.gmail.com>
In-Reply-To: <CAMwbjeWur3uKY0fV89PqdrSB7t_e=3Osot6DAocrhA57PCf_UQ@mail.gmail.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Thu, 19 Oct 2023 15:59:23 +0100
Message-ID: <CALeDE9MjzL47L6qNquQByEzfDAavFpQERyy-B229fYqvnijFug@mail.gmail.com>
Subject: Re: Branches in uboot-imx
To: Grzegorz Borowiak <gborowiak@gmail.com>
Cc: u-boot@lists.denx.de
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

On Thu, Oct 19, 2023 at 3:58=E2=80=AFPM Grzegorz Borowiak <gborowiak@gmail.=
com> wrote:
>
> Hello!
>
> I just cloned the repository:
>
> https://github.com/nxp-imx/uboot-imx
>
> and I encountered a rather large amount of branches (listed below).
>
> Are these branches somehow described, so I could read what they are about=
?
> Especially I'm interested in branches whose names begin with "imx" and
> "lf". What are differences between them, and how are they different from
> branches here:

You would have to ask NXP about that, that repo is not part of the
upstream project.

> https://github.com/u-boot/u-boot
>
> ?
>
> imx_4.14.98_8qxpc0_er
> imx_5.4.0_8dxlphantom_er
> imx_v2017.03_4.9.11_1.0.0_ga
> imx_v2017.03_4.9.123_imx8mm_ga
> imx_v2017.03_4.9.51_imx8_beta1
> imx_v2017.03_4.9.51_imx8_beta2
> imx_v2017.03_4.9.51_imx8m_beta
> imx_v2017.03_4.9.51_imx8m_ga
> imx_v2017.03_4.9.88_2.0.0_ga
> imx_v2017.03_4.9.88_imx8mm_alpha
> imx_v2017.03_4.9.88_imx8qxp_beta2
> imx_v2018.03_4.14.62_1.0.0_beta
> imx_v2018.03_4.14.78_1.0.0_ga
> imx_v2018.03_4.14.98_2.0.0_ga
> imx_v2018.03_4.14.98_2.1.0
> imx_v2018.03_4.14.98_2.2.0
> imx_v2018.03_4.14.98_2.3.0
> imx_v2019.04_4.19.35_1.0.0
> imx_v2019.04_4.19.35_1.1.0
> imx_v2019.04_5.4.3_2.0.0
> imx_v2020.04_5.4.24_2.1.0
> imx_v2020.04_5.4.47_2.2.0
> imx_v2020.04_5.4.70_2.3.0
> lf-5.4.y_v2019.04
> lf_v2020.04
> lf_v2021.04
> lf_v2022.04
> lf_v2023.04
> master
> nxp/imx_3.14.38_6ul_engr
> nxp/imx_v2009.08
> nxp/imx_v2009.08_1.1.0
> nxp/imx_v2009.08_10.04.01
> nxp/imx_v2009.08_10.05.02
> nxp/imx_v2009.08_10.07.11
> nxp/imx_v2009.08_10.10.01
> nxp/imx_v2009.08_10.11.01
> nxp/imx_v2009.08_10.12.01
> nxp/imx_v2009.08_11.04.01
> nxp/imx_v2009.08_11.05.01
> nxp/imx_v2009.08_11.09.01
> nxp/imx_v2009.08_11.11.01
> nxp/imx_v2009.08_12.01.01
> nxp/imx_v2009.08_12.02.01
> nxp/imx_v2009.08_12.09.01
> nxp/imx_v2009.08_12.10.02
> nxp/imx_v2009.08_3.0.0
> nxp/imx_v2009.08_3.0.35_4.0.0
> nxp/imx_v2009.08_3.0.35_4.1.0
> nxp/imx_v2009.08_r13.4.y
> nxp/imx_v2013.04_3.10.17_1.0.0_beta
> nxp/imx_v2013.04_3.10.17_1.0.0_ga
> nxp/imx_v2013.04_3.10.31_1.1.0_alpha
> nxp/imx_v2013.04_3.10.9_1.0.0_alpha
> nxp/imx_v2013.04_3.5.7_1.0.0_alpha
> nxp/imx_v2014.04_3.10.31_1.1.0_beta
> nxp/imx_v2014.04_3.10.31_1.1.0_beta2
> nxp/imx_v2014.04_3.10.53_1.1.0_ga
> nxp/imx_v2014.04_3.14.28_1.0.0_ga
> nxp/imx_v2014.04_3.14.28_7d_alpha
> nxp/imx_v2014.04_3.14.38_6qp_beta
> nxp/imx_v2014.04_kk4.4.3_2.y
> nxp/imx_v2015.04
> nxp/imx_v2015.04_3.14.38_6qp_ga
> nxp/imx_v2015.04_3.14.38_6ul7d_beta
> nxp/imx_v2015.04_3.14.38_6ul_ga
> nxp/imx_v2015.04_3.14.52_1.1.0_ga
> nxp/imx_v2015.04_4.1.15_1.0.0_ga
> nxp/imx_v2015.04_brillo
> nxp/imx_v2016.03_4.1.15_2.0.0_ga
> nxp/imx_v2016.03_4.1.30_7ulp_alpha
> nxp/imx_v2016.03_4.1.33_7ulp_beta
> nxp/imx_v2017.03_4.9.11_1.0.0_ga
> nxp/maddev-imx-android-r10.3
> nxp/maddev-imx-android-r13.2
> nxp/master
> nxp/scm-imx_v2016.03_4.1.15_2.0.0_ga
> u-boot/master
> u-boot/next
> u-boot/origin
> u-boot/u-boot-2009.11.y
> u-boot/u-boot-2013.01.y
> u-boot/u-boot-2016.09.y

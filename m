Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FB5CE95A61
	for <u-boot@archiver.kernel.org>; Sat,  7 Oct 2023 12:56:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 780E586406;
	Sat,  7 Oct 2023 14:56:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CnR18koO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA1F6863C8; Sat,  7 Oct 2023 14:56:01 +0200 (CEST)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com
 [IPv6:2607:f8b0:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 327CF86406
 for <u-boot@lists.denx.de>; Sat,  7 Oct 2023 14:55:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1c76ef40e84so5774135ad.0
 for <u-boot@lists.denx.de>; Sat, 07 Oct 2023 05:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696683355; x=1697288155; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LONG90cNZEY8KWaIwvzjBCgfwPd/U1RPeQ+jy8q2cn4=;
 b=CnR18koOk7NZfOe68SMUO122cP1+sVvRWeko4J4/574zR+kvzQDsBlYELv1f03hv6a
 hCnw30W/Yen7GpNyT32ywBgIqtBAVKbgoQe6vQRLy+K828Q/igB6wBtYRfKjb2YPmLB3
 djlAR8u68/3Dq8rGYdtscmASSMBxxEI9XUQphd0Ygx2PQL2mNA8hCPnab1/zP1dnACdc
 XhcCoUVyz6TIc9QIaTu9/a/c6whwqPOS3V79fNMIQm3dXlaw9qNq0E/ID/aYuOOU5CtQ
 rWyvURe/w+6oJCBDGR4lNetFxYwVXMjFyqnbAM6h1A1JGebL7VfLXudHwTADf5chE9vB
 1Rxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696683355; x=1697288155;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LONG90cNZEY8KWaIwvzjBCgfwPd/U1RPeQ+jy8q2cn4=;
 b=qhAC1w4O3HGq+vTS7XUXH2QMaGfClvfRFTp0d3+9jhcJnbMYw0qf+YLUK0x/5Y21Aw
 JU5r4j3fBTqYHJYD6BuDJniJV6eGikN96ctL1OhlmO+tjBcfBxU22cJv/+Oey/h8KoPq
 fJCNxiDhRQ74yAUF9oFWuYz7dzDTbMeWYj4Jd8ZNqcRv5CibZcAUUyjsW0uGZynhMdRj
 9JIF9207jGMQWSPW3pKNcaGltNatl0rkW0ZUbK5GU8pUn9LPJ61CKq+z71Tq2o/p8tCq
 7PJJtsRZQMtoltw55YfTNu5OIC4xtDH2irn71gHgBbI0HV2ADVE2jeBh+YQ9fAkKOcdD
 RLDA==
X-Gm-Message-State: AOJu0Yxlamsep2AoBBjly0SBZqsOf7MozFU7VViBeOOIBQe11Qvx6+6P
 DzuxI02nquw/jw2ClyWPw3ZyFbTcs3GE43JWYo8=
X-Google-Smtp-Source: AGHT+IEpkjy5zoQ/4LYlJ9mi8QKRCbpkSML6vTxGTvfzjHko5Y18qDvnLyvtNp9ZkJDTzU7PjMW+Ax56hNxv18eSaLM=
X-Received: by 2002:a05:6a20:3d04:b0:13d:d5bd:758f with SMTP id
 y4-20020a056a203d0400b0013dd5bd758fmr12588912pzi.6.1696683354936; Sat, 07 Oct
 2023 05:55:54 -0700 (PDT)
MIME-Version: 1.0
References: <20231004090810.28923-1-sebastien.szymanski@armadeus.com>
 <20231004090810.28923-3-sebastien.szymanski@armadeus.com>
In-Reply-To: <20231004090810.28923-3-sebastien.szymanski@armadeus.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 7 Oct 2023 09:55:43 -0300
Message-ID: <CAOMZO5BX-CQ8N36i+zfyYfgVWEfFs5Ci=MZ+ahHuSQn+iLHkYw@mail.gmail.com>
Subject: Re: [PATCH 2/2] dm: adc: imx93-adc depends on ADC (fix boot)
To: =?UTF-8?Q?S=C3=A9bastien_Szymanski?= <sebastien.szymanski@armadeus.com>
Cc: Stefano Babic <sbabic@denx.de>, Peng Fan <peng.fan@nxp.com>, 
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de
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

On Wed, Oct 4, 2023 at 6:09=E2=80=AFAM S=C3=A9bastien Szymanski
<sebastien.szymanski@armadeus.com> wrote:
>
> The i.MX93 11x11 EVK fails to boot with following error:
>
>  Model: NXP i.MX93 11X11 EVK board
>  DRAM:  2 GiB
>  Error binding driver 'imx93-adc': -96
>  Some drivers failed to bind
>  Error binding driver 'simple_bus': -96
>  Some drivers failed to bind
>  Error binding driver 'simple_bus': -96
>  Some drivers failed to bind
>  initcall sequence 00000000fffb8f28 failed at call 000000008021e0d4 (err=
=3D-96)
>  ### ERROR ### Please RESET the board ###
>
> That's because since commit e7ff54d96303 ("imx93_evk: defconfig: add adc
> support") CONFIG_ADC_IMX93 is enabled but CONFIG_ADC is not.
> Fix this by enabling CONFIG_ADC in imx93_11x11_evk_defconfig.
>
> Make sure this situation won't happen again in future i.MX93 defconfig by
> making CONFIG_ADC_IMX93 depend on CONFIG_ADC.
>
> Signed-off-by: S=C3=A9bastien Szymanski <sebastien.szymanski@armadeus.com=
>

Reviewed-by: Fabio Estevam <festevam@gmail.com>

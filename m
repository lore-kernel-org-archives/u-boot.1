Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80382C83F09
	for <u-boot@archiver.kernel.org>; Fri,  4 Jul 2025 16:40:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D9D7E8277D;
	Fri,  4 Jul 2025 18:40:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Vj++QCKC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 48FA782A76; Fri,  4 Jul 2025 18:40:55 +0200 (CEST)
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com
 [IPv6:2a00:1450:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 454A6803DF
 for <u-boot@lists.denx.de>; Fri,  4 Jul 2025 18:40:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-32aabfd3813so11717721fa.3
 for <u-boot@lists.denx.de>; Fri, 04 Jul 2025 09:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751647252; x=1752252052; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jd8LrpA4piuYSvzc/2IwHwAL7PfVVjolp9tjBALptlQ=;
 b=Vj++QCKC6ALf/LKozEPdnTmloKDot5q/HuERjdxK0BKc2DtyQWzlck/Y1tdxAAf5xH
 AP8QfbQitqfKz+pUixQKpRTX4bRCn7uQVsjcYNW+EywDGspt1cEd5Bc842iuJ3uuF2E9
 PZ20jkttweRcXZ4uVkFxUQksb+YHoMlHeJ7ZGaj2hEj7ZUtzSk3OHSd2lMMxlAxacEoX
 VD2z3cpevB+4ZJhIGIW4OBYIWEzQJMkqFmNhTOLkaB7D7+9x0qhHsWGC4AMM/s4Pn01r
 XAPeuUMZy9PZSEacRabh/c2ikdAsLEfsqGKav8eI0eUC3saRJEi+MAXUpr4S5CfL0PB2
 PgBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751647252; x=1752252052;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jd8LrpA4piuYSvzc/2IwHwAL7PfVVjolp9tjBALptlQ=;
 b=h3Zbf9NIBOYSktv220eBLQOxlxgUuk1nQoS/c1/XfWoeuphjG7Eiib+WD4vN9lSkHi
 u86vYmFa6vHzCB2sB+uuCIK1ePNQKr/e6hfoJRsMU3KUrofejjbskHj939YidOOjYtVm
 kOAQcuf6iq/Cel45W38yhtxh7tIKk00T6zL/7+7chZ9l1tyMqr3TH/k3c5QqhRpMBoQS
 gE/1KgDBaZrAZmnL7Jb4gE9bO4rR0vKEAKfg27ZFHll14SZ/GwLUXFdwxNPfBv1fGK8E
 9/O2GchecEgKh0PjvHXACRmGNWKR6lvpVIeMD3U8HQ6io14J2mNiYdDmeIesM+OOnShi
 CLxg==
X-Gm-Message-State: AOJu0YwZizFs7IyPeIDFQQu8aNbjUIk0bNzB8EAj2a2l6rL0wAwXzpf4
 xLKAcNOqqqBm+2sLjVGrbUutErMXuObH/5DUkcur15/S3yv3LnyKj0RKIzDTOUW/rcgf4Gt05HS
 VtQjRgndA4gONdcRCiwrzdxdgd1kmq3s=
X-Gm-Gg: ASbGncsFERTE8zj0L23+8582Gy68PPP4ds65F0T+ZR/JUaDF8VsnFnSF85Xzw2BuQ/P
 mzYbAQ9Bf1qjWUqTM5yhBgfPytD34/Y5TtMINW1CuHXXFtPy40QAy0jgjwRCna7+IGFOelaFou5
 m3vU3+apkyoLgighPgS2bAvLm2oxrJP/hKIh66g9moO72P/noU7soRDEnN8sTn9jF4wVR4UFGrR
 Q==
X-Google-Smtp-Source: AGHT+IELMnV/78KNXPSGLTyb72NEdt/SsFVDme8shS3aBYc61coH6f7fENHfDIcgaZ6kMkIMn9Vd07xqNAUaxUsslR0=
X-Received: by 2002:a2e:9181:0:b0:32a:de79:2ca with SMTP id
 38308e7fff4ca-32e5f57ca68mr7276911fa.11.1751647252204; Fri, 04 Jul 2025
 09:40:52 -0700 (PDT)
MIME-Version: 1.0
References: <20250704144022.3946416-1-festevam@gmail.com>
 <20250704155611.GH6424@bill-the-cat>
In-Reply-To: <20250704155611.GH6424@bill-the-cat>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 4 Jul 2025 13:40:40 -0300
X-Gm-Features: Ac12FXyrKrdGP_5-WKrONDs5psfJ4WAH3P-n8qc5iZ38nzf9hJtFyeV_ZUrtOxA
Message-ID: <CAOMZO5Ck=ufscXJ8KFyy+Ee-fPJNtHFKTFMCGdQ8t0uWVbFfHg@mail.gmail.com>
Subject: Re: [PATCH v2] mx6sabresd: Reduce U-Boot proper size to fix boot
 regression
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, jerome.forissier@linaro.org, otavio@ossystems.com.br,
 michael@amarulasolutions.com, uboot-imx@nxp.com
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

On Fri, Jul 4, 2025 at 12:56=E2=80=AFPM Tom Rini <trini@konsulko.com> wrote=
:
>
> On Fri, Jul 04, 2025 at 11:40:22AM -0300, Fabio Estevam wrote:
>
> > The mx6sabresd U-Boot proper binary size has grown beyond the
> > CONFIG_BOARD_SIZE_LIMIT.
>
> So, is CONFIG_BOARD_SIZE_LIMIT set incorrectly then and needs to be
> lowered?

The current CONFIG_BOARD_SIZE_LIMIT is 715766.

This value is CONFIG_ENV_OFFSET (0xC0000) - the offset for U-Boot
proper (69k) =3D 786432 =E2=88=92 69=C3=971024 =3D 715776.

The calculation itself is correct.

The first issue: CI does not report a build failure. However, my local
build reports:

u-boot.img exceeds file size limit:
  limit:  0xaebf6 bytes
  actual: 0xaed70 bytes
  excess: 0x17a bytes
make: *** [Makefile:1501: u-boot.img] Error 1
make: *** Deleting file 'u-boot.img'
make: *** Waiting for unfinished jobs....
u-boot-dtb.img exceeds file size limit:
  limit:  0xaebf6 bytes
  actual: 0xaed70 bytes
  excess: 0x17a bytes
make: *** [Makefile:1501: u-boot-dtb.img] Error 1
make: *** Deleting file 'u-boot-dtb.img'

The second issue is that even if I remove the
CONFIG_HAS_BOARD_SIZE_LIMIT/CONFIG_BOARD_SIZE_LIMIT, it builds, but
fails to boot like this:

U-Boot SPL 2025.07-rc5-00012-g7027b445cc0b-dirty (Jul 04 2025 - 13:22:16 -0=
300)
Trying to boot from MMC1

This boot failure is related to the initcall series.

To avoid the mx6abresd boot regression and play safe for the upcoming
2025.07, I'm more inclined to go with the previous patch version that
increases CONFIG_BOARD_SIZE_LIMIT.

Jerome said he is working on a better fix, which reduces the size by
1702 bytes for sabresd.

Having CONFIG_BOARD_SIZE_LIMIT with too low a headroom may cause a
problem where, on some build systems, such as U-Boot CI, the build
succeeds, while others, like my local build, fail.

Let's provide more CONFIG_BOARD_SIZE_LIMIT headroom to avoid this
situation from happening again.

If you agree, feel free to pick v1.

Thanks

Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E1D6C46CA2
	for <u-boot@archiver.kernel.org>; Sat, 16 Dec 2023 10:49:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 30A6387A7B;
	Sat, 16 Dec 2023 11:49:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MCAjQPFP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B501487A10; Sat, 16 Dec 2023 11:49:28 +0100 (CET)
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com
 [IPv6:2607:f8b0:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F47A87B4D
 for <u-boot@lists.denx.de>; Sat, 16 Dec 2023 11:49:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-5c6910e93e3so370654a12.1
 for <u-boot@lists.denx.de>; Sat, 16 Dec 2023 02:49:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702723760; x=1703328560; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J0t8t0FCQrbY4KfO+mRU5jnh/vaWzjqi+WnpvR36NrI=;
 b=MCAjQPFPB+DZ9AUgbCGhKByLNrN8/IAORZlxhyJxh5lIcHtrJ52hcn9GVxKBUReVsQ
 S51XrGxywo5eAyxvtvJwlZE7ZwNcTkLw7qIHnANmrGkn8lWobKbKsvJeMfpDbUbbh2tV
 B7TuogKKusFB2p9S2uM0GnxIOxKdMTp5CG+rkmzIVmbsXvmRCTKL3G2/z0k1QCsnqm5C
 wHcuOBwEE4jon9r6EgiNUN033i7Ab0zY6moVDidp3HKCYCCnx5D46PmBxZl558e4I1lw
 59U+zn3d6Z1Bp08Tgh4Vp5d0KqD9FpbDqP69DiG4drq6Y9TlqOODDtve3CHaK5KLef0S
 c+/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702723760; x=1703328560;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J0t8t0FCQrbY4KfO+mRU5jnh/vaWzjqi+WnpvR36NrI=;
 b=wFInUeA4MJawEGEFL7iLELACZ9m8V2qQ2NXFcf+6X9uCAkCHwYr7xmmhYzJjQgjqNu
 afL5fAZFr/aarSQE7c6o6poy7dgBlUHzzvo2SmLUW/aQvf2vNgyKlZ1MZhaYSAE2orq9
 jvsGsOlxxfp0IH0crdrcaBzGq3jjukZo7du/Fdl/50RhHxPKahlF61NknR0u1RC1+Spt
 F6ZZ6EkhN/MJzLsCw53t6decEuhi7uWS9nPoiPXSPguX0Oprj1eah+8h9fr8lhH1IRC7
 9lxvm+kJ6LEEi1+vVXFkxPuLECOR+aOHnT6Kv03MCLbHRePtoe/BriAjtkbwK+XZaPcm
 O4rA==
X-Gm-Message-State: AOJu0Yw4WEhngSrZsQDWh+5nqWAN1UO8w/obTGfznKSZBV47EvlhxY9O
 JTyJTwOKz1G4um46nuHtUsjxr16qQI7HW03hx7m6FTdo
X-Google-Smtp-Source: AGHT+IGGVK6VxbakB3O60/2nSvcV2Rd3qCdsQKv8wYPwYY7hVuYE/9i9j4JgUAw7EUQTmpPD2LiidFC8OchKDwIatks=
X-Received: by 2002:a05:6a00:2d9e:b0:68e:2fd4:288a with SMTP id
 fb30-20020a056a002d9e00b0068e2fd4288amr27799542pfb.3.1702723759843; Sat, 16
 Dec 2023 02:49:19 -0800 (PST)
MIME-Version: 1.0
References: <20231214162543.1200276-1-tharvey@gateworks.com>
In-Reply-To: <20231214162543.1200276-1-tharvey@gateworks.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 16 Dec 2023 07:49:07 -0300
Message-ID: <CAOMZO5B14b9f=Tt8rpru-Y41Yd5MjLyZPY+eQ_SvBCdYYzZvZg@mail.gmail.com>
Subject: Re: [PATCH 1/2] configs: imx8m{m, n,
 p}_venice_defconfig: add arch_misc_init
To: Tim Harvey <tharvey@gateworks.com>
Cc: u-boot@lists.denx.de, Stefano Babic <sbabic@denx.de>, 
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>
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

On Thu, Dec 14, 2023 at 1:25=E2=80=AFPM Tim Harvey <tharvey@gateworks.com> =
wrote:
>
> Enable call to arch_misc_init in order to probe the CAAM driver.
>
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>

Applied only this one to u-boot-imx next, thanks.

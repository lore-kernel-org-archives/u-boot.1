Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5054C25B75
	for <u-boot@archiver.kernel.org>; Mon,  3 Jun 2024 16:45:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5804A8835E;
	Mon,  3 Jun 2024 18:44:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bdTY5WV0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D84598835E; Mon,  3 Jun 2024 18:44:57 +0200 (CEST)
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com
 [IPv6:2607:f8b0:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B683588180
 for <u-boot@lists.denx.de>; Mon,  3 Jun 2024 18:44:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-7027ddf3324so40402b3a.2
 for <u-boot@lists.denx.de>; Mon, 03 Jun 2024 09:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717433093; x=1718037893; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qGsQ0E2aN0IWVkvBKV+egGFoIRno4GL1KDYa6ZeOxkA=;
 b=bdTY5WV0kkNeINbbjVRvHcPl6ifKyqgyGI8tas6r5IusEPlaXSLlJwMK8nM5zISzyf
 1Qq6z4iCUC5KYfL8RyYkuyFtx0gsZcrrMpWTTkGuDhtKTQz9/2GSDQ8orH2IZaJ/aUWv
 SUEaVZa2v5wZBYHQAVmY0hptU0wT/Q1rE62HvB0PAe6EjYB9sElSB2kgUvVoYjqiDDfx
 cB4gcbAQbK8/c6FhXMiBO4Hc9smxaq41TbhUzHt87wK4FKhVwUeEXIzIiCmsxTMoPtI6
 LXJDKSV8FoC6+x725XkaZJz1dT0IFq2PnsTKWvqfQS/nzpA+eO23DHQce+gJ51fqNRgQ
 a88A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717433093; x=1718037893;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qGsQ0E2aN0IWVkvBKV+egGFoIRno4GL1KDYa6ZeOxkA=;
 b=gukYgdn1eM07U8wezIjIqAxmFEL3XAjgBejHAcOkivDGbAAwsXvKsk29S7ulSWyvEb
 Pj2EE+VaOXE+mA/5NwHXNxG3iuamAYQa7tU1DMr17B1NTKhi4sikROWNktyHM7jhBVUO
 Dztf8U0obW2ZPi6xELnDPqoc9jNqoT+7GH66po5VIuz7pyGKuTBWjqVYGQ9U3iWyFpMU
 b01c1FX1uN8T6nUlSpedFWlCBh3I2B0YnyCOsag7xhPTqHg3M4FgSRtMj11bknn7X0iZ
 XtQFutksXg2UPFk3q++vpGAwbauV04vs9FtKtHy07r+rLcGWeW7eDczcArDrW73yeKGy
 yNzg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUu61bwUCJPiTqKKnrqYmL9UP1nVIl0cvFqO3ziN805GeM58oGxrFAJFLqHSwNwd0YHykZ9D/eU4jr/tuXeqzi6AP9OmA==
X-Gm-Message-State: AOJu0Yx0zJ7ANFNU72+Ba/D8m1mIrmOj2pNBea2zKZyI2ND64GfGTIci
 wHGp8Nj50OHi1v0xyFczionafoKSmhjCYyuZSuoH39b/YSte161AJTFPUIpmggHIYpfHiiLVD6I
 J8+mCrt0uoY1q29Xqd15NELz+aA4=
X-Google-Smtp-Source: AGHT+IGLrSxk42X1Mb/l9XB/Bv0ivsh/5sOQYGjq8T+35gDiQjPrU3uCzMqv8Ny6TT6Es1XQvdVBtRX8EcrfA5UiLr8=
X-Received: by 2002:a05:6a00:8b18:b0:702:2e30:e8bd with SMTP id
 d2e1a72fcca58-702477b6bc6mr9904268b3a.1.1717433093221; Mon, 03 Jun 2024
 09:44:53 -0700 (PDT)
MIME-Version: 1.0
References: <20240528-phytec_imx8_of_upstream-v1-0-c884c1ddca5f@phytec.de>
In-Reply-To: <20240528-phytec_imx8_of_upstream-v1-0-c884c1ddca5f@phytec.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 3 Jun 2024 13:44:42 -0300
Message-ID: <CAOMZO5D+7+O9SYHXWg9YJR1dZw_=UuXO5Zbrb6R1CMFv889abA@mail.gmail.com>
Subject: Re: [PATCH 0/2] Migrate PHYTEC imx8m boards to OF_UPSTREAM
To: Yannic Moog <y.moog@phytec.de>
Cc: Teresa Remmet <T.Remmet@phytec.de>, Stefano Babic <sbabic@denx.de>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de,
 upstream@lists.phytec.de
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

On Tue, May 28, 2024 at 8:25=E2=80=AFAM Yannic Moog <y.moog@phytec.de> wrot=
e:
>
> - update MAINTAINERS
> - delete synced dt files
> - imply OF_UPSTREAM
> - update default device tree

Applied all to u-boot-imx/next, thanks.

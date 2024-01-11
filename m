Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD8AFC4707B
	for <u-boot@archiver.kernel.org>; Thu, 11 Jan 2024 11:17:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 27B73877FD;
	Thu, 11 Jan 2024 12:17:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lUFhvCqq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D02B8786C; Thu, 11 Jan 2024 12:16:59 +0100 (CET)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com
 [IPv6:2607:f8b0:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6ADAB8753C
 for <u-boot@lists.denx.de>; Thu, 11 Jan 2024 12:16:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1d54c7ef801so8153015ad.0
 for <u-boot@lists.denx.de>; Thu, 11 Jan 2024 03:16:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704971810; x=1705576610; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PVQrk1PmBnnvDstidvZiLrSOCNC5TEGIBJBK9HGWyGc=;
 b=lUFhvCqq9Bk1xDTli58gvsJtCCux3a2CzbnhV7hf1S94fQEl9RSNUbTM2TucvIT8Gm
 5UHtAU1TyRnQ6YsZpNgE7fHKvPixwZKo9ddJVfODaCs8h20pjBrW5rCt/5f9kaqcRxLl
 06G5w+61J1dZMTZg7GdBl6kVHNCwTuLT2qXuBZ5MNH7RKMcq5F2q6Bv6434b7RgGL4qu
 pK1F2N3hkrVCDdcXjNFU+7cjrMpzpc/wlo/eK3bZdxty4uO6xVocRDiiCeM5QL3vcGfu
 1B4tym5KFwgy5G5OE9aLcyJwe7+araj7tbQrAmVqgHW/CWJ/hO9kh1tzLHbL21QUwz+0
 w7Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704971810; x=1705576610;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PVQrk1PmBnnvDstidvZiLrSOCNC5TEGIBJBK9HGWyGc=;
 b=TX8S4YjTqC3wdMXSHF59+04XO7x59W+XsofAk0WMldi8hLyYl1mWlLjZbw80jKw6JP
 W38HVlohWLvidFErLB06njHG6GtFx3YgZ5LmGuBy4IBZ1UlGaB/1sW3OwrroKNlap7fh
 S+kiowm0ZOkosYTp/TCmYyNY1Jiqqa7ThUGcTWIRgVduokSMtRurpbzEO8T11lBhP34E
 BmzzKpPbGlNQc6qfjraDrlkDlRqsKoFdBPc/KGmsCF6I8guEJtYcs2SXDYpzQuGnsoy1
 egD0CUT7JDtlyg+weedzUZuIZQ8jL5XLHpXoft7BGNQI19PUuAMp29PeZMLKuZw8WLLN
 ai3Q==
X-Gm-Message-State: AOJu0YynIJnQdMMTjkGsvO8m40O/R6ubZ4e6534tpY/S8ej30Ht8C7wT
 y6+SOtrkdGs/tJs2DXG385NwycfmCJSPqERwpP4=
X-Google-Smtp-Source: AGHT+IGbBwSDvMFurpTpnxtS3J7t8ZNuYYCQlpuYx9Tav+p0hFGwNcTARh3Wfi6Qx3jBzBQpzTWYyBuMePJIQ83zDOY=
X-Received: by 2002:a05:6a21:3281:b0:199:7f36:d8c1 with SMTP id
 yt1-20020a056a21328100b001997f36d8c1mr1929561pzb.2.1704971809689; Thu, 11 Jan
 2024 03:16:49 -0800 (PST)
MIME-Version: 1.0
References: <20240111110611.2051821-1-lukma@denx.de>
In-Reply-To: <20240111110611.2051821-1-lukma@denx.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 11 Jan 2024 08:16:38 -0300
Message-ID: <CAOMZO5CtLSkRPb-3RvS77za-y5zwkBirH4gGE_kwqLNao9bdSg@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] arm: xea: Move XEA's environment variables from
 xea.h to xea.env
To: Lukasz Majewski <lukma@denx.de>
Cc: Stefano Babic <sbabic@denx.de>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de, NXP u-boot <uboot-imx@nxp.com>
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

Hi Lukasz,

On Thu, Jan 11, 2024 at 8:06=E2=80=AFAM Lukasz Majewski <lukma@denx.de> wro=
te:

> +serverip=3D10.8.217.79
> +nfs_serverip=3D10.8.218.113
> +gatewayip=3D10.8.209.250

These IP addresses should not be hardcoded here.

They were not present in xea.h originally. Please remove them.

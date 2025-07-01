Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BC09C83030
	for <u-boot@archiver.kernel.org>; Tue,  1 Jul 2025 01:43:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E230C81FEE;
	Tue,  1 Jul 2025 03:43:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KH3HxxQl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A8FF81FFC; Tue,  1 Jul 2025 03:43:49 +0200 (CEST)
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com
 [IPv6:2a00:1450:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 46EC98006D
 for <u-boot@lists.denx.de>; Tue,  1 Jul 2025 03:43:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-553b6a349ccso3070971e87.0
 for <u-boot@lists.denx.de>; Mon, 30 Jun 2025 18:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751334224; x=1751939024; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jlzB1hkvTVLfhAaBlvGgcf1G0qNPcqu9TmKAmWAJtMY=;
 b=KH3HxxQl8JLQ6IerSglyguqCjQgumHMAEt43DVS37sO7AHLdu1BmL3jSGFC6b3CgqD
 PZWMDBKXhP8h9HZ7eBM+zFOJO02xDhc3UfCsoLY5ihXOQvYp2RfXa847gpe1KXxQvwWZ
 ykptngF10alg4WuL6uBtU5J7Wl6OTGw197uQUt/rVXxCAeEaeAVJr8C7EUZwyGV1IxIQ
 8Gg5B1hJdjnsxbOdTmuQaHuh28zLdB6LkLJYh4F+jC1X0PeJTlfJ8RMgvfonBp33T82H
 LFnYOLabo4U8IMMnW2EKuTl+aNSR36tSgNioJkLrk+IqJ08LP0SHHooBePWUM2veae2F
 UIIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751334224; x=1751939024;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jlzB1hkvTVLfhAaBlvGgcf1G0qNPcqu9TmKAmWAJtMY=;
 b=e9GcUn0kGHX3zMrApf1wyzXPXkEP6Qg0+pzoe4fg09cTem0P7cHv+ypYKMgQzaejcQ
 4KzJQPc2J19yUF9XuDY8PNSVZ9V+uYy5+pi6fbGC4B65fCz+CxqbSSSznzUCIPmchLyi
 gQ/Wi+/DSbrXJvRNRGT8h23urslf+KGrIUZ+lHd9SqGz/dB6L5gGTcijegfpQpaOgWTs
 3hRiWd77nXYHpZ1GiDf1w74FtN7KX2hTUwFwk3j9Wc5GNto+wBVxoJ8pF+VJNGzrgk6/
 Py3Ci49h9hLc4JYONMcftL38uGLUhd6qCkE/6muqSlHLKSm3G4wk8GzRqsUQPGWacN9H
 h6dQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVuoZyAIiuvaCkE3z+T0hIbtXVhvLHT4vQMJgc265S4YXZpT+EwnZ0GAocSPVz635UuAL17FvA=@lists.denx.de
X-Gm-Message-State: AOJu0Yxugx+Un66AhwDI47nzB27mA/2eO92zZxtK+8O52+783wG6V/9A
 oBa8qp+bf5n9r2AiTyx+SV+oKSagsrLFB1YXdZau7da6rUV8/llWDRvOkcZZltETnJ+7EHHlhKW
 AVa5HbeRv8sHkd4SEHpwXXYNnHyphLSsYew==
X-Gm-Gg: ASbGnctVNJ4MBZZMKeGDrGnHa4R7TqijnXnVrtzI/mxsvBQ40MAtCovGe50qA73cCrc
 oT3pCVDg91c6qg/iHqdRdE+mzKRfvYWKgm5c5OFvLRAc8JJS6/HP/yDSL3CURmnmNc1tfBRPe57
 6E5hzEm+MXR4p7GvLClLHSw96LoJkrztCVudAvNF1Tf/7kcYelJeWunCdTPRlHxsAdQTcLMEq3u
 dM=
X-Google-Smtp-Source: AGHT+IHjL1JgOADad5r9XdhPHNAnfAmKCZr8zaprymMrs9OMTMXhZC7MAdSG77NFkH2NnNDgD2W3S7Hu51PkhDamd+U=
X-Received: by 2002:a05:6512:2388:b0:553:3383:6766 with SMTP id
 2adb3069b0e04-5550b829399mr4416267e87.19.1751334224236; Mon, 30 Jun 2025
 18:43:44 -0700 (PDT)
MIME-Version: 1.0
References: <20250623-sr-v2-0-e97fc53f0f8d@nxp.com>
In-Reply-To: <20250623-sr-v2-0-e97fc53f0f8d@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 30 Jun 2025 22:43:32 -0300
X-Gm-Features: Ac12FXzTpYX2a6PfNwf6NEiVIp6Pdj14cYAialvwM2-6kE8TrkF4ptephRklCnY
Message-ID: <CAOMZO5Brthfbh8M3iYPSXteTxT-tZ5Mvk-w8i3qHoxUKv=LpVg@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] imx: Support capsule update
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Stefano Babic <sbabic@nabladev.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 Peng Fan <peng.fan@nxp.com>
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

On Mon, Jun 23, 2025 at 2:52=E2=80=AFAM Peng Fan (OSS) <peng.fan@oss.nxp.co=
m> wrote:
>
> Support capsule update for i.MX8M-EVK and i.MX93-11x11-EVK.
> Currently tested on i.MX8MM/N/P-EVK and i.MX93-11x11-EVK.
> Capsule authentication not enabled as of now, this is on TODO list.
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Applied the series to u-boot-imx/next, thanks.

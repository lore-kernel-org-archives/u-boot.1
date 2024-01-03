Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27DBAC3DA6E
	for <u-boot@archiver.kernel.org>; Wed,  3 Jan 2024 19:32:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 987A38780F;
	Wed,  3 Jan 2024 20:32:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Xt6+Try0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 667118783C; Wed,  3 Jan 2024 20:32:41 +0100 (CET)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com
 [IPv6:2607:f8b0:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB8F88783B
 for <u-boot@lists.denx.de>; Wed,  3 Jan 2024 20:32:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1d4c91a9adcso2048315ad.1
 for <u-boot@lists.denx.de>; Wed, 03 Jan 2024 11:32:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704310355; x=1704915155; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OqQG+00V1H/fHgLNVJ35UKswgXZqcFBQVtNLk97/VNA=;
 b=Xt6+Try0fBiTGGAOO6jN7yJY90l6uTOHmaKJAtOqwF33b6yoDFW/fDIUZhCAsRFqAv
 zPzTHo+NqliUgvL/cXC/RG8S+LYdaVmJB/0+ZzAu13ILdLwqqJrTq1B5Id4y7q4eVFBE
 f/31Iut6P2zOJuchlsr3QFiwrjQEzIMD7CwZpRXC5/ukn/LFnlPfI03lN7CBik43z4mX
 tizl1xM/tkShQBxjC1EXbb5cSW2hBku5CHPvXYotpVJmf1R/nUjY0U2w4tB3b7L/s+ES
 0syyb75ATlWrr+Sfc8NUiUByr/Cg+DImN1Nlzt2dc/LaJHER9LFWKpbkfsK+SURvrH1w
 Zd5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704310355; x=1704915155;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OqQG+00V1H/fHgLNVJ35UKswgXZqcFBQVtNLk97/VNA=;
 b=HrfuNi21S2zxaZs8EuYlL7GWESXTKwLhZ4ppwlOw/eN4uDJvbD0S2RaCTMEY7m/IO4
 HcIJHVSbaSLz23evraKte0d6k+3JriyqweMpQGw7Pk7aDlLP/YlFJTWSp/mZVNC82jLk
 /7OXqCWFRFNPqDS8pRT9/KBAH27oo6wlnAZMYKaKcTM29WCEfcC+cBxW8/Y8g4GR8S6N
 TQU9yG8WjfefLbyiU3fvdBkue2ZWkOc4+eRFAuUpmQ+DVIx1gm10nYih3L6zU0/8WDyb
 6BzuBhpaan4u/Tp9J0+kD0lwJCVKb1w4QcSagYAnWwuqxnUmxdJk6i4PxRG4Uk9fxQyp
 1F9w==
X-Gm-Message-State: AOJu0Yw8pr7sOst1P4jm8H3QBTd8jn9hvbWZEQkxkvI+G1RPwszgvp1G
 RDmrcA3kdhFk/ixOQhYx5CpsT9/9IcJsWW11bq0=
X-Google-Smtp-Source: AGHT+IH//n8Gh6OigaShDCWlYMErzi5+lMR+yHr1KYDsWeICxsAc6cl3FdSMZbQ9E5oWZwQIoT2LnCkLE4R6atq4Dkg=
X-Received: by 2002:a17:90a:e0f:b0:28c:5a9:de71 with SMTP id
 v15-20020a17090a0e0f00b0028c05a9de71mr29034395pje.4.1704310355563; Wed, 03
 Jan 2024 11:32:35 -0800 (PST)
MIME-Version: 1.0
References: <20231229111701.10696-1-othacehe@gnu.org>
 <20231229111701.10696-3-othacehe@gnu.org>
In-Reply-To: <20231229111701.10696-3-othacehe@gnu.org>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 3 Jan 2024 16:32:23 -0300
Message-ID: <CAOMZO5D6KMp1qRvJgETSChsinv5eRMxXUT5x3uvYri6isxNW-A@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] mach-imx: Add i.MX93 binman support.
To: Mathieu Othacehe <othacehe@gnu.org>
Cc: Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>,
 Stefano Babic <sbabic@denx.de>, 
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>,
 Mathieu Othacehe <m.othacehe@gmail.com>, u-boot@lists.denx.de
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

On Fri, Dec 29, 2023 at 8:17=E2=80=AFAM Mathieu Othacehe <othacehe@gnu.org>=
 wrote:
>
> From: Mathieu Othacehe <m.othacehe@gmail.com>
>
> Add dedicated Makefile targets for the i.MX93 and a new imx93-u-boot.dtsi
> device-tree to create binman images.
>
> Signed-off-by: Mathieu Othacehe <m.othacehe@gmail.com>

Reviewed-by: Fabio Estevam <festevam@gmail.com>

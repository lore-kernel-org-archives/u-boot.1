Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF0E5C4828F
	for <u-boot@archiver.kernel.org>; Thu,  8 Feb 2024 14:34:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4705787E45;
	Thu,  8 Feb 2024 15:34:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bGfK2z9A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D249987E6F; Thu,  8 Feb 2024 15:34:09 +0100 (CET)
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com
 [IPv6:2607:f8b0:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE7C987E36
 for <u-boot@lists.denx.de>; Thu,  8 Feb 2024 15:34:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-5dc13b142ffso484323a12.1
 for <u-boot@lists.denx.de>; Thu, 08 Feb 2024 06:34:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707402846; x=1708007646; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xcA7PMVoRcVTpJ/tJxVQ5G3RSQt9R0BNCprTD+nYYQM=;
 b=bGfK2z9Am2vpTjFy8FM+LvWmYguJtei1vCYJkqY2bN9olOlOfsvWnyjP2sbMdRIaSO
 8xvpy0CVPdEHEOL/aIj7BXgjRFcA/Llbhx75bGgfSbeAEszrdevpazuNoAqL/BJdhrns
 8pC53vlT1bfCACGVZs7+bgRqT+LV+9wyDWMd70OfGHgCoPfWxju+3NxRTrfZShhUw07o
 c29o6By81S55BdUNdj3JLyCyzElph45dEsLSKtk+g+zjobefw1Yb91IIx9+MXq4PDDQP
 v9OKZbLBObQd8bKq9W8y1FistREhP2SLhBqaMaLpEhwF7zgCD0CRSxV+LS0EL6o6+exG
 FkCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707402846; x=1708007646;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xcA7PMVoRcVTpJ/tJxVQ5G3RSQt9R0BNCprTD+nYYQM=;
 b=SxKZSaSqIcsNv/0Xt3veAQWnGmtNUAaWMDaQTVocgxG1kNLJOP/I/nzmAxJLGefMyR
 WHMWHORxo3MkgwjgmOiq0qeAQBMN9lLN0Q6t1okCcwnmhM90jgS+Qak86cuA45PfOfyy
 ZHh28P5YrpKvJAP6T3eUEdkPltlYCAk1JltGP7DOStlAM2UenggVxc1DCDLRv09eKMvs
 3n+E9sCUpLpeXZgSv61jaQGvhdNvtIL7b4asnw4N7voLQh+3fId+Ya5/NEyaSMyFYGFR
 CVeNPpdk2dncc9VLKhGtZ5T/NILIbaL3uIpcGrGqbpcl2L48zfGQEbbKvyfcep55nDA5
 3SXg==
X-Gm-Message-State: AOJu0Yw3ebX9+H4DC8rhqPjQJGLydk75iScNiR0AtUBL48GRKZIJd+/L
 lu0nrdw5yspVSe+9GF44bqVNGjJfITyV62eakrG9EEYJre3Md36a4pqjxLRZaAJEyDfPJwbYhyF
 ArddsfkQOejTd2tU7nRLOyylL3EM=
X-Google-Smtp-Source: AGHT+IFa+JLiB/pHFjYDONHUmRG0qivIugkqR1GB4TzuFb9dTOMLNq/fw7FsCXsKUB88R6UtxEOtwwalCJ6NdIkWf5I=
X-Received: by 2002:a17:90b:1d0c:b0:296:9c2a:e7da with SMTP id
 on12-20020a17090b1d0c00b002969c2ae7damr9171567pjb.2.1707402846058; Thu, 08
 Feb 2024 06:34:06 -0800 (PST)
MIME-Version: 1.0
References: <20240124021516.280026-1-Mr.Bossman075@gmail.com>
In-Reply-To: <20240124021516.280026-1-Mr.Bossman075@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 8 Feb 2024 11:33:54 -0300
Message-ID: <CAOMZO5D9AvjuO5KFJKHsaEmjs7sg=pYFMGWzhoAvQR1++MMagg@mail.gmail.com>
Subject: Re: [PATCH v1] tools: mkimage: Add support for i.MXRT FlexSPI Header
To: Jesse Taube <mr.bossman075@gmail.com>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Giulio Benetti <giulio.benetti@benettiengineering.com>, 
 Mamta Shukla <mamta.shukla@leica-geosystems.com>, 
 Thomas Haemmerle <thomas.haemmerle@leica-geosystems.com>,
 Adam Ford <aford173@gmail.com>, 
 Fabio Estevam <festevam@denx.de>, Simon Glass <sjg@chromium.org>, 
 Jassi Brar <jaswinder.singh@linaro.org>,
 Paul-Erwan Rio <paulerwan.rio@gmail.com>, 
 Alexander Dahl <ada@thorsis.com>, Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Masami Hiramatsu <masami.hiramatsu@linaro.org>,
 Mikhail Ilin <ilin.mikhail.ol@gmail.com>
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

On Tue, Jan 23, 2024 at 11:15=E2=80=AFPM Jesse Taube <mr.bossman075@gmail.c=
om> wrote:
>
> Modify imx8m Flex SPI Configuration Block to work with imxrt.
> Add more Flex SPI configuration options to Kconfig.
>
> Signed-off-by: Jesse Taube <Mr.Bossman075@gmail.com>
> ---

Applied, thanks.

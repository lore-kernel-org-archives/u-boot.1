Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C12E1C3DA6E
	for <u-boot@archiver.kernel.org>; Wed,  3 Jan 2024 19:35:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC10387730;
	Wed,  3 Jan 2024 20:35:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MLSKJzeW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E7548780F; Wed,  3 Jan 2024 20:35:07 +0100 (CET)
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com
 [IPv6:2607:f8b0:4864:20::1033])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D46A087727
 for <u-boot@lists.denx.de>; Wed,  3 Jan 2024 20:35:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-28b93b04446so2068899a91.0
 for <u-boot@lists.denx.de>; Wed, 03 Jan 2024 11:35:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704310502; x=1704915302; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2bas5vtCtQYCxBktUeeN3FwKjHpnGszBdQBmUnf0s7E=;
 b=MLSKJzeWjohDCfDerog/oNjAVkAWpUh1jFnv7ZIy/rFSuQWT/SOyJs0FkFkJXr48ai
 qqGG1ozXnUdkfx6je2s5CRwOLnIBTdtZdXoFgISnf6KLDBWbh7I+35tYfc045rKYHHwK
 HK0aOtpTOYPLg55KJkS3D4iYqKbRH7jSCp6O0LFpWUsFbboz++rnB1LK/1Yo3dfsUqXH
 zV+G8G3MkeJDKpITNFg6FxZ8pA5Hrj0CjKHmDk35ZIF5vlNcdIt9oUnD5m/rskZalpRH
 E+fmHC2Mx8Xu51shXb4in37GptM1N5eCIhCWmA1P1/jAv4H/AyG8sYikPksYZZBXJ5qd
 u86Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704310502; x=1704915302;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2bas5vtCtQYCxBktUeeN3FwKjHpnGszBdQBmUnf0s7E=;
 b=o1Oiea2B41dieDR33Lhl8a7CAv50YFElcx9TEfu1Df83l7lv2Xrm/uj2Cy3KXY7I3B
 7UCAt4dsw8yvmgafQ2mZCS6Yk4rP1XLuYo6M/t15TogvUd6YM6jzF11Nskv38EOyXYuh
 PgF/pVB53AI/lzNd7dNH7ZIu0NTpYaqhMlsiyO3BbGMJ5Wmukqyt4JtRGJ3Q+U1zzBIG
 E6q3TUsJmgNupFjm0rwCDFq75mxlxxi387ouijDJ7h4PIv7uC2JZF9UXD8jCqyyIW2W9
 Lt/r5e3lhwIFIwWibgt7PeV6GuSqFT0VCuiJ7+hNsf4ZQ34+qkPFNRnZb4J7mz2VFiWZ
 nz/Q==
X-Gm-Message-State: AOJu0YyLPKuSdrZ4a6xpmQ8mb8B8kDdtcWY1he7VJkdmNgO8TwmMV7H/
 mR6RYafN5QLtihUNomtOtgFnq8hpK3vzqmhGZe0BxZX0hmA=
X-Google-Smtp-Source: AGHT+IHBWwwTuZXnbB/U7sWrq5Et1Zt712HJZZJs7/llIJZ1PV0XaKo2yyo7iOxGBhzL/fElvA9Q6HqpLNxPTuMOf1o=
X-Received: by 2002:a17:90a:e396:b0:28b:c60:8dd0 with SMTP id
 b22-20020a17090ae39600b0028b0c608dd0mr28863252pjz.2.1704310502169; Wed, 03
 Jan 2024 11:35:02 -0800 (PST)
MIME-Version: 1.0
References: <20240102121207.3963-1-francesco@dolcini.it>
In-Reply-To: <20240102121207.3963-1-francesco@dolcini.it>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 3 Jan 2024 16:34:50 -0300
Message-ID: <CAOMZO5Dn6XrBq7N4eiS86BWGCjwJVJje3mq5=4-MQnkXoyD1Dw@mail.gmail.com>
Subject: Re: [PATCH v1] verdin-imx8mm: Remove stale fdt_addr env variable
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Marcel Ziswiler <marcel.ziswiler@toradex.com>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>, u-boot@lists.denx.de
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

On Tue, Jan 2, 2024 at 9:12=E2=80=AFAM Francesco Dolcini <francesco@dolcini=
.it> wrote:
>
> From: Francesco Dolcini <francesco.dolcini@toradex.com>
>
> fdt_addr variable is the location in flash of the device tree blob [1], i=
t
> does not exist for verdin-imx8mm.
>
> Because of this the bootefi command fails unless the optional
> `[fdt address]` parameter is passed on the command line,
> bootefi.c:efi_install_fdt() assumes that `fdt_addr` is valid when
> present.
>
> Fix this removing fdt_addr from the U-Boot environment.
>
> [1] doc/usage/environment.rst
>
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>

Reviewed-by: Fabio Estevam <festevam@gmail.com>

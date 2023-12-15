Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3E58C35274
	for <u-boot@archiver.kernel.org>; Fri, 15 Dec 2023 12:04:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2700E87B7F;
	Fri, 15 Dec 2023 13:04:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="G4ukP3ID";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1815E87B8A; Fri, 15 Dec 2023 13:04:14 +0100 (CET)
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com
 [IPv6:2607:f8b0:4864:20::102b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DCA7087B7F
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 13:04:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-28b1478d85bso62445a91.1
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 04:04:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702641850; x=1703246650; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/Vw2x8sS4o9rJC6hCshTalwXZJu8N2eE9x8RRT2ayGw=;
 b=G4ukP3IDSLhzS2LESJY9i6v9aMXeGPSHsCT/qdf4eYcIX0RyOuQtRkHaKb+hpUr3eM
 6dCR0baThTLfCzmRPLCraC8zaAKK54QG+xzMFbNJKhLc9QiwbaAiuy/PQ3J3eEhyMgEu
 iNJpJz74rsTOEVQFFYO66PNRkTKK51qe313JfBqQz4ohSulPevyyTCztoJlr48WZX83N
 RfyWowvMkcmKt4Wzr8BkvTT9jSUkwvZzNdbJoZEdDlcwL+HVEoxSsCHQavu2/JgefiZe
 nLxRxlg2HdwfrpwPI/vFZ3xhz6Cc0u5DmCC1riknnqWnHv2ylwvUlKy8+JgdawonUJHO
 iOKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702641850; x=1703246650;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/Vw2x8sS4o9rJC6hCshTalwXZJu8N2eE9x8RRT2ayGw=;
 b=mu85XwO6lXAdeOBhevumWq39k7CfQDTwlNZGXt2PGB+8TPh7Iiol8nxoNrcdhkw81b
 tt9KBzkx/9iLovfK7UV65W+klsgFD47V8Nw9/FBNNv9vJjj5r571FcDw4PM4B3gPX3Nl
 YTSFHFLQqSQVPt576Br0zAzVz2YDfzKZaLxNS9wdWt1iAsGcFoVV3WVHc3LJpr2nxT9k
 nw+ZRXB60HUuQpQphd4EAwTta/6Vz+6WeTjNLADmEKfWLylnIB+v8ckNS0FX5mjyaABs
 JUDZ141LHUFHEWPHr+O6cJ69Mt4YLue67A4jDkTqX1uS2DJVJk1CHo1wgIyTBrPy5TeD
 2pDw==
X-Gm-Message-State: AOJu0Yxdmxq1XNbe5pd6oECXIv47IiS7H5UNlHsudrVMHqsygjIbCFPl
 66jsqF303GCav90Kb7uachz6kflBFnKcrzj14g0=
X-Google-Smtp-Source: AGHT+IHVD0uenXgtzyWjbREF3Ltmb00QsOUuOyqftUv68Tqr7sinD7iWVWlGgn9NPzkkD2M757PMt5cDMb/i0WyN+UI=
X-Received: by 2002:a17:90a:88f:b0:28a:e25d:a9da with SMTP id
 v15-20020a17090a088f00b0028ae25da9damr7433988pjc.3.1702641850141; Fri, 15 Dec
 2023 04:04:10 -0800 (PST)
MIME-Version: 1.0
References: <20231215111333.31286-1-sebastien.szymanski@armadeus.com>
In-Reply-To: <20231215111333.31286-1-sebastien.szymanski@armadeus.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 15 Dec 2023 09:03:57 -0300
Message-ID: <CAOMZO5C8F3EpzpMS3=XC5n8uzzR30LBpY9V7t-Het7NEe+krXQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] Makefile: pass -ansi option to cmd_gen_envp
To: =?UTF-8?Q?S=C3=A9bastien_Szymanski?= <sebastien.szymanski@armadeus.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Le Jin <le.jin@siemens.com>, 
 Jan Kiszka <jan.kiszka@siemens.com>, Fabio Estevam <festevam@denx.de>,
 Heiko Schocher <hs@denx.de>, 
 Jesse Taube <mr.bossman075@gmail.com>, Eduard Strehlau <eduard@lionizers.com>
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

Hi S=C3=A9bastien,

On Fri, Dec 15, 2023 at 8:14=E2=80=AFAM S=C3=A9bastien Szymanski
<sebastien.szymanski@armadeus.com> wrote:

> --- a/board/siemens/iot2050/iot2050.env
> +++ b/board/siemens/iot2050/iot2050.env
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: GPL-2.0+
> +/* SPDX-License-Identifier: GPL-2.0+ */

This is an unrelated change.

>  /*
>   * Copyright (c) Siemens AG, 2023
>   *
> diff --git a/board/storopack/smegw01/smegw01.env b/board/storopack/smegw0=
1/smegw01.env
> index 93de8669109d..6807ada71887 100644
> --- a/board/storopack/smegw01/smegw01.env
> +++ b/board/storopack/smegw01/smegw01.env
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: GPL-2.0+
> +/* SPDX-License-Identifier: GPL-2.0+ */

Same here.

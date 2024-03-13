Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96C12C54E58
	for <u-boot@archiver.kernel.org>; Wed, 13 Mar 2024 01:16:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E66158753A;
	Wed, 13 Mar 2024 02:16:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mi3QrqtB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 636E487F0E; Wed, 13 Mar 2024 02:16:32 +0100 (CET)
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com
 [IPv6:2607:f8b0:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2CE4D8753A
 for <u-boot@lists.denx.de>; Wed, 13 Mar 2024 02:16:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-5d862e8b163so2017982a12.1
 for <u-boot@lists.denx.de>; Tue, 12 Mar 2024 18:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710292588; x=1710897388; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OERZ7WhGAdzXI7UeKheVfOHtuSR2YzrjK/bMSj5eG+I=;
 b=mi3QrqtBmMmjrGMGKZZLaKcqc+kifzj5mj4YnWb9nwaxgF/AA66Qz0wZBSWm+vOXiV
 t1dfYrcwJH1XxFoMt1gvwvWQ4MuI+p8lhqnm9lD8Rd+JkJitvS5i2f5EfLT7XcOgURAD
 WgzTo8oEB9Zf7Jccx/v1OjJjxWKh7WLU0QvgyyzUPseY10h5jkA3H0HFuhbCQ5gnHkz1
 F9ZVelfYa/jqj00Tdp6+hsLgBVv629Tg8EDC5PUkAnggPFueyWzNC/6CGneToq5R5jyT
 aRvH5HPux8seE1uJDEseVjARse3Ot9zTgtcOkN2mrkQGs8oNGd9DC+Tpw1bJExLlcM+3
 9Bkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710292588; x=1710897388;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OERZ7WhGAdzXI7UeKheVfOHtuSR2YzrjK/bMSj5eG+I=;
 b=WE/nx1hgC/+QNQ+I4QIaWHBLNGRqsgmL+0aon3aCZPqfKMFzSA0rAI9XitYAuYKIH/
 SkGg3uOT5JpC2ExClsYl4fqBtYbL6psCRrL26ndRM2MxGq4hFfJKz6cLcnww6eGK63mM
 h/pipj0/HEQg3maPtKUtNxcg/thu9lO9jaxjuP3m2dVcZq2OHTtkuC/WonAsRW3dpWRy
 i1AFV1thBZSmiiw7t0Eop6PsuZNldUKtGx1WxaMgwKHBt1MlPV2UjEo0aoJKVS3Z4h3s
 RnmXRqYV+qgs8XwnxzWfhmITSjpOk0LIr+mb6ccKTesMpWkXs4tRvJOLWfpeN3G2pVyV
 kgGw==
X-Gm-Message-State: AOJu0YwucHWffcuGYDia1UHxXkVnY/vYI9kmRf2KSSO8Djk+M6ikGcuw
 Rh10v/pbrOrBw7BcPsTpKTMct4JHnYF3XT6xcusliPH+1R0gCSTT8UFD47JIoSAaprZCD/dCCsv
 77wqG/CJe5wlV3nVk1fMaQcHEqag=
X-Google-Smtp-Source: AGHT+IF84+ql/EBnUAkBZwFcZXhRBsZrs4AVr+FAkNt4VSbIjvCI8Fn41MyMvAoexO+oP7JnLQYaqQX1ocsGi69uXsg=
X-Received: by 2002:a17:90a:9ef:b0:29c:607f:1661 with SMTP id
 102-20020a17090a09ef00b0029c607f1661mr207615pjo.0.1710292588473; Tue, 12 Mar
 2024 18:16:28 -0700 (PDT)
MIME-Version: 1.0
References: <20240312190543.3544532-1-tharvey@gateworks.com>
In-Reply-To: <20240312190543.3544532-1-tharvey@gateworks.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 12 Mar 2024 22:16:16 -0300
Message-ID: <CAOMZO5A8m5gW+MgD8RWrtsd3kpsMaj+cV5CLHuvUkux7daD1jQ@mail.gmail.com>
Subject: Re: [PATCH] imx8m*_venice: move venice to OF_UPSTREAM
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

Hi Tim,

On Tue, Mar 12, 2024 at 4:05=E2=80=AFPM Tim Harvey <tharvey@gateworks.com> =
wrote:
>
> Move to imx8m{m,n,p}-venice to OF_UPSTREAM:
>  - replace the non-upstream generic imx8m{m,n,p}-venice dt with one of th=
e
>    dt's from the OF_LIST
>  - handle the fact that dtbs now have a 'freescale/' prefix
>  - imply OF_UPSTREAM
>  - remove rudundant files from arch/arm/dts leaving only the
>    *-u-boot.dtsi files
>
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
...
>  33 files changed, 13 insertions(+), 10658 deletions(-)

This diff looks great :-)

Reviewed-by: Fabio Estevam <festevam@gmail.com>

I will queue it to u-boot-imx/next soon.

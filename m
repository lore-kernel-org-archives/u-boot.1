Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF08AC3DA4A
	for <u-boot@archiver.kernel.org>; Mon,  5 Aug 2024 13:31:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 15F4588297;
	Mon,  5 Aug 2024 15:31:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LCbszLXi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B271E888D7; Mon,  5 Aug 2024 15:31:48 +0200 (CEST)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com
 [IPv6:2a00:1450:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D032F87876
 for <u-boot@lists.denx.de>; Mon,  5 Aug 2024 15:31:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-52efa98b11eso1707687e87.2
 for <u-boot@lists.denx.de>; Mon, 05 Aug 2024 06:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722864706; x=1723469506; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bW5foQSoZtufLcNfH1U/KCLnh1VnO+nNWl/COV9EWYg=;
 b=LCbszLXiwipDPkE4Acxa9PFEZsGIrES0en5gfHZmAA+AhPTBtdXezAaCwetQ9cK2Tr
 OMhO/OMP7n1hBjMK8ap5jT/h7/knFVglt6WbtyINokOSu0TaIz7nqqfFyVfQfmOdiWBq
 YSNcvXvu7mVKUoi/MSNapLTdzmMT2bIK2FCm7HV6846gpjKkBAyqRudoRGhbdOaikc+i
 w7lWi5gD8quFb6qL/km3Kat5/Lw4zjuzpYykppF+8bVJeTHhy85DCAnd5fxgzT7XCNZN
 fjOtPOpN2YjpB214LVOZc0eCWHmPB6orkv1gPf1Cq4NRIirkkyF2oZZ/oFq0+XakSDtL
 vNww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722864706; x=1723469506;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bW5foQSoZtufLcNfH1U/KCLnh1VnO+nNWl/COV9EWYg=;
 b=FOl1BRGIXZnmtwTB5IbIgELAaq6woJPj625jsmFipS/CDDGzwy/F2NwfN3NjHVCYnz
 bgCQh7OF44pl0Aqw4GvNkTzi1lq7Jmo8l3REtNE07Zrrp00e3+LJD3tVG/hA9ScraGS3
 8qmlr0yV0BkPSJRSJbRIDtgzXG9V8ZZdv0Bn1ch8XwPXccTtMlMcIqXofI/kNsG4S2Re
 sgjrWnlxVslVwgGsz89ahp3+Zh0K+0QVhk3xueUCAyKjr8LOtWW/v17S0qnone7dGRlF
 q0ZkjZi9MwY/+vPQCFptbrYwp+ZO9i2QvQydENBfdIiipgR/eGgd2Flez/yvTO3fwvtu
 SnbA==
X-Gm-Message-State: AOJu0Yzk9BIvyoL/V6ypdHBuUSnCFmjY1cg/HD5UXAcCzjScXqodplKa
 WN/rxOboBmfPSw3H9W1RYiVVnDiARkP65ZzPKCIgPKCQZv4bJoZw6MJGBtQ8BhKFqSUeM6Xloov
 WUOCdcxvPlvqQSoHMExBCPCcYHeY=
X-Google-Smtp-Source: AGHT+IHCF5vHalMtGkMyax3gCCg/HfopnN4p4Rf6DSdrCguJYQqT0d8A1mdk3iLUxuf/toAFUyoCwZngjit5q+hTf6Q=
X-Received: by 2002:a05:6512:3e12:b0:530:baec:3975 with SMTP id
 2adb3069b0e04-530bb3656d3mr4154426e87.1.1722864705453; Mon, 05 Aug 2024
 06:31:45 -0700 (PDT)
MIME-Version: 1.0
References: <20240805124326.544310-1-bisson.gary@gmail.com>
In-Reply-To: <20240805124326.544310-1-bisson.gary@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 5 Aug 2024 10:31:34 -0300
Message-ID: <CAOMZO5CrAfxg5993jm+yDGgJUC6x10Cq-onHY5ref-BDc2sKZQ@mail.gmail.com>
Subject: Re: [PATCH 0/5] imx: imx8ulp: add binman support
To: Gary Bisson <bisson.gary@gmail.com>
Cc: u-boot@lists.denx.de, trini@konsulko.com, peng.fan@nxp.com, 
 uboot-imx@nxp.com
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

Hi Gary,

On Mon, Aug 5, 2024 at 9:43=E2=80=AFAM Gary Bisson <bisson.gary@gmail.com> =
wrote:

> Gary Bisson (5):
>   tools: imx8image: fix soc variable for ULP
>   tools: imx8image: add upower image support
>   spl: binman: Disable u_boot_any symbols for i.MX 8ULP boards
>   mach-imx: Add i.MX 8ULP binman support
>   imx8ulp_evk: enable binman support

Thanks for adding imx8ulp binman support.

One thing that is missing is a doc/board/nxp/imx8ulp_evk.rst that lists
the required firmware files to build and boot the board.

Could you please add it?

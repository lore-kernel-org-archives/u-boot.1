Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8396BC47DA9
	for <u-boot@archiver.kernel.org>; Mon, 29 Jan 2024 11:52:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B1EEF8785A;
	Mon, 29 Jan 2024 12:52:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="G44S7EEU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DEEF287CFE; Mon, 29 Jan 2024 12:52:45 +0100 (CET)
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com
 [IPv6:2607:f8b0:4864:20::1134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD3B18784B
 for <u-boot@lists.denx.de>; Mon, 29 Jan 2024 12:52:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jagan@amarulasolutions.com
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-5ff821b9acfso24083617b3.1
 for <u-boot@lists.denx.de>; Mon, 29 Jan 2024 03:52:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1706529162; x=1707133962;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y1/VNbW1FuOA1iWCAbah5MY149FkOzFjEU9svAgwL+8=;
 b=G44S7EEU3hASqVVOrHxJMlGppluciyP468jmMIyEIy7k5uqLsZFW72FCh/IshiVUnI
 0Mx/+u/V5R3IfT7k+aL5gHLhxfsSEfRc1qsaBO9z8TmvutezdIn0EbOqdsYV6amPk/4r
 esD/UrNPN8rPjsFjOA3aRMH6ofwpXQR1+5YLQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706529162; x=1707133962;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y1/VNbW1FuOA1iWCAbah5MY149FkOzFjEU9svAgwL+8=;
 b=RVL586AfzysdXlJRuWxk0fNSDy6k7VA7sxPeTh1xm2irhmZwRS1jTs2cSaziJk1kEt
 P8spJyXNO3LsRu1Iv2q8vam+2EyLYQvSpPptBcFCinSPDzmQpLCRnDJ9PcnlASe3JOCN
 OoOyCiN9ANVCUE3yUvzz1foGMP5qs2qfd/48qeyN9SMyu77rboEwo11SGMiuyxxV1bVo
 ftGcMmYuMBQnNR/MJ6jcDsutKyitO/TXUaxOr/jyH4mXzQuJBZCsRswdjWF2tzfqTKbn
 mGL/yFiNnouBxKOhklvTw2IrKf5POTx16OL6q60GcuatATEytgC1vhcN8ZF1VWPSWXbo
 WeoQ==
X-Gm-Message-State: AOJu0YzHztsoCi1EvMwFqc+cXJ/QddVlszk2+a6uWdnaonz8RfxWRhF1
 8x4gMG3W1Qal+/hM0CINuloNAwMzficy9OXSoOJ6kK2yqfndk99cpV7IAx1e8T2ml8futO+K13O
 5F8/XTKz/dj/K9GlfxNwVfSctbxDeA1iSmlxn5A==
X-Google-Smtp-Source: AGHT+IHYhxr3ZY84i4aKv5A/DE751uQpelhz+M90xPl4EvVhIgtFqfrTCWc0kATWmiFX1btMEk75Z2xWNgrSLO1ruio=
X-Received: by 2002:a81:ed09:0:b0:5ff:8155:c994 with SMTP id
 k9-20020a81ed09000000b005ff8155c994mr3151956ywm.74.1706529162513; Mon, 29 Jan
 2024 03:52:42 -0800 (PST)
MIME-Version: 1.0
References: <20240128155458.56712-1-marek.vasut+renesas@mailbox.org>
 <20240128155458.56712-7-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240128155458.56712-7-marek.vasut+renesas@mailbox.org>
From: Jagan Teki <jagan@amarulasolutions.com>
Date: Mon, 29 Jan 2024 17:22:31 +0530
Message-ID: <CAMty3ZA7sEks59cdQhHCZR+R8fSxHdAtgHUupem=X61KDUALSA@mail.gmail.com>
Subject: Re: [PATCH v2 07/11] mtd: spi: renesas: Add R8A779H0 V4M support
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Hai Pham <hai.pham.ud@renesas.com>, 
 Paul Barker <paul.barker.ct@bp.renesas.com>
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

On Sun, Jan 28, 2024 at 9:25=E2=80=AFPM Marek Vasut
<marek.vasut+renesas@mailbox.org> wrote:
>
> From: Hai Pham <hai.pham.ud@renesas.com>
>
> Support RPC SPI on R8A779H0 V4M SoC.
>
> Reviewed-by: Paul Barker <paul.barker.ct@bp.renesas.com>
> Signed-off-by: Hai Pham <hai.pham.ud@renesas.com>
> ---
> Cc: Jagan Teki <jagan@amarulasolutions.com>
> Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
> ---

Applied to u-boot-spi/master

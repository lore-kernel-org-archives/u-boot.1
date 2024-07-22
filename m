Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A68D9C3DA5D
	for <u-boot@archiver.kernel.org>; Mon, 22 Jul 2024 21:04:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3A8F887F82;
	Mon, 22 Jul 2024 23:04:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FAmcz6AA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C74BE88579; Mon, 22 Jul 2024 23:04:40 +0200 (CEST)
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com
 [IPv6:2a00:1450:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE58D87D43
 for <u-boot@lists.denx.de>; Mon, 22 Jul 2024 23:04:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2ef298ff716so3446231fa.1
 for <u-boot@lists.denx.de>; Mon, 22 Jul 2024 14:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721682278; x=1722287078; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BWT7vqy24W7VTCBEwFiomrEwL9nQ50jjZKSLlaygAX8=;
 b=FAmcz6AARb9lwSvkoJWZRnle2pnofDqiOiaQJK70GImY8dfCyMzCD88PbyCAG+xpf9
 3+vQWom59OKGCgMpusOjjUV7FJLUptbo21qNu7BLWAm2TDRCh4xJzTrPHo5U0J2DDyaz
 4pm4sXqtSSP4xpRJGMk/O+IR5rGFC2sldN60QlUaGemo4s/VO+L6jm7Pn74T4NaV4zEX
 XiA3f66ZHGSJpsbQS2rnCqZQobiTFhEN8/TBHe/mB1kJOmcbezUhiCW8Q0MOL9xL7wcU
 9AAuliq27yIlLCIzprj9wHw2dva5VdlUdhbobOrGK+MA0O9WCreDGRweYX/twSaOP8FK
 yq2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721682278; x=1722287078;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BWT7vqy24W7VTCBEwFiomrEwL9nQ50jjZKSLlaygAX8=;
 b=i/9YSdFLkWhoAW6jl4UWPGn2ciPsKx0YpaCE77RsRKXsQ73OjaWYPft8kJs4hPyWNU
 LMzPJiDIY0pZfjccDrcebjwaKqHEhsyOqVn1QzVOJAnR86gvIQKzr4NoW/K/pmDZXcam
 3AfIgaWzzVZtxBnTvkn8q6I/wuQuUXtkaf2JKT7riRqAgaPcHCsoBK8qgbHCOizYTb0M
 5IYLXVrEb8DmL5PGT9HZ6l+qn606mrTJoD2o/M6Bkk7vRGi/bTtsU3WrH28Cp+ecvPuC
 PmDONL2VU8FEqt3+dACUBU6FVXSHma0ug66j8zWInr3DB7cvUthRgA7hy5hyHCQ1P021
 dZuQ==
X-Gm-Message-State: AOJu0YzubJImIORe+yRgjiJEMeFkOkpdsgDxTaX4LgEkNVMs4ifdIcGb
 fgXAAKjL67icKyyvLVeLAUGwzPe9Xxm0yDsXMelGiLctY1OQiuIcMPrkOlP7E7KNbtkxAivkEyZ
 DBiW6cGGXx1XxgOw3urBYuaR/f+A=
X-Google-Smtp-Source: AGHT+IGO83FuSJCzf+aWKIrMRJazwmC6c7k+drr7SyayyOqJSE4ysoNWFUHeLJHKI15GuDt7dO4cdTduim3ihCjnSwY=
X-Received: by 2002:a05:6512:3405:b0:52c:ce28:82bf with SMTP id
 2adb3069b0e04-52ef8dc9c90mr3326502e87.5.1721682277801; Mon, 22 Jul 2024
 14:04:37 -0700 (PDT)
MIME-Version: 1.0
References: <20240720155400.3576137-1-agust@denx.de>
In-Reply-To: <20240720155400.3576137-1-agust@denx.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 22 Jul 2024 18:04:26 -0300
Message-ID: <CAOMZO5AbjbDRVJCcRRXxrgfkR6Qgowob=TM596wjUs-Kii4CvA@mail.gmail.com>
Subject: Re: [PATCH] kontron-sl-mx6ul: switch to DM_SERIAL
To: Anatolij Gustschin <agust@denx.de>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>
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

On Sat, Jul 20, 2024 at 12:54=E2=80=AFPM Anatolij Gustschin <agust@denx.de>=
 wrote:
>
> Enable DM_SERIAL to avoid board removal warning.
>
> Signed-off-by: Anatolij Gustschin <agust@denx.de>
> Cc: Frieder Schrempf <frieder.schrempf@kontron.de>

Applied, thanks.

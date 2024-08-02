Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A940EC3DA4A
	for <u-boot@archiver.kernel.org>; Fri,  2 Aug 2024 19:25:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 098F188BF0;
	Fri,  2 Aug 2024 21:25:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FhDeCx89";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3EED288C02; Fri,  2 Aug 2024 21:25:38 +0200 (CEST)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com
 [IPv6:2a00:1450:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5035788BBB
 for <u-boot@lists.denx.de>; Fri,  2 Aug 2024 21:25:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-52fd0904243so821234e87.3
 for <u-boot@lists.denx.de>; Fri, 02 Aug 2024 12:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722626735; x=1723231535; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VQfSII9oV+XuYyxQEA4z1OEDuixVsm63vF7WP9tYBkY=;
 b=FhDeCx8953pwvnl/Fy4v7iI657732CLDlTOXh/L1bfUsXQ+fYcwsVzNXZsW3HiA8OU
 gaXMZFZxiDsYL0XUSrEy53eTwT3IIrzIziTSI5kx69vtjUtajMjSi6fPz+/RufQvoqFp
 I8d4necuTrv9zNRubAdL10m1+zfA9rI4ZpRQS5Z4+ErEEtgbHUEymq9hY/mwCsqO9/KO
 pe0MCngeyhMkUNaYK+0acfxa+cL8vc8czlgbrQPRw7CxI3j3y5QuZkDEzNcEM+gj8GdP
 fDyxDdTvd6EsLaMp4G1URhoI6paVP3EO1YJpFzGb00if0ZrdeJh/x+4NBkxrN02zvNdr
 39yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722626735; x=1723231535;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VQfSII9oV+XuYyxQEA4z1OEDuixVsm63vF7WP9tYBkY=;
 b=MxprTMV2sEojI0JixXkPAd3kjMiHcQ7g5NG1tsAhwgEdjST9+iJPdd8osErobDJFI3
 Kp+9kr+qVmF4STruGZqrYDF2NvUZc4SlvsFwFjElxGKexMhNK5vYqNv7NripxQuxPQAO
 9YEP7dVAAoAYJb0t+WaWVhZaEgSnNg2wNOZD3YfcCGsZK6TIRfdFF3VaP7T+MZvqv463
 ns0ro/8nX+1mgvZwkM46KAyZ/nNpwxC9DCEJMsHslfzYU94Qfr3zemoPZc71ryF3fkC6
 KkDXLoVfGMQdL9ulgHJ1pX0mL4gS998714+aMCdeURdW7BYLfXs15kStF2SxTpOLjqON
 3Xpw==
X-Gm-Message-State: AOJu0YwLvsoGMQt0Wc7xrU6VvOXJBWUUPtbA7VTOfhEfTl5aADQ3haTu
 oDMD2tWh1wFzWa1XObX20rldt5KrNK0jAziq9XLOklLKGpc3wVRHBJvQ92OSbx6ryC4vua1DwAB
 LdvRQeAKTyU8BbrtJYf1g39+glSM=
X-Google-Smtp-Source: AGHT+IEMSb6CyXn9K6qFrf+llpRN8E+SJWJmi5jUzGCr4CSkBuLM776DXnIp1VeWYLT/O6BDgTpwdSZgtp3BEgU+dJM=
X-Received: by 2002:a05:6512:ba7:b0:52f:cf27:69f3 with SMTP id
 2adb3069b0e04-530bb36725dmr1951651e87.2.1722626735258; Fri, 02 Aug 2024
 12:25:35 -0700 (PDT)
MIME-Version: 1.0
References: <20240801035959.43115-1-Zhiqiang.Hou@nxp.com>
In-Reply-To: <20240801035959.43115-1-Zhiqiang.Hou@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 2 Aug 2024 16:25:24 -0300
Message-ID: <CAOMZO5BWePhEjHs8BsCPxnSYyGHyEhusPbAZ9DJNxH5kY=QbZg@mail.gmail.com>
Subject: Re: [PATCHv5 00/14] Add a subcommand 'release' to cmd/cpu.c
To: Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
Cc: u-boot@lists.denx.de, trini@konsulko.com, peng.fan@nxp.com, 
 sjg@chromium.org, marex@denx.de, lukma@denx.de, seanga2@gmail.com, 
 xypron.glpk@gmx.de
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

On Thu, Aug 1, 2024 at 12:39=E2=80=AFAM Zhiqiang Hou <Zhiqiang.Hou@nxp.com>=
 wrote:
>
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
>
> This patch set is to add a subcommand 'release' to the 'cpu' command
> in cmd/cpu.c, making the command is able to release a core to run
> baremetal and RTOS applications.
>
> Fixed some problems of the imx8_cpu.c and added i.MX 8M series SoCs
> support.
>
> Added ARM A53 core clock registration in clock driver of i.MX 8M Mini,
> Nano and Plus SoCs.
>
> And enabled the 'cpu' command and imx CPU driver for i.MX 8M series
> EVK boards and i.MX 93 EVK board.
>
> Hou Zhiqiang (14):
>   clk: imx8m: register ARM A53 core clock
>   cpu: add release_core callback
>   cpu: sandbox: implement release_core callback
>   test: cpu: add test for release CPU core.
>   cpu: imx: fix the CPU frequency in cpu_imx_get_info()
>   cpu: imx: fix the CPU type field width
>   cpu: imx: removed the tail '\n' of the CPU description
>   cpu: imx: Add i.MX 8M series SoCs
>   cpu: imx: implement release_core callback
>   cmd: cpu: add release subcommand
>   doc: cmd: add documentation for cpu command
>   MAINTAINERS: add entry for cpu command
>   configs: imx8m: enable the 'cpu' command
>   configs: imx93: enable the 'cpu' command

Applied all, thanks.

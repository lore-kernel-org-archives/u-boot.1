Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AB6EC5478C
	for <u-boot@archiver.kernel.org>; Fri, 23 Feb 2024 13:42:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA44A879DF;
	Fri, 23 Feb 2024 14:42:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Y+p5/l4i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 373D0879DB; Fri, 23 Feb 2024 14:42:01 +0100 (CET)
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com
 [IPv6:2607:f8b0:4864:20::102a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 12C3287C52
 for <u-boot@lists.denx.de>; Fri, 23 Feb 2024 14:41:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-29964f5c904so126014a91.0
 for <u-boot@lists.denx.de>; Fri, 23 Feb 2024 05:41:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708695676; x=1709300476; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qwzT/OX5DB/+CtwCzQhWkSPTb1vR6il8XWDrz+djdYs=;
 b=Y+p5/l4iRX5+f4iP6U15sYKJIp+vRZNi0psUc5j7kSsUow3jPF/CxzVXMztJzE+rAk
 bjkQC5cL+LByNkjPcL4WvAcpv1AZ2JamshsegTKQ2MR0VDTmqEG8TtzDffpIC3BV1UPK
 rzWXrv+/c6WuLoR62fLg1l/1TDqYywvUBTgHDNi+1kLoUy+9B3rKLRNAGiPZ/Oq7rRey
 +lQz8NAxyOfXp7bm4BHxcriZ+dNwX/Xky3EnWPYbArpA6bzFlugIwJIEdYJMmaPmjeSA
 GdN5cVCoIxpGuXM+yFG3MAW2cB5kj/vN+DSh7cdtOwswpoZ8nINA93nNF41I8eIRRVE4
 vDGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708695676; x=1709300476;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qwzT/OX5DB/+CtwCzQhWkSPTb1vR6il8XWDrz+djdYs=;
 b=QwbzD42sePMgqLnDgIz3A7Ja0XeY9DX9tECwC6RQ2AfMRwh42X96xjcvFll9oZbqnA
 FabB9SVfQFGvnUhIblNJOuIq82fQ6FpDaLzBMfIyW5t1GgxquB8oliTd5EGUAqyiLgJC
 XQB+1SJCNDoJlXVGjtzLSLBO5GLWj1rjmO7nW2rP0bRO2tq7ti8lDqbEgPkIx4/U5mkt
 C/QzZ4QEXOuw1fXy4P2we9v2Niy5RhDN9Hqh12DJwQSuWEOVqMPguC9CU5N1ozU8HN1h
 fgoFxfa2KVR70kl5oedoLmjkTn6cU642TihBZ5MH2JDdjQZKRgEmn8lfU17c6TF7Uxig
 oL2g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXpd+8wn5Nu5Ixub8xnFENLLSI/lhugSYNa5AB/BgejmQOgMbB8aHq1tgPJmEhSBL/20CzAYpwExfytJUPCuGFZeiOPCw==
X-Gm-Message-State: AOJu0YwKFIvZ+k+Hm6SodID8kbgaLCf8DsPuLb4xaswpV+Oi5oPtcG/Y
 7ktp4ZCHAyVEpq6FGvwHlKvetNrdbK+RIaPnlK9vcOVz2ti3D5Yu8e3wP8HkSvHduw+4U1hHmzM
 3JIJ3kfR3ZQRCckriUG10bm3UE8A=
X-Google-Smtp-Source: AGHT+IGlJdfh9VZF7uG+u5t+OmSIYntKtSCedgIy/ow9bLvlxNui7ZUQwiWqveXeDzJz2sZUFP4Fi9pa1Nd9LdoyiLs=
X-Received: by 2002:a17:90a:3ee2:b0:298:c3b4:f6ab with SMTP id
 k89-20020a17090a3ee200b00298c3b4f6abmr1509723pjc.2.1708695675789; Fri, 23 Feb
 2024 05:41:15 -0800 (PST)
MIME-Version: 1.0
References: <20240223091143.9561-1-francesco@dolcini.it>
In-Reply-To: <20240223091143.9561-1-francesco@dolcini.it>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 23 Feb 2024 10:41:06 -0300
Message-ID: <CAOMZO5AshES83w9HqYoLS1UzBhs7FJpzvF8FbRvOfXgCoSrDzw@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] toradex: fix reset and hardware detection
 regressions
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Stefano Babic <sbabic@denx.de>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, Tom Rini <trini@konsulko.com>, 
 Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>, u-boot@lists.denx.de, 
 Sahaj Sarup <sahaj.sarup@linaro.org>
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

On Fri, Feb 23, 2024 at 6:11=E2=80=AFAM Francesco Dolcini <francesco@dolcin=
i.it> wrote:
>
> From: Francesco Dolcini <francesco.dolcini@toradex.com>
>
> This series fixes two regressions affecting multiple Toradex boards
> (i.MX, TI and TEGRA based) and targets the current master, e.g. v2024.04
> release.
>
> U-Boot `reset` command is broken on all Tordex i.MX6* based SoMs since
> v2023.07, this series fixes it enabling the `wdt-reboot` driver.
>
> Since v2024.04-rc1 reading the Toradex configuration block is not working
> properly anymore, the serial number and the hardware version are not read
> correctly, preventing the board from functioning correctly (wrong mac add=
ress,
> wrong DT, ...). This is fixed by reading the config block in `EVT_SETTING=
S_R`
> and adding a toradex sysinfo driver. In addition to that, we now use a ra=
ndom
> mac address in case the config block is invalid.
>
>
> Reported-by: Sahaj Sarup <sahaj.sarup@linaro.org>
> Closes: https://lore.kernel.org/all/CAKZ1LvM45MB8N0CqgU+C7i9=3DBjb6kqNTxW=
o2Tv407HKLWtCMkA@mail.gmail.com/
> Reported-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> Closes: https://lore.kernel.org/all/e40ed93bd8f371ec56b8fc451dcb458f3ce6d=
cba.camel@toradex.com/
> Reported-by: Francesco Dolcini <francesco@dolcini.it>
> Closes: https://lore.kernel.org/all/ZY2ZDWAQuTlRjV9H@francesco-nb/

For the series:

Reviewed-by: Fabio Estevam <festevam@gmail.com>

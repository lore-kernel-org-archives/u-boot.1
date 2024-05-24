Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23849C25B74
	for <u-boot@archiver.kernel.org>; Fri, 24 May 2024 17:00:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 182FC888F3;
	Fri, 24 May 2024 19:00:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="OZaQ6xw0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A686E88640; Fri, 24 May 2024 18:06:57 +0200 (CEST)
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com
 [IPv6:2607:f8b0:4864:20::b31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 194D98800C
 for <u-boot@lists.denx.de>; Fri, 24 May 2024 18:06:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jagan@amarulasolutions.com
Received: by mail-yb1-xb31.google.com with SMTP id
 3f1490d57ef6-df4f05f4cc8so3089442276.0
 for <u-boot@lists.denx.de>; Fri, 24 May 2024 09:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1716566812; x=1717171612;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LYOVo6mPbwjMZ5rVlhy4/6FzGdFirbvYKjtxCS49HN4=;
 b=OZaQ6xw09XIbu6qzsytP/gPQ9GNRHr2IJRdXPa5EKmIldVOliIICrrTWPybJwvSAmK
 jEDv9IL9aFzsLlAb6gzNx2nSH7KqKLYdTv1D6hPm9VclfOcNMDnI0dFHXQiauZMPorW1
 nPHunUfpGTWVOjXIhL0Z7nYSsz1bPCp/Cau04=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716566812; x=1717171612;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LYOVo6mPbwjMZ5rVlhy4/6FzGdFirbvYKjtxCS49HN4=;
 b=cZXehi1lQbkKR8BImSs/t8BkEnDNUyGIyfYX/kCoN9X1qg3zzE0sQiPC+lbIMfx2Pb
 I++UoMP9ir+QFk1oZSZky2haOtgGAnAPfKLQtrz+oatzJST+D4lkuy92cSs8RqC/gwJ4
 dB9IlDz5t+U5dTcJ40f7earfyC1a2YtbosbJ5aMPOrNycfiTm0rLvKfm2mHS9lvW7OLM
 0CHq+06dC0YlE4gwiPKi/YnGCDSx13SfAqfpmk+k/QZ+WHIYbWlQKtGLLnKaAk6lgKaK
 7rIZDBHm6zynWyjHucDRCr4BVwkiAP5GQU7eAu+UdYNMOwj/uRXyRAioN0W2WzWOqd0E
 GKLQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWkUepmZyaWo1guwK1wYKTjMZVfFmws9jg567L0i9OfO2U3usGDxA+hb1NSDFn9EIZAhOWkOvgUzbvc6NKhcMtJzk7zoQ==
X-Gm-Message-State: AOJu0YxOhrVURQpHz08GYE0XHT0HBZssFlA81RMjFB3veJuJcHoFhLZA
 OufA8ErYZt0g9YdmCNmDTY5hmC/N84hhDR7T4CigCuwdRuzHjVogwzzvGMcLYsHC1ol7ZLnGZvR
 MPhDPuyMWldffcDtUWqSIf07fJFchdH86uXeicw==
X-Google-Smtp-Source: AGHT+IFJwszvO5XLub3AGnoVa5ZMIFbjXWeDfM9ws9AcCAG8HA7IsAHZ1ToI3l8NmH3XZv4XPfrf/i/g2g5ztoVkMas=
X-Received: by 2002:a05:6902:2588:b0:df1:cfb3:47fb with SMTP id
 3f1490d57ef6-df772384209mr3083577276.54.1716566811948; Fri, 24 May 2024
 09:06:51 -0700 (PDT)
MIME-Version: 1.0
References: <20240226102520.1844450-1-dunaev@tecon.ru>
In-Reply-To: <20240226102520.1844450-1-dunaev@tecon.ru>
From: Jagan Teki <jagan@amarulasolutions.com>
Date: Fri, 24 May 2024 21:36:41 +0530
Message-ID: <CAMty3ZBuMS_FgSPypZrdEg5r5Gb6qEVTb0sJ_mZnNDEx8cBwgA@mail.gmail.com>
Subject: Re: [PATCH] mtd: spi-nor-ids: Add Puya Semiconductor chips description
To: Dmitry Dunaev <dunaev@tecon.ru>
Cc: dunaich@mail.ru, Vignesh R <vigneshr@ti.com>, Tom Rini <trini@konsulko.com>,
 Michal Simek <michal.simek@amd.com>, 
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Jonas Karlman <jonas@kwiboo.se>, 
 Angelo Dureghello <angelo@kernel-space.org>,
 Andre Przywara <andre.przywara@arm.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Bruce Suen <bruce_suen@163.com>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>, 
 Nishanth Menon <nm@ti.com>, Jit Loon Lim <jit.loon.lim@intel.com>,
 Ssunk <ssunkkan@gmail.com>, 
 Jim Liu <jim.t90615@gmail.com>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Fri, 24 May 2024 19:00:29 +0200
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

On Mon, Feb 26, 2024 at 3:56=E2=80=AFPM Dmitry Dunaev <dunaev@tecon.ru> wro=
te:
>
> Added support for the Puya Semiconductor chips.
>
> The datasheet can be found here:
> https://www.puyasemi.com/h_xilie715.html
>
> Signed-off-by: Dmitry Dunaev <dunaev@tecon.ru>
> ---

Applied to u-boot-spi/master

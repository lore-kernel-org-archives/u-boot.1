Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A03CC43458
	for <u-boot@archiver.kernel.org>; Sun,  5 Jul 2026 15:21:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A088F841F2;
	Sun,  5 Jul 2026 17:21:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=riscstar.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="fu9RESIK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E2A87846F8; Sun,  5 Jul 2026 17:21:22 +0200 (CEST)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com
 [IPv6:2a00:1450:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF4CF83314
 for <u-boot@lists.denx.de>; Sun,  5 Jul 2026 17:21:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=riscstar.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eric.chung@riscstar.com
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-5aeb8870485so2465316e87.2
 for <u-boot@lists.denx.de>; Sun, 05 Jul 2026 08:21:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783264880; cv=none;
 d=google.com; s=arc-20260327;
 b=Wy332WX+JeBy8z7Fjhge9rz+s/GXD4272z8iQYAyoDyvejfTMgzfcXCCkwzHLH7GlF
 Fbm3Xi4uHmHdipUTEShuNbf4KCSZMdRWlhE8gxpAXPBVkqITIklKzCdaD4GQ3kjeeifa
 MtdmndwnytnL+Q61AMTfEKCZwr2NJ/CeurlyImZSEP+20gVtz8HfcP9Sthq9mkfv5aHZ
 tCJjGuljvLnWFFTd9HzZh7ob0zB2AdjZPpZbPp3ziANojFeJ77gKwtZYSmBrGdqfQaUk
 gRG7t7Uuy7QWFILxHuBwJXMPzZo7pNwmbsaOnrL59grCE/hlZiOvzsI1IZpEg3l16b5E
 6vkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=KQ04O+NVoASu7NvGx4dVkzL1yACET+kJR0JgxnYA5SM=;
 fh=j8WP9ikAYecthPDilNISmELVe1A7jNJ2Ezu9jYnxyBs=;
 b=lkyXNWSj2imCjpyjydAFUqHMXWPybakmH5GH7WXIECLyIWsGdn/hoodQswzklSave3
 jmw8qtOsZ9JgQi3Omel1Jw0qvsC8Jo0tTrRMOCQ0QCGjAPHMiwSxezxKXNmBkRHaiEyI
 Cn3ow4AD+2ZhWUG1GEUDdhhWrqzHWDbDRuppJujQg4QPaqSlrThx8MjE/JlR+mADMq+D
 tAerKUQ6NCuUIB1Pd196IY6K5dD0tzD4uIqJVIoUqLGecJfEli0Gw6kSudh0ebJecFD/
 sDxMSuEfmo+lF2bezoxSATIiH3E/xPfGOTFs5m3dkNOhPMptNYzQ/0Tb4lcS7n3UAqef
 74Zg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1783264880; x=1783869680;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KQ04O+NVoASu7NvGx4dVkzL1yACET+kJR0JgxnYA5SM=;
 b=fu9RESIKfXrT6erVybTU/2cfAZ4fsEg1XunvN6Hd+nqMYkQfISbBGXbfnpB5/SvqIw
 p+2By35WADED75/q5ptbhTxnnS0muPiA39kV58lLD1KN03N2X9gVO7TtoFJycWaTpYVY
 yG4Ydjbf7rOW4Hu+NEPv5sB+6KZRwgNTXlG3gmfs9UBlWn8B7rgzBOr9srQkhyeXtv22
 9uQZDWjrUJwvMKoVYMzHLGJ/iBEZMkX7s/psLjoWCzb/dC3NxpQaK12eDDJFWUjT0IMn
 G3XyohqnmLJPpmYynzik/gaZnLpY6sEWQMUJX4ZLdQdzxWEcAv5XmTJVaK1Mi0doTP3z
 lW6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783264880; x=1783869680;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KQ04O+NVoASu7NvGx4dVkzL1yACET+kJR0JgxnYA5SM=;
 b=phf+tHXIre/UF82frU1wVA3FqcJ9eU9rTw3Ev5wuJxeJW6rIHQ/P/qHdadZQ5yr3q4
 kIjcaxWNTYjSkXFkqIizTA3HucWX/UuJoId4HF1mqA7VzDOAnbIyZTWdS6GxPIEGgvN3
 ns+hq6sdeZXYUZtnyjmK1J4cEMaxNgw9tfn7x/gTBjseOl8Xuhk1kA7cDwrutQ3KBloH
 8p1NsVCleMgWJEFQ15f7ZExIwwdpEKOvmp0ijQL0QOpKm+m0zvbVG+0FzGj1zQIDviWn
 Uq+BB1hvB3fkVDjJhcYbe7Y0Q3PzWSIF1OnlubDt//Rd+iMPtG+Lvqg6env1S2KoIZEu
 5oug==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq59KuPTvzoDIOxYMMPJpwNU2oinb4rJEmZPswCczt3/v0MvbFCxt8gAjE+9fPQs1hlA+HZGTY=@lists.denx.de
X-Gm-Message-State: AOJu0Yxy2yJo1tK0O3OLNlE6RYIFum+k8YfPuQksTgdYQ7jz5wvN3Vzo
 jVIO2CuJrEpfv8VRof8h83rT4wUHBUDBs8uguKLOO35vlPqb3OrEJRfcW2OPiUlRc8eLq8rsaew
 FZ9qmSj92ZUSVdhgWQVsVG4/Zc93dWcpKzquf5xKKMA==
X-Gm-Gg: AfdE7cmUfT7v1jRbjsD5oqRQeMMoNK/WEO/CTWj6ebs97bJRdukBOaoZW4pD3ElpPVT
 GHOn/YlFukbGupjHy/B59P7pPBooFiY+HFEDjj6Ki0KnVTU98fTwwnWnopr0QqakEIND7m8aQIC
 fRwigxEBHfyHnYFyuhwgPkmfGlyeKhIwl1/iTTQcCplJkivTqTloJI5tKHvOapmJUTHldyARLuz
 BabjP5oHL6ee9DC4Yh8GlONFPmy9Vwsvy/qm9+fbLll/eXTjehvU11Z9hDW9yVVmLWlEpk8RuBU
 lXFoWOP6w4RCIYLAcX22vIdfywdkoNXFZkL6c2G2JgRJ/bCUC4CaipAjXGLBOjL4EEizBTSoEW8
 iNp/g5bJgJtLcSI8wK7H0IBvJzUwKjRfrwhj8M4yg
X-Received: by 2002:ac2:5bc4:0:b0:5ae:c7a2:69a2 with SMTP id
 2adb3069b0e04-5aed50b6703mr1042985e87.39.1783264878075; Sun, 05 Jul 2026
 08:21:18 -0700 (PDT)
MIME-Version: 1.0
References: <20260705-m4-v3-0-5a9bc7f25fc5@riscstar.com>
 <20260705-m4-v3-3-5a9bc7f25fc5@riscstar.com>
 <52987597-bb11-4193-a28e-223eeab093eb@altera.com>
In-Reply-To: <52987597-bb11-4193-a28e-223eeab093eb@altera.com>
From: Eric Chung <eric.chung@riscstar.com>
Date: Sun, 5 Jul 2026 23:21:05 +0800
X-Gm-Features: AVVi8CeTLoEEmborECQPN0i-LW5n-LDei_GmHw2wPiDGW9Xt0u7ZyImN03cnRMc
Message-ID: <CAH22mJwTcvbvoR=Bp2VLm3tgVpVx+wNF9+y-ua37Vw50Qw2O0w@mail.gmail.com>
Subject: Re: [PATCH v3 3/9] mmc: sdhci: enable CMD23 for multi-block transfers
To: "Kathpalia, Tanmay" <tanmay.kathpalia@altera.com>
Cc: u-boot-spacemit@groups.io, u-boot@lists.denx.de, 
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, 
 Huan Zhou <pericycle.cc@gmail.com>, Raymond Mao <raymond.mao@riscstar.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Bhimeswararao Matsa <bhimeswararao.matsa@gmail.com>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>, Han Xu <han.xu@nxp.com>, 
 Yanir Levin <yanir.levin@tandemg.com>,
 Christoph Stoidner <c.stoidner@phytec.de>, 
 Balsundar Ponnusamy <balsundar.ponnusamy@altera.com>,
 Daniel Palmer <daniel@thingy.jp>, Anshul Dalal <anshuld@ti.com>,
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Angelo Dureghello <angelo@kernel-space.org>, Johan Jonker <jbx6244@gmail.com>, 
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>,
 Guodong Xu <guodong.xu@riscstar.com>, 
 Tim Ouyang <tim609@andestech.com>, Leo Liang <leo.liang@sifive.com>
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

On Sun, Jul 5, 2026 at 5:52=E2=80=AFPM Kathpalia, Tanmay
<tanmay.kathpalia@altera.com> wrote:
>
>
> On 7/5/2026 11:37 AM, Eric Chung wrote:
> > Enable the host controller's support for the CMD23 (SET_BLOCK_COUNT)
> > command to manage multi-block read/write operations. This allows the
> > MMC core to use CMD23 in preference to the legacy CMD18/CMD25 plus
> > CMD12 sequence, reducing command overhead and improving I/O
> > performance on multi-block transfers.
> The commit message claims this enables "host controller" support, but the
> changes are entirely in the MMC core (mmc.c) and header. No SDHCI host
> driver sets MMC_CAP_CMD23 in this patch. mmc_write_blocks() in
> mmc_write.c is not touched. CMD25 still always follows with CMD12.
>

Thanks. I'll apply all fixes.

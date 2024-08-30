Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24459CA0EFD
	for <u-boot@archiver.kernel.org>; Fri, 30 Aug 2024 16:49:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E7FE88C09;
	Fri, 30 Aug 2024 18:49:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XQ8HZYSN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6FFE888C8C; Fri, 30 Aug 2024 18:49:29 +0200 (CEST)
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com
 [IPv6:2a00:1450:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7894C88C09
 for <u-boot@lists.denx.de>; Fri, 30 Aug 2024 18:49:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-5353d0b7463so3735508e87.3
 for <u-boot@lists.denx.de>; Fri, 30 Aug 2024 09:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725036567; x=1725641367; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=jMkdA66U3X+N0Wn+uaF5Y287WDGtoiJhVPx4i0RvmJk=;
 b=XQ8HZYSNWBTk9JnqofZa63BYwMV8SS6k0rdqURPMjCkVDxbkR+tOQk7vQBihxV5VDT
 mmORhKi9bBKVzIEQy5X0U5fpXtuyHEMkQTWtbgNg7xDeVWVKJKWVJ1s1onrSaZMZF6UF
 cRwxqcjBjWzT4DWDaRT7ATiUJDUDt3Be/vdVGyoAxZs+ywE1zTZ3EIshv+g6m9/fGqlJ
 dqZLAM/3deJ5ihhRp4RVXqix6gU2D5WsAQkual28TYdotEtxQPZHNNdGFEcInUjTL7ZV
 CO8gAW1ZBSFhdbH0+AisOicvhjxJdqW06M1dIpHUVIWEqFHf7Am83QMJEVXXr3iLOG/k
 DAzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725036567; x=1725641367;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jMkdA66U3X+N0Wn+uaF5Y287WDGtoiJhVPx4i0RvmJk=;
 b=Vu4BVJLfyMnGA8tCA7srzYjc3Jbado2LQgQbv94xPPcD+qZlt3u7MhTxtyw1fzp/3v
 iwIBUmyJzj3bOto4CodfxkDuZTd6uXI3W/t5rKxVcaxK7l6+I8LsQupmoWrBAlyykhvg
 uBPwHwGg0+iWC+4KpIBoFsI8C6AXixKMU5elj5shCn7cRfdFTKXG6qsUiwGJv/yced0t
 75k1mfi0NLrim69M+gmXJbEpExGcaSV0T5uOgS+poiKP/eKoiKlOYpZN407fzVWDaE8W
 9ac/dr1u95DC7HlY1IrBMrrFXcIADOBP0Oe0/XfZvG6ePnRwfjQrWr7/QVbkQYWjZfgY
 EbpQ==
X-Gm-Message-State: AOJu0YylZ2Jf1VJ2cvBTb4xi7CEk+Ra39H/rx9K3R69PlbR0CJtDl3OH
 28UreONUGlWJrNZh4CNTSVKGfJ7jPpqGTXZUWIAVRWYGTb6oRtLQtD3nO/EdZNq4tsv2/fCi6Lq
 u0qYKc3OxtMYnZpThoxMVi4ko7tSYir2y
X-Google-Smtp-Source: AGHT+IFSLe7/nDCn3NUmizWqvZnWP9BfN0teM/yonhiwy117DdgxiCsMI5S2Jhgd7mLkyoY+g6sNfOvMzfHZxI0huWk=
X-Received: by 2002:a05:6512:32c8:b0:52c:9ae0:beed with SMTP id
 2adb3069b0e04-53546bfbf9dmr2529288e87.52.1725036566304; Fri, 30 Aug 2024
 09:49:26 -0700 (PDT)
MIME-Version: 1.0
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 30 Aug 2024 13:49:15 -0300
Message-ID: <CAOMZO5AUvhAGZd5VyiJGXXTKbEHJGysgTPLbjWE4H7wSh697hQ@mail.gmail.com>
Subject: imx6ull-evk: Hanging with Ethernet enabled
To: Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>
Cc: U-Boot-Denx <u-boot@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
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

Hi Peng,

Running top of tree U-Boot on an imx6ull evk board causes the board to hang:

U-Boot 2024.10-rc3-00015-g57949a99b7bd (Aug 30 2024 - 13:46:12 -0300)

CPU:   Freescale i.MX6ULL rev1.1 900 MHz (running at 396 MHz)
CPU:   Commercial temperature grade (0C to 95C) at 27C
Reset cause: POR
Model: Freescale i.MX6 UltraLiteLite 14x14 EVK Board
Board: MX6ULL 14x14 EVK
DRAM:  512 MiB
Core:  69 devices, 19 uclasses, devicetree: separate
MMC:   FSL_SDHC: 0, FSL_SDHC: 1
Loading Environment from MMC... Reading from MMC(1)... *** Warning -
bad CRC, using default environment

In:    serial@2020000
Out:   serial@2020000
Err:   serial@2020000
Net:

If I disable Ethernet, U-Boot boots fine.

I haven't had a chance to investigate, but wanted to report it.

Please take a look when you have a chance.

Regards,

Fabio Estevam

Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F12D3D711D4
	for <u-boot@archiver.kernel.org>; Fri, 19 Dec 2025 02:45:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4E3F2800AB;
	Fri, 19 Dec 2025 03:45:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QraldpeZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 63FC280433; Fri, 19 Dec 2025 03:45:26 +0100 (CET)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com
 [IPv6:2a00:1450:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF4E880050
 for <u-boot@lists.denx.de>; Fri, 19 Dec 2025 03:45:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-59431f57bf6so1397655e87.3
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 18:45:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1766112323; x=1766717123; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=oZ5WyLVu7s8lyDeqH8Ima7FqU08V2VdfsWJAQMr5Lak=;
 b=QraldpeZpLqRi4oXCQ5rhz+/DjI1zevg/PxUDDxhCcGxdnYEz8FwnOFvOlwfrJolFn
 yNY3oDgJRis2UXBF766ZVAgahv752e2aH9FxuGB9ua/D5vWKklCncsMxusOuYSGCD3au
 7r2unhMBXuWdAV8ajWmh+bEuHn+/hcD8QS3wMzMbwF6A58Wpx4vN6ih2qv7ZYWiIhuwQ
 /NXItqpfmQpHFd2C0CeOe16d9arY0ZUrqTW+pcse5KqtJ93W/mBcQR90LTwtKRPryiXL
 SgTy264vLGbPz2n1oUKt+raOAUCnFk5uHj5AnK50ZRdUGL7h5BL51jDHLJ7U5cV8vdBA
 Dg4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766112323; x=1766717123;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oZ5WyLVu7s8lyDeqH8Ima7FqU08V2VdfsWJAQMr5Lak=;
 b=JfDsSh2P0ZuEA+ancarGWcitFszcPU97XiPFc3tJ8OKdishLfn0Dkmn8n4+zfGgXlx
 Y/0BJknXeSUK5Ula2MC6tI+t0pDONyVfznUokq0ChYbZouLhF2jvjFBdSsZeO9WZMd8r
 hLnU9hDquNORygyOb01WpeOCIcWcsz2cfjztB7l3TFRtZb06ANlNbz+IR8DYkXUHwBDo
 AXRxCcpdShGAScYbNkak4e1EoCw+QLe6cz9506JKE0ixoQpLi0BnqdpoO0MBcEcxh0kd
 EGWKhVoJ0A6EY7FiOfE7f/4dCpdEd+BPWpdZrRgGZcXl0lTy+OhHUKBSB/BWxvDkQxho
 I6Dg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXyDqskI57/9/uBSrl8HWxgMc3trfhjk4hd7769xey4OI+LAic8o0qAXDjnHsg85iOBeVHT6aQ=@lists.denx.de
X-Gm-Message-State: AOJu0YyOGkjiPSja9WmjpRL6TS1oKLnoCKLXFE8SOcza2uQGTbkvBTtO
 EJcJe50zspnmMdpnetiYKLHOYUmrjL1nqLRjDQJk635pYSXvi/B71gVWzF/CIl7TXSi5qJoAU/7
 93U4GxP2l8/B3PwM5FHnHiAQt4bVdXW4sVtUT
X-Gm-Gg: AY/fxX5M96FhlZIudcR57A8d+FaOYyQSl3MF421Uy94x2nmZuyZiDxaqLBTLHsXl3el
 CdVi2TSnHOaW7gJIJp0DYofTXoQj1QcKH78dljueohDkizaw+jZoZYNFCuwWLAvdT2aOPDCiC03
 hbg81psuh70s049sf6ybggT++RszOABM1uLvM5AkH90p2Reqknl9mtz+lFsIbz6Yh+EgCovce3N
 RZYLyOqjOoQitagh1Bb6jk1gu7jzobr9CWXMU5c0zN93xSUmTefTJiu4NWgbBT8Qt1EDobYliWv
 TABUWlHT/p9f/coT7kyOMHgsNzs=
X-Google-Smtp-Source: AGHT+IHoIO2XsJsFK31Sr+VcHWu88lTUFe95IsMp/VoPZ97i0pGJqH4HGQ4O3yUL/rSxE8+vZcA8i7fdFwfwwFkRJyQ=
X-Received: by 2002:a05:6512:3ca0:b0:594:2c1f:75e2 with SMTP id
 2adb3069b0e04-59a17d5e60dmr491552e87.44.1766112322975; Thu, 18 Dec 2025
 18:45:22 -0800 (PST)
MIME-Version: 1.0
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 18 Dec 2025 23:45:11 -0300
X-Gm-Features: AQt7F2rk8TA1rsJO8mqXguGv3ZGmhjrlxjIY0htsNoYHa-Gk0zLxy1SDbipggNQ
Message-ID: <CAOMZO5B0HmoyCtHHuOFjTq8n1HRoHxZ0-c-mJ_2e6JoT2heSBA@mail.gmail.com>
Subject: RV1103B: Attempt to upstream
To: Kever Yang <kever.yang@rock-chips.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>, Jonas Karlman <jonas@kwiboo.se>,
 U-Boot-Denx <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>,
 xuhui.lin@rock-chips.com
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

Hi,

I have a custom board based on the Rockchip evb-rv1103 (RV1103B silicon),
booting from SPI-NAND.

I can successfully boot the vendor Rockchip U-Boot v2017.09 on this board,
from SPI-NAND

I am currently working on upstreaming U-Boot support for the RV1103B SoC.
My first RFC attempt is available here:

  https://github.com/fabioestevam/u-boot/commits/rv1103/

Build steps:

  make evb-rv1103_defconfig
  make

However, I am not yet able to boot U-Boot on the board. At the moment,
the board does not boot and only prints "RKUART".

My initial plan was to avoid SPL, similar to the evb-rv1108 approach
(described in board/rockchip/evb_rv1108/README).

Before going further, I would like to ask:

Is the evb-rv1108 =E2=80=9Cno SPL=E2=80=9D boot flow a valid reference for =
RV1103B?

Any guidance or pointers would be greatly appreciated.

Thanks,

Fabio Estevam

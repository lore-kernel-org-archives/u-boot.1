Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51A17D4336D
	for <u-boot@archiver.kernel.org>; Thu,  7 Nov 2024 14:58:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E8F0892A1;
	Thu,  7 Nov 2024 15:58:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ziVAGtNN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9DCDE8927E; Thu,  7 Nov 2024 15:58:33 +0100 (CET)
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com
 [IPv6:2607:f8b0:4864:20::930])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B3E89891FA
 for <u-boot@lists.denx.de>; Thu,  7 Nov 2024 15:58:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-ua1-x930.google.com with SMTP id
 a1e0cc1a2514c-84fc5aaccf8so486108241.3
 for <u-boot@lists.denx.de>; Thu, 07 Nov 2024 06:58:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730991509; x=1731596309; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/p0Ok3rDq5O8CMSSszcA33dM3npCOsdvMIwSqrzSSso=;
 b=ziVAGtNNexIwsH8/J4tAPmBnbl7ZAw8fiUahoOYZI5wRJ++pFZ6PaW3sEoceKw86GK
 zjC4k3yZYI8/km7FdYgT1kJj3BDCGppFQVDOLs2aDCrUaP+wxkUPm58+pb34Q7ttfQIU
 JiEUSJn9yh4nUz0FwXna3/hEo0qhzxMz6Vjb5OIybiNWpPiEGFck7EOIl0ut5gEseI3z
 q515ZC4m3JEgdxZf2x861CL7SWkcupXyNI+/rddyDp97Bem4k6cbznme0/sMx1ItjqA1
 crDoQ5I62I3QCwM70zq7ImTUrZ160ZuHiRQqSlQxZJ89Z+RVmzY5ajqTwVYcZQZOw0Td
 kEog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730991509; x=1731596309;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/p0Ok3rDq5O8CMSSszcA33dM3npCOsdvMIwSqrzSSso=;
 b=atoazZQVlAn+e4hanhpwbFyZ9p1zutLfSSvTuU34zwta1G9txzy5oHDKxlZCY8pC+9
 kWnmuEwiVU1Chs23xRQqSNhWnzaOYzR45qUHz7Lpz9xBtlpysYXMz0x5yaIjpY9jSDi4
 c1z4b6CAv+jwldWDU1bBQkYIidWD+TJfn1JgmcZ4DKGxsEKkM3vU/bMvlaCbUZbp+UWu
 mu3jeVOLplYQQntdDr2DNhtDCBCnjJMAV3CcoJXIDIghGSy8FTjmZkRkySE/j8/LHABh
 6aB0yXeq2TodDcX3lw7PWu0Pp9DEm2gQ1cueRBKtGe0VpB2whAv8mYV7B7FjZFRqtByb
 PeTA==
X-Gm-Message-State: AOJu0YxVldlLw4kiLZy6X1NJqOXVsC4rheosAc4/Y109oJ6Ig+hFtXCU
 Q33vI/LS9K0bjI41s+fP6S7m1q5di6AwZRe2Q1GgFh/1Z6cUeH5vn3snEkB24pIuQaJhcDhWya2
 dvETXZcBc/ifLpFj6YMDeuS5Ygc0SxzzMf73LQg==
X-Google-Smtp-Source: AGHT+IGEwyxB4IrJShb4HTkBsB3GlqeSteq/LQmR5SPjb6q8+Y6PzjuXCSHuzQmuc2mXyXemmLlWrg/2Qfmq1csQHrI=
X-Received: by 2002:a05:6102:f98:b0:4a3:d3d5:4435 with SMTP id
 ada2fe7eead31-4a962f3a1b8mr24485031137.21.1730991509546; Thu, 07 Nov 2024
 06:58:29 -0800 (PST)
MIME-Version: 1.0
References: <20241106210348.218507-1-dregan@broadcom.com>
 <20241106210348.218507-3-dregan@broadcom.com>
In-Reply-To: <20241106210348.218507-3-dregan@broadcom.com>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Thu, 7 Nov 2024 14:58:17 +0000
Message-ID: <CAFA6WYOjNjAQxy8fkA9PWE-bxag-v=_p+Y48McuWaHaqK_axHw@mail.gmail.com>
Subject: Re: [PATCH 2/4] arm: dts: Use upstream dts
To: david regan <dregan@broadcom.com>
Cc: u-boot <u-boot@lists.denx.de>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>,
 Anand Gore <anand.gore@broadcom.com>, 
 William Zhang <william.zhang@broadcom.com>,
 Kursad Oney <kursad.oney@broadcom.com>, 
 Philippe Reynes <philippe.reynes@softathome.com>,
 Linus Walleij <linus.walleij@linaro.org>, 
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Kamal Dasu <kamal.dasu@broadcom.com>, David Regan <dregan@mail.com>,
 Tom Rini <trini@konsulko.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>
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

On Thu, 7 Nov 2024 at 00:53, david regan <dregan@broadcom.com> wrote:
>
> Make use of OF_UPSTREAM which uses Linux dts.
>
> Signed-off-by: david regan <dregan@broadcom.com>
> ---
>  arch/arm/dts/bcm47622.dtsi            | 126 ------------
>  arch/arm/dts/bcm4912.dtsi             | 128 ------------
>  arch/arm/dts/bcm63146.dtsi            | 110 ----------
>  arch/arm/dts/bcm63158.dtsi            | 278 --------------------------
>  arch/arm/dts/bcm63178.dtsi            | 120 -----------
>  arch/arm/dts/bcm6756.dtsi             | 130 ------------
>  arch/arm/dts/bcm6813.dtsi             | 128 ------------
>  arch/arm/dts/bcm6855.dtsi             | 257 ------------------------
>  arch/arm/dts/bcm6856.dtsi             | 253 -----------------------
>  arch/arm/dts/bcm6858.dtsi             | 272 -------------------------
>  arch/arm/dts/bcm6878.dtsi             | 111 ----------
>  arch/arm/dts/bcm947622.dts            |  30 ---
>  arch/arm/dts/bcm94912.dts             |  30 ---
>  arch/arm/dts/bcm963146.dts            |  30 ---
>  arch/arm/dts/bcm963158.dts            |  30 ---
>  arch/arm/dts/bcm963178.dts            |  30 ---
>  arch/arm/dts/bcm96756.dts             |  30 ---
>  arch/arm/dts/bcm96813.dts             |  30 ---
>  arch/arm/dts/bcm96855.dts             |  30 ---
>  arch/arm/dts/bcm96856.dts             |  30 ---
>  arch/arm/dts/bcm96858.dts             |  30 ---
>  arch/arm/dts/bcm96878.dts             |  30 ---
>  arch/arm/mach-bcmbca/bcm47622/Kconfig |   1 +
>  arch/arm/mach-bcmbca/bcm4912/Kconfig  |   1 +
>  arch/arm/mach-bcmbca/bcm63146/Kconfig |   1 +
>  arch/arm/mach-bcmbca/bcm63158/Kconfig |   1 +
>  arch/arm/mach-bcmbca/bcm63178/Kconfig |   1 +
>  arch/arm/mach-bcmbca/bcm6756/Kconfig  |   1 +
>  arch/arm/mach-bcmbca/bcm6813/Kconfig  |   1 +
>  arch/arm/mach-bcmbca/bcm6855/Kconfig  |   1 +
>  arch/arm/mach-bcmbca/bcm6856/Kconfig  |   1 +
>  arch/arm/mach-bcmbca/bcm6858/Kconfig  |   1 +
>  arch/arm/mach-bcmbca/bcm6878/Kconfig  |   1 +
>  configs/bcm947622_defconfig           |  11 +-
>  configs/bcm94912_defconfig            |  11 +-
>  configs/bcm963146_defconfig           |  11 +-
>  configs/bcm963158_defconfig           |  11 +-
>  configs/bcm963178_defconfig           |  11 +-
>  configs/bcm96756_defconfig            |  11 +-
>  configs/bcm96813_defconfig            |  11 +-
>  configs/bcm96855_defconfig            |  11 +-
>  configs/bcm96856_defconfig            |  11 +-
>  configs/bcm96858_defconfig            |  11 +-
>  configs/bcm96878_defconfig            |  11 +-
>  44 files changed, 121 insertions(+), 2254 deletions(-)
>  delete mode 100644 arch/arm/dts/bcm47622.dtsi
>  delete mode 100644 arch/arm/dts/bcm4912.dtsi
>  delete mode 100644 arch/arm/dts/bcm63146.dtsi
>  delete mode 100644 arch/arm/dts/bcm63158.dtsi
>  delete mode 100644 arch/arm/dts/bcm63178.dtsi
>  delete mode 100644 arch/arm/dts/bcm6756.dtsi
>  delete mode 100644 arch/arm/dts/bcm6813.dtsi
>  delete mode 100644 arch/arm/dts/bcm6855.dtsi
>  delete mode 100644 arch/arm/dts/bcm6856.dtsi
>  delete mode 100644 arch/arm/dts/bcm6858.dtsi
>  delete mode 100644 arch/arm/dts/bcm6878.dtsi
>  delete mode 100644 arch/arm/dts/bcm947622.dts
>  delete mode 100644 arch/arm/dts/bcm94912.dts
>  delete mode 100644 arch/arm/dts/bcm963146.dts
>  delete mode 100644 arch/arm/dts/bcm963158.dts
>  delete mode 100644 arch/arm/dts/bcm963178.dts
>  delete mode 100644 arch/arm/dts/bcm96756.dts
>  delete mode 100644 arch/arm/dts/bcm96813.dts
>  delete mode 100644 arch/arm/dts/bcm96855.dts
>  delete mode 100644 arch/arm/dts/bcm96856.dts
>  delete mode 100644 arch/arm/dts/bcm96858.dts
>  delete mode 100644 arch/arm/dts/bcm96878.dts
>

Glad to see this diff, FWIW:

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

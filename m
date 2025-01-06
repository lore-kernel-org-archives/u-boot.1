Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB045E77188
	for <u-boot@archiver.kernel.org>; Mon,  6 Jan 2025 11:11:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 44652801E8;
	Mon,  6 Jan 2025 12:11:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WgnxlCA+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5D71C8036B; Mon,  6 Jan 2025 12:11:27 +0100 (CET)
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com
 [IPv6:2a00:1450:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 60D5D801DE
 for <u-boot@lists.denx.de>; Mon,  6 Jan 2025 12:11:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-30225b2586cso160187721fa.0
 for <u-boot@lists.denx.de>; Mon, 06 Jan 2025 03:11:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736161885; x=1736766685; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GOaW1ry6ugS72DWBpCPAxPNzxO3TkYH1ucHjc0hUuEo=;
 b=WgnxlCA+nOYqAoGwvvMHGm7Zd2aF0zAHYk+tbsB0YOzy72+riorencLX+XmZOWRXRi
 IHmnUfqwrbXxuTzDcUJdZWDr/gWozIh4k2kNztPeK09ilHVMbe1Gh7KW6YCDTTEkmAru
 g7wHpe3GMSWHjAhupTZm0rvonS9eI9U69HW6V5BNJ649Vy+ZLJCBScJY8QaCe1IdCHmj
 bpiiBBUXVWpgT3NeVEBwosJIsmxEIlne5YQSMkwly/JZ64NAhl3YzjY+O2GenU7PQ9K7
 ZflB3JMwXoBkKO57jroQSNbeqVCdzXMbkdB83k0hxPQVSoiM5e675k2JNqldJ7uwz7Ze
 N3cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736161885; x=1736766685;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GOaW1ry6ugS72DWBpCPAxPNzxO3TkYH1ucHjc0hUuEo=;
 b=Wv0ogimEzsb8N3S7v3lfXBrqaN/Qwgvj/kUdCBL5x2NAj47OCUut1H1zXs6XGplNiM
 Ifarm+kAEdFTrcznqpOTIXieYRpD8Nqq4y17EZaTlcxscGmu1jTAN1DVQAJhGbCV+ZoT
 QQXPVwXK4/ANcOgy9/aVOJeclkc5Pxq0CUormDevANVh61aYtxVcoU5QqfwbzRWke0uX
 klc5IH/BEjXjwqi9CNTI10eGKeLH1iMz0M+g20wEWtJkYPbsOjCZgGdODlgdQNKKSoj/
 EBwXoYobcnEajlClri1zYLAeGXlsQEGHyJC9sATFLXjPxO9oFeuHVU5KSxrjNN/MDM7y
 SvFg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUwcm28OVPzHktRL7/cxfLlRLyEgXyQijWD/4gDJbdUVxXzBCxgdZbQlstth6mPzbnVSem3m0Q=@lists.denx.de
X-Gm-Message-State: AOJu0YzzeGroLToG8EsYTgdJ5rf/tDtOvrBWtu2FFJilPYXTaoYKdmn2
 /SHfFBZhZK/Pw1TIvfU/sRbIddiXdjoe4MaV0O7Vy6ETG1jCvu6k71wz+ezhKbtRpDhcnbT79d0
 QY5bO5GNkMUtnYQ7c79qhe+hwRmw=
X-Gm-Gg: ASbGncutgOzabuwXqky1NlaVePJp8Dzdv2KtreLeXWsI18dzwMQlP/WkEQiUKSYLasJ
 AFS/SHxNNMBjWFMhoDfEHeXmGXTj70xWltfhB6UUw5Knxi/6qgzxC5fNzRhUbgJBlY2VKpQ==
X-Google-Smtp-Source: AGHT+IH4SWKib2L0hrJ8aJlpCAB41MqqimxKacW71ba8rEF189lOMJq00BbjZrW4j4ktXzkY34Y/mI/nQl3HrjGZHRE=
X-Received: by 2002:a05:6512:3f0c:b0:53d:f2e8:b37f with SMTP id
 2adb3069b0e04-542294256f8mr17569283e87.6.1736161884536; Mon, 06 Jan 2025
 03:11:24 -0800 (PST)
MIME-Version: 1.0
References: <20250104-imx-bootstd-v1-0-e09618cc1d65@nxp.com>
 <20250104-imx-bootstd-v1-10-e09618cc1d65@nxp.com>
In-Reply-To: <20250104-imx-bootstd-v1-10-e09618cc1d65@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 6 Jan 2025 08:11:13 -0300
Message-ID: <CAOMZO5B5Q-253ryFZkUXZhz5AvaJDubthywm2x7hBDLVBMBquw@mail.gmail.com>
Subject: Re: [PATCH 10/12] imx: imx8mq_evk: Enable dynamic settings to mmcdev
 and mmcroot
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Stefano Babic <sbabic@denx.de>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>
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

On Sat, Jan 4, 2025 at 12:20=E2=80=AFAM Peng Fan (OSS) <peng.fan@oss.nxp.co=
m> wrote:

>  #include <env.h>
> -#include <init.h>
> -#include <malloc.h>
> -#include <errno.h>
> -#include <asm/global_data.h>
> -#include <asm/io.h>
> -#include <miiphy.h>
> -#include <netdev.h>
>  #include <asm/mach-imx/iomux-v3.h>
> -#include <asm-generic/gpio.h>
> -#include <fsl_esdhc_imx.h>
> -#include <mmc.h>
> +#include <asm/arch/clock.h>
>  #include <asm/arch/imx8mq_pins.h>
>  #include <asm/arch/sys_proto.h>
> -#include <asm/mach-imx/gpio.h>
> -#include <asm/mach-imx/mxc_i2c.h>
> -#include <asm/arch/clock.h>
> -#include <spl.h>
> -#include <linux/bitops.h>
> -#include <power/pmic.h>
> -#include <power/pfuze100_pmic.h>
> -#include "../common/pfuze.h"
> -
> -DECLARE_GLOBAL_DATA_PTR;

Same here: sorting includes and removing DECLARE_GLOBAL_DATA_PTR
should be separate changes.

Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DC6BC369AB
	for <u-boot@archiver.kernel.org>; Fri, 25 Apr 2025 02:03:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4A9B98082A;
	Fri, 25 Apr 2025 04:03:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="F2EUDABm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E84FA809D4; Fri, 25 Apr 2025 04:02:59 +0200 (CEST)
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com
 [IPv6:2a00:1450:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE0DB8059A
 for <u-boot@lists.denx.de>; Fri, 25 Apr 2025 04:02:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-3104ddb8051so19837011fa.1
 for <u-boot@lists.denx.de>; Thu, 24 Apr 2025 19:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745546577; x=1746151377; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PIucqkKFQTcA7jms45Ni6jpDKFFF4n0tp6i933oRK5s=;
 b=F2EUDABmARGjcq+5wCen2XbWmdUc91gmxyJJdL6Kjh/4davwp65qU8Ug9KxZfLkQO2
 sCU/iAWCsI/1tG8yQAT9wpKgsTvzSeot7RRweHOy6gxlmJg2mzgqW1WNibe94phCtkFg
 OeBrZIWAHYh+ViDPPOmn5vRHg/jdzQJJftyRIlk9uIz8dL8D44sUsQER5Y3DWRd030vb
 oTpJNWhTYUxciB2K4VmDZU3Lv8y+YxpfJzc90WrytPo3li0tP7fz+jf0dJGNSk6Bai1E
 H1DipkBy42DiQRg5PbQgnKVZE5mrBHUwFZthy6NsF0hNvNG9YGgRzy75/mDT2ag3qtKj
 whgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745546577; x=1746151377;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PIucqkKFQTcA7jms45Ni6jpDKFFF4n0tp6i933oRK5s=;
 b=GjRQameGr7QTnrBAb73O4dtaoDdJoN/V2fudBErbqTQ6qXSz7GqDZTwLOR5iwinys7
 qWujGT/DrTgZKnds+pQAkwD+gJTIik1JldJ+wdfbw8r87PYOQYll2IrQBVhjooJJZ4hW
 lIjAzwkei/Kc3ZC0QeHkNqr0WwyqybVdOY+VQA1nExXvtTf96mxjRisLKaKpoYlL+sSk
 0hjfryy+dZbu3Q+fs+TNEckZ6nzAMM/TC+NFKrXEvt7fZRPqI5m99X0VyKiZK2MndvJ5
 GyM9pRQQYkpcmq3RI3Di8igY1hQeSv3HyVqpljoTz6pKHEJjMtV3GAXDnAC5wynBPlvh
 he8Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVZJUz3Ms0pbubHxhuZbBB2/Cq3w8woti4fp3TtFzUT0HYGRCxB/WHRHTagGZnC37Wq7V5tYKs=@lists.denx.de
X-Gm-Message-State: AOJu0Yy/aj82r+P3UbELlkDJm5mmOtSqOt4o/Ryf/OEtJmDE2c5qZgUy
 ro0xdakd87//Ds7eCZpt51OhHcsAXIYssfKZWxaW6q+Pq92b1X9yqe3wKhAfvRXQFDvrlh0KTkz
 Zuq0lmwDjgaqXOCtR237S5zuyM5w=
X-Gm-Gg: ASbGncvK8MOhShroXm41MeUn7nThhoMwJOQFsVtE0uIz+2d0MeVVW4GfT9mh8+/TcqQ
 nHYT6in1SLnYXlIvE5Ty2st3KKS52ewxZEqiDmHc2sVWGyckQx42WB/QXhZFhtiLC8M1fwOnQc8
 mcE+wfURqx/ek6xWtPDWhGNH550hOQCjCWBXjfHWDiHw4RTZhX+MmAVknPeGMqH/Db
X-Google-Smtp-Source: AGHT+IEyUMY4u6kVbnWLOa0jsrmPFj9ukZwVrfp1lGefrPTzZedbYdqrGqBIbGldcbq5Xd7er+YwhI7BIhx4fOnw7PM=
X-Received: by 2002:a2e:a9a4:0:b0:30b:fe62:2329 with SMTP id
 38308e7fff4ca-31906058e4bmr947621fa.11.1745546576628; Thu, 24 Apr 2025
 19:02:56 -0700 (PDT)
MIME-Version: 1.0
References: <20250417171101.2566447-1-festevam@gmail.com>
 <5eb55cce-28b0-436a-85c4-dcf86e6c6554@denx.de>
 <CAOMZO5C_9yojvxO1NoNjtTHxD85ZcGd_cK2t-rofyY_Zxm1xcg@mail.gmail.com>
 <CAHCN7xLkDnLX5PHFNjXYn7AFXA5+S22aksgv62PpWpg80ZDQmA@mail.gmail.com>
 <d81112ad-017b-491a-b517-de828dd30c25@denx.de>
 <CAOMZO5CpQ-yv=8GhNv7=yjnA+uzzP9ZmB=P2d+xmhY1ktQJX9A@mail.gmail.com>
 <28b4bb24-4c56-4fe3-ae9b-db43c63290b1@denx.de>
In-Reply-To: <28b4bb24-4c56-4fe3-ae9b-db43c63290b1@denx.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 24 Apr 2025 23:02:45 -0300
X-Gm-Features: ATxdqUE0jGEoMYfm3SbXT0dJGs4gtjbDkx_VyXZLdHmWgF-daZXm8J4btVjtKpU
Message-ID: <CAOMZO5Cz1atyi0OSOrzUfSGiLb-9XdnyX-d8L7un5PuAdkBeBQ@mail.gmail.com>
Subject: Re: [PATCH v2] clk: fixed-rate: Use "clock-output-names" to name
 fixed clocks
To: Marek Vasut <marex@denx.de>
Cc: Adam Ford <aford173@gmail.com>, trini@konsulko.com, lukma@denx.de, 
 seanga2@gmail.com, francesco.dolcini@toradex.com, u-boot@lists.denx.de, 
 Fabio Estevam <festevam@denx.de>
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

Hi Marek,

On Sun, Apr 20, 2025 at 4:20=E2=80=AFPM Marek Vasut <marex@denx.de> wrote:

> Can you send that as a fix ?
>
> And also, fix this patch up and drop the bogus second half of the commit
> message and do a V3.

Sorry for the delay.

I found another issue on an imx8mm-evk board.

U-Boot SPL 2025.04-01379-g10f48365112b-dirty (Apr 24 2025 - 22:56:59 -0300)
No pmic
WDT:   Started watchdog@30280000 with servicing every 1000ms (60s timeout)
SEC0:  RNG instantiated
Trying to boot from MMC1

(Pause here for about 3 seconds)

NOTICE:  Do not release JR0 to NS as it can be used by HAB
NOTICE:  BL31: v2.12.0(release):v2.12.0
NOTICE:  BL31: Built : 15:28:24, Apr 24 2025


U-Boot 2025.04-01379-g10f48365112b-dirty (Apr 24 2025 - 22:56:59 -0300)

CPU:   NXP i.MX8MMQ Rev1.0 A53 at 1200 MHz
CPU:   Consumer temperature grade (0C to 95C) at 37C
Model: FSL i.MX8MM EVK board
DRAM:  2 GiB
Core:  188 devices, 24 uclasses, devicetree: separate
WDT:   Started watchdog@30280000 with servicing every 1000ms (60s timeout)
MMC:   FSL_SDHC: 1, FSL_SDHC: 2
Loading Environment from MMC... Reading from MMC(1)... OK
In:    serial@30890000
Out:   serial@30890000
Err:   serial@30890000
SEC0:  RNG instantiated
Net:   eth0: ethernet@30be0000
Hit any key to stop autoboot:  0
u-boot=3D>

The issue above is the long pause after "Trying to boot from MMC1".

If I manually revert commit b4734c9c333b ("clk: imx: Convert
clock-osc-* back to osc_*"), then it boots normally, without the long
pause.

Applying your patch helped resolve the USB issue, but not the long pause is=
sue.

Thanks

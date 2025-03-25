Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21A9DC36008
	for <u-boot@archiver.kernel.org>; Tue, 25 Mar 2025 22:00:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0BABD8192A;
	Tue, 25 Mar 2025 23:00:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ewQQRLQu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F9B381951; Tue, 25 Mar 2025 23:00:16 +0100 (CET)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com
 [IPv6:2a00:1450:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 569BD8186D
 for <u-boot@lists.denx.de>; Tue, 25 Mar 2025 23:00:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-54afb5fcebaso301603e87.3
 for <u-boot@lists.denx.de>; Tue, 25 Mar 2025 15:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742940014; x=1743544814; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rmewDLTBA2bhpxkRC+JrVj0aQUGe0XClBmSTxdkpvTM=;
 b=ewQQRLQuagnRk94hILAtK+xjC1/oHSO04UX71pDyfIQ4quLzMhz0QqpXDFs304R/fV
 CZ/49KiwMAmcwUw1T1vwp5TLD/ouG1IR0R6MfgSzZ0ZSAFCMEZ3M3TYE/XA1KFPr/Qa+
 S7EV3tHbqJuKoGpBSNkAORX9z6vlYzH0Z6VeGfvJ2/nQwhq33/7AFtIxg2zFJ9+sFaqe
 tbok/SaNlAMfBSgTutd7xa0y+i0kRF5lck852m9kQYO4YFVby36589/h+VtTE9Vw34Yf
 KGHcUsa1hbCDvov1bqjRSCPdruc6br/G6/EPqC3TLFf9MQS1n1b86OmMtj6MhdZ7qGJL
 ocvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742940014; x=1743544814;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rmewDLTBA2bhpxkRC+JrVj0aQUGe0XClBmSTxdkpvTM=;
 b=JHn81I3CSrapKO00iv5STQTJFPzfIteeQvamLof+ISOnm/WjNCimINdO7uSWkBdiyp
 F4tKTDzr67GX1XRlhRx1HHSHOSydTSQshkpgnU712S4JNSZCGKcuXvoIDoxZAJDnoao6
 Z/dO+FeDZxmM1ua0mJMWfp793sUh2x6tsjua87m4ZL9dWu6pE4GpH8PsDX1oRdJ8NTDg
 ATg58JEq+KFdz0r+6JM+mXuoPUvRfdp1tAyw4kOFymLTXPVo11wpnVWzQ1WdpqcGUoRW
 KOgnKDBoNAHO+LyZi0+hBop2FwRX55LOgyM4MaXlDtLSbyw9BKdlOayCow/Oa8Jkvm7h
 699Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWz9hulg4iGRoAZQ+SRSK/q37hqtRq1oRJI3pokChYNcJCD4PMUB9vvVFE8Pt801g6aCB7EpB4=@lists.denx.de
X-Gm-Message-State: AOJu0YwEDCCvFu9OUdys4YylV6WSRczfrIsIqlsg8rxue1o4X13sRf8U
 laDkQIlZm4BMsM8xXmBaCixJ9O8HMaUNNKmhYR2LC/rXphdool+DAMlDb0/IlCMT8wNErenmBx0
 ODLaYDuD7IVPbGVzG1zrZjp0pOcI=
X-Gm-Gg: ASbGncvuOja1S/Xl8PjSkaUEGWRhHA7koTKsK1a3Rv+Am6qApRjfgP4u/Qdt12vHk+T
 4pxqYkvbM8BnBjQqUJhYlh8vYTAtXr0yY3S+oKBMA6xfER299QoGOUFjg0gZtgv+jO3IlfkpOGi
 X14iWRjD4ROea8NRnbPQdQdJt7ENEDIc+ghiozDNLG1s5F2LsR5cZIcKjW0w==
X-Google-Smtp-Source: AGHT+IHK4Oj5lwpJXxLMxJJkNQCmZfXMBa7CKiZ3C5kk+feZ37amus5yqsZ0YBmRxbVdaFVBHr8AvfUTsC2BoHTU/5Q=
X-Received: by 2002:a05:6512:3d23:b0:540:2da2:f282 with SMTP id
 2adb3069b0e04-54ad64f4ef6mr5966615e87.42.1742940013307; Tue, 25 Mar 2025
 15:00:13 -0700 (PDT)
MIME-Version: 1.0
References: <20250325025452.950303-1-aford173@gmail.com>
 <20250325025452.950303-5-aford173@gmail.com>
 <6f58a557-d5b4-4bc7-87b0-6ed626ec534a@mailbox.org>
 <CAOMZO5CT0uevQaPWPAHM0qVULy+f6rsbwE72Kkph48ghpOSKkQ@mail.gmail.com>
 <CAHCN7xJoJYmZCG7e+zv3cJc8B460kqWpz8v-KibsVsHJzbpjUA@mail.gmail.com>
In-Reply-To: <CAHCN7xJoJYmZCG7e+zv3cJc8B460kqWpz8v-KibsVsHJzbpjUA@mail.gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 25 Mar 2025 19:00:01 -0300
X-Gm-Features: AQ5f1Jr3_hDKymtFtBEuEng_uLm3GuDhOoQd0p0JjAObzYvM6kVXj1keJ0alLQI
Message-ID: <CAOMZO5DxKOF4qD7zknYxz=UihHSQrH=OBX3ZqUO6-vsdZoNGmQ@mail.gmail.com>
Subject: Re: [PATCH V4 4/7] cpu: imx8_cpu: Print Speed grade if IMX_TMU.
To: Adam Ford <aford173@gmail.com>
Cc: Marek Vasut <marek.vasut@mailbox.org>, u-boot@lists.denx.de,
 aford@beaconembedded.com, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>,
 Heiko Schocher <hs@denx.de>, 
 Enrico Leto <enrico.leto@siemens.com>, Peng Fan <peng.fan@nxp.com>, 
 Yannic Moog <y.moog@phytec.de>, Gilles Talis <gilles.talis@gmail.com>, 
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, Ye Li <ye.li@nxp.com>, 
 Christoph Stoidner <c.stoidner@phytec.de>, Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
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

Hi Adam,

On Tue, Mar 25, 2025 at 9:37=E2=80=AFAM Adam Ford <aford173@gmail.com> wrot=
e:

> Once this is complete, I'll have a smaller patch series which shrinks
> my 8MP SPL code by around 4k by #ifdef'ing out dead code.  Hopefully
> it's not too cluttered, but that smaller series depends on both the
> UART clock and the CPU_IMX updates.

The two series are present in the next branch now.

Feel free to post the additional improvements.

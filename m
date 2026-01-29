Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E28BD358F5
	for <u-boot@archiver.kernel.org>; Thu, 29 Jan 2026 10:08:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E930583CBD;
	Thu, 29 Jan 2026 11:08:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mkK44O4Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0CD0E83DA9; Thu, 29 Jan 2026 11:08:26 +0100 (CET)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com
 [IPv6:2a00:1450:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1CD2C83C8C
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 11:08:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-59dd4bec4ecso877949e87.0
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 02:08:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769681303; cv=none;
 d=google.com; s=arc-20240605;
 b=VYOvPePaiACt/UNRfqiZzSbloQGWCaBvRTF0oTXElfLao2wi8zAIqDbm6FnLyYmdhJ
 T7j1GaKyoVwvzF+Da4UiusupplYE0eyfZ74wVQuiQrbopLJDYE0JY3LpHPpq2z8elfcG
 6s3MXkdT5awCbA5LSIxPjVo6Wx1y1fU+LRrGTKETdFpQ6NwFQIhg5KXWD5ujtUCQyIRK
 O4Vm/1hANaeeA74YLncGz9ZsjEIF97H8SqN/xK9a4i4e6cl2GlVVF5LCPalqK1PU4ypX
 uAwKUHsZbpK+KJuzvGBgiES9D2OiepaP748pz9VgMw1V74BNRvkctzLrrnUSllZ/9y55
 7U9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=7G98bJj4cnZ4aTkfzovmADg5lN7f6c6qrdEeETdygoQ=;
 fh=p6MXb22yGHjcOSAhxt9rqYfJ8/fMqraBxRauuqGAbTU=;
 b=T4NhB8BLoWnnmpI9mzBw8LZkMSHJ+r7M8b/IS8OC6KZLLe958efWxiN7mozS/AzFr2
 jbmy8EWM3vWc6zH8HVt+IvEZ21q3+emy/M166f8ZQaN8rSyJhfEdmriOQv3AYdL0yrX8
 JAZd26spKUyAwEjiYcoVojFiANaiAiKVf+XanMxGA9pPs3RqpgaE4QJUDW45Fh1kXI6q
 7RAcoRWfXoFmGFlsYRJ4JWq1cv0CnHMSuf/VmWVU2puwGMTgVFgo9i9J1oFa0mVo+Hac
 FRdirJU3nVyrE0fK18b/XfdvUrrV15X66kz5uwi4GSnTIGQ5og0yLDcBktQF+6VIPkaC
 VYpg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769681303; x=1770286103; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7G98bJj4cnZ4aTkfzovmADg5lN7f6c6qrdEeETdygoQ=;
 b=mkK44O4QnJvras/LhLsJbPvAb2a1Py4d/eyzBJyzEc2pkXFr6CFi1Wy/+hsBgiMcJ8
 FWGPNbyz+lXwAk9QF5kW0PqHHx4u2fDW0FczO+ycPhVqr12NtaTvpD3eYkJ0B1dOJukD
 vHiyJvgANby4ftaZu1xDEVmSa3PBy+HgfNU48EaxcRX6IIJLK63lco2bDrqoiKzKK1LM
 5fZY88nJrtpvEgQ31B355/KInwZ7bAl9EinNg1zkKagUMNSXzTdEsf2KwMW93uO59ioP
 hP3LuC1PBHTCtozyPAb4DkVNsOBgHPUCQNHmPV9rfnLhqIwnsq8zMgeSrLqJjyPdD3jE
 Vs0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769681303; x=1770286103;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7G98bJj4cnZ4aTkfzovmADg5lN7f6c6qrdEeETdygoQ=;
 b=VetTh3bb4zNobm0QhaTw0HJ4fmYNI79/DuJCzfMxhCNfazZnXDIRgr+s+wEsFS2YV8
 yybRkzNhgT2KqXvglg+cfP+qTu+ETD/Vc6rLaJhP10W0t21owkIjwMYq8K86AHFtv5HJ
 sUiKLByte/ezIHX52xzAYgf2Tw3At7B/ziW4Yq3R4Z1WBsNTpPFog8ZQPMrF/5sYspDN
 7uIbOOCYhecq2kVuGZ2vOzJUxpBT1euxSm9IZPOp5R4mDvaLiQBHJ5gEcNj/gMSlHSmH
 u5tAGt70tHbqr8CvR0PeFv2gJwukWoKRVo2a3eRcAxgRkQSZLf6lm09uxu86r70mnMcC
 ujJA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVxikqq/BNYDuYE3KwTx8sHwZbD4TvEAw5kVsx5FrfVb+ppNZ1BhJ/5AL6u7ivVbs3AnQl3mQY=@lists.denx.de
X-Gm-Message-State: AOJu0YyIdEVFT3WMRW15BoblLHNZfkWI2WjMLzsNus2bWlG9Hhrw8jRF
 e9tNGzGvMZMlL8F51Tb4WCWKTHrVFwen2DhCn8fIcVySEPAA59oJSpcAdALYG2r2yBxbQKubRvZ
 YVgAAaX9S4XdI71rsK93FT1vPS1FTr70=
X-Gm-Gg: AZuq6aL9RtWzNKbn3UhGP0J5G8gKYBsd/QQd8SGrW/6xvLY+1JuFb+MsDR6sMrLbi95
 6kHL3CuhIesqeCh7WPeqFCutpNokhP+YYqeDDUUVuUnxvDQQFhn4cBopWFFzwkdaieli+6ELfyn
 /WZCseZMIMon1X45SdaznHWCEE0aa14vyYtgm9peNDQ1NVyOhULLtYV6CNZTkQ78+ZEDVVfLiqC
 c+6bsYyu7jVTLnAsyPekKBuExYF57WQsfCRrZ5DfKCdx6vvBY7oV+hlPWzGVW+YwIY9tZgkLDJb
 tMV+QBRxYgn3REJ/V0UcYXKR5Vg=
X-Received: by 2002:a05:6512:a8a:b0:598:853e:4866 with SMTP id
 2adb3069b0e04-59e04035474mr3625805e87.51.1769681303027; Thu, 29 Jan 2026
 02:08:23 -0800 (PST)
MIME-Version: 1.0
References: <20260129-imx95-rproc-v1-0-035b2dbf3e57@nxp.com>
 <20260129-imx95-rproc-v1-3-035b2dbf3e57@nxp.com>
In-Reply-To: <20260129-imx95-rproc-v1-3-035b2dbf3e57@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 29 Jan 2026 07:08:11 -0300
X-Gm-Features: AZwV_Qhn4ltUOLEQKi1_pyE-G6YttadpeGjZIFPaqr2_IEXZhsgLxhyDWVE1pfc
Message-ID: <CAOMZO5A0WEQTwCFOUS=Q7Re5=CPYgNMdX2LcJxM7D9NbOdB_Rw@mail.gmail.com>
Subject: Re: [PATCH 3/4] arm: dts: imx95: Add cm7 node
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de, 
 Stefano Babic <sbabic@nabladev.com>, Ye Li <ye.li@nxp.com>,
 Alice Guo <alice.guo@nxp.com>, Peng Fan <peng.fan@nxp.com>
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

Hi Peng,

On Thu, Jan 29, 2026 at 6:10=E2=80=AFAM Peng Fan (OSS) <peng.fan@oss.nxp.co=
m> wrote:
>
> From: Peng Fan <peng.fan@nxp.com>
>
> Add i.MX95 CM7 node for remoteproc usage.

Please explain in the commit message why this is being added to
u-boot.dtsi for now.

Also, as part of this series, please add a new patch that adds an
i.MX95 entry to doc/board/nxp/rproc.rst.

Thanks

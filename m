Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 314DFC369C2
	for <u-boot@archiver.kernel.org>; Wed, 16 Apr 2025 23:59:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 61DE482BD6;
	Thu, 17 Apr 2025 01:59:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XT/hx4pN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E8FD882DB4; Thu, 17 Apr 2025 01:59:08 +0200 (CEST)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7482880107
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 01:59:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-54954fa61c9so267106e87.1
 for <u-boot@lists.denx.de>; Wed, 16 Apr 2025 16:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744847946; x=1745452746; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S7G+wktPU1CuvNJ4W5oz1vX6x4Iukuct8SW+dxDqpbc=;
 b=XT/hx4pNis2bfON4zDi0xHxPMYH1/mm4Wah1VYxuGGKYNagER0M/F5IeFJmsswWrFJ
 ZvSQFEbVkikIrm70GIKvczuJEQDtoPxhxZnVmkq3hnTfxhfSpkE2GZfHtFd+WvVWsvS/
 nPy+UwN8YPEkdclUKy1R4QnC39dRBMwNMJB4JjPeqyJpTZvlRd0Z62xCQDiOV1LieVEe
 llWwubCyxc9oP+iG/FCLRnWM2yBUJpX/JXLv+M7jWkfHSikwMnA1/Ut69o4etrk8nyKs
 E3UfwNcnwNLU4xamxMS9M41Hrek8mLqeuksxRcKf7gw1//R53BNu8zpoQytZyBXa112f
 2dDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744847946; x=1745452746;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S7G+wktPU1CuvNJ4W5oz1vX6x4Iukuct8SW+dxDqpbc=;
 b=WuC/2Or3TjndFkQqHr/+IELiQvKVRAMwAu/5NXNIlTGK3vJ0ErUMqt2YYRbqoODzEj
 TohDlbwyMi607SzdFcPQc0ztPMklAaMrARpb3P+hN6+AZ+eu+t/MiUUuJYFtNwX+gy7X
 fQ/sVemNU+vyemJuPNRGbpwMMAl0FAv0A12nAR+oaIQT4v9cIHCAkskDqNARGvfEql0L
 OlfUcfJkIbM8KYp6+4S5sh6RuHme9Xj76TVKKJLS8VSBOhn0msEZ457qsNuM11QMT6vT
 dWwP9YPmrb4UsvEK1CL9iLbkEefzwKXPjJoIB/eB3NwHfPcUdwACB5W/rfSJH/+q6aV9
 xxBQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXicAs4M2fCNqyTtHFcflsiCuZvB/GU6duaUUVocXw8NFwjJsEqQ9dnEoTMRjHTPYuuEo/wHUw=@lists.denx.de
X-Gm-Message-State: AOJu0YzDEaIdLGHSY3Hg7DvzhExbaO6biI9iGjQQryflmCJtcUqiS8iC
 Wed9LdwV7iw/g88R8J7IQqp9oUglVGk0/hzckDvdiUfqoRruiL29QKkYGzXO+S3dkH4OVxHY1cY
 WlUpVlMc2ETDzl7E4VhIbCH1v7MQ=
X-Gm-Gg: ASbGncvkEV5//r/XGXT485V9H25QLPHDcGBsDXR8NDIbg/IupiUuyN5b/x+VKtoLyNa
 LpYO4pkkMaB+ZiGLTpBib3xJhVVxV7B37o/E71MIw5tqzoTjegQpqsNUFnoUe1UXOEEfwwlEeF1
 AOlhvT37GiKjHl75KGHSmGCpa6ps/kOp2u4k481W8Wotq/eK/Tc/JOETW9PkmlsNfN
X-Google-Smtp-Source: AGHT+IFnzeX14kMH7FDCQ1SB6XGEiXyUiL3K/IAE+2eGpvxbrpqMH3H5x3WQwW0mX0F7hMSP+0HVtCOKjvwiTaEtSro=
X-Received: by 2002:a05:6512:3b0f:b0:549:903a:1bf with SMTP id
 2adb3069b0e04-54d64af3e9amr1160969e87.48.1744847945378; Wed, 16 Apr 2025
 16:59:05 -0700 (PDT)
MIME-Version: 1.0
References: <20250323160107.145749-1-marex@denx.de>
 <20250323160107.145749-17-marex@denx.de>
 <20250415142846.GA244333@francesco-nb>
 <CAHCN7xLa5W-AtRso6RUZwZG_sfDm9CHierfzt_WfOqFjSGJZoA@mail.gmail.com>
 <20250415150344.GA246483@francesco-nb>
 <b396cb96-ff95-4822-ad24-ddff2e3b6545@denx.de>
 <CAOMZO5B=j=k8U6to2TDzohS11j4hPWQOho9bdrYCPe0WXtrQjw@mail.gmail.com>
 <20250416092639.GA24345@francesco-nb>
 <db2d623afd944df2bca6d1e4657d4031@dh-electronics.com>
 <CAHCN7xKyoBQPeXDA90-kcBTw7BhObvn6PVzreoUQ5+GjiCewyg@mail.gmail.com>
 <CAHCN7xLgS7FZ4ajbBa+p-_w_s6oHnfMYcZEMsNBNkqkgAG-7Jw@mail.gmail.com>
 <b35218ca-df17-4423-9932-a2ad0ba14e50@denx.de>
In-Reply-To: <b35218ca-df17-4423-9932-a2ad0ba14e50@denx.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 16 Apr 2025 20:58:54 -0300
X-Gm-Features: ATxdqUHgVUQCuzwqMyNvJUoCuDHtMPm1iittgkh-6M6ix2qMhB2rKXv1DkyQJ6Y
Message-ID: <CAOMZO5CA0_GUr2uQtQgFHe-9wVDCOQwo5HZzZ4sibXEPMpe8cA@mail.gmail.com>
Subject: Re: [REGRESSION] Re: [PATCH v2 16/24] clk: imx: Convert clock-osc-*
 back to osc_*
To: Marek Vasut <marex@denx.de>
Cc: Adam Ford <aford173@gmail.com>, 
 Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 Francesco Dolcini <francesco@dolcini.it>, 
 Fabio Estevam <festevam@denx.de>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Dong Aisheng <aisheng.dong@nxp.com>, Hou Zhiqiang <Zhiqiang.Hou@nxp.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, Peng Fan <peng.fan@nxp.com>, 
 Tim Harvey <tharvey@gateworks.com>, Tom Rini <trini@konsulko.com>, 
 "uboot-imx@nxp.com" <uboot-imx@nxp.com>
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

On Wed, Apr 16, 2025 at 8:47=E2=80=AFPM Marek Vasut <marex@denx.de> wrote:

> You are not supposed to use "clock-output-names" for clock look up.
> You are supposed to use "clocks"/"clock-names" DT properties and then
> resolve the remote clock from information in those.

What do you think about registering the osc clocks like this?

https://paste.debian.net/1369857/

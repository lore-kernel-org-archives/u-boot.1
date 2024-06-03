Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E0A5C25B75
	for <u-boot@archiver.kernel.org>; Mon,  3 Jun 2024 20:32:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA511883A7;
	Mon,  3 Jun 2024 22:32:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KvoSon1G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B94248839D; Mon,  3 Jun 2024 22:32:16 +0200 (CEST)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com
 [IPv6:2a00:1450:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D1622883A7
 for <u-boot@lists.denx.de>; Mon,  3 Jun 2024 22:32:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=lucent@gmail.com
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-52b90038cf7so3208033e87.0
 for <u-boot@lists.denx.de>; Mon, 03 Jun 2024 13:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717446734; x=1718051534; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0d+hi+RVW462g8woeoA39lUvci0S3ikzpBaT0M0AJRM=;
 b=KvoSon1GtMT1IDRZfTUTwX8JehpHkSMCUOCDgU03F8+ygnlTtl/buf2YrYq31PZ/0M
 v5p6PqjU44+VOCdfblLroT706uoJDN1o60wulJESiPw+L2Gg523VRKmzkgtXNPfafemQ
 IcrgGURNYHmCuiIDQVYjVpmdSXvO8RqLbbTmxIlb2ccsH17BuBn+08XYs64pmIQGSXwd
 tCJUVgS3negRtFFZumX6tPVNsG+pNOFYFfnbRbzOr/14cHK6sXiketC3OwATc0CWGcaZ
 DP6ih59lW3l6asu/BSsob0T75wfPmrrlzDeG+qNfTeMGJZgTLh3ID4WyhD6UnaxvsZuO
 UmVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717446734; x=1718051534;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0d+hi+RVW462g8woeoA39lUvci0S3ikzpBaT0M0AJRM=;
 b=OGyIYotr0ddovPEu0TZav/qsOy3u9O53m+CdeqoBo+7XYIUxNyE5qmtxos83LfnrUG
 MQzkEwYdw8DkHcuoxUTGTd6CujtJaOiMeP8h/KFpVSsEqU6Lbh2dCRGIPNSR16THPgql
 nDGi7crkkpkVLuDg91ceR0a/A8oWAqHLfvk/xwcn+yvOGhpERobWYpL4l4we1apVKl1D
 LRa6dCJ3VqgTNWuqrsiJbVpKiSWttEJQC96Ygr5U52D+R3w5g7wzDwYx02s3wjcFWchj
 jEY29F9SwcF/p2zyXPsJKCeegj76wLvtCnVsh7LTJYzhbTKxhbB2AHDX9sTyGA1WRdyi
 zdUg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXYJVcjWV3Kw4tFybEaCE4Pnyi5DYUrLbWEG6BaxGxyJxsU7+XP8bRN/dwvboNA6/AAn1qO4uEwqATh9fpXPzeOEDtxJA==
X-Gm-Message-State: AOJu0YyJb+FbWUkOG8MAcHeeS3CXbybe4Xtys3GBF+2TmjmOkplbBfsL
 G+KC8s/x06mBbFw3i/1wTzZXelxvfVmtgwwGfXPoSxXW3UiQoAbKHZx64JG/N2duNl+Qi/Zs1TO
 owBTeRzFfhr63uVj4TK4qETerAMo=
X-Google-Smtp-Source: AGHT+IGjVgyh7CqPwSdVqBPwk6gv9C154mJtHb0pNdzsQDW2hMcWTbtyI4kqpP+/6KV1/cZVtsKrdTOmmn87Q4fOvo0=
X-Received: by 2002:a05:6512:21a:b0:52b:839c:78dc with SMTP id
 2adb3069b0e04-52b8957af1amr6420375e87.29.1717446733797; Mon, 03 Jun 2024
 13:32:13 -0700 (PDT)
MIME-Version: 1.0
References: <20240603132721.6522-1-hal.feng@starfivetech.com>
In-Reply-To: <20240603132721.6522-1-hal.feng@starfivetech.com>
From: E Shattow <lucent@gmail.com>
Date: Mon, 3 Jun 2024 13:32:02 -0700
Message-ID: <CANV2PTPjbYEWr67bMSM_fg3kSS4Q2kDYdcHTLVp0CrQyeT=dbA@mail.gmail.com>
Subject: Re: [PATCH v1 0/4] Sync StarFive JH7110 clock and reset dt-bindings
 with Linux
To: Hal Feng <hal.feng@starfivetech.com>
Cc: Leo Yu-Chi Liang <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Rick Chen <rick@andestech.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Nam Cao <namcao@linutronix.de>,
 Bo Gan <ganboing@gmail.com>, 
 Yanhong Wang <yanhong.wang@starfivetech.com>, 
 Emil Renner Berthing <emil.renner.berthing@canonical.com>, 
 Minda Chen <minda.chen@starfivetech.com>, u-boot@lists.denx.de
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

Hi Hal,

Instead of manual dt-bindings sync can we please adopt OF_UPSTREAM for JH71=
10 ?

-E


On Mon, Jun 3, 2024 at 6:57=E2=80=AFAM Hal Feng <hal.feng@starfivetech.com>=
 wrote:
>
> There are differences in clock / reset dt-bindings between U-Boot and
> Linux. Sync them, so it is feasible to use OF_UPSTREAM for StarFive
> JH7110 SoC.
>
> Hal Feng (4):
>   dt-bindings: clock: jh7110: Sync with Linux
>   dt-bindings: reset: jh7110: Sync with Linux
>   clk: starfive: jh7110: Sync clock definitions with Linux
>   riscv: dts: jh7110: Sync clock and reset definitions with Linux
>
>  .../dts/jh7110-starfive-visionfive-2.dtsi     |   6 +-
>  arch/riscv/dts/jh7110-u-boot.dtsi             |   2 +-
>  arch/riscv/dts/jh7110.dtsi                    |  28 +--
>  drivers/clk/starfive/clk-jh7110-pll.c         |   6 +-
>  drivers/clk/starfive/clk-jh7110.c             |  44 ++---
>  .../dt-bindings/clock/starfive,jh7110-crg.h   | 180 +++++++++++-------
>  .../dt-bindings/reset/starfive,jh7110-crg.h   | 144 ++++++++------
>  7 files changed, 243 insertions(+), 167 deletions(-)
>
>
> base-commit: ea722aa5eb33740ae77e8816aeb72b385e621cd0
> --
> 2.43.2
>

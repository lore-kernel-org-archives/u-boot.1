Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60672C10F16
	for <u-boot@archiver.kernel.org>; Wed, 17 Apr 2024 01:41:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9512988432;
	Wed, 17 Apr 2024 03:41:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TTpFbhcb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8274188432; Wed, 17 Apr 2024 03:41:36 +0200 (CEST)
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com
 [IPv6:2607:f8b0:4864:20::e2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D044188449
 for <u-boot@lists.denx.de>; Wed, 17 Apr 2024 03:41:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=lucent@gmail.com
Received: by mail-vs1-xe2b.google.com with SMTP id
 ada2fe7eead31-479e857876fso1629616137.0
 for <u-boot@lists.denx.de>; Tue, 16 Apr 2024 18:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713318091; x=1713922891; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1Q3998I6nhC9nnij4LfxKYy84NtJiqn2G1pOrqm9K/w=;
 b=TTpFbhcbVzNjX01hzRKFoPW2KqZz5WIku8lIXdHS5ZU2cHao1EHj/4pR2wkNPp1qmT
 fr7YgGZ8zOJAvlxRBiJTerkfoOowvEqd8y9LBvAoarNvlcOckJZt8IBhSH8pql3DuNww
 Kq2y9oBS2XefE/WRCYxB0k+4eVbMMizzC6hdUQDNX+2sa52y8Mq3IhSwgrVuJn0L3DYt
 oXq3pEZlJMOtnsJqHtA8/uz0A5mYsqmHpdnhG6Cy/OpSRAz5TFytrDFXHclqnI9PWzZJ
 GMylWqWoHh7KAhu0hSPSWNmOrXuxlaKM/jrzAT4w9L2bXeUq0T0rt5mKQTP0olF0aA1g
 t3LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713318091; x=1713922891;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1Q3998I6nhC9nnij4LfxKYy84NtJiqn2G1pOrqm9K/w=;
 b=ut2bHeEcab6kM9u+LYwaNGlxGTGBkpkeByK0AoTOKIAXZkKpAfYOh0oEm656rno2NM
 OFj6JzFhkROFyrRUW/df7qaljWRrZjHl5pLVuJAYIQG53LSb949ACJiuvxi3C17Prnsh
 K/Fv67cMbDbTEBgEJpkP1CgDdr3abzukC5rcV+VQgJHJqGXZZ08iyG2A0RLO6Q8L2UyS
 Ul6n/gVGL2ypGp/0ScFSSUHooPPiBKFbRfQ3m0fcMP7r8oIkjCokYpJBPyGwHEj5y3ic
 V3S+LL1VX7GUX8plBk61Gp0sAydyPZzm4WQ6+H0TrLDl0BGVHDTaIf/HvKjIbyp+h7Sj
 v2Tw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW13pkb2rlCpj236ICHoQtLvR555SnpmRQBEpNyHr3APFnNMafVf6dIXkReXGy/e2sYoC3AW0dtz0C3U1410r6O99wTpw==
X-Gm-Message-State: AOJu0Yy0ECcU13BHNxnU5Qb7mAic1U8K1O3h3U9yzpbo3H8BXzIN0UHe
 mIgtBDXPZdzFr25TRASdiBrxTISQh+X4BbKIiTWq/5ARYVGURj0Wmc7HOverLKbQL76A70bSXn+
 DSxiIqgd925wKiohoIvb/mqO0Zns=
X-Google-Smtp-Source: AGHT+IFKvew3D+l1XDvvMR1pK474twLdZrY3b74Dil/mTb3yAyc1fCppoBcv9KEP9KSw4MBT83agN1uFNUAAoFyytbQ=
X-Received: by 2002:a05:6102:3052:b0:47a:3b48:7eea with SMTP id
 w18-20020a056102305200b0047a3b487eeamr16977508vsa.27.1713318091610; Tue, 16
 Apr 2024 18:41:31 -0700 (PDT)
MIME-Version: 1.0
References: <20240415115035.46199-1-heinrich.schuchardt@canonical.com>
 <20240415115035.46199-5-heinrich.schuchardt@canonical.com>
In-Reply-To: <20240415115035.46199-5-heinrich.schuchardt@canonical.com>
From: E Shattow <lucent@gmail.com>
Date: Tue, 16 Apr 2024 18:41:20 -0700
Message-ID: <CANV2PTNLVMQQYugK4HB3Yv6WXmrbXBLB0FswKPHqq47OkX-DFQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] configs: visionfive2: enable SPL_YMODEM_SUPPORT
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, 
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>, 
 Lukasz Tekieli <tekieli.lukasz@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>, 
 Shengyu Qu <wiagn233@outlook.com>, Shiji Yang <yangshiji66@outlook.com>, 
 Seung-Woo Kim <sw0312.kim@samsung.com>, u-boot@lists.denx.de
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

Successful in use w/ 'tio' serial tool and Adafruit CP2102N Friend
adapter on Mars CM Lite board in DFRobot mini router carrier.

While SPL and u-boot.itb payload are sourced via UART the environment
variables are from the environment variable storage as-is. This makes
sense in the use case for development but may have side-effects in the
case of U-Boot as a JH7110 recovery tool. There is now 'env default -f
-a' which does not purge non-default variables and retains the
non-default variables when migrating from vendor firmware. Consider to
also build for U-Boot the commands that can aid in cleaning the stored
environment variable state CONFIG_CMD_ERASEENV=3Dy and in-memory state
CONFIG_CMD_NVEDIT_LOAD=3Dy. With these it can be done easily with: 'env
erase; env load; env save'.

On Mon, Apr 15, 2024 at 4:51=E2=80=AFAM Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> We can use U-Boot for recovering JH7110 based boards via UART
> if CONFIG_SPL_YMODEM_SUPPORT=3Dy.
>
> * Send u-boot-spl.normal.out via XMODEM.
> * Send u-boot.itb via YMODEM.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  configs/starfive_visionfive2_defconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/configs/starfive_visionfive2_defconfig b/configs/starfive_vi=
sionfive2_defconfig
> index fa80d489f5e..e2d83c62b28 100644
> --- a/configs/starfive_visionfive2_defconfig
> +++ b/configs/starfive_visionfive2_defconfig
> @@ -62,6 +62,7 @@ CONFIG_SPL_I2C=3Dy
>  CONFIG_SPL_DM_SPI_FLASH=3Dy
>  CONFIG_SPL_DM_RESET=3Dy
>  CONFIG_SPL_SPI_LOAD=3Dy
> +CONFIG_SPL_YMODEM_SUPPORT=3Dy
>  CONFIG_SYS_PROMPT=3D"StarFive # "
>  CONFIG_CMD_EEPROM=3Dy
>  CONFIG_SYS_EEPROM_SIZE=3D512
> --
> 2.43.0
>

Tested-by: E Shattow <lucent@gmail.com>

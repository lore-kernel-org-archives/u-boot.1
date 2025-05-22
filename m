Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7FD2C54E65
	for <u-boot@archiver.kernel.org>; Thu, 22 May 2025 13:04:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E28C83091;
	Thu, 22 May 2025 15:04:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RM7dhMz8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F4848309A; Thu, 22 May 2025 15:04:38 +0200 (CEST)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D67A8006D
 for <u-boot@lists.denx.de>; Thu, 22 May 2025 15:04:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-550ee1cb0a3so9445463e87.3
 for <u-boot@lists.denx.de>; Thu, 22 May 2025 06:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747919076; x=1748523876; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RcuMR6vUN1J+11F1ZGpWALzqNNn2f9o5/DG4DvPj4vM=;
 b=RM7dhMz88pOIa/lLnJMZ8+rgXuRwzykX8/EiEtcme8Y7hfBMVwyvJCrB/llW/gY9Ok
 5NkbVB8JHoJQjJabBamklvIPGfOJ6ch8gCr62tCPdghc01RtnE9/KiSV9gW0nP9j824a
 gpXawODpTXXPIQOsl0rWa70wks8e4LzAwdiyUK6Uw863pRrVWMnRhG+ZQQC9K10DApKL
 CjHb6fuH9EbY5zZCkpVU4Fjg7xNqwt9RmTcIM+jCAbsVpaISSk79GjC9r0kSP7hPyQy+
 3I/0Vnq5wT/PKH+pzxVUGUUFUR2U0Hf1Gu0GkZ2rb1WuMyQYoSREJNRWfIaVkCCaM/6j
 NFig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747919076; x=1748523876;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RcuMR6vUN1J+11F1ZGpWALzqNNn2f9o5/DG4DvPj4vM=;
 b=NYtheLAFGqxA7x+xvXdQFmXkqLjh+05ZMBrLPgnwgw3zhoxZ1xGI+SjP56SFBLJkTf
 ssYEOdpJEQhstn7lC0GldGPFiMEvQlU5+HnKYyIVnlwfjsGr7yN4eEcNm4niIXughG5M
 hbRdmYo30KnvxtAjnNwx/CRlf15cRNvmJCPRMrIU1GOjvB7/AbSiPWFWTDKcudzh3Dtg
 gOVUB52euTOVsOT5g42IEC+++3yP8dEhZ9X6zwWA3ecpyksARftuLdiytOKjmtUr39HC
 eo0KnK/SxwlpGTromvL1ecQHsr9+Dtx5BI9e8QOk0VbY6/qSHGM+SLcYwtTdBLHB/mjc
 vF1Q==
X-Gm-Message-State: AOJu0YzgMIvKeTMiKRemAMHwKW6Ft/+8QMeZtnI74tEOi1ovi1JgntwZ
 V2pupgwLQeyvWtt4Wj2F+gwyti9oL/4WJ3WoLD/lNSsNUvR7FZLs3jqlEfGt3o6YxKJ9Hoy2eKW
 8PAu/lXO3o2s/zprlAubPcOSNq3QHzCY=
X-Gm-Gg: ASbGncuXvVKoNm0lAiBzZ91F3U1UR9phkKiIctEOr9WGX0ovA55fta9SJ/peWcA33Sq
 C05Px0zLDXCCKVIQj8wDBto8kbR4XBGPOc3fS+yXOvf3iQIX2LsvXw0dslz7Eko+Y2gKRkvTYna
 Q706nf7osGl3Iv2kHaDTRzRTVkRwv6PGox2EXF1jhefc5/EQWDlI6tRY9W6nFqq8c=
X-Google-Smtp-Source: AGHT+IGwhY7tdfCEedbK9WEyjewJOiOjfAW+uIe8kB7IpxOHeQ31cZscKhWdVEV/shIx/Uzsf7s8Pc4GPEjqzNXKkaA=
X-Received: by 2002:a05:651c:19a4:b0:30b:9813:b002 with SMTP id
 38308e7fff4ca-32807791340mr97023041fa.30.1747919075298; Thu, 22 May 2025
 06:04:35 -0700 (PDT)
MIME-Version: 1.0
References: <20250515150955.926708-1-dario.binacchi@amarulasolutions.com>
In-Reply-To: <20250515150955.926708-1-dario.binacchi@amarulasolutions.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 22 May 2025 10:04:23 -0300
X-Gm-Features: AX0GCFsf_kwpxkg20c8vrRfsGVc8ezNFxNWcx0jEjKddkz4j4nYDq2LLu0IEsVQ
Message-ID: <CAOMZO5ARvohsYXcWCXZuacZB1w4-jdmnXcnL7r7Z=ORw7VbQmQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] arm: imx: imx8m: soc: fix the macro name
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: u-boot@lists.denx.de, linux-amarula@amarulasolutions.com, 
 Michael Trimarchi <michael@amarulasolutions.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Marek Vasut <marex@denx.de>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 Paul Geurts <paul.geurts@prodrive-technologies.com>,
 Peng Fan <peng.fan@nxp.com>, 
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Stefano Babic <sbabic@nabladev.com>, Tom Rini <trini@konsulko.com>
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

On Thu, May 15, 2025 at 12:10=E2=80=AFPM Dario Binacchi
<dario.binacchi@amarulasolutions.com> wrote:
>
> From: Michael Trimarchi <michael@amarulasolutions.com>
>
> The function arch_spl_mmc_get_uboot_raw_sector() was never compiled,
> even when the option CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION was
> enabled. So rename the macro SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION to
> CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION.
>
> Fixes: 2a00d73d081a ("spl: mmc: Try to clean up raw-mode options")
> Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Applied the series, thanks.

Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1774C4829E
	for <u-boot@archiver.kernel.org>; Thu, 15 Feb 2024 12:27:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BCDE087DC5;
	Thu, 15 Feb 2024 13:27:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="S1WQT//S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 64F0F87DD9; Thu, 15 Feb 2024 13:27:43 +0100 (CET)
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com
 [IPv6:2607:f8b0:4864:20::102e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8DF7A87DC5
 for <u-boot@lists.denx.de>; Thu, 15 Feb 2024 13:27:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-298d827e841so216030a91.1
 for <u-boot@lists.denx.de>; Thu, 15 Feb 2024 04:27:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708000053; x=1708604853; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3lCBpNJaz1SHLv3fxSpxTmSO0GgCPdYbsTMHQcvdw78=;
 b=S1WQT//SFSSYjRNQy3WpasGIYZhaKMRmMDvzRqWCpAudyNlNyt60JIFUAQg31BdDVK
 xqG8uGvQXM50AlxM5b29BTBKpz8jYi1YxKRbi2WbWX0axTPa5Yt1RDZvGQIx3UPq6+HY
 /xZEBgAfhiiEZMZKYF7pUWr3M1Ks8zC1hb7CHKRGJ8b+JluK/olyaLk5JqHXgh8ZxAod
 xv54hF8+VPeSZDF8xj000JiwcmKoU6r/oS7Z8vL6BqTWg2lzL/iNQUngwuBDRS6X2rxl
 7UhDDM+ixZafCfv4ObwjuLcHDC/Sc65WgPx35bcHNmuWXqMgma9F0n8RkArNbxbBnax9
 vQmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708000053; x=1708604853;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3lCBpNJaz1SHLv3fxSpxTmSO0GgCPdYbsTMHQcvdw78=;
 b=ENexovyfSJKs9CGCRcH6oEqOLn2r7Mm4kNb5TaehEHDfyOcXItXQrbvQQQU80aAEuL
 hyYG8uWY2YRQMpEk20p3ykoIVxWLZjMhsO4imhiX74Qp+dKndtF2t9beVsPQuhSe3/mK
 9NYsyJ0BGDtb92Vae6vqNDGNKRcJVPLpqeEg8hCsLCz8khJ5upXJo5iLjN3AHTaWAkPX
 gDVNRROC5rR23Af/Z6yGDbZcwwXi2xg04j/n6PhfKguqOa2R+zD9kVjD1+8UlQptJpvf
 uQkWDa4dUrv+OTQu83kvdqFxPNTJ7Yiqq9jAyb+de7L1d8yHVwq1wEpPumfm7+xvYjp/
 eWTw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUBk4lX4jOTyUiNi5XyFAAphmoMCipTNj2pphZ0tiuA5NwKdvPfIv1lrA9VGeZXcCMw//d4VUeGdTPAY7+LVtdn2Qhi6g==
X-Gm-Message-State: AOJu0Yw4c4B4lYQxU3qb03is1vcO9d/f/txuoKd2USLZHoid2ZnNk8Eh
 B1IN6swRaQprtfl1e12l1EoatssKDpYuWUKO9Tks1AcqbF0Xt/ZCWlyWyR+mcBaYTx5InuNUwb0
 QV/5r8aVqI6CL4uifig6wB/zFGdg=
X-Google-Smtp-Source: AGHT+IGFTJ/GJFrYeQvXHfeWm5R87dSrrg1I3KhsLwM6uMoBnka5te3L50o9IBOVEorlG8lIytn2fuWt4zjuEjhjOCo=
X-Received: by 2002:a17:90a:f2c4:b0:299:1ae1:51b2 with SMTP id
 gt4-20020a17090af2c400b002991ae151b2mr559799pjb.4.1708000052780; Thu, 15 Feb
 2024 04:27:32 -0800 (PST)
MIME-Version: 1.0
References: <20240213172226.151181-1-frieder@fris.de>
 <20240213172226.151181-2-frieder@fris.de>
In-Reply-To: <20240213172226.151181-2-frieder@fris.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 15 Feb 2024 09:27:20 -0300
Message-ID: <CAOMZO5AtTf_2pg2Fs93pPvVGcO20tcGsd3mJPfj+bhFBaKd_vA@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] board: Add support for Sielaff i.MX6 Solo board
To: Frieder Schrempf <frieder@fris.de>
Cc: Stefano Babic <sbabic@denx.de>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de, Frieder Schrempf <frieder.schrempf@kontron.de>,
 Christian Hewitt <christianshewitt@gmail.com>, 
 FUKAUMI Naoki <naoki@radxa.com>, Hai Pham <hai.pham.ud@renesas.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Marek Vasut <marex@denx.de>, 
 Martyn Welch <martyn.welch@collabora.com>, Michal Simek <michal.simek@amd.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, Peng Fan <peng.fan@nxp.com>, 
 Simon Glass <sjg@chromium.org>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Tianling Shen <cnsztl@gmail.com>
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

Hi Frieder,

On Tue, Feb 13, 2024 at 2:22=E2=80=AFPM Frieder Schrempf <frieder@fris.de> =
wrote:
>
> From: Frieder Schrempf <frieder.schrempf@kontron.de>
>
> The Sielaff i.MX6 Solo board is a control and HMI board for vending
> machines. Add support for this board.
>
> The devicetree files are taken from pending changes in the Linux
> kernel that are available from linux-next and will likely be
> part of Linux v6.9.
>
> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
> ---
> Changes in v2:
> * Implement changes suggested by Fabio (Thanks!)
>   * Fix system reset and remove unneeded cpu_reset()
>   * Add 'static const' to nfc_pads[]
>   * Remove hostname from env
>   * Remove options to disable caches
> * Enable watchdog and wdt command
> * Enable LTO

I put this series in CI and it complained that there is no MAINTAINERS
entry for this board:

https://source.denx.de/u-boot/custodians/u-boot-imx/-/jobs/784464

and there was also an issue with the documentation:

https://source.denx.de/u-boot/custodians/u-boot-imx/-/jobs/784463

Please fix these two issues and submit v3.

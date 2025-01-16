Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DBC7C02183
	for <u-boot@archiver.kernel.org>; Thu, 16 Jan 2025 14:40:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE19780703;
	Thu, 16 Jan 2025 15:40:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dqk9BXvC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5CCBE80708; Thu, 16 Jan 2025 15:40:17 +0100 (CET)
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com
 [IPv6:2a00:1450:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E19CB8022B
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 15:40:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-304d760f12aso9029051fa.2
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 06:40:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737038414; x=1737643214; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kxhvsu7c6pq1utYYXZolHc70fs8saGD7Z04cHysvI98=;
 b=dqk9BXvCzE1OIm6ZyoN+fzMdWyoktkuWdULEjR80NSwS6Etf1K6vatbECU7QcQ6YGh
 QLsdqHMaNH8YT3QcNqo8blpIdJwaoMxhYbXv7N6qBZ7FgUFwQX6AUAO12gmn0J1IHlv/
 pgWTDH4XuKBGLHyzkpWBlFLLeq9SihF5sVLrOhWdgb5zIooo4YVmNRKUzOWFWSKGt8ce
 VcM0SFeovxKPuS3foDLUBY4yz8wDnyAwwZzSQmlNHwmXUI1ImNUP0JO15yqrX4SFjvSA
 reCaHr+RL/eibQy4SlHpA2kiYD5c+Pg0eDjchLT+/m386nUX5qkknxF6+DOIgyj25iN4
 28HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737038414; x=1737643214;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kxhvsu7c6pq1utYYXZolHc70fs8saGD7Z04cHysvI98=;
 b=EYBmRDvuUVIvvQ0GdQc/dgtNg/0Hw/vOaEONSR94eRom+a8eTe1l2tRTEbEWp0lawi
 sbIxD69qtfJ/LBHGGWFiwMCN9eqsBsANx8Gl+Xy8aFkaYT+HeiFf5JIQdehk6J7Cw4mQ
 lP0kxy9NV19lMKTdCdSFzvtd0dqeHAh4cs3X79gPGaf5UQ5B/gW8isFe01IWn9t3QbVG
 bIvg1fIM4GZQ2eczWXkyPDrcKoavkeA7s/oN8PpI/R7hEp7q8MirNeGOWXUwXIz5yLLB
 ejZnv3TkLVmPPg+53y9vNJp+1GNi6j59cbljG4WWluT9I6iqqC6ddV93J/qwdS/olaHu
 VqjA==
X-Forwarded-Encrypted: i=1;
 AJvYcCULFzJeH4HzHkMeZpoP05ggx0A/pmtPRb7PbegB7+aZeh4vkKa4OMlmXS/jobVP5SsXruSzSH0=@lists.denx.de
X-Gm-Message-State: AOJu0YyGhVGyRcm1Py+gpu0f1KZ4s0S8Uq2T5J7QAVbN07iRWpSnHinu
 fjbIqVl9E0gUd2NPtWoAoABeGLhoauWz4QTqhzxK7CxVJuuKMY7HX49h2F6PSNrM7bS4gLFodgd
 YN5qdKhZ3gMLEw+mcE+AnAyXwbbFjIQ==
X-Gm-Gg: ASbGncuG34d08i7engWJmZSpfMKwejL9ziQsHAAqQnlsyEpFGAQS+qtZtmNu88wvsAr
 +lzD3f9dGNx3VlDZ3XX3LujRdEj6IOwj+O+GA6hXwvH4MtW3ZnQsqkcWJjs5pLR1CLzz/3A==
X-Google-Smtp-Source: AGHT+IFchBUGuSPgD5V9xpKCHw3No3K3TmkGDMLOPQa5/LUJlOI2P2q3WLyRsTSNooszqoLKrsJ28rMpMHzQ0Mcfo6U=
X-Received: by 2002:a2e:b8ca:0:b0:302:1dd5:6b5d with SMTP id
 38308e7fff4ca-305f457c9fbmr116532241fa.14.1737038413804; Thu, 16 Jan 2025
 06:40:13 -0800 (PST)
MIME-Version: 1.0
References: <20250109-imx-bootstd-v3-0-16e5fc0baecf@nxp.com>
In-Reply-To: <20250109-imx-bootstd-v3-0-16e5fc0baecf@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 16 Jan 2025 11:40:02 -0300
X-Gm-Features: AbW1kvZXSav-ha4QuqRfdzgINPlsX-OsTE01XALiENWfmgsHJWFC-T3eEk0NWbk
Message-ID: <CAOMZO5CEF_98a69Ta84ZETZX7MXj_2Zn6cvKu09QbEU3hGu0wQ@mail.gmail.com>
Subject: Re: [PATCH v3 00/17] imx9: switch to bootstd for i.MX93/1 EVK/QSB and
 i.MX8M EVK
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

Hi Peng,

On Wed, Jan 8, 2025 at 11:23=E2=80=AFPM Peng Fan (OSS) <peng.fan@oss.nxp.co=
m> wrote:
>
> Switch to bootstd for NXP i.MX9/8M boards with a bsp_bootcmd as fallback.
>
> Some cleanups are also included together with this patchset
>
> CI: https://dev.azure.com/pengfan/uboot-ci/_build/results?buildId=3D17&vi=
ew=3Dresults
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
> Changes in v3:
> - Separate driver and dts changes for patch16 in V2
> - Link to v2: https://lore.kernel.org/r/20250107-imx-bootstd-v2-0-97671b1=
694cd@nxp.com

Applied the series, thanks.

Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D82AFCAC597
	for <u-boot@archiver.kernel.org>; Thu, 18 Sep 2025 10:08:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4AAAC81E13;
	Thu, 18 Sep 2025 12:08:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YuFwp5bE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B38FB83281; Thu, 18 Sep 2025 12:08:12 +0200 (CEST)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7E15180107
 for <u-boot@lists.denx.de>; Thu, 18 Sep 2025 12:08:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3ec4d6ba12eso434122f8f.1
 for <u-boot@lists.denx.de>; Thu, 18 Sep 2025 03:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758190090; x=1758794890; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UkJtMoKOVSlk6bG7UzdWrJkmxsyMi0EI8tJz3tZa4wM=;
 b=YuFwp5bEGCrQJm8FUi3elclOweAMmEKPNiK6w7zrteNV37Lk2KbufaSyf/M2DE6ONg
 J2QKx3BJxUgfdj1IPIVwjzFugVXaEZpZIqlUgiBTL6As3z4MGWyTX1m1Totdj8lBv7aN
 dVmPEiwngHNiSCiC25EMiMZcrctUj4dScQKtAJ7utx+YdcoJ9cCLXAim3RYp7t0ZZzRl
 QLgNfcZ2tZHu40AEUWw7OUoze3/9D+ZUHQS4ys+eJAx0JVTdHbzsE+hJL08fB/W/ODRj
 KfvEw4xPoqQZ21BRq0WHcbVbcCHTjc055U6aCi3wSVCimDX8R5w41pqqfWElAnvpSJPL
 5Vhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758190090; x=1758794890;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UkJtMoKOVSlk6bG7UzdWrJkmxsyMi0EI8tJz3tZa4wM=;
 b=J6H/EBxQLptabsB0pg/b5+btN1gyPqV6D5ImsOadu1Z5sA4ecEvD+kpFtKSXUiXxUm
 aloVABsJkmSoDwn7BIlignzo1naV2rQMGWmUeGPTIEPVZ8oMCAvjOZu0LwgdCC0wlNSR
 e0YLv4FgPv3nLvRwUnAc4BAAH3ws3ipI8+bULUmDj0dsGc/BFLidi0lUc7/v3Bt4CkEI
 HyMfs8VhEpt84n8mZMUkvNT7A9mnEPgw4YSTZz7JFG/O5zEUzNx+FTTFYu3tOb/RvhMp
 HWbXkjhbFUxKl7ND6WmbTmJnIDAB6ZP0xkq7WZZ77QkPA8MDr8oAhsX/+Wozg317qGUp
 funQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW7tO/EC9ad+uhn3qd297aOt/L4UQJhGfEhlsAfqaXy9djipKADV3NizTp1ymLwm5UwoCNS+Gs=@lists.denx.de
X-Gm-Message-State: AOJu0YwR+b3kS/Hl7UFEactdQBXUmmbvTIW/430iWywSoNhKYGNvuXP+
 AO/qQzFwnHKTIoB7u1/PdtRztTGnKAEm0jpkn3Nb8TYCrI1Wtzzju6ZGLn+Beg/+ynzLMLreOTD
 v+xCv70Hz9g2bsho/VN92XZa03l0S6gM=
X-Gm-Gg: ASbGncvzEeRYOSLbOHfjbwGCy+JTk5qZfmXso8uPpopoYIM/aswx+1jMOYwxuoKdB/a
 uKDNM2hjnKq3ze+/VhGjMiEH1sFaNLTZwhkcxRU8tbdfXdtx5TJMuNVBg9Em+HkXpIo1YLsYDrX
 hgBpzgngyf6BLFCNEbFu/eEco6sYyPg0FvhqADc0ubO9JP3eIehb1wMlNpjj3p0HrAQlcGxsNNf
 XWt9FaaRzwVFKKTYgeTNxKza78=
X-Google-Smtp-Source: AGHT+IEaZ6k4hBTg1Y21+6BTotbD7WXjKzsUrF98eDKilm3tWYHhcQ6HMwsI7V2Osc4UaSZgr8HOYkWbu9d8TdMJvBs=
X-Received: by 2002:a05:6000:4023:b0:3e8:94d3:765e with SMTP id
 ffacd0b85a97d-3ecdfa5c304mr4623729f8f.61.1758190089671; Thu, 18 Sep 2025
 03:08:09 -0700 (PDT)
MIME-Version: 1.0
References: <20250918084207.3862049-1-lukma@nabladev.com>
In-Reply-To: <20250918084207.3862049-1-lukma@nabladev.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Thu, 18 Sep 2025 13:07:58 +0300
X-Gm-Features: AS18NWB8eZxNMRHz4MFKo-HwRkRFW84CZxC46hqZlGxWJACffl7eHHmpNR8Fov0
Message-ID: <CAPVz0n26KNJ33=nr7hW4395VTrWLhe55wpz-M0A+t40NBwf24g@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] timer: tegra: Bind watchdog driver when timer node
 is processed
To: Lukasz Majewski <lukma@nabladev.com>
Cc: Thierry Reding <treding@nvidia.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de, Francesco Dolcini <francesco.dolcini@toradex.com>,
 Stephen Warren <swarren@nvidia.com>
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

=D1=87=D1=82, 18 =D0=B2=D0=B5=D1=80. 2025=E2=80=AF=D1=80. =D0=BE 11:44 Luka=
sz Majewski <lukma@nabladev.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> The Tegra SoC is a bit special, as it doesn't have the separate IP block
> to provide watchdog functionality.
>
> Instead, timer IP block allows such functionality when properly configure=
d.
>
> This patch manually binds U-Boot's WDT driver (based on WDT_UCLASS).
>
> Signed-off-by: Lukasz Majewski <lukma@nabladev.com>
> ---
>
> Changes for v2:
> - Replace "Tegra T30" with just "Tegra" in comment as all Tegra
>   SoCs are using the same programming paradign
> - Update the commit message
> ---
>  drivers/timer/tegra-timer.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>

Reviewed-by: Svyatoslav Ryhel <clamor95@gmail.com>

With minor adjustments applied to u-boot-tegra/staging, thank you!

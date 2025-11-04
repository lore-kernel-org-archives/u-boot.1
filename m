Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CB6ACCF9E3
	for <u-boot@archiver.kernel.org>; Tue,  4 Nov 2025 18:08:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DFD4183923;
	Tue,  4 Nov 2025 19:08:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kFfctGur";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A9BA83923; Tue,  4 Nov 2025 19:08:09 +0100 (CET)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com
 [IPv6:2a00:1450:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ADB8D8393F
 for <u-boot@lists.denx.de>; Tue,  4 Nov 2025 19:08:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-59428d2d975so2834050e87.3
 for <u-boot@lists.denx.de>; Tue, 04 Nov 2025 10:08:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762279687; x=1762884487; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RsAMQZxFUN5m52AxHnVnDHjYid/FpOpAFO6tx/jH7Fw=;
 b=kFfctGurvirKhonJ1sjHfITPgzUx8KFpzOu3DRHpXh2LqXSrr+BOtikCA6eiEJTt+T
 HZpLKvPL9A5c3V9HoCw+xlq8Sa9nJzuk+PBFoMY262Z7+AVFJiwE+i/XnupgommhO7h3
 qRRUXBw3rD0X8KmgifmqZT81XBcuMeEO6/TfQilfrpE2J6CLI2QRadggum5oaD/Cm6EO
 IocDL4L52qHWU1qmdJ//IjvwNrjEstda8kwZmQmHk+1MuUEFDl/wcKui2EQsGOJfwinA
 SAUlarS07LNnIhM69sHuD3DsQLP0u/eItBnLaLdqxurXggHKMifSbsqNHhH39WKm2EyJ
 HiyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762279687; x=1762884487;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RsAMQZxFUN5m52AxHnVnDHjYid/FpOpAFO6tx/jH7Fw=;
 b=B9N/b3fINYUlIq1krrnYrQbWXxnKnaRaRuS6lOVi+InqmyUXf6SZSh7IAcxPBoC4V0
 VDI3JVTiYn22YXVAUCpxynPOef8IK/KQtgfaTpAVwaHmSiCR50RqYprJYQbMohb37xuX
 M0eFBwSxL7qJPoEtff3grdg1RHJgQ6UIlWsSMKk0IUlHQ1Wl94H6NwlG+CaijQkTiOC8
 tKLK+5y0dVPEiQqOvQLNSxyHuMHgtUXa9TTRthRXonubVuo1fNR8qU4M6rZ9Jn9JZd5F
 Nl3EaByIw4lgtI9sCmkmzzD3nl+Css+W1I30Pb3wYNbfaPjOFRDgIc25kfj3jJV6EEDl
 8YUA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXsurmJJbXj19v1KJ+1jjdT8RK3Yqn90VdRPoY2EIRIqYXLl/2nq6eCeqUjThc1K1snC1sNDcs=@lists.denx.de
X-Gm-Message-State: AOJu0YxvT7nF3hY41sIKPAcZmyOc5z7+GM/rGDaB+7mbdfqhAbpf+kcy
 KB8b90CM1htd8V1DtDk6yY/uWexVLYWzeu2keD7LE/kXrW1hZM0gnTtt7lkTVlOxFNgq5cdq9r2
 MD+LBQjyyixPOIo1QmkZn8xxGoO2/dyE=
X-Gm-Gg: ASbGncvmoHbcetSo8w4IOqdlQVUCu3R9lAwe41UWQ/pvpu3fXDDlpDIzdjaEQ/vFGFK
 He4FkxG+MyUsSw2FrEmgXqA6nDWKTq6MCPvCCKCBPxeBDsj0f2yObHfFXWOpmKLI3+ZhaAS2V5S
 qTkD3LoDKCSH1MQFsyKlMKU0pWG6VHsrKHNQONksTY5ct6rRP9q3VWPQCcC7mtWU6pkHBLGgYDr
 SJciwQ7t1hC+ajsNMtZCAUjhencguUg3efZYBgPtg9a/nAphXPX4oIZtnl/NyVjuQnvfgcMxhtU
 hqW0scKx4SaBflzE
X-Google-Smtp-Source: AGHT+IEbw2TvdPIKbJ7MejkaXFDgfcUuemlsViAs3RVRzqw74CGMIsUxwjXt5ueeXj6g/9c2cKVrLfMbOIK34Haw0w8=
X-Received: by 2002:a05:6512:3c84:b0:594:2a49:f274 with SMTP id
 2adb3069b0e04-5943d7cedb9mr9561e87.38.1762279686796; Tue, 04 Nov 2025
 10:08:06 -0800 (PST)
MIME-Version: 1.0
References: <20251104125441.138131-1-frieder@fris.de>
In-Reply-To: <20251104125441.138131-1-frieder@fris.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 4 Nov 2025 15:07:55 -0300
X-Gm-Features: AWmQ_blX56aPZFLcejklg38HVyuXNB7VkwLHbmE9iJM8bbuFCW3E0E6jhrJAkB8
Message-ID: <CAOMZO5CPqiEyDfMEcw_BHYakKu0sF36uELDuqr4VJejS-zErpg@mail.gmail.com>
Subject: Re: [PATCH 0/4] imx: kontron: Add support for HW UIDs in OTPs
To: Frieder Schrempf <frieder@fris.de>
Cc: Stefano Babic <sbabic@nabladev.com>,
 Annette Kobou <annette.kobou@kontron.de>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de, "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>,
 Eberhard Stoll <eberhard.stoll@kontron.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Oualid Derouiche <oualid.derouiche@kontron.de>, Peng Fan <peng.fan@nxp.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, Simon Glass <sjg@chromium.org>
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

On Tue, Nov 4, 2025 at 9:56=E2=80=AFAM Frieder Schrempf <frieder@fris.de> w=
rote:
>
> From: Frieder Schrempf <frieder.schrempf@kontron.de>
>
> SoMs and boards that are manufactured at Kontron Electronics
> Germany (KED) get UIDs programmed to the OTP fuses. This adds support
> for extracting them from the fuses and exporting them to the serial
> console and Linux.
>
> Frieder Schrempf (4):
>   imx: kontron-sl-mx6ul: Enable CONFIG_BOARD_LATE_INIT to fix auto
>     fastboot
>   imx: kontron: Add common function to get HW UIDs from OTPs
>   imx: kontron-sl-mx6ul: Add support for reading HW UIDs
>   imx: kontron-sl-mx8mm: Add support for reading HW UIDs

Applied the series, thanks.

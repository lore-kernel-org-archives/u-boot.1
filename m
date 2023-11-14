Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BB22C4167D
	for <u-boot@archiver.kernel.org>; Tue, 14 Nov 2023 08:14:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD4CE871A0;
	Tue, 14 Nov 2023 09:14:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="yg4KNj8t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD9FC8719F; Tue, 14 Nov 2023 09:14:34 +0100 (CET)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D70A7870F5
 for <u-boot@lists.denx.de>; Tue, 14 Nov 2023 09:14:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-32f7abbb8b4so3227703f8f.0
 for <u-boot@lists.denx.de>; Tue, 14 Nov 2023 00:14:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1699949672; x=1700554472;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=u7gJLV8RSnfmUY1L2EvH0aePRyNPlNQYfdAOKc4Pkdw=;
 b=yg4KNj8tHWbK6IoDPrcAzaxaF255jglHikuOUGfPbQ16xJv0q/nqU7wglp1d2VmOAs
 YeNCKasTEhAMSXMgA8YvXC35op1TSUx4hjYfl6R6KhCBAtDOmcVQvdB1DuGvYyl/mz6c
 5esx+2G6TgzwwFl2Hc/GmQ0IoFQvFrBSH3xykzI8hsXDN24Xw2Zl1atYQSpUCZU/KJR0
 m1Ku2s734CdU7XRK4KaBV9fYsg++bNWn6WB3NC+cAM/dtyDhX9/FtEl+2PZjWvcdeCo+
 vormIJtliM5HvyAw0Xq1RWidGoKxP9NaG/YYg3DQwBfYDfR+ZyFt4hK7Qj3xMOcZTxfu
 jJ6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699949672; x=1700554472;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=u7gJLV8RSnfmUY1L2EvH0aePRyNPlNQYfdAOKc4Pkdw=;
 b=AH83NhTtJ3Fw9TfwArakOL1X9wz7TFE8TlB9LTFClgajxTPZTbV5CXLzZVCLVJOpxr
 cDwZxCpLplwiJIQZAm6F2X9RaMzuOfKwgp2/dDJ63MsVLqFvb82QX8HMastNqNotMadL
 JIDy1NpbvK4qS5nHvW7i096Io21quGW8im3mMoLcNjWkrpELpn5A9xHwgu1MSDTXY3Fw
 Tg4X7xUiqrrkKLQCF283qsaXlwZZAyOpT95Iwulx92/Z8ZJ/s/Xp6lcG7+MV2ULZwnmH
 Sx/HRniuRaYyQLJTk90bsQ5Az7Na7dIY9Ea3DcM3Xg+2rOLJM3rj93ZCLPYWl7Wyz6ME
 oFww==
X-Gm-Message-State: AOJu0Yw1SPxo6iBNQj9aDGfOfgTj58f91GdEtKUyKK+whjK4AnisB2u3
 Fl5BRoqzPwl8RUWgPjY16/IjfQ==
X-Google-Smtp-Source: AGHT+IFDtds/7yQvbjNT1p73RtI0y99hHuQK0VaoHpFtVc/4/r6hJWbZnxLAl2Q0cn0rde0cQuo7aA==
X-Received: by 2002:a5d:60ca:0:b0:32d:9d64:b429 with SMTP id
 x10-20020a5d60ca000000b0032d9d64b429mr5873778wrt.21.1699949672216; 
 Tue, 14 Nov 2023 00:14:32 -0800 (PST)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 m3-20020adffe43000000b0032d8354fb43sm7104222wrs.76.2023.11.14.00.14.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Nov 2023 00:14:31 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Dmitrii Merkurev <dimorinny@google.com>, u-boot@lists.denx.de
Cc: rammuthiah@google.com, Dmitrii Merkurev <dimorinny@google.com>, Eugeniu
 Rosca <erosca@de.adit-jv.com>, Ying-Chun Liu <paul.liu@linaro.org>, Simon
 Glass <sjg@chromium.org>, Sean Anderson <sean.anderson@seco.com>, Cody
 Schuffelen <schuffelen@google.com>
Subject: Re: [PATCH 0/2] cmd: bcb: extend BCB APIs to support Android boot flow
In-Reply-To: <20231110055955.3370681-1-dimorinny@google.com>
References: <20231110055955.3370681-1-dimorinny@google.com>
Date: Tue, 14 Nov 2023 09:14:31 +0100
Message-ID: <87v8a4n448.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Dmitrii,

Next time, please add the version (v2) in the cover letter as you did in
the patches (subject should start with "[PATCH v2 0/2]")

No need to respin the series for this.

Thanks again for your contribution!

Cheers
Mattijs

On ven., nov. 10, 2023 at 05:59, Dmitrii Merkurev <dimorinny@google.com> wrote:

> Following patches introduce various block interfaces support
> and extend API of BCB (bootloader control block) to reuse it
> for Android boot flow of Cuttlefish virtual device.
>
> Signed-off-by: Dmitrii Merkurev <dimorinny@google.com>
> Cc: Eugeniu Rosca <erosca@de.adit-jv.com>
> Cc: Ying-Chun Liu (PaulLiu) <paul.liu@linaro.org>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> Cc: Sean Anderson <sean.anderson@seco.com>
> Cc: Cody Schuffelen <schuffelen@google.com>
>
> ---
> Changes for v2:
> - "mcc" to "mmc" fixes
> - Clean some gotos
>
> Dmitrii Merkurev (2):
>   cmd: bcb: support various block device interfaces for BCB command
>   cmd: bcb: extend BCB C API to allow read/write the fields
>
>  cmd/Kconfig                  |   1 -
>  cmd/bcb.c                    | 205 +++++++++++++++++++++++------------
>  doc/android/bcb.rst          |  34 +++---
>  drivers/fastboot/fb_common.c |  14 ++-
>  include/bcb.h                |  59 +++++++++-
>  5 files changed, 225 insertions(+), 88 deletions(-)
>
> -- 
> 2.43.0.rc0.421.g78406f8d94-goog

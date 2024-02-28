Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD8B2C5478C
	for <u-boot@archiver.kernel.org>; Wed, 28 Feb 2024 11:49:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E2CED88081;
	Wed, 28 Feb 2024 12:49:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="tRv4lzYQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7302687F73; Wed, 28 Feb 2024 06:34:24 +0100 (CET)
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com
 [IPv6:2607:f8b0:4864:20::934])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C6D9F87F95
 for <u-boot@lists.denx.de>; Wed, 28 Feb 2024 06:34:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-ua1-x934.google.com with SMTP id
 a1e0cc1a2514c-7da728b0597so1593455241.1
 for <u-boot@lists.denx.de>; Tue, 27 Feb 2024 21:34:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709098460; x=1709703260; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=YUviAkcZyCNfiW6oz5KE3FMz/Fn1RoEXtjgRIzevopc=;
 b=tRv4lzYQtbJPIED0QIddHjxUFHBdgndKIgAE4xf9mokyETVSMj4knZUJ7WQU6DxToa
 TOR65ho94rD96asN/rL9AMKCTMvp43sbjZjSkauOJwzWgIGcMGRCIb3ehmwULWKMl5DY
 Chu3oM1fQiueEKANBtJOxtU17UPuGK7KHcKPSBd7u15GMWVZMKAFpBDlD/lw5gA790Wd
 Ig4krdAtF6BT2xHDnuIzIDk7Dl2Bg5su2YsiM9PeP9rK2t5wPaW/6Dk3s1SSdH46lXVg
 CkR2UaJH0B9ro0yJUwY6ph2vHy5P/tJ8fE3TPbuxfeQojkcxbVNnG5cHumHzw+XRNySi
 pl9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709098460; x=1709703260;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YUviAkcZyCNfiW6oz5KE3FMz/Fn1RoEXtjgRIzevopc=;
 b=eyn1RWEMsb7bl4/E9vuXiubAEtl0v39ETaVg/+4S+rHfWpYnCA63lR/V/F+vLC+txL
 6qgO6QUlIelQAl1MG3c8ZVUJDfqd/QVSQIJ6Yi8N1nMxbEZ4kJjhjgkCfbWDV/G4SvpV
 qK0qIrJkOQYgOQ3ZFZ9s4gwbrrj4XUCa0wWX7/0USofJi2lVTZda5hZIJLp+LAdZEXsS
 O+H6nF9tx531lgFyb28Bd1oa5JshmpSNlahVXDBhX6d38DBddpFrpfauYA/Ik8q3nk9k
 KZUhApCTsEDvAdZPSRGwpdCJrd+7BScBlNP+k4cGxOTw5rwddUQQfBH5btXFb7ssddB9
 a9vw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVLmatjZJ7wCSdOLSGN+Oyf4IujRhljZks3d4pE6x8ezbSrXQi+QW6KX/KgQK9lwZ0wzVXOigw89xa6j1/ECc/DzvzCIg==
X-Gm-Message-State: AOJu0YwArd1oASRgPFPgXVZVS1DNBnoDcXoKH/kkGWwqWDwurA8EBiEh
 GvmICv49WuDWkROO19nqtmPKHn8Re3HFkI2WQRTRhwWMHm/BrBlYI31pXz3E8yHwcC9j1LnxkBg
 BR71+aZrUbO1oo0eboDAABEUnIH2KIQ/GnikEqg==
X-Google-Smtp-Source: AGHT+IHsNd4ilfEH9jjyx4+5JTYBeic4cBOQwhC2w7EE9vpNInBvT7S5yA2F8U975kkuwoIpaqC72Zb5wW0BlxHculQ=
X-Received: by 2002:a05:6102:d91:b0:470:6d54:5eee with SMTP id
 d17-20020a0561020d9100b004706d545eeemr11548200vst.5.1709098459947; Tue, 27
 Feb 2024 21:34:19 -0800 (PST)
MIME-Version: 1.0
References: <20240223202153.3756094-1-a-nandan@ti.com>
 <4f418aa56f55f984a3c096732eb02124545b79eb.camel@toradex.com>
In-Reply-To: <4f418aa56f55f984a3c096732eb02124545b79eb.camel@toradex.com>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Wed, 28 Feb 2024 11:04:08 +0530
Message-ID: <CAFA6WYNLMwy+eWyM=GBuOO78d9ZbytQcWRztFq7nDG8L9mhYSg@mail.gmail.com>
Subject: Re: [PATCH v10 00/15] Introduce initial TI's J784S4 and AM69 support
To: Marcel Ziswiler <marcel.ziswiler@toradex.com>
Cc: "seanga2@gmail.com" <seanga2@gmail.com>,
 "hnagalla@ti.com" <hnagalla@ti.com>, 
 "rogerq@kernel.org" <rogerq@kernel.org>, "afd@ti.com" <afd@ti.com>, 
 "christianshewitt@gmail.com" <christianshewitt@gmail.com>, 
 "yanhong.wang@starfivetech.com" <yanhong.wang@starfivetech.com>, 
 "ralph.siemsen@linaro.org" <ralph.siemsen@linaro.org>,
 "vigneshr@ti.com" <vigneshr@ti.com>, 
 "j-choudhary@ti.com" <j-choudhary@ti.com>, 
 "mkorpershoek@baylibre.com" <mkorpershoek@baylibre.com>,
 "naoki@radxa.com" <naoki@radxa.com>, 
 "a-nandan@ti.com" <a-nandan@ti.com>, "bb@ti.com" <bb@ti.com>,
 "kamlesh@ti.com" <kamlesh@ti.com>, 
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "andre.przywara@arm.com" <andre.przywara@arm.com>, 
 "clamor95@gmail.com" <clamor95@gmail.com>, 
 =?UTF-8?Q?Jo=C3=A3o_Paulo_Silva_Gon=C3=A7alves?= <joao.goncalves@toradex.com>, 
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 "n-jain1@ti.com" <n-jain1@ti.com>, "b-kapoor@ti.com" <b-kapoor@ti.com>,
 "jh80.chung@samsung.com" <jh80.chung@samsung.com>, 
 "xypron.glpk@gmx.de" <xypron.glpk@gmx.de>,
 "a-bhatia1@ti.com" <a-bhatia1@ti.com>, 
 "kever.yang@rock-chips.com" <kever.yang@rock-chips.com>,
 "sjg@chromium.org" <sjg@chromium.org>, 
 "n-francis@ti.com" <n-francis@ti.com>, 
 "christian.gmeiner@gmail.com" <christian.gmeiner@gmail.com>, 
 "mr.bossman075@gmail.com" <mr.bossman075@gmail.com>,
 "marex@denx.de" <marex@denx.de>, 
 "m-chawdhry@ti.com" <m-chawdhry@ti.com>, "lukma@denx.de" <lukma@denx.de>, 
 "michal.simek@amd.com" <michal.simek@amd.com>,
 "sabiya.d@ti.com" <sabiya.d@ti.com>, "nm@ti.com" <nm@ti.com>, 
 "j-humphreys@ti.com" <j-humphreys@ti.com>, 
 "neil.armstrong@linaro.org" <neil.armstrong@linaro.org>,
 "trini@konsulko.com" <trini@konsulko.com>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 "u-kumar1@ti.com" <u-kumar1@ti.com>, 
 "hai.pham.ud@renesas.com" <hai.pham.ud@renesas.com>,
 "jonas@kwiboo.se" <jonas@kwiboo.se>, 
 "cnsztl@gmail.com" <cnsztl@gmail.com>, 
 "rasmus.villemoes@prevas.dk" <rasmus.villemoes@prevas.dk>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Wed, 28 Feb 2024 12:49:49 +0100
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

Hi Marcel,

On Tue, 27 Feb 2024 at 21:45, Marcel Ziswiler
<marcel.ziswiler@toradex.com> wrote:
>
> Hi Apurva
>
> On Sat, 2024-02-24 at 01:51 +0530, Apurva Nandan wrote:
> > Hello Everyone!
> >
> > This series will introduce basic support (SD and UART) support for Texas
> > Instruments J784S4 EVM.
> >
> > The J784S4 SoC device tree patches are taken from kernel patch submissions
> > and will be updated as they are accepted and merged to the kernel tree.
>
> This patch set does not include any such, right?
>

I suppose you have missed to apply dependencies for this patch-set,
look for following:

Note: This series is dependent on the following series for OF_UPSTREAM support
https://lore.kernel.org/all/20240222093607.3085545-1-sumit.garg@linaro.org/

And, '[PATCH 01/15] Makefile: remove hardcoded device tree source
directory' has been
cherry-picked from PATCH 11 of
https://lore.kernel.org/all/20240201030634.1120963-16-bb@ti.com/ by
Bryan
Brattlof

-Sumit

[snip]

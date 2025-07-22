Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4B36C83F27
	for <u-boot@archiver.kernel.org>; Tue, 22 Jul 2025 07:33:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5EFB58329F;
	Tue, 22 Jul 2025 09:33:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Oajbxpu2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D7444832BF; Tue, 22 Jul 2025 09:33:34 +0200 (CEST)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B4EC382E26
 for <u-boot@lists.denx.de>; Tue, 22 Jul 2025 09:33:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=linux.amoon@gmail.com
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-60768f080d8so9912360a12.1
 for <u-boot@lists.denx.de>; Tue, 22 Jul 2025 00:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1753169612; x=1753774412; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3PcR3aoEe+DoumLch50nz44FU2U1nS/GTyJPvzCCvEo=;
 b=Oajbxpu2nTB7tsm3HbZ0YMt86W/CN1kC1vNo515Om8ziEdPWv3pHJX2pb0gt74qbyb
 CyMyD6sxKGksOHSw3jmL6luNTDDV310YWRf9c29ILEHpM/BQ5YtKUyLB++uIp4H2/9ic
 oeKB6RoUaZ0QolDErNl+xD3vcafG3ihuf3Zm33GBvYzxwWXnx0hhQloenmPlTEd455W+
 w9dCaxYFmOHqvQ+EUdI6ATnmuSMt+Og4HIBE+wT+b6WxP3ZXYlcO/DjL3HGX9bZSNIN2
 UZWuS8a+eiRFZQWrUFtENuJTGZcV/QPK9XE29bqIPiZnE8Eh+hso33RfMMVvSxqIc1dg
 YtTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753169612; x=1753774412;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3PcR3aoEe+DoumLch50nz44FU2U1nS/GTyJPvzCCvEo=;
 b=XxLFL7VMGo5s2z6GOS9lgvynCwHab73DS1lEyZnwQfZBKU22RMJ49d3TSCmPsEXc7O
 ebDGESdq0pJ6ynx23z7fY2GRwEar4Ngd2f2zmg+otnGWRUONbE1cJMoxfEnp4dD113KE
 qypHRVikH4c5yqAP6bZYbEGj0/Ygs3T2VFW8Oba+6q5f2oqMCBhiHpPevsXCVJ9fpt0p
 Xu+Dng83tIyulWs7NroqWWNlFGlfarhkBw17DYFINlxRzfRYjXYNUdwjrHPdFd1tLlv8
 /RXIbRGsVX2XGTEBHlVCphbT4NYbVsGq2b/y673rKu9WUv/MCXMB4FWSxJaGbhObkmfF
 CmGg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXkVl8kJqp0iAiS9wpBkfC7kwZI/P3G8afz1JGi8GG1wnMWKS/JGg1E9wW7exIXhwwHK0Liae0=@lists.denx.de
X-Gm-Message-State: AOJu0YzVzZOoDnHeDjsGkoyzNAXlEfV/9yAFYZyJo3TnyQXdXpWLVnaB
 aB830NGpE9TyOvu54ipnPBi0D0SYtRU/kU0dGQ7JtR5glVRu7XT82OkmYOb2BgNvXefu3WHWdhS
 z+M5Oc4mJFDxy/9pGcRLAxVR8cR3/nLg=
X-Gm-Gg: ASbGnctnlL0JtYpHPWMG9tapaveqUm77Y+gC29m35ww/G2oRe8gDtBqeRZjPpySVWH4
 YclSeS5KRMgJo2gPu6eq5nPVYFDFTi8b6jkEIsR9IMVUCJUsXz37v8HR3yJtzY0vhVji2SSYju5
 oFhafUUV2xTn8JZhm1XtMgHuOgxICSNLDMQVKI6WZaJN5NBGgDl3Ldxl6Kgc80iYd7d+U0iD8mh
 oXT
X-Google-Smtp-Source: AGHT+IF3uantWfCzqii2SLHa3GZ68AGotsZCnk9IkSwQaYn29etkJ5FvocvxBXGhEx5vL9FmMcmt/Q0fTyzair4uwBk=
X-Received: by 2002:a17:907:e2e6:b0:ae3:b22c:2ee8 with SMTP id
 a640c23a62f3a-ae9ce07c2e6mr2076421866b.37.1753169611792; Tue, 22 Jul 2025
 00:33:31 -0700 (PDT)
MIME-Version: 1.0
References: <20250720-samsung-mmc-fixes-v1-0-cb705abfa594@grimler.se>
 <20250720-samsung-mmc-fixes-v1-1-cb705abfa594@grimler.se>
In-Reply-To: <20250720-samsung-mmc-fixes-v1-1-cb705abfa594@grimler.se>
From: Anand Moon <linux.amoon@gmail.com>
Date: Tue, 22 Jul 2025 13:03:15 +0530
X-Gm-Features: Ac12FXziegBmlVybZixMyVMDvppoYOiWJ6rvP8KUoGkElYH_9-OYz_jQKm8uk3Y
Message-ID: <CANAwSgQQXZcQm3umesxOiywEYS0tdBF2L=cgE_G0ra8dH7rK4g@mail.gmail.com>
Subject: Re: [PATCH 1/3] mmc: s5p_sdhci: remove duplicated card detect code
To: Henrik Grimler <henrik@grimler.se>
Cc: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 David Virag <virag.david003@gmail.com>,
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Minkyu Kang <mk7.kang@samsung.com>, Tom Rini <trini@konsulko.com>, 
 ~postmarketos/upstreaming@lists.sr.ht, replicant@osuosl.org, 
 u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

Hi Henrik,

On Sun, 20 Jul 2025 at 22:40, Henrik Grimler <henrik@grimler.se> wrote:
>
> The common sdhci infrastructure is already parsing the cd-gpios
> property, since commit 451931ea7002 ("mmc: sdhci: Read cd-gpio from
> devicetree"). The s5p code is therefore duplicated, and also broken
> since it assumes that the GPIO value is inverted, while the sdhci code
> correctly follows the ACTIVE_LOW/ACTIVE_HIGH flag specified in the
> device tree.
>
> This fix was originally authored by Simon Shields:
> https://github.com/fourkbomb/u-boot/commit/2eac9dea7903
>
> The change has been tested on exynos4210-i9100, a device similar to
> exynos4210-trats.
>
> Signed-off-by: Henrik Grimler <henrik@grimler.se>
Reviewed-by: Anand Moon <linux.amoon@gmail.com>

Thanks
-Anand

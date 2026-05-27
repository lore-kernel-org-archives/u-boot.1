Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D370CD5BDE
	for <u-boot@archiver.kernel.org>; Wed, 27 May 2026 04:39:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE69F841D7;
	Wed, 27 May 2026 06:39:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="E6IkVt1I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 55D4784659; Wed, 27 May 2026 06:38:59 +0200 (CEST)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E22F80433
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 06:38:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-bd8f9725b30so1251146266b.3
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 21:38:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779856737; cv=none;
 d=google.com; s=arc-20240605;
 b=fJobQCOUwLCpCXoUfjiOUCvCkhlv0cAwr86zQW9pOUvNxCWLX9Qnt9bX3mylKZYaiu
 EnRpPMHHTcsaIodk9Spu5at/XmhszGMijrm7PbXnyChfMbc6Xa3OTBP2eknsASuHUo6/
 wiSqm6pG9quK0PBAQycQmwJB4e1CyP/ZMliAhBgDQgYw8VJUKGhYY9uSUWgm+EzhvNto
 2Yx9jPXT2P25ZG+6sxFDb3+pu2amU/Ve7iLXy1ZsbOB7mkT4/YsqIo+urJ02OivYxN3Q
 WrwnfyL/3JIJOsXObhrFz3V6MWGZ4PMUFvx8TELRm1jEZSYA5fdDK+6AY/o8tyUZFS+l
 0zmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=0+qlNxZ2G3qq76wnncytfUaBiaTh0Lx82oVvzapdkms=;
 fh=nqXbri/t605KwzaYj6FnepUyH8OpYdQ47z347Vj1Qjo=;
 b=Kbyu6AAEWLzrZCk9v63x1q/D2+qkh832DNleXFExrkVAnO7dv0hM9Sv65qCiV/723L
 qnd+Lx1NHoHdLFUiGNZpBPRYdMbmF5uz/XUfdFZ4FhP8z8IR7NKkrUzNOZ94hSsQAU2+
 a0xegsGqyapLqiFlhVhC1HF6I3ozjdKuIDUyX1DJPKQiheqNbCs9xo66OtxDRgFSl+JS
 b383X1cHE4L784sKF+aus8LHuOYeZC05z3aT0yNITnMiSWQ+8QRMdgmTeegtoZR6T7Jo
 GtJEvHMMJmsdqb5R107pgNT1HetSNqr4MlTToV8JIxtZswkqeDlBY0r4H4vm0RJ8UTWE
 1piw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779856737; x=1780461537; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=0+qlNxZ2G3qq76wnncytfUaBiaTh0Lx82oVvzapdkms=;
 b=E6IkVt1IxeUwemo/f1wuduOPHmVYb/9VRwlDDh5qTotG+HeLpRq0+wHvI4iTOPu4TJ
 K0vJlz2AjjujYDxKP3GD6URSUVTFxMAiJf5bnZ3XYk/4hxtiZo5L/ND/ZHGvW6JYe77t
 und+cRKX/UbifcUilUCDu/wQ1BvUNWp0ieI1s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779856737; x=1780461537;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0+qlNxZ2G3qq76wnncytfUaBiaTh0Lx82oVvzapdkms=;
 b=k9tr4GhVL76LJI20SbBo2QxwKwTjhAtq3xJ3VJHnpMZjOoUN5CFJnNaH9bKDNuJHT+
 crIsOHYUFSvdQnkdPgqgjxXaftpil2zSM9gOGj3yGTW4W0aS1beB+LlTJylGKDeZFK9R
 ID4JTJn5wT6Om+7dw8r+NnRId6rrdcyPm9XQPxQ6E/3SaUzoyzl393MmZAyd9zP/EeOi
 qqmrxDcqpa1WEsckDWcoXhr3oMY+sAo+KvTIb8z0XBxIbdQRrZF9aR14lrwzZqo1XGFp
 whWZRkh+MwaUqQuI9qgbf8rTS+X+KtdPgCHCHmuRCBR0TtH83PUWOoxy3KL0j5qBbLBY
 b7YA==
X-Gm-Message-State: AOJu0YySsniRya0ltvEdMWTlKLpxCY3HPiD+LR1JltVcGXKx51CRVGP3
 75UnbF3EyBpCti4pQyeRH2Vy5P9llhkIE3YhIYWj8ImQMFpHAT+iVvHXLzIsWTDkDaRxJvdkAk9
 9ABCA+sfgB2bm8uCMevPi9hz5sA6dnkdN1npGpgzd
X-Gm-Gg: Acq92OEV6i69/xc3uto/MWET+0UjQAVTGe07+S23CK+49Dv9pXhzUyDLSvb/wtFqqbi
 6hWKZMy3mHeuiQmFhIuRui/L5KPhKHlsEnszJ20i/5YN6rkSxo18uypQNZKy50iWkpd/zfSCkqG
 sLAOF02vNyuXb4/T5l/RPgT57rhDHZhQLl+NIfltHUx+1qBACmIGdIa2qQ3jGxa2OruGNFBmQJ4
 Nu09wXXNGH00PBFM73J9cD79QalLGO6rfKlgY1FIvL/DPTXRCLOCspzW5Ua0tewz5rPWntm8uiw
 0HzWdISQn2shUQNa
X-Received: by 2002:a17:907:b5a6:b0:bdd:87c:5bd0 with SMTP id
 a640c23a62f3a-bdd28a79cd4mr961410966b.11.1779856736834; Tue, 26 May 2026
 21:38:56 -0700 (PDT)
MIME-Version: 1.0
References: <20260213112717.1256823-1-aswin.murugan@oss.qualcomm.com>
 <20260213112717.1256823-7-aswin.murugan@oss.qualcomm.com>
In-Reply-To: <20260213112717.1256823-7-aswin.murugan@oss.qualcomm.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 26 May 2026 23:38:44 -0500
X-Gm-Features: AVHnY4Ltw7Aej8jac-goVC5QGSyATy1SgZboQXYrME1WYyQRXt7OkevtwNCAluA
Message-ID: <CAFLszTiwxAihD2QJ=OzGA4Uyu9Z9JGSww7=-TWvujWMuv=6kNQ@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] qcom_defconfig: Enable reboot-mode support in
 qcom_defconfig
To: aswin.murugan@oss.qualcomm.com
Cc: u-boot@lists.denx.de, sumit.garg@kernel.org, casey.connolly@linaro.org, 
 u-boot-qcom@groups.io, seanga2@gmail.com, trini@konsulko.com, 
 marek.vasut+renesas@mailbox.org, neil.armstrong@linaro.org, peng.fan@nxp.com, 
 quentin.schulz@cherry.de, n-francis@ti.com, xypron.glpk@gmx.de, h-vm@ti.com, 
 justin@tidylabs.net, jamie.gibbons@microchip.com, ycliang@andestech.com, 
 me@samcday.com, sughosh.ganu@arm.com, gchan9527@gmail.com, 
 ilias.apalodimas@linaro.org
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

On 2026-02-13T11:27:11, Aswin Murugan <aswin.murugan@oss.qualcomm.com> wrote:
> qcom_defconfig: Enable reboot-mode support in qcom_defconfig
>
> Enable reboot-mode functionality for all Qualcomm platforms that define
> reboot-mode device tree nodes. The drivers gracefully handle platforms
> without reboot-mode configuration, making it safe to enable globally.
>
> Add config options:
>   CONFIG_DM_REBOOT_MODE=y       - Core reboot-mode framework
>   CONFIG_REBOOT_MODE_NVMEM=y    - NVMEM-based storage backend
>   CONFIG_QCOM_SPMI_SDAM=y       - Qualcomm PMIC SDAM/PON access
>
> Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
>
> configs/qcom_defconfig | 3 +++
>  1 file changed, 3 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>

Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECA43CD6E6E
	for <u-boot@archiver.kernel.org>; Fri,  5 Jun 2026 00:11:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6C72C848BF;
	Fri,  5 Jun 2026 02:11:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TrHc1YUB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 146EB849AF; Fri,  5 Jun 2026 02:11:09 +0200 (CEST)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com
 [IPv6:2a00:1450:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3055884874
 for <u-boot@lists.denx.de>; Fri,  5 Jun 2026 02:11:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-5aa612bf6efso1322248e87.3
 for <u-boot@lists.denx.de>; Thu, 04 Jun 2026 17:11:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780618266; cv=none;
 d=google.com; s=arc-20240605;
 b=KKeii2EPkrEqsircu9P2LWOfpLpwY6frH+e/7jFWP7wZKp22rCxd1q3A4DNSAN4IXw
 9TycipQFn59F+JzfSzAm2LJUGd11qC2825x+oFCyDQqWIdUzP7tAeAybEisCfyzvOifK
 WeefAaYx1EWrA4a/5Et6fDhyX33AQqS/3TVuH2bdwwi0DR1AV6ovCpeJUkHrWEvB+biv
 mmVkI4bgCBnHSw+DmppW9IHv43Hszq5MWzFocAj3to8I7bJ6LFOW+X6ZwuunCnsRdwC6
 I9vqMDR/DVmObPnlxeiZyi/zDi+SDKME2cj2pR0httLtcbdEL8j7rTpFCLJeMCs1180z
 QW8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=MTcnU0tekaPXBvjAqc4IusVaHzUAVpy418he9p1+Mw4=;
 fh=Y58YhQxtiG+2+8m+bOJtLxSnx1aAFUaqmwf4ICy9DeY=;
 b=IR72tyYUsmckEv58bhdXDoZcUYAJd9NJym5oY6RVLGf2YhChuZAPJHKt0ajCd/PEEf
 LmWAAYDXF6fw7h4L33Y5Q0CErP8tpEXjswkFqjDlTpQiMQvGE0q/NkXSW7dXo6SWeCjW
 7d+E6HItPxdtOvkuIIugwhH2jgId7TI13dfN/hTjsJy0jwedELrT3cvXOEcD/fV9oDM4
 crvkxOtCm9T28EPZ1iwWqUcJXx9MhxAA6HUPrkofzEt3LRETw0qaeXA5viqnF+DChpH3
 R0rJXDvk5TaqozTdmRZWiVU6BnEL9AxJRf840+hwq0C3cZHHgkm3iFp+O1PaVOqbb83/
 63Wg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780618266; x=1781223066; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MTcnU0tekaPXBvjAqc4IusVaHzUAVpy418he9p1+Mw4=;
 b=TrHc1YUBsqJVDqj5jeeVJ+oxcBGA5lCgvn3C/fiXPavgnQunal0rVcgvhTh5Gr/34j
 xYW9OCqNZkEK4FC+JIfLX3iECQUYcZIkz9HEqWHmLeEQm8HZpc2iZfA10N1KF4w5VHdg
 rTUbO8Ul9osv13SMHNY/Rbw8sOuD2tZLfx5u5wnWFFoCoRuXLPYtiEa0S8gnv2SoHm1U
 rFTF/mOWt0zTaEJW/dkxgguVOCymIvB4syTyDsaccFCsiivwhr91cIvGzD+3IJa73hNZ
 AWGbM483rsUydOV5dHRViOIWzAWP+qfb3kkRfVgIvyNuD7v1nC9RkLK5wInKAojtrb0K
 /TjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780618266; x=1781223066;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MTcnU0tekaPXBvjAqc4IusVaHzUAVpy418he9p1+Mw4=;
 b=HiCxVvVKnqlFoe+nLDPu4Pnuj80oRD9aEXS7s7EKtviJSc3LkFBYqtQSgOro56QRtK
 zTEfl9txXry3Fu4xHV0QoVVASAo0j6je6vNXUS4QLA86s4Z02YjFchNiFMx6ym24ar4i
 UqFzzudCqCoHeaiTvc5HLVTh0/u5pesW/oXe7++5UGJE6901Q1aZhsTPZXm4forOmcLw
 z6YFbxTNAcqXBZD51c8L1/WVBPFctOGvyspPLQ+ZW/WoTzNKAHB+36cMuL6n4h8ITxhs
 etOc6/xiTvbjipKY+aXdhyZpeXvxTGJxTms6/O9VFukytf5bFGEnPeP4UnYB7DPpPu94
 02Tg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8PMyx4B4Bv9V2ny+w128kszkGTcVZf6WyoD1BvPUh9180hrLxr/8Go6BXLlDJpnngo1W0IAa8=@lists.denx.de
X-Gm-Message-State: AOJu0YzYOQcnHFXdvfSHu4UuO3lbrNFTE4it0H7BgtpW+wDyDreWmN5y
 Y3AZK/HlKUWzFW4TvoBPt06Ve6YJPtPkKd5HYffRIHFmh6evKtjqrS528YL5I6sr/UH06h7sDkG
 G+qwV1XzFxawnD0g3ltCSXDNT/Rj0BiU=
X-Gm-Gg: Acq92OHnEgCnFsfM+B50x6Uj6/HmhTb5yPFZNdsoDciY8cmIK/QqQ2ilYU1CxTukk8K
 E63f9PRQP2fTOHjGOOxULZYrDC8v2C9dlys7k2G5Aa6huaa7tkmoAVcGdG5XIschTsVjNTIxg0j
 HSwGw7nksxEWI91DAeebsmg8k7/M3l9O/lNlZBrQZP6g1YrWGqNxY6fy5VcyCiu4b9VzgdvNLf3
 uxR7es85UNxLORWc/sEIyzkpRaiLG43ce5acqIWRh4UbAMDzyGq1TSmmxKQbOQucwBX315Abz4a
 31x1mg+UGwKVuX5fmMoTi1TzeCrTYGLRKaWps0/IMiKgwG2iKL/M2H5Zx1DKShok+Kfh7KSurFj
 xYnzmgw==
X-Received: by 2002:a05:6512:3402:b0:5aa:500f:7bae with SMTP id
 2adb3069b0e04-5aa87b8f846mr192967e87.35.1780618266293; Thu, 04 Jun 2026
 17:11:06 -0700 (PDT)
MIME-Version: 1.0
References: <20260526114100.816424-1-frieder@fris.de>
In-Reply-To: <20260526114100.816424-1-frieder@fris.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 4 Jun 2026 21:10:55 -0300
X-Gm-Features: AVHnY4LIM9NzQdCRa-HYkdRfUr-iwewAsK6JT2fchn-3b1zD5wAY5mzyLXZGP0A
Message-ID: <CAOMZO5DkATr5EhLTPmMQAR=m+wbqpDwMiTJqoNwnUN4BPOkaBw@mail.gmail.com>
Subject: Re: [PATCH] imx: kontron-sl-mx6ul: Enable CONFIG_DM_MDIO to fix boot
 abort
To: Frieder Schrempf <frieder@fris.de>
Cc: Stefano Babic <sbabic@nabladev.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>, 
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de, uboot-imx@nxp.com, 
 Annette Kobou <annette.kobou@kontron.de>,
 Eberhard Stoll <eberhard.stoll@kontron.de>, 
 Oualid Derouiche <oualid.derouiche@kontron.de>
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

On Tue, May 26, 2026 at 8:41=E2=80=AFAM Frieder Schrempf <frieder@fris.de> =
wrote:
>
> From: Frieder Schrempf <frieder.schrempf@kontron.de>
>
> The following failure occurs right before switching to the kernel:
>
> data abort
> pc : [<9ff60162>]          lr : [<9ff79d13>]
> reloc pc : [<8781c162>]    lr : [<87835d13>]
> sp : 9bf30f78  ip : 9bf4b140     fp : 007963a0
> r10: fffffdfb  r9 : 9bf3bed0     r8 : 00004600
> r7 : 00000000  r6 : 9ffe5a0c     r5 : 00004600  r4 : 9bf4acf0
> r3 : f5f5f5f5  r2 : f5f5f5f5     r1 : 9ffe0c5c  r0 : 9bf7c130
> Flags: NzCv  IRQs off  FIQs off  Mode SVC_32 (T)
> Code: 9ffe b158 e9d0 2300 (6053) 601a
> Resetting CPU ...
>
> This is due to the fact that the board uses a shared MDIO bus for
> both ethernet controllers, but FEC_MXC_SHARE_MDIO is not enabled.
>
> This results in a double free in fecmxc_remove(). To fix this
> enable CONFIG_DM_MDIO so the shared MDIO is correctly detected
> from the devicetree.
>
> Fixes: 048fdda977ab ("imx: kontron-sl-mx6ul: Enable second ethernet inter=
face")
> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>

Applied to u-boot-imx/master, thanks.

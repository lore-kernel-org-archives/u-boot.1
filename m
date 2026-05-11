Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0580CD37B5
	for <u-boot@archiver.kernel.org>; Mon, 11 May 2026 11:11:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 65FCA8341A;
	Mon, 11 May 2026 13:11:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RXFPslPH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 061CA83A41; Mon, 11 May 2026 13:11:52 +0200 (CEST)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 20CF8801A9
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 13:11:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-67b8d9c26bbso7308822a12.2
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 04:11:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778497909; cv=none;
 d=google.com; s=arc-20240605;
 b=cX2Liu1mtX9KaGrItfuc7IMUt+zZGLlvFp9vb32q+xKO/GZlmufKQu5dFiDXlZk5Qg
 fTYV7az1VOMERL30hn0alTYF+IqjnQ/Vi8//ACbeQL3ccovIeOEZwlXZsDuLMQK/EvyT
 uP5V3i4Pa0UIGUJMxC2b8sLmMs+/dzlCErjjoRCgyOVE6dKPDNBmvb6n8ztGh34shAKH
 VbUX04EvKskG/IVi2ppYwBvjkZnQcu/dWpqYsz/JQs9xxdKPdgljub4ZickTkXi/cB6J
 wKdBr6f033+D6/pJJcmY22yU2E18dVOUtgvlx/kQYzs1qMwNa1ak9kj6sJjp5vxsZ+Mo
 Z82g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=NPqgidOigSBUlEdKF6PpY+5ZurI7V8/8n6urHxY1lM8=;
 fh=NnSAuInCgb4huhFqzH29w0mFAFXrNS66jl/+MZcydRo=;
 b=XUwp/OxBIxBjiUPzTf3G07WKVISv+me6YbYgcGffih7jHm68yaMcR0IDrtqilhqU+b
 UKSLOvrFBeic1k2J/a10U5Hon7IMdUhL8YthA2/TtlJqF0FybNIxgk+0BTPHxyjicF1Y
 3J/TG4fWpuCb72n+z3RirYh/8mctpkaxglSs6mbT2WZSLnMsCukV063PI7SogO4Dnd0D
 74T9nf34aJcQxLwCl+O98ZyS111FsBO8h8887/WDXuRS8I4198ggttUIUWPUhcambvf8
 6ZmCATN9il4UHeKXY6xhwQN/NerEZV8+MhI9G7XlQQKgy4GTP6Cr+Sq3pEDaZQZUq35y
 DMPw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778497909; x=1779102709; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=NPqgidOigSBUlEdKF6PpY+5ZurI7V8/8n6urHxY1lM8=;
 b=RXFPslPHzIie6f2m91XHyi8iacEHPmyGF7+gDu0Sxs4wGxllVoSktzckHKRgVJVxeR
 BI352hOCKbKGQ7+KDlIeN+eZDB3Yd1eIDJl+Ey15LM7qQw2j7Q3MOJjftJu7LxlyCpZG
 5RU8Zr5Qu5DJsqXjrXw+CollXUuKcnCDNbOHZMvlezcBSf+SySJDcqCtrl01OqpU/GOD
 oYYuX2X6vmQhuc0yKQHdqtG80dxvdDIn+vQ8NNcke50R/MJVE4F5jA2XJNHRQ8JOdd3w
 LM+4E9iRmPTMixjw823OFePly3c80Rhoz1BYNN4EvSw1Auq9JLu/DH+77FUYFNl9uVKP
 M2Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778497909; x=1779102709;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NPqgidOigSBUlEdKF6PpY+5ZurI7V8/8n6urHxY1lM8=;
 b=odsK2/P32Wc9uKhsHfSPHvQbC+AR7Ea1biSwmP/gSM2vMIb0GWJU/NbBoiU2pxSNAP
 QMo/k51sSkVlmWi8ZamZEnES9GnVm54ZV9s0rOuNXXa0XBGUfLGlGBNbkJ+SjKoeSXsj
 5W7UlWfr846bgY5Xswu5OX0uK2LhhYdLbH2CuUty4/S3k1ySMkzDzBB4knPBE6qBQJMR
 eVXaFGRRCSF+k+FuevZacZUgQtrqN1N95uYOLJLTlaLcAJs1LMc2q3pNtvwtspMPHK79
 gao1rqn9OQGPQ/1ENLZ+yo8HJl9dDK0dH1mFSnwggZTXyrRqXSV+16w+QxdziQF5Lwqy
 vJRA==
X-Gm-Message-State: AOJu0YyWyBaaFoc6oF65WoCawt6+BJXgrB1nZ4RDXVnb/8EF+IPrWb1C
 hUuukHTOGL+HZWl8sip2vb+Wuaxd218KORhMjBeeBHBqcBv4dMrzc+sdQHjQ54WpwvZFH8taq5H
 1LxyT52+Mt2CUWZaNvSZLr0pNeD+pvt0=
X-Gm-Gg: Acq92OFrKD9K8vc9kfSKkJyjdf0vf+axwq1RtzKEB+OlTUjFE7W8YOc50yjCHD516LM
 d5Azc7mMPQkgl8MFB+UbDrOVg14XavvbjvlrG/xOifPEmRQZZtoa0LL6axgx+EqIiUXM2ohSogp
 fUCvWreSY1tR0AGaYyYxIiHRt/lD/aQ4VDxkyZnD2UyzQhq1oIbg0e3vYO/DA3OSrfHirmibXYx
 P3nXzPwN9SG2OC47rer/Kvcr/r+fXEAY0DEx0UOmbDctCClmkrnNLYI6VLARduVxpWFy6Q8saXo
 w03uhQHbbKFmEAnBhVoytr57/NhTLf+Lddo3s61OGAzCKU9jbguhSa3E8H3xUYQPw3Rt/vEcNvJ
 Hef+ahmz0D2sz82c5nkBDTShOW1js1JyTF174U7p/CAiFpmLMLt3oRPX7xRDykMDSIXQ8Bmk5H5
 ca
X-Received: by 2002:a05:6402:3815:b0:67c:4c52:edf0 with SMTP id
 4fb4d7f45d1cf-67d638ae9ddmr12060266a12.2.1778497909256; Mon, 11 May 2026
 04:11:49 -0700 (PDT)
MIME-Version: 1.0
References: <20260509210607.51303-1-liel.harel@gmail.com>
In-Reply-To: <20260509210607.51303-1-liel.harel@gmail.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Mon, 11 May 2026 12:11:38 +0100
X-Gm-Features: AVHnY4JN1LXrhF9EKdqV_8QaLJihp6Jg8rIaXtiboD7Gk575XdUymUBNzeOtIBc
Message-ID: <CALeDE9Pstjpd0uFyUw8nu1UKvK++wt2tXCrj8n38m3CjSdZ9hg@mail.gmail.com>
Subject: Re: [PATCH] mmc: bcm2835_sdhci: Parse generic MMC device tree
 properties
To: Liel Harel <liel.harel@gmail.com>
Cc: u-boot@lists.denx.de, Matthias Brugger <mbrugger@suse.com>,
 Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>
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

On Sat, 9 May 2026 at 22:06, Liel Harel <liel.harel@gmail.com> wrote:
>
> From: Liel Harel <liel.harel@gmail.com>
>
> The bcm2835 SDHCI driver sets up the MMC host configuration via
> sdhci_setup_cfg(), but does not parse generic MMC device tree
> properties.
>
> As a result, properties such as bus-width are ignored. On Raspberry Pi
> Compute Module 4, the eMMC node describes an 8-bit bus, but U-Boot
> initialized the device as 4-bit.
>
> Call mmc_of_parse() before sdhci_setup_cfg() so that generic MMC
> properties are folded into the host configuration before the MMC core
> selects the bus width.
>
> Before this change, mmc info reported:
>
>     Bus Speed: 52000000
>     Bus Width: 4-bit
>
> After this change, mmc info reports:
>
>     Bus Speed: 52000000
>     Bus Width: 8-bit
>
> Tested on Raspberry Pi Compute Module 4 with onboard eMMC.
>
> Signed-off-by: Liel Harel <liel.harel@gmail.com>
Reviewed-by: Peter Robinson <pbrobinson@gmail.com>
Tested-by: Peter Robinson <pbrobinson@gmail.com> # on the CM4 as well

Thanks

> ---
>  drivers/mmc/bcm2835_sdhci.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/mmc/bcm2835_sdhci.c b/drivers/mmc/bcm2835_sdhci.c
> index 655d9902dfa..efa4d14f5da 100644
> --- a/drivers/mmc/bcm2835_sdhci.c
> +++ b/drivers/mmc/bcm2835_sdhci.c
> @@ -219,6 +219,10 @@ static int bcm2835_sdhci_probe(struct udevice *dev)
>         host->mmc = &plat->mmc;
>         host->mmc->dev = dev;
>
> +       ret = mmc_of_parse(dev, &plat->cfg);
> +       if (ret)
> +               return ret;
> +
>         ret = sdhci_setup_cfg(&plat->cfg, host, emmc_freq, MIN_FREQ);
>         if (ret) {
>                 debug("%s: Failed to setup SDHCI (err=%d)\n", __func__, ret);
> --
> 2.43.0
>

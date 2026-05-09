Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C01F9CD3447
	for <u-boot@archiver.kernel.org>; Sat,  9 May 2026 15:28:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2027484D3A;
	Sat,  9 May 2026 17:28:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LZ5vL2M3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 19FA784D3F; Sat,  9 May 2026 17:28:06 +0200 (CEST)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2748F84D31
 for <u-boot@lists.denx.de>; Sat,  9 May 2026 17:28:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-bcda7765d64so639066b.1
 for <u-boot@lists.denx.de>; Sat, 09 May 2026 08:28:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778340483; cv=none;
 d=google.com; s=arc-20240605;
 b=VRkYXa9q8l0gaWEklddEENbj2c4/dWuwy18crQyRqBIC/PpNAs57ssZTEBRttZSODz
 g9ocyzmgmbLHsNEXLnJ8rHoDr9VIdQlIS2lks0jGtmjYLsvguCV2Fe00n/+/v2EhR6jY
 FJ7x9G/umQ1ZGB5IKjy58zVjE3DXAkEDIUUxTNREF+OrShuuNAtK6IWswe+JQCZrd50z
 UO7l7TH0queIs3CRw44Fak5kwnpo9ZqJHV9QxkMYCUmPA4pn98Fq9p4jy/23MUVZLCVd
 5J1tvwfz0rsU9DhIkQQeduJD6zE+JKsaEQQYdQ2e4TBxq0VfvwmhicpQcTz52ub7HTd2
 DUUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=vGi9jZ+D22YL99bOS1xrQwVSy3ZrqZ/REJ7XO3cntU8=;
 fh=r3thpCWc9NCd461xtx07zCNvWrpaT3QraAQd5iSeiAo=;
 b=GdE0Qmsozyc7J70bozb1uA2itluQrbFPb/12VIt8mF6RzCgh+ixJqXZR/Dhqmpeq+t
 IOB++/g4R7E3M2R4ljpRK+GBJDcwuR1HqNBc5rRTir++2JBhAyeo12zDOMIqNxTJXlTq
 g1roQWQv+u+11dJgxvpHhRbQMcerTO9ZixDNj+pTiUip+e3eJk2RD81EujqkrT3Z33wn
 H2A6YUcTxs2ne6x5GwSUwkFBatZt5lUNe3uJuNTwyYtuzp9WGtz0/rmrEUjhyJoq3Fgo
 ewxc9U9EqA035AEzzVDPilNt+7nw9dOfqV5nrdiddCb3QI/IUBXr44vwMWffs8GgpAE9
 JQtA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778340483; x=1778945283; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vGi9jZ+D22YL99bOS1xrQwVSy3ZrqZ/REJ7XO3cntU8=;
 b=LZ5vL2M3Rs+oLIR82L3rv8CE+ejJ4Yp7LTXcGQXG299G6k3Y78LfAETu4X9x6T3O9v
 W7glWwZfD9dnJWsGoZIfGKeyt5jg/bTaIw/s1TdIlhuuAA6BaCD9z7ejAhjqTDfww3QE
 No0ZNrn5FWMin7Chryp8UTgvYXnSTavyJpjSx488oWpVXyl98f96UXtiGlvvlavXwog9
 Yp+BU6NRxLb70UXlcbOSyIJAVRYUpbz7S2XsoxuaC2irFgwnzeihaUzMTkAe8/lc04y3
 qSMc25igrXF/LN1ECVOjLl5JaW1Yf/ITjiCNU8xDhkQ2e3+yPCzAXEIZZ21idksV31pG
 arkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778340483; x=1778945283;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vGi9jZ+D22YL99bOS1xrQwVSy3ZrqZ/REJ7XO3cntU8=;
 b=mc7/wQYisZ6jxe0m0nHUcXXpqcHjmP0mo507/lR2xH2y48aoIs5ThF6dwDC5YBi65O
 6KVHG56N8VvzW1xS0hNeX6rwKq+zMvCHQySDALR8CDFoa3rWYrBRlRCLUqlei/RWs4HJ
 vGdbZk5PIe50FTWwmKLT4c6Z+S5SP2xqcm9REfdEs3xUy5pYOPET6az7QuChPpiKWESB
 q4s7/4LjLLvFWPzix4PVtbbxMJxrGwwRMXk1ATmiQBVU8JKTSk9cfX4Ei0A9HHLnzzEi
 Zasp19Op335jFYPtJ0WSlkSw4h3jjmhFdTpPEJe7HQfmbzQt9VKbDftxTnLMClaf7GZ7
 th8A==
X-Forwarded-Encrypted: i=1;
 AFNElJ+nbwgOPSV88IXbaG3jD6XEti7Tan2NMK748hoQTitUkCZDk6E0EPiHVwobto22c6nR5PrEzO8=@lists.denx.de
X-Gm-Message-State: AOJu0YyUDkPSXtdvk5jW3hrW2L94qm/WJRcW0m/sqS1i7ICh5q1mzo2B
 UIo1JRcurHlCLURTkFadsjZoUKLVSDXL5dVxTwKUe5RWrJ53RfpP+UR1Rp4jNakYB4EPGTdiPk7
 UERcjXKQk0x1LNpSzvm04ME7fcnRJXuc=
X-Gm-Gg: Acq92OFGYJ+FHVqeLw8bBXuMcqlPlVRDXmsD5TtDdPLLh8LNazQrkkBPWExbW49Cwhi
 KWzwHSPMvEUr7yek0794eT1MkVJEd96yawGmpxnOCtlsrah+kuDdWvFD1dDfrRTwLL+HAY/8Evq
 AOXjyxtAhUQw9cnXG4c4ZfpKgnCWA2hqAI+xwx6GZO8ytIIoYvlNahA0u1Bf5hHUn0a2Qyh749A
 QB2HJcFm1aonzFYR8dxK8jf4aIy3GPLMsg3hK3qSXSrEsYc620LLA6hIaxeoM8g+2fnlfqg0M9Q
 92CN+Ns5txwX2CId+Pkj9NtjLeJObVqhhbrKxn4yTebSAgJ5gFOXMXSS/030HjKFhWtfFpOPkyN
 EWzmRvTcm4uld8HGS14vx6iFbE1TICVEUO7tKPWk7XWqz9PLU30s6M8Kfdf+XXTN+vszXf1dZqr
 Hz
X-Received: by 2002:a17:907:7b9d:b0:bba:1743:33ce with SMTP id
 a640c23a62f3a-bc84d58c2b2mr568488166b.14.1778340483260; Sat, 09 May 2026
 08:28:03 -0700 (PDT)
MIME-Version: 1.0
References: <20260508154108.336B968BEB@verein.lst.de>
 <20260508154248.3532B68C4E@verein.lst.de>
 <CALeDE9M_ac4nNd1hpfbhk1a13pG2PNByN52ZehGrzDeedWyuMQ@mail.gmail.com>
In-Reply-To: <CALeDE9M_ac4nNd1hpfbhk1a13pG2PNByN52ZehGrzDeedWyuMQ@mail.gmail.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Sat, 9 May 2026 16:27:51 +0100
X-Gm-Features: AVHnY4KP-dnRPSdydPffdoDeQpkiHXHLyjzq_4BzBI2joZhDyHcJPtsGxF7lG3A
Message-ID: <CALeDE9MAWnm_LW5RXTVbG6mX2tmAES599UGgX+jbKvGG_xW_zA@mail.gmail.com>
Subject: Re: [PATCH 3/3] configs: enable NVMe
To: Torsten Duwe <duwe@lst.de>
Cc: Matthias Brugger <mbrugger@suse.com>, Bin Meng <bmeng.cn@gmail.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Andrea della Porta <andrea.porta@suse.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Simon Glass <sjg@chromium.org>, =?UTF-8?B?SmFuIMSMZXJtw6Fr?= <sairon@sairon.cz>,
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

On Fri, 8 May 2026 at 19:00, Peter Robinson <pbrobinson@gmail.com> wrote:
>
> On Fri, 8 May 2026 at 16:42, Torsten Duwe <duwe@lst.de> wrote:
> >
> > From: Torsten Duwe <duwe@suse.de>
> >
> > Enable NVMe in the Raspberry Pi 64-Bit default config
> >
> > Signed-off-by: Torsten Duwe <duwe@suse.de>
With the fix below:
Reviewed-by: Peter Robinson <pbrobinson@gmail.com>
Tested-by: Peter Robinson <pbrobinson@gmail.com>

Tested on CM4 with NVME, pci NIC
Tested on RPi5B both SoC revC and devD

> > ---
> >
> > Thanks to this series, U-Boot now supports the 64GiB address offset
> > used on the Raspberry Pi 5 for those inbound accesses.
> >
> > Remember that the other prerequisite on Rpi5 is the PCIe support
> > for bcm2712.
>
> I am in the process of testing this across my devices, awaiting a PCIe
> -> M.2 adapter so I can test on the CM4.
>
> One minor nit, I think we should scan for NVME drives:
>
> -CONFIG_PREBOOT="pci enum; usb start;"
> +CONFIG_PREBOOT="pci enum; usb start; nvme scan;"
>
> Peter
>
> > ---
> >  configs/rpi_arm64_defconfig | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/configs/rpi_arm64_defconfig b/configs/rpi_arm64_defconfig
> > index 38af5029403..18f8213f3b3 100644
> > --- a/configs/rpi_arm64_defconfig
> > +++ b/configs/rpi_arm64_defconfig
> > @@ -41,6 +41,7 @@ CONFIG_MMC_SDHCI_SDMA=y
> >  CONFIG_MMC_SDHCI_BCM2835=y
> >  CONFIG_MMC_SDHCI_BCMSTB=y
> >  CONFIG_BCMGENET=y
> > +CONFIG_NVME_PCI=y
> >  CONFIG_PCI_BRCMSTB=y
> >  CONFIG_PINCTRL=y
> >  # CONFIG_PINCTRL_GENERIC is not set
> > --
> > 2.54.0
> >

Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4A8CCD98D2
	for <u-boot@archiver.kernel.org>; Sun, 14 Jun 2026 11:51:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E57E84877;
	Sun, 14 Jun 2026 13:51:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="nU18XPPo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 624F184872; Sun, 14 Jun 2026 13:50:59 +0200 (CEST)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6918A83EEF
 for <u-boot@lists.denx.de>; Sun, 14 Jun 2026 13:50:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-6913fb25322so2952323a12.1
 for <u-boot@lists.denx.de>; Sun, 14 Jun 2026 04:50:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781437857; cv=none;
 d=google.com; s=arc-20240605;
 b=ZbDHangcYfDFCIc26dX4DDoL+WaWWCYAaXaklUNzlYRIpM2pL0QMC9B4z/6YSLApyy
 Qm8oZvJDeqnj7biwrBI1aVJk4rqWWbvuk0mBpAEqCF27T8AoDj5oLdWPY6VN2hW/9ZRO
 ugKV5mxN2Xqh2s6LXLDRekhRoq3OxJhKWSF0QLKGITSYkxgd/tSyD5R7IHlrKuprSMvD
 1yHSU1IZtA6Bg9Uf1Q1az6RGodxRPlCkjK6COvsLL0igIDNx380YkR+T4BaInKEB/J2S
 uGT2zD2GbdZg2GW/VfR8wjckn/pw6DscoMCJ6uZP2gtmRnyPoe3XUCO31YdmS1acMM5c
 ayNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=7oupiIRiC2YV+iVEMT9MTbnRpQKqj+BIXCgqq6WQXpc=;
 fh=b00tbBIs2dXWF6KvsynfUhedHtHGTTfzgmYSflFnFWY=;
 b=NL3zQFbPZi9gjj/Y18LW6DGAGzrJook9r5rbTS1q0cpUnDlf3rcJE+oAFbowZBP0Ex
 NywDp3zhLY4pF7+jdKFiZb7HBamTxpu1Woz+rQ3CJXkHLijb4HYCvrvLT/+M1hVi0ABF
 j1kWMctifN1RNIfRD8J4Q8v7DKQMaaipf7RZaRLlV4Xr1lx1O2jtjMNcPUDl3iuabfcO
 6MpDZ8dpRAV+pBx0c50pwy3Ejr7zkpf5rrpeGfEYY9O8czU6/+sBp31nlgZExTbhqfkT
 T1dp1EVhYOGFbgQ5uukBcBsMNTJfV72pC6q1pk63xo5nqJJK2jBiR8g2/HpP+00eNbAq
 06CQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1781437857; x=1782042657; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7oupiIRiC2YV+iVEMT9MTbnRpQKqj+BIXCgqq6WQXpc=;
 b=nU18XPPoANRxtYE06nKHOPkLxOuhNkPt5utmNGwNcQWt8ET4CDHIEE+zE+76ynQiCP
 msnw6vIacYLhzrgBwWP7oNTktb+r+sTPit+pvpNaetbuiY+WeBDTvHPVwIFJIK9vh65R
 gLgLzlX2j+SZdcWJxjTCCkzwkykLswXrem+tg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781437857; x=1782042657;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7oupiIRiC2YV+iVEMT9MTbnRpQKqj+BIXCgqq6WQXpc=;
 b=FQdmsePhTGAeBDP/r6CEcuMU582BlkjNU10oOGLuUKS5I7958sFlBRYMcjysqtVUo4
 pY2MXxmeO36woCd6aTfDbUQKNpPg+9ZqiEjQ52m1HUgUW3J40NTP1RZPM313Q+/5fFv/
 yQGNesYRU+ApBQXyOJAlyNdm0muUHGM1Lkmq0Wh/RUs4GT/ky3rmmcDrvDq7oZjAjVWs
 OJezxjJmYEZemZEohXQpSxtp+BbTuGXSDX8bZ5wWalOxr8oCLKwvVMCY3GWfnPFTgxtr
 +oPalqWRbdKIqOuV2L4y/IdDMGrDhrSQ99mMzeVmBzC8K8Z1IeCy+GLLop8J+C35cp9U
 yq9A==
X-Forwarded-Encrypted: i=1;
 AFNElJ+aO+i9r/R2b0cRFA07ABlomHJSyXhVKUP24IgxYaAs7gtRm1ytyKvH4FLi6/jBmioIvnhCP60=@lists.denx.de
X-Gm-Message-State: AOJu0Yy1HiV0qKqa1wiiSZ7CrMv/70D9STDVSb6ZLOE2hhJh0tM4XPx4
 AYOAAiJhmoCnYzdCk1O4ZpALrpeCJIKJMxNCpY4rOxgIO2jgs5/RLmygIWp/5t9X3xHveJ3Itf1
 is+JeKyRWMGMKTtSwfFtjuEEb4uIxepUnC6TeY7kq
X-Gm-Gg: Acq92OE9CLHrzPbNFvNlvbI77KxkxYhe6iN4tMP9GjzUfckBtYG6bqA+mZkJtulL7ss
 Jl69T4fK/75Dk2XsPiUXR9XNcLpPd8QBaeSl6YIZ+atzuKkrxdQWMhYn/wfWiz4MswRRFndflSy
 TwQKF/oD4P9sMAph8/xzFNW9XeR1oIyC8DurR2FqTedxfeeFbvKOaUaek0Q234CSwUjjI9+fDKl
 U1O+9C75fuRbhkXxlENZC1l6obhvXqwnYnHZ/iTxGtIZHp+m1SXhI06NqfF1f4k2rlmEMmYXCTp
 hELwvQ==
X-Received: by 2002:a05:6402:2696:b0:692:500f:f91 with SMTP id
 4fb4d7f45d1cf-69378a03aedmr4565847a12.10.1781437856860; Sun, 14 Jun 2026
 04:50:56 -0700 (PDT)
MIME-Version: 1.0
References: <20260601103557.022EB68B05@verein.lst.de>
In-Reply-To: <20260601103557.022EB68B05@verein.lst.de>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 14 Jun 2026 05:50:43 -0600
X-Gm-Features: AVVi8Cdk2JWLnZBNzSKejcDOHNhhTt93P0IUr2yDKHpuAPL3Z7pf3Op5CrAkZas
Message-ID: <CAFLszTj4F+Wpv2QOtKPyK6sApK5YpBWtCdpi0vJa6FNgUgYWvw@mail.gmail.com>
Subject: Re: [PATCH v5 0/9] ARM: RPi5: Enable PCIe
To: Torsten Duwe <duwe@lst.de>
Cc: Peter Robinson <pbrobinson@gmail.com>, Matthias Brugger <mbrugger@suse.com>,
 Tom Rini <trini@konsulko.com>, =?UTF-8?B?SmFuIMSMZXJtw6Fr?= <sairon@sairon.cz>,
 Andrea della Porta <andrea.porta@suse.com>, "Ivan T. Ivanov" <iivanov@suse.de>,
 Stanimir Varbanov <stanimir.varbanov@suse.com>,
 Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>, 
 Volodymyr Babchuk <volodymyr_babchuk@epam.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Paul Barker <paul.barker.ct@bp.renesas.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Christian Marangi <ansuelsmth@gmail.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, Huan Zhou <me@per1cycle.org>, 
 Gabriel Fernandez <gabriel.fernandez@foss.st.com>,
 Kever Yang <kever.yang@rock-chips.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Joseph Chen <chenjh@rock-chips.com>, 
 Elaine Zhang <zhangqing@rock-chips.com>, Pedro Falcato <pfalcato@suse.de>,
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

Hi Torsten,

On Mon, 1 Jun 2026 at 04:36, Torsten Duwe <duwe@lst.de> wrote:
>
> Basic PCIe support for the RPi5. This is the prerequisite for PCIe
> slot adapters / HATs and NVMe storage. Those might require their own
> supporting drivers or changes. It is also the prerequisite for all
> peripherials residing on the RP1 I/O controller, like USB, network,
> GPIOs and all serial ports beyond the debug connector.
>
> Changes from v4:
>   - fixed remaining style issues, no functional changes
>   - patches 3&6 Reviewed-by Neil Armstrong
>
> Changes from v3:
>   - differentiate only between bcm2711 and -12. No possible future
>     extensions for other chips. In particular, keep EXT_CFG_INDEX and
>     EXT_CFG_DATA offsets fixed, no functions in the cfg struct that
>     are the same for both, like bridge_sw_init_set and rc_mode.
>   - pass error codes through the newly introduced reset call chain
>   - some patches Reviewed-by Neil Armstrong
>
> Changes from v2:
>   - fix wrong subject prefixes
>   - make reset drivers only found on the RPi5 depend on ARCH_BCM283X
>   - some patches Reviewed-by Peter Robinson
>
> Changes from v1:
>   - fixed inbound window rewrite, which broke RPi4
>   - series Tested-by Pedro Falcato
>
> Andrea della Porta (1):
>   pci: brcmstb: Fix PCIe bus numbers
>
> Torsten Duwe (8):
>   ARM: bcm283x: Add bcm2712 PCIe memory window
>   pci: brcmstb: Support different variants using a cfg struct
>   reset: Add RPi5 brcmstb reset facilities
>   reset: Add RPi5 rescal reset facilities
>   pci: brcmstb: Get and use bridge and rescal reset properties
>   pci: brcmstb: Fix iBAR size calculation
>   pci: brcmstb: rework iBAR handling
>   pci: brcmstb: Adapt to AXI bridge
>
>  .../mach-bcm283x/include/mach/acpi/bcm2711.h  |   6 +
>  arch/arm/mach-bcm283x/init.c                  |  10 +-
>  configs/rpi_arm64_defconfig                   |   2 +
>  drivers/pci/pcie_brcmstb.c                    | 389 ++++++++++++++++--
>  drivers/reset/Kconfig                         |  16 +
>  drivers/reset/Makefile                        |   2 +
>  drivers/reset/reset-brcmstb-rescal.c          | 103 +++++
>  drivers/reset/reset-brcmstb.c                 |  97 +++++
>  8 files changed, 589 insertions(+), 36 deletions(-)
>  create mode 100644 drivers/reset/reset-brcmstb-rescal.c
>  create mode 100644 drivers/reset/reset-brcmstb.c
>
> --
> 2.54.0
>

I see that this series has been applied to -next although I didn't see
any 'applied' email here.

Do you know how I could try this out, please? I have a GeeekPi N07
PCIe M.2 M-Key NVMe. What sort of changes might I need to make?

Thanks,
Simon

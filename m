Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7434CD5BA4
	for <u-boot@archiver.kernel.org>; Wed, 20 May 2026 17:35:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DCD70846BD;
	Wed, 20 May 2026 19:35:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dCoBbOLU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F0E8846DD; Wed, 20 May 2026 19:35:51 +0200 (CEST)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1013D8464D
 for <u-boot@lists.denx.de>; Wed, 20 May 2026 19:35:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-6870f904c6bso2077392a12.0
 for <u-boot@lists.denx.de>; Wed, 20 May 2026 10:35:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779298548; cv=none;
 d=google.com; s=arc-20240605;
 b=fJ+mXA2kLyD2VfV77KywnLL+F1nAeshK8QmmVuVpAUA3aocKKCeWwl3Q5h74nZWmZI
 ck0I/ln5yCNN2829IJP6D8oKqAKvb9JrdOkf5gyzh9Ku5sDh3aeir4pPRb3TSo2ENtmH
 aXyp2cKK5GP6wDhZo1MXnBQJvpqn7okioa4Sk3LDIc7c3m1ND+lUAlt6+ACQixt+shYX
 +rBqNv2VI00UIrZgwm3p/BGAJNs0LtLCkQ8aK0e0HvthkzBE5MUrGDmslrMT0F+lyEfZ
 U5dRXj2j7TgE6tlzZAdu1rPFqi7keA8geVvJgqmNMd+9cb4LGxrRBzS3SRlMSEKUXfce
 +UQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=mMvqKDMxIMtC9xMWTO4SGzPApiKmf25xeNl52AqzJGk=;
 fh=b2MinOpyv1tOyH0ZOlr/dLBrNEyXiMlqLDhqH+NcVBI=;
 b=jEAHdBe6FGXktiYP/ZuSDVQLjlbs2OX4bLaxvWEuCHPrbQuPjkwzK2TNfk8s814CGT
 XAIDJ7bHcigAygsMYcQy77x/VQfLZHRd/iXFQTximdqkcld2oKwARGspY9rrmt3fPkqf
 aiyRa8Sj8B6O+mNLxhYOlzgxQOAdiGi5Wx21q+XcnCO3AxntYU0SZL03zrHuatyGukvi
 Y9pzW1gZPbxKuDjhkDhbZu6TmkhpdNdoc03B+Og/frQ5hJohCbqlVbE+14lMV3UeId6S
 j2Pzb8+nAuHX7M8fApEfboG5ybkz/QIpxmXbV9C3YLdc+T3XVoLkWir/YXCdGDPRC7Yw
 rexA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779298548; x=1779903348; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=mMvqKDMxIMtC9xMWTO4SGzPApiKmf25xeNl52AqzJGk=;
 b=dCoBbOLUIXEbqzg7g/HqG/hVzi85ft6E8Bsm1KeZy3GH+B5yqvzWHiW6HoS6oG1j6H
 mw4U0rhCQw7Y0eaMbGao7T9Qc2eczlZApRA4j/SWxf76zGxkqt0U1I1qmp7rH+NN7Sgm
 WQdDdIITwXyqD+ZbrUQT00kdnk7IgXr2E768rSuBzop0eXujFMFMwde9xn19aZ61lrlH
 XK/thwgjX/772NLSR0SBWJKNDB2FpkJKTC+NRYEBSxR94WEpOTf47qC4YArfkRgQJQ6z
 NJatgSgu1j/fsLS9+t+/18V5KhWSV9sqN/Z6Ony3RblsNUeHKpd6dlaIhQgAK0yfDpAI
 bdOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779298548; x=1779903348;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mMvqKDMxIMtC9xMWTO4SGzPApiKmf25xeNl52AqzJGk=;
 b=qh9mKkveLd2Tqm1V6YkdQ1XyKIXDECpgVWKlNu1FRi05TPFmIP13B4FHey4hIiY/05
 rHPcZ4yBJyAaBVrB7MpktdQrcsvVq1mD3tMNoqS4JoT18chTe0ub6gpI/TucvQoMZJHK
 jdYo/vEVz8FCwnu8A+0nRW675OOQsbzv4wGiKSaa4h1MIAgaqN2xb9I98iCM7Q7iVxLX
 B9IGuHJufmfJhJxFkDcuegC1TuqbSmonswdCM6K50OctdwmS66rX+e2C6VHeYCXRUYcS
 xER/GkyEx0N0c+zYhyu5XXtIGy9CB+LAnN7PnfM3eQILZ9USOTlGIhKG5k3EBnz/+oV5
 XMPw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9pk5Cso7jVl4jacZvNCn8NDQGseaYYDP9f2PCtt1MXKelkBRYtmDacM4ZUROSesE8cWEysbJg=@lists.denx.de
X-Gm-Message-State: AOJu0YzXf+6S0ksLEXv47ytouLia+GxGABn4OyfhxexudaQ8Tuy8unRJ
 3kfltX4Fxb20QfRcqgucuYav8MkWxGr+xVC1Za8uAI5Q+70925MGVHGM2Lwni8QACf3Y3acT+NK
 GvbgQKZlsDFRoKIYhxo9P0Ai7fGKicLI=
X-Gm-Gg: Acq92OGhaVeY3j+c1388058KB6stpO7LE3AlvwcwiEMdP2y64vBLjyvM6WrVL2U5oSE
 qHhjC0YwIhz1gDnmSAxVC0Lfs0O7n66l5zprr+Cs0kpcmNQzojALQqNrfk64Yir27hbwsuCZ/v4
 9DdweJwdojfUW8f0RaeJiFSbh0RBH4leTMiRX8QUB7Nxbf/xQSwAz8pxA+VlPREzLAdroTh6Gt5
 jmvnE6nfX1CXZF1AHnMxvncZJBE/gSWjEdNrZfpn9yqEeDJCLKnRFUojxGzG5UPaka1vylJConm
 o+H82nd9x58iIO7LD09PHPnxau/ZhnTibtV5oFbo535JbE6zC903Mv/g6K1das/cG9DHwasLPhH
 l+7d3GLmwVN8mUlU8HILAtiAAh2VVkr6Fd9Glr5rZuxQfNYSvVmJpuN5D1CzwUXCHfuXozwSCdr
 eI
X-Received: by 2002:a05:6402:5306:b0:670:f48b:caf8 with SMTP id
 4fb4d7f45d1cf-683bc8a214emr12297911a12.3.1779298548190; Wed, 20 May 2026
 10:35:48 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1778619453.git.aidan@wolfssl.com>
 <20260513002625.76915-14-aidan@wolfssl.com>
 <e369ec39-56ff-499f-9de8-f905373c7f89@suse.com>
In-Reply-To: <e369ec39-56ff-499f-9de8-f905373c7f89@suse.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Wed, 20 May 2026 18:35:37 +0100
X-Gm-Features: AVHnY4Ix3sH0b3dZEF1BhxHmjRaB2dKwrTkqkAlOo8GDJENrWWxJQS1bE_hL1Sg
Message-ID: <CALeDE9MfDk4y=wsYhT=1S88_sOsNSXZcNLFf-u1gJMCYC9ePKw@mail.gmail.com>
Subject: Re: [PATCH v4 14/14] configs: add rpi_4_wolftpm_defconfig
To: Matthias Brugger <mbrugger@suse.com>
Cc: Aidan Garske <aidan@wolfssl.com>, u-boot@lists.denx.de, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Tom Rini <trini@konsulko.com>, 
 David Garske <david@wolfssl.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>
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

On Fri, 15 May 2026 at 12:31, Matthias Brugger <mbrugger@suse.com> wrote:
>
>
>
> On 13/05/2026 02:26, Aidan Garske wrote:
> > From: Aidan <aidan@wolfssl.com>
> >
> > Add a new defconfig variant for Raspberry Pi 4 that enables the
> > wolfTPM stack and the hardware SPI driver out of the box, so users
> > with an Infineon SLB9670 / SLB9672 TPM HAT can build a working
> > U-Boot in a single 'make rpi_4_wolftpm_defconfig && make' step.
> >
> > This is a separate defconfig rather than a modification to
> > rpi_4_defconfig because the average RPi 4 user does not have a
> > TPM attached and should not pay for SPI + TPM + wolfTPM code size
> > by default - that was the concern raised against v3's modification
> > of rpi_4_defconfig.
> >
> > Compared to rpi_4_defconfig this enables:
> >   - CONFIG_SPI / CONFIG_DM_SPI / CONFIG_BCM2835_SPI / CONFIG_CMD_SPI
> >     The hardware SPI controller driver added earlier in this series,
> >     plus the spi command for diagnostics.
> >   - CONFIG_TPM / CONFIG_TPM_V2 / CONFIG_CMD_TPM
> >     The core TPM 2.0 stack and 'tpm2' command.
> >   - CONFIG_TPM_WOLF / CONFIG_CMD_WOLFTPM / CONFIG_WOLFTPM_SLB9672
> >     wolfTPM as the active TPM backend, with SLB9672 firmware-update
> >     support enabled.  CONFIG_WOLFTPM_LINUX_DEV is left off so
> >     wolfTPM uses its native SPI HAL (the Linux-dev path is the
> >     QEMU+swtpm path, not the bare-metal RPi path).
> >
> > No debug / unit-test config (LOG, LOGLEVEL, UNIT_TEST,
> > CONSOLE_RECORD, HEXDUMP) is enabled - those belong in a developer's
> > local .config, not in a defconfig shipped in tree.
> >
> > Signed-off-by: Aidan Garske <aidan@wolfssl.com>
>
> Peter what is your view on that. Shall we add config options for specific hats?
>
> I'm inclined to do so, but I wonder if we can have some kind of config overlay
> instead of a fresh new config. (I'm not aware that U-Boot allows for something
> like this right now).

I covered it in my reply to the cover letter[1], in short it should
likely be based on rpi_arm64, and it can use include files to reduce
maintenance burden.

[1] https://lists.denx.de/pipermail/u-boot/2026-May/618524.html

> Regards,
> Matthias
>
> > ---
> >   configs/rpi_4_wolftpm_defconfig | 81 +++++++++++++++++++++++++++++++++
> >   1 file changed, 81 insertions(+)
> >   create mode 100644 configs/rpi_4_wolftpm_defconfig
> >
> > diff --git a/configs/rpi_4_wolftpm_defconfig b/configs/rpi_4_wolftpm_defconfig
> > new file mode 100644
> > index 00000000000..4301d2a3e93
> > --- /dev/null
> > +++ b/configs/rpi_4_wolftpm_defconfig
> > @@ -0,0 +1,81 @@
> > +CONFIG_ARM=y
> > +CONFIG_ARCH_BCM283X=y
> > +CONFIG_TEXT_BASE=0x00080000
> > +CONFIG_TARGET_RPI_4=y
> > +CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
> > +CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x7fffe30
> > +CONFIG_ENV_SIZE=0x4000
> > +CONFIG_DEFAULT_DEVICE_TREE="bcm2711-rpi-4-b"
> > +CONFIG_OF_LIBFDT_OVERLAY=y
> > +CONFIG_DM_RESET=y
> > +CONFIG_SYS_LOAD_ADDR=0x1000000
> > +CONFIG_PCI=y
> > +CONFIG_EFI_RUNTIME_UPDATE_CAPSULE=y
> > +CONFIG_EFI_CAPSULE_FIRMWARE_RAW=y
> > +CONFIG_BOOTSTD_DEFAULTS=y
> > +CONFIG_OF_BOARD_SETUP=y
> > +CONFIG_FDT_SIMPLEFB=y
> > +CONFIG_USE_PREBOOT=y
> > +CONFIG_PREBOOT="pci enum; usb start;"
> > +CONFIG_SYS_PBSIZE=1049
> > +# CONFIG_DISPLAY_CPUINFO is not set
> > +# CONFIG_DISPLAY_BOARDINFO is not set
> > +CONFIG_MISC_INIT_R=y
> > +CONFIG_SYS_PROMPT="U-Boot> "
> > +CONFIG_CMD_NVEDIT_EFI=y
> > +CONFIG_CMD_DFU=y
> > +CONFIG_CMD_GPIO=y
> > +CONFIG_CMD_MMC=y
> > +CONFIG_CMD_PCI=y
> > +CONFIG_CMD_SPI=y
> > +CONFIG_CMD_USB=y
> > +CONFIG_CMD_EFIDEBUG=y
> > +CONFIG_CMD_TPM=y
> > +CONFIG_CMD_FS_UUID=y
> > +CONFIG_CMD_WOLFTPM=y
> > +CONFIG_ENV_FAT_DEVICE_AND_PART="0:1"
> > +CONFIG_ENV_RELOC_GD_ENV_ADDR=y
> > +CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
> > +CONFIG_TFTP_TSIZE=y
> > +CONFIG_DM_DMA=y
> > +CONFIG_DFU_MMC=y
> > +CONFIG_SYS_DFU_DATA_BUF_SIZE=0x100000
> > +CONFIG_SYS_DFU_MAX_FILE_SIZE=0x200000
> > +CONFIG_BCM2835_GPIO=y
> > +CONFIG_MMC_SDHCI=y
> > +CONFIG_MMC_SDHCI_SDMA=y
> > +CONFIG_MMC_SDHCI_BCM2835=y
> > +CONFIG_BCMGENET=y
> > +CONFIG_PCI_BRCMSTB=y
> > +CONFIG_DM_RNG=y
> > +CONFIG_PINCTRL=y
> > +# CONFIG_PINCTRL_GENERIC is not set
> > +CONFIG_RNG_IPROC200=y
> > +# CONFIG_REQUIRE_SERIAL_CONSOLE is not set
> > +CONFIG_SPI=y
> > +CONFIG_DM_SPI=y
> > +CONFIG_BCM2835_SPI=y
> > +CONFIG_SYSINFO=y
> > +CONFIG_SYSINFO_SMBIOS=y
> > +# CONFIG_WOLFTPM_LINUX_DEV is not set
> > +CONFIG_WOLFTPM_SLB9672=y
> > +CONFIG_USB=y
> > +CONFIG_DM_USB_GADGET=y
> > +CONFIG_USB_XHCI_HCD=y
> > +CONFIG_USB_XHCI_PCI=y
> > +CONFIG_USB_KEYBOARD=y
> > +CONFIG_USB_GADGET=y
> > +CONFIG_USB_GADGET_MANUFACTURER="FSL"
> > +CONFIG_USB_GADGET_VENDOR_NUM=0x0525
> > +CONFIG_USB_GADGET_PRODUCT_NUM=0xa4a5
> > +CONFIG_USB_GADGET_DWC2_OTG=y
> > +CONFIG_USB_GADGET_DOWNLOAD=y
> > +CONFIG_VIDEO=y
> > +# CONFIG_VIDEO_BPP8 is not set
> > +# CONFIG_VIDEO_BPP16 is not set
> > +CONFIG_SYS_WHITE_ON_BLACK=y
> > +CONFIG_VIDEO_BCM2835=y
> > +CONFIG_CONSOLE_SCROLL_LINES=10
> > +CONFIG_PHYS_TO_BUS=y
> > +CONFIG_TPM=y
> > +# CONFIG_HEXDUMP is not set
>

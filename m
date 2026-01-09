Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EF35D232C1
	for <u-boot@archiver.kernel.org>; Fri,  9 Jan 2026 01:41:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 12B5F841FF;
	Fri,  9 Jan 2026 02:41:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AJlqYAKd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8546784206; Fri,  9 Jan 2026 02:41:55 +0100 (CET)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 895B78415D
 for <u-boot@lists.denx.de>; Fri,  9 Jan 2026 02:41:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-b7ce5d6627dso784817966b.2
 for <u-boot@lists.denx.de>; Thu, 08 Jan 2026 17:41:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767922913; x=1768527713; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=uTlctz8f4Z58pae92pGZNmZWT041Q8Ey9K1LHGTdXts=;
 b=AJlqYAKd5zuoJzQRowLoXMh/hRYb2//hOAigC9wjsJnLmRUpi32c4Hvw5AlnEcIS8Z
 /gkZGePK9DHZluiAp3tExHi+lTGTqJ+D9qY3tAv42v8XoGi+JqruLVqaO9GPVU40bxA4
 03RN+NOFc0CBv5KfhZjgWkzVGcdpRiC3mXg+Ec3XSK2DVzdb6w7wg09ONjGq0JZYc0KI
 GCa/PuEFww4I996Sg1/kIq3P6MT3SeCrUIXrFvM6XOh7TqPEzuu7gNoN2Z6csITCmdnu
 7oarbUqf91M70CfvIfeWo25xHAHAUohy5fKTa4vVZHfn4VRPPX4LSSrVe0qhBALzEb3x
 nPVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767922913; x=1768527713;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uTlctz8f4Z58pae92pGZNmZWT041Q8Ey9K1LHGTdXts=;
 b=s0YZO1Izwb8ZNIGu/3zkyci+e943aNJ+9xIcOvlpMnCHaP5vi0tlKFlBFHU+6vg2X6
 qIATnuXiqkPuWMpPbbs+CN/8OjbvXz5e2YfyzpDfH/G0yciHWYhrI6kIHnYbQQyvfa9d
 FfpMh+aw7x1bNHXudknmMToE34qoZTorkDEVozL5TMf3kThkUC9hPegM4w/qpYbHHKPz
 wYIvaUmOxXTSRsYrNWSxgSDSY8Odi297QTxf2zHEiKw2mYzoGzLYpzWX8VQ201spbIVq
 c2oACb/FjARuoJT+jFqYzYDNNFl6tcOi/xAApMnjfadIrUzpObGc/XXYVHj4gSCG92Oa
 2emg==
X-Gm-Message-State: AOJu0Ywg+TYWzjKbHuJBv+Cegys3xaRwKIokLYpkW2NfznMSY9Omvby5
 CTOD2yE0iGg2r72wLbByhK+xorb3RquOOhU2ke+m1YHLsyVP96Cp7bm7/z+0aZxmCJ1Lo7mBeLv
 5IDW7nB7I0ZtuMH3wQPQak/WuJZgxY14=
X-Gm-Gg: AY/fxX4ZrS8sUfQbQclWnJvwS8gUNbd4cNtdx0ZtWW+UUzVPTsjqhlkLJNs4AlhdEbs
 bKdVvUljfr3zwmmZhhScvnZTfI+f/Gw0/HhN9M3+ZPBMMUfmPlIdQ4dR4w7JrR0tUp6vTTqCq+j
 yQLT8UFD94/axbRsFB2vwODcEdnRqJ0aLpTNta5K6yjFB0vbPT/i7YpTUsHbL1Wfujdj5+eGNIa
 x/CuqRTOtrf7RzDC4HKr90xnQzFWlknv79CAEAP9BazYPE6aYkBTCM4oLrnuTmZ6bO4jfzl6YRK
 DQSERMDnio1sz7Tc3amoHvcsEznlyWDPL26JOHRdp92iVQuBrxflPTBjzFHDOAymGnto/kqbFng
 EjDU4zwsVDb3/Q46Fv80qytinaskncMTebH6M
X-Google-Smtp-Source: AGHT+IGRtpI9jEWjKSgFAyEvHBcpSe1TzrhanmBEf0hZ2yqfSP9vxizQROvmG02BYA+mKR5EVmHcmYL6IqXW2uEQIIs=
X-Received: by 2002:a17:907:25cd:b0:b84:40d3:43c6 with SMTP id
 a640c23a62f3a-b8444d4ea73mr759084366b.11.1767922912677; Thu, 08 Jan 2026
 17:41:52 -0800 (PST)
MIME-Version: 1.0
References: <20251108-vop2-pt2-v6-0-d04c699262fb@mainlining.org>
 <jwvwm1rep4n.fsf-monnier+gmane.comp.boot-loaders.u-boot@gnu.org>
In-Reply-To: <jwvwm1rep4n.fsf-monnier+gmane.comp.boot-loaders.u-boot@gnu.org>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Fri, 9 Jan 2026 01:41:41 +0000
X-Gm-Features: AQt7F2o6uyD1jHyjWPA6TdaGyI9NxrEMwWonpYNYjPO0QqJ2zbWTXNY9SAgJnNU
Message-ID: <CALeDE9Oe-JG_cbVRNS=oe9x-SVxx9K-L31nmnyUDoJzvUqaO=g@mail.gmail.com>
Subject: Re: [PATCH v6 00/12] Rockchip VOP2 support
To: Stefan Monnier <monnier@iro.umontreal.ca>
Cc: u-boot@lists.denx.de
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

On Thu, 8 Jan 2026 at 22:18, Stefan Monnier <monnier@iro.umontreal.ca> wrote:
>
> Dang Huynh via B4 Relay [2025-11-08 12:37:56] wrote:
> > This series adds VOP2 support to U-Boot and enable it for PineTab2.
> > HDMI should work flawlessly but there's still some timings issue with
> > DW MIPI DSI, perhaps that's something to look into later.
>
> I'm trying to use this patch on my NanoPi R5S and the result is not
> quite what I expect.  I suspect I'm doing something wrong.
>
> I applied the above patch to the tip of the current u-boot (there was
> a trivial conflict in a Makefile, but nothing of significance).
> Then I applied the following patch:
>
>     diff --git a/configs/nanopi-r5s-rk3568_defconfig b/configs/nanopi-r5s-rk3568_defconfig
>     index 1653ab8b44f..d707dd5bc29 100644
>     --- a/configs/nanopi-r5s-rk3568_defconfig
>     +++ b/configs/nanopi-r5s-rk3568_defconfig
>     @@ -56,6 +56,7 @@ CONFIG_DWC_ETH_QOS_ROCKCHIP=y
>      CONFIG_RTL8169=y
>      CONFIG_NVME_PCI=y
>      CONFIG_PCIE_DW_ROCKCHIP=y
>     +CONFIG_PHY_ROCKCHIP_INNO_HDMI=y
>      CONFIG_PHY_ROCKCHIP_INNO_USB2=y
>      CONFIG_PHY_ROCKCHIP_NANENG_COMBOPHY=y
>      CONFIG_SPL_PINCTRL=y
>     @@ -80,4 +81,12 @@ CONFIG_SPL_USB_DWC3_GENERIC=y
>      CONFIG_USB_GADGET=y
>      CONFIG_USB_GADGET_DOWNLOAD=y
>      CONFIG_USB_FUNCTION_ROCKUSB=y
>     +CONFIG_USB_KEYBOARD=y
>     +CONFIG_VIDEO=y
>     +CONFIG_DISPLAY=y
>     +CONFIG_VIDEO_ROCKCHIP=y
>     +CONFIG_DISPLAY_ROCKCHIP_HDMI=y
>     +CONFIG_VIDEO_DT_SIMPLEFB=y
>     +CONFIG_VIDEO_BRIDGE=y
>     +CONFIG_VIDEO_REMOVE=y
>      CONFIG_ERRNO_STR=y
>
> I also changed the U-Boot config to extend the autoboot timeout to 30s,
> so I have plenty of time to hit a key on the keyboard.
>
> and the result is as follows:
>
> - A U-Boot logo greets me at the top-right corner of the screen.
>   I'm really happy to see this logo, shows something is right with the
>   HDMI code&config.
> - The rest is all black, no text.
> - Hitting a key on the USB-connected keyboard seems to have no effect:
>   the screen stays desperately all black except for the U-Boot logo.
> - After the 30s timeout, the system boots as usual.
>
> I tried to disconnect&reconnect the keyboard as well as tried both USB
> ports on the device.  Same difference.  Why do I get to see the U-Boot
> logo but not the usual bootup text?

I suspect you have two problems.

For the lack of text being displayed can you check if you have
CONFIG_SPLASH_SCREEN=y in your .config? That will suppress all the
text. Try a '# CONFIG_SPLASH_SCREEN is not set' line in the config to
see if that helps.

For the USB I have seen issues on and off with rockchips devices.
Adding the following might be a good debug to ensure it runs and scans
the USB bus:

CONFIG_USE_PREBOOT=y
CONFIG_PREBOOT="usb start;"

If you have a USB TTL you should be able to see it all on serial
console no matter what gets displayed on HDMI.

Peter

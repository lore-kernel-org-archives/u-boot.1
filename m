Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C4B6C5DF66
	for <u-boot@archiver.kernel.org>; Mon, 17 Aug 2026 16:02:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 092BC40514;
	Mon, 17 Aug 2026 16:02:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SMFpQPZQqIKa; Mon, 17 Aug 2026 16:02:12 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2AF5040566
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786982532;
	bh=317K2llt2QT57p8HmrWKjtE5O3Sk5CNWcadSIwErRKs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gs+7QBFdTw9h/K3Rx1sYhEEBBC5lZG6Q/dhYzRLgGTwdy/rnPDTCu5uKLX1zEChPb
	 wTaI6tnfQObsAsfj3rY/TnozLvRVt+e2rY1ngJyKzCnouFoo3JawhKGX6ovho0eP8B
	 NSvc4zlC4AW2nDU80e7rvJeNJH4ILWjVC5vpyfrtJLYTkWiM7VJoKpsJcXyg48q+QU
	 DEqPMClyGJDKCgcmkMDrlYRatC9fV1jwOAfUxgtSVbxRthve9wwwMdMm8oLbEN6qbL
	 I3g4jHc6d3j6aRFXdRsfHgcHG976iJkDcS4n3hQ1wrdquiyQBkOcfv5obq4JgvDvjS
	 pXn9NhxdM8GfQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2AF5040566;
	Mon, 17 Aug 2026 16:02:12 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id B6AE6282
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 16:02:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B4AFB6078D
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 16:02:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XBYaxpDr4Qal for <u-boot@lists.u-boot-project.org>;
 Mon, 17 Aug 2026 16:02:10 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::f33; helo=mail-qv1-xf33.google.com;
 envelope-from=pbrobinson@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org B849B60671
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B849B60671
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=Tyc8wFsM
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com
 [IPv6:2607:f8b0:4864:20::f33])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B849B60671
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 16:02:09 +0000 (UTC)
Received: by mail-qv1-xf33.google.com with SMTP id
 6a1803df08f44-8efef6533aaso18850056d6.0
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 09:02:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786982528; cv=none;
 d=google.com; s=arc-20260327;
 b=CxA+RisDYE8V5rdcmtTo3emGirSEpun/8ys4+robq2gcF1jmwBvClIOeXKYFXkYgYy
 XOdFoX1LDuXVuE91Z25Fvst2rln0vHoHTZZD3w4karWv7kzDBXv3RUcAF+wh4ls9o1oL
 J9FM3KN0SmqjK5TfU++SY8ORZgKvOWzPFBZ1RINoLDju/FQYAw8+85ZPR/qURv3ONRGh
 9/xjsvdRctha+EBE7bhNeDGdOm6+8HBQCYobd6W5VjbtO/7Y3VkkPE6MSrEbIzLDJ2Xu
 UJrH1fmFGHr45FQP4JaYxEvjWCqg1zGj24O87uvR/GbM5Z7sfXbSjPl/oZ1ga2KR0Ybo
 awXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=317K2llt2QT57p8HmrWKjtE5O3Sk5CNWcadSIwErRKs=;
 fh=WetTzq2xTDX5h60waVCMlF8+Q239zw5nKngPEmXaato=;
 b=sAEDo6x1A4qzhGsGr2sgQxSTBE+ilCeApTP9Iwr4l9mICZKFGvr2/5BTf3ZLWr5Tfc
 c/xaUVmCXxunmznMhJy3sw9ifXh/yqy6iH2Lxh23LIm3Bfw7o7IpeIfVIO4FwUqfj+Uh
 SyqEyovr31+Y1vNEFdnrm4SLeUJeoLwi3TuYaAgvFLeBXF+c9Kc+ffNgjRrQNcYC6Ens
 4hh/lg3uDwcf6cDpZan3TzaCGwJC9BmyYLHn4Ku+wheMocBEY/xxoIRztaVHAbT2TTGK
 qviFYMW0wH6iSSzg00tVfTM+Oui+JV5LLEORlPa+Qe36Cx5zZOUAKU1wIOaLFIZrUG3B
 rmaA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786982528; x=1787587328;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=317K2llt2QT57p8HmrWKjtE5O3Sk5CNWcadSIwErRKs=;
 b=Tyc8wFsMk6O5onr9355t+RVK/n9jSj0n7W9e+b8eOaUloETb7tN8YW4ox5prBfqvPT
 xu+AwK7KKbGMqYlvaf14jutzEUPY0Vimo5o/byrEdPcz/fOyFBGMuMK/fLi1OuDLbdf8
 wSYAY2e6iz6ONSq5U52vHoJKiLNvIvq5dggd8AGWrGQtwKA4l8ByNFKzjT7I+CiIet1g
 Qnc2xaIcSF1wXLcHazCJ9KCbImlamfQoyyvjRQ3jPqZvlDC9Dd4EaZE0qx1nt62dAgor
 R6/aiFvwqNR5Ke+0V98NXggKoKYYDmON2mQDjl/jFZgM3uzwt3fzjMNl024+icCa+TA3
 w1Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786982528; x=1787587328;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=317K2llt2QT57p8HmrWKjtE5O3Sk5CNWcadSIwErRKs=;
 b=IprZghIWQn20tuLJ4A0lXnMisKLThxVhncrLV0EefLXViErWKG7IZZocsz/FODNLqU
 Au0FlwbMAAHFtrzYQhR4rAqMsrSN50+JPn2PW7Up2ZaUgyv5B1EEuptL5w3VHjHsgfrE
 e9JMbTk2kkIiQYRmkokehuMIa10AU1DQ1my6slIkt+osIgkIx7KXr9kpLViUIbjDHNyK
 x9Zq8zW0q+hgOyLWY/vof8o7BsQz2dbYtgMsQKE5v8YgyUU94MkNWGfFPDHLQethWV+u
 AU6n60Kfiy5sNZbYsOvDC96ip36uSZMMVbV58/bn8l67wvEflmqy//NvVW1xF7327aBL
 oJwg==
X-Gm-Message-State: AOJu0YxthAAwrB6+YVDQa2nmSGwg16SLoumDCLEr+Xj1c8rCoQZLeJ/m
 9abeqM0FfO4OASO6r4bfG5GuN1xTaNNh/PqAOgP+dm3AOFV65FwmIhfg/a2N+NLkecbi8cnrPGK
 uYWa71EPokVme2YZqWg23zGMq3SraSrw=
X-Gm-Gg: AR+sD11eq+CgaXHLqTXDrjcedIQftcAO7WTv7zS2p0IsVHJW93Q/h6XIfEveynA6GWN
 Uc1iC7Kjqm+VO3I4yRmpbw8GX3+zamoeE2/oNiMWr0WQY2c3Kykwx7nn9HJvTNtSKCl0rUI/1tE
 PqUIS1Sr05H5B572RRjEdfEwZF8OTYtzWxzwizH2lwKx7u0YZIapZj2dpuAzv4/Y2HyX2qHzNBp
 EojiujaIU0tAWDaAYeRI+WBxFP9b4unvEXNSpranTX61kw2Vzwok8HylsOuT3miEO30LnjkwJZ8
 00VBqo/PvzoGDe9I0rsN4jiUHBFQoK6yNqcJ5QE+jaEEH0YRv77Q1QryDYg5X/dZbOXuYfd3kLI
 aSRZaXV20cXEAJXUmh2FvSDDS2rBkkPS6JiLD4PDwBouXl+jUNkfA0gm6mMq9eYS84IROSt/Zul
 gpgbBaQbkYR2SfkLYRMvOaRNx1vXhKnRyE+des40MFHiMhSlOb5Q==
X-Received: by 2002:a05:6214:5c08:b0:8f2:5a3e:c619 with SMTP id
 6a1803df08f44-90a91c5c192mr322161816d6.4.1786982495445; Mon, 17 Aug 2026
 09:01:35 -0700 (PDT)
MIME-Version: 1.0
References: <20260817153144.1951036-1-vjardin@free.fr>
In-Reply-To: <20260817153144.1951036-1-vjardin@free.fr>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Mon, 17 Aug 2026 17:01:22 +0100
X-Gm-Features: AcwNN1XDy4Hx_PJg7YeU_5XzRpKaKt31tQla0VNDEWRTblokediThDy_7OK3E9U
Message-ID: <CALeDE9OTtd7Oy7sVKsdukfnwdrV3Sg5d1F34muBQgZdsOaMoKA@mail.gmail.com>
Subject: Re: [PATCH v1 00/23] board: nxp: add the Free Mobile Nodebox v3 CPU
 Module (LX2160A)
To: Vincent Jardin <vjardin@free.fr>
Cc: u-boot@lists.u-boot-project.org, Wasim Khan <wasim.khan@nxp.com>, 
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, 
 Priyanka Jain <priyanka.jain@nxp.com>,
 Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On Mon, 17 Aug 2026 at 16:32, Vincent Jardin <vjardin@free.fr> wrote:
>
>
> This series adds the Free Mobile Nodebox v3 CPU Module, an NXP
> LX2160A based board (16x Cortex-A72, DPAA2). U-Boot is the BL33
> payload of TF-A: BL2 trains the DDR, BL31 hands over, and U-Boot
> boots a FIT image (kernel + MC firmware + DPC/DPL) from a single
> FlexSPI NOR. The module plugs onto several carrier boards (NBV30,
> NBV32, etc.) that share one kernel image but differ in their device
> tree and DPAA2 data path.

Why just FIT and not UEFI?

> The port is modelled on the LX2160ARDB / QDS boards and lives next
> to them under board/nxp/lx2160a/, reusing their SoC level code.
> Board specific behaviour is wired through EVENT_SPY hooks rather
> than weak symbol overrides, and the dependencies each hook needs
> are forced on by hidden default-y Kconfig bools under
> `if TARGET_NBXV3`, so a hook cannot silently turn into a no-op.
>
> The series is in three stages:
>
>  1. Base port and documentation (patches 1-2): TARGET_NBXV3, the
>     defconfig, a minimal device tree, the MAINTAINERS entry, the
>     Ethernet wiring file and doc/board/nxp/nbxv3.rst.
>
>  2. Board code (patches 3-9): DPAA2 Ethernet on DPMAC17 through the
>     RTL8211FD PHY; the +0V8_VDD core rail (MPS MPQ8785 PMBus
>     regulator snapshot, PMBus PSU snapshot, VID fuse driven voltage
>     trim through UCLASS_REGULATOR); the ${carrier} selection that
>     lets one FIT carry a DPC/DPL/DTB set per carrier; the ZL30733 /
>     ZL30643 DPLL traces; the +3V3_FAN rail hook.
>
>  3. Build and device tree settings (patches 10-23): one small
>     commit per peripheral or features, each enabling its DT nodes and
>     defconfig symbols.

The device tree should be sent upstream to the Linux kernel and then I
think most of 10-23 should be compacted to a single patch.

>
>
> Vincent Jardin (23):
>   board: nxp: add Nodebox v3 CPU Module (LX2160A) base port
>   doc: board: nxp: add the Nodebox v3 CPU Module (nbxv3)
>   board: nbxv3: enable RTL8211FD PHY for 1G DPAA2
>   board: nbxv3: add MPQ8785 PMBus traces + DT regulator
>   board: nbxv3: add boot-time PMBus PSU traces
>   board: nbxv3: add VID-fuse driven core voltage
>   board: nbxv3: select carrier at boot
>   board: nbxv3: add DPLL status (ZL30733, ZL30643)
>   board: nbxv3: enable +3V3_FAN rail fixed regulator
>   arm: dts: layerscape: nbxv3: enable UART0..UART3
>   board: nbxv3: enable FlexSPI boot NOR (GD55LB02GF) and FIT boot
>   board: nbxv3: store the environment in the boot NOR
>   board: nbxv3: enable eMMC on eSDHC2
>   board: nbxv3: enable PCIe root complexes (PCIE3..PCIE6)
>   board: nbxv3: enable both USB host controllers
>   board: nbxv3: describe the I2C buses and their on module devices
>   arm: dts: nbxv3: add the +3V3_FAN regulator
>   board: nbxv3: enable JC42 + QorIQ TMU + PMBus thermal
>   board: nbxv3: enable HW crypto (CAAM) and rng command
>   arm: dts: nbxv3: bump SBSA watchdog timeout to 120s
>   board: nbxv3: add operator commands and JTAG semihosting
>   board: nbxv3: enable GPIO controllers with line names and hogs
>   board: nbxv3: add the boot environment (FIT over MC, MC memory, PS1)
>
>  arch/arm/Kconfig                       |  12 +
>  arch/arm/dts/Makefile                  |   1 +
>  arch/arm/dts/fsl-lx2160a-nbxv3.dts     | 531 +++++++++++++++++++++++++
>  board/nxp/lx2160a/Kconfig              |  45 +++
>  board/nxp/lx2160a/MAINTAINERS          |   9 +
>  board/nxp/lx2160a/Makefile             |   1 +
>  board/nxp/lx2160a/nbxv3/Makefile       |  11 +
>  board/nxp/lx2160a/nbxv3/carrier.c      |  87 ++++
>  board/nxp/lx2160a/nbxv3/carrier.h      |  17 +
>  board/nxp/lx2160a/nbxv3/dpll_zl30733.c | 183 +++++++++
>  board/nxp/lx2160a/nbxv3/eth_nbxv3.c    |  77 ++++
>  board/nxp/lx2160a/nbxv3/fan_power.c    |  32 ++
>  board/nxp/lx2160a/nbxv3/mps_pmbus.c    | 107 +++++
>  board/nxp/lx2160a/nbxv3/psu_pmbus.c    |  80 ++++
>  board/nxp/lx2160a/nbxv3/vid_handoff.c  | 146 +++++++
>  configs/nbxv3_tfa_defconfig            | 106 +++++
>  doc/board/nxp/index.rst                |   1 +
>  doc/board/nxp/nbxv3.rst                | 255 ++++++++++++
>  include/configs/nbxv3.h                |  57 +++
>  19 files changed, 1758 insertions(+)
>  create mode 100644 arch/arm/dts/fsl-lx2160a-nbxv3.dts
>  create mode 100644 board/nxp/lx2160a/nbxv3/Makefile
>  create mode 100644 board/nxp/lx2160a/nbxv3/carrier.c
>  create mode 100644 board/nxp/lx2160a/nbxv3/carrier.h
>  create mode 100644 board/nxp/lx2160a/nbxv3/dpll_zl30733.c
>  create mode 100644 board/nxp/lx2160a/nbxv3/eth_nbxv3.c
>  create mode 100644 board/nxp/lx2160a/nbxv3/fan_power.c
>  create mode 100644 board/nxp/lx2160a/nbxv3/mps_pmbus.c
>  create mode 100644 board/nxp/lx2160a/nbxv3/psu_pmbus.c
>  create mode 100644 board/nxp/lx2160a/nbxv3/vid_handoff.c
>  create mode 100644 configs/nbxv3_tfa_defconfig
>  create mode 100644 doc/board/nxp/nbxv3.rst
>  create mode 100644 include/configs/nbxv3.h
>
> ---
> base-commit: 527115ef6783cec49e5610c523c124b399011361
> branch: for-upstream/nbxv3-v1
>
> --
> 2.43.0
>

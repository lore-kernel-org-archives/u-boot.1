Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B504A606A31C
	for <u-boot@archiver.kernel.org>; Fri, 27 Nov 2026 18:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=cnc2dTKK;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=u6s8nrR7
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 653958128D;
	Fri, 27 Nov 2026 18:29:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mFfGfkq1Yzly; Fri, 27 Nov 2026 18:29:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 4848381299
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795804152;
	b=gDSW+xHqjIZaDNFbsVzK82pD/hzJPazeGaXCFeKUn/N9bV1a+0gVmLH8wOSXdxYvK6nV
	 6Tn86UqfsJiR6XHSt1Ta4dgj/YTNXaOhEbwLMX7oCFNfRlv0eP7nlRzRwm9K6dp3J1WTT
	 xjKzXCoKyv8ugxbarxl7w8z/7/NrreKWADC1YKiHOzqijLpqfoopXa+jrl2UDoaFgRmX2
	 G52FHKFKMpElrZi4xBHJhboMzfmdHwXK7++q0HhcmYwbPj2m50Y0wrhja84HrDomXp5KY
	 q2zLn4VSXSLeqVS1rQokOFEldgYH3UacUQMj7u/XBJoYB7u5NXDF4Kg11v1H/aX6kkw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795804152;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=PgFzAJ52LP2owHMaGUqgest0krzzOD2aJZPb3IpYVy0=;
	b=dc0ZOUd7vg3Kbo7GGMDeBhQiQoArMALMm5SDM+3as2qzWJizufja3rDSW6U4YXUiV6VU
	 BMg0fu3pNghNa0IUWPJhlet8ZdHhVe/RQ08X7G4xnef+yFJKx4wuYKglyk6y9X9nxtDMW
	 XQeT0GeAikM8KtAEwfTHkGy04oFhsF1JqeoJe0ciwdtqX1jOIRMXwUwVxbKQcybDBu5x/
	 u3Pfd+UziUTe7CLeCEmiCl7hiof7xKn3nkMyiq18EoLYRgPPyL8Ioffl9wcNbNT3C/DzA
	 A6FB0/Ad3i7V63eG0eepYYyqljYRSFPbjLH0Q8ew56PGHFFSDDFtEInSHJsrp86sJcA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795804152;
	bh=PgFzAJ52LP2owHMaGUqgest0krzzOD2aJZPb3IpYVy0=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=cnc2dTKKftwGCccmYW1QBXuAHVXzX6v7wp2iX1yBWYHC9ZlUr+Kb3HDslSBHkCaB/
	 mHJnlGOAKp9WSm/GOdLKo2XRsFykYU8mT+0H3vSXQZpYyhbbhhP5QZMGinJ6miKzL/
	 khAR0EJdVem2Ta35zCCTUVa/WdLiruQdkuoQkpJ1XjompEuB9ERP3qhC5dWhU3kxd7
	 4C898oejsibvYtzkyrPeSKs4viKVLm80F5zO7rgHITKs/MFS7sTGTZJBld1sOrV2ej
	 fMA+NQ136FhbCaA8A60HwL6WUwUUkSY2RY1IivDWnFKMX6YrXbGBNqSOGIV/w2CJLR
	 XHfsg7Jzth+4Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4848381299;
	Fri, 27 Nov 2026 18:29:12 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 3EEE32BD
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 18:29:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 24DF660A54
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 18:29:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5Dswg3BUD6Zh for <u-boot@lists.u-boot-project.org>;
 Fri, 27 Nov 2026 18:29:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E47BF608CD
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32f; helo=mail-wm1-x32f.google.com;
 envelope-from=mehmet.fide@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=u6s8nrR7
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E47BF608CD
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 18:29:09 +0000 (UTC)
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4bb702a7548so77305095e9.1
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 10:29:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795804148; x=1796408948;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=PgFzAJ52LP2owHMaGUqgest0krzzOD2aJZPb3IpYVy0=;
 b=u6s8nrR7Anerf887LEtslpxmoRtMOm1ISdg+NN7Pkw3tKExNHgUUJnyWAC1t/a0sp6
 kvU/MLsctqsNw6CplcXaO1bXY5lIUG8xmyDcUL9sxyURe4nR0tkgBxqsuS7SESmUSQGa
 cORNvK/IRorpURkWOvAoMvcH5thsKTXBN7hqronVQ4EZnNXMxdwi2YLXHZbjnh/hbeDr
 xCfmR8UHd6kBJBnq8E4EDyEydSjlFBa6EdHk7Ty4UNWE1Q1AYgfaxeOzKeCvkUlE3M2+
 0BzdEhKE2KKEzqnlEUd2Z0PONaZu/GMzfGc6bpyNqRG06BZjRp61e7yiRE6uQlBmCcyj
 hm4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795804148; x=1796408948;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PgFzAJ52LP2owHMaGUqgest0krzzOD2aJZPb3IpYVy0=;
 b=dyYc1YqQynPbiheSREhzxBbv4ZrsTi5+3IhXLrLSXF5Q1+S/5GX6xmxBBiWh1XQHfl
 q7qDPGvpyFJZc5yRb1JX0+AkGhp+QfvqjbJcZZBL0mbm1sPon+b0a7cq0oN4GYoqQSYk
 /4kEYnaWFYE0Iv4X9iPSSGPjbf7TVQzkC6ANa/7cwEUlDcFGTUTLn49S0MqypCQxU/Wc
 mdww6Mbg5iMo80yhcxqNhAgv/SxbSv/wXRstHCla3QYEGlGhWX+EhK8tx5CmF/bQ2CBI
 Fw9tW9RF+wlmFA3q/Tv/drmB3gNCJ+g+NIA4RhLVS6VAQRkiKXBD9HvN9/pBKYqG1KoX
 KV3A==
X-Forwarded-Encrypted: i=1;
 AL+hErHyPNREYIEXtOwOs9NR1TSffpwsxRDV/+VBJnf6w6oKnl2B9OhxYQMSrLReL13JfmHMSgGCdec=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z81VWyNCqomdwAFbVtxx7OWLaQLrhFDJsqe86uuiWho0/MJr7Fr
 x2SpvQcgoE58+I19KkAeFIxfeyjXh93eFQKS1LX1BLo629E/EZrABrp5XZnuhW0K
X-Gm-Gg: AZFdTZdgE3m8Ik8mLp4gdR/fVcbCxBZ2ehr4TYIxbVzR32+tu3X7afGzgcfJnG+Hjlo
 AyjS1JjnSjnJs0WXGBdSNEX5nNHm7MaBX2mQe9fYexN68DhTS25MpQFLENEyFuApzpUytffoE1x
 sWCEiwSEkk56Hbfi2KOy3kbOwBPWY8TV5X9Btz6bEUiX05lK2dSdoifaJp7y9W6yKQsd8Zc37Ef
 rAEad0xOjRqKZSWuyOZjaqCZNDc4A4M2K8+6i0Mmh4FjSQioOPpL8hLlk29L+zAP4tcL7w4AqeK
 bOIiEzlHHkkmpZFHLmSelQ9e4f8kJ9hfTNceaRy/wVpftevjx4COl8hcA6kPoDj2M5Gq1Ocl00e
 CY0zz5nOLy92piZvqqImYwe2WSB9f+LVjlE9F0utIofKGvG9AUJ+HKkZ+IQYHzxnCgRtWWVh3C9
 nH1axip9ukcTkUgHK09O48uM6ElwNeGErLRRZAqpyDnHhKVyKEEwfrgY6aeMpENweVbbKmJB+xF
 SXHPBm72oHQtyj2kLxJvGqyBLXzEzCLE6hLAiEEMrhhSYqx/LqDwQMKMPqdgI6zWgcwHEUzAX1i
 wvgHz7JNRVNTlvGVcqFEp7s/wt7KuXe2NoZ1kTcx4K/5POsYx4jlOwkn
X-Received: by 2002:a05:600d:82d3:b0:49f:e701:51c8 with SMTP id
 5b1f17b1804b1-4bb8880f0ebmr559388505e9.9.1795804147449; 
 Fri, 27 Nov 2026 10:29:07 -0800 (PST)
Received: from deb05.proceq.com ([213.160.61.66])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab658e2d1bsm50584856f8f.8.2026.11.27.10.29.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 10:29:06 -0800 (PST)
From: Mehmet Fide <mehmet.fide@gmail.com>
To: Marek Vasut <marek.vasut+usb@mailbox.org>,
 Fabio Estevam <festevam@gmail.com>
Cc: Lukasz Majewski <lukma@nabladev.com>, Peng Fan <peng.fan@nxp.com>,
 Stefano Babic <sbabic@nabladev.com>,
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>,
 Tom Rini <trini@konsulko.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Stefan Eichenberger <stefan.eichenberger@toradex.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.u-boot-project.org, mehmet.fide@screeningeagle.com
Subject: [PATCH 0/8] vf610: add a clock driver,
 ehci-vf takes its clocks from it
Date: Fri, 27 Nov 2026 19:28:57 +0100
Message-ID: <20261127182905.2836449-1-mehmet.fide@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Mehmet Fide <mehmet.fide@screeningeagle.com>

The follow-up to the ehci-vf series [1] that Marek and I agreed on in
its review: the Vybrid gets a clock driver, and ehci-vf takes its
clocks from it instead of setting the PLL bits of its port by hand, so
the port number it kept for that goes as well, with the
board_ehci_hcd_init() call no Vybrid board implements.

The driver is a port of the Linux one to the common clock framework,
like those of the i.MX6, with the clock tree up to the devices U-Boot
drives.

- patch 1 adds the two PLL types of the VF610 to the PLLv3 driver
- patch 2 adds the clock driver
- patch 3 makes the LPUART driver read the rate of the clock the VF610
  device tree names, "ipg"; without it the baud rate is not set once
  CONFIG_CLK is on
- patch 4 turns the driver on for colibri_vf
- patches 5 and 6 move ehci-vf to the clock of its PHY and drop the
  port number and board_ehci_hcd_init()
- patches 7 and 8 have ehci-vf enable the controller clock as well and
  drop the USB clock setup from the board code

The series applies on next, which has the DCD change of colibri_vf
(2fe1b27ba5e). colibri_vf grows from 478656 to 495672 bytes; with the
DCD it has no size limit any more.

Tested on a Colibri VF50 V1.2B and a Colibri VF61 V1.2B on Iris
carriers, booted from NAND and from the serial downloader of the ROM:
console, SD card, NAND and UBI, the USB host port, the DFU and mass
storage gadgets, the FEC with DHCP and TFTP, the environment in NAND,
and Linux 6.18 booting from NAND, with 10 power cycles and 10 resets on
each module. Files read from the SD card, a UBI volume, UBIFS and over
TFTP have the CRC32 of the same files read in Linux or on the server,
and a file on a USB stick reads back with the same CRC32 on both
modules and after a USB reset.

The clocks stay as they were: the CPU, bus and IPG rates, the 162
registers of the DDR controller and the clock tree Linux reports
(rates and enable state of its 190 clocks) are the same as without the
series on both modules. In U-Boot only these CCM and ANADIG fields
differ: PLL4 and PLL6, both off, leave bypass as in Linux, the FEC
timestamp clock follows the assigned clocks of the device tree, and
until USB starts, PLL3 stays on as the ROM left it (patch 8) and the
USB controller clocks are still gated.

With I2C and DSPI built in for the test, the M41T0 on the Iris answers
and a DSPI loopback returns its data at 8, 16 and 32 bits, with and
without the series.

Outside the Vybrid only patch 1 reaches other boards: it adds the VF610
PLL types to the PLLv3 driver, about 210 bytes on the i.MX6 and i.MX RT
boards (buildman -B), without changing the existing types. buildman
builds the 58 boards with the LPUART or the PLLv3 driver at every patch
without new warnings, and "ut dm" on sandbox gives the same result as
without the series. I have no i.MX6 hardware to boot it on.

[1] https://lore.kernel.org/u-boot/20261023111559.4081795-1-mehmet.fide@gmail.com/

Mehmet Fide (8):
  clk: imx: pllv3: add the PLL types of the VF610
  clk: imx: add a clock driver for the VF610
  serial: lpuart: take the ipg clock on the VF610
  colibri_vf: use the VF610 clock driver
  usb: ehci-vf: enable the PHY clock through the clock driver
  usb: ehci-vf: drop the port number
  usb: ehci-vf: enable the controller clock
  colibri_vf: leave the USB clocks to the drivers

 .../arm/dts/vf610-colibri-eval-v3-u-boot.dtsi |  13 +
 board/toradex/colibri_vf/colibri_vf.c         |  14 -
 configs/colibri_vf_defconfig                  |   2 +
 drivers/clk/imx/Kconfig                       |   9 +
 drivers/clk/imx/Makefile                      |   1 +
 drivers/clk/imx/clk-pllv3.c                   |  37 ++
 drivers/clk/imx/clk-vf610.c                   | 465 ++++++++++++++++++
 drivers/serial/serial_lpuart.c                |   2 +-
 drivers/usb/host/Kconfig                      |   2 +-
 drivers/usb/host/ehci-vf.c                    |  77 +--
 10 files changed, 543 insertions(+), 79 deletions(-)
 create mode 100644 drivers/clk/imx/clk-vf610.c


base-commit: 8e939402ab242b02e50cea8b98c51cb4c51546fc
-- 
2.56.0


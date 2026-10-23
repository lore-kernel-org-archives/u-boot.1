Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB00D606A31B
	for <u-boot@archiver.kernel.org>; Fri, 23 Oct 2026 13:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=tTn/GeEZ;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=HmzRFLWt
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 88071606C0;
	Fri, 23 Oct 2026 13:56:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rpFj_3Nr1v0Q; Fri, 23 Oct 2026 13:56:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 6812460657
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792763789;
	b=a5EFoAt2jajABViU5K70j6k/Ma1ysv7vhYAAKbUFZne5oBzRoNiivzFubtWah0POnlMk
	 SwCtbcJnNhWQIM+/9+YT3cv28yBPnrPB7gvsJrm2k6+CCRqyL5BSKChxTByNuUevNxYbk
	 0l3PoAi0liVNFgekEH+t4pr33ly78iFCKP0SX84c7Nikn702Zqq5UVtkWL9UUSmq2kKnI
	 cDkuhRuelo7lPscE0StDjetT4wm5860JlOLiWC5rpAZM0+IrpQyExSnI4Ebf/7iEiGbCt
	 NXHNdD8HGHkztFq5/i5Ddm7Ma8IYJcf+5AiyzomYTSIShfYWZV73KxmjWvnphJL3Hcg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792763789;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=34VclgLNHTuaIYLEIU0Zthz4t66yNzrp5nmQuRVWYbo=;
	b=M9IyfaUfZ3r5Or0JGEZQYUbUBBc3F4K9GE5yNt56V3GTyPwDHxtbzu6dGLp/LMy3H6iR
	 Wo4jaeK5+q8IW5QOvlzmFHwsxwsbsE4SzR6zWo2gFi2WslIq0JzmpAbpfS4VYZfI8FGOC
	 T3P4YLS8htOYhShdZCcJyxtLqCKKmog5T0xQYB+jyJfPzrAqLBmBs/rgrFSWOqZes3zyr
	 q3MfWU4vYSZvvhK3BPTL3WjpEtpwPFPSCJ4TSoS9ovLi52l4T0cPwPv7rCT+F0RgUOV6H
	 8nun+79bT+IPshGVMDWg1Dlbre5kAYytCyO6+cid43vrcld3HaLSlPdPmyPgFnl7Otg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792763789;
	bh=34VclgLNHTuaIYLEIU0Zthz4t66yNzrp5nmQuRVWYbo=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=tTn/GeEZWcNfNGRFYuyM1wBOB/vgj0zk0B2ITY++Z/CNMQ9Tq9pzY9NI7YifdrUhu
	 j2J05ammRY8/9Mtt3vx/86Ac6xPhftniVyPi1nlmGRX6PSIpWrSBKnUHy10Pk+Q89B
	 Oas39rkBjfxe7wFpJFMUQzplvDqS6tuSnKcaNa+l23SuzJT+Qe8K5tvdw7p2JfTtrt
	 Qi7gkiwPry0WiWKTgE07MfFSEJH4w12p5iXOe0kFZsDSZ164AxWKGig+s8AUTfz9ao
	 6tCUHJNvS6uC77XMq9nckKYPoyGjEF1Yc6QNbqjY/K+wxNm+Qic7yrxsNaOyoAt7RN
	 Pb4RmSBidJKRg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6812460657;
	Fri, 23 Oct 2026 13:56:29 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id BF7543C1
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 13:56:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A4988400D0
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 13:56:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xYYEwVsC0OWP for <u-boot@lists.u-boot-project.org>;
 Fri, 23 Oct 2026 13:56:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 075A140071
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:36::8"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792763786;
 b=qjy/jQICDfd1uZYg+cmV8o+Jl5p+/phAu2pTsXucUE1K4A41P+++ZkiQmh/64fHG2qmB
 Yku8CN+2eWuD4GVt5JlwseVYAUWjiP6HqO5BHwZaoPv/131JiUbRzXCFoFsMM7LCngfRk
 RA2U+fVfTL5VUjtLo+ZqZZd/otecy2QPdcL+QjrGa4mvz2EVnvchtkCKc7BtNIzv7sory
 Is7g9n8s1kZ0fFavUP8B7PISeRwZK1/sAjzUX9p1HS7wJbVwEM/SrilgnmNOJ7GunJJk3
 0q1QqiprbFqytU7oYax4+e1YsmvUAQ/C9O1ufUuSLaS/Yg/N2wVwQWH5mbA9rO4nZ0g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792763786;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
 Content-Transfer-Encoding;
 bh=34VclgLNHTuaIYLEIU0Zthz4t66yNzrp5nmQuRVWYbo=;
 b=EKgUCuijURM5MI+/tRzve/doSrZKcVaRi51potwMWQtWPj6LSVQqzifkNzung6ySdPHx
 r18WuxgvHFl1ZNrGYqKAZSWXEX/H8q7WAinftZLy6YFuSoQ5G5Ty8E0s+PuB6TeDJutvj
 MbuXoJUnJhwmWY7LiRzKu+4eOd49jhvFxHZ/y5aZHBNeq8ukSAGUn6z/cYcyPpNEyicD2
 iBk8aPjQTRt6Fh5mu6Z7QEGZWGmYdL8btyrvV7ft/k4ww10UWE0RvLI+tHmnRDzcUgEIe
 wWqBh3LyTHdi9gfudZL42CNuZZS1O8UOPu1Kwy/m8ds3p7qjCSmxbfZCgwTCQK/VJlg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=HmzRFLWt; 
 arc=none smtp.remote-ip="2607:f8b0:4864:36::8"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:36::8;
 helo=mail-dy2-x08.google.com; envelope-from=coiaprant@gmail.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=HmzRFLWt
Received: from mail-dy2-x08.google.com (mail-dy2-x08.google.com
 [IPv6:2607:f8b0:4864:36::8])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 075A140071
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 13:56:25 +0000 (UTC)
Received: by mail-dy2-x08.google.com with SMTP id
 5a478bee46e88-34cbc588a31so518080eec.1
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 06:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792763785; x=1793368585;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=34VclgLNHTuaIYLEIU0Zthz4t66yNzrp5nmQuRVWYbo=;
 b=HmzRFLWtxTmF/S6WrX/Obu+1J/ekS2g33JMMI+5ewYYLY8+elv4Fb8K+7XZB0hXoWM
 oR0Bl9JTxyMUxtbCBllc2epib5zPXsF6P1fRRxDJzIz+iJvD0rxzRMQUc686AsK63ppc
 H8X9+ADfSqAAuVYcwFnsj40vHWq3LeCanAquPvd3Q7f0ascdPNtSORYb1fiM2F05o+aQ
 jHsbNLBeCsLn7eLEPwRxuyt3L6YYf06yhNl+KPn24NPzwIjPja33uRMFy5kuE44OepwO
 7KJAO7HLw/P/ORpns6foWABQloF21FVNeBjjNEpGxZ5njkftBbOujEFsZxxzyxZOvBr4
 UUkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792763785; x=1793368585;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=34VclgLNHTuaIYLEIU0Zthz4t66yNzrp5nmQuRVWYbo=;
 b=fd2USIMCEmbLYVA0ytoAro13SD3R5u83ENHQXtugdcoJ2B0AHgnQYu40J94LPVm8J5
 g6MLnhGovZErlT1wDvj2U7qYUGXVqTVZ25EYheUlhHB7x2CmivAB4iC0WmaFSS+8RN8C
 aldEW8TpzgPBrrmwGc0IAs9fRPksWXT2RFE5F8nB0Inc06Jq8H/8E4AvgWga61giO/DQ
 PsHZ7VHzqNmQ1EtN3Jyymzda/ogzCt4J9BggWmaLlg12uvWfxJCTLoRSuqlsYrU9u+FA
 qIHJtAZwaErMIu4NkCIE9F5uoGmQSUnLiIfeS4MPFGXO4tLkTPXtAFX6xp3YALPdEwpb
 VC9Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBy7uhDY2h2SglSx55haZjSLnT54QSOfSyZWM5+PESJtMhSjh3hd6Hotwm9V61xLP+hl4M3kBEo=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYI6cwVFRXlty6ZW1QRQwKKIgFySM9RSq/zAjsxF3GItXPFpULTE
 npCogAtbFoDJ+57UYi4DRvD7zrXi3ofToYhnafGsDmU+n/8N/Y9c93/F
X-Gm-Gg: AYBFou0VwF3rhs2UgqFTx+vK6Znavnmsg9oVlu9C9j5EeXJP00Rkgqyfxo37+DamVsk
 XFKVRu+hS8UybCqHsjIu0nH/JswjZixnZegV3gMW4/sjJgJOqeX1cgShzWpVaVjSvSnX5/JwGg3
 fFJUC7yqivMTCEsookNaP2dqTJh6Immgxim+t4Sifb54nT7f6rOfJ7NQPxKgOJ7nAd8ZlnQRrl2
 Pw54vCBAX1r/iUNHITxRtdlen15FUhQQHhZU/dznkrtcxOCFNi8uTWFtBAwPFcM65iRq/2xmuMr
 Z04OtqJDosJDDRPZHhY9y3QeIsGApeB3ZhedPfaT4uUmmOAmmWLsq00/P11J7NtDJAh/b6kOyK8
 Xu0jJX83YuOELAeC/Pen8dPW+3MWnyAvdCrtJ3HDKkFMoDtcAYYwRGL/fyfXzNwKH6kOWzBjONN
 tvvJuJ+akuxma7Seerhn+TPpdJ8JSJIDhC9Ff4vN/LLRhRYfX2QW73XcrVq8rqdvghfa6oRoMNc
 6fmDW2SbXGI8VsjuoKvNqwv25sbge/i3xy4NxF9C7+6/vqDrB8Gxw==
X-Received: by 2002:a05:7301:4395:b0:368:6f29:f26c with SMTP id
 5a478bee46e88-369d916e13emr2998685eec.4.1792763783270; 
 Fri, 23 Oct 2026 06:56:23 -0700 (PDT)
Received: from server.lan ([168.138.199.194]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-369d9d5e9e2sm6691593eec.4.2026.10.23.06.56.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 06:56:22 -0700 (PDT)
From: Coia Prant <coiaprant@gmail.com>
To: Kever Yang <kever.yang@rock-chips.com>, Quentin Schulz <u-boot@0leil.net>,
 Joseph Chen <chenjh@rock-chips.com>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Liangbin Lian <jjm2473@gmail.com>, Johan Jonker <jbx6244@gmail.com>,
 u-boot@lists.u-boot-project.org, Coia Prant <coiaprant@gmail.com>
Subject: [PATCH] board: rockchip: Add support for Graperain G3568 v2
Date: Fri, 23 Oct 2026 21:56:14 +0800
Message-ID: <20261023135614.2376931-1-coiaprant@gmail.com>
X-Mailer: git-send-email 2.47.3
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The Graperain G3568 v2 is an RK3568-based development board, just like the RK3568-EVB.
It always uses soldered connections between the GR3568CV2 core board and the
RK3568BV2/GR3568BV2 I/O board.

The G3568 board has multiple hardware revisions, and we currently support v2 (I/O board).

Specification:
- SoC: RockChip RK3568 ARM64 (4 cores)
- eMMC: 16-128 GB
- RAM: 2-16 GB
- Power: DC 12V 2A
- Ethernet: 2x RTL8211F RGMII (10/100/1000 Mbps)
- Wireless radio: 802.11b/g/n/ac dual-band
- LED:
  Power: AlwaysOn
  User: GPIO
- Button:
  ESC: SARADC/0 <1100k µV>
  MENU: SARADC/0 <1400k µV>
  VOL-: SARADC/0 <430k µV>
  VOL+: SARADC/0 <50k µV>
  Power/Reset: PMIC RK809
- CAN
  CAN/1: 4-pin (PH 2.0)
- PWM
  PWM/4: Backlight
  PWM/5: Backlight
  PWM/7: IR Receiver
- UART:
  UART/2: Debug TTL - 1500000 8N1 (1.25mm)
  UART/3: TTL (PH 2.0)
  UART/4: TTL (PH 2.0)
  UART/8: AP6356S Bluetooth
  UART/9: TTL (PH 2.0)
- I2C:
  I2C/0: PMIC RK809
  I2C/1: Touchscreen
  I2C/4: Camera
  I2C/5: RTC@51 PCF8563
- I2S:
  I2S/0: HDMI Sound
  I2S/1: RK809 Audio Codec
  I2S/3: AP6356S Bluetooth Sound
- SDMMC:
  SDMMC/0: microSD (TF) slot
  SDMMC/2: AP6356S SDIO WiFi card
- Camera: 1x CSI
- Video: HDMI / DSI0 (MIPI/LVDS) / DSI1 (MIPI/EDP)
- Audio: HDMI / MIC / Speaker / SPDIF / 3.5mm Headphones / AP6356S Bluetooth
- USB:
  USB 2.0 HOST x2
  USB 2.0 OTG x1 (shared with USB 3.0 OTG/HOST)
  USB 3.0 HOST x1
  USB 3.0 OTG/HOST x1
- SATA: 1x SATA 3.0 with Power/4-pin
- PCIe: 1x PCIe 3.0 x2 (x4 connector)

Link:
- https://image.chukouplus.com/upload/C_153/product_file/20211022/6daddec9e400458816dd4c57ba807fc3.pdf
- https://blog.gov.cooking/archives/research-graperain-g3568-v2-and-flash.html

Signed-off-by: Coia Prant <coiaprant@gmail.com>
---
 board/rockchip/evb_rk3568/MAINTAINERS       |  5 ++
 configs/graperain-g3568-v2-rk3568_defconfig | 76 +++++++++++++++++++++
 doc/board/rockchip/rockchip.rst             |  1 +
 3 files changed, 82 insertions(+)
 create mode 100644 configs/graperain-g3568-v2-rk3568_defconfig

diff --git a/board/rockchip/evb_rk3568/MAINTAINERS b/board/rockchip/evb_rk3568/MAINTAINERS
index 3e2d864901f..3a655a817f4 100644
--- a/board/rockchip/evb_rk3568/MAINTAINERS
+++ b/board/rockchip/evb_rk3568/MAINTAINERS
@@ -35,6 +35,11 @@ S:	Maintained
 F:	configs/generic-rk3568_defconfig
 F:	arch/arm/dts/rk3568-generic*
 
+GRAPERAIN-G3568-V2
+M:	Coia Prant <coiaprant@gmail.com>
+S:	Maintained
+F:	configs/graperain-g3568-v2-rk3568_defconfig
+
 LUBANCAT-2
 M:	Andy Yan <andyshrk@163.com>
 S:	Maintained
diff --git a/configs/graperain-g3568-v2-rk3568_defconfig b/configs/graperain-g3568-v2-rk3568_defconfig
new file mode 100644
index 00000000000..b3d6872616f
--- /dev/null
+++ b/configs/graperain-g3568-v2-rk3568_defconfig
@@ -0,0 +1,76 @@
+CONFIG_ARM=y
+CONFIG_SKIP_LOWLEVEL_INIT=y
+CONFIG_COUNTER_FREQUENCY=24000000
+CONFIG_ARCH_ROCKCHIP=y
+CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3568-graperain-g3568-v2"
+CONFIG_ROCKCHIP_RK3568=y
+CONFIG_SPL_SERIAL=y
+CONFIG_SYS_LOAD_ADDR=0xc00800
+CONFIG_DEBUG_UART_BASE=0xFE660000
+CONFIG_DEBUG_UART_CLOCK=24000000
+CONFIG_PCI=y
+CONFIG_DEBUG_UART=y
+CONFIG_FIT=y
+CONFIG_FIT_VERBOSE=y
+CONFIG_SPL_FIT_SIGNATURE=y
+CONFIG_SPL_LOAD_FIT=y
+CONFIG_LEGACY_IMAGE_FORMAT=y
+CONFIG_DEFAULT_FDT_FILE="rockchip/rk3568-graperain-g3568-v2.dtb"
+# CONFIG_DISPLAY_CPUINFO is not set
+CONFIG_DISPLAY_BOARDINFO_LATE=y
+CONFIG_SPL_MAX_SIZE=0x40000
+# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
+CONFIG_SPL_ATF=y
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_GPT=y
+CONFIG_CMD_I2C=y
+CONFIG_CMD_MMC=y
+CONFIG_CMD_PCI=y
+CONFIG_CMD_USB=y
+CONFIG_CMD_PMIC=y
+CONFIG_CMD_REGULATOR=y
+# CONFIG_SPL_DOS_PARTITION is not set
+CONFIG_SPL_OF_CONTROL=y
+CONFIG_OF_LIVE=y
+CONFIG_OF_SPL_REMOVE_PROPS="interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
+CONFIG_SPL_DM_SEQ_ALIAS=y
+CONFIG_SPL_SYSCON=y
+CONFIG_AHCI=y
+CONFIG_DWC_AHCI=y
+CONFIG_SPL_CLK=y
+CONFIG_ROCKCHIP_GPIO=y
+CONFIG_SYS_I2C_ROCKCHIP=y
+CONFIG_MISC=y
+CONFIG_SUPPORT_EMMC_RPMB=y
+CONFIG_MMC_DW=y
+CONFIG_MMC_DW_ROCKCHIP=y
+CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_SDMA=y
+CONFIG_MMC_SDHCI_ROCKCHIP=y
+CONFIG_DWC_ETH_QOS=y
+CONFIG_DWC_ETH_QOS_ROCKCHIP=y
+CONFIG_PHY_REALTEK=y
+CONFIG_NVME_PCI=y
+CONFIG_PCIE_DW_ROCKCHIP=y
+CONFIG_PHY_ROCKCHIP_INNO_USB2=y
+CONFIG_PHY_ROCKCHIP_NANENG_COMBOPHY=y
+CONFIG_SPL_PINCTRL=y
+CONFIG_DM_PMIC=y
+CONFIG_PMIC_RK8XX=y
+CONFIG_REGULATOR_RK8XX=y
+CONFIG_PWM_ROCKCHIP=y
+CONFIG_SPL_RAM=y
+CONFIG_SCSI=y
+CONFIG_BAUDRATE=1500000
+CONFIG_DEBUG_UART_SHIFT=2
+CONFIG_SYS_NS16550_MEM32=y
+CONFIG_SYSRESET=y
+CONFIG_USB=y
+CONFIG_USB_XHCI_HCD=y
+CONFIG_USB_EHCI_HCD=y
+CONFIG_USB_EHCI_GENERIC=y
+CONFIG_USB_OHCI_HCD=y
+CONFIG_USB_OHCI_GENERIC=y
+CONFIG_USB_DWC3=y
+CONFIG_USB_DWC3_GENERIC=y
+CONFIG_ERRNO_STR=y
diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
index 1f4e58c8be2..096e089ff3c 100644
--- a/doc/board/rockchip/rockchip.rst
+++ b/doc/board/rockchip/rockchip.rst
@@ -135,6 +135,7 @@ List of mainline supported Rockchip boards:
      - FriendlyElec NanoPi R5C (nanopi-r5c-rk3568)
      - FriendlyElec NanoPi R5S (nanopi-r5s-rk3568)
      - Generic RK3566/RK3568 (generic-rk3568)
+     - Graperain G3568 v2 (graperain-g3568-v2-rk3568)
      - Hardkernel ODROID-M1 (odroid-m1-rk3568)
      - LinkEase EasePi R1 (easepi-r1-rk3568)
      - Lunzn FastRhino R66S (fastrhino-r66s-rk3568)
-- 
2.47.3


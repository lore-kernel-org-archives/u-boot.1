Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0936BC02183
	for <u-boot@archiver.kernel.org>; Fri, 17 Jan 2025 14:13:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D211F8070C;
	Fri, 17 Jan 2025 15:11:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lKnLZJ6x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9803C80737; Fri, 17 Jan 2025 11:46:00 +0100 (CET)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com
 [IPv6:2607:f8b0:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4713580312
 for <u-boot@lists.denx.de>; Fri, 17 Jan 2025 11:45:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=zhang971090220@gmail.com
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2166651f752so44889285ad.3
 for <u-boot@lists.denx.de>; Fri, 17 Jan 2025 02:45:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737110757; x=1737715557; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=rNmEB38QoTW2uludIBNRLYyuSbzwU3R892uesL0W9Zk=;
 b=lKnLZJ6x6W/TAZcH/rggIGR0okNoTfFoxbGiqRHNHm3INpwlwN6dGiDp28mXuUnFP+
 YHH4QNQOBpK8a6h9hLb+up/MlclGDVBM4XfFaGudbYCINLouE8P//ubjR5HnN5aqI0+M
 UvdlJkt/nMTEe24Z3cAU2f23PtX0fH3zVtjW7sJbOTSRbMCrmpPQ375tHUi9RVZ0v6bb
 qHFmkXWfcryyhi3J3rgv8LSdQCu4iDoarevqTV3IpifPacCPxEoz4eX8UEWkfzWRO1vd
 3lbTQ9Rjqx85L7Bkx8UgKBXZohEo8F+GKgMWxF2LIRbzcF9bHZqOzJ/Yj9ZEq0VRSqcK
 gQXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737110757; x=1737715557;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rNmEB38QoTW2uludIBNRLYyuSbzwU3R892uesL0W9Zk=;
 b=E6zTAlCb+O6HKHz1mwr2ZE14HPvxq195WvKLxUqpZsCjZ4Q9trqoDHbhvR9srM0/Nc
 JD/yMra0zX5MEe+fKpDaIrhEpHmezkkkI0o9XVisrz3no+vSB/Mr789uJT9i6/dHmQDv
 o3zgeOvLZkh8/MkJV9g/dV3SvX9fb0hLK8udOJy1cX+vVlGklj9Ez7gfV/KjiXqwy1qa
 iAT++xGVgnPwlTn3w/T7S0qCZu9x4Ok0K+w1qvEDteBfIITpAoK5U9DP21zsX91mlr2N
 2uZc1ryyfg0PHDlg2Kyba4ppRwcaRfVMRJssNxQO0nUHfftUWNrXGuyNnQsWTZzbJ1K7
 f40Q==
X-Gm-Message-State: AOJu0Yzzv/dIFXarcFlJawLmcxOmvDTY6RbVVONJmYatjAyMM/73lnzT
 HWjvggF31IvjWbLSziPvkAEwqENN14KYpAH+eufOHX76dgNz1qVjLsmcirW3
X-Gm-Gg: ASbGncvnuBqw0EtTy+DDoPtZMGN1Fuunb0ho9FKoppaSFxFWBdliPB/FQXi9tW9vGH2
 Zs6FzLsDL3ONqp21+VZ31PIazX3ikCmtWg8c86/WPJOUAwh739R7avsAOfoKQql5D4JGsSE/NPH
 /Jrpdt6G+kGSxdZZvlDATC4ewqd0W3aGSv9QgGy0oLt51I/+7WkhUNIqdOuBvOs1W3P8WrWYHxF
 +BjnshXrFpG+S+NDchFb0TS20+Y1RyDrLvdQLtN/Im2Npq9qCj7b86F55jw6zJ3Dq5sxfMCgKWf
 WYjuHO8+IyvHzZw4DtqgMVsyThvj
X-Google-Smtp-Source: AGHT+IGAohCNQswEA0hZNO7UwQ34l9RchOM4ktvR2ii3ETI0bJkcTyz+keCaP5mmMnAsOj+9yaPotQ==
X-Received: by 2002:a17:902:ec84:b0:215:3661:747e with SMTP id
 d9443c01a7336-21c353ef81cmr29130115ad.8.1737110756573; 
 Fri, 17 Jan 2025 02:45:56 -0800 (PST)
Received: from hcdev-d520mt2.. (60-250-196-139.hinet-ip.hinet.net.
 [60.250.196.139]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21c2d4028d6sm12972885ad.226.2025.01.17.02.45.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2025 02:45:56 -0800 (PST)
From: Michael Chang <zhang971090220@gmail.com>
To: trini@konsulko.com, joe.hershberger@ni.com, rfried.dev@gmail.com,
 zhang971090220@gmail.com, yschu@nuvoton.com, JJLIU0@nuvoton.com
Cc: u-boot@lists.denx.de
Subject: [PATCH v4 0/3] Add bitbang feature for npcm8xx and driver
Date: Fri, 17 Jan 2025 18:45:37 +0800
Message-Id: <20250117104540.1580343-1-zhang971090220@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 17 Jan 2025 15:10:59 +0100
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

I am resubmitting the patch titled "Add bitbang feature for npcm8xx
and driver" for review and inclusion in the upstream project.


Driver didn't support bitbang feature.
Add bb_miiphy_bus function for driver and open feature for npcm8xx

the log is as below:
-------------------------------------------------
U-Boot 2024.10-g30b9cdaf2df5-dirty (Jan 09 2025 - 00:57:37 +0000)

CPU-0: NPCM845 A1 @ Model: Nuvoton npcm845 Development Board (Device Tree)
DRAM:  1 GiB
RNG: NPCM RNG module bind OK
OTP: NPCM OTP module bind OK
AES: NPCM AES module bind OK
SHA: NPCM SHA module bind OK
I/TC: Reserved shared memory is enabled
I/TC: Dynamic shared memory is enabled
I/TC: Normal World virtualization support is disabled
I/TC: Asynchronous notifications are disabled
Core:  649 devices, 28 uclasses, devicetree: separate
WDT:   Not starting watchdog@901c
MMC:   sdhci@f0842000: 0
Loading Environment from SPIFlash... SF:
Detected w25q512jvq with page size 256 Bytes, erase size 64 KiB,
total 64 MiB
OK
In:    serial@0
Out:   serial@0
Err:   serial@0
Net:   eth0: eth@f0802000, eth1: eth@f0804000, eth3: eth@f0808000
Hit any key to stop autoboot:  0
U-Boot>
U-Boot>
U-Boot>setenv ipaddr 192.168.16.3
U-Boot>ping 192.168.16.12
eth@f0802000 Waiting for PHY auto negotiation to complete
......... TIMEOUT !
Could not initialize PHY eth@f0802000
eth@f0804000 Waiting for PHY auto negotiation to complete
......... TIMEOUT !
Could not initialize PHY eth@f0804000
Speed: 100, full duplex
Using eth@f0808000 device
host 192.168.16.12 is alive
-------------------------------------------------

Changes for v4:
    - Replece bitbang function prefix npcm to dw.

Changes for v3:
    - Support multiple buses for multiple Ethernet interfaces.

Changes for v2:
    - add bitbang delay dts read
    - modify printf to debug

Michael Chang (3):
  ARM: dts: nuvoton: Add bitbang delay through dts properties.
  ARM: configs: nuvoton: add bitbang feature for npcm8xx.
  net: designware: Add bitbang feature for designware driver.

 arch/arm/dts/nuvoton-npcm845-evb.dts |   1 +
 configs/arbel_evb_defconfig          |   4 +
 drivers/net/designware.c             | 113 +++++++++++++++++++++++++++
 drivers/net/designware.h             |   6 +-
 4 files changed, 123 insertions(+), 1 deletion(-)

-- 
2.34.1


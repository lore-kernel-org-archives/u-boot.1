Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A073C606A31B
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 13:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=gIbmsC8e;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Tmzc3Lnn
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 578D5606FD;
	Wed,  4 Nov 2026 13:31:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yfdbQpBO5cLz; Wed,  4 Nov 2026 13:31:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 8789760690
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793799076;
	b=rR5+z46n1/boF8suEmOs8TgHhp5/Np3skGoWnuEHQe+1J8u8eQc05/Cgi2z1wBx+Uvwt
	 1p8at+veUaSNm8OCAO0LIvi6/C6I9W5ZzUxzgcM6jkJCKQFU9QJJ58Pb7t9Ho2oKOz8N7
	 ylhBBeJ7zhy+x5rUX2Iw28jPZ1S+dqxBZFjSPeybbWaVjKBwQphPBhSX3r2F4Poy+mAwQ
	 VxOPjRVECYYGfonzZ8OhoxtcgPW1LpPYTc45f4grekojJJhPORizX4xRy00copV6YqQcU
	 9b2iVunYpuJyI+fTIzlXvyPM5KuQGMJT36ytmLzkShbJ1Ku1U/tvXB7tIlavE2sphrA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793799076;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=OliCLEW0wJHEWDU8AoQLIN3S0T5ID1UcJKcAC3M5Fe4=;
	b=Z+BY3Xh8kBCt2wUYhjCb0foZ9lueYS3SDCTiez8m9q/H5bqcXVm4qv0ObxEVal47GqoY
	 gyjnnDEn2h38Iwwgn9w2I/vHG1NmnFtPwMf38nfTLtUigueMnDlEPQrBmz+ZOENNGHt9u
	 CG43LpLogN+MV0S+VZXl0IwWD/LXPLjqxQ4E8xnRxbEuL45avWmbwc3sZuaO+sj0a7oM9
	 hd5Rr+7El6KbI4BLiiz357MDHSNGRXjCJt94Ij3Hp4e8/0xwvpYh7949TyNdRcg6fRQCF
	 Kso+nXC68zoj1CaeWjllYdtoBmCDNJ+RDCHo853PqxWS3c3W9uwqSyAIr+H0NpgDiig==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793799076;
	bh=OliCLEW0wJHEWDU8AoQLIN3S0T5ID1UcJKcAC3M5Fe4=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=gIbmsC8ejpFoxE5t51RoYKyraLlDTKVHhPqWlkWKNC5R+kF9iwmefPlx25E+e/SM5
	 /4KpC8bAOVne3YSMyxe9HwSanQ6Mt7zbs7xVzfrmSS3TNJXKoJzhHeBoilwAt6Go0f
	 VB4Pf/lhEnzWu6+wxLIucf4DbE18zfiVcG5LsAFNdSNAtYmUw+mT8KgJj6DHM3Qkxg
	 iyowVnBXR5GdMk7bswh8KiS/D3tWGilYQ5TILN6G6OC7KHrf6xRlkLN8NRL5waPaoe
	 Lj/CFZD4TSQM9A4AcZsIHsqn/oIn9SmCns9btpun65yQLe1tkcLin71QhiqzEvcjYW
	 idis8w4483H2w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8789760690;
	Wed,  4 Nov 2026 13:31:16 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 88EB52B6
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 09:31:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7A6B0402C5
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 09:31:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id t9qlVw3A-PRp for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 09:31:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 482DA4004D
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1332"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793784714;
 b=MTwvZp5sF8pEse5vsc/wT8uO6NRCKuvAoGKl6/X2ByMmwVUyA+AB1rN4HxWzCbPWLQV/
 Bic/DDpTTqadv0CJ7mXSEPHqBshQYdUwBrqNttNzaCG1BgKumYuXsoTdxE404fG8lmPx1
 BXBtV9VYwSNZVL9/OjfQG6waqjn1hsRp2wiHxp1R6B4HC8vz7mpEAmlHw3+usmAy84nbv
 hCmjvMvkA5vktoTakzw+JKbU0LV2CJod6vlUOi3D7/vU8z2tEpHkKvnFWkWe4uTlgL7f2
 ruEIZgZetM8r3fVMQdiN6V821PlnbGL9jqF/Pnvq9i8RHJSLNRvpKlBfXOixnJoQD8A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793784714;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=OliCLEW0wJHEWDU8AoQLIN3S0T5ID1UcJKcAC3M5Fe4=;
 b=YZnImCJZ1rZBIMqdDPAF9gd0Bw/T1ehpfDsMaN8cy5KRqsmtSx67gthUUYkpbvnsxhbS
 Zi3vX3h4DjlnJOm6zwlAOMXf+c+Bk4R/WwJtg438d6PqREjIWB3nijLRsnOt3Hx6uiSd8
 MTR2l5S+SYTT7Hj3NVOVb0vGtz7rY7/RAT6e2Fkm0YE3lDPBKBJKBV4ePUTvWqupNMteP
 PiAY27bc+jee/XZO6y/jd7TnKTXWon3lSJ9PLZvVbEiTD5UOuiSxu4fMA1GNrM6+PPgnq
 g4KE8J/mgJkTAEuC2N+HtsFvIxlKMqX/TIpTEueDi+Xad0z3FU5L4c8YoJLmIVa0O1Q==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=Tmzc3Lnn; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1332"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1332; helo=mail-dy1-x1332.google.com;
 envelope-from=nguyenanhgiau1008@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=Tmzc3Lnn
Received: from mail-dy1-x1332.google.com (mail-dy1-x1332.google.com
 [IPv6:2607:f8b0:4864:20::1332])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 482DA4004D
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 09:31:53 +0000 (UTC)
Received: by mail-dy1-x1332.google.com with SMTP id
 5a478bee46e88-33fb4680717so798450eec.1
 for <u-boot@lists.u-boot-project.org>; Wed, 04 Nov 2026 01:31:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793784713; x=1794389513;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=OliCLEW0wJHEWDU8AoQLIN3S0T5ID1UcJKcAC3M5Fe4=;
 b=Tmzc3LnnYuC/POR4Zn3LsmErZPbGIOH0QsF8QpPnKjeTi6yGaR2MHTwq5ieUsfek0f
 QUmpF2TjANNFGzM0gI6elkC5qGKBJHxaCPI/OKkQ0Q2p63AzLjVX6Wo7IXMlPELr06JE
 Z/8R+RVhBYo2VM3HmjkoAzNbClfBJTqnfD0nWG5NLk4FRinJ0Z2KSgiwg+dyWbT4dJIT
 Ojk+HF6IbprxhY6fdnX4hDKoULeh1DwT4+RrhAIQV8B3jZVA9DHAsq1DetvQD+25R+2I
 B9xlvwaGJuErritLrmET4azeFyOVup78hu5IQnBEgFFTgKzdNuncSjPHxTF1qWWpJzQW
 mR+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793784713; x=1794389513;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OliCLEW0wJHEWDU8AoQLIN3S0T5ID1UcJKcAC3M5Fe4=;
 b=v9sUISGqduEWTZB6MzfGjLh4ZK7z7i9Kc5TzIPZbhxHwSXR97RBl1MebFp354xPxNn
 sFwwvmpMgdxMI32Fsv4FFzDIJgeQ5LXP6HwtRFvwCA35SuohRrZBwerHQHC0VKDiG6fx
 aQw0JTUme1XQiI9Ng/a/2ebyVZmv9l2Oucv/yZ95p5VUBo/AEMN2zAgQaF3GpmoSVCw0
 3abFvzogbs2Pphk36KhUCvmRasplnMgUlHr9gRbd15JwugwCGlCRlpuI3qk5FL3pCVxR
 s5AzNHMToT7snLRnQaYB8wxj8X3xmXTZj3w1DYTJBgrdnL1dBNHn6gCIBg9VVffFs+pV
 4fBA==
X-Gm-Message-State: APuU4Z9zCoIFg+njBLW15Rg0x7JOTuVZqI/MR2zmnJzoJ3LjzlwvfGnN
 Sw3FTZ1cC+n2As6RqzdfeB3J8Vj4LDbLccjSnE18x/F6xSLXM6APHxsHLZZKAN5RExr27Q==
X-Gm-Gg: AYBFou1QaNnVl6ZUw8QysMlMvM0R9d3egL/XEbGFHI1mnH1xBKBIEvuZUU+xh9ZdUAn
 CIVlEVWTuT01+uMXL5C0E/mgcwZRU1ljcri/oesS9tysK654ySBGonlBXWLL2bHE4Yd9f0PXVCp
 HIORmmSzUOKuP8QAVH30C3TUeqnHYr3ZnF5z9Vlvf3ki/CUoTj+Z1xsqqYuvwdfjaQv/qH1MtPO
 FvGl2qJCRzAXIcbWFnxL7hsRk1zecGoJpkxjR8revXG54W1LZ/sJUUyIDNHAEO+gVL5xWKXE/CZ
 uH6t7PBMmpnSsTkiL2BAlp6Ht5BWjemq4K79dYlqa7m7Pv/PcR52IUsPUO1lxH9HXrTeiUDMLNp
 qd8EZtFo3VD0L1OfEykmLZzKZH4pUvQLZC7asSp5pkNJEYn+3dojV86wDfQRmcMtHX45k1Rgj7P
 7SjJSiixyH4onuMw/8Fi9AhJ4D7AJg7ZflXfbRmmZoJPTL98Xu/r3Tj7FA+dIxyxp8C9U9DBHxn
 USBC+4kXzmNwKFvi8dC3Z7welVInm+rVs9/nDAKyN145hVnZxugUCFOnSKzPo2Xehb5khutIITs
 JYf2prK3RV91BEW9L3kl/S+xkbhoul1Ad6a1TBCF
X-Received: by 2002:a05:7300:cacb:b0:36a:3310:21a8 with SMTP id
 5a478bee46e88-36a4238da58mr22730253eec.17.1793784712493; 
 Wed, 04 Nov 2026 01:31:52 -0800 (PST)
Received: from R3700x.lan ([2405:4803:217b:bca0:fde9:1c92:911f:3a66])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36ca3958746sm6030224eec.22.2026.11.04.01.31.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 01:31:51 -0800 (PST)
From: Giau Nguyen <nguyenanhgiau1008@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Matthias Brugger <mbrugger@suse.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heiko Schocher <hs@nabladev.com>, Simon Glass <sjg@chromium.org>,
 Giau Nguyen <nguyenanhgiau1008@gmail.com>
Subject: [PATCH v4 1/2] i2c: bcm2835: Add new BCM2835/BCM2711 I2C controller
 driver
Date: Wed,  4 Nov 2026 16:31:00 +0700
Message-Id: <20261104093101.500696-1-nguyenanhgiau1008@gmail.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 04 Nov 2026 13:31:11 +0000
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Mainline U-Boot currently lacks an I2C controller driver for the
Broadcom BCM2711 SoC (Raspberry Pi 4).

This commit adds a new DM-compliant I2C driver for Broadcom
BCM2835/BCM2711 SoCs, based on the Linux kernel's i2c-bcm2835.c
(Linux commit 32a0a94aa09e ("i2c: Switch back to struct
platform_driver::remove()")). The driver is polling based.

The driver dynamically queries the actual VPU core clock rate from
the VideoCore firmware via mailbox property messages to calculate
the CDIV clock divider, ensuring accurate I2C timing and baud rates
on BCM2711.

To query the clock, add bcm2835_get_clock_rate() to mach-bcm283x and
reuse it from bcm2835_get_mmc_clock(). The existing fallback to the
maximum clock rate when the firmware reports a rate of 0 is kept for
the MMC case.

Tested on a Raspberry Pi 4 Model B with a UPS HAT carrying an INA219
power monitor (I2C bus 1, address 0x42), using the 'i2c dev', 'i2c probe',
'i2c write' and 'i2c read' commands to configure the sensor and read back
its current register.

Signed-off-by: Giau Nguyen <nguyenanhgiau1008@gmail.com>
Reviewed-by: Heiko Schocher <hs@nabladev.com>
---

Notes:
    v4:
     - Split defconfig changes into a separate patch.
     - Reused bcm2835_get_clock_rate() in bcm2835_get_mmc_clock(), keeping
       the fallback to GET_MAX_CLOCK_RATE when the firmware reports a rate
       of 0. Define and declare it before bcm2835_get_mmc_clock() in msg.c
       and msg.h.
     - Added 'depends on ARCH_BCM283X' to Kconfig.
     - Dropped unsupported I2C_M_IGNORE_NAK flag handling.
     - Removed redundant !curr_msg check in polling loop.
     - Replaced printf() with dev_err() in probe().
     - Dropped redundant set_rate() call in probe(), the uclass already sets
       the bus speed from 'clock-frequency'. Check for a zero core clock
       rate in probe() instead, as bcm2835_get_clock_rate() no longer
       rejects it.
     - Fix #include order, .compatible formatting and copyright header.
    
    v3:
     - Added the Linux commit ID to the commit message.
     - Fixed alphabetical sorting of CONFIG_SYS_I2C_BCM2835 in
       drivers/i2c/Makefile.
     - Added Reviewed-by tag from Heiko.
    
    v2:
     - Clarified commit message: U-Boot mainline currently lacks BCM2711 I2C
       driver.
     - Fixed line endings and code formatting per checkpatch.pl.
     - Converted register offsets to 'struct bcm2835_i2c_regs' abstraction.
     - Removed 'bcm2835_i2c_readl/writel' wrappers in favor of standard
       readl/writel.
     - Moved mailbox clock querying to bcm2835_get_clock_rate() in
       mach-bcm283x.
     - Sorted drivers/i2c/Kconfig and Makefile alphabetically.
     - Removed 'Assisted by AI' tag.

 MAINTAINERS                              |   1 +
 arch/arm/mach-bcm283x/include/mach/msg.h |   9 +
 arch/arm/mach-bcm283x/msg.c              |  29 +-
 drivers/i2c/Kconfig                      |  11 +
 drivers/i2c/Makefile                     |   1 +
 drivers/i2c/i2c-bcm2835.c                | 359 +++++++++++++++++++++++
 6 files changed, 402 insertions(+), 8 deletions(-)
 create mode 100644 drivers/i2c/i2c-bcm2835.c

diff --git a/MAINTAINERS b/MAINTAINERS
index d273603ac64..53bf76964de 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -277,6 +277,7 @@ S:	Maintained
 F:	arch/arm/mach-bcm283x/
 F:	board/raspberrypi/
 F:	drivers/gpio/bcm2835_gpio.c
+F:	drivers/i2c/i2c-bcm2835.c
 F:	drivers/mmc/bcm2835_sdhci.c
 F:	drivers/mmc/bcm2835_sdhost.c
 F:	drivers/serial/serial_bcm283x_mu.c
diff --git a/arch/arm/mach-bcm283x/include/mach/msg.h b/arch/arm/mach-bcm283x/include/mach/msg.h
index e54da86e353..ca8cc8826da 100644
--- a/arch/arm/mach-bcm283x/include/mach/msg.h
+++ b/arch/arm/mach-bcm283x/include/mach/msg.h
@@ -14,6 +14,15 @@
  */
 int bcm2835_power_on_module(u32 module);
 
+/**
+ * bcm2835_get_clock_rate() - get the current rate of a clock
+ *
+ * @clock_id: ID of clock to get frequency for (BCM2835_MBOX_CLOCK_ID_...)
+ * @rate: Returns the clock rate in Hz (may be 0 if the clock is not running)
+ * Return: 0 if OK, -EIO on error
+ */
+int bcm2835_get_clock_rate(u32 clock_id, ulong *rate);
+
 /**
  * bcm2835_get_mmc_clock() - get the frequency of the MMC clock
  *
diff --git a/arch/arm/mach-bcm283x/msg.c b/arch/arm/mach-bcm283x/msg.c
index 05e1a02e80f..d1b85bdac24 100644
--- a/arch/arm/mach-bcm283x/msg.c
+++ b/arch/arm/mach-bcm283x/msg.c
@@ -77,15 +77,10 @@ int bcm2835_power_on_module(u32 module)
 	return 0;
 }
 
-int bcm2835_get_mmc_clock(u32 clock_id)
+int bcm2835_get_clock_rate(u32 clock_id, ulong *rate)
 {
 	ALLOC_CACHE_ALIGN_BUFFER(struct msg_get_clock_rate, msg_clk, 1);
 	int ret;
-	u32 clock_rate = 0;
-
-	ret = bcm2835_power_on_module(BCM2835_MBOX_POWER_DEVID_SDHCI);
-	if (ret)
-		return ret;
 
 	BCM2835_MBOX_INIT_HDR(msg_clk);
 	BCM2835_MBOX_INIT_TAG(&msg_clk->get_clock_rate, GET_CLOCK_RATE);
@@ -93,11 +88,29 @@ int bcm2835_get_mmc_clock(u32 clock_id)
 
 	ret = bcm2835_mbox_call_prop(BCM2835_MBOX_PROP_CHAN, &msg_clk->hdr);
 	if (ret) {
-		printf("bcm2835: Could not query eMMC clock rate\n");
+		printf("bcm2835: Could not query clock rate for clock %u\n",
+		       clock_id);
 		return -EIO;
 	}
 
-	clock_rate = msg_clk->get_clock_rate.body.resp.rate_hz;
+	*rate = msg_clk->get_clock_rate.body.resp.rate_hz;
+
+	return 0;
+}
+
+int bcm2835_get_mmc_clock(u32 clock_id)
+{
+	ALLOC_CACHE_ALIGN_BUFFER(struct msg_get_clock_rate, msg_clk, 1);
+	ulong clock_rate;
+	int ret;
+
+	ret = bcm2835_power_on_module(BCM2835_MBOX_POWER_DEVID_SDHCI);
+	if (ret)
+		return ret;
+
+	ret = bcm2835_get_clock_rate(clock_id, &clock_rate);
+	if (ret)
+		return ret;
 
 	if (clock_rate == 0) {
 		BCM2835_MBOX_INIT_HDR(msg_clk);
diff --git a/drivers/i2c/Kconfig b/drivers/i2c/Kconfig
index 0b5225fd3f5..77f71cd28ca 100644
--- a/drivers/i2c/Kconfig
+++ b/drivers/i2c/Kconfig
@@ -171,6 +171,17 @@ config SYS_I2C_AT91
 	  i2c-gpio driver unless your system can cope with this limitation.
 	  Binding info: doc/device-tree-bindings/i2c/i2c-at91.txt
 
+config SYS_I2C_BCM2835
+	bool "BCM2835 I2C controller"
+	depends on DM_I2C
+	depends on ARCH_BCM283X
+	help
+	  Enable support for the Broadcom BCM2835/BCM2711 I2C controller.
+	  This driver provides standard I2C support for Raspberry Pi
+	  devices, including the newer Raspberry Pi 4. It dynamically
+	  calculates the clock divider based on the VPU core clock
+	  queried via the firmware mailbox.
+
 config SYS_I2C_IPROC
 	bool "Broadcom I2C driver"
 	depends on DM_I2C
diff --git a/drivers/i2c/Makefile b/drivers/i2c/Makefile
index 79e6a298808..207449f0f20 100644
--- a/drivers/i2c/Makefile
+++ b/drivers/i2c/Makefile
@@ -15,6 +15,7 @@ obj-$(CONFIG_SYS_I2C_ADI) += adi_i2c.o
 obj-$(CONFIG_SYS_I2C_ASPEED) += ast_i2c.o
 obj-$(CONFIG_SYS_I2C_AST2600) += ast2600_i2c.o
 obj-$(CONFIG_SYS_I2C_AT91) += at91_i2c.o
+obj-$(CONFIG_SYS_I2C_BCM2835) += i2c-bcm2835.o
 obj-$(CONFIG_SYS_I2C_CADENCE) += i2c-cdns.o
 obj-$(CONFIG_SYS_I2C_CA) += i2c-cortina.o
 obj-$(CONFIG_SYS_I2C_DAVINCI) += davinci_i2c.o
diff --git a/drivers/i2c/i2c-bcm2835.c b/drivers/i2c/i2c-bcm2835.c
new file mode 100644
index 00000000000..58bc3ce944c
--- /dev/null
+++ b/drivers/i2c/i2c-bcm2835.c
@@ -0,0 +1,359 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * BCM2835 I2C controller driver
+ * Copyright (C) 2026 Giau Nguyen <nguyenanhgiau1008@gmail.com>
+ *
+ * Based on Linux driver: drivers/i2c/busses/i2c-bcm2835.c
+ */
+
+#include <dm.h>
+#include <i2c.h>
+#include <time.h>
+#include <log.h>
+#include <asm/io.h>
+#include <asm/arch/mbox.h>
+#include <asm/arch/msg.h>
+#include <dm/device_compat.h>
+#include <linux/bitops.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/kernel.h>
+#include <linux/types.h>
+
+#define BCM2835_I2C_C_READ	BIT(0)
+#define BCM2835_I2C_C_CLEAR	BIT(4) /* bits 4 and 5 both clear */
+#define BCM2835_I2C_C_ST	BIT(7)
+#define BCM2835_I2C_C_INTD	BIT(8)
+#define BCM2835_I2C_C_INTT	BIT(9)
+#define BCM2835_I2C_C_INTR	BIT(10)
+#define BCM2835_I2C_C_I2CEN	BIT(15)
+
+#define BCM2835_I2C_S_TA	BIT(0)
+#define BCM2835_I2C_S_DONE	BIT(1)
+#define BCM2835_I2C_S_TXW	BIT(2)
+#define BCM2835_I2C_S_RXR	BIT(3)
+#define BCM2835_I2C_S_TXD	BIT(4)
+#define BCM2835_I2C_S_RXD	BIT(5)
+#define BCM2835_I2C_S_TXE	BIT(6)
+#define BCM2835_I2C_S_RXF	BIT(7)
+#define BCM2835_I2C_S_ERR	BIT(8)
+#define BCM2835_I2C_S_CLKT	BIT(9)
+#define BCM2835_I2C_S_LEN	BIT(10) /* Fake bit for SW error reporting */
+
+#define BCM2835_I2C_FEDL_SHIFT	16
+#define BCM2835_I2C_REDL_SHIFT	0
+
+#define BCM2835_I2C_CDIV_MIN	0x0002
+#define BCM2835_I2C_CDIV_MAX	0xFFFE
+
+#define BCM2835_I2C_CLKT_TOUT_MS 35
+#define BCM2835_I2C_XFER_TIMEOUT_MS 1000
+
+struct bcm2835_i2c_regs {
+	u32 c;
+	u32 s;
+	u32 dlen;
+	u32 a;
+	u32 fifo;
+	u32 div;
+	u32 del;
+	u32 clkt;
+};
+
+struct bcm2835_i2c_priv {
+	struct bcm2835_i2c_regs __iomem *regs;
+	ulong input_rate;
+	size_t msg_buf_remaining;
+	u8 *msg_buf;
+	struct i2c_msg *curr_msg;
+	int msg_err;
+	int num_msgs;
+};
+
+static void bcm2835_fill_txfifo(struct bcm2835_i2c_priv *i2c_dev)
+{
+	struct bcm2835_i2c_regs __iomem *regs = i2c_dev->regs;
+
+	while (i2c_dev->msg_buf_remaining) {
+		if (!(readl(&regs->s) & BCM2835_I2C_S_TXD))
+			break;
+
+		writel(*i2c_dev->msg_buf, &regs->fifo);
+		i2c_dev->msg_buf++;
+		i2c_dev->msg_buf_remaining--;
+	}
+}
+
+static void bcm2835_drain_rxfifo(struct bcm2835_i2c_priv *i2c_dev)
+{
+	struct bcm2835_i2c_regs __iomem *regs = i2c_dev->regs;
+
+	while (i2c_dev->msg_buf_remaining) {
+		if (!(readl(&regs->s) & BCM2835_I2C_S_RXD))
+			break;
+
+		*i2c_dev->msg_buf = readl(&regs->fifo);
+		i2c_dev->msg_buf++;
+		i2c_dev->msg_buf_remaining--;
+	}
+}
+
+static int bcm2835_i2c_calc_divider(unsigned long rate,
+				    unsigned long parent_rate)
+{
+	int divider = DIV_ROUND_UP(parent_rate, rate);
+
+	/*
+	 * Per the datasheet, the register is always interpreted as an even
+	 * number, by rounding down. In other words, the LSB is ignored. So,
+	 * if the LSB is set, increment the divider to avoid any issue.
+	 */
+	if (divider & 1)
+		divider++;
+
+	if (divider < BCM2835_I2C_CDIV_MIN ||
+	    divider > BCM2835_I2C_CDIV_MAX)
+		return -EINVAL;
+
+	return divider;
+}
+
+static int bcm2835_i2c_set_rate(struct udevice *bus, unsigned int rate)
+{
+	struct bcm2835_i2c_priv *i2c_dev = dev_get_priv(bus);
+	struct bcm2835_i2c_regs __iomem *regs = i2c_dev->regs;
+	ulong parent_rate = i2c_dev->input_rate;
+	u32 redl, fedl;
+	u32 clk_tout;
+	int divider;
+
+	if (!rate || !parent_rate)
+		return -EINVAL;
+
+	divider = bcm2835_i2c_calc_divider(rate, parent_rate);
+	if (divider < 0)
+		return divider;
+
+	writel(divider, &regs->div);
+
+	/*
+	 * Number of core clocks to wait after falling edge before
+	 * outputting the next data bit. Note that both FEDL and REDL
+	 * can't be greater than CDIV/2.
+	 */
+	fedl = max_t(u32, divider / 16, 1);
+
+	/*
+	 * Number of core clocks to wait after rising edge before
+	 * sampling the next incoming data bit.
+	 */
+	redl = max_t(u32, divider / 4, 1);
+
+	writel((fedl << BCM2835_I2C_FEDL_SHIFT) |
+	       (redl << BCM2835_I2C_REDL_SHIFT), &regs->del);
+
+	/*
+	 * Set the clock stretch timeout.
+	 */
+	if (rate > 0xffff * 1000 / BCM2835_I2C_CLKT_TOUT_MS)
+		clk_tout = 0xffff;
+	else
+		clk_tout = BCM2835_I2C_CLKT_TOUT_MS * rate / 1000;
+
+	writel(clk_tout, &regs->clkt);
+
+	return 0;
+}
+
+static void bcm2835_i2c_start_transfer(struct bcm2835_i2c_priv *i2c_dev)
+{
+	struct bcm2835_i2c_regs __iomem *regs = i2c_dev->regs;
+	u32 c = BCM2835_I2C_C_ST | BCM2835_I2C_C_I2CEN;
+	struct i2c_msg *msg = i2c_dev->curr_msg;
+	bool last_msg = (i2c_dev->num_msgs == 1);
+
+	if (!i2c_dev->num_msgs)
+		return;
+
+	i2c_dev->num_msgs--;
+	i2c_dev->msg_buf = msg->buf;
+	i2c_dev->msg_buf_remaining = msg->len;
+
+	if (msg->flags & I2C_M_RD)
+		c |= BCM2835_I2C_C_READ;
+	else
+		c |= BCM2835_I2C_C_INTT;
+
+	if (last_msg)
+		c |= BCM2835_I2C_C_INTD;
+
+	writel(msg->addr, &regs->a);
+	writel(msg->len, &regs->dlen);
+	writel(c, &regs->c);
+}
+
+static void bcm2835_i2c_finish_transfer(struct bcm2835_i2c_priv *i2c_dev)
+{
+	i2c_dev->curr_msg = NULL;
+	i2c_dev->num_msgs = 0;
+	i2c_dev->msg_buf = NULL;
+	i2c_dev->msg_buf_remaining = 0;
+}
+
+static int bcm2835_i2c_xfer(struct udevice *dev, struct i2c_msg *msgs, int count)
+{
+	struct bcm2835_i2c_priv *i2c_dev = dev_get_priv(dev);
+	struct bcm2835_i2c_regs __iomem *regs = i2c_dev->regs;
+	bool done = false;
+	ulong start;
+	int i;
+	u32 val, err;
+	int ret = 0;
+
+	if (!msgs || count <= 0)
+		return -EINVAL;
+
+	for (i = 0; i < count; i++) {
+		if (msgs[i].flags & I2C_M_TEN)
+			return -EOPNOTSUPP;
+		if (msgs[i].flags & I2C_M_RD) {
+			if (i < count - 1) {
+				dev_err(dev, "read message must be last\n");
+				return -EOPNOTSUPP;
+			}
+		}
+		if (msgs[i].len > 0xffff)
+			return -EINVAL;
+	}
+
+	/* Clear stale status and FIFO state before starting a new transaction. */
+	writel(BCM2835_I2C_C_CLEAR, &regs->c);
+	writel(BCM2835_I2C_S_CLKT | BCM2835_I2C_S_ERR | BCM2835_I2C_S_DONE,
+	       &regs->s);
+
+	i2c_dev->curr_msg = msgs;
+	i2c_dev->num_msgs = count;
+	i2c_dev->msg_err = 0;
+
+	bcm2835_i2c_start_transfer(i2c_dev);
+	start = get_timer(0);
+	while (get_timer(start) < BCM2835_I2C_XFER_TIMEOUT_MS) {
+		val = readl(&regs->s);
+
+		err = val & (BCM2835_I2C_S_CLKT | BCM2835_I2C_S_ERR);
+		if (err && !(val & BCM2835_I2C_S_TA))
+			i2c_dev->msg_err = err;
+
+		if (val & BCM2835_I2C_S_DONE) {
+			if (i2c_dev->curr_msg->flags & I2C_M_RD) {
+				bcm2835_drain_rxfifo(i2c_dev);
+				val = readl(&regs->s);
+			}
+
+			if ((val & BCM2835_I2C_S_RXD) ||
+			    i2c_dev->msg_buf_remaining)
+				i2c_dev->msg_err = BCM2835_I2C_S_LEN;
+			done = true;
+			break;
+		}
+
+		if (val & BCM2835_I2C_S_TXW) {
+			if (!i2c_dev->msg_buf_remaining) {
+				i2c_dev->msg_err = val | BCM2835_I2C_S_LEN;
+				break;
+			}
+
+			bcm2835_fill_txfifo(i2c_dev);
+
+			if (i2c_dev->num_msgs > 0 && !i2c_dev->msg_buf_remaining) {
+				i2c_dev->curr_msg++;
+				bcm2835_i2c_start_transfer(i2c_dev);
+			}
+		}
+
+		if (val & BCM2835_I2C_S_RXR) {
+			if (!i2c_dev->msg_buf_remaining) {
+				i2c_dev->msg_err = val | BCM2835_I2C_S_LEN;
+				break;
+			}
+
+			bcm2835_drain_rxfifo(i2c_dev);
+		}
+		udelay(1);
+	}
+
+	if (!done) {
+		val = readl(&regs->s);
+		dev_err(dev, "transfer timeout: status=%08x remaining=%zu\n",
+			val, i2c_dev->msg_buf_remaining);
+		ret = -ETIMEDOUT;
+	}
+
+	/* Always abort/reset the controller and clear W1C status bits. */
+	writel(BCM2835_I2C_C_CLEAR, &regs->c);
+	writel(BCM2835_I2C_S_CLKT | BCM2835_I2C_S_ERR | BCM2835_I2C_S_DONE,
+	       &regs->s);
+
+	bcm2835_i2c_finish_transfer(i2c_dev);
+	if (ret)
+		return ret;
+
+	if (!i2c_dev->msg_err)
+		return 0;
+
+	if (i2c_dev->msg_err & BCM2835_I2C_S_ERR)
+		return -EREMOTEIO;
+
+	return -EIO;
+}
+
+static const struct dm_i2c_ops bcm2835_i2c_ops = {
+	.xfer          = bcm2835_i2c_xfer,
+	.set_bus_speed = bcm2835_i2c_set_rate,
+};
+
+static const struct udevice_id bcm2835_i2c_ids[] = {
+	{ .compatible = "brcm,bcm2711-i2c" },
+	{ .compatible = "brcm,bcm2835-i2c" },
+	{ }
+};
+
+static int bcm2835_i2c_probe(struct udevice *bus)
+{
+	struct bcm2835_i2c_priv *priv = dev_get_priv(bus);
+	struct bcm2835_i2c_regs __iomem *regs;
+	int ret;
+
+	priv->regs = dev_read_addr_ptr(bus);
+	if (!priv->regs) {
+		dev_err(bus, "cannot get base address\n");
+		return -EINVAL;
+	}
+
+	regs = priv->regs;
+
+	ret = bcm2835_get_clock_rate(BCM2835_MBOX_CLOCK_ID_CORE, &priv->input_rate);
+	if (ret)
+		return ret;
+
+	if (!priv->input_rate) {
+		dev_err(bus, "invalid core clock rate\n");
+		return -EINVAL;
+	}
+
+	/* clear FIFO + status */
+	writel(BCM2835_I2C_C_CLEAR, &regs->c);
+	writel(BCM2835_I2C_S_CLKT | BCM2835_I2C_S_ERR | BCM2835_I2C_S_DONE,
+	       &regs->s);
+
+	return 0;
+}
+
+U_BOOT_DRIVER(bcm2835_i2c) = {
+	.name       = "bcm2835_i2c",
+	.id         = UCLASS_I2C,
+	.of_match   = bcm2835_i2c_ids,
+	.probe      = bcm2835_i2c_probe,
+	.priv_auto  = sizeof(struct bcm2835_i2c_priv),
+	.ops        = &bcm2835_i2c_ops,
+};
-- 
2.34.1


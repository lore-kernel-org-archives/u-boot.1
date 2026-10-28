Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4897D606A31A
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 13:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=pmFa6O9C;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LsApWNac
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E9158810A2;
	Wed, 28 Oct 2026 13:36:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sRs4j6Z3YqAb; Wed, 28 Oct 2026 13:36:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 57B5C80FBC
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793194596;
	b=rlUN3Oi22uFLeIAfbdFrSENh/vINkr90zoIFqUmy/Md0eXP3eCjw1xLS3tqmMG2y8Fwg
	 /jxZxa7FDqsQsXGbCZfQ4yF/HlS1MxbNYwlTh8SzgZspHxmPKCVQeB6OJZnHFmF0qUfhr
	 KNpN/igIf4TzzcllkxStO9+GBRqn+7vwxvvp3LvEHziR0njgJsYjn+JhJxIK70G2ghi9f
	 a91bwYbzq+SBIodt3rJiavKzdDTjNU4c76mRNJVvXo1h4xrSflPrB/Gt1DWePtKOzgI7D
	 D7JAWapXwWZppXmZf1YwqLvZGMeV2o07qeGioJrE3BIJjUFS2nj18QU395enEz7eC6Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793194596;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=iJOcJg3njCtX/duCVV5hg3HhY4mQ3CnMlNqENSbedjA=;
	b=iQRNpWbjSN0D1EITChNFAFweWBISw57HKhbrk5iK+eMk0PEx/ZG1Gj9tCZ899FtgWC9P
	 LcsMbv6OJUzrzqoXdGWgBtHkrCswBr6SbvHUdhqhJcVn5ehwQxj3QTEWpSDDP3OO6ulVt
	 accQYz8JK0o6TTw4skxVVCFwWgF4PNusxDshUleHWSXpX+wN4MQQn7W60n0kZMoRuE7hE
	 P7bVJnXVViau5rxbHZ47KdkLF6aZ5EWTIlLunUcZFR9StfwqAs84S31tLgJlITiL8YqQb
	 bOLYcr17ntvIu0nf/9RbK0QM77VsDWbOTfhTkEnV1oVghcYz4RjtC3LIBfnCbldBBsA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793194596;
	bh=iJOcJg3njCtX/duCVV5hg3HhY4mQ3CnMlNqENSbedjA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pmFa6O9CZHIpGw9MaiKNw2aMp9RnWdUI0Suo7KHlVGajwAQ+xVdaGDQEOBL/ECJjn
	 xOA7pYn0MaLxVNlvd2sgkFpiaMi4P7fYlmH2F/3lQ/kNA1zcGhTT0cdrDB1RMLdEhd
	 p/bP2o/paQkm9mP0LEbdxZkb7LwCgcs2a+FitMWG0A0ufRJyTnj4E2kAxP9z2tR76t
	 abP2Mh4Mn4BTk1hwjlCGjMUYVnLJAfr6Rd+p/H9oXK55hTEwfXvMsXHbZNzhOCZlVb
	 k28PKfIOx4ut5Mv072jP7mKzAHfH1476nA+dMo/0hPdTABnAZ33PKvFns6t4icKe7H
	 tUSsBbP4zPDCg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 57B5C80FBC;
	Wed, 28 Oct 2026 13:36:35 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 6E1392E5
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 11:30:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 54446400FF
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 11:30:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Hs9M8EcID0V9 for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 11:30:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 361B940087
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::62d"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793187019;
 b=r+cKhKrJCj8UvTeHaXGrWnnC3oGVVZNk7RcIYc3zA3cJEXd3hFkA44j/wz7xuOQkXG3O
 0AXKE3+ircwV1VlYjzy/k9kK0h3gnbRhttXFQwMFCU8tRBPefBfmAg27G6EWDP3FAUCBA
 VW510i0ZtOZzU8V2ekkJyQBZaYrxIkrTkbT/kgiPXIyOPQNmF2RAXsOYUVqVHjodXjAAC
 PZHke1uLx5G7BnCsiQU/p0hcNzYFrvvuMnjv/2dXK48B6cQyfp6IyBbk8Jt7YNU8bP097
 llrJR5/f7JhSHJ+6yD+jRIh4UAy3mk/Vs6x8vGcgLNdAJYmD+Z6ckgrCzHfeZ4CK8gQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793187019;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=iJOcJg3njCtX/duCVV5hg3HhY4mQ3CnMlNqENSbedjA=;
 b=dMUZ13+3tMJwu9hLqXXN2sY+dNAMRwiBMms8d84XuI5STcaHMGjs4vBWSa7qhARbiK9c
 GSpJkZfOLeTK6azorTOpsqesDW/HyyPlniCst1JrNxJl8sscoC0UqOmcSoGS06IYASznq
 RjSS7WLWduhEd2gFYaxloJ4UWP88x6vZ64o6kFQt3lxAzp6wOjxt6EzOtM2nQWe0P4s5O
 zLipSm0dTilub1v2//0P2zvAc5AXRZtOjzfp0aLGwbzbyjL4w+W5THhufue/HAjMqPYtC
 qTSSeAAj2oh2c8cFyTf1Ov6JXUIGg2DMJnhMlIh4zoOZ/c6LaFFMFBveIB4eT1JuSZg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=LsApWNac; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::62d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::62d; helo=mail-pl1-x62d.google.com;
 envelope-from=nguyenanhgiau1008@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=LsApWNac
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 361B940087
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 11:30:18 +0000 (UTC)
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2e5378b281aso4122525ad.2
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 04:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793187018; x=1793791818;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=iJOcJg3njCtX/duCVV5hg3HhY4mQ3CnMlNqENSbedjA=;
 b=LsApWNac0vEMI02F06tejXB5QdkBUo2lfY11pCpHfoiucJyXPyUYSzvPU7eMY6+l+T
 0/+trvL+um6if5wPSCb39xQvj/30XCOC0DUxD8FqggOKccNuEqWYtopUBbqUevv5ddbf
 MdW0L3eGlAzHs3xaA0iK6xlwFEzEiUbHD37FSEUHXOXYaZ7JsQcQvjSzh/OlifHE3dUL
 nxcygRhoHNgey7NuUxZhCD1rXsejvWVwSjKQ0iE1Ff3+YwsbQSptNJ58+iGFswKZbdGt
 EFuoutqTkO/P4h5KTkLUJB8E+jcSDypVK7y/IxBrriKUCjfprKif5feS5QW4ycsZ8eiZ
 YRXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793187018; x=1793791818;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=iJOcJg3njCtX/duCVV5hg3HhY4mQ3CnMlNqENSbedjA=;
 b=aGUJdnEBcNUK7hDJZH0ve318uL6q2+j6uj9G2FvHZxZB5sIMdgwhlzU7G8CKUWxPGI
 PTcLxw28Jq3yH8a+kVLQ5+keip5ibsPTnYmWIVoXrRGBFLKk8cQrrwLorKnLCyJDKqvW
 Kaoks0hkCwZtJCWoBNsLUG5/AHv/O17Qlo23C7SIalMdTP8SzD2eXuiySrJonOzKHUFl
 PWBMnyVI7jx1n/YxswRnv65TKi9QCBhfrOLAKHvHyBsBold8oaYVOgY/6WWtPucaSWlh
 UNz0iqSRh2ghMf4V6MpxrOQaKTSn0WVXvOZRwB/DnPF4IMFHO4t6Wk3VzfytGqabCUGu
 Q4Sg==
X-Gm-Message-State: AFq9FYLOh0fLGisnDqc9YwR18Z5aDMAggFRYyoPm5CMLjro1awPpkPRt
 nWGdGn6FSif2L29r5ijqC4XnISEiuHyLNAYhpa3teV8zRzou9YJPlBNqqsuRHmch4pg6yykx
X-Gm-Gg: AYBFou0NskAehV99gMCPHqnSjrCUFM3BLVntKMV7llbUDsFiHBd6TiBJ8uUiI2bWNzw
 nOD7xXPbBRL08cw728GcKMnRCwIM+z2kvDXSe2Vu/+pQiIqP1bDCm0F23lWYqkwpaxXw3QqFoYZ
 sBgpuDR/3OQxC9TrjjBOLYWUtmxAiBO/y31wmjODDby9AS+XlfTNDVltf2qCVHABqm5p2Xh7tJQ
 8dbKwKMYRhzMlSS6Rf1kOrlDELBAhga7l8ro/4tMCSoZZGGGW/X2cpGjHh57g1/QSXLEM2ee9Sj
 Jc4kiSo8NLf/1RG/0lE4zwq3rt1UDYYlR+pNYcdgyc+wKaK8EN1C8Lykv2ihjfhoyhDUZyywM5c
 D4IyCXV/ZtA1huUA6gn3aRoVIkPVuaShGfAIuLYyF766FfBM7My1il52fhwyGnAe8DsdzyChCzs
 oEuQZffAA7tUZf02qfFGo4B2t+DDl4C1OINRMNZ+qHsc+K09GtFpyZBI8axTlkWGWFumpDP/axy
 o207ng88ZTwm6+Jvddsput4+WhpSOTTZnL9d02dH/QBuLKDNzjQHV/LpzO294l1Kj4pdUFf0Jk6
 kWTr7r+dPGsOuerrqZvMqrWSTIyCEcrm3J3yflU=
X-Received: by 2002:a17:903:144f:b0:2e9:4b32:fc66 with SMTP id
 d9443c01a7336-2eb002e1ef3mr19883905ad.10.1793187017756; 
 Wed, 28 Oct 2026 04:30:17 -0700 (PDT)
Received: from R3700x.lan ([2405:4803:217b:bca0:5d93:2973:6540:69d1])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2eae6c37551sm21039355ad.51.2026.10.28.04.30.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 04:30:16 -0700 (PDT)
From: Giau Nguyen <nguyenanhgiau1008@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: hs@nabladev.com, mbrugger@suse.com, pbrobinson@gmail.com,
 trini@konsulko.com, Giau Nguyen <nguyenanhgiau1008@gmail.com>
Subject: [PATCH v2] i2c: bcm2835: Add new BCM2835/BCM2711 I2C controller driver
Date: Wed, 28 Oct 2026 18:30:05 +0700
Message-Id: <20261028113005.515786-1-nguyenanhgiau1008@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <0a36eb46-539f-8e47-02db-5dfe91a9bab2@nabladev.com>
References: <0a36eb46-539f-8e47-02db-5dfe91a9bab2@nabladev.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 28 Oct 2026 13:36:21 +0000
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
BCM2835/BCM2711 SoCs based on the Linux kernel's i2c-bcm2835.c.

The driver dynamically queries the actual VPU core clock rate from
the VideoCore firmware via mailbox property messages to calculate
the CDIV clock divider, ensuring accurate I2C timing and baud rates
on BCM2711.

Enable CONFIG_SYS_I2C_BCM2835 in rpi_4_defconfig.

Signed-off-by: Giau Nguyen <nguyenanhgiau1008@gmail.com>
---
v2:
 - Clarified commit message: U-Boot mainline currently lacks BCM2711 I2C driver.
 - Fixed line endings and code formatting per checkpatch.pl.
 - Converted register offsets to 'struct bcm2835_i2c_regs' abstraction.
 - Removed 'bcm2835_i2c_readl/writel' wrappers in favor of standard readl/writel.
 - Moved mailbox clock querying to bcm2835_get_clock_rate() in mach-bcm283x.
 - Enabled CONFIG_SYS_I2C_BCM2835 in rpi_4_defconfig.
 - Sorted drivers/i2c/Kconfig and Makefile alphabetically.
 - Removed 'Assisted by AI' tag.

 MAINTAINERS                              |   1 +
 arch/arm/mach-bcm283x/include/mach/msg.h |   9 +
 arch/arm/mach-bcm283x/msg.c              |  22 ++
 configs/rpi_4_defconfig                  |   4 +
 drivers/i2c/Kconfig                      |  10 +
 drivers/i2c/Makefile                     |   1 +
 drivers/i2c/i2c-bcm2835.c                | 370 +++++++++++++++++++++++
 7 files changed, 417 insertions(+)
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
index e54da86e353..d6adec07ae2 100644
--- a/arch/arm/mach-bcm283x/include/mach/msg.h
+++ b/arch/arm/mach-bcm283x/include/mach/msg.h
@@ -22,6 +22,15 @@ int bcm2835_power_on_module(u32 module);
  */
 int bcm2835_get_mmc_clock(u32 clock_id);
 
+/**
+ * bcm2835_get_clock_rate() - get the current rate of a clock
+ *
+ * @clock_id: ID of clock to get frequency for (BCM2835_MBOX_CLOCK_ID_...)
+ * @rate: Returns the clock rate in Hz
+ * Return: 0 if OK, -EIO or -EINVAL on error
+ */
+int bcm2835_get_clock_rate(u32 clock_id, ulong *rate);
+
 /**
  * bcm2835_set_sdhost_clock() - determine if firmware controls sdhost cdiv
  *
diff --git a/arch/arm/mach-bcm283x/msg.c b/arch/arm/mach-bcm283x/msg.c
index 05e1a02e80f..b8917662b31 100644
--- a/arch/arm/mach-bcm283x/msg.c
+++ b/arch/arm/mach-bcm283x/msg.c
@@ -116,6 +116,28 @@ int bcm2835_get_mmc_clock(u32 clock_id)
 	return clock_rate;
 }
 
+int bcm2835_get_clock_rate(u32 clock_id, ulong *rate)
+{
+	ALLOC_CACHE_ALIGN_BUFFER(struct msg_get_clock_rate, msg_clk, 1);
+	int ret;
+
+	BCM2835_MBOX_INIT_HDR(msg_clk);
+	BCM2835_MBOX_INIT_TAG(&msg_clk->get_clock_rate, GET_CLOCK_RATE);
+	msg_clk->get_clock_rate.body.req.clock_id = clock_id;
+
+	ret = bcm2835_mbox_call_prop(BCM2835_MBOX_PROP_CHAN, &msg_clk->hdr);
+	if (ret) {
+		printf("bcm2835: Could not query clock rate for %u\n", clock_id);
+		return -EIO;
+	}
+
+	*rate = msg_clk->get_clock_rate.body.resp.rate_hz;
+	if (!*rate)
+		return -EINVAL;
+
+	return 0;
+}
+
 int bcm2835_set_sdhost_clock(u32 rate_hz, u32 *rate_1, u32 *rate_2)
 {
 	ALLOC_CACHE_ALIGN_BUFFER(struct msg_set_sdhost_clock, msg_sdhost_clk, 1);
diff --git a/configs/rpi_4_defconfig b/configs/rpi_4_defconfig
index 850f8c7d1c6..b6f97d8635b 100644
--- a/configs/rpi_4_defconfig
+++ b/configs/rpi_4_defconfig
@@ -24,6 +24,7 @@ CONFIG_SYS_PROMPT="U-Boot> "
 CONFIG_CMD_NVEDIT_EFI=y
 CONFIG_CMD_DFU=y
 CONFIG_CMD_GPIO=y
+CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_PCI=y
 CONFIG_CMD_USB=y
@@ -37,6 +38,9 @@ CONFIG_DM_DMA=y
 CONFIG_DFU_MMC=y
 CONFIG_SYS_DFU_DATA_BUF_SIZE=0x100000
 CONFIG_SYS_DFU_MAX_FILE_SIZE=0x200000
+CONFIG_I2C=y
+CONFIG_DM_I2C=y
+CONFIG_SYS_I2C_BCM2835=y
 CONFIG_BCM2835_GPIO=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
diff --git a/drivers/i2c/Kconfig b/drivers/i2c/Kconfig
index 0b5225fd3f5..191083c9184 100644
--- a/drivers/i2c/Kconfig
+++ b/drivers/i2c/Kconfig
@@ -171,6 +171,16 @@ config SYS_I2C_AT91
 	  i2c-gpio driver unless your system can cope with this limitation.
 	  Binding info: doc/device-tree-bindings/i2c/i2c-at91.txt
 
+config SYS_I2C_BCM2835
+	bool "BCM2835 I2C controller"
+	depends on DM_I2C
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
index 79e6a298808..41378a71d1d 100644
--- a/drivers/i2c/Makefile
+++ b/drivers/i2c/Makefile
@@ -54,6 +54,7 @@ obj-$(CONFIG_SYS_I2C_SUN6I_P2WI) += sun6i_p2wi.o
 obj-$(CONFIG_SYS_I2C_SUN8I_RSB) += sun8i_rsb.o
 obj-$(CONFIG_SYS_I2C_SYNQUACER) += synquacer_i2c.o
 obj-$(CONFIG_SYS_I2C_TEGRA) += tegra_i2c.o
+obj-$(CONFIG_SYS_I2C_BCM2835) += i2c-bcm2835.o
 obj-$(CONFIG_SYS_I2C_UNIPHIER) += i2c-uniphier.o
 obj-$(CONFIG_SYS_I2C_UNIPHIER_F) += i2c-uniphier-f.o
 obj-$(CONFIG_SYS_I2C_VERSATILE) += i2c-versatile.o
diff --git a/drivers/i2c/i2c-bcm2835.c b/drivers/i2c/i2c-bcm2835.c
new file mode 100644
index 00000000000..e6abb076bdb
--- /dev/null
+++ b/drivers/i2c/i2c-bcm2835.c
@@ -0,0 +1,370 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * BCM2835 I2C controller driver
+ * (C) Copyright 2026
+ *
+ * Author: Giau Nguyen <nguyenanhgiau1008@gmail.com>
+ * Based on Linux driver: drivers/i2c/busses/i2c-bcm2835.c
+ */
+
+#include <log.h>
+#include <asm/io.h>
+#include <asm/arch/mbox.h>
+#include <asm/arch/msg.h>
+#include <dm.h>
+#include <dm/device_compat.h>
+#include <i2c.h>
+#include <time.h>
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
+	bool ignore_nak = false;
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
+		if (msgs[i].flags & I2C_M_IGNORE_NAK)
+			ignore_nak = true;
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
+			if (!i2c_dev->curr_msg) {
+				dev_err(dev, "unexpected completion status\n");
+			} else if (i2c_dev->curr_msg->flags & I2C_M_RD) {
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
+	if (ignore_nak)
+		i2c_dev->msg_err &= ~BCM2835_I2C_S_ERR;
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
+	{.compatible = "brcm,bcm2711-i2c"},
+	{.compatible = "brcm,bcm2835-i2c"},
+	{}
+};
+
+static int bcm2835_i2c_probe(struct udevice *bus)
+{
+	struct bcm2835_i2c_priv *priv = dev_get_priv(bus);
+	struct bcm2835_i2c_regs __iomem *regs;
+	unsigned int bus_clk_rate;
+	int ret;
+
+	priv->regs = dev_read_addr_ptr(bus);
+	if (!priv->regs) {
+		printf("bcm2835_i2c: cannot get base address\n");
+		return -EINVAL;
+	}
+
+	regs = priv->regs;
+
+	ret = bcm2835_get_clock_rate(BCM2835_MBOX_CLOCK_ID_CORE, &priv->input_rate);
+	if (ret)
+		return ret;
+
+	bus_clk_rate = dev_read_u32_default(bus, "clock-frequency",
+					    I2C_SPEED_STANDARD_RATE);
+	ret = bcm2835_i2c_set_rate(bus, bus_clk_rate);
+	if (ret)
+		return ret;
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


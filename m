Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ADD1606A31A
	for <u-boot@archiver.kernel.org>; Sat, 31 Oct 2026 13:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=o+dQIPhe;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ADyMLB4G
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 04CE940AAD;
	Sat, 31 Oct 2026 13:59:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xOv8OKLKROl3; Sat, 31 Oct 2026 13:59:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 9900140A80
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793455192;
	b=HjadWVTIYFJTH0yrUDCCYMd9v2jEx0GQsUoJ+zY0U1gYyay/XewRNkNOwt0cIfb9WPgL
	 +k0ntROgLf0KCT87HvGVRSw47pDtn3s/kE1zd9/IcyhRleylWbOxew9FBrzvrulBsi2iW
	 qldOkeNwEr5f2ymet2TaaSeEIiR2ndUTr1XS8J4radoSn47o6uP2Qf2eNjsHvic/F/j5B
	 3oFh77eVKQjqU9M55pIA6hVNzZ9/Ja2HU+cqNTtKaWcAnOFGZvZacJPVXlsk44UUsXyWr
	 k73Fp8HhQSlC2frmSOQzNtqa5Pc6lhEmqOZGAl7zcvjVdJ52lYjFCzyzxrgssZ+9T+Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793455192;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=wmF3croLpu1cAY2PZLb8WfzgkrQ9dHa3x4v1n5PHljs=;
	b=hpDAPBH1KW9i104PJbyfF1aRBQjgrdjB6uc0Y3CJ2dUOE96yPDufPAJNegtbJY56RT6r
	 Y0prn4P4QdVFbGqVZ3n7UTeTP95wIOAHAzkoUKNU6iariyD8PWLsa8nOKx20Ok6o31AyB
	 J4B2r0iKjtRcIwRJHvqj18iDWi3816gcAzL66F7jhL3FJ3cldTtcX0cy79l+Ujx6dKaii
	 q4hGfz2HAr8Pi9Y5vJAh0sy3g/3U8NUBKdjlAhW8PfkIvbAfPLcSmQDPGQjTUGH4KYcBQ
	 maGdSh8fbMzFJBJOvtHjGrX4UHM4V6Ll//1m0gLWfzDtCA34xYr9mq1yDUlGEjVnalQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793455192;
	bh=wmF3croLpu1cAY2PZLb8WfzgkrQ9dHa3x4v1n5PHljs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=o+dQIPheSpE2Ua3/h5NqDX/jeXbezb/Iu6Ghx3/Q76JUt48+7/NsycLUSpQ8NuO6v
	 ael4PmiRGrF6SVUMyWgYEFIvPRyTL5A6OC6OUj/56rZ+Nj6MdMR2Y/Ca5CCKFUCefn
	 HV4P1tsaL9uxTbxc84a6KYuRij/Bq1wpBH4gMi66mdRqfEZZNGLfAQZNbwq1fRhrQP
	 iGtFVsRelf5QrXTqOMiuAcvaBP9omNDsita+DhJqIZzuQ0JhcPCr+lvu9d1hOv2U8R
	 jAJzOaHVF74xdetcuzYsKu1W1h4pNNuZWkwOaeyeDUgdNnRCWsyizy2D4D4ShSsnWx
	 gVMx/A6VT0sdQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9900140A80;
	Sat, 31 Oct 2026 13:59:52 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id A37EB529
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 06:50:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 89B0560A88
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 06:50:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id L3Vy1DRPlcA5 for <u-boot@lists.u-boot-project.org>;
 Sat, 31 Oct 2026 06:50:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 534AC605F3
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::42b"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793429436;
 b=b3lrkAniD7pu6iM7Apv2+XWSovsSOr5Bx0pLGW2jQAjUbXniLxGvc4OBiIH+psP2rFJ+
 mORrm9hFbKLLEno7sNnhgf9/fFlUiqVp42bScwrILxTvYaB0yNO7QSumVabIuegwQkXZm
 JSeuI5k6yJzTzJWqfL3Hd2JPLB+TeWlrqO2/oODED492EW/fmgLqH17YbgS3gl1hb34/i
 VYLOAf1ZHJTIQQS+XtsDLRIlm4BZ1Yf67XQMkUa08m/ZLdNiYBOR08+01u73rzww1edl7
 5bDnuPkXF0vfNrILjqeMvQ6BHJxjwGwu+gc0ritkqwHmkcd0/5BIFRJkmkTJri/4acg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793429436;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=wmF3croLpu1cAY2PZLb8WfzgkrQ9dHa3x4v1n5PHljs=;
 b=AMnk37+WHFlnczvT/gI0n6X6m/RVOv5pXMFs7leEb7usItbpLwVuuJrgNX9W8cU16KEK
 +ONw858Q1UGzyJrF5fUIwFZt3CIPLV+nGLNMwZeXhziLVCknX2yr+/ZcQI6ixBWN7xZQo
 yMCXb9almtQGqa8VqKNqAOhjk+wEeVQjuwjRdI6C6NHaMe3Fq1f8oIgWB922DkWnCYJhL
 aOzYFbK1j48rxBbV1HKVfE7/7F3ADX8zKGFCGUV7SgWzSOL90c7s+tlMPzo8iPdjzzmFk
 sjQGSHRyDDGdaqk5w5ZUzHv02npvtpsBOu7peth3MwAoH9p9k6KByMpVNYUO8GNylaA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=ADyMLB4G; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::42b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::42b; helo=mail-pf1-x42b.google.com;
 envelope-from=nguyenanhgiau1008@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=ADyMLB4G
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com
 [IPv6:2607:f8b0:4864:20::42b])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 534AC605F3
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 06:50:35 +0000 (UTC)
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-8a070755c8cso677146b3a.0
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 23:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793429434; x=1794034234;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wmF3croLpu1cAY2PZLb8WfzgkrQ9dHa3x4v1n5PHljs=;
 b=ADyMLB4Ge6CKtgffZFJ6EDQAZo+A6EIfahAKeVHIhWPypuxp7y3YZShifks3FFkCW6
 gzG4wAxLjTSWVFXPS3sPwWlX7MvbtBZdIbGkV8YCNmzOQcyz2Fh41//dqXwYoYCNXMIu
 BwwsVmKrED+NX9052ugLi5IsKYB28tpq1lQitPgRZyN3mRwWiqMrDGaXOLPXYT3/NmjT
 PFXSeKgrBY5v6azoWTYPOE00gJFAKy1lo4/iEmhiK/d7ebWRMzMJvQP7i6i/a/tMgZkG
 kXXVImZRryxnT+phRI5Qv6ztoFELcm9thnzgp6zMIvdDzvE5rgH/sfFN5xm70YJMD6MO
 0iqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793429434; x=1794034234;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=wmF3croLpu1cAY2PZLb8WfzgkrQ9dHa3x4v1n5PHljs=;
 b=q2+P0Px1c/XmoplIKSbQ7ekUdeBXi+QOwyK9bsSHXXfbxiLgZQ+n+/pzmv0IugDRL+
 0TODLxlOA1EsQ5I3GjwixVzDv7+pRsv5ykMMMulb+URcP/6TugGbU5yFrqyaJmrG7kUT
 k8qsPNKaT7wbQszZ3quvAJ27Aernav+lGPcZ5wu/MkIF8qSiDUjrYTfJ/ewuBzg9E9K/
 sLpJ+JEQ9mZeVuVZ20Osz0Q+O4M9/X1iQx5kal9U77TYBlctA7cDktOezkHMXm5idgw8
 E1WMyCRNO3KvPVScE+SJxiWOoWWeeMC8MOp03RGP0N+Fpyen2VkkI0tCli6VRo/aWW/Y
 b8dQ==
X-Gm-Message-State: AFq9FYKrEArAwWaon1MgNWYgaAp/0Kwrwy3enKNILZl3lj08hKmQ7GdU
 3Ec94NG7azWg754u9KIH3IYk7VOLCLY8C80utBKKhXTGtLEJbPGBSG17rn5t5RVJ4RDFlQ3d
X-Gm-Gg: AYBFou1hJEv/eJanSLDlAP1xKImwv0/LtRcQdD+NpRcZgBFEisb26rKNLG81u460Ggs
 yzSksaB1YxvUJBqicQ1znGk9cckrQ8d/Q2lN2KlGcpeaMkMZaTXNPx2S7BsfvqqTXw7vLJOkZ2/
 RvYCwbPChuNWStOL1/BRVeY4eION9xePvjxIylRmvcRdgwBRQNm7BTa8hyoahOvg+O5OV5XtlXi
 4jI1K4KD5WT4awfbNcIEoEpD2LkchA1xRLU45G1tFJGw0Ltgq4ct7GxKsPlYfSWsweaBqQotXYg
 /Ly4orl4MXZwPNaHmFiLEoqlETm8VFYCL932nEyePqWkzS1J/T7YDQ2BJMUHHBxWY2f8VueMbjG
 2buwX5CWU+t9tZiKNG9rVBfTGrKBP7EgAxindF2t2h72xper+7HMzz4Y50D8axkP+WmVqx1Dfd5
 YALNcQdk2gCWrOZENGJisM1YF3UmZOFGk9Bgr0F+KFVyQcKMhOlRRNXmub2Avz9jTaUADiS9Hez
 ka5lEF5/k2IviQRF0z3ZYMTkZf2pNzXDAXAIHXbClS651qcRg+6w/ULIjIrjDkKjR6Sox9kvRDd
 DuyNshEcyZk/4s82CiwFNJLVhngkNCLuHE02ESq888XZVJQmb/FqZ/XhBGV/
X-Received: by 2002:a05:6a00:189f:b0:881:9f52:ca00 with SMTP id
 d2e1a72fcca58-8a9bfbf4cffmr3721389b3a.42.1793429434224; 
 Fri, 30 Oct 2026 23:50:34 -0700 (PDT)
Received: from R3700x.lan ([2405:4803:217b:bca0:ad34:6cfa:d8f0:6fd3])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8aad963d6acsm575070b3a.18.2026.10.30.23.50.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 23:50:33 -0700 (PDT)
From: Giau Nguyen <nguyenanhgiau1008@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: hs@nabladev.com, mbrugger@suse.com, pbrobinson@gmail.com,
 trini@konsulko.com, Giau Nguyen <nguyenanhgiau1008@gmail.com>
Subject: [PATCH v3] i2c: bcm2835: Add new BCM2835/BCM2711 I2C controller driver
Date: Sat, 31 Oct 2026 13:50:06 +0700
Message-Id: <20261031065006.343477-1-nguyenanhgiau1008@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261028113005.515786-1-nguyenanhgiau1008@gmail.com>
References: <20261028113005.515786-1-nguyenanhgiau1008@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 31 Oct 2026 13:59:48 +0000
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
(based on Linux commit 32a0a94aa09e ("i2c: Switch back to struct platform_driver::remove()")).

The driver dynamically queries the actual VPU core clock rate from
the VideoCore firmware via mailbox property messages to calculate
the CDIV clock divider, ensuring accurate I2C timing and baud rates
on BCM2711.

Enable CONFIG_SYS_I2C_BCM2835 in rpi_4_defconfig.

Reviewed-by: Heiko Schocher <hs@nabladev.com>
Signed-off-by: Giau Nguyen <nguyenanhgiau1008@gmail.com>
---
v3:
 - Added the Linux commit ID to the commit message.
 - Fixed alphabetical sorting of CONFIG_SYS_I2C_BCM2835 in drivers/i2c/Makefile.
 - Added Reviewed-by tag from Heiko.

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
index 8c6c0c2a4bc..3260024a736 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -215,6 +215,7 @@ F:	arch/arm/dts/bcm283*
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
index 4993c0bdb81..74f847c5e54 100644
--- a/arch/arm/mach-bcm283x/msg.c
+++ b/arch/arm/mach-bcm283x/msg.c
@@ -115,6 +115,28 @@ int bcm2835_get_mmc_clock(u32 clock_id)
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
index f5fb322aa8f..2ddaf003558 100644
--- a/configs/rpi_4_defconfig
+++ b/configs/rpi_4_defconfig
@@ -22,6 +22,7 @@ CONFIG_MISC_INIT_R=y
 CONFIG_SYS_PROMPT="U-Boot> "
 CONFIG_CMD_DFU=y
 CONFIG_CMD_GPIO=y
+CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_PCI=y
 CONFIG_CMD_USB=y
@@ -34,6 +35,9 @@ CONFIG_DM_DMA=y
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
index 52067fa7c1f..1b26906e403 100644
--- a/drivers/i2c/Kconfig
+++ b/drivers/i2c/Kconfig
@@ -164,6 +164,16 @@ config SYS_I2C_AT91
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
index bebd728e7da..aac6ce4b6e0 100644
--- a/drivers/i2c/Makefile
+++ b/drivers/i2c/Makefile
@@ -14,6 +14,7 @@ obj-$(CONFIG_$(XPL_)SYS_I2C_LEGACY) += i2c_core.o
 obj-$(CONFIG_SYS_I2C_ASPEED) += ast_i2c.o
 obj-$(CONFIG_SYS_I2C_AST2600) += ast2600_i2c.o
 obj-$(CONFIG_SYS_I2C_AT91) += at91_i2c.o
+obj-$(CONFIG_SYS_I2C_BCM2835) += i2c-bcm2835.o
 obj-$(CONFIG_SYS_I2C_CADENCE) += i2c-cdns.o
 obj-$(CONFIG_SYS_I2C_CA) += i2c-cortina.o
 obj-$(CONFIG_SYS_I2C_DAVINCI) += davinci_i2c.o
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


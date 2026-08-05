Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ED8EC55174
	for <u-boot@archiver.kernel.org>; Wed,  5 Aug 2026 13:21:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7B824607D5;
	Wed,  5 Aug 2026 13:21:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 62_Wj_52P11X; Wed,  5 Aug 2026 13:21:53 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 08524607B4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785936113;
	bh=qymroRTTEpNJSYBU+p1HMeV3CuruNz/S0kU/ZY7OILQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CeTQq0KIG2RF0+0uBQjzDMZGBQfULupAhDMmbdmVBzkQM7d+xdZ93iHe19wsWFd8F
	 VpDS2KpToHUF/fjr/druI6WVpuSbpKGfQthLQpRuPjWtkKrKfOUvS6OXVc1qM/mkl/
	 7SKY56t9KSZCGHqUOejjCDN6MFjs/kYAs6llheAWSRI00q/b6baizEqQ4WRv9jOFsb
	 oWHeC7vhY7I0hgvgm7Mq0zqcqgo5GWzEkEvIrLgg9fcNQhMuOH7Mq4qmB4YQi1ledN
	 quH8K+87slWfSy4dtSHtQnfGVloqFZ/VsK3sghiHkGAQofvEcGmqUVlboboxv3uJs2
	 OxfoXCK7KFkjg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 08524607B4;
	Wed,  5 Aug 2026 13:21:53 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 01DE6397
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 13:21:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E6F7B406A1
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 13:21:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id m2Bj4hnHN2Mr for <u-boot@lists.u-boot-project.org>;
 Wed,  5 Aug 2026 13:21:49 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a0a:51c0:0:12e:550::1; helo=galois.linutronix.de;
 envelope-from=gregor.herburger@linutronix.de; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 3B7954068E
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3B7954068E
Received: from galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a0a:51c0:0:12e:550::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3B7954068E
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 13:21:48 +0000 (UTC)
From: Gregor Herburger <gregor.herburger@linutronix.de>
Date: Wed, 05 Aug 2026 15:21:40 +0200
Subject: [PATCH v4 1/2] rpi: set boot partition from devicetree
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260805-tryboot2-v4-1-6e6d755222a5@linutronix.de>
References: <20260805-tryboot2-v4-0-6e6d755222a5@linutronix.de>
In-Reply-To: <20260805-tryboot2-v4-0-6e6d755222a5@linutronix.de>
To: u-boot@lists.u-boot-project.org
Cc: Matthias Brugger <mbrugger@suse.com>, 
 Peter Robinson <pbrobinson@gmail.com>, Tom Rini <trini@konsulko.com>, 
 =?utf-8?q?Filip_Kokosi=C5=84ski?= <filip.kokosinski@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Gregor Herburger <gregor.herburger@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785936106; l=1357;
 i=gregor.herburger@linutronix.de; s=20260226; h=from:subject:message-id;
 bh=4+bM65tNui9B6ZZpfMJj/iUKxmOuDh9UNLJF+ikkIho=;
 b=3wGCIwlVVvAb27yKaND5gm5Zkdg6kIH5j/SznBmw5o5mHbonfGoyPuUN1FwdJ8kI3w3V+m5Gd
 xkx9bm8PgK1DIETnj5ufuDPm+DTzIq6enMMZlcSU61kH1Lr9KVZngRf
X-Developer-Key: i=gregor.herburger@linutronix.de; a=ed25519;
 pk=u72Lv7+/lS5CC1hmSrb17lv/6CK7HBh4Lvz77PHA5LM=
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linutronix.de; s=2020; t=1785936106;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qymroRTTEpNJSYBU+p1HMeV3CuruNz/S0kU/ZY7OILQ=;
 b=LOb6XcsOcBYBK26+mmkFD2kUmeW3mS4u9PsQ3aPMzkWtNIPpXgo/oOjQ0WVrElAt6mPbjE
 Uy6XM6V9QiJA3Zi5odaged3WNjFhvk6ISrP1v2c2x9zA4H0ugrAyLbVK+DSbTu3JOSG14d
 Wjj0Blxd5tg/dAOxl7kjWkvxD7GhJ1YwSkrqggjy9awsTLgOVYwCMDHeE52TjP28lkm67h
 UBSVHZnZ9zRXnLCtH9QXBWuVNjDfTqV6/2q5A7JBhtyRJdrfbB4z0BPfUZXBUiH2cbM2GP
 FPTfsCdHsTjX2KOLj8gC3FBoZm7uXudAvKjP/KtCAJu0wdLzLEay6ZKgy9o+/Q==
X-Mailman-Original-DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=linutronix.de; s=2020e; t=1785936106;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qymroRTTEpNJSYBU+p1HMeV3CuruNz/S0kU/ZY7OILQ=;
 b=7D2cibifUpAuA62EJKbvlvBMrm+PnHskWgEEQXz8v7Cfq+QkVeZy2W6v4eoYe7eOUqlok0
 yNcnx838U6sZrAAw==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=linutronix.de
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de
 header.a=rsa-sha256 header.s=2020 header.b=LOb6XcsO; 
 dkim=pass header.d=linutronix.de header.i=@linutronix.de
 header.a=ed25519-sha256 header.s=2020e header.b=7D2cibif
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

The Raspberry Pi has the "tryboot" feature where it can boot from a
different partition enabling failsafe A/B updates. After boot the
firmware sets 'partition' property in /chosen/bootloader.

Set the env variable boot_partition accordingly to allow boards to
create a bootcmd based on the boot partition.

Signed-off-by: Gregor Herburger <gregor.herburger@linutronix.de>
Tested-by: Peter Robinson <pbrobinson@gmail.com>
---
 board/raspberrypi/rpi/rpi.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/board/raspberrypi/rpi/rpi.c b/board/raspberrypi/rpi/rpi.c
index 1da5df92351c..8354fec833cc 100644
--- a/board/raspberrypi/rpi/rpi.c
+++ b/board/raspberrypi/rpi/rpi.c
@@ -480,6 +480,20 @@ static void set_serial_number(void)
 	env_set("serial#", serial_string);
 }
 
+static void set_boot_partition_fdt(void)
+{
+	void *fdtp = (void *)gd->fdt_blob;
+	u32 partition;
+
+	partition = fdt_getprop_u32_default(fdtp, "/chosen/bootloader", "partition", 1);
+	if (!partition) {
+		printf("Failed to the get partition property.\n");
+		return;
+	}
+
+	env_set_ulong("boot_partition", partition);
+}
+
 int misc_init_r(void)
 {
 	set_fdt_addr();
@@ -489,6 +503,7 @@ int misc_init_r(void)
 	set_board_info();
 #endif
 	set_serial_number();
+	set_boot_partition_fdt();
 
 	return 0;
 }

-- 
2.47.3


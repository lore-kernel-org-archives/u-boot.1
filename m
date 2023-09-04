Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3574BC71153
	for <u-boot@archiver.kernel.org>; Mon,  4 Sep 2023 11:23:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 26376868FC;
	Mon,  4 Sep 2023 13:23:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="PDzG0S8v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4FDBA864C5; Mon,  4 Sep 2023 13:23:25 +0200 (CEST)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A0C08682C
 for <u-boot@lists.denx.de>; Mon,  4 Sep 2023 13:23:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.. (unknown [46.114.152.14])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id F16CE43CDA; 
 Mon,  4 Sep 2023 11:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1693826602;
 bh=0XeCeD1RlE0XZG9l6PTKVbXwVjy5VCkmhusvgu1LtFo=;
 h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
 MIME-Version;
 b=PDzG0S8voB4HkuHL3PU/vEkMd2kZ9UQSehzy7SN/eGhz3e9Cb1YK0Vbi/U56HBU+b
 S6xDdi4gYOB0M7vl1PR20MWosBtYMPueiOiD4fvVkzQe9Tq+nxLclE0PSoOY5fBPbB
 0LFB6maK0jhi6t3PlNhOou88OBrPsnebTQzcL0je0+pQYFPMlu1ZSd8x9F4MQzwfZP
 XY8FY8LsEAafrySTOz+5lSMmUel0ngHFJPrKElbjJPbyoM1xkXz8WglXNevPxeDkMi
 9G2VHPrvXdWjy8tfFkWAO8QAVO/gomU7hTOwnDLsdAvCzBtj3LnmEj1Vm+XsPXzWbf
 DdQDRvm985d2w==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Rick Chen <rick@andestech.com>,
	Leo <ycliang@andestech.com>
Cc: Bin Meng <bmeng.cn@gmail.com>, Anup Patel <apatel@ventanamicro.com>,
 Chanho Park <chanho61.park@samsung.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 1/2] risc-v: implement DBCN write byte
Date: Mon,  4 Sep 2023 13:24:03 +0200
Message-Id: <20230904112404.81899-2-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230904112404.81899-1-heinrich.schuchardt@canonical.com>
References: <20230904112404.81899-1-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The DBCN extension provides a Console Write Byte call.
Implement function sbi_dbcn_write_byte to invoke it.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Reviewed-by: Leo Yu-Chi Liang <ycliang@andestech.com>
---
v2:
	no change
---
 arch/riscv/include/asm/sbi.h |  1 +
 arch/riscv/lib/sbi.c         | 16 ++++++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
index 009a26885c..bf4c9af622 100644
--- a/arch/riscv/include/asm/sbi.h
+++ b/arch/riscv/include/asm/sbi.h
@@ -170,5 +170,6 @@ int sbi_get_mvendorid(long *mvendorid);
 int sbi_get_marchid(long *marchid);
 int sbi_get_mimpid(long *mimpid);
 void sbi_srst_reset(unsigned long type, unsigned long reason);
+int sbi_dbcn_write_byte(unsigned char ch);
 
 #endif
diff --git a/arch/riscv/lib/sbi.c b/arch/riscv/lib/sbi.c
index 8724e3a460..55a3bc3b5c 100644
--- a/arch/riscv/lib/sbi.c
+++ b/arch/riscv/lib/sbi.c
@@ -204,6 +204,22 @@ void sbi_srst_reset(unsigned long type, unsigned long reason)
 		  0, 0, 0, 0);
 }
 
+/**
+ * sbi_dbcn_write_byte() - write byte to debug console
+ *
+ * @ch:		byte to be written
+ * Return:	SBI error code (SBI_SUCCESS = 0 on success)
+ */
+int sbi_dbcn_write_byte(unsigned char ch)
+{
+	struct sbiret ret;
+
+	ret = sbi_ecall(SBI_EXT_DBCN,
+			SBI_EXT_DBCN_CONSOLE_WRITE_BYTE,
+			ch, 0, 0, 0, 0, 0);
+	return ret.error;
+}
+
 #ifdef CONFIG_SBI_V01
 
 /**
-- 
2.40.1


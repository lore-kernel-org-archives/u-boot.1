Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AA95EE4993
	for <u-boot@archiver.kernel.org>; Sat, 19 Aug 2023 13:12:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D1FDD87002;
	Sat, 19 Aug 2023 15:12:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="vhk5ilI1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6131B807B4; Sat, 19 Aug 2023 15:12:35 +0200 (CEST)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A891D86FF7
 for <u-boot@lists.denx.de>; Sat, 19 Aug 2023 15:12:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-062-143-244-162.um16.pools.vodafone-ip.de
 [62.143.244.162])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 26D88400A8; 
 Sat, 19 Aug 2023 13:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1692450751;
 bh=IpbzGsl77TJXLiiObJU2DElmf9aUzoDwcOoBMMbioXQ=;
 h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
 MIME-Version;
 b=vhk5ilI15lPHU3O2lPlutnHHBRsLTBXpxuyZX1joH6/ZTXDOiF1bKM798SasboEEN
 Kj1WhTM4778HN02B/A465jFa17NZk6ntGHrX2FTKLNKEd072mSRqPDqF5dQtkxkL6L
 lfnJxCl33Y3QRbnb2dldkZARbugxluvn6kHit8kLhVxn8sXy3uuoUGd2mr6p43Qb5n
 yO37r3kyFikMEPk2qxniE623+fnHU49bZtOCJgoEkIFd65uPgxBalfDyi6r61o+n7B
 AFcjx1/T/QXFwdQ9wGoomgDFBKsDySoYZkvu8aUgv4rh6OcMMYRHJ4He/iBvEuD2EQ
 BUcrWYhVxFhyA==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Rick Chen <rick@andestech.com>,
	Leo <ycliang@andestech.com>
Cc: Bin Meng <bmeng.cn@gmail.com>, Anup Patel <apatel@ventanamicro.com>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/2] risc-v: implement DBCN write byte
Date: Sat, 19 Aug 2023 15:12:49 +0200
Message-Id: <20230819131250.10251-2-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230819131250.10251-1-heinrich.schuchardt@canonical.com>
References: <20230819131250.10251-1-heinrich.schuchardt@canonical.com>
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


Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8573F606A320
	for <u-boot@archiver.kernel.org>; Thu, 19 Nov 2026 15:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=eUv5V3ZG
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D5A8060DA8;
	Thu, 19 Nov 2026 15:20:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5Mm36cmgN3Jb; Thu, 19 Nov 2026 15:20:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 1263A60AA2
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795101648;
	b=V6JipflZVIEJkJMRPHb7V4ZX6fTcT0SXZU4hB4dpSxzSgIzWvrcGmZknu7ydPnsii5Ib
	 QnLv8KktqZ9OB6rXeN8t5f2y/gDKNQWqYIxxbpjLm0waOQtb8pZDRBRppTwdidVfd0Unq
	 XnIDAsQIZTTkXEBMHPdAOwywnQcaCxZ6dFqTb0uZkVcwoDKlTWseuJ4HRQMF+9hfacbmx
	 xM46Qc1LkdjtN4u21qseK3dydWsFqS28Uy/J/tWlsyobwD6vToYZTPoKvo7JsUmrcx2Ro
	 ZZ3PqdkWZAbrWziED38MmxHkNQ0N6AYBmdnJxwmdfALoDERri4ekNrKnbSF7GdfkXPQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795101648;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:From:
	 Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=ar8NJqmmpkMijTsDv5n/AuD5XnztuGBM8bD6vOfYZZ4=;
	b=YmD4cCPQSRUCUXxSwZRa2oYMvXcUAdmQkcOCKp5Y1eZe/lk7ABeLC86GK7VPnQQ94zZF
	 R/aNfB9cNX352kdYueUElshrW1OWZVj//qWyk7gHGPs2dca6bAf6UX5pDvYQErXmpmJz1
	 BdbqmqCcfsjX/Mt/ejQZbwKczl9djyH8PxeEPRRv97DqHeiJoEmA8iJZNVyFX4sBtYL2W
	 VHQaq2Qoc3yb+lCxFHeTAtQXPQrw5pFWYcxiX7fGs2krqf5dlUyamnbuRwmqgao8skV7k
	 5ySwyu0RItWZe8Xc+SpVEnPjEaGVlzHie9V16bE7RjcVkzqgJYz8ujVN3JAZFghU+cA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=dave.eu;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795101648;
	bh=ar8NJqmmpkMijTsDv5n/AuD5XnztuGBM8bD6vOfYZZ4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eUv5V3ZGlUJuBgNiCDSnSw4VVlF/qeTt4T206V2WBKDzcvqcrpb1RngbDT4iWMuw3
	 X/A+BwJYKT5U19pMMErAaOBrkPxYYX9xR7883SA4RtqppEME+hft2kbnqdQdKnZfZa
	 fRi/4Ix4M/JQKnUi0Is67ZPPxAZCjL9Z2SSuCLWldvSlJOH9hs3lRnOdLrGoxuSrjJ
	 q9Rktw0VTECL4E6APdw31xb5G+oNtDmP5ce/8/dBlIPBynrtrY/uTwxTkXcwQL7Z8F
	 D1abvnKkIU+7m75bCv9VlS5TM54HPfEHa4a86y1PRVpTUmh8KpFolsONZ3d25gZmwK
	 yUwajo1O5IRhg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1263A60AA2;
	Thu, 19 Nov 2026 15:20:48 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id F28B3465
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 15:20:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E428160ADF
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 15:20:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GzzXypYa3rIH for <u-boot@lists.u-boot-project.org>;
 Thu, 19 Nov 2026 15:20:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 811A760686
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=31.223.242.245
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=31.223.242.245;
 helo=mx.dave-tech.it; envelope-from=andrea.scian@dave.eu; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=dave.eu
Received: from mx.dave-tech.it (mx.dave-tech.it [31.223.242.245])
 by smtp3.osuosl.org (Postfix) with ESMTP id 811A760686
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 15:20:43 +0000 (UTC)
Received: from [127.0.1.1] (unknown [192.168.0.244])
 by mx.dave-tech.it (Postfix) with ESMTP id 944D02017A;
 Thu, 19 Nov 2026 16:15:35 +0100 (CET)
From: Andrea Scian <andrea.scian@dave.eu>
Date: Thu, 19 Nov 2026 16:15:23 +0100
Subject: [PATCH 2/7] zynq: rsa: keep the PPK lookup inside OCM
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261119-b4-zynq-rsa-v1-2-62ed5f983d1e@dave.eu>
References: <20261119-b4-zynq-rsa-v1-0-62ed5f983d1e@dave.eu>
In-Reply-To: <20261119-b4-zynq-rsa-v1-0-62ed5f983d1e@dave.eu>
To: Michal Simek <michal.simek@amd.com>, 
 Siva Durga Prasad Paladugu <siva.durga.prasad.paladugu@amd.com>, 
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Andrea Scian <andrea.scian@dave.eu>
X-Mailer: b4 0.14.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

zynq_extract_ppk() locates the FSBL's certificate at OCM base plus
fsbl_len, and fsbl_len is read from the boot header of the image under
verification. The sum is not bounded and wraps in 32 bits: with
fsbl_len = 0x10040000 the "PPK from OCM" is read from 0x10000000, which
can be the image itself. The image then supplies the key it is checked
against, and the previous fix is bypassed.

Reject an fsbl_len that would put any part of the PPK outside the
256 KiB of OCM.

Fixes: 37e3a36a5475 ("xilinx: zynq: Add support to secure images")
Signed-off-by: Andrea Scian <andrea.scian@dave.eu>
---
 board/xilinx/zynq/cmds.c | 39 +++++++++++++++++++++++++++++++--------
 1 file changed, 31 insertions(+), 8 deletions(-)

diff --git a/board/xilinx/zynq/cmds.c b/board/xilinx/zynq/cmds.c
index f63a3e55410..8a3b2fc41ad 100644
--- a/board/xilinx/zynq/cmds.c
+++ b/board/xilinx/zynq/cmds.c
@@ -39,6 +39,17 @@ DECLARE_GLOBAL_DATA_PTR;
 #define ZYNQ_RSA_MAGIC_WORD_SIZE		60
 #define ZYNQ_RSA_PART_OWNER_UBOOT		1
 #define ZYNQ_RSA_ALIGN_PPK_START		64
+/* End of the PPK in the FSBL's certificate, from its 64-byte aligned start */
+#define ZYNQ_RSA_PPK_END	(ZYNQ_RSA_HEADER_SIZE + \
+				 ZYNQ_RSA_MAGIC_WORD_SIZE + \
+				 ZYNQ_RSA_MODULAR_SIZE + \
+				 ZYNQ_RSA_MODULAR_EXT_SIZE)
+
+/*
+ * OCM, mapped high (0xFFFC0000 - 0xFFFFFFFF) by the time U-Boot runs. The
+ * FSBL and its certificate are still there.
+ */
+#define ZYNQ_OCM_SIZE		0x40000
 
 #define WORD_LENGTH_SHIFT	2
 
@@ -69,21 +80,26 @@ static struct partition_hdr part_hdr[ZYNQ_MAX_PARTITION_NUMBER];
 /*
  * Extract the primary public key components from already autheticated FSBL
  */
-static void zynq_extract_ppk(u32 fsbl_len)
+static int zynq_extract_ppk(u32 fsbl_len)
 {
-	u32 padsize;
+	u32 offset;
 	u8 *ppkptr;
 
 	debug("%s\n", __func__);
 
 	/*
-	 * Extract the authenticated PPK from OCM i.e at end of the FSBL
+	 * Extract the authenticated PPK from OCM i.e at end of the FSBL.
+	 * fsbl_len comes from the image under verification: keep the whole
+	 * certificate inside OCM, or the PPK would be read from wherever the
+	 * image points it, the image itself included.
 	 */
-	ppkptr = (u8 *)(fsbl_len + ZYNQ_OCM_BASEADDR);
-	padsize = ((u32)ppkptr % ZYNQ_RSA_ALIGN_PPK_START);
-	if (padsize)
-		ppkptr += (ZYNQ_RSA_ALIGN_PPK_START - padsize);
+	if (fsbl_len > ZYNQ_OCM_SIZE)
+		goto err;
+	offset = ALIGN(fsbl_len, ZYNQ_RSA_ALIGN_PPK_START);
+	if (offset > ZYNQ_OCM_SIZE - ZYNQ_RSA_PPK_END)
+		goto err;
 
+	ppkptr = (u8 *)(ZYNQ_OCM_BASEADDR + offset);
 	ppkptr += ZYNQ_RSA_HEADER_SIZE;
 
 	ppkptr += ZYNQ_RSA_MAGIC_WORD_SIZE;
@@ -91,6 +107,12 @@ static void zynq_extract_ppk(u32 fsbl_len)
 	memcpy(ocm_ppk_modular, ppkptr, ZYNQ_RSA_MODULAR_SIZE);
 	ppkptr += ZYNQ_RSA_MODULAR_SIZE;
 	memcpy(ocm_ppk_modularex, ppkptr, ZYNQ_RSA_MODULAR_EXT_SIZE);
+
+	return 0;
+
+err:
+	printf("INVALID_FSBL_LENGTH\n");
+	return -1;
 }
 
 /*
@@ -301,7 +323,8 @@ static int zynq_verify_image(u32 src_ptr)
 	if (!(efuseval & ZYNQ_EFUSE_RSA_ENABLE_MASK))
 		return -1;
 
-	zynq_extract_ppk(fsbl_len);
+	if (zynq_extract_ppk(fsbl_len))
+		return -1;
 
 	partitioncount = zynq_get_part_count(&part_hdr[0]);
 

-- 
2.50.1


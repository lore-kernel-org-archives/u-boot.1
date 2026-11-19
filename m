Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C2B606A320
	for <u-boot@archiver.kernel.org>; Thu, 19 Nov 2026 15:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=SpA/vLOz
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7AE9D60DDF;
	Thu, 19 Nov 2026 15:20:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dJZrpgxtd1Fa; Thu, 19 Nov 2026 15:20:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 94CB960DC7
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795101658;
	b=em0K8lFmMC25ieQ/kQidEnIC9IrJKKJqPQmDPkwEMUygbb2Q+R3ZHtkTWZXnJoX8lcGJ
	 cYq1ep4fMI2dfHpzpzvdRLm/Z5cON4GcZNF/aIOLfzG25X0loTZ4R0N7EhmuEu9bzhlP0
	 Ya9jM9VTLz0HhPvDhxDSeOQRakNalfUQqOrLKtA8AzT5RPyihSp+XuwoS+z8sTzDfw0+x
	 o84h/mskuN4SGsKapfRO1Ny9WCA3l+cveDXhM6VIhpGs+OxiNbv9P8tvBrBeQsVFgSzF8
	 SB8ZVWbKk1JFOFlJY3oLDh4X0wDUSlVYpa/JhdwUEs0YGaIXwIsp5rDbt17nNgO+0dA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795101658;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:From:
	 Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=7oDdtYJgAm/CoMcALADIWgJNR98JXFm0lTy504vFHXg=;
	b=BKs9Ha6MkNTAAexCkOM/aRkOSvafKHS8DiqdpVa67fi1dn6Ik7qBBmbu6HPcP53BMhlJ
	 KMA8K+cGOgSWR4nqAycSw1/Sf7SBcXt0jWGgQT4FHh5t+u0fQYQIDfeYMOxNdoJli8Skz
	 dpMlWdIJ84HnRP6q9fqC/8IEQzclQ1mMcCVRKh7SuzDMJh6UXtGe9aJNWQWLgbYH0CMJ2
	 O6alIcUS7EV7mouAx9hqYo3DLzss2/HLqI3tXyVEb8vSsF4qTxzGMPPnqMnSrHewso1EB
	 Tj8TPIj4YEK7If6E0C5pBgLXGQGV+mKNTdQ3VYyMdFST7JnLQ3sVr/wFtnGf+ER0CNg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795101658;
	bh=7oDdtYJgAm/CoMcALADIWgJNR98JXFm0lTy504vFHXg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SpA/vLOzF0k/NWp3NSJdFLnxuWrW2wMrEipTSPtt5XPdhXeVakS3QiP9BCxg3aard
	 3aMQ9QBmF/e1i7/MQMg3fcgNbThXexj0cYImBDtMtFf0tciiFH8kKlNwExjv+MnxlU
	 MUKdhWt5nK0VFvVlOB43f+7tqWGyI3ajBbRtPStK/iqp7lZITxzIpTauvebNUdgkH9
	 ApqPM2P/VjI4Vka5/nlmuiKhsrIpkhM9/RMNM0dW0Pho01P4zPHZRxQiz1PpncbKtC
	 GpDZZgWavBosYXVsUZLix41SrYzLOZuEM+fEn0MK5SsbYQ8llVEFVrSVM42lN6vYSK
	 tddYdzu8YL2Gg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 94CB960DC7;
	Thu, 19 Nov 2026 15:20:58 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 871E8A32
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 15:20:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 74F2B40573
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 15:20:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jRvWfShsOv4S for <u-boot@lists.u-boot-project.org>;
 Thu, 19 Nov 2026 15:20:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 810D640556
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=31.223.242.245
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=31.223.242.245;
 helo=mx.dave-tech.it; envelope-from=andrea.scian@dave.eu; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=dave.eu
Received: from mx.dave-tech.it (mx.dave-tech.it [31.223.242.245])
 by smtp2.osuosl.org (Postfix) with ESMTP id 810D640556
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 15:20:43 +0000 (UTC)
Received: from [127.0.1.1] (unknown [192.168.0.244])
 by mx.dave-tech.it (Postfix) with ESMTP id A98F120182;
 Thu, 19 Nov 2026 16:15:35 +0100 (CET)
From: Andrea Scian <andrea.scian@dave.eu>
Date: Thu, 19 Nov 2026 16:15:28 +0100
Subject: [PATCH 7/7] zynq: rsa: fail if no partition was authenticated
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261119-b4-zynq-rsa-v1-7-62ed5f983d1e@dave.eu>
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

Partitions not owned by U-Boot are skipped, and the loop then falls
through to 'return 0'. The owner field is in the unauthenticated
partition header, so an image whose partitions are all marked as owned
by someone else is reported as verified, with nothing checked.

Count the authenticated partitions and fail if there are none.

Fixes: 37e3a36a5475 ("xilinx: zynq: Add support to secure images")
Signed-off-by: Andrea Scian <andrea.scian@dave.eu>
---
 board/xilinx/zynq/cmds.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/board/xilinx/zynq/cmds.c b/board/xilinx/zynq/cmds.c
index af6cc707011..3e4437d687b 100644
--- a/board/xilinx/zynq/cmds.c
+++ b/board/xilinx/zynq/cmds.c
@@ -299,6 +299,7 @@ static int zynq_verify_image(u32 src_ptr)
 {
 	u32 silicon_ver, image_base_addr, status;
 	u32 partition_num = 0;
+	u32 authenticated = 0;
 	u32 efuseval, srcaddr, size, fsbl_len;
 	struct partition_hdr *hdr_ptr;
 	u32 part_data_len, part_img_len, part_attr;
@@ -439,6 +440,7 @@ static int zynq_verify_image(u32 src_ptr)
 			return -1;
 		}
 		debug("Authentication Done\n");
+		authenticated++;
 
 		if (encrypt_part_flag) {
 			debug("DECRYPTION\n");
@@ -463,6 +465,16 @@ static int zynq_verify_image(u32 src_ptr)
 		partition_num++;
 	}
 
+	/*
+	 * Partitions not owned by U-Boot are skipped, and the owner field is
+	 * not authenticated: an image may mark them all so. Do not report
+	 * success when nothing was verified.
+	 */
+	if (!authenticated) {
+		printf("NO_AUTHENTICATED_PARTITION\n");
+		return -1;
+	}
+
 	return 0;
 }
 

-- 
2.50.1


Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87481606A334
	for <u-boot@archiver.kernel.org>; Thu, 19 Nov 2026 15:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=qcs/ufNr
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5F79060DCD;
	Thu, 19 Nov 2026 15:20:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ufh3tkt8WpOL; Thu, 19 Nov 2026 15:20:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 97B9B60DA7
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795101653;
	b=eshNVR/TOle8eMuX6kL7kkRz3/9gkuu8IFzFf8mmVF9w/+fF/P6rMzQheFQ8r+uewEyG
	 3HF2EBaLe2x+4VPTuM3pi35RLYuYruI7T358f7veVMqzrdwD1tJvIrE8dXQBrUSD9S21t
	 yd/XT5xRHF+Ptv2JhlroQH46wBJd8AxgC/2Z9gMc7FG2pwuolaOFLZAJ1nb9wj41zkwfu
	 Con3i8aLK7zHsIwGyEPRZJ++dI5xnSO+LR8xMZ7i4V6KwgIA5zQR1F6AHm5FQ/EEnxJZa
	 D431IMRmmuMIMcyER7kvNPoP0QuzQ1/e5chfufJGENaVmDUp575oz7E9LfB7VdMVsvA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795101653;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:From:
	 Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=qPPmEMJKTLhoqrRwoye1pje81Eo4yXJL5A2IbMNxaTw=;
	b=eoYi2IX1OnE5iMpo0idptyi6tS9WpxvJ8yaLNLoD33kUE9MBifGJg7LIPk0e/XxX+Hyv
	 MvOEK8EWLLS5okDlgzz4/34r8+fKIUSCQwrSW5JnBPe3PFZ5lVPUKnjyUHStTLGSEzVn7
	 l6txnkzlDhL6OEvMqTSCuD4onHZBeS+IpptwEvuiYu/BFknKx+aP7soVtAvq8MClqlEKu
	 GyPugusywVFjhwtDnnTdmYSHpDA0Fu1UdUNhkrb+tvq54H+G3goELLWejF/hzUWZuPuSK
	 cPL1eHuEy1/sO7VPykF95IlLeoSXVhhH2JXZY7KJvL96MobAazgMftDedlfKO7BPqiw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795101653;
	bh=qPPmEMJKTLhoqrRwoye1pje81Eo4yXJL5A2IbMNxaTw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qcs/ufNrCqgx5YTult77W9lz5iLN+s9D0aL74dL2/WnQFYW9y4RRCRLE8pHvKcoU5
	 CgQucKRyL36dRELqU9DYz5t5G8rzKG4ofReZ7nHcAa4QfbmEyPdIO0XBg4jZ5W4mhI
	 ZqfCfogg2HKYXDsUk/WuPkzL3ltP2IDwjuycicmwr41xYR2xJ7MLUkDAkqgZ7DoQG5
	 H1EUiG5fGQNlrFFkobG14Kxav7W3WkHSjiZn2D8KSBGPEv3MGW6TCAFkt0DHdVbQA6
	 2LQyFiYyqJb9A6FFCLlkIr2OwaWDTKatyp3+qOLNoG1O9LgDTxC3LfKDt5nkDvWVu3
	 U118m/QN4a7gw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 97B9B60DA7;
	Thu, 19 Nov 2026 15:20:53 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 5BD6A2FB
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 15:20:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4E3D38138E
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 15:20:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7HBXfmU37mP2 for <u-boot@lists.u-boot-project.org>;
 Thu, 19 Nov 2026 15:20:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 855EE81371
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=31.223.242.245
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=31.223.242.245;
 helo=mx.dave-tech.it; envelope-from=andrea.scian@dave.eu; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=dave.eu
Received: from mx.dave-tech.it (mx.dave-tech.it [31.223.242.245])
 by smtp1.osuosl.org (Postfix) with ESMTP id 855EE81371
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 15:20:43 +0000 (UTC)
Received: from [127.0.1.1] (unknown [192.168.0.244])
 by mx.dave-tech.it (Postfix) with ESMTP id A0DC120180;
 Thu, 19 Nov 2026 16:15:35 +0100 (CET)
From: Andrea Scian <andrea.scian@dave.eu>
Date: Thu, 19 Nov 2026 16:15:26 +0100
Subject: [PATCH 5/7] zynq: rsa: fix the load-address bounds check
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261119-b4-zynq-rsa-v1-5-62ed5f983d1e@dave.eu>
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

	if (load < dram_start && load + part_data_len > dram_end)

With '&&' this never rejects anything: PS DDR starts at 0, so no u32
load address is below dram_start, the first operand is always false,
and OCM, the SLCR and the PS peripherals were all accepted as
destinations. The length is also wrong: part_data_len is a word count,
while the copy moves 'size' bytes, and the sum can wrap.

Check that the 'size' bytes copied lie inside PS DDR, in a form that
cannot wrap. PL images are exempt: they are not copied.

Fixes: 37e3a36a5475 ("xilinx: zynq: Add support to secure images")
Signed-off-by: Andrea Scian <andrea.scian@dave.eu>
---
 board/xilinx/zynq/cmds.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/board/xilinx/zynq/cmds.c b/board/xilinx/zynq/cmds.c
index ac72ad81e81..44ad5442577 100644
--- a/board/xilinx/zynq/cmds.c
+++ b/board/xilinx/zynq/cmds.c
@@ -385,13 +385,16 @@ static int zynq_verify_image(u32 src_ptr)
 			  (part_start_addr << WORD_LENGTH_SHIFT);
 
 		/*
-		 * This validation is just for PS DDR.
+		 * The partition is copied to its load address, so check
+		 * that the bytes copied fit in PS DDR, without wrapping.
+		 * PL images are not copied.
 		 * TODO: Update this for PL DDR check as well.
 		 */
-		if (part_load_addr < gd->dram[0].start &&
-		    ((part_load_addr + part_data_len) >
-		    (gd->dram[0].start +
-		     gd->dram[0].size))) {
+		if (!(part_attr & ZYNQ_ATTRIBUTE_PL_IMAGE_MASK) &&
+		    (part_load_addr < gd->dram[0].start ||
+		     size > gd->dram[0].size ||
+		     part_load_addr - gd->dram[0].start >
+		     gd->dram[0].size - size)) {
 			printf("INVALID_LOAD_ADDRESS_FAIL\n");
 			return -1;
 		}

-- 
2.50.1


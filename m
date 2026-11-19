Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D2D606A320
	for <u-boot@archiver.kernel.org>; Thu, 19 Nov 2026 15:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=dqw03ic9
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B328540D20;
	Thu, 19 Nov 2026 15:20:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id skIZTWorkLci; Thu, 19 Nov 2026 15:20:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org DA01640D1E
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795101657;
	b=VL1k1RFrGot8UcbqneatCL71eCFqtnKxDj1+eP2pVo7IcmT1wWCYqmA1pS/PUTsrE0f1
	 0VdUYC8ZYo07kyfWNp+bprR6W1REPaC7xTFxDTbtp8NLaatfk4EIwfdp+FwQVOUjKDBem
	 y122dBOkMaQwBOLXHaesGfULo3i7d4pOVw6GYeSYrqRX39URot77wxJIwrAGwE53zNA4i
	 VhZeauaooyZhJ/O2pnCRl6jqg+VVu282IbjTo0S5Dtb/F1uJS9wVon4G5FFVKkFEaBQZD
	 3ptGntxXp1PlF06wuupeKOcFVp1AUUxoTAIjZht0ojnxZhj6k5mKOyWYu4IsMelWL1g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795101657;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:From:
	 Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=mVHlk8OxY25+nKkeuhmfjtv27Tva3+aYZFaxQtIw2Y0=;
	b=BfsWEZnmrU1kFl5Amgid78MgyR6SoYF1d3qyk/maSCKTCQLZOoZ8EaFev0D24Kdg1gIh
	 1wbOHX01M36Fb5/JNd+6Wz3M+JYWl2CqFJ6qi0ljEzItlogTy7v0aUWNweI5MN1bj6U2u
	 UCqa13IXPrL7F8N+iN2TPFFE+XWUJGGRUuV0uWWmPzEaCR3IGWGaaDbbjMmO4MKW+m4Kf
	 1KJsVzb9+3QIUuD140YN3Ma5h0g5h9RY9qZ0fm1ISB3EYSzU6I3HJ8h3fljHffEndDjZi
	 AgNrupkfdqAbLX3Ru1xVK/dV+48sZYU1l7uy4mOxT2SK46QckpL+ckT+adFc5Q96wPQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795101657;
	bh=mVHlk8OxY25+nKkeuhmfjtv27Tva3+aYZFaxQtIw2Y0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dqw03ic9TkxlOMmYFuwdPub2N6Ndsuevp0JUiqrkRk6x37eR0fayzYux/q70/Rg5j
	 noYSC2TsQIueaEBDARjf43qwsxdRggNF31IR1FYRGsJue+AEAyRYSGEXwCbjkxtFtO
	 GnLS0FZUlllDHF8rp5tHgL3GvwP1UpQ49j/uTrNoGIu3Kby4DuOrP4phtTY1DrzYyZ
	 0miUgiQNt+/3D7HtXfeDaKDhLvgqJPnUbD6qD8LOdU67PeGUQDxyZ5VPbx45OJbf3s
	 u2tF8ezcG6QC8/Qy+xenNBTiocDaE0LCU1xWj7Oe1Ut7c1U8Cpr+6TPObZH/4yl7jL
	 g5p1UGADZDufA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id DA01640D1E;
	Thu, 19 Nov 2026 15:20:56 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 818B7465
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 15:20:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 73C7740571
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 15:20:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WkOl6r0OtHW6 for <u-boot@lists.u-boot-project.org>;
 Thu, 19 Nov 2026 15:20:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 8F3D840562
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=31.223.242.245
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=31.223.242.245;
 helo=mx.dave-tech.it; envelope-from=andrea.scian@dave.eu; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=dave.eu
Received: from mx.dave-tech.it (mx.dave-tech.it [31.223.242.245])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8F3D840562
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 15:20:46 +0000 (UTC)
Received: from [127.0.1.1] (unknown [192.168.0.244])
 by mx.dave-tech.it (Postfix) with ESMTP id 9C9582017F;
 Thu, 19 Nov 2026 16:15:35 +0100 (CET)
From: Andrea Scian <andrea.scian@dave.eu>
Date: Thu, 19 Nov 2026 16:15:25 +0100
Subject: [PATCH 4/7] zynq: rsa: reset the partition flags for each
 partition
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261119-b4-zynq-rsa-v1-4-62ed5f983d1e@dave.eu>
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

encrypt_part_flag and part_chksum_flag are set per partition but never
cleared, so a partition inherits them from every partition before it.
After an encrypted or checksummed partition, a later one that is neither
is still sent to the decryptor or matched against a stale checksum
offset.

Clear them at the start of each partition.

Fixes: 37e3a36a5475 ("xilinx: zynq: Add support to secure images")
Signed-off-by: Andrea Scian <andrea.scian@dave.eu>
---
 board/xilinx/zynq/cmds.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/board/xilinx/zynq/cmds.c b/board/xilinx/zynq/cmds.c
index 57cb3cdd176..ac72ad81e81 100644
--- a/board/xilinx/zynq/cmds.c
+++ b/board/xilinx/zynq/cmds.c
@@ -303,8 +303,7 @@ static int zynq_verify_image(u32 src_ptr)
 	u32 part_data_len, part_img_len, part_attr;
 	u32 part_load_addr, part_dst_addr, part_chksum_offset;
 	u32 part_start_addr, part_total_size, partitioncount;
-	bool encrypt_part_flag = false;
-	bool part_chksum_flag = false;
+	bool encrypt_part_flag, part_chksum_flag;
 
 	image_base_addr = src_ptr;
 
@@ -359,6 +358,9 @@ static int zynq_verify_image(u32 src_ptr)
 		part_start_addr = hdr_ptr->partitionstart;
 		part_total_size = hdr_ptr->partitionwordlen;
 
+		encrypt_part_flag = false;
+		part_chksum_flag = false;
+
 		if (part_data_len != part_img_len) {
 			debug("Encrypted\n");
 			encrypt_part_flag = true;

-- 
2.50.1


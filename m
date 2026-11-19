Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFAE5606A320
	for <u-boot@archiver.kernel.org>; Thu, 19 Nov 2026 15:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=GHtinpWD
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A858181371;
	Thu, 19 Nov 2026 15:20:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0KZ6ob8ulGGC; Thu, 19 Nov 2026 15:20:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C9F4E81372
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795101650;
	b=Rd3lB4G7BObL3VD9ZAMOMSRCFIVR0/xV1zp/8tXaQtqQyAKypfnQpnka03pdt7J9fx86
	 srID4yQAJbKvFg7I4r8X85Zszh5Cypx39RNXqiDkw9q8yT19smMdWLemnOT+za8mRSCXQ
	 9L00c7SgXYhJzfhTkal3Zi1zQc4zZi2z1y6Wh3UydIH9BCaka8BYi8B2kqDwf7K/y4BHS
	 2wQnffyAghdoqVDy6+Y7iIG/IosufQt0f53zrAgdw83cr1/M4dKuSgpThnTnxKdxO9ytv
	 8CNPXHza6h9h1/E328nnojxrL/MA2Lvh3rKF1Vvt9YUFgkeGqa2cWXGBX6S2bMZQ5eQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795101650;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:From:
	 Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=AUXzX8vS+9YMlLBr4yKRQBNLwBa3kI3aYifacNj5M/M=;
	b=ny+m3AEcPSXbSFNey1TduyuXWMnbRP7tRJu5YTHI1kPWHqoEp4eGH+QZuRE8zMll7Jx3
	 M+yCNJzCf/6u/5azAB+iuK9JrIVe4yo6pJtl/kyqxmxjePIEdSYj5aa4oxq5XdS4ZhE5k
	 8b+WdCPsN+OGaHYMAPDMg3bcpWATaD6+Ph1myDdJsp/A60s4ogw9MHDhemK1f0HLSa3Kg
	 NQTojOnts7QMqRkRyhKYLSAdEcpt4bPJjxYKwSvF/Brk6G4vyXh2mzlcTmxf9vJAwBww4
	 oyO2bp3dRcQZ71Z66FKm0fHI6dylOnDO9r7JVSjA3FH/Ot/CXjgAXykxLtMiXPt70lw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795101649;
	bh=AUXzX8vS+9YMlLBr4yKRQBNLwBa3kI3aYifacNj5M/M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GHtinpWDcOcvCXXQ5jWitX46PmRJV2Eg/OZA8XvzK5AbtoA3lbUkeBEdBvJxfhgPn
	 kjqqu3tGIo5UGsAZOOJQ8yH7wRssEO6PtRgy9FemsLIsm6et++vJRv6FrDh3HwL+WA
	 tj/dfGbK2sia5PRqsZrtuwsVMz1USTLC8r7OgqgiFnbJ6OsAOgviubLjNj+cvNDczp
	 m4txteYsYCIZa8G+ICCLYEWPRHEyj84IFnGXTGEiwHt1FPwlUUy9VyvRMFH7JpnRSD
	 bjnS1BK2buDUtwM28Ua/Dm79d87c/cuJEK6pPztQMVVEc6ca6dPF6/XgmNR7sjvu9J
	 h8qYfGG/7ER5Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C9F4E81372;
	Thu, 19 Nov 2026 15:20:49 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 42EBA2FB
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 15:20:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3530D60686
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 15:20:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yhyMscp-kMMW for <u-boot@lists.u-boot-project.org>;
 Thu, 19 Nov 2026 15:20:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 7627C60AA2
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=31.223.242.245
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=31.223.242.245;
 helo=mx.dave-tech.it; envelope-from=andrea.scian@dave.eu; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=dave.eu
Received: from mx.dave-tech.it (mx.dave-tech.it [31.223.242.245])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7627C60AA2
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 15:20:46 +0000 (UTC)
Received: from [127.0.1.1] (unknown [192.168.0.244])
 by mx.dave-tech.it (Postfix) with ESMTP id 987802017D;
 Thu, 19 Nov 2026 16:15:35 +0100 (CET)
From: Andrea Scian <andrea.scian@dave.eu>
Date: Thu, 19 Nov 2026 16:15:24 +0100
Subject: [PATCH 3/7] zynq: rsa: reject partitions that are not signed
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261119-b4-zynq-rsa-v1-3-62ed5f983d1e@dave.eu>
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

A partition owned by U-Boot without an RSA signature was accepted if it
carried a checksum, and skipped if it did not. The checksum is MD5 over
data the image builder controls, and the partition header that asks for
it is not authenticated. An image can therefore add an unsigned
partition with a matching checksum next to a validly signed one, and
the command returns success with the unsigned payload at its load
address.

zynq rsa only runs with RSA_EN burned: require a signature on every
partition it processes.

Fixes: 37e3a36a5475 ("xilinx: zynq: Add support to secure images")
Signed-off-by: Andrea Scian <andrea.scian@dave.eu>
---
 board/xilinx/zynq/cmds.c | 36 +++++++++++++++---------------------
 1 file changed, 15 insertions(+), 21 deletions(-)

diff --git a/board/xilinx/zynq/cmds.c b/board/xilinx/zynq/cmds.c
index 8a3b2fc41ad..57cb3cdd176 100644
--- a/board/xilinx/zynq/cmds.c
+++ b/board/xilinx/zynq/cmds.c
@@ -305,7 +305,6 @@ static int zynq_verify_image(u32 src_ptr)
 	u32 part_start_addr, part_total_size, partitioncount;
 	bool encrypt_part_flag = false;
 	bool part_chksum_flag = false;
-	bool signed_part_flag = false;
 
 	image_base_addr = src_ptr;
 
@@ -368,19 +367,17 @@ static int zynq_verify_image(u32 src_ptr)
 		if (part_attr & ZYNQ_ATTRIBUTE_CHECKSUM_TYPE_MASK)
 			part_chksum_flag = true;
 
-		if (part_attr & ZYNQ_ATTRIBUTE_RSA_PRESENT_MASK) {
-			debug("RSA Signed\n");
-			signed_part_flag = true;
-			size = part_total_size << WORD_LENGTH_SHIFT;
-		} else {
-			size = part_img_len;
-		}
-
-		if (!signed_part_flag && !part_chksum_flag) {
-			printf("Partition not signed & no chksum\n");
-			partition_num++;
-			continue;
+		/*
+		 * RSA_EN is burned (checked above), so every partition U-Boot
+		 * owns must be signed. A checksum is not a substitute: it is
+		 * computed by whoever builds the image, and the partition
+		 * header that selects it is not authenticated.
+		 */
+		if (!(part_attr & ZYNQ_ATTRIBUTE_RSA_PRESENT_MASK)) {
+			printf("PARTITION_NOT_SIGNED_FAIL\n");
+			return -1;
 		}
+		size = part_total_size << WORD_LENGTH_SHIFT;
 
 		srcaddr = image_base_addr +
 			  (part_start_addr << WORD_LENGTH_SHIFT);
@@ -418,15 +415,12 @@ static int zynq_verify_image(u32 src_ptr)
 			debug("Partition Validation Done\n");
 		}
 
-		if (signed_part_flag) {
-			status = zynq_authenticate_part((u8 *)part_load_addr,
-							size);
-			if (status != 0) {
-				printf("AUTHENTICATION_FAIL\n");
-				return -1;
-			}
-			debug("Authentication Done\n");
+		status = zynq_authenticate_part((u8 *)part_load_addr, size);
+		if (status != 0) {
+			printf("AUTHENTICATION_FAIL\n");
+			return -1;
 		}
+		debug("Authentication Done\n");
 
 		if (encrypt_part_flag) {
 			debug("DECRYPTION\n");

-- 
2.50.1


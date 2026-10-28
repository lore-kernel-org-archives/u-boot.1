Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F309606A31D
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 06:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=cd7seFcp;
	dkim=pass (2048-bit key, unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=VlA+E5Eu
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 05AFE605E5;
	Wed, 28 Oct 2026 06:13:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dxdn1KMN0HVq; Wed, 28 Oct 2026 06:13:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 34154605EA
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793168017;
	b=Gz4w4jb5kNftJv+QL0wOiuTKjHEuTnLzNFR0iXdGUbPB0fMHD/wUuNt6OzJRug853+9V
	 AlPK5stNYserq/kVu2+GetgkywtJt2qMV8dvyqNfYqEkizepefpty+QWt7Mit1bvmxXvb
	 5ILicVjYgqohFlM6wk6rRMYYn/MQK1lDs+7ZzEQU+v/sEDlt7vlt+BjxbJRXZ3JAx+YBw
	 hcavKg1CgpJCvXVF2dHiKDxx4gxqXcRWX+OWuGjvGpBHMnQS6dj9yVikVLSYnn7gF2w5Q
	 efrZ2dQ1zbhiwWHfB3NCIhgT0IBeNaYk8DAX9aWP8NG8wC8ScbXKCyKSgNF6cYUo+0Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793168017;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Last-TLS-Session-Version:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=VmGzescQNl+bqXanUEo67BSAVIRBcQbDNA64G4Adjn0=;
	b=DB/ufI7scWBPIlSCcCpnwTYqRNrKAk7m2suKAO31JPC84Ka2vvi72clkGyA4oXI7YJD7
	 Be9UF9zdTpbPtbPXfBXzxDfS0DGuTRsLxo5l5SB2pwJNQGrnKC1BkCe1FZ36UWEL9IQ0w
	 xvZ9fAXcwiTCBbLppIyosletFcVmFUevn86uWEXhFnGAwn01ZZzG40Q/kNDY7sOKk3JjA
	 S/6LO4BwsZTVg7J3/HvL/b21UzUkm6CWXlX1WW5yaZwc07T5RYhRk6WdK6u+ElTOBrBeb
	 7MiMVPp5iZ74nxT3W7eNVbIT1Ua/AqROomm7Lo9hknhX3l+Rm2SM4NWoEUboQWedlrg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793168017;
	bh=VmGzescQNl+bqXanUEo67BSAVIRBcQbDNA64G4Adjn0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cd7seFcpiCI43GNW9hgAN78WwES6dkSc3KhhhGaMmZ28zmog2+Jogx9F+rkrpf7Vk
	 WeZzbczSi/IzddR0gk09L5FkJwk4fOk93D78g6DgMCylGTFNz0tjenKt5x1Bmc914r
	 p6wcciflDV6kh8r6o1FhgbgBTTFOA4ov3M6PYcGl+BnU/1640AUZaqb67K8dstbUX0
	 kplHbdAP/8U0gc/sgnC5F1C+Lpf6q+4S/2W95wvB5NezUShhE0x5P7B7/ToNn8RwQk
	 vdd4REfzHWmLGqjYdLoxh640ht9NspmYsLTxZzmLUNEvRlipJKMJ/sAhssHuxhCtfD
	 1l1MOuifbNllQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 34154605EA;
	Wed, 28 Oct 2026 06:13:37 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 7D442473
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 06:13:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 77BA180DC3
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 06:13:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Yh7oMZqFKgnu for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 06:13:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 7372780E2B
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=178.251.229.89
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793168014;
 b=AwzJaGBZXL5EcDyud2klVl4MY8bj6s5Qr9klcCSOTUvuWNoOBkacsm3dPIuck0guY8YM
 EiNtty7pafvy6PdaEAb7wLQzxXdilJ9P6igUBsNfoWvYZTMlGFJCChCNczP1bbjIVSJwd
 w8AVAbKKjZGzO6agbYoTSMRxJbuajE5hGiji3VQ/LhpCh6jK6RMupUrvsPszTqVoK5WU3
 npwrIBDdli9N1QaKB34A1oPYk+PrNYspLkwQDC1xojLlQUv7mknHZqKqTTn/0YAYA8TBR
 ngkW3x9Qg2cCLFDsH2cGZF6k8LLDj2Yr6HqWfWoqaue6Zf3XPNtCVg6mr4c2R+C74fw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793168014;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
 bh=VmGzescQNl+bqXanUEo67BSAVIRBcQbDNA64G4Adjn0=;
 b=dDwbU6UN8T8ClK5cNQsid5gmIpYRPSBbZBfphXrRxFxyaGDVKqI5wOfxDN06SsoJbPTx
 apL/vuEU28P4F0kbEtaqFCQCRA9kVzf9eQ6liyq/gE+GRXTbLMSiYq9XoDlAAZs2eTr1V
 MrpMe/uQp6hN+Ukb9RTnsDrTK8TVPM7z/npwJoYlIfC065nzNZ/sdn4fLvxdvUEv5SYxc
 Kb9QR7Hz0fPVRVfMidb/vJAVYTyd8qFCvs0gXm8WRZmHj6sFQoLx3FDjMw7HqW+XILsbm
 xv1LMA6ApHJdPzT7niauMBZUc4QK1YUJNQTI2jv+FDVPPbQE4X0ers6HTRFLOTcDRKQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=nabladev.com;
 dkim=pass header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=VlA+E5Eu; 
 arc=none smtp.remote-ip=178.251.229.89
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=178.251.229.89;
 helo=mx.nabladev.com; envelope-from=hs@nabladev.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=VlA+E5Eu
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7372780E2B
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 06:13:32 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id BD53C10B6AE; Wed, 28 Oct 2026 07:13:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1793168007; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=VmGzescQNl+bqXanUEo67BSAVIRBcQbDNA64G4Adjn0=;
 b=VlA+E5EupFlj2U28gHn2kx+LfLDLz+wL2+reZXILOkzXh95d/xHBTQKTb67fXp0OGYlM1L
 2hBnBOJBQyxP68cDX5tLU4SXmrSmImg3dbsjPJHutVfgBUnIhiVnGen08isy9efDbdLiYQ
 hPuNaV0wY2qkrSxwLoD3s/i90OEfMiczSoA4VBXdQxlQ25DSbW4zCU+974jVdq5EihG2Jp
 GZgMtlGN7f5wL8KTEs4cV4k3woR/UeS0dPHyNaGkngM3R7dEo4TBQL0iV5SINEB0zS1OCY
 A7GWA0yEKmnrxHvbmD0IhcZ1zYqQXyvdrGhehjRNwLVGg2FjBA3jbENps/Hq0w==
From: Heiko Schocher <hs@nabladev.com>
To: U-Boot Mailing List <u-boot@lists.u-boot-project.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Johan Jonker <jbx6244@gmail.com>, Vignesh R <vigneshr@ti.com>,
 Takahiro Kuwano <takahiro.kuwano@infineon.com>,
 Simon Glass <sjg@chromium.org>, Heiko Schocher <hs@nabladev.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 2/7] mtd: align a partition on the write size if the device
 cannot erase
Date: Wed, 28 Oct 2026 07:11:36 +0100
Message-ID: <20261028061231.39152-3-hs@nabladev.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261028061231.39152-1-hs@nabladev.com>
References: <20261028061231.39152-1-hs@nabladev.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

allocate_partition() checks a partition offset and size against the
erase size of its master. A device which cannot erase has no erase
size, so the check divides by zero and "mtd list" ends in

	### ERROR ### Please RESET the board ###

Align on the write size where there is no erase size, the way Linux
does in allocate_partition(). The MTDPART_OFS_NXTBLK rounding divides
by the erase size too and takes the same alignment.

A driver which declares neither size gets an alignment of 1 and a
WARN_ON(), as a missing size must not take the boot down.

Signed-off-by: Heiko Schocher <hs@nabladev.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
checkpatch reports two warnings and four checks on the two
printk(KERN_WARNING"mtd: partition ... force read-only\n") lines.
This patch only changes s/"erase block"/"erase/write block" in the
string of the print, so ignoring the warnings.

Changes in v3:
- The two alignment checks no longer rely on MTD_NO_ERASE being set
  correctly. An alignment of zero counts as 1 with a WARN_ON(), and the
  partition erase size is only taken when there is one (Simon)
- Updated the comment above the first check, which still spoke of the
  erase size alone (Simon)
- Added Reviewed-by from Simon

Changes in v2:
- New patch mtd: align a partition on the write size if the device cannot erase
  Testing on the board dropped for "mtd list" command:
  ### ERROR ### Please RESET the board ###
  This is because division by erase_size, which the SPI RAM driver
  sets to 0. Added for this case also sandbox test.

 drivers/mtd/mtdpart.c | 44 +++++++++++++++++++++++++++++++++----------
 1 file changed, 34 insertions(+), 10 deletions(-)

diff --git a/drivers/mtd/mtdpart.c b/drivers/mtd/mtdpart.c
index a3003cf44b0..ca13e18e353 100644
--- a/drivers/mtd/mtdpart.c
+++ b/drivers/mtd/mtdpart.c
@@ -563,8 +563,19 @@ static struct mtd_info *allocate_partition(struct mtd_info *master,
 					   const struct mtd_partition *part,
 					   int partno, uint64_t cur_offset)
 {
+	u32 wr_alignment = (master->flags & MTD_NO_ERASE) ? master->writesize :
+							    master->erasesize;
 	struct mtd_info *slave;
+	u32 remainder;
 	char *name;
+	u64 tmp;
+
+	/*
+	 * A master that declares neither of the two sizes leaves nothing to
+	 * align to. Take every offset as aligned instead of dividing by zero.
+	 */
+	if (WARN_ON(!wr_alignment))
+		wr_alignment = 1;
 
 	/* allocate the partition structure */
 	slave = kzalloc(sizeof(*slave), GFP_KERNEL);
@@ -665,9 +676,11 @@ static struct mtd_info *allocate_partition(struct mtd_info *master,
 		slave->offset = cur_offset;
 	if (slave->offset == MTDPART_OFS_NXTBLK) {
 		slave->offset = cur_offset;
-		if (mtd_mod_by_eb(cur_offset, master) != 0) {
-			/* Round up to next erasesize */
-			slave->offset = (mtd_div_by_eb(cur_offset, master) + 1) * master->erasesize;
+		tmp = cur_offset;
+		remainder = do_div(tmp, wr_alignment);
+		if (remainder) {
+			/* Round up to the next alignment boundary */
+			slave->offset += wr_alignment - remainder;
 			debug("Moving partition %d: "
 			       "0x%012llx -> 0x%012llx\n", partno,
 			       (unsigned long long)cur_offset, (unsigned long long)slave->offset);
@@ -731,19 +744,30 @@ static struct mtd_info *allocate_partition(struct mtd_info *master,
 		slave->erasesize = master->erasesize;
 	}
 
-	if ((slave->flags & MTD_WRITEABLE) &&
-	    mtd_mod_by_eb(slave->offset, slave)) {
-		/* Doesn't start on a boundary of major erase size */
+	/*
+	 * The erase size of the partition may differ from the one of the
+	 * master if the master exposes several erase regions. Align to the
+	 * one the partition ended up with, as long as there is one.
+	 */
+	if (!(slave->flags & MTD_NO_ERASE) && slave->erasesize)
+		wr_alignment = slave->erasesize;
+
+	tmp = slave->offset;
+	remainder = do_div(tmp, wr_alignment);
+	if ((slave->flags & MTD_WRITEABLE) && remainder) {
+		/* Doesn't start on a boundary of the alignment above */
 		/* FIXME: Let it be writable if it is on a boundary of
 		 * _minor_ erase size though */
 		slave->flags &= ~MTD_WRITEABLE;
-		printk(KERN_WARNING"mtd: partition \"%s\" doesn't start on an erase block boundary -- force read-only\n",
+		printk(KERN_WARNING"mtd: partition \"%s\" doesn't start on an erase/write block boundary -- force read-only\n",
 			part->name);
 	}
-	if ((slave->flags & MTD_WRITEABLE) &&
-	    mtd_mod_by_eb(slave->size, slave)) {
+
+	tmp = slave->size;
+	remainder = do_div(tmp, wr_alignment);
+	if ((slave->flags & MTD_WRITEABLE) && remainder) {
 		slave->flags &= ~MTD_WRITEABLE;
-		printk(KERN_WARNING"mtd: partition \"%s\" doesn't end on an erase block -- force read-only\n",
+		printk(KERN_WARNING"mtd: partition \"%s\" doesn't end on an erase/write block -- force read-only\n",
 			part->name);
 	}
 
-- 
2.55.0


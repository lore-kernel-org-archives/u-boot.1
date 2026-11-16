Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF0D606A33E
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 17:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=xlibdUfZ;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=DT7uSFV/
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E25288108E;
	Mon, 16 Nov 2026 17:37:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id i9zRQ9WxEqlO; Mon, 16 Nov 2026 17:37:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 35E0F8104B
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794850658;
	b=WGA3VAV8Qrnk930ReF8ChryarZuzl6BcAQfHfdpYorrZDbxy+RY7jZWY8So3A8RXyoca
	 hxR1PM0c1hoCkHp7EDxb2wM9men/5oCsNBmw6+rF46CwifaHBJRV/Qj5JNEHLs2oBlR5h
	 L+F5GnJIRpTZe4+a5QMqAdzjtFTjHGM0iqRVhnc6ucxD+s6hYOJceeG7LTMnMWSWuSjH2
	 1Gc0KDZKohreaE2zEB/hlk+kw3zOB4gZ1RlJhEXudYhOsfy111Ci8omJswLhlKv88/7qK
	 7RwA0OQ3ReeI7s4/W6KMiAUbZ7M+YLKcONoZd85fgaE83zK2fw+TrFDzed6Ij/Exb/w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794850658;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-MBO-RS-ID:X-MBO-RS-META:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=n+ypfeCxwhfqVfnvjevdTk0dphomiI9Vi3ZQPg0R+rg=;
	b=EhCiN/9fbsVtu9tXFDPy+fP8B+G+fm99EvRNqmTonDpvYhrJlTZsbrqY1GlwdFVEcoIY
	 Vi3yFiRRu0MRTu/bGMkkKtRVTB/hT68YUGddFxDmrH7EMoZAM8FFVFBNMDCeY/tDQQq6c
	 DhbAc0SvnXE1WLt/k7zdrEH9vej1NE1oqaFqxMBIAryRM8zbplEShlAIUoLpctUg/0BL0
	 nH+I8OM6gc4SEbDORClI7L7KKerptQZDuzor7fv/p25IN8NYov7e6PdJ8bra65W8Q0Vmh
	 72qx713SDyTfivl/Hq4T9ksLRAX/pV8rTU3cM2H8TNlSVZpcvwsSjJckUXAfc9sfESQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794850658;
	bh=n+ypfeCxwhfqVfnvjevdTk0dphomiI9Vi3ZQPg0R+rg=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=xlibdUfZiXC56TlRSd14tcrdwXE5Pn68RB2hCWER+/Cx7HSNMMGMouPqrlQUxYRyg
	 zF5uKqd8ZU45sPMrs7B4B5vxXVRn1uikEz/jHMoBbjXHDY/+KVXBQNjsJHXwroHgzj
	 uLvHZcAR8AcGoqWtgr7CevInxm+OedbKCnP1Z0Unu3VUxhohd9MWMs9R8qGqDNHeoC
	 3kT7BkRBltumiqnDeRlbrPV70H0XnNXw/66Wu4yqK2Yqm9PsTQnBNjZVT91p/PffaS
	 z+74VE6RBW+96VbBTPhgqgXskiV1CD8Ki8/AtGvHFTBC1Lt+Fv2fpTyPuNptl3+d6Y
	 u0KDgdXxPVevA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 35E0F8104B;
	Mon, 16 Nov 2026 17:37:38 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id CFBC228C
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 17:37:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C22E56075D
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 17:37:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id i6XC6iqYXUTv for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 17:37:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 13BC560685
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=80.241.56.152
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.152;
 helo=mout-p-102.mailbox.org; envelope-from=marek.vasut+renesas@mailbox.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=DT7uSFV/
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 13BC560685
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 17:37:35 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4jSw6g29hQzKrmd;
 Mon, 16 Nov 2026 18:37:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1794850651;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=n+ypfeCxwhfqVfnvjevdTk0dphomiI9Vi3ZQPg0R+rg=;
 b=DT7uSFV/B6+fI0gi3EhBw0V7Xot/104HIshQf8SGWIzWMPzNhkQmq9kkar5E8C8b2Bfznh
 3DHCVt6u2DJBz1kupDVnmb/YKoH8fEkj2nbMxWMJAI2oENwFmiGzxvvM06nmo/S5LPACo5
 DyBkmPK7gPjRUBq5XJ6mgMap7nihK0Qm08YnNpGvGqT83NWg6gifHKT5vXmEzUDVavZcYp
 lxC6dk4FQahHhVCz3UgSjfiOtsOJ0z6A8azBe6ENIc07E0PWZveTRokJ+lJRlWIpqhY2rb
 t0EUrd+z8Cse744tLhuZNB1IstE29koBLqB7IKG45tY6iSVURsRkuknwhIkywA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, Janne Grunau <j@jannau.net>,
 Mark Kettenis <kettenis@openbsd.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] iommu: Constify driver ops
Date: Mon, 16 Nov 2026 18:37:24 +0100
Message-ID: <20261116173729.3488020-1-marek.vasut+renesas@mailbox.org>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: dfc25c8a266dce0a871
X-MBO-RS-META: aigunx8zqyd9pjjox84iipb9r9sqirzk
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
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Set the ops structure as static const. The structure is not accessible
from outside of this driver and is not going to be modified at runtime.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Janne Grunau <j@jannau.net>
Cc: Mark Kettenis <kettenis@openbsd.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org
---
 drivers/iommu/apple_dart.c    | 2 +-
 drivers/iommu/sandbox_iommu.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/apple_dart.c b/drivers/iommu/apple_dart.c
index ebef28d0b9d..3f1df503fe0 100644
--- a/drivers/iommu/apple_dart.c
+++ b/drivers/iommu/apple_dart.c
@@ -165,7 +165,7 @@ static void apple_dart_unmap(struct udevice *dev, dma_addr_t addr, size_t size)
 	io_lmb_free(&priv->io_lmb, dva, psize);
 }
 
-static struct iommu_ops apple_dart_ops = {
+static const struct iommu_ops apple_dart_ops = {
 	.map = apple_dart_map,
 	.unmap = apple_dart_unmap,
 };
diff --git a/drivers/iommu/sandbox_iommu.c b/drivers/iommu/sandbox_iommu.c
index c5eefec2185..8bd221c8d81 100644
--- a/drivers/iommu/sandbox_iommu.c
+++ b/drivers/iommu/sandbox_iommu.c
@@ -34,7 +34,7 @@ static void sandbox_iommu_unmap(struct udevice *dev, dma_addr_t addr,
 	psize = ALIGN(psize, SANDBOX_IOMMU_PAGE_SIZE);
 }
 
-static struct iommu_ops sandbox_iommu_ops = {
+static const struct iommu_ops sandbox_iommu_ops = {
 	.map = sandbox_iommu_map,
 	.unmap = sandbox_iommu_unmap,
 };
-- 
2.53.0


Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745F3606A31C
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 17:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=aj0lAbY3;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=L6ZO4NY5
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4CC8080D4A;
	Mon, 16 Nov 2026 17:34:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JUw7YZh8OKVV; Mon, 16 Nov 2026 17:34:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A16CB80D62
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794850494;
	b=OHK/IjBcbVUZptDoaEjavAlhxFkiP3+CP7RZM7GKmi4Y3I6lcifHwA4NYtQ2E+OR+1f9
	 YwSn6r3SquQhA4kdEcV9RSVqotY8nlpo2wviHOh+pnB+MID0cf6pYPhx4O1w7wThkrb3K
	 iQB8QhbxvywhW0+VhmxucGfPYETXUoMC1CDxrwPz0zfsJddR6ZwMUiMdaD2zoGwMl1VKo
	 BE58ftu4wYSRmEpQxP8iIFHsBCpVErkYA7eKNKSM2Xei1enZxE5NxTjYImBxMKajUouuW
	 N3YWNlBdvrhLmEDbktgha+OCAdUNhkMyflNHwY9Nbjbt37SnS1v9Er4b1gSYYPT9c6Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794850494;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-MBO-RS-ID:X-MBO-RS-META:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=iNZ/bieUPl/SrT1sTF6JHBzqZt9oIm1IjwKhDb29Lgo=;
	b=oRWdM6nZ1YjZGRptAA4bDAAtGdPiWd0VkSxrP/FrFSkR18AdP+GSez7tUTyk6AGIhp4o
	 ZHyFmPeIqa72JZ5rIaBRh8UAlGh2VMyvnGJOhK9c0uGum5lGyWvSsM/JHiKHUUQYHJ7pd
	 olSkYuNMciEMYUHrZPLmQpenxVHZPfUKvfv4QOdIRPIaPK9Eqvcvi50Fd4McJEbqvJajR
	 oaFm4z8UnW8PKRA72J4UkEf7KU8FcKpEoZeY2ReWH3wmupSJkI65x7gWG861VpTPoZ/BN
	 gUjIvMkzOTER0jYHv8qgCZGtqE6ujdqnXGJnW6nT7iJ/rbz0SAyvTYbztSDUtDgDYwg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794850494;
	bh=iNZ/bieUPl/SrT1sTF6JHBzqZt9oIm1IjwKhDb29Lgo=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=aj0lAbY312N4N2rmC7vK+KjNbhsRHjDSMcnBWukjAlblKCmi8nYytudBsGmKFsUjT
	 j6Ox4D8CtP8aTflkibT8DgugSkMloUhTJljZCORJWHSspXFsqeFEQG/1dI7Ki2zuzA
	 wZB5aruXcg713zsGNVPQmye2rzLSlz5ielUzOMok5/whnH+NmMssM69S/VOVEmwFd7
	 ywuhGRTLnv5jHFJOOELcNB0CJnFkvZmm03jVn7iapZGuZLDmgiFZAvK1yYj3Dedl0m
	 64rB0EK2gFSalHSBtcOesr7c6XYUvAyJzO5ew6nrNaOCnKlWaavq7fe7PUWqj/tVjy
	 efwbe8SkuTdIA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A16CB80D62;
	Mon, 16 Nov 2026 17:34:54 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id A8DCB4DD
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 17:34:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8F0AA60685
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 17:34:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vGkDiieUjFnF for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 17:34:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C445D60601
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=80.241.56.161
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.161;
 helo=mout-p-103.mailbox.org; envelope-from=marek.vasut+renesas@mailbox.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=L6ZO4NY5
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C445D60601
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 17:34:51 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4jSw3X0z2czKnDX;
 Mon, 16 Nov 2026 18:34:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1794850488;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=iNZ/bieUPl/SrT1sTF6JHBzqZt9oIm1IjwKhDb29Lgo=;
 b=L6ZO4NY5Xne9tLMKVAFD8nJ+h7TYhoSktb2q2pi5GCbUqmcfPKjPgt8n/WmD/38CXl4tbh
 jqakyZ58ZqjKIj2HRBUlgDNJ7NePh3PahKDWlzuPKZQb1p+uwtx3fiUta6JUMEIRF9lUSB
 twKNNFqz4pUkkh5lA+jIdPt72W0InNdzMWBJw0RnWn5YKRnEXDRzeAtj6+mG6JvYjGaL6i
 QcR4zMLFH/fYaOfYb8L9AO8k3aRRM+/beqjN1YDBbksjiBrRWOuNVgQnlTb3S3QhWO+UPz
 0xAf7Ca4do6GP24de+lukcNefEENpDVrkZTNUlH/XpKMZI4i0irtvf7mqLcC2Q==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mathew McBride <matt@traverse.com.au>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] board: traverse: Constify driver ops
Date: Mon, 16 Nov 2026 18:34:40 +0100
Message-ID: <20261116173446.3487821-1-marek.vasut+renesas@mailbox.org>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: e67661b0f0623e552b5
X-MBO-RS-META: 7iw9xx7fp6hs744qd4ewgcwinpdg443h
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

Set the ops structure as static const. The structure is not accessible
from outside of this driver and is not going to be modified at runtime.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Mathew McBride <matt@traverse.com.au>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org
---
 board/traverse/common/ten64_controller.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/board/traverse/common/ten64_controller.c b/board/traverse/common/ten64_controller.c
index 63b72c4df7b..f2c31b143c6 100644
--- a/board/traverse/common/ten64_controller.c
+++ b/board/traverse/common/ten64_controller.c
@@ -222,7 +222,7 @@ int ten64_controller_call(struct udevice *dev, int msgid, void *tx_msg, int tx_s
 	return -EINVAL;
 }
 
-static struct misc_ops ten64_ctrl_ops  = {
+static const struct misc_ops ten64_ctrl_ops  = {
 	.call = ten64_controller_call
 };
 
-- 
2.53.0


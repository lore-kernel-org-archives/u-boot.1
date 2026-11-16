Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B961C606A893
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 17:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=yWWpnDUw;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=bXTYc+FW
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9697381005;
	Mon, 16 Nov 2026 17:36:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id O5ns1PysAiqG; Mon, 16 Nov 2026 17:36:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org ED73D81094
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794850612;
	b=nMPtjTdTrMX/u6MgB4xnRm+HwPjfco+GHoFT8TC8JSGuHmLoGAc3YDceB/GTticlvDKN
	 vFr9gM1FQW2+SBQlwAcsIb9JTKVYsqzLfwsz4kpUaJWDiW7ZZCdk8sEKR/y87XLXRE4g5
	 tID1WijN+IFWA4gbhJdBgU72neZi9bsFfK4fsxA+jnew0l9lMTbVw/Y4VGz4mHggJdr/J
	 ugIGMYoAutZiVeJ4dFZmQd6IWI7X50xRA3RtjfH41R2d+ba2IFWcDY9z+/qQaksMtdViZ
	 Nne6vTsriU+AzprvhiLGCyyW1iCEvrbMqfK9Qgu2nYsyzTZp08pWFHtKJlT7lSCEsRQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794850612;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-MBO-RS-ID:X-MBO-RS-META:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=bRB3ZiD5DTWbLKRbYdOpb5VRGyhBQm7sMyFBAeuod1k=;
	b=i6zKfoctlhx25RDHxzgD8Bg9T8aLuD1aXRKtNVmWR1G9oE1QFGqvZ54Vlls3uUTAJcw2
	 Iq6ycuMqd719BZ7rPDG+eDVy6IMn/+bhFu8cBf3noj1fX/PVrnqZ+2ttP4+H/nKOk2i3w
	 lGoZDUuVNJ/zVv/7/RRwl1JY4T2jzLtrEC9WV26tvPHVAMCttXXbwLj1wEXB/yGlU2hUx
	 s1TXwMlmjeaT07Mv06Um8Zj0tNuEGVi7LR7KVgW09C9TZ61o4s2VOdvNxO+gQ5j3qE8pG
	 PfieXNefR0Iw326XrjWvU1qf44qi9VB7RHoG/hoP+2DVl5krE5xELtYkIAjY2SBVA0A==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794850612;
	bh=bRB3ZiD5DTWbLKRbYdOpb5VRGyhBQm7sMyFBAeuod1k=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=yWWpnDUwl//HubGB66cLcMHKRawkClL/FonBeQV6HZE3y4l/sUhhGZ8/gmqDUw8rv
	 8ajaSAuKz2Ni0qFWY45ITJstnPjGtdEZz55LKOVJYLOnQDk03G7Kj2XGKqBhTpin0v
	 +U0isJ1X4vHYXFksBCakAQ7iYwa8hzMVzobFd2VmOu1SI21fVPlP8WxRLpqW6Hpt/O
	 bwpmKoD122UliN68/VdaRPb9EpRhomd0j3Gn712QBa/MG+6Tb/uNa04aDleH9YDEzI
	 sK8J+I4AaK5OCXAGc75reWMl+AqyAQoOf1aYJfnDYZSEpNBhgOYwU+hAOiuGblPoWB
	 WVzwktjwr1NJQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id ED73D81094;
	Mon, 16 Nov 2026 17:36:51 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id CE205176
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 17:36:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C0593607CE
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 17:36:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kebYn-wSFTEa for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 17:36:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 0EF9760793
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:0:465::102"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::102; helo=mout-p-102.mailbox.org;
 envelope-from=marek.vasut+renesas@mailbox.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=bXTYc+FW
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0EF9760793
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 17:36:49 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4jSw5q2TwpzKr6g;
 Mon, 16 Nov 2026 18:36:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1794850607;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=bRB3ZiD5DTWbLKRbYdOpb5VRGyhBQm7sMyFBAeuod1k=;
 b=bXTYc+FW5/yc+aqhm4J3E6F4OkOksagqXzQcrw7AlrbO7oIImNYXdjRFfqvMzDrA3zTp+Z
 RldZPzdTxvorMgwSepKPjzUfaKWjj8FPbTJZ6Tqhezg94FbCCD+20aSjuxlc1NS247+3Cb
 MA2HQterhpTfYe0WjjCTdNUPEs26vjRvLHcjZ1WIAobJ5zU3NrUaPc2gikuX9uNrB2UfvK
 iP/Q95L6M+vJ/5ayj0u2o3P4DbFYk//sf+QwR8n8IA/9G0tNbT+PBdrUO6e2WwC6kigRYe
 PelORAqU8bi4I6F/+mRADUK6rZimoZ0WFUwyiAr27a2qzq/jrie9GFq1pAezOA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Sughosh Ganu <sughosh.ganu@arm.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] fwu: Constify driver ops
Date: Mon, 16 Nov 2026 18:36:40 +0100
Message-ID: <20261116173646.3487945-1-marek.vasut+renesas@mailbox.org>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 5a465852896c9d4fd98
X-MBO-RS-META: 7y3bd4qa3bjgndkcnp4iq1jmrsxsxwnu
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
Cc: Kory Maincent <kory.maincent@bootlin.com>
Cc: Sughosh Ganu <sughosh.ganu@arm.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org
---
 drivers/fwu-mdata/raw_mtd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/fwu-mdata/raw_mtd.c b/drivers/fwu-mdata/raw_mtd.c
index 41c153038ab..ec26b869e55 100644
--- a/drivers/fwu-mdata/raw_mtd.c
+++ b/drivers/fwu-mdata/raw_mtd.c
@@ -270,7 +270,7 @@ static int fwu_mdata_mtd_probe(struct udevice *dev)
 	return 0;
 }
 
-static struct fwu_mdata_ops fwu_mtd_ops = {
+static const struct fwu_mdata_ops fwu_mtd_ops = {
 	.read_mdata = fwu_mtd_read_mdata,
 	.write_mdata = fwu_mtd_write_mdata,
 };
-- 
2.53.0


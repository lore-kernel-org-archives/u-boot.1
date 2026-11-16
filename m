Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21414606A32A
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 17:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=nT4Du59f;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=KM8OH3qF
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id F287740848;
	Mon, 16 Nov 2026 17:43:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Qv6uIhw8s0Ym; Mon, 16 Nov 2026 17:43:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C535040829
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794850996;
	b=XPswHIWECRUViH7OJsPz4OcH4snl54eajFiQRkJX6CvumAnrX+PRufIs7JMjAPLASyDR
	 fJ/HxsZWU7bQpUC/nZoaha6IvS0hAEVgTtUMvDke+3zfOeVswvdGJcUOd7NfDZd5bk6aD
	 UcRHVRZbXASppwzkRqr5NBS4awNYZG9ptoVTSNGvo/OXIclSV7Fm5VMZzjERuWlAu6FKZ
	 Q9Gzi3RSUdPVRAmKK9sorZzICukoCtEDye3AU3PStmYKyf3w5SrBVfS8tMQSVcIhZxIbF
	 jHEDzV5YRbJTUQPJtCoUQ+MdKGkUiaBg2NUuY4GokWwSpJICb24tsKj9+3ESOPmAZwA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794850996;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-MBO-RS-ID:X-MBO-RS-META:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=JHhD8gw1fha4tgTp7QMiObznHRBFvm5Huml4KsgkOFw=;
	b=edpl/Ef5O820/7EPN3pLTXZslKCmgUJFXo7MIVCq1b9nlyw4veQ/c0C9JhDZG7hX9FDe
	 eeojWwz0ZLx/fW6BQ9iaaQaMLNHDMj76Ga1KDDDJJkY0drUSvOdYof2AGlcY+cbSHsEzS
	 UVRhcg1GBfPY05hKe2vPpf0jn9DVOnw52KlRg89Wa6yabBzhnwaLKZ+PZqo1/HV/LA75a
	 7WfLnl2/FMKeQ8zS5H4OO/wCzqpOy5XeGmK7ChgzrcDkH9axhS3BgASc5lTB5GHdeJ4lL
	 IuoWEfEvA5wwyWHwrNp1gsImHUg3/Eb7bbr+0RqyuFLXhopP6W+etjGXFt5KdhkAzqA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794850995;
	bh=JHhD8gw1fha4tgTp7QMiObznHRBFvm5Huml4KsgkOFw=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=nT4Du59fW2FPOB4zVgPiys5/h6QeG+Sm/YgbCHxNqnZ146O0mgeETJs2vOiwpoXg5
	 Mt6xxx7V/bpiVCbjUh+W23/ajX7KkbGVNdkDHdnDmgrPJJEWhXN2JdIONRkrzyCcBi
	 2etXGb/61ibjoR7Ng8cN64jglUvHKFMIv+SAj9lzgVP0R1lailbNInOkC6Ii1MEjfF
	 8V/TAvyjevT1bBhtUG1RZsR93a6aGwQ9SC3V/gqCnTh6cUuuQe0DA8VoVofzx7YyyM
	 4f00mXXNnr873AsRbAypFCLqquR0kGeV167QpP70Kra0I8O51j92J554Wh+83LKQSA
	 zkmJOW6oVGZxA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C535040829;
	Mon, 16 Nov 2026 17:43:15 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 4CFD8169
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 17:43:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3F48180F5C
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 17:43:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MncN25BfqkYa for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 17:43:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 01A9C80DCC
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:0:465::103"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::103; helo=mout-p-103.mailbox.org;
 envelope-from=marek.vasut+renesas@mailbox.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=KM8OH3qF
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 01A9C80DCC
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 17:43:12 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4jSwF90D2kzKnbK;
 Mon, 16 Nov 2026 18:43:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1794850989;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=JHhD8gw1fha4tgTp7QMiObznHRBFvm5Huml4KsgkOFw=;
 b=KM8OH3qFzJcp8gwGMocoDqmCMQWuuFHyA0euz1BrAJHTRcZi1lqroH3L4GAuuZ8+CtscYk
 PL+bMSG5QazwCByVzpgFVRcderezGSv1iWBNPRJhBVP1YqG/BrvgoGsPtKcjpzAjoPja3V
 aHaJpbLKlZ+eX45blKmhdvm4YdxfWbwr73ZaGeKevgGhRQ5QPJh+arZwWd6I2Sa/Sfw3NX
 TdD3IFrh0c8U1UW1Vt61DlqRZLkJM8/CT2NbtkfvqWjY+uXphdrcRKMl4G7h3sKy8tOfv8
 GADAsVniUnJxgmO8qlhpvKdhTUi5AK14K4EBb0loMMSuVvIykOwwtUYgBpNh7A==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH] soc: ti: k3-navss-ringacc: Constify driver ops
Date: Mon, 16 Nov 2026 18:43:04 +0100
Message-ID: <20261116174307.3488283-1-marek.vasut+renesas@mailbox.org>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: a89919246aea6cb311d
X-MBO-RS-META: hb83azbbrpmoaqnmfsw3wcf73wpdq1qp
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
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org
---
 drivers/soc/ti/k3-navss-ringacc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/soc/ti/k3-navss-ringacc.c b/drivers/soc/ti/k3-navss-ringacc.c
index d37c454143b..ea9e0f479cc 100644
--- a/drivers/soc/ti/k3-navss-ringacc.c
+++ b/drivers/soc/ti/k3-navss-ringacc.c
@@ -143,7 +143,7 @@ struct k3_nav_ring {
 	struct k3_nav_ring_fifo_regs __iomem *fifos;
 	dma_addr_t	ring_mem_dma;
 	void		*ring_mem_virt;
-	struct k3_nav_ring_ops *ops;
+	const struct k3_nav_ring_ops *ops;
 	u32		size;
 	enum k3_nav_ring_size elm_size;
 	enum k3_nav_ring_mode mode;
@@ -223,17 +223,17 @@ static int k3_nav_ringacc_ring_pop_mem(struct k3_nav_ring *ring, void *elem);
 static int k3_dmaring_ring_fwd_pop_mem(struct k3_nav_ring *ring, void *elem);
 static int k3_dmaring_ring_reverse_pop_mem(struct k3_nav_ring *ring, void *elem);
 
-static struct k3_nav_ring_ops k3_nav_mode_ring_ops = {
+static const struct k3_nav_ring_ops k3_nav_mode_ring_ops = {
 		.push_tail = k3_nav_ringacc_ring_push_mem,
 		.pop_head = k3_nav_ringacc_ring_pop_mem,
 };
 
-static struct k3_nav_ring_ops k3_dmaring_fwd_ring_ops = {
+static const struct k3_nav_ring_ops k3_dmaring_fwd_ring_ops = {
 		.push_tail = k3_nav_ringacc_ring_push_mem,
 		.pop_head = k3_dmaring_ring_fwd_pop_mem,
 };
 
-static struct k3_nav_ring_ops k3_dmaring_reverse_ring_ops = {
+static const struct k3_nav_ring_ops k3_dmaring_reverse_ring_ops = {
 		.pop_head = k3_dmaring_ring_reverse_pop_mem,
 };
 
-- 
2.53.0


Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405CA606A31C
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 17:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Mx6/r4MI;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=X163a+JY
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1F2EC40804;
	Mon, 16 Nov 2026 17:36:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YlTq-zUfUrQH; Mon, 16 Nov 2026 17:36:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 63784407F2
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794850603;
	b=nKypRUcIRh6W+cQnPqf0Sw7qmj/Rf66nV1omLYoT2Xua4CwJXbJczRcgDtQ5GxrPkpXQ
	 5HY8GRweEizUMGIWLEjzShB19xltbA600ivsMKsFh4/88EV7AN1fKci52sfZ/tAQHTYgN
	 AOGIyKCUz9TfpQU5zkdrULaq6Gc6lQD9r23a10bmcqiWhDI0O0CL1tePlb1MZuc8M8u8y
	 rXXomL4KK6opBSSRBZfMBoxMZXindxmQRpa+IQR+Ioa4q8l6VP9gW8IKErrILbf+Z7/AU
	 EjLKVoN81EyxWDALY9wD9NtJ2C5c8RgeH6J9UqfvaBqrxgIJwSiVWV9+7cfi3FcxPUA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794850603;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-MBO-RS-ID:X-MBO-RS-META:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=WuWoGYGXu896/jQ7GDnGyjAxoVhs8n09fCPcJe+dORk=;
	b=fyJoaox3DlIX1rW64CmOwNZEb9y3d5aKkIpY0hN8AA8CR8p40Dt5XDZqYSil3IqZSLN4
	 gmaFud7chFt26pGT0/jYZ1l8YbV7Jd6M0doukcYZ9c2Idbx8lq/uiEXpKHVqB8ym6r8EE
	 9PaMWzWelpEzpp3L/mAjngS8XKMtshZPfswUPrFieR2K+ZUA4pbJvb3FLUWFUmcwH5QzI
	 rcbS7Z0pUteTca26qpaB0/774hF/xhXKLj7IJUiBqyVr3EUG5ZAgkXBpUlaAsTpJIlTqA
	 4PgDnA5OYQ6WPFmp/cW1La32K2Zieut5o7ltcrI+4MayLhkY3O04TPnWfNH4PO0g1mg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794850603;
	bh=WuWoGYGXu896/jQ7GDnGyjAxoVhs8n09fCPcJe+dORk=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Mx6/r4MIpjijjb21xwDshe+uzmFNF3ZfmSEUSS7Tuj+ChEVftoMpWlEbHwxAKdODO
	 UcMx2JVaXZdXo04b8lZUc0WPQmHr/6+hWXWeHBeppuBHayQdCX878jVcTkItdU10+a
	 uTPkSi0P5IMaimUu4KZMlKDPkyGHF8ytoN2XPwrNXja5Iote5NHIFBM/ejL40iWr1K
	 PjEUq69gEnDsSBtn1gKCWrEStB/Zogx5o/5xp8WkhEm8IIDZiWrwEqgSXKwhf0MF85
	 5BNdARfd98SxQ2j1bgfAF0HTX5mAHMrhEVdhYlRth8U84bRj2rBoJ6wysM8hyVR71l
	 5pmCEijIkREXQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 63784407F2;
	Mon, 16 Nov 2026 17:36:43 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 48D60176
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 17:36:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3ACA560793
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 17:36:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id O-TE5KevrLJT for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 17:36:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 714C860685
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=80.241.56.172
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.172;
 helo=mout-p-202.mailbox.org; envelope-from=marek.vasut+renesas@mailbox.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=X163a+JY
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 714C860685
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 17:36:41 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4jSw5f1kywzMlDm;
 Mon, 16 Nov 2026 18:36:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1794850598;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=WuWoGYGXu896/jQ7GDnGyjAxoVhs8n09fCPcJe+dORk=;
 b=X163a+JYyvAxxZwcNYzhqVNedyn6lwjdDuqBRWxCzvrEMIK6QUqJtYwWfUUTcoVw3mM6ND
 5RZFNCTiPXZ3482fqZPhomHRjKSsWz/DG6fkNYPjxJYp6lqM6EjEscAX+6NwmqDrKkJipk
 iZI8eUAnHz+D8LK4fXXIAPkefvcbQVtrBJUxI3XeRCt4jdIeMa6STCI7AXrcLtXxwdXqh2
 TR4l1G1cUD6SKdVw9HczQfwPp97l9HZWJpjMmZWKutR7F1NwhGGIfe5KSvYxGWf/DYDXfC
 TIznPXriYeb1fqyDkAyXMjpG4zURXDvRpSRJ3GSvFiDFUCB//K7UCM5Ln/PTig==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, Bryan Brattlof <bb@ti.com>,
 Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] firmware: scmi: Constify driver ops
Date: Mon, 16 Nov 2026 18:36:30 +0100
Message-ID: <20261116173636.3487926-1-marek.vasut+renesas@mailbox.org>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: cd17a4b99c77857e378
X-MBO-RS-META: 5bxwnb8azt6fc81juo68uq4nco4ng83g
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
Cc: Bryan Brattlof <bb@ti.com>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org
---
 drivers/firmware/scmi/base.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/scmi/base.c b/drivers/firmware/scmi/base.c
index fd65eae3cb4..7933d7ade29 100644
--- a/drivers/firmware/scmi/base.c
+++ b/drivers/firmware/scmi/base.c
@@ -514,7 +514,7 @@ static int scmi_base_probe(struct udevice *dev)
 	return ret;
 }
 
-static struct scmi_base_ops scmi_base_ops = {
+static const struct scmi_base_ops scmi_base_ops = {
 	/* Commands */
 	.protocol_version = scmi_base_protocol_version_int,
 	.protocol_attrs = scmi_protocol_attrs_int,
-- 
2.53.0


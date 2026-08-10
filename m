Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC713C5AD55
	for <u-boot@archiver.kernel.org>; Mon, 10 Aug 2026 22:36:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 53728607A3;
	Mon, 10 Aug 2026 22:36:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pk8VimCNHXF4; Mon, 10 Aug 2026 22:36:14 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 992E36075D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786401374;
	bh=ZzHVPULWPdHvUMnP/GwunWWEMx87Rs5AEVp/3rNlnS8=;
	h=To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=KRfaXwr4KCU9LBgMIfngDwlJMn/HwCD3UFqJkmdiAx8z0mpgz1uL87swEKSMaGjT8
	 mkJEZKxIQjxxk+FnruHhyxh3G2i7lcdnooTraaAVGvU79GmetVOYw0he6whKjE3bcu
	 z5xRCarvXfgPApSiYB6Dl63+Ltsvhqom0BXCUuNzELNA2lgOrdbUiKX0nrAOzeh2hN
	 GdV5yEOH/XMrQtWEo9rgKBq0YGv+c4g2berqJGNslFe/J2kYVdzeYAPcnAxELC9lgW
	 V+o2CDihWGP5FZYLiu4fp6dk+2zTWoVUhoREWjpOrmQb538jAqxS8JNUtII5hAqhTD
	 n+qNCIAJenUBg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 992E36075D;
	Mon, 10 Aug 2026 22:36:14 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 6EA9F10E
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 22:36:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6238F4018B
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 22:36:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qWjV0w8pqZD3 for <u-boot@lists.u-boot-project.org>;
 Mon, 10 Aug 2026 22:36:12 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::201; helo=mout-p-201.mailbox.org;
 envelope-from=marek.vasut+renesas@mailbox.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 784FF4007A
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 784FF4007A
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 784FF4007A
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 22:36:12 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4hJqNV1RFxzMlJ9;
 Tue, 11 Aug 2026 00:36:10 +0200 (CEST)
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/6] remoteproc: renesas: rsip: Clear SCMI transport flags
Date: Tue, 11 Aug 2026 00:35:02 +0200
Message-ID: <20260810223604.1333043-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: gx5y8sw5soeoyo63et7mcp6m7e45ybfe
X-MBO-RS-ID: 65d9e53c9abfefa0a46
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailbox.org; s=mail20150812; 
 t=1786401370;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=ZzHVPULWPdHvUMnP/GwunWWEMx87Rs5AEVp/3rNlnS8=;
 b=m7mefrlSGX171jhTeWOgy34K3ckQZeMdUQo2PreqGkwz6fUMy+1nynWhRTA+vnhzWZnJG2
 rNXRZQflDvC/can1o7OKHxjwJCrYB+I1nSw5WYKdVzM5ZjBYsmylMkotUqD5dtPB+4UrrI
 vOCCdFjCEyRJUcnPN36OzqppUy7Mn2noo7o4yvIuxYgL2WyECzSjhGRga1gGOO8ei2r/JY
 wAaOf7JYT0ptW6TY6vLUxb51cOYcsMB9kKXzmBEJSDjqmWduL4SOOyDc+kj6mr2f6ooMym
 EZt4f5L/+A+W0FLwASFtpa5f33A+Mip4sDiUxWyKJ57uKnOglzgt6IZfOn1+Zg==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailbox.org; s=mail20150812; 
 t=1786401368;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=ZzHVPULWPdHvUMnP/GwunWWEMx87Rs5AEVp/3rNlnS8=;
 b=cEJZuJIC9N0ApDyRLHQWv/F6N7DbI/h5CQkgh/95yKlztHkUwPT1qofA3xJgYb/FnR7n6c
 UKkxryzrEbFHac7/ewLlEQKDZqs0cSB00l/E5bKaCxBeV5ooEQs5nCXBIwxMD1ApzATru6
 iw/yk2yGBUwSRcpndkU14oLSdiTppPf/eOLDqBQ/BHhEUegUa2P7lxywLeHaAWv37Tn1fB
 YJ8NjC9PW2QikNI2fzWf++Ib2iglBmiZnhAK8FdLNaWyb8ih+GiIQ3RecK+SpOjUD3i0xS
 c4n43jyxqZH2gIoSCPRtaGudX3JytuYaPaRFoMGVLE0KDfHjmfGOZ0qGa2+ctA==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=mailbox.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=mailbox.org
 header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812
 header.b=m7mefrlS; 
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=cEJZuJIC
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
From: Marek Vasut via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Clear the transport flags field before starting new transfer.
The current SDK SCP is not affected by this in any way, but it
is better to clear the field to be correct.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org
---
 drivers/remoteproc/renesas_rsip.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/remoteproc/renesas_rsip.c b/drivers/remoteproc/renesas_rsip.c
index 76ccaf93b1a..68b775e5f82 100644
--- a/drivers/remoteproc/renesas_rsip.c
+++ b/drivers/remoteproc/renesas_rsip.c
@@ -116,6 +116,7 @@ static void scp_cpu_core_start(const u32 core, const u32 ep)
 	/* Wait for SCP to be free, then set it busy */
 	scp_wait_fw_free();
 	shmem->status &= ~SCP_SCMI_STATUS_FREE;
+	shmem->flags = 0;
 
 	/* Set up the message and copy it to SHMEM */
 	shmem->message_header = SCMI_PD_POWER_STATE_SET_BOOTADDR;
-- 
2.53.0


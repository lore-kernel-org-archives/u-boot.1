Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DDB7606A897
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 17:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=E0zUYiDs;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=B/BDMfqg
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3503980DE9;
	Mon, 16 Nov 2026 17:37:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id o-X8aHKRQwpx; Mon, 16 Nov 2026 17:37:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8C1CD80F9E
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794850641;
	b=o6FaX5kGtfISGyH/ewo/xXagMHavL9QoHFzQs7UcKo0pjO+iGSNhLv17/5av7H7doXsW
	 tiZohFFsGuY/AWfPYFr28quzZwBpvKDkPMXf8CmIRySu4iRSd/vytMREwl3zRySYC9Sgt
	 BnpzWg78fSKgK9gMSMEVVxUnd+9/MF9qazcg2FyRuybFWkW7MHCz1wOVflvaI7pyo5dGb
	 +Hrq/FMwT20RwmcrdroFWt4I0ltCcnVsvv5d6kr5o5lWVL1kJORvyB1JZkiU5Y864ZmQ5
	 cTzBW8XyStK1m4ztUIgzcPXK5BYWIf7s2GylwT0HDO/XZ6YrkKzhszt4BAcBrREkl0g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794850641;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-MBO-RS-ID:X-MBO-RS-META:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=ELMpeQ5UASQEiwQP5gd8egIgwSZP/Q4Ht0grrZzzgyk=;
	b=iodqjx5kzdnv4fdqhvDaQkglFvGquOyEVyJQp3pE8igxvvKnruZYHLdbneDfuTEdDvqo
	 lpw1bfOaD8iZXssRbspV8NJAFhgn+aC9Jjd17aAw1KcT6eMaXBaiQ3HRQ5jLoQ3A5XwZH
	 TquYH1us9tuIN4sSKoVHHe1Mu64BM+KRShNwK88MDIR9sSxuu9diiJwj2zB+o67nKW4C9
	 8z8+73vOkgv215rJ9HkplzLQZcoUNaL5rxJtMPX+5L0zrkjdM0jNUF/QOhMO0dPRhpE2I
	 mxSMImE5wL3v54p1jyJT6K4AU99L3RMYyhBDxb/A7216va3WRK3P1I6A4CKeoU0FdVA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794850641;
	bh=ELMpeQ5UASQEiwQP5gd8egIgwSZP/Q4Ht0grrZzzgyk=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=E0zUYiDsZ3slEZMBUOnbYvCi7fBfRnGJJYyykiCeKne86V9fwy29LmJDL0RD0zJ7V
	 N9PoP23UfgQYRSFRJquRNMPlSfrfVfaA3cc8wXdTIjoSnk3xKuelrI4bQRVnH5Qr33
	 2Fhyq87xhGCMP0ZBa/rAQkYSw/Cb3d8vfd90xb4Dngf3EnkR2IiQQyFUZpI18RSOQT
	 Ca2xlzMttBT8DuLzAKTANTbwKGcneU+//GBRtOkpZAdJxKEdsqf5WuNteXm5RLKgFZ
	 1H36ZE7WUbzQXhVUmMPGAjRRcgIW+41cwL0K+BxRGuAbUAZl76nC+xv+KxhGIlJijU
	 22R28G3U2Uukw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8C1CD80F9E;
	Mon, 16 Nov 2026 17:37:21 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 990834DD
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 17:37:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8055E6075D
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 17:37:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tIeVjvlCwp63 for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 17:37:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C334760685
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=80.241.56.152
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.152;
 helo=mout-p-102.mailbox.org; envelope-from=marek.vasut+renesas@mailbox.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=B/BDMfqg
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C334760685
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 17:37:19 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4jSw6N0gsSzKr65;
 Mon, 16 Nov 2026 18:37:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1794850636;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=ELMpeQ5UASQEiwQP5gd8egIgwSZP/Q4Ht0grrZzzgyk=;
 b=B/BDMfqg06jE2MUAarP+qrCNT1INFsEcdKM0dGD4rhQmKVXFlxxIup4pPz34UM605OLq5r
 9r/efC//PhrLtwivCwjaRzqxf5piSr+1qgMeAZcy/5N3dxnYSgkS3yqPEZMh/sqkRa3U+e
 Uf2qHeKzMZLcc9EPpZq5RgNU8KdTMH8QwcymnOB8k99AznAIvsBQc23HAICAtQRq4IuokV
 0sBtzpkXN/kqrx9CoNWdNm5z36SctlzTAODM+Phx1YnowhTh2iRM/N2W/vroDxvLtyWHvQ
 hfvMmYymKXOPRXNmwKpIKACCx79S1x0KygNMGPsi89z+x7TVIroD+CdLeFHUEw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH] interconnect: Constify driver ops
Date: Mon, 16 Nov 2026 18:37:09 +0100
Message-ID: <20261116173713.3487997-1-marek.vasut+renesas@mailbox.org>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 8adebb835838649d10f
X-MBO-RS-META: ejt4y6uxnutw4ghteuoj99hgtc9up44b
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
Cc: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org
---
 drivers/interconnect/sandbox-interconnect.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/interconnect/sandbox-interconnect.c b/drivers/interconnect/sandbox-interconnect.c
index 0fc0e3e0d49..512f902bf00 100644
--- a/drivers/interconnect/sandbox-interconnect.c
+++ b/drivers/interconnect/sandbox-interconnect.c
@@ -285,7 +285,7 @@ static const struct udevice_id sandbox_interconnect_ids[] = {
 	{ }
 };
 
-static struct interconnect_ops sandbox_interconnect_ops = {
+static const struct interconnect_ops sandbox_interconnect_ops = {
 	.of_xlate = sandbox_interconnect_xlate,
 	.set = sandbox_interconnect_set,
 	.pre_aggregate = sandbox_interconnect_pre_aggregate,
-- 
2.53.0


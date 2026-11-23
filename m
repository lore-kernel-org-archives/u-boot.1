Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C80606A31E
	for <u-boot@archiver.kernel.org>; Mon, 23 Nov 2026 08:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ATL+73rP;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=X7l5IOJf
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 118C380D17;
	Mon, 23 Nov 2026 08:58:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7onnF15aTOW2; Mon, 23 Nov 2026 08:58:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org F344880A92
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795424293;
	b=kG3Xu1lTCqJgMRXCS5jvS2LKfkun4C4z1GbecxMImvBb+nREqvZUYR03yhgytzckSI95
	 9j0O7CKtG6XzGQiXF/4yl/jmsOuQKqNWKKOgoNXGdErLLzteILE6Jr0j1MZywm5Z54zeh
	 L3iXkH7wfUKxOPcQTwaq+W7er2+sIFA5uf4hQD1R5Qcm0EFsmw+5NNhHYnmRS+pYyKMr9
	 CAiT7FORSoh5MdLXJ/KhFndHG/DplYoTWqF+tglyCdV9DcVk+9EFNOf1XjZ/yIJz/v65R
	 EJL0QtCSyLFdc8gsQaKBSl3sNUwfuVAU+iUK1Cv+Qs1ZwkPxO6vSW+/wF5G3E8ZsOgw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795424293;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-MBO-RS-ID:X-MBO-RS-META:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=xneAG+sXLbaNoMftzwGVAB5Qg1LNwqPD3GiT3lFurH4=;
	b=iSj/TRoO4/JvSE8+BZO63/3Zliql9KwNvAjlVo4jTpIz2+un6+EuNzpZN1L9xcQYN1xc
	 /2z6SvhHrjBLz8Ez02c8uMGMv5sbB5Q2/sX0SIQlR8QhMjgfot0zKSOjDcOHW75aLbfVn
	 XUUvbHylKThr6KGHLusO4sNOKUDUh2mavxCRHznYfhIyn7OHLOGo5YQM8FzkZ5P5QyZNp
	 GmrgZ4mTylHe1eaShe6IyM3/rXlddpwU+PnqPAoIoveVXl1vl+kfOy4aQlKLIa8aCXYb0
	 BT9iZopw20nlYgdEysNunzlb/B/C01BwBLjjzkRFA68sCOweT6CQTAxVgah6fvvoK2Q==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795424293;
	bh=xneAG+sXLbaNoMftzwGVAB5Qg1LNwqPD3GiT3lFurH4=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ATL+73rP2lFrO4bE2YgCti7GwdTat/rdiglUeeQ13HFaMdhHrzFC+u1mvYnZDSrFB
	 y1ZBwENSUYo+NwCsmEaz/X57WFq9n9dt0I8ICK2eL3BEqD/i4QsZbPKDVp0yoQetex
	 gjNyPLUnyskKp+WsxDQSKbHVwFUsF3yiIk8Q/pQ+QlzBxDvTHuZsE+vY5q3EaJqmVn
	 bcJSHU9TDGYNl//y0AZYNr9UIlMNJgpN+ax8t+Ok/H03ZGybyXPatXdJyViRW7G5rW
	 LyVSG5vR9w0ROj3S8ngjUgMV78/Byy/CntJmIKG6C0ymbqHcmbz0PzMHAaH7nmNkjd
	 ZOex7jQS7Zr7A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id F344880A92;
	Mon, 23 Nov 2026 08:58:12 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id ED551D31
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 08:58:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D2F9D4064E
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 08:58:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lPKWc6L9gURR for <u-boot@lists.u-boot-project.org>;
 Mon, 23 Nov 2026 08:58:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 987714064A
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=80.241.56.172
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.172;
 helo=mout-p-202.mailbox.org; envelope-from=marek.vasut+renesas@mailbox.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=X7l5IOJf
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 987714064A
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 08:58:09 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4jY0G55VPtzMlvg;
 Mon, 23 Nov 2026 09:58:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1795424285;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=xneAG+sXLbaNoMftzwGVAB5Qg1LNwqPD3GiT3lFurH4=;
 b=X7l5IOJf+2ZjpGUlM2lQK8RXa2tg3AAvY5u0s0NTZG5oaQz/mXy6lLNNrWGeNF/2uUjuNV
 GcAb8GQ88TbE17lt1gs/vyGdxRqGAf+J49HyntV8dFFKSJBSKTwL1irgIyvht/dKaEDdPV
 LbschqUE9eNlCS7afKgfQARLK3AkV4+bOtd1pBvde9rnixphe2mwGUIrwLoRaMzuQszCkV
 aiB/3J8KjzA2qxP/xXKsGcJc0njZnVpEFyqYoXidi3pQijNAoapuVk9pQtCMEKVwjLMNuv
 Ljv1VtkVSwPoMNvLuLdnh6xNuXW0qhCRviRJMJVbV+VBixXv/2v5GX2QJSm/BQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Jerome Forissier <jerome.forissier@arm.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] net: wget: Fix typo
Date: Mon, 23 Nov 2026 09:57:43 +0100
Message-ID: <20261123085803.25333-1-marek.vasut+renesas@mailbox.org>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 072a002df32bb1f01d5
X-MBO-RS-META: eqa9tzwkcfjqo3sjspxa5rsxhocrwkok
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

Fix misssed typo, two s are sufficient. No functional change.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Jerome Forissier <jerome.forissier@arm.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org
---
 net/wget.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/wget.c b/net/wget.c
index 49bfb9fcb96..14937edaa08 100644
--- a/net/wget.c
+++ b/net/wget.c
@@ -146,7 +146,7 @@ static void tcp_stream_on_rcv_nxt_update(struct tcp_stream *tcp, u32 rx_bytes)
 			goto end;
 
 		if (!wget_info->silent)
-			printf("ERROR: misssed HTTP header\n");
+			printf("ERROR: missed HTTP header\n");
 		tcp_stream_close(tcp);
 		goto end;
 	}
-- 
2.53.0


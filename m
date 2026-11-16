Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE841606A322
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 17:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=DGU6z0Sh;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=Ts2BnnES
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BBE0480EF4;
	Mon, 16 Nov 2026 17:34:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id L4TWSKNPakO9; Mon, 16 Nov 2026 17:34:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 0D00180D8D
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794850477;
	b=G9cysMgLqiwtcsu1cEn0s7OEhA8bFbq7ctJTQ1yi1hizM1TUCAmYeA3zJbZxbZoGRZEm
	 rj4xfz7G2ZadxDYuR59PJXydzvNEgDXDoOsNHnnswCVSrNexLMhawWquDdhKKe0g1OTXY
	 Cg17J3T2RInSxlO8P3c72Vlge0R/VeKRLJ2mRZjK2ibQSGqErNDYBF15lAU4WwVCJ+MrB
	 jtrVsra+Zgep/uGmBtKLXndGTTDko43tU6mYSD/c+KonuGaPOghmtsL6x5RNxlc5+y4WU
	 tbazco9w59HeyzJrtNZccefqpZPEmC13b71K66RQ2GJIOpxPsLIxeLvk7J5+gKZMVaw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794850477;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-MBO-RS-ID:X-MBO-RS-META:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=CFYz/tcV/S8UKlBVOKthmWHGErAtBGuFz/I05584aaU=;
	b=eb3Fhgu1q1CQY5o6dOlaXJqcTrxIEVcobgPflntel5GO2tqDwRuoz8AYigqwqnIj/aXd
	 ZIYf1IRTFSldRPE0IPD13HIs8RhIeSofvPruEsvfxq3SeY9tqWK85u5WKaFE1l51tK+15
	 L+wBsnebVvLCVxyL1miyMy4X9jjuFVARJpQlSv5uyWcrhWiRt/xJNxXw3PL660jabEZGH
	 qBRNpDkMHdD1A7LvoLU5jHB+o6Vbgq9xnvIzk+M39+VR90ebOjE+9WJWn+/Mc0V4lIxqU
	 q49fgn2WVl60nXCAPq2RjBJn0ufRSuGQIF6rg+kSS2FtEbVuyHhYSzXSjkMquA359TA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794850477;
	bh=CFYz/tcV/S8UKlBVOKthmWHGErAtBGuFz/I05584aaU=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=DGU6z0ShCRqSpYa8eVJfMoQAaHWLR1/FwPopkCobLWLa8nRm7193P1qexIzSm1EHT
	 ReYzQ2/3wiVTJpmDzm5rRPcZyGsXWqUDxjL5XIRx8VTOiwO9RHfov7n72gzyhg6rKW
	 QbrrFL1cbErEqCnxvtyKrxWSguY1eMIqHf+QAlEz2YkmApcGo6vxDhnEilrWOZa73b
	 ttX0WGp22HLmer8I6F1Mp1d5fvtvxZLfyxyihUBgjQDpIgqICm/rkcknmjQ8BesMzJ
	 vAVMJ/kqVkX2jMFIG9mCH6Pcq36Qg63zxXs32AfEaZ1RzYyJrI2ID43Edw8+GhzIzI
	 SDe165U18MTZA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0D00180D8D;
	Mon, 16 Nov 2026 17:34:37 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id DBFF81E7
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 17:34:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CE3E160601
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 17:34:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JzdGmQyobsny for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 17:34:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D7DE560685
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:0:465::103"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::103; helo=mout-p-103.mailbox.org;
 envelope-from=marek.vasut+renesas@mailbox.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=Ts2BnnES
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D7DE560685
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 17:34:34 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4jSw3C31KVzKnDX;
 Mon, 16 Nov 2026 18:34:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1794850471;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=CFYz/tcV/S8UKlBVOKthmWHGErAtBGuFz/I05584aaU=;
 b=Ts2BnnESkjT43IaPc8JkBFvjexXL3J/BbXN77F4FcHzYr3cC7y7m4sNv9TwHpddk5HNt70
 6NhdbJ+V/1JtSn6c7lO+A4aBXlUzApejD+pIXEPoP8wzl0i3lnl+leE7fgY98D187Vx7Ec
 Fizsa8pS6G1d9EGUrSz9/+NdHRuZa+tybwB4dMpKifQecLl+BFZnAatZqLvPy04zXUogIb
 2e+Gf4MqxB7/ix5lEDWOVbHP2R+FLghiVJ3aFWi4sXnAqYNsvFq8VqyYjCzfkZjRO5/I0z
 L7E9SA/pzhS6kO2GUy1/QX2RBdMbGG4NKFqK6gVAtJFC8dGGkCpqOt9JNqMTzg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] arm64: renesas: v3msk: Constify driver ops
Date: Mon, 16 Nov 2026 18:34:25 +0100
Message-ID: <20261116173429.3487798-1-marek.vasut+renesas@mailbox.org>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: a4e9e29a19b68511726
X-MBO-RS-META: q1ia6gmqcxi6bef7p9zqo1s9m6ab8h8t
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
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org
---
 board/renesas/v3msk/cpld.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/board/renesas/v3msk/cpld.c b/board/renesas/v3msk/cpld.c
index 260755ac746..3129ae15531 100644
--- a/board/renesas/v3msk/cpld.c
+++ b/board/renesas/v3msk/cpld.c
@@ -348,7 +348,7 @@ static int renesas_v3msk_sysreset_probe(struct udevice *dev)
 	return 0;
 }
 
-static struct sysreset_ops renesas_v3msk_sysreset = {
+static const struct sysreset_ops renesas_v3msk_sysreset = {
 	.request	= renesas_v3msk_sysreset_request,
 };
 
-- 
2.53.0


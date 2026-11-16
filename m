Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3D5606A322
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 17:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=FiQrGypK;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=igucqL//
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 366A44057B;
	Mon, 16 Nov 2026 17:34:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id u-hAWfx0UfHc; Mon, 16 Nov 2026 17:34:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 8093640557
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794850470;
	b=rr6HcQIXMwdaqabNlMwPZ5iMNf6mvAr+aK9YYml3PRax3mE1HstL1HtEuCkl116Q3L3r
	 7DmOfBA11Lajw4Tsb54scT/IDut2j5neD6ZJ57wgvq92U3Ca2n8Q+rLBQoZLTk1kK8ba6
	 eWqIw1UH+Lk7nkKg6or+97e/HnGzKKjh/qFhM5fDspck1P+A+6QtPYxBq8iRIR2XPdtcY
	 QmBhlFWul+i9ehzn+40ajudcVT58obTt8fbOKewDnuc0VKX1XONNtN0nKeUvIf+ISHY88
	 Ab/WySnVcnjmsuc459b5Ci7feGtOCeQTkLZZXMu+5Blu5EsQIcd207a1omysiMkDwcA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794850470;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=OVXNCxJPFGL9Q9ZgE6VITC30bs7N6mJlNVQV753TTxo=;
	b=QGai0VM6GdQJkfEUAztk1CJXAbSOLGLYQSwzSPketOdFGbSj0xH+fEjc90Hxsa6p5i39
	 n9+CkkqL+ezkG/EmbUa2Lk91BbB9ZBGuig9KELQ0i/zRYwP0rMvTWYDgr3B4ZZaaxe3VZ
	 6/MErnb6yMuND2S4Dk6xkRANrWFrwUwWpQMtxfkwNyM95rXy52TtM1eOfj9NI/xLjA8EY
	 zhSiYLcyTJkb0ICsHj9Yt8gOjKXv/o29rRROOjnIOfhWHOWQi7AEtSMaDn+zRAlx8aXdT
	 kie3LRsXyDbgIUZ6NApV13MNp+/MF4rsiiUzz/KY0KPh7vwMUX29pMPjWCtDC0Q+JxA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=mailbox.org;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b="igucqL//";
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794850470;
	bh=OVXNCxJPFGL9Q9ZgE6VITC30bs7N6mJlNVQV753TTxo=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=FiQrGypKYR6UHgUshmfQGAW+rfjVkMUR4r/VcZRy5DYoecvoZQ1O1FvAcnUZ3KIqe
	 SwXXyGdIOqfJWIjMgLHzmCccNdQcqfg63oAzD4tEjalIWPRV7LzrVqhTvr3HjUCG2a
	 bs0df6gVlbA28pIGv0D4FvjYRiq3fALSGRCsw4Zi0BAPtXH1fncVp/VMKRm7/hZ2Hb
	 Z0edi/QzXNio3u/W/uBrGFdxmo+S+aQqwkb4Xy1S/qZPFHFwHv7OGYml+MSd+kxa0b
	 q1vxxy6RJGLszkv+u4OlcvyTmVAx1MUzvr73GFpSSmLoFQSnK1A0+XtS0YuLo/Ukbx
	 aDZZ3yzaFI4Lg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8093640557;
	Mon, 16 Nov 2026 17:34:30 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 83EE54DD
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 17:34:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6A25D40557
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 17:34:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WCFoczS2GE7i for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 17:34:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 8031F40543
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=80.241.56.172
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.172;
 helo=mout-p-202.mailbox.org; envelope-from=marek.vasut+renesas@mailbox.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=igucqL//
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8031F40543
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 17:34:27 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4jSw335wLYzMlv3;
 Mon, 16 Nov 2026 18:34:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1794850463;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=OVXNCxJPFGL9Q9ZgE6VITC30bs7N6mJlNVQV753TTxo=;
 b=igucqL//WFrl5n6Nz6CToJKMpjqo1P3aNcoL4RCWUFz5kom8nVP40dMspymaUu3R/y0lcy
 QBnq+ruOJBz4+67rrxB02oBnc47DjAiin50SSWKSfz0PbTdQm+uQqoX4/voDdcSVPj405b
 EruWdAuOcrCi8L1w9KHHk++2DrCG0AfZVMmG+bDpX87OopqhHDeaLBtLza04DE6dHeYI/e
 oyU2i4Y156QkptxrvsRlXhGYUbJv8nJC0JB+vAmBvhiZATizMBGIR90jJJxe1eqj42psjg
 67/Dbvk6tnebvb0sKr9crBluyvgZOusf3Lq08QM9uxyF9EoiEzHB1KVMNVs10A==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] arm64: renesas: ulcb: Constify driver ops
Date: Mon, 16 Nov 2026 18:34:07 +0100
Message-ID: <20261116173422.3487778-1-marek.vasut+renesas@mailbox.org>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: zt65nog9zm8te3ey8qsc7k9qpecxkkf5
X-MBO-RS-ID: ab95751c9562cafadda
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
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org
---
 board/renesas/ulcb/cpld.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/board/renesas/ulcb/cpld.c b/board/renesas/ulcb/cpld.c
index e72e45e3fb4..4f273c75279 100644
--- a/board/renesas/ulcb/cpld.c
+++ b/board/renesas/ulcb/cpld.c
@@ -172,7 +172,7 @@ static int renesas_ulcb_sysreset_probe(struct udevice *dev)
 	return 0;
 }
 
-static struct sysreset_ops renesas_ulcb_sysreset = {
+static const struct sysreset_ops renesas_ulcb_sysreset = {
 	.request	= renesas_ulcb_sysreset_request,
 };
 
-- 
2.53.0


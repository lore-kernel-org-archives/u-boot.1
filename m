Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78A7606A31C
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 17:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=easKJq+U;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=leN01W6+
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7E47C810F2;
	Mon, 16 Nov 2026 17:36:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oOIoKzoWTSv2; Mon, 16 Nov 2026 17:36:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 9AAEE810E0
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794850575;
	b=FhX615HoLVzV0FKaDFTEXv25RIDoE72x+MKln8CUD+c3ccqB6dVnR/91qvBqcVsCBzg1
	 +/SbpTme9jSydT5tOccWIHI1Eg/aKGMWInlgLdYqDabuEA5n6uv86kvqykqM2Y7ma4G17
	 fFUJw1nn0PHurXe2gei91hFjj0WeMkuq5chlyhdMqhVBNtoxjsZyBhk1TI2mn5QBmPI5l
	 VpoD/gRxxf/0OyzP31IaaUCreb7izg6F9/WO0DtdgRp3vTaVuj3vqJX5Qyl6jHmRPnPhP
	 D7AkYC5K2++UN6PxL1oDou1r+G49m5KTtgYQum0tQkw4NA2MsV16MXfPfZRb1FVNXgw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794850575;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-MBO-RS-ID:X-MBO-RS-META:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=liy8IfoYP3ZlOHgFdlglA0rWAUravhJYD9xEj4pMoJ0=;
	b=TiZHmj4HSDUSEfA9Ci0R0xwhBDs7WtWObh0jFHBhHIkMhVRXyXc8xsN0XvMNG64Ybx60
	 wZ+vwgUrqzir93pG94Jmky+hheH6tcMO5OD61q2UtcBoe64IVtYsoke3s2UO00lh4Dn22
	 i8jr6QZ1l5MNgZWKM2+1pU6zMyNlWiG23DdOu8wcMRyPn3fBECv0Bs5dqeonw6iAFY6ia
	 0snmY4KbegoMZ+6aOOeskPyfsxxTd+QvyUmYPHZuMFzXbMfOID8mkDmHT7BPSR/2waOcA
	 5xgcPVjVWwbgKREzocwpq0GgzkGiiRteB1brV5w+XISGEYLG475s/p51FJtuPsnkazQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794850575;
	bh=liy8IfoYP3ZlOHgFdlglA0rWAUravhJYD9xEj4pMoJ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=easKJq+UB8xRVCnlMEkwU2fFRTqqmQanVP08aqFS3Rz6Ojan2qXXTPHs6ojp15RT5
	 hSXw5eXHPNmSFtUKSSMT/P9knziNyL7Y+Ljs1IbIu3/YA0AOjnDDRDfVU4PBBIbQKa
	 fy67zoUwoI/sO8+WuAzWixfYkLsd39lr4yxpAUiDZqBApSzB29Jml18UBTlqGKzm65
	 glgRiVPc4isv+zkhrrtphzauIHDQhNMyt1p1tICqRHJPZP2HSl7PaKLCpg03z0c521
	 BrYvCXm77pfXvDEOPy41ssCYlI69rhU10vHLKj+G0FEPwNLPgWZnIFadFYhZr75gvP
	 YaZJO8dp8Xt/w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9AAEE810E0;
	Mon, 16 Nov 2026 17:36:15 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id DBC7E1E7
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 17:36:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CDB5040737
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 17:36:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RAaYClVEAZkt for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 17:36:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 219C840588
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=80.241.56.161
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.161;
 helo=mout-p-103.mailbox.org; envelope-from=marek.vasut+renesas@mailbox.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=leN01W6+
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 219C840588
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 17:36:00 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4jSw4t1wKdzKnlK;
 Mon, 16 Nov 2026 18:35:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1794850558;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=liy8IfoYP3ZlOHgFdlglA0rWAUravhJYD9xEj4pMoJ0=;
 b=leN01W6+Z82aQ+BPAgBXraz5VtjtWsZ7HbdF4Xxut5ZfGygavtJ8xGJ5Z9Veoq3TyEeWxl
 kREc9eSKsZgXp4yeVGaDMzCrO+HmQaqnUfZd9myh2i/+wyPHuaxtCpHWMJs94DkgjncXOs
 sVnXkv0HDEriHP8Axenki7b+N82r2R4hth4PkYKNaO0SC3Q6ARY9e/trocUtf90WWhqZhY
 MiHinrxOZJ3HYXpzBAigo+ORkwFr0ezSI5gDnPGmMUEKJ6rvD/Fo5gupwo8wKRYTmJxwTA
 JDvm7tef6hhb8Ilp5JDHARews6rZ5pVoJ27P+2mZnDHG3B3NtjXHyhR/1pdPGw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Lukasz Majewski <lukma@nabladev.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 12/20] clk: sifive: Constify driver ops
Date: Mon, 16 Nov 2026 18:34:51 +0100
Message-ID: <20261116173546.3487841-12-marek.vasut+renesas@mailbox.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261116173546.3487841-1-marek.vasut+renesas@mailbox.org>
References: <20261116173546.3487841-1-marek.vasut+renesas@mailbox.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 843e91f70fa7a27cab6
X-MBO-RS-META: k7di91awi1kgs1gc5xi5o1yuczj6s5nx
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
Cc: Lukasz Majewski <lukma@nabladev.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org
---
 drivers/clk/sifive/sifive-prci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/sifive/sifive-prci.c b/drivers/clk/sifive/sifive-prci.c
index de55504b5c9..e885dab3e04 100644
--- a/drivers/clk/sifive/sifive-prci.c
+++ b/drivers/clk/sifive/sifive-prci.c
@@ -702,7 +702,7 @@ static int sifive_prci_probe(struct udevice *dev)
 	return 0;
 }
 
-static struct clk_ops sifive_prci_ops = {
+static const struct clk_ops sifive_prci_ops = {
 	.set_rate = sifive_prci_set_rate,
 	.get_rate = sifive_prci_get_rate,
 	.enable = sifive_prci_enable,
-- 
2.53.0


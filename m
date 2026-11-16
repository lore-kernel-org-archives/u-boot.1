Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 639AB606A323
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 17:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=K9WYlS5m;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=trZESRSQ
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3ADD440737;
	Mon, 16 Nov 2026 17:36:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XDPlbbDqf49l; Mon, 16 Nov 2026 17:36:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 0E045407E6
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794850591;
	b=l/cakuQW6ffq+XLSeZRnC7fi54ouea75j3rkpUM4DcXX6NlaxxHa/m2VBHhjqf0O4FMV
	 hySCY+2sdZcgmPYo+Bk+K183iS+zkaAYzfxxizXff8eCoYJbrx7Ln5RC3b6IaHI8sErcP
	 4fKHk97dB0RCaNMd+BbCIrXr3eogBjy16FD0d2Ul5TNrmn0KI38Tz6yvyp7f/+FDFqidZ
	 Z+ljOPhkAJeX72Hh5ReRaMG97ddbog5Bn7DKf3sbdzkv8LpTD5eOwt5HOjKVLK/nAy4AH
	 T9XuXY7F97ESHXHKAwWn4rxGzMRnou/t0jrGkvGR/8NG/w/AxhkEGM7jPlPJ8N2Ew8Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794850591;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-MBO-RS-ID:X-MBO-RS-META:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=GL3HYZBPo+0bLatmWWGkVeepZT/TQ/5Q1fS+IStpYXI=;
	b=KfcmppKxLbWmC46SXTM1mim4QqbThIbnf+gKQh7pfCb2QsvmtuVNl/pmdOoPzG4v+gUW
	 casZyvQbP+ZYyzS+LRe+nPRiBS6v8pvXTD9YB14Nc91WHeSvU4GEJHfcWLaTPnJvWktL9
	 837Nh372AsJG8Cd3SYFc3mXBnnFzrvLnbJIuDm32Zt0ypmt4BETScXJuQA/+Kz9XoBIqA
	 QgQZ1pev9i+qMmOnPrTz9GvRdmA0/oaIyWA5HjzP3qOquKq8TChZrJ5DHct5thIwB0IxM
	 EIzVMr9n3EiHItGd9JCzElBW84mwh6jDS42V6Uiz1jXwXCTBhlC/fqcKIcItHAOYvtQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794850591;
	bh=GL3HYZBPo+0bLatmWWGkVeepZT/TQ/5Q1fS+IStpYXI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=K9WYlS5mH9PERtNBXJwAZz1zrM2NPbOEtknfcNFHOZzIVvmEEwRR1bE9OkP25y9fd
	 umJYLYoY/fm9IuIj2uTwsEcNhWpVCBOblppmBT5ILCsOPwrughJZ8SLUtkCkWK0hdh
	 h9RXzSVEhpJV5QlArxaq/9TLojDij3jCQMmczo+ozMBHZwy28LHVi7ZjVkLyTvGg/v
	 w+pLIJ5I7MK7sFcreZufOi12h9KISWsyKiGFLXe2EWdOACk91M5XzaykV44KoCsH91
	 6yvolX+q8V8I/uwpA3zeYnPHUvDH1kK25mCwJc5Fh6QCKsTn7xHjtfenHq/6JHIYWC
	 khWNfg3Gl7GEA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0E045407E6;
	Mon, 16 Nov 2026 17:36:31 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 46CB028C
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 17:36:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 37F64607CE
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 17:36:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BEYOhMsm2xHJ for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 17:36:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 92D616075D
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=80.241.56.171
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.171;
 helo=mout-p-201.mailbox.org; envelope-from=marek.vasut+renesas@mailbox.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=trZESRSQ
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 92D616075D
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 17:36:04 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4jSw4x5wTKzMlmv;
 Mon, 16 Nov 2026 18:36:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1794850561;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GL3HYZBPo+0bLatmWWGkVeepZT/TQ/5Q1fS+IStpYXI=;
 b=trZESRSQk3et2k7TYIqgtTHxNDk/3Z/1M5yAN7zDQswNYJEaWj7iYF23E8/r/yLmW+SJbQ
 lgEJlrJoN9KP86s7yMKAQgaTa1l3nrwtejFjO868Xr85sRshTeVYLW1Tvtht6xYf0aep65
 yeePGS6i39gHXFS+YMw9Th+LTjOzNV2VM8Xk/03ebSkxQw9UJOjRleHlbGWm4TXJ6/sIar
 vpcuheFnRqiseLzwHfCEeVu37pYK74XaCAF4FtjLCqcsg7+IYztgFYHZvHJQjznL78pDzn
 DiDd3dfBqeBTqH21KwaWuw0IDMcAdvqH8FJrbyPVMD/VYA6WHSdCErZwJrgQLQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Lukasz Majewski <lukma@nabladev.com>, Michal Simek <michal.simek@amd.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 17/20] clk: versal: Constify driver ops
Date: Mon, 16 Nov 2026 18:34:56 +0100
Message-ID: <20261116173546.3487841-17-marek.vasut+renesas@mailbox.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261116173546.3487841-1-marek.vasut+renesas@mailbox.org>
References: <20261116173546.3487841-1-marek.vasut+renesas@mailbox.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: b0b623246d29ec29a8e
X-MBO-RS-META: 1tjb7iauudmwupu1kzxqwzr8f84b1q1p
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
Cc: Michal Simek <michal.simek@amd.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org
---
 drivers/clk/clk_versal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/clk_versal.c b/drivers/clk/clk_versal.c
index 2e0c382ef30..2555b21805d 100644
--- a/drivers/clk/clk_versal.c
+++ b/drivers/clk/clk_versal.c
@@ -803,7 +803,7 @@ static int versal_clk_enable(struct clk *clk)
 	return 0;
 }
 
-static struct clk_ops versal_clk_ops = {
+static const struct clk_ops versal_clk_ops = {
 	.set_rate = versal_clk_set_rate,
 	.get_rate = versal_clk_get_rate,
 	.enable = versal_clk_enable,
-- 
2.53.0


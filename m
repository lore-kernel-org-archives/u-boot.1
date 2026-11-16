Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB7F606A31C
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 17:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=bfB5m37/;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=NCzZaJba
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D38284078C;
	Mon, 16 Nov 2026 17:36:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PMLD2Cy1s5G9; Mon, 16 Nov 2026 17:36:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 33BF240781
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794850568;
	b=hg8rEXRrG3TE6awDUjElJQyGT6QWxSnOrUvo1cvfp7IkmtjW3/KX0yyeQmGGer/4CXzt
	 Asnv6xmQDgvfm6YxD9VXuBEdDsz+4lMOLMhmbrGtDpaUiNfwtRUbMjaLASNS7zFbsY+mz
	 9MZoEkx+oRL6Urr/oFhMbSdAbW04erGWlwUHhgnc8Y+8EDlmLQCvrvJgSyM8lggiWWBn5
	 ZDacUqTE6mHh+1dRLqlz7gLlLc5EYGDpAIWF8xv1sruqkLAUdf6XmhxbVQ+d2w8AOGHGQ
	 kawe0drgLPrLM1SxpkUkVLNzIFtiBfLzPNYh/kaFy3UQPqCib/NCjpPzxR6OTRFC6xQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794850568;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-MBO-RS-ID:X-MBO-RS-META:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=4A18TGb21yexVb1F0JkbC5t/lOTLPV4WyXgquwvDOIY=;
	b=XVWPpP4rcYAszFHV866OiD+prvjI0TFsDZ5Udph0HyDRsb3QdoE2R/hnRrM9OlxlhmmX
	 XtIP+U02EgkpoPtTgdMsWKdpAMwnevvdnkfUpL4X+utA/7x6B7r+UQqIxtD3JQ5DdtRWZ
	 kOc1MvF3ib4p4x4yBfRP8RBR2McaXdtSDIMaCfAiSGBPvIhuNFfl3hDREwFGTbJjM2PHf
	 fA+h9jqFN9dKpQgo9TUHaGoXO8ALwehztKmXPYuZHwux8I6bmJHxDikUPVbEUogH4oUAs
	 OGNV3Bc40ryrNwuOvVjiICb3ahNs09A5q8r1pHsDa+YD6STzr4EdzSgfIqFqyGw50pg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=mailbox.org;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=NCzZaJba;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794850568;
	bh=4A18TGb21yexVb1F0JkbC5t/lOTLPV4WyXgquwvDOIY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bfB5m37/RldS9WOuieSzOzEZVnKawjLXHQCikrh943J5oN+bLVBbS+5atm/n+3I1E
	 xknEWOdZ2OhPyCtdFkRm5iH9IzOHEjl6msL7svNp7bueEynAZmLS5ZtpJykDQ5ZdR4
	 4G6ziHU4owg7vZ0w0auJo7CQdnOvtlg++QboE+7QvgaYKK+NM7xjmzZseCdwsqj42l
	 L/AwCIR2brc5DDh3YOShFZ4r97oZ/3kPLRh03PLbNCQTsZCih3NnTEfget+1JBZG6L
	 AxH9NbaD+l7nfpT7n1goSO9psvCI87WfKNN0V33hjqu9KvBT9dczF0d38VIBfD2EJK
	 CKUD7SplnDM2g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 33BF240781;
	Mon, 16 Nov 2026 17:36:08 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id D279028C
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 17:35:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D0156405F0
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 17:35:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id V-GbKDD5B5LB for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 17:35:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A5A6340588
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:0:465::202"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::202; helo=mout-p-202.mailbox.org;
 envelope-from=marek.vasut+renesas@mailbox.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=NCzZaJba
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A5A6340588
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 17:35:58 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4jSw4q5WPszMlvV;
 Mon, 16 Nov 2026 18:35:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1794850555;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4A18TGb21yexVb1F0JkbC5t/lOTLPV4WyXgquwvDOIY=;
 b=NCzZaJbaFfCdCg51WA8PbcZAXV5J49NyyYChRKFQVpjibOzxumscVRo2xP6uvO0h8CbWBJ
 cxpbBWNW2KJU3yq0t3wo3ZEnKdymGM6cCQoR4t+UHfKOKz4lUpgvIrBiRGYk44rSU6s161
 yViM8pODzkSzokr5IXJmHR/AZcz79WdoSzuYi0YLFSWubIomPVh5sPOQsCPOXlbhFDhi2o
 cjqwYdsAd0PFJ6hc6wp1Kmgs5WT0HSpU4SP+MJ1EtQo0mifQxd01qwL0A/HSQXdi8A/UaU
 K5vxRfaF8zMTRD5eUmxIZPcxHo5/zSuJ5h6whp/7reZKgVflYXhFs+S6E1YTBA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Lukasz Majewski <lukma@nabladev.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 08/20] clk: octeon: Constify driver ops
Date: Mon, 16 Nov 2026 18:34:47 +0100
Message-ID: <20261116173546.3487841-8-marek.vasut+renesas@mailbox.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261116173546.3487841-1-marek.vasut+renesas@mailbox.org>
References: <20261116173546.3487841-1-marek.vasut+renesas@mailbox.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 3eecb625aa8f58dc02d
X-MBO-RS-META: 1x8eeqm45s6c769giynq447xjrapsmi9
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
Cc: Lukasz Majewski <lukma@nabladev.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org
---
 drivers/clk/clk_octeon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/clk_octeon.c b/drivers/clk/clk_octeon.c
index fa50265184f..930bd4b39a4 100644
--- a/drivers/clk/clk_octeon.c
+++ b/drivers/clk/clk_octeon.c
@@ -39,7 +39,7 @@ static ulong octeon_clk_get_rate(struct clk *clk)
 	return 0;
 }
 
-static struct clk_ops octeon_clk_ops = {
+static const struct clk_ops octeon_clk_ops = {
 	.enable = octeon_clk_enable,
 	.get_rate = octeon_clk_get_rate,
 };
-- 
2.53.0


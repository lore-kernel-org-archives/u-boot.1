Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC714606A31C
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 17:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=U/WW2dkT;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=Fpz1qN+c
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A4D2D40787;
	Mon, 16 Nov 2026 17:36:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ttF-cj8O4NMJ; Mon, 16 Nov 2026 17:36:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 085FF40781
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794850580;
	b=kv7h5PzCkkKeJFHiz4nO7QMfiiQukGulOghE5BImWH2RZCxUK/hcBLalcmulFGvMHZ02
	 AczdilYrBo7ActJbe/3UvY/YoD7giDvk6nb3TfPn/DHBACg5Oc09YI73e0XzkE414Eq3B
	 qa+c3FPB3P4K5RBALQ6qbkoZ2SkQUm3ZY5ij7ZECRf+VwMAs1aZqn+aQhkwYzaM7F4xsx
	 x0omGjeueCPcjYxHhXAp/5C2VmgagdPCj8VF19neOvMijNBS9Yyl15jswer+sSXo3vs19
	 ddXLRGpcjzI+e45jxwxGLDYHRG3xi2hUGG7b8jh+1wOgh4BQ4+GVVs6Vhs+xc1XfQ0Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794850580;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-MBO-RS-META:X-MBO-RS-ID:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=+UMPjKU7CRObat3PrVFgCLhkiqVyrqB6Zss1YGfvr0E=;
	b=svUrVFTjvloBAXVtva0OJSLzyAnqW4zEneJnxCWcsO5yI173tTRS1an878CnEJoHBvL1
	 FCw2AFzcKjtkxF83+fb/8fjVZe80zdKA5WSYkVdlOG7eU8929LNtwS+xcXICZoUyu0e0l
	 YuwwGWQrd4VkpSJUWadF+yGsul90YCh7Wncp6NQdM30FLtlT/q1+h3RwJZHWH4tlFRNL2
	 u3U98FmNFtyuA9LztVKICv1jft0VHI1YjkFXbJpEJJUSgHus+xlMI4a1MpTMiZnM2Uh2L
	 g5wLs9nfir7SPPd7Ed9mTmxLUUanf4eJBPCqS5jzEpYyEe2o0Zb2zFAveM6gQGmLfmg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794850580;
	bh=+UMPjKU7CRObat3PrVFgCLhkiqVyrqB6Zss1YGfvr0E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=U/WW2dkTUwE6yzad6ooZlWCdyCYCKa/ohuB814VcfqwWoZyROkdsvcFc0WYFbIJtM
	 etnlmxA7L5Hgh3vu4x8TKNUP0pSDOucJu5HicjtmC0JXn8LLFzCtSqtOUdhKs3dmYn
	 bpdWgLL2nN6HMGePZzzw2oEpuVQA8oXmixVJR7x+FtvK2Iq4Kl3QvM1Hh84Tp326jM
	 S8wTb3Ile6ktlMzQNL3qhKIUZ7DOVE3V8FHMAEUjhz6pd+8kWfTKoPSIMMcM68m6Oz
	 SI1XUmUBLuQlUGRT6dqs+dyzljNAzLcJJq3e/1MYW8rkDaSg3KpsI2VQjMom4lCsM6
	 pWi01TFz/+qlQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 085FF40781;
	Mon, 16 Nov 2026 17:36:20 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 488D51E7
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 17:36:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3AD1C402CE
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 17:36:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rlr6m0IQjLF1 for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 17:36:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 42C43402D0
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:0:465::102"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::102; helo=mout-p-102.mailbox.org;
 envelope-from=marek.vasut+renesas@mailbox.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=Fpz1qN+c
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 42C43402D0
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 17:36:01 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4jSw4s5nZ8zKr6g;
 Mon, 16 Nov 2026 18:35:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1794850557;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+UMPjKU7CRObat3PrVFgCLhkiqVyrqB6Zss1YGfvr0E=;
 b=Fpz1qN+c5MfnBT9zMwP16ukRE8GU5DvyOTMYXma9INkngF40jLL+NmP/ge6dczlDK0A9b8
 4o6/nUHcQXIQgJfBjw1cJltEEVLbJay8D9Y6qlktroKUDCSi2alfLj4n0n1CJldYES7I2s
 0J06JL3eJX+XC1KXNgq6Oz/aeJWBUUEQR35BDTmZB6ncUTbr3X3VTFLWrnGEIVbQoe/NT7
 H05zhUY47HNHzwkv5t7HLyc/V3vmJRml2Bk0vFyUlu71ceSfDHsCtYT6XqZLEbg7arabBL
 WLMTxaDby/zErSot+3BNPzKfOUEtDtL9wd3gUtDNKB77dwUnTJuZC1KjLDRnfQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Lukasz Majewski <lukma@nabladev.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 11/20] clk: sandbox: Constify driver ops
Date: Mon, 16 Nov 2026 18:34:50 +0100
Message-ID: <20261116173546.3487841-11-marek.vasut+renesas@mailbox.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261116173546.3487841-1-marek.vasut+renesas@mailbox.org>
References: <20261116173546.3487841-1-marek.vasut+renesas@mailbox.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: ncffhnys4qgsr4ke87mwhcc7bxzpxjms
X-MBO-RS-ID: 172d6cf216e1039c97e
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
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org
---
 drivers/clk/clk_sandbox.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/clk_sandbox.c b/drivers/clk/clk_sandbox.c
index c8c5a88c52d..aba571c22ee 100644
--- a/drivers/clk/clk_sandbox.c
+++ b/drivers/clk/clk_sandbox.c
@@ -106,7 +106,7 @@ static int sandbox_clk_request(struct clk *clk)
 	return 0;
 }
 
-static struct clk_ops sandbox_clk_ops = {
+static const struct clk_ops sandbox_clk_ops = {
 	.round_rate	= sandbox_clk_round_rate,
 	.get_rate	= sandbox_clk_get_rate,
 	.set_rate	= sandbox_clk_set_rate,
-- 
2.53.0


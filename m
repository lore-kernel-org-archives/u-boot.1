Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8542CD343F
	for <u-boot@archiver.kernel.org>; Thu,  7 May 2026 22:07:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8309A84C17;
	Fri,  8 May 2026 00:07:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="O4yglLza";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="ObYeyU5Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0CC5884C18; Fri,  8 May 2026 00:07:01 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3CF6984BE5
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 00:06:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4gBRDg02Fkz9spS;
 Fri,  8 May 2026 00:06:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778191619;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EtoCWVUTtsMdG6hKTfDL6bgXRuUm1MJfLdNAGikIyKs=;
 b=O4yglLzaDMnyr1mak5R2GODOnC6uLsPkD5LzncwN61i/+syfS6cEsGozUT2Avhi4DogD6L
 sB6/xgWDs0UpfyR768e5GZkyaOqTjtpj6Mx86r2u7JuNJldvPKGXJWKp7M/hcMkn04yoCK
 joeLI39/JwWlHBBBf/h9nFy5WTBI5/IiCpO9q9X2ObkiQJe38gMqDEXCn3tsUaBJ3l7yLd
 fNdlzzJ2JqBOKSnZZ00x/UyZplWh/Vmv/A7AaC/ejp3sYjKjHGHzctW+ZWR1eWyHyRrWvv
 DsjP6l9SIoKPKDXt1qIw/Een9DTsAMCpTOX/OOfPUfPabAbpX5Ofvi761ZZSSg==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=ObYeyU5Y;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778191618;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EtoCWVUTtsMdG6hKTfDL6bgXRuUm1MJfLdNAGikIyKs=;
 b=ObYeyU5YUXrE+3xpQv9YD0IU4aBWUeIM0LhkAF6LJdNDsnScDPUG+y/amQdVrO5UQ7bhvu
 IIc7xwUSy2RatYkstj/dIhH9VKtuVO05CdNg1PdVFlZ+O9vmsXg1KRF9y2HtbCLp+b71Zg
 0+ltGxItyK/fAtQiO550R6TFD930+9rBeRbGHWwih62Z/ki2szhIcrSf1RnPbNDJ2hVVBW
 fO1wjvYuYwBn4AzK2Kqs91lD0qr2Yle28qeeJ6MlcOeBHgCxq5Ta8hQQqC6FatDyz/LmWL
 QZvWNJ8QgluY2LKzVQST0678EzfEobiy8yHdDRvBWrgz4NHBXdDq2gWolrRo/w==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 3/6] mailbox: k3-sec-proxy: Staticize and constify driver ops
Date: Fri,  8 May 2026 00:06:30 +0200
Message-ID: <20260507220651.209168-3-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260507220651.209168-1-marek.vasut+renesas@mailbox.org>
References: <20260507220651.209168-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: becc8e5e055b1070401
X-MBO-RS-META: tfpqa37udxr3o78t619i5dbqkfponj8r
X-Rspamd-Queue-Id: 4gBRDg02Fkz9spS
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Set the ops structure as static const. The structure is not accessible
from outside of this driver and is not going to be modified at runtime.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 drivers/mailbox/k3-sec-proxy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mailbox/k3-sec-proxy.c b/drivers/mailbox/k3-sec-proxy.c
index 6f5ad37919f..6eebfcd3601 100644
--- a/drivers/mailbox/k3-sec-proxy.c
+++ b/drivers/mailbox/k3-sec-proxy.c
@@ -293,7 +293,7 @@ static int k3_sec_proxy_recv(struct mbox_chan *chan, void *data)
 	return 0;
 }
 
-struct mbox_ops k3_sec_proxy_mbox_ops = {
+static const struct mbox_ops k3_sec_proxy_mbox_ops = {
 	.of_xlate = k3_sec_proxy_of_xlate,
 	.request = k3_sec_proxy_request,
 	.rfree = k3_sec_proxy_free,
-- 
2.53.0


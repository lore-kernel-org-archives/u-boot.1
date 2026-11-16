Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C8B606A88F
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 17:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=0UJ55EU5;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=rN4J0b7s
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 77F2A40737;
	Mon, 16 Nov 2026 17:37:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id t4O4iNRfqE12; Mon, 16 Nov 2026 17:37:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org D019E4075D
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794850628;
	b=Dr0B6F4ZJpz+EeQ5opA7IYbFUac8N0U0XwLoxqpkBI+je+aI9ZDC3zGOX1Qp6B03qZlu
	 njELwqY86+5FiihrBnAkidDZGexRf7tAx3+L3W3qzLeS+T2vlmmhoUYmqBLX/6YjyIXYC
	 AwkVv3KPuAQWMuc0KgVgwedZ5rJAUelJEtyBLA0ZkBccqF9B+4nppQ1DCND4ZhTTcwY0H
	 MSJZCvSFFAaj497d44dZHnIX3ZRxC3WjUXUTfAmnhLP0aeMCpuJtgxKHAfCDOwL4gJ1v3
	 limW8NRC3sqkyka9S69yDWosM+dJ6SjrZcgh08imgpkmgHSTxH5keVgkSenFarj/jtA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794850628;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-MBO-RS-ID:X-MBO-RS-META:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=1K8HreyfuzPfL1U4wicLCJ3PamCkKfY3S2MB3JQ12/Q=;
	b=YSNGLUyhjLmRymuQ5Vae2k3FMMKxA4tncAaZEoHIslwJynj5aElhqHQvt+/XAGsEf90R
	 8gJNCIsKcw+HgoZYAW/3IVXRyMZJvCsRSauDlZ7txGb1xeF3rKQa8YHxGMHSARy6f4l71
	 Q0t3X8Ll42U6rJvBGJegOOr4aqZGyDirqe/jroLwdlQ3FgmpruN8VOulNVACyLVij//wD
	 x9sO0LXZ0eFN0h806Fd5B3Y4Py1HCDMoOun1BJXNg5E8o7Lvt1LR0wWNUeesC7WRm6lIR
	 9Q6ETNClVRPD+GODLgk8pxQmiUYF9MPwUVcUcBouiAfR5pzEvvYcu0mGkb4Mi2wfDBA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=mailbox.org;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=rN4J0b7s;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794850628;
	bh=1K8HreyfuzPfL1U4wicLCJ3PamCkKfY3S2MB3JQ12/Q=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=0UJ55EU5fJlcCtX3v8Tj4yE1WQugi9yKM6TeBesSI0zwRbPa8qEW190qUoOHvsjUO
	 LALcmfyrrsk6wj9YRbmJEq47JB1vy/NygmxuEEnki42LdtomSMWontFfFFED6+hxGc
	 OEdO9CRvOQQnoXiMuoSzj5/8hLWGjfFBBRdqLkgcApDjLSjPG1S2KS1t0giEc9Yw7b
	 txFE3dZ4mw9K4HZ7g6izlqMDXb9ABAkIHEAuhmERQHesvv98DV5hGEbrSp/4f0NFsR
	 lvVo7g7+6fiPzm40v2DI/X7gNbJq0mmHau2ogfs72ljE+OXCWG33v3xFIGrIUMuVEP
	 Va9ziE2sgG45Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D019E4075D;
	Mon, 16 Nov 2026 17:37:07 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 15ED928C
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 17:37:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id EE8874075D
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 17:37:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id W4WSjzlrZUSY for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 17:37:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B4A8140737
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=80.241.56.152
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.152;
 helo=mout-p-102.mailbox.org; envelope-from=marek.vasut+renesas@mailbox.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=rN4J0b7s
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B4A8140737
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 17:37:04 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4jSw6501v9zKr6g;
 Mon, 16 Nov 2026 18:37:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1794850621;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=1K8HreyfuzPfL1U4wicLCJ3PamCkKfY3S2MB3JQ12/Q=;
 b=rN4J0b7svG9iGpqjLKKrGZ36YDNcFDQrV8zvmCbjTSOOcAKcSFc27Q72DYCntmxdeeOk9L
 H9JGumUHZkSBuTjhYy4ETpAIuA1g/P7THV6aa98UqyIAe4Nadwv59SDPMwXwQTN5n9552Y
 r7X3UtPKPDXQYKSF18mptCkp80NZoZ4qJIeEEkx6PLp4iQmGJHD3KVQ8SSG0UO6Wu5oHYY
 prOOxe8JrVttR3W84EYecWa8pexm5F13JlcWiCh1Mt5TZBpPr95U1gTiwdErHX9CPraAX6
 P5LsR8rJix6dCmfKGAzuM5nhRArxKXwKOhF7PksReEywI+3CDAEujQfSTszYgA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] gpio: sandbox: Constify driver ops
Date: Mon, 16 Nov 2026 18:36:54 +0100
Message-ID: <20261116173659.3487973-1-marek.vasut+renesas@mailbox.org>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: befacb63c5559745218
X-MBO-RS-META: js7mafr7oy9ce64pq891b7swmniq8pcg
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
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org
---
 drivers/gpio/sandbox.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/sandbox.c b/drivers/gpio/sandbox.c
index 76aff0ed5aa..8b44dda738a 100644
--- a/drivers/gpio/sandbox.c
+++ b/drivers/gpio/sandbox.c
@@ -561,7 +561,7 @@ static int sandbox_pinctrl_probe(struct udevice *dev)
 	return 0;
 }
 
-static struct pinctrl_ops sandbox_pinctrl_gpio_ops = {
+static const struct pinctrl_ops sandbox_pinctrl_gpio_ops = {
 	.get_pin_name		= sb_pinctrl_get_pin_name,
 	.get_pins_count		= sb_pinctrl_get_pins_count,
 	.get_pin_muxing		= sb_pinctrl_get_pin_muxing,
-- 
2.53.0


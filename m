Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C404BC3DA59
	for <u-boot@archiver.kernel.org>; Sat, 20 Jul 2024 12:45:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D3D788C59;
	Sat, 20 Jul 2024 14:43:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="JdeRbVxp";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Ts5Swblo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6252C88C41; Sat, 20 Jul 2024 14:43:44 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B01888418
 for <u-boot@lists.denx.de>; Sat, 20 Jul 2024 14:43:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4WR5nV1qm2z9sT1;
 Sat, 20 Jul 2024 14:43:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721479422;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8Z5CAmjkEbRUkVdqCh3zq6YQnNayaR4AAvurilwz3Sk=;
 b=JdeRbVxpx4k/p0J0Vh76ZCvmkUGlH1TsfO6uTBgD5bAj6Ll0kt/DM5Aq83dDlNWYwaiJSF
 uxg7RlgOQAiPRjTuSJCkU/oyUlPhcHSenk7J7ANShFf/dcdKJuoVXcN7Ja2YhnjjfnGFZp
 TOxvz8ELW0OvpeOAoVQffmXyHEfxx42+cX7G5b2U0Qn5ZjyTr/H0ghaEUW6TbHkAtrJpIr
 9phT4ciMeUnVKzpHRuexJCDvksXLMsiv6wumpPGTsafQz+lOiOFYWMrTsNA+/6rkc2ZsDS
 FBZQ7f1q5YvqQ/xjA8rkDJQuC7aTto2t54k64I83UIieqc2smt/V+JkBzpjAVA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721479420;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8Z5CAmjkEbRUkVdqCh3zq6YQnNayaR4AAvurilwz3Sk=;
 b=Ts5SwblooXJCFTyTHe9SW8ZN+TLhFnS3dPgE43zm1wCQxmDU+szjVr8Rd6p/jfMTLjad9G
 wB8MttBDbHMJpPNaN9XLp8YkWV4AmgejByz6Ehq1hT5YBG/mnLeP5Lu/59NxK82QrLXR4R
 h9bO+9M/f61fyqmwfCXw4dMT7CZEJUgCFElummyiwmK6WzGDf+zj9a9OClYa/2svDjATvP
 9AeqiPrfwdxw1CJF00N1u6jQEzGuS+MqwFMO0hwMr2mzG1w/o4zwyBtwltntDLbIOvALp9
 uGnaLuZchWOOg4t+zQCvPQ5syXmaRRoAzqPBI5zTabwP8VaKdf+KbEg7vrJ2jg==
To: u-boot@lists.denx.de
Cc: francesco.dolcini@toradex.com, seanga2@gmail.com, sjg@chromium.org,
 trini@konsulko.com, Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 11/40] drivers: firmware: Remove duplicate newlines
Date: Sat, 20 Jul 2024 14:40:36 +0200
Message-ID: <20240720124239.7553-11-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240720124239.7553-1-marek.vasut+renesas@mailbox.org>
References: <20240720124239.7553-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 590f72fd945fb4899e8
X-MBO-RS-META: z9td9eeejquynqy8s63j4zteqgkwiknr
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

Drop all duplicate newlines. No functional change.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
 drivers/firmware/ti_sci.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
index 8ce0f46e70c..e591333ba38 100644
--- a/drivers/firmware/ti_sci.c
+++ b/drivers/firmware/ti_sci.c
@@ -139,7 +139,6 @@ static struct ti_sci_xfer *ti_sci_setup_one_xfer(struct ti_sci_info *info,
 		return ERR_PTR(-ERANGE);
 	}
 
-
 	info->seq = ~info->seq;
 	xfer->tx_message.buf = buf;
 	xfer->tx_message.len = tx_message_size;
-- 
2.43.0


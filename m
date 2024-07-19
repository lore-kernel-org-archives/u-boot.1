Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CC26C3DA59
	for <u-boot@archiver.kernel.org>; Fri, 19 Jul 2024 10:54:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D28D88C21;
	Fri, 19 Jul 2024 12:50:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="KsJksXo7";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="ErYthvpi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 001FE88BDB; Fri, 19 Jul 2024 12:50:43 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 296A588BDB
 for <u-boot@lists.denx.de>; Fri, 19 Jul 2024 12:50:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4WQRKY6l2zz9sls;
 Fri, 19 Jul 2024 12:50:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721386242;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pzfXpPHdrF4OZgtgEi2hPnVT+0Ah5XBwkO6Tos13dUU=;
 b=KsJksXo7/BlxnpHo0UkFd8JX3EVURzRgrhbnl8Gq1EnAwys2nI4wbQxylB3LRoFC+173LB
 5vBCPRf2A06rJ+Ag4DEpNmH+rlqKLvtJDqnAuhu1KgiO0zLlxY1u7q6vVvoes5syuj3mfN
 JLDU/VKxFKbpsQz2OVpZV8dYlYQQfvLsEF9khlo6+gGWz9s/i1naoFnSpdK0jsJqIOR8o/
 saq6Qco/dNHAVRHQLiUGtgPwbeuJEBvxc+5mblT8t96xpcvz3O8vIP/NDGgLJZaJjXq6Yz
 803h5XRm074Ant5r97OUbJhLk2DrwX0vKlhL1gA8aoQETTadTv2LMLq/UkHawg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721386240;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pzfXpPHdrF4OZgtgEi2hPnVT+0Ah5XBwkO6Tos13dUU=;
 b=ErYthvpi6hO2Zx52hvhkYdskycjcspOHuCoA0JSTK1QFjHrWXAzWJQmgzelCcPljU3XjM9
 2iqmiGB00UpIhyV/Nb+gYBZrsV5hPAXIaWve0YJx12P+nDUSAUSm9u+NoQUtj27Aw4tTD0
 ofbtjY+xGdl76Ois+4UYOR+5M7iUDtq4Vvyc+q4vyVlYi3VCppVVrUAaPLY6c7WfOPurL2
 vLNpicNee+TLK9lRxz886fGcC946aLmJ4pinczvCnD9SWUfLOz9INtVHaiP5x+x1rpa087
 9jdTv90KE2ph5NRP8SQuFqE6uBm44e0ewcv4BmJKjXA1szvCSFiwZK0MHM609g==
To: u-boot@lists.denx.de
Cc: francesco.dolcini@toradex.com, seanga2@gmail.com, sjg@chromium.org,
 trini@konsulko.com, Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 24/37] board: opalkelly: Remove duplicate newlines
Date: Fri, 19 Jul 2024 12:49:01 +0200
Message-ID: <20240719104948.323791-24-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240719104948.323791-1-marek.vasut+renesas@mailbox.org>
References: <20240719104948.323791-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: pew7oi6h6midmsba33zyfb98r87nquy3
X-MBO-RS-ID: e56b3bdbb7465b86f93
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
 board/opalkelly/zynq/zynq-syzygy-hub/ps7_init_gpl.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/board/opalkelly/zynq/zynq-syzygy-hub/ps7_init_gpl.c b/board/opalkelly/zynq/zynq-syzygy-hub/ps7_init_gpl.c
index 0cbfc08183c..1c63277d928 100644
--- a/board/opalkelly/zynq/zynq-syzygy-hub/ps7_init_gpl.c
+++ b/board/opalkelly/zynq/zynq-syzygy-hub/ps7_init_gpl.c
@@ -254,7 +254,6 @@ unsigned long ps7_reset_apu_3_0[] = {
 	EMIT_EXIT(),
 };
 
-
 int ps7_post_config(void)
 {
 	return ps7_config(ps7_post_config_3_0);
-- 
2.43.0


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21293CCF9E0
	for <u-boot@archiver.kernel.org>; Mon, 27 Oct 2025 16:39:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B2FAE838D5;
	Mon, 27 Oct 2025 17:39:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="Ovw63GGz";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="c4Yqb8xb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5DC84838E7; Mon, 27 Oct 2025 17:39:13 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7150E838AB
 for <u-boot@lists.denx.de>; Mon, 27 Oct 2025 17:39:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4cwK331WrSz9tSq;
 Mon, 27 Oct 2025 17:39:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1761583151;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=i8Ne6cdEsyOT0yTH/0JJ6slq4W71CdSLNlQKhxvovYo=;
 b=Ovw63GGz9VANCHKyX6zBysLSQO8TyQudtEtc4/fs6A4At4aVYOozaXv5dnviubfsTO0IB/
 jF1H9dYC5ROuoGSYvdI6hroFIabkBl36FON9hCUcJh2ChFpB9N0N6x0aRcpM9mz5MMQtqH
 FL7+vQtcrTfPuTvx697lJfbUH7OptJf6MG1KO3QKPqVdjzP/OxSAy2Nlr9Q5/tw3hLPexs
 /xFbP2l8SOKdaUwR+nKbLEquP3r4D8+d24hlyb5TFsk/9iC1l9pqIpemF5PjOpgNQQDBYc
 AasfahSTFT0nlc6ECr025h3bHF5wTA1yzDZ2Fe111Ps9E/D+Y1nmrwmgypchmg==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=c4Yqb8xb;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::1 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1761583149;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=i8Ne6cdEsyOT0yTH/0JJ6slq4W71CdSLNlQKhxvovYo=;
 b=c4Yqb8xbBHlwwc83g4sDHsBgNXQujXPB1PaHa3ihmsM3wjaGZ2IgE8A4jFjL5r+gCjNcbj
 7w/29sQ5aBp4+bsYiho7dPHFZvF0oRX76Mn/N17OcPy4sarfj0FK1MGVop2jvh2nR518Hj
 os8UUE9OG7zwlKJbJvwjfi3BmnT1xZbXr2l59xed41IM7svZia6fp7UrBNTfy4ZEvbLbn2
 thH1F+buyG7G2jCdX+YRURkHcj5cUG+KJQxmrtXkg2dWLVAcnxZ6IVHgpEIY9+DitQ3ONW
 i1kFRSIpEuDMc88rZZB/fvkIZyZ6Newu24Ru1wEg3/xoy1wZGf/8sPT/XpLUGg==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Alice Guo <alice.guo@nxp.com>, Jamie Gibbons <jamie.gibbons@microchip.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Peng Fan <peng.fan@nxp.com>,
 Tom Rini <trini@konsulko.com>, Tuyen Dang <tuyen.dang.xa@renesas.com>,
 Viorel Suman <viorel.suman@nxp.com>, Ye Li <ye.li@nxp.com>
Subject: [PATCH] mailbox: Allow operation without .recv callback
Date: Mon, 27 Oct 2025 17:38:38 +0100
Message-ID: <20251027163904.11814-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 18qpr6ebb9k3egys1rg68ormrjb8nqh8
X-MBO-RS-ID: 2879d18395b5ec05f42
X-Rspamd-Queue-Id: 4cwK331WrSz9tSq
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

Some shared memory mailboxes may have empty receive operation,
because the data are polled by upper layers directly from the
shared memory region, and there is no completion interrupt or
bit of any sort. Allow empty .recv callback, and if the .recv
callback is empty, exit from mbox_recv() right away, because
any polling for completion here would be meaningless.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Alice Guo <alice.guo@nxp.com>
Cc: Jamie Gibbons <jamie.gibbons@microchip.com>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Tuyen Dang <tuyen.dang.xa@renesas.com>
Cc: Viorel Suman <viorel.suman@nxp.com>
Cc: Ye Li <ye.li@nxp.com>
Cc: u-boot@lists.denx.de
---
 drivers/mailbox/mailbox-uclass.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/mailbox/mailbox-uclass.c b/drivers/mailbox/mailbox-uclass.c
index 4bf4987ce0a..fef437a4281 100644
--- a/drivers/mailbox/mailbox-uclass.c
+++ b/drivers/mailbox/mailbox-uclass.c
@@ -132,6 +132,15 @@ int mbox_recv(struct mbox_chan *chan, void *data, ulong timeout_us)
 	debug("%s(chan=%p, data=%p, timeout_us=%ld)\n", __func__, chan, data,
 	      timeout_us);
 
+	/*
+	 * Some shared memory mailboxes may have empty receive operation,
+	 * because the data are polled by upper layers directly from the
+	 * shared memory region, and there is no completion interrupt or
+	 * bit of any sort.
+	 */
+	if (!ops->recv)
+		return 0;
+
 	start_time = timer_get_us();
 	/*
 	 * Account for partial us ticks, but if timeout_us is 0, ensure we
-- 
2.51.0


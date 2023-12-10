Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34410C4167B
	for <u-boot@archiver.kernel.org>; Sun, 10 Dec 2023 21:25:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 79AE78706B;
	Sun, 10 Dec 2023 22:25:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="i2P1LwGK";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="sMOCOGcx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 67F56876F2; Sun, 10 Dec 2023 22:25:38 +0100 (CET)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3256586F42
 for <u-boot@lists.denx.de>; Sun, 10 Dec 2023 22:25:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4SpHwb4stdz9sZq;
 Sun, 10 Dec 2023 22:25:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1702243535;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=tqW9W3VcYjWafBdHUfvzGnxOTeSkyWYaQDp0VbPbyjo=;
 b=i2P1LwGKc4vv7HybouQ21Ap3CmqSQ43x8P0TBVz6Dj1awMShFVsdDM6WMwRVhtOWdnng2p
 4TwYnwULToo1ts1AN1MFpjvmU7aBziD4Pt+WZU6VzjeXeCHLAUf1P6wAhKcRwDvRMVGewp
 sTxyXYJ2iEuqQIY2VboAD2sw0+vrOsJAgxZiqhAecQ5X0yuZqB4RNjmUyv28jQiD2qM2jx
 ai3X8Hqpm06fyiVsNiA01hjIByQuHCnlOz01sxTKVWWgF2XIxY7Z3zK8sJEJtoXF88bMPa
 tbKSmjZWvOfHsHhvL7ni06IUgJk/ajsjw+afxwdf9QXj4X4TPERcuBiSHEN9/w==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1702243533;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=tqW9W3VcYjWafBdHUfvzGnxOTeSkyWYaQDp0VbPbyjo=;
 b=sMOCOGcxUD1wYmFHy4Aa6nyGXM5rg3g6B/jKvcqIA4NLYKaP7qql6dDmv4uo/FjA8NRnU0
 WEJOlFtmGIZl6zI7Z4x8lkes3xQyre0yHC2J/6W8JmSDrn0lvKe8iyx+Qwn9nhh02UeyaP
 qNNexP29bw+1GDjls/LAMvvqT6Mb0AYiZpQfiSKgNpAwO1bWAPDzbp4fiCiM7noJtDnFpz
 /pB/JjkWZDpsezV9rhV20ff2WgUzvLFGAFMpjVNwpW3+o0zh4G9U5Zdv1/zanxcp0M8mdX
 9fOAEbtLFiizculBEsutetDlQGMNGGZ3b4X+0RXHMImvAO3d5PR55KgciAgH6A==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] cmd: part: Cover both part type entries with GUID ifdef
Date: Sun, 10 Dec 2023 22:25:07 +0100
Message-ID: <20231210212522.398132-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 33nmwhyz9h53cy48yq5ykp3tu8ejjg71
X-MBO-RS-ID: d083a4276ddce1b2925
X-Rspamd-Queue-Id: 4SpHwb4stdz9sZq
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

The 'part type' subcommand depends on GUID partition table support.
The help text exposes one of two 'part type' subcommand entries,
hide both in case GUID partition table support is not enabled to
avoid confusing users.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
---
 cmd/part.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/cmd/part.c b/cmd/part.c
index 0ce190005d3..c75f85acd52 100644
--- a/cmd/part.c
+++ b/cmd/part.c
@@ -308,9 +308,9 @@ U_BOOT_CMD(
 #ifdef CONFIG_PARTITION_TYPE_GUID
 	"part type <interface> <dev>:<part>\n"
 	"    - print partition type\n"
-#endif
 	"part type <interface> <dev>:<part> <varname>\n"
 	"    - set environment variable to partition type\n"
+#endif
 	"part set <interface> <dev> type\n"
 	"    - set partition type for a device\n"
 	"part types\n"
-- 
2.42.0


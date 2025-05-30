Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 136A5C5B543
	for <u-boot@archiver.kernel.org>; Fri, 30 May 2025 22:05:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3ADE482B0E;
	Sat, 31 May 2025 00:05:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="cEj8XMis";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="uwuMEOkA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DCFF182BD9; Sat, 31 May 2025 00:04:58 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A465A82B07
 for <u-boot@lists.denx.de>; Sat, 31 May 2025 00:04:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4b8HN83CWBz9t96;
 Sat, 31 May 2025 00:04:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1748642696;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=dVr4+mmZ+B+wX2eaXJMi9J6DxI/k5EbgXwjhq5Ox85o=;
 b=cEj8XMisn92W6rV2NjEKC/3kyEudF8UAqzEJB1D3xAKB3gOn3ndOA3ckPibdohm2WZeQQS
 gskHmRNh7FuTI5RCvcVKYYVCTyftiaRIZ4Qlc79FwUqYFqO/8Pt5up3G+X+l6ptyC0tOS0
 VzS2Wjb1TwGaoAEnkNE7qKq9zXNncsJAtwfM6XpJVo68KFAjWbu9pwWERz0vA1yb0Dpky5
 6YkS6Sctxz2ZYoQNpPxj0P+mY0XFpQS552r2paLf5VShmBW5pch6AGYN1ogUnl4Usf36eK
 0o05FmzlNkr3D/mHnDo8hLrCyf37zztQO/PiZ8IEll5CxQ3opwouzfVMeCMxTg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1748642694;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=dVr4+mmZ+B+wX2eaXJMi9J6DxI/k5EbgXwjhq5Ox85o=;
 b=uwuMEOkA7SA2vciZgogkiyOzLbPfA/YbYCKU1nLYEm24Rm8IrYGhkA6VqACK1dH3yL1iRF
 ithy9CrreVqX+fPTPXC2PvDdo+nDLjmolXzSuEY6irhaEhc5HO0q0S1GWqIqLlaVfpzPtW
 eFMyvi9Um6g26KvAdEhxhQ5ex9CgGbPexBDutdvgPQyu0U+JPFZBnfot3o0FIaN7XmMZaw
 REuMKqwhSukeHuPMQ30Wd5+edhyhSoDsnFm+bbTCfmr2wgAURI7xAPu2wTdrBQNT6yCISe
 D59Hc92AfoUVp4pa8u2KvbtkmBZXyMBN8IqpqWIXs25YXKjJ6vkkKHqi+5XjQw==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/2] arm64: renesas: Introduce renesas_dram_init_banksize()
Date: Sat, 31 May 2025 00:03:39 +0200
Message-ID: <20250530220420.26891-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 4woyo1b6g48nzsowbhpuwifqp4zphfui
X-MBO-RS-ID: b50141908cbee0ab2f1
X-Rspamd-Queue-Id: 4b8HN83CWBz9t96
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

Introduce weak renesas_dram_init_banksize() function which is meant
to be used to adjust DRAM bank sizes after the common Renesas board
DRAM bank handling code finished. This is mainly meant for boards
which ship with multiple DRAM size options, which can be detected
at runtime. This allows such boards to ship with single U-Boot
binary on all boards.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 board/renesas/common/rcar64-common.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/board/renesas/common/rcar64-common.c b/board/renesas/common/rcar64-common.c
index 69229ea3cb0..bcb03792494 100644
--- a/board/renesas/common/rcar64-common.c
+++ b/board/renesas/common/rcar64-common.c
@@ -36,6 +36,8 @@ int dram_init(void)
 	return ret;
 }
 
+__weak void renesas_dram_init_banksize(void) { }
+
 int dram_init_banksize(void)
 {
 	int bank;
@@ -58,6 +60,8 @@ int dram_init_banksize(void)
 		break;
 	}
 
+	renesas_dram_init_banksize();
+
 	return 0;
 }
 
-- 
2.47.2


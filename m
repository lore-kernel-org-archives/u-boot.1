Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6CFFCD3447
	for <u-boot@archiver.kernel.org>; Sun, 10 May 2026 01:42:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9BE5284A49;
	Sun, 10 May 2026 03:42:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="pJTS7dni";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E60AE84663; Sat,  9 May 2026 19:59:57 +0200 (CEST)
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com
 [IPv6:2607:f8b0:4864:20::102d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA5FE845E9
 for <u-boot@lists.denx.de>; Sat,  9 May 2026 19:59:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tanmay.kathpalia@gmail.com
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-36536771300so2928039a91.1
 for <u-boot@lists.denx.de>; Sat, 09 May 2026 10:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778349594; x=1778954394; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=8e9tpAHtbErUyIzUxjPlOTgCnVBK8+3E/ZHqxwr1RSA=;
 b=pJTS7dniZR1KJ23XpSgOftcpi9a7nRuiSN6fzWMbUcVxEg+ZlJRUev712QEojMj80m
 br1H+ZYqNR9wrD1Z+6Z1QrXB/DYlr2Nk+NrnBSJac0C27chwFSYaP7RTzemydwzQeDPs
 SHkIuETHayxCv2GLLVD5xrOgYA+baB45MBApcOeGzDc9V3C6UUSGn9QtXBW7Me5V6s/q
 PO7cYXF7SjEbEv8avvRqiZ4jdg/A5LgRgC4YXbHoFGN6jdWUTJz9hc4oT51UpV/DhML9
 OyIseVyLpr/7zUKp7pQo+Tl18gXIg1n9a1qFFVyePIsTJnlMD9/yydWZ5nscEtQWs3Ya
 06/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778349594; x=1778954394;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8e9tpAHtbErUyIzUxjPlOTgCnVBK8+3E/ZHqxwr1RSA=;
 b=XBURtA5QaVSfQfKY650kZPkTlLXt612r/hccfUYsEVJaDyjs2BBWQ83HhPL6NPTJhN
 ++k3KVRGfc12XJLPDmrUQlZT0cfGtwMraWDyrVBkagxuCgj20ZpgVql+rvwlhSgZA+9W
 2SrDe05c13j3iJ64Imsxqx8iSCLep9EkE92NdMfnEcmrAScntVMWf5PZHAKgqxPgZsli
 Lt8Kmg+//mvWFe0HYZCxiHs4eaLwtF2nFlxUpXL/wDASz0RF2ho+dMdZfGANbSxo5O0+
 T6FbmuBKNzR2RjJeXF5JPoNg9qZqi1vuNXXGOC7AS65Z9EF+wwqhoJfjvNIlgzfiv7rq
 Q7tg==
X-Gm-Message-State: AOJu0Yyev5dv9QaJlvPdilau2/Lqgqjy+VzrG8SO32ZcpdDRd5UlPQFu
 gPeW7REefyoTYA4gfrd6sGD4DMugy97ibe82yoZu76x8f3Ge6tPSjBASGSkMnTpRrMM=
X-Gm-Gg: Acq92OE7f2HWzCbvApmp+ngyuLGiuLIxTNlw53QKlPFVzLYxlyccFLHFPz4EBty8gb9
 uELnaH2xRib+n6a0MoRoafTcv90rH3wJiEFI8FI5wum2gIxprNEAPQlNFxfOfce7e1QJmRhKpEX
 eP7DfEeBR4cnIN2xQUo4RmKd3yNC3mGAPrZoi9rNXYx2UfcBjhNUcxuOryjQQRv1XTtDavpcOXd
 thmt03UoR1JWzewt/kmoxREe+6+3wNEGX/v3WyVb+MAshKq9ottJ3356PvuKfi3UQC7yjZ0NwqY
 xBGa5n3vNIMzdzo5GSWJzVo8Th0WM9+DAYS+c5u/5VUqnAYsHVqRboTtQifk016+qLJXZS8jxNg
 lcM8zZQGKvFG6OADVoZsYYD4eqYEK/UjBspDuloBr3MF66q1ohyJYbfwKHyf7YZ48MTIdzIifJv
 jXdcpqolK+pDswjFDZLP2W5U/GJuDBzKMdw4lLwIA0mlo5pg==
X-Received: by 2002:a17:90a:d646:b0:356:21e9:73ff with SMTP id
 98e67ed59e1d1-366055e69demr9522563a91.11.1778349593748; 
 Sat, 09 May 2026 10:59:53 -0700 (PDT)
Received: from partlink-A8.. ([122.161.53.136])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-367be784e0asm1563275a91.3.2026.05.09.10.59.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 May 2026 10:59:53 -0700 (PDT)
From: Tanmay Kathpalia <tanmay.kathpalia@gmail.com>
To: u-boot@lists.denx.de
Cc: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Tom Rini <trini@konsulko.com>,
 Tanmay Kathpalia <tanmay.kathpalia@gmail.com>
Subject: [PATCH] mmc: sdhci: Start status timeout after command issue
Date: Sat,  9 May 2026 23:29:32 +0530
Message-ID: <20260509175932.263105-1-tanmay.kathpalia@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 10 May 2026 03:42:13 +0200
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

The status polling timeout in sdhci_send_command() should measure the
time spent waiting for the command interrupt after the command has been
issued.

Do not initialize the timer at function entry, since the command inhibit
wait and setup path can consume time before SDHCI_COMMAND is written.
Start the timer immediately after issuing the command instead.

Signed-off-by: Tanmay Kathpalia <tanmay.kathpalia@gmail.com>
---
 drivers/mmc/sdhci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/sdhci.c b/drivers/mmc/sdhci.c
index 648dfa4b5ef..08594e10266 100644
--- a/drivers/mmc/sdhci.c
+++ b/drivers/mmc/sdhci.c
@@ -215,7 +215,7 @@ static int sdhci_send_command(struct mmc *mmc, struct mmc_cmd *cmd,
 	u32 mask, flags, mode = 0;
 	unsigned int time = 0;
 	int mmc_dev = mmc_get_blk_desc(mmc)->devnum;
-	ulong start = get_timer(0);
+	ulong start;
 
 	host->start_addr = 0;
 	/* Timeout unit - ms */
-- 
2.43.0


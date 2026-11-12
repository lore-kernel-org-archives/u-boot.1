Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C78C606A332
	for <u-boot@archiver.kernel.org>; Thu, 12 Nov 2026 12:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=oScKYTzj;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ziyao.cc header.i=@ziyao.cc header.a=rsa-sha256 header.s=zmail header.b=COTTkM8m
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DE4A7815B6;
	Thu, 12 Nov 2026 11:59:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Y4eVFEzFIt4c; Thu, 12 Nov 2026 11:59:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 46B7B81746
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794484799;
	b=aRLm5ftlF23P0x9tNCh202pxaER1nhEUnE0UUFcXgUV8DGOYCvS3wxhwoWk4oieBaYmd
	 ZAxb5IB77R+/Viuqt2niExdxZGWNajV8w2O3+jSSssNo2WicU9tIRgBvh1RsOP57uTmSb
	 RVZZsr5WlX2Gp9JNs1jZ6AlulRmqKb4HbKB2kuyk2CHtBQR2i/Pw3xfLbcvGv0mF+xgHT
	 z2XAY5UQCOrWNJixHECRpZqyLuIskQg83jCqACgm8lnn52wFzt0zDngv9O47/qzExqEJ8
	 nKkvP7dcpFZnneInWoqMxal/Cr/3i9fW8L1VJwILPiaB86WS9QFcfwOR9lflMszgxsQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794484799;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-ZohoMailClient:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=a91XGA7PeQMK73UB5xEBnVXhnhgR9YRX4ae2N8b/b9o=;
	b=HRJZ1O/24DyxiFSQiAzFuiCrYm04wh2MndesJBhiv817IYAYljknQTZ4zjnOQa+wKDEz
	 95szYesQ0vO18BmWs7bHSBJe6UjNqWefZkLs+/8vesDDwFy4gk3TMAFXVk1HbdvKAPJQB
	 JCUds3GluOGyBZw8P1qHu30gvVmlH45FirtzAZoYN12+fThb7mmagIPqj9OLOcuFxSpzR
	 9AfTuDIJw2FzTTyE9QaEihkxOZeTR/XE/bPHk9hStSqiEsde0DL/IGLE2P7ZXdSgebbAQ
	 jYw9M8d/o8tIgewrct7NLbx0xNRkYu+22J9f7EznYj4IvCLZt+OgmcClskkkp+Vj7Ng==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794484799;
	bh=a91XGA7PeQMK73UB5xEBnVXhnhgR9YRX4ae2N8b/b9o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oScKYTzjCF9NyaJEypsajuOQTWHPkBeWQdHo2ljIEiPj32xGzNO9n+8E5R2iv/G4n
	 U9fpkEWgbUwiPeklhCsz5XTht+sUt32/VwU4JXrpMSwhRPdpDxInfi9SmQsSy9DYCq
	 lkXDpkeiaaQ/Dsz44lP7dsltEjWLqduLyKeNrXSNEu24QL8c4riPobEyek8d+KB5hU
	 Ul4lUWsV7co5AzAbE6Bifr6YmotSPKLVKStr/zwtO1Z++hvpoWbILtjUlhDh1cI7jH
	 iI3vinA/7kRgYSj1ob6va7mYwR94L0O9+rxS6lxTnkG+S51d7Jvg7iql50qdGtMPxk
	 UoyjM2aSQLDdg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 46B7B81746;
	Thu, 12 Nov 2026 11:59:59 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 1CDAA28C
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 11:59:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9997360AB3
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 11:59:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ye5b1R5xmRSa for <u-boot@lists.u-boot-project.org>;
 Thu, 12 Nov 2026 11:59:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 08B27607F7
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.182.15
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.182.15;
 helo=sender5-op-o15.zoho.com; envelope-from=me@ziyao.cc; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=ziyao.cc header.i=@ziyao.cc
 header.a=rsa-sha256 header.s=zmail header.b=COTTkM8m
Received: from sender5-op-o15.zoho.com (sender5-op-o15.zoho.com
 [165.173.182.15])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 08B27607F7
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 11:59:44 +0000 (UTC)
DKIM-Signature: a=rsa-sha256;
 b=COTTkM8mxzjBxbZy9tyhLcMeoTqqJuICUX3SJroPghB2aCRLW/y/WrV7YQ92Sst8bEbOg3wmaVJ8iH/3Phy1ofm70SUJ5HUoUXScNtpyj5sdyqHsblT10VSqu0D+7GBZ4BUTuIrNVpJKFQ+npwb33/PnSMNsg4LnukPzZtov0G0=;
 c=relaxed/relaxed; s=zmail; d=ziyao.cc; v=1;
 bh=a91XGA7PeQMK73UB5xEBnVXhnhgR9YRX4ae2N8b/b9o=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1794484616119651.7869527256834;
 Thu, 12 Nov 2026 03:56:56 -0800 (PST)
From: Yao Zi <me@ziyao.cc>
To: Tom Rini <trini@konsulko.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org, Yao Zi <me@ziyao.cc>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v7 12/20] board_f: Add LoongArch path of mon_len calculation
Date: Thu, 12 Nov 2026 11:54:30 +0000
Message-ID: <20261112115438.1837663-13-me@ziyao.cc>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261112115438.1837663-1-me@ziyao.cc>
References: <20261112115438.1837663-1-me@ziyao.cc>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

gd->mon_len is calculated in the same way as SH and RISC-V.

Signed-off-by: Yao Zi <me@ziyao.cc>
Reviewed-by: Simon Glass <sjg@chromium.org>
---

New patch since v4, to ensure U-Boot correctly reserves its own space
for relocation, even without SYS_MONITOR_BASE enabled through
MTD_NOR_FLASH.
---
 common/board_f.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/board_f.c b/common/board_f.c
index 2f26b4644cae..22650d9d003c 100644
--- a/common/board_f.c
+++ b/common/board_f.c
@@ -292,7 +292,7 @@ static int setup_mon_len(void)
 	gd->mon_len = (ulong)_end - (ulong)_init;
 #elif defined(CONFIG_NIOS2) || defined(CONFIG_XTENSA)
 	gd->mon_len = CONFIG_SYS_MONITOR_LEN;
-#elif defined(CONFIG_SH) || defined(CONFIG_RISCV)
+#elif defined(CONFIG_SH) || defined(CONFIG_RISCV) || defined(CONFIG_LOONGARCH)
 	gd->mon_len = (ulong)(__bss_end) - (ulong)(_start);
 #elif defined(CONFIG_SYS_MONITOR_BASE)
 	/* TODO: use (ulong)__bss_end - (ulong)__text_start; ? */
-- 
2.56.0


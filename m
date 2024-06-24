Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45874C2D0D1
	for <u-boot@archiver.kernel.org>; Mon, 24 Jun 2024 09:47:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E2BB87FA1;
	Mon, 24 Jun 2024 11:47:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="RVLLf3gh";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="S2mdR4V3";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="aVxmoOjg";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="CVsOSGxg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C5BC888020; Mon, 24 Jun 2024 11:47:02 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B6D7387DEA
 for <u-boot@lists.denx.de>; Mon, 24 Jun 2024 11:47:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=schwab@suse.de
Received: from hawking.nue2.suse.org (unknown [10.168.4.11])
 by smtp-out1.suse.de (Postfix) with ESMTP id 06AA621A09;
 Mon, 24 Jun 2024 09:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1719222420; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type;
 bh=Au46Cc86aUsiK2vLjv8br1UJhRdhL7emai0EsU4FwM0=;
 b=RVLLf3ghw0c82yS2iyhnoDWJaOjCpDNgjiNk8IrEod2q1IMr1FxO5cs7qL7aHaJ5uzGWHx
 HxPhfxcBUgAdtxx0iS8jguSUu2Usf7cKgqp0jBdH/IlrEpuev+I7c1HCMwFL3Hdu4IMVH5
 9fI15vU2h4XMKLQikbxskkFpxYn5+OE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1719222420;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type;
 bh=Au46Cc86aUsiK2vLjv8br1UJhRdhL7emai0EsU4FwM0=;
 b=S2mdR4V3Jf3nM5xBSraFUAIKDPTNpzOUIKnXnDnL+T8xF9RF9YMq8OPW3QbW8lWqP2Wv5c
 tJW88hUrgycxSBBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1719222419; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type;
 bh=Au46Cc86aUsiK2vLjv8br1UJhRdhL7emai0EsU4FwM0=;
 b=aVxmoOjgwSMR0NV7hdW41GOAbiqeos7h3KlZZ4G1PXV4aq4q0ok1P+zoM6H9hFDB/1M4zO
 Zjoe6137Y56qU7njvAzd5erVhSM/EeCWqjuwW2aUQzxSHsv0HlhFz6m1oFtlRQqk3moQuh
 M6xKxeXCT9i1P5ClXEXd9FeQ7fVpHPQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1719222419;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type;
 bh=Au46Cc86aUsiK2vLjv8br1UJhRdhL7emai0EsU4FwM0=;
 b=CVsOSGxg7s8U3RP6cPOC8V8DfeTGUAXLrDfXeOkpSUNzfLsrZLd5r2v0eAzBNTDklG+Yjk
 oyw2eMUHwbngJ3BQ==
Received: by hawking.nue2.suse.org (Postfix, from userid 17005)
 id EB0BB4A03D4; Mon, 24 Jun 2024 11:46:58 +0200 (CEST)
From: Andreas Schwab <schwab@suse.de>
To: u-boot@lists.denx.de
Subject: [PATCH] board: sifive: unmatched: remove extra space in fdtfile value
CC: Yong-Xuan Wang <yongxuan.wang@sifive.com>, Tom Rini <trini@konsulko.com>
X-Yow: I've been WRITING to SOPHIA LOREN every 45 MINUTES since JANUARY 1ST!!
Date: Mon, 24 Jun 2024 11:46:58 +0200
Message-ID: <mvmsex2pt9p.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-3.36 / 50.00]; BAYES_HAM(-2.17)[96.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.998]; RCVD_NO_TLS_LAST(0.10)[];
 MIME_GOOD(-0.10)[text/plain]; MIME_TRACE(0.00)[0:+];
 FROM_HAS_DN(0.00)[]; RCVD_COUNT_ONE(0.00)[1];
 TO_DN_SOME(0.00)[]; ARC_NA(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 DBL_BLOCKED_OPENRESOLVER(0.00)[hawking.nue2.suse.org:helo,suse.de:email]
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

Fixes: 44a792c994 ("riscv: sifive: unmatched: migrate to text environment")
Signed-off-by: Andreas Schwab <schwab@suse.de>
---
 board/sifive/unmatched/unmatched.env | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/board/sifive/unmatched/unmatched.env b/board/sifive/unmatched/unmatched.env
index 0f1e5a7174..34425dc9ef 100644
--- a/board/sifive/unmatched/unmatched.env
+++ b/board/sifive/unmatched/unmatched.env
@@ -16,4 +16,4 @@ partitions=
     name=loader1,start=17K,size=1M,type=${type_guid_gpt_loader1};
     name=loader2,size=4MB,type=${type_guid_gpt_loader2};
     name=system,size=-,bootable,type=${type_guid_gpt_system};
-fdtfile= CONFIG_DEFAULT_FDT_FILE
+fdtfile=CONFIG_DEFAULT_FDT_FILE
-- 
2.45.2


-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."

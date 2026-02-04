Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2858CEA7944
	for <u-boot@archiver.kernel.org>; Wed,  4 Feb 2026 20:34:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 94D71839DF;
	Wed,  4 Feb 2026 21:34:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=nwl.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=nwl.cc header.i=@nwl.cc header.b="h1dOScby";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 939E883A36; Wed,  4 Feb 2026 21:34:25 +0100 (CET)
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 493C28341A
 for <u-boot@lists.denx.de>; Wed,  4 Feb 2026 21:34:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=nwl.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=phil@nwl.cc
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nwl.cc;
 s=mail2022; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
 Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=upy9uygjpRXpWEUOyXS5jWQV23NdkA1FNpJmrsDAw/s=; b=h1dOScbyJU7y8LGxNaj/+AbuSC
 6nqFnTU4gZ/uZbGY0XDdYHIdpadies3QA9SvH3kNA5SKgSmrxMmJFqj459pjljMWsQmokpkX0s+1o
 JbkAxqJhzjqYrwPgg/h5mPOvzqswF2JeWngaBnT35aF+nEdoV2GJOgDk6F1lR6cxZm0mMvmeszAZT
 dkMsxqhQZGnhL6nGdMaBC2mBqJDzIrzQdl0+/roEpGizXq6b92cFiwbikIKyp61S+AZxDTm9GQY6x
 CmajhTnlUwNgWTnakG7WCOIAmqofhJtLShAwBpsjzL22TDJTsMGH0F0PrXFEr/S2fBfaQz5Gmhc9S
 +9/Hfn4A==;
Authentication-Results: mail.nwl.cc; iprev=pass (localhost) smtp.remote-ip=::1
Received: from localhost ([::1] helo=base)
 by orbyte.nwl.cc with esmtp (Exim 4.98.2)
 (envelope-from <phil@nwl.cc>) id 1vnjZu-000000001I8-2LjM;
 Wed, 04 Feb 2026 21:34:22 +0100
From: Phil Sutter <phil@nwl.cc>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH] board: Synology: common: Fix typo in Makefile
Date: Wed,  4 Feb 2026 21:29:36 +0100
Message-ID: <20260204202936.21585-1-phil@nwl.cc>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Due to this, legacy.c was neither compiled nor linked into the binary
and thus booting legacy DS414 firmware failed. Missing atag setup led to
no console output (and probably stalled boot) after:

| Uncompressing Linux... done, booting the kernel.

Fixes: 9774462e34faa ("arm: Disable ATAGs support")
Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 board/Synology/common/Makefile | 2 +-
 lib/fdtdec.c                   | 5 +++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/board/Synology/common/Makefile b/board/Synology/common/Makefile
index f688b5490631c..87be53321ee64 100644
--- a/board/Synology/common/Makefile
+++ b/board/Synology/common/Makefile
@@ -2,4 +2,4 @@
 #
 # Copyright (C) 2021 Phil Sutter <phil@nwl.cc>
 
-obj-$(SUPPORT_PASSING_ATAGS)	+= legacy.o
+obj-$(CONFIG_SUPPORT_PASSING_ATAGS)	+= legacy.o
diff --git a/lib/fdtdec.c b/lib/fdtdec.c
index c38738b48c79f..89f4de6110bf1 100644
--- a/lib/fdtdec.c
+++ b/lib/fdtdec.c
@@ -624,6 +624,11 @@ int fdtdec_get_chosen_node(const void *blob, const char *name)
  */
 static int fdtdec_prepare_fdt(const void *blob)
 {
+	printf("%s: blob at %p\n", __func__, blob);
+	if (blob) {
+		printf("%s: blob & 3 = %d\n", __func__, (uintptr_t)blob & 3);
+		printf("%s: fdt_check_header() returns %d\n", __func__, fdt_check_header(blob));
+	}
 	if (!blob || ((uintptr_t)blob & 3) || fdt_check_header(blob)) {
 		if (xpl_phase() <= PHASE_SPL) {
 			puts("Missing DTB\n");
-- 
2.52.0


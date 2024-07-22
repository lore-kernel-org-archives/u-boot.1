Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38664C3DA59
	for <u-boot@archiver.kernel.org>; Mon, 22 Jul 2024 23:29:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 327D688676;
	Tue, 23 Jul 2024 01:29:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="KBAl9KYW";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="XOfcG3rq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 14E1188644; Tue, 23 Jul 2024 01:29:56 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1D4D288614
 for <u-boot@lists.denx.de>; Tue, 23 Jul 2024 01:29:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4WSc256H3Sz9sWt;
 Tue, 23 Jul 2024 01:29:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721690989;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=lKAQy8pZz5LRnQLXPNCPk4A85QWmEKuIg+9Lln9gfzU=;
 b=KBAl9KYW6cux5w+KT/NdyBLKpMlTdIoBvdBc8qyNXMJGwkAYw0YM0FiOWfQ8cMyFXYzCY4
 rAreAuhWJ41LpQi2K/uh6pI4+PH03Urt3DTl9aRQgk2Dg2fvjDg0izzNKuAB2m/6rdf+IL
 tYW9OLN1b/UGpqHfzeNycIokMtiS6PN1tia26JfQFTmkZWVSluOssDqs34SKmzGJNQszXT
 hCYA8eiPcaf7Io/Q/CKMwroA/w75oj0OO4do5yTrtKqL/eW1GriryiTeDynJbCyvvd1oLM
 owzcGCSDKQvmfEpdMbxtLY3ODYhgMgQ/DnOsal/3bGqLOrhtj7JAcXphOkjSUA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721690988;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=lKAQy8pZz5LRnQLXPNCPk4A85QWmEKuIg+9Lln9gfzU=;
 b=XOfcG3rq2Yo/HTxil9oPqoHNAH8Ty58tMpbJXg8GiYJLY6QL4GFFf7F0ULjZ1XdFuFWD0c
 gxb9JBf07rQQUNkrXbotG6ThCb2zlkrMBdafJqTz/J3fAgDDO+gQoOvJv9NEI1Jb1x4gMh
 CKaDCPwalX853hqQMVnZDJIvVTzs4QHDSResqS2ZVYEV8M5d0RM6dazAsChSTAzG7/wTb2
 Pi49tmgMzegj9MgwmEHdIN/oNp+M5UO1Vuqn+n5YWz++96t4O4bw9A3DJR/lJjKrGB5Q2S
 zraU7t3rlJjKhFCRoWvzNuPXN5fQEfNVWw/OCrLCTKt5jGJugVgU9cm/XxBPLw==
To: u-boot@lists.denx.de
Cc: francesco.dolcini@toradex.com, seanga2@gmail.com, sjg@chromium.org,
 trini@konsulko.com, Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 01/15] include: asm-generic: Remove duplicate newlines
Date: Tue, 23 Jul 2024 01:28:20 +0200
Message-ID: <20240722232910.91249-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 32ed0b8ec7945dd3934
X-MBO-RS-META: i9gzpk4ojm9z3jypgukfs675g3jhhnjo
X-Rspamd-Queue-Id: 4WSc256H3Sz9sWt
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
 include/asm-generic/int-ll64.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/asm-generic/int-ll64.h b/include/asm-generic/int-ll64.h
index 7451718a61c..aa572021cc0 100644
--- a/include/asm-generic/int-ll64.h
+++ b/include/asm-generic/int-ll64.h
@@ -43,5 +43,4 @@ typedef __u64 u64;
 
 #endif /* __ASSEMBLY__ */
 
-
 #endif /* _ASM_GENERIC_INT_LL64_H */
-- 
2.43.0


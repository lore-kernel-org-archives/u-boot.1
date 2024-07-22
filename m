Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73D7EC3DA59
	for <u-boot@archiver.kernel.org>; Mon, 22 Jul 2024 23:32:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 226FC88739;
	Tue, 23 Jul 2024 01:30:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="NG3wf/PU";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="kupf6ld+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 779D288614; Tue, 23 Jul 2024 01:30:11 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F406E884C6
 for <u-boot@lists.denx.de>; Tue, 23 Jul 2024 01:30:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4WSc2J52B9z9sp5;
 Tue, 23 Jul 2024 01:30:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721691000;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=deC50xjst5lBiH+JQWv6CylOkjvi4uB47SPRqWLMkak=;
 b=NG3wf/PUY0wAeBG2L9H0cqPzkM8seS2t0CKQf3ZGCZb4F6nJp98B/lLyNrw7nWoIEAE39a
 EChdYdT9+CtcMekqbbEyqwOdDFhND6wMzuOE5gYsNuy8xQ1SzngwZqPDXYwxe25pI1J+lq
 f248lKN/UyLaytUyR/6eGhyVtN52KM/R/sD2kyUxFMAG1LsaHAZ0Td2ea4vwKDCqapIg7e
 UVsenTPE5TwFqK+77V8erBtISOFNIUTkO142x/hqLx9H/CSaTBV40+mBzKgIkzm2wzZoxV
 4lFSte3QPtMNuMHxl+hSTHP/SjtZmcMKUJ9UUk5gmandWbGNkb/u8rKFI88hRA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721690998;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=deC50xjst5lBiH+JQWv6CylOkjvi4uB47SPRqWLMkak=;
 b=kupf6ld+G7azZ0z8TNmGXwf3fJAesAjFLX69pF5ILMjid2Z8nQMOeE8i4qXVs0UKcNMSr/
 pdZe+vEEo2Gxm3X7E2RgcGwONF1lgSQSrg0wCpM3P/lyFDHtZp5EgkU58ofun7y7ZAMk+n
 8T0uzrsQZRYRKiaNExnNSw0dA72766I0Q/NTnERA8EBa5KW/qKw9M87L2/PZAXJT+HakUX
 E25wejO//Mfq18Six0N1efzuLBsOrhyoAN7VpgAZoPbDQn0/lSLhmfAZ0xVePvqEqS85IU
 lJx+/GF/aREljB5gEf3Y7Q0ofQaK6yPLB6z9kORM0fQRgEiLsmfSs31usrlbXQ==
To: u-boot@lists.denx.de
Cc: francesco.dolcini@toradex.com, seanga2@gmail.com, sjg@chromium.org,
 trini@konsulko.com, Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 14/15] include: zfs: Remove duplicate newlines
Date: Tue, 23 Jul 2024 01:28:33 +0200
Message-ID: <20240722232910.91249-14-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240722232910.91249-1-marek.vasut+renesas@mailbox.org>
References: <20240722232910.91249-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: aabcdc8d44cc6b33025
X-MBO-RS-META: h5kfxm5d5gxduknz113gzdxhfbwxz8ye
X-Rspamd-Queue-Id: 4WSc2J52B9z9sp5
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
 include/zfs/spa.h     | 1 -
 include/zfs/zfs.h     | 1 -
 include/zfs/zfs_acl.h | 1 -
 3 files changed, 3 deletions(-)

diff --git a/include/zfs/spa.h b/include/zfs/spa.h
index cd2ddf58e77..df01d4964fb 100644
--- a/include/zfs/spa.h
+++ b/include/zfs/spa.h
@@ -10,7 +10,6 @@
 #ifndef ZFS_SPA_HEADER
 #define	ZFS_SPA_HEADER 1
 
-
 /*
  * General-purpose 32-bit and 64-bit bitfield encodings.
  */
diff --git a/include/zfs/zfs.h b/include/zfs/zfs.h
index 72d87452ddf..84154377bda 100644
--- a/include/zfs/zfs.h
+++ b/include/zfs/zfs.h
@@ -10,7 +10,6 @@
 #ifndef	GRUB_ZFS_HEADER
 #define	GRUB_ZFS_HEADER 1
 
-
 /*
  * On-disk version number.
  */
diff --git a/include/zfs/zfs_acl.h b/include/zfs/zfs_acl.h
index d6cc408d7f1..038c68f1386 100644
--- a/include/zfs/zfs_acl.h
+++ b/include/zfs/zfs_acl.h
@@ -38,5 +38,4 @@ typedef struct zfs_znode_acl {
 	uint8_t	z_ace_data[ZFS_ACE_SPACE]; /* space for embedded ACEs */
 } zfs_znode_acl_t;
 
-
 #endif	/* _SYS_FS_ZFS_ACL_H */
-- 
2.43.0


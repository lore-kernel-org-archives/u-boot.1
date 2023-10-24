Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75003C07545
	for <u-boot@archiver.kernel.org>; Tue, 24 Oct 2023 12:00:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 647208770C;
	Tue, 24 Oct 2023 14:00:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=tom-fitzhenry.me.uk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=tom-fitzhenry.me.uk header.i=@tom-fitzhenry.me.uk header.b="U1EVYWOa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3EB3C877E8; Tue, 24 Oct 2023 14:00:10 +0200 (CEST)
Received: from mx2.mythic-beasts.com (mx2.mythic-beasts.com
 [IPv6:2a00:1098:0:82:1000:0:2:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 00187876CC
 for <u-boot@lists.denx.de>; Tue, 24 Oct 2023 14:00:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=tom-fitzhenry.me.uk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tom@tom-fitzhenry.me.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=tom-fitzhenry.me.uk; s=mythic-beasts-k1; h=Date:Subject:To:From;
 bh=UqeSNvntlTXkadE63rgPg2TYgqKObEzRfJPUWP6UbYE=; b=U1EVYWOaCgwhyzCraAqOG3k+ld
 kl28OjYBNlVGqEjGmtCG99KNXq7rjyMGdIFnSilOpgMtBPDnXt8gagWUt2+pVaGVra9NXaV5NzErh
 SotplDGzJ70nvN7IEe9ZlG31jgfH99WDyKkQv4pzPWPaVSQ5KSMRW5GWxbzf/tc2iUbqA4eCoJ2/4
 C7ZNtqIhQk9MgPHLuqZfsPKPbFr8FLeJaVczzjshilsSOZROx+2RdEtZ7qtfjgiPy+i7hUH0xtwxg
 CCD71JAso09suYjqMiKC5uMPPd9hrrsFpslBUbh0o2s51jgoNvoCvCW7X7f6+1pPrfnKWTlHaWYLc
 Ga7e3tww==;
Received: by mailhub-hex-d.mythic-beasts.com with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <tom@tom-fitzhenry.me.uk>)
 id 1qvG4k-002rVP-Sa; Tue, 24 Oct 2023 13:00:00 +0100
From: Tom Fitzhenry <tom@tom-fitzhenry.me.uk>
To: 
Cc: u-boot@lists.denx.de,
	Tom Fitzhenry <tom@tom-fitzhenry.me.uk>
Subject: [PATCH] doc: gpt: fix example of echoing variable
Date: Tue, 24 Oct 2023 22:59:06 +1100
Message-ID: <20231024115915.16565-1-tom@tom-fitzhenry.me.uk>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BlackCat-Spam-Score: 49
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

---
 doc/usage/cmd/gpt.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/usage/cmd/gpt.rst b/doc/usage/cmd/gpt.rst
index f6115ecb0ee..ea43218fa21 100644
--- a/doc/usage/cmd/gpt.rst
+++ b/doc/usage/cmd/gpt.rst
@@ -192,7 +192,7 @@ Get the information about the partition named 'rootfs'::
 Get the list of partition names on the disk::
 
     => gpt enumerate
-    => echo gpt_partition_list
+    => echo ${gpt_partition_list}
     boot rootfs system-data [ext] user modules ramdisk
 
 
-- 
2.42.0


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43E0CC2BD09
	for <u-boot@archiver.kernel.org>; Tue,  9 Jul 2024 10:31:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 80EE4885A0;
	Tue,  9 Jul 2024 12:31:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 222B4885A0; Tue,  9 Jul 2024 12:31:56 +0200 (CEST)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E309B884FF
 for <u-boot@lists.denx.de>; Tue,  9 Jul 2024 12:31:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=csgroup.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=christophe.leroy@csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
 by localhost (Postfix) with ESMTP id 4WJHNT24TTz9sSp;
 Tue,  9 Jul 2024 12:31:53 +0200 (CEST)
Received: from pegase2.c-s.fr ([172.26.127.65])
 by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id V9jYBGrBP6Fb; Tue,  9 Jul 2024 12:31:53 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase2.c-s.fr (Postfix) with ESMTP id 4WJHNT1KVCz9sSg;
 Tue,  9 Jul 2024 12:31:53 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 1EC6F8B773;
 Tue,  9 Jul 2024 12:31:53 +0200 (CEST)
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id T2Q5KKkQeWB2; Tue,  9 Jul 2024 12:31:53 +0200 (CEST)
Received: from PO20335.idsi0.si.c-s.fr (unknown [192.168.232.243])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id CE4248B76D;
 Tue,  9 Jul 2024 12:31:52 +0200 (CEST)
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Michal Simek <michal.simek@amd.com>,
	Tom Rini <trini@konsulko.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	u-boot@lists.denx.de
Subject: [PATCH 0/6] Resubmit series "zlib: Address CVE-2016-9841"
Date: Tue,  9 Jul 2024 12:31:12 +0200
Message-ID: <cover.1720521011.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.44.0
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

This series reapplies the series that was merged by commit 4914263c9a14
("Merge patch series "zlib: Address CVE-2016-9841"") but then reverted
by commit bbacdd3ef776 ("Revert "Merge patch series "zlib: Address
CVE-2016-9841""") due to boot failure on powerpc/8xx platform induced
by the removal of the necessary optimatisation brought by
commit cd514aeb996e ("zlib: Optimize decompression").

In addition to the previous version, this series adds patch 3 to fix
inflate_fast() with post incremendation and removes the deletion of
commit cd514aeb996e ("zlib: Optimize decompression") by patch 4.
It also adds patch 5 which contains changes split out of patch 4 because
they are unrelated to the description of the patch.

CI passed on https://source.denx.de/u-boot/custodians/u-boot-mpc8xx/-/pipelines/21518

Christophe Leroy (1):
  zlib: Fix inflate_fast() when POSTINC macro is set

Michal Simek (5):
  zlib: Rename this variable to here (current decoding table entry)
  zlib: Rename write variable to wnext (window write index)
  zlib: Port fix for CVE-2016-9841 to U-Boot
  zlib: Misc unrelated updates
  zlib: Remove incorrect ZLIB_VERSION

 include/u-boot/zlib.h |  16 ++---
 lib/gzip.c            |   2 +-
 lib/zlib/deflate.c    |  13 +---
 lib/zlib/inffast.c    | 147 +++++++++++++++++++-----------------------
 lib/zlib/inflate.c    |  31 ++++-----
 lib/zlib/inflate.h    |   2 +-
 lib/zlib/zlib.h       |   1 -
 lib/zlib/zutil.c      |   1 -
 8 files changed, 90 insertions(+), 123 deletions(-)

-- 
2.44.0


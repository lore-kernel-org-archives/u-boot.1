Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA3FBC3DA64
	for <u-boot@archiver.kernel.org>; Wed, 31 Jul 2024 13:10:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 37A09889AE;
	Wed, 31 Jul 2024 15:10:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=comcast.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=comcast.net header.i=@comcast.net header.b="hZV3SbFP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0CBF3889DC; Wed, 31 Jul 2024 15:10:04 +0200 (CEST)
Received: from resqmta-c2p-546593.sys.comcast.net
 (resqmta-c2p-546593.sys.comcast.net [IPv6:2001:558:fd00:56::8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5BC0388996
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 15:10:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=comcast.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=fventuri@comcast.net
Received: from resomta-c2p-555694.sys.comcast.net ([96.102.18.237])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 256/256 bits)
 (Client did not present a certificate)
 by resqmta-c2p-546593.sys.comcast.net with ESMTPS
 id Z7yCszVP5VY9BZ95bsVTvS; Wed, 31 Jul 2024 13:09:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
 s=20190202a; t=1722431399;
 bh=Ggjuen63LLyj0m/JRkrMnVhnmIdfOvZNiW2ItLBrAIQ=;
 h=Received:Received:From:To:Subject:Date:Message-ID:MIME-Version:
 Xfinity-Spam-Result;
 b=hZV3SbFPI+PrO1uWwsybJHoaO+3qBHWn7EdA5d0JayeS3Z/u0pQ16Jc8roTrP/glp
 HfjzzZIHSayQXy0o99Czv9ySl2prG2V9rwlLpbIyaMXdjv1W/03tPosAl6IbtAZzia
 aClNdwSs0UBzvrZBUtkjUVovqqdz3lUES1aZ10GHuyoO8+BzZRcgm0KE436xQe54cm
 NBA3g8Yr6kTqk3xC2Uq+oMIAkR5NtF4zJ2f8/qVv28H6+54QdYdvB9SBrw6SMEeisi
 vtmxO1zC0q57vyWToOMZxGbEjkb2Nu548dcisbnemyj4TqLt+J4JmBr4TnoAN8cZ3u
 wi4gocxdevWBw==
Received: from fvdesktop.. ([76.18.214.183])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 256/256 bits)
 (Client did not present a certificate)
 by resomta-c2p-555694.sys.comcast.net with ESMTPSA
 id Z950sQyLgB6aKZ95EsqI4U; Wed, 31 Jul 2024 13:09:38 +0000
From: Franco Venturi <fventuri@comcast.net>
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Franco Venturi <fventuri@comcast.net>,
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v2] mmc: fix signed vs unsigned compare in read check in
 _spl_load()
Date: Wed, 31 Jul 2024 09:09:00 -0400
Message-ID: <20240731130913.487121-1-fventuri@comcast.net>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfAWmDw2z7XEG3JAXrV5I1jpmGUX3eZFQSfO4NO+o789nKzvrWiz31PpnskFg9muWHbMbgt20QJ9pG5FvLmMWEcqyK0ETHc2CagU6ze1Hg01YosI/aRFv
 D6uyDMKE2dJNST/z+bg3iWzEnaktYMaas/XQGyIR783EKnLjJRpt0f6M3qsiMT6+ZXnu81kOOuEot5RDySWp2mUgHXHPtJLQptw4/jNDCkCSv3ILOF7Kh4Ax
 j5/CvD3JwbRBklVFhW2Zj1gaxodM+NBTr+Z4YGTUifqhSdGhtm0CGE/eagXluUidgu8qZMEp6KBEXGA220nppkWxhJo0aG9eQ1z+lhGbiRfa0KfhrYNtIx4B
 bvxDZ4Wy
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

Fix signed vs unsigned compare in read check in _spl_load()

Issue: when info->read() returns a negative value because of an error,
       the comparison of 'read' (signed) with 'sizeof(*header)'
       (unsigned silently converts the negative value into a very
       large unsigned value and the check on the error condition
       always return false, i.e. the error is not detected
Symptoms: if spl_load_image_fat() is unable to find the file 'uImage',
          the SPL phase of the boot process just hangs after displaying
          the following line:
          Trying to boot from MMC1
Fix: cast 'sizeof(*header)' to int so the compare is now between
     signed types
Reference: https://stackoverflow.com/questions/17293749/sizeof-operator-in-if-statement

Signed-off-by: Franco Venturi <fventuri@comcast.net>
---

(no changes since v1)

 include/spl_load.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/spl_load.h b/include/spl_load.h
index 1c2b296c0a..83db381202 100644
--- a/include/spl_load.h
+++ b/include/spl_load.h
@@ -22,7 +22,7 @@ static inline int _spl_load(struct spl_image_info *spl_image,
 
 	read = info->read(info, offset, ALIGN(sizeof(*header),
 					      spl_get_bl_len(info)), header);
-	if (read < sizeof(*header))
+	if (read < (int)sizeof(*header))
 		return -EIO;
 
 	if (image_get_magic(header) == FDT_MAGIC) {
-- 
2.45.2


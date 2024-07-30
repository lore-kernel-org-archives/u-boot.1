Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82F69C3DA64
	for <u-boot@archiver.kernel.org>; Wed, 31 Jul 2024 12:59:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE140889AE;
	Wed, 31 Jul 2024 14:59:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=comcast.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=comcast.net header.i=@comcast.net header.b="vrGJBBkE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B703D8854A; Tue, 30 Jul 2024 15:31:44 +0200 (CEST)
Received: from resqmta-h2p-567408.sys.comcast.net
 (resqmta-h2p-567408.sys.comcast.net [IPv6:2001:558:fd02:2446::8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A5BC488747
 for <u-boot@lists.denx.de>; Tue, 30 Jul 2024 15:31:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=comcast.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=fventuri@comcast.net
Received: from resomta-h2p-554997.sys.comcast.net ([96.102.179.209])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 256/256 bits)
 (Client did not present a certificate)
 by resqmta-h2p-567408.sys.comcast.net with ESMTPS
 id Ym7Ds9o9V9bHAYmwzsl3Xf; Tue, 30 Jul 2024 13:31:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
 s=20190202a; t=1722346298;
 bh=EA8WO+3J5KQDunxZcBnv+yR4JSlO2e0Sl4K6Uv8o8S4=;
 h=Received:Received:From:To:Subject:Date:Message-ID:MIME-Version:
 Xfinity-Spam-Result;
 b=vrGJBBkEAaj60U4GrOYtIQTbZ+SxlFiyoObfYy9uBmkrLEnxRLsQr5HJx9Utx4WJy
 rKu8cPL1sXtC3GZB3SG1N7lp/cujrL0rcrsrP6GpcvngqarS7HEr9MU2w1LAameJcP
 xkbYLadpuKvMWo3SMntpn0Mr0sMLYEFcMwiZ6ZXJqPIWABCXxUHlfMEBxyF93Ctxzd
 pOTTLoPRrQkbd/ezFWwaXJzyQrwlGLljyBuqEBUkWqOFDCxACNHHA0P1eOgVxkKBRT
 GZhOQgEi4nQMH9A9Bp8s8PvZOY0QXzBYoBtm1K1y9zT5D9s5wwONCbQDq6L8+FTFnl
 eSd/FxFLvXMSg==
Received: from fvdesktop.. ([76.18.214.183])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 256/256 bits)
 (Client did not present a certificate)
 by resomta-h2p-554997.sys.comcast.net with ESMTPSA
 id YmwCsHecLrKZWYmwbsv6pM; Tue, 30 Jul 2024 13:31:15 +0000
From: Franco Venturi <fventuri@comcast.net>
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Franco Venturi <fventuri@comcast.net>,
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v1] mmc: fix signed vs unsigned compare in read check in
 _spl_load()
Date: Tue, 30 Jul 2024 09:30:32 -0400
Message-ID: <20240730133043.12577-1-fventuri@comcast.net>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfFUtx7EIXpNH+jeX3xdDmNBNInmXVcqYqq0hCaaGV3yzvP1xsOQdh26Bszv2hoCTvmxrlw7KkeQDZ7D0W+UXrWM8TPfrY+voLeh8/JwLTVH4PQ6unecS
 DTXoNbkESHmBs9+ep3twybrINVLOqeZgDdZuSLpPzPavGfWm8rjnrFJv7vUyb9U19G0+6T8wTMJIxp/GQ3/FZhUocg0eP/Y5AuwR9p0QnHMM/h6xKM2eu9AK
 elxmVz9w4AaT4USyIgwUqstu/08VLKTXQzs4+aPydQ5PnjAOh3PPhDKzcSs/ZJzPDcm8ZPxCrr0j/FglGT42m5HVktqnxJm7B0fJe+PnGY1n6GT12xregwKN
 oZ6556Hq
X-Mailman-Approved-At: Wed, 31 Jul 2024 14:59:20 +0200
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
Fix: first check if 'read' is negative then check its value against
     'sizeof(*header)'
Reference: https://stackoverflow.com/questions/17293749/sizeof-operator-in-if-statement

Signed-off-by: Franco Venturi <fventuri@comcast.net>
---

 include/spl_load.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/spl_load.h b/include/spl_load.h
index 1c2b296c0a..1e05599d29 100644
--- a/include/spl_load.h
+++ b/include/spl_load.h
@@ -22,7 +22,7 @@ static inline int _spl_load(struct spl_image_info *spl_image,
 
 	read = info->read(info, offset, ALIGN(sizeof(*header),
 					      spl_get_bl_len(info)), header);
-	if (read < sizeof(*header))
+	if (read < 0 || read < sizeof(*header))
 		return -EIO;
 
 	if (image_get_magic(header) == FDT_MAGIC) {
-- 
2.45.2


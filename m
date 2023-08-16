Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFDBEC04E69
	for <u-boot@archiver.kernel.org>; Wed, 16 Aug 2023 15:06:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 151D1869F5;
	Wed, 16 Aug 2023 17:06:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="mKlSs29O";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="s4fdA5NM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EEC22869F1; Wed, 16 Aug 2023 17:06:27 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 511AA807C9
 for <u-boot@lists.denx.de>; Wed, 16 Aug 2023 17:06:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4RQs0d1cKLz9sdh;
 Wed, 16 Aug 2023 17:06:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1692198385;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=LXYpG6qSqqSMez4y8SzFaAOQMLUDTHjmxcTHBUPLjdw=;
 b=mKlSs29OC+5A5S9sg3hEpmm//gODV22mcLbTP9Lr0B2UpbD7tV6H8KsevvcNkmPSIcbuh+
 LgtQGHP7uPvheCObOyYcdt9fyMXjoOzlssBZN57uUVvEuJLLHax+kfSqfDd4rbKMLQ3jRH
 4m84rGTc4vaAaHBbocNgqtOg+f92Df1k2Wp33tpgHlDCuC1lT/T2RwDT6VRte/Y5eV+DBR
 VsOqC7y2QEh/Y7s80ti3bornMzR+oGV2OxMiQLJ4j5K/JYj5iA6vdMa5ewAT4975ss/jnt
 zzd4Is+6GI8qQ6HZcj0If+FrzKMcCVd72/XwLdAGHkcCDyFpSoXx4LqiAxWOAQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1692198382;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=LXYpG6qSqqSMez4y8SzFaAOQMLUDTHjmxcTHBUPLjdw=;
 b=s4fdA5NMDpDrhFfU1T0nCRBb5k3brmg++LveUFQU0bjmcZvoOdhMOxiEKgJ8NQ23XBKhNn
 tA8TmNxfv0kT2jWBLH1sz0oXXex+1l0Punx+mxx682txU/LYfA4BrHxr7Tn2N7V2Eg1YoP
 hZguvktQ0XFOjDVtl/PyldsWTaAvTkFms7IfIJ6Tr2SwUyRYHUw8wkN4rTaGVDHObTcMQT
 VVNvKLcr4PCTc4LO3cZoja2T3BoPvy9bkg2v+Bl4lOXkbs9i5vxM/nlYntCsZpfdAUmpjr
 AcTW6DiP9M6QexeZwPdNlumibpPu8UB4agoBju5EcHZCATrdOFYni1babhqQ9A==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Bhupesh Sharma <bhupesh.sharma@linaro.org>, Faiz Abbas <faiz_abbas@ti.com>
Subject: [PATCH v2 1/7] ufs: Convert quirks to BIT() macro
Date: Wed, 16 Aug 2023 17:05:49 +0200
Message-Id: <20230816150555.245028-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 44308f07a5d86012ba7
X-MBO-RS-META: s9mcsrihnhustx99ynz9hkqrcug4z845
X-Rspamd-Queue-Id: 4RQs0d1cKLz9sdh
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

Use BIT() macro for quirks, no functional change.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc: Faiz Abbas <faiz_abbas@ti.com>
---
V2: New patch
---
 drivers/ufs/ufs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ufs/ufs.h b/drivers/ufs/ufs.h
index 8a38832b05f..5a5c13aefdf 100644
--- a/drivers/ufs/ufs.h
+++ b/drivers/ufs/ufs.h
@@ -717,7 +717,7 @@ struct ufs_hba {
  * the LCC transmission on UFS device (by clearing TX_LCC_ENABLE
  * attribute of device to 0).
  */
-#define UFSHCD_QUIRK_BROKEN_LCC				0x1
+#define UFSHCD_QUIRK_BROKEN_LCC				BIT(0)
 
 	/* Virtual memory reference */
 	struct utp_transfer_cmd_desc *ucdl;
-- 
2.40.1


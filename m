Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A0B9CD4F5E
	for <u-boot@archiver.kernel.org>; Thu, 21 May 2026 11:37:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 570E08341A;
	Thu, 21 May 2026 13:36:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="UO/WYCcx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B0FB83FF5; Thu, 21 May 2026 12:58:28 +0200 (CEST)
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com
 [210.118.77.12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE80C805D7
 for <u-boot@lists.denx.de>; Thu, 21 May 2026 12:58:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=l.stelmach@samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20260521105820euoutp02165d3f769a390463c76b3cf9b195ad59~xj344Aie-0685206852euoutp02N
 for <u-boot@lists.denx.de>; Thu, 21 May 2026 10:58:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20260521105820euoutp02165d3f769a390463c76b3cf9b195ad59~xj344Aie-0685206852euoutp02N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1779361100;
 bh=96gnYaU/dnlNRFkGm8plHZ97ooKyKdA8YPljTlHEEyA=;
 h=From:To:Cc:Subject:Date:References:From;
 b=UO/WYCcxwmbPtMePR3zh8E2iS5PboQeGDT5pXvQCklUNTssM5BZ6QiTJDoIvPw95Y
 l1Lyok6IYduCeaB+Nq8yB42EXtlrp+mFVB4rG3SHXBvbLKFve6tFjAAjqA3EiD7Awt
 lvdDW0dGnUdfwbqYKCwG3drl9QePEA0nyE1xLKts=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20260521105819eucas1p18eab88ecd16fe3563eb8717324e77dba~xj34jgqwR0538405384eucas1p1v;
 Thu, 21 May 2026 10:58:19 +0000 (GMT)
Received: from localhost (unknown [106.120.51.111]) by eusmtip1.samsung.com
 (KnoxPortal) with ESMTPA id
 20260521105819eusmtip1705d58dcaa66071cd1195db56715cd60~xj34f1znO2153421534eusmtip1J;
 Thu, 21 May 2026 10:58:19 +0000 (GMT)
From: =?UTF-8?q?=C5=81ukasz=20Stelmach?= <l.stelmach@samsung.com>
To: Mattijs Korpershoek <mkorpershoek@kernel.org>, Tom Rini
 <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
 =?UTF-8?q?=C5=81ukasz=20Stelmach?= <l.stelmach@samsung.com>,
 u-boot@lists.denx.de
Subject: [PATCH v2] fastboot: read fastboot buffer address from fastboot_addr_r
Date: Thu, 21 May 2026 12:57:22 +0200
Message-ID: <20260521105728.605496-1-l.stelmach@samsung.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Organization: Samsung R&D Institute Poland
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260521105819eucas1p18eab88ecd16fe3563eb8717324e77dba
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260521105819eucas1p18eab88ecd16fe3563eb8717324e77dba
X-EPHeader: CA
X-CMS-RootMailID: 20260521105819eucas1p18eab88ecd16fe3563eb8717324e77dba
References: <CGME20260521105819eucas1p18eab88ecd16fe3563eb8717324e77dba@eucas1p1.samsung.com>
X-Mailman-Approved-At: Thu, 21 May 2026 13:36:58 +0200
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

Following the previous advice (link below) check fastboot_addr_r
environment variable for fastboot buffer address.

Link: https://lore.kernel.org/u-boot/aWiWFrdwvy7-IK63@sumit-xelite/
Signed-off-by: Łukasz Stelmach <l.stelmach@samsung.com>
---
 drivers/fastboot/fb_common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Changes in v2:

* replaced the nested ternary operator with the parameterised call to
  env_get_hex()

* fixed a typo in the commit message

diff --git a/drivers/fastboot/fb_common.c b/drivers/fastboot/fb_common.c
index 9c52e004588..f2f063ebfbb 100644
--- a/drivers/fastboot/fb_common.c
+++ b/drivers/fastboot/fb_common.c
@@ -240,7 +240,7 @@ void fastboot_init(void *buf_addr, u32 buf_size)
 #endif
 
 	fastboot_buf_addr = buf_addr ? buf_addr :
-				       (void *)CONFIG_FASTBOOT_BUF_ADDR;
+		(void *)env_get_hex("fastboot_addr_r", CONFIG_FASTBOOT_BUF_ADDR);
 	fastboot_buf_size = buf_size ? buf_size : CONFIG_FASTBOOT_BUF_SIZE;
 	fastboot_set_progress_callback(NULL);
 
-- 
2.47.3


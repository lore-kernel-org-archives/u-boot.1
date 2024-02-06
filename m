Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E652FC4828D
	for <u-boot@archiver.kernel.org>; Tue,  6 Feb 2024 04:30:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 07285876FC;
	Tue,  6 Feb 2024 05:30:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.b="iB7nDNdL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 271BC87727; Tue,  6 Feb 2024 03:49:44 +0100 (CET)
Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.220])
 by phobos.denx.de (Postfix) with ESMTP id 15D108751F
 for <u-boot@lists.denx.de>; Tue,  6 Feb 2024 03:49:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=jhb_ee@163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=JNI8B
 BewjWWkGmtDZ3+TXovBIEoV0LQFfL2KhKzGMAg=; b=iB7nDNdLSqRGY3WAK5y5e
 jPFjh0eMdGaiAtrGDIQykWhyxfQ0EMQc9FbNblh124U10xbaRBP14NkAH85AkTEk
 EqzfUPoLVTnt2W0I/bw2QYRcsa0WdjynyBb3nSthLU2LtMU7rvY985faWwRoqObp
 kcXLfrsetWhbjnv5FqyzGI=
Received: from SZ-jihb.starsmicrosystem.com (unknown [60.31.47.108])
 by gzga-smtp-mta-g0-1 (Coremail) with SMTP id _____wD3_xY3nsFlZG9gAA--.19080S2;
 Tue, 06 Feb 2024 10:49:28 +0800 (CST)
From: Hongbin Ji <jhb_ee@163.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com,
	Hongbin Ji <jhb_ee@163.com>
Subject: [PATCH] xyzModem: Correct xmodem blk verification conditions
Date: Tue,  6 Feb 2024 10:49:25 +0800
Message-Id: <20240206024925.16325-1-jhb_ee@163.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wD3_xY3nsFlZG9gAA--.19080S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKrWkuw1UKrW5KF43GF1fXrb_yoWxtrcEgF
 W8Wr17tw409Fsxtw47u3yfZr18t34kGF18K3WUAr98Kr1UZFsxJrn8Jr1rXFWjg3WUZry3
 Wan8tws5Ar4I9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRiVc_3UUUUU==
X-Originating-IP: [60.31.47.108]
X-CM-SenderInfo: 5mkesvrh6rljoofrz/1tbiLx18fGVOBuUxMAAAs7
X-Mailman-Approved-At: Tue, 06 Feb 2024 05:30:45 +0100
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

When the blk sequence number is 255 and cblk is 0, the original XOR condition
produces a result of 0,and the judgment condition will be unsuccessful.

Signed-off-by: Hongbin Ji <jhb_ee@163.com>
---
 common/xyzModem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/xyzModem.c b/common/xyzModem.c
index fb319f7119..0bc1a87067 100644
--- a/common/xyzModem.c
+++ b/common/xyzModem.c
@@ -373,7 +373,7 @@ xyzModem_get_hdr (void)
     }
   ZM_DEBUG (zm_dump (__LINE__));
   /* Validate the message */
-  if ((xyz.blk ^ xyz.cblk) != (unsigned char) 0xFF)
+  if (~xyz.blk != xyz.cblk)
     {
       ZM_DEBUG (zm_dprintf
 		("Framing error - blk: %x/%x/%x\n", xyz.blk, xyz.cblk,
-- 
2.34.1


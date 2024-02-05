Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28663C4828D
	for <u-boot@archiver.kernel.org>; Mon,  5 Feb 2024 13:51:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 98B4C87BFC;
	Mon,  5 Feb 2024 14:51:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.b="WmB5yf3U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 89E988777D; Mon,  5 Feb 2024 07:59:06 +0100 (CET)
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
 by phobos.denx.de (Postfix) with ESMTP id 33E7B875E9
 for <u-boot@lists.denx.de>; Mon,  5 Feb 2024 07:59:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=jhb_ee@163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=JNI8B
 BewjWWkGmtDZ3+TXovBIEoV0LQFfL2KhKzGMAg=; b=WmB5yf3UDJLEIncN6SLAe
 1qppAZRfU87z4SIT2xA+4ryJgRqr61amcVHrqmAFPk16IqGW+Fr5IaWH/qNo9CBp
 Ly92TV7BiWIBxj8nTi7UhAtv0daWLVttV35TuuZtJCmWi2JNOL68lwJprHDHU3oO
 fy8wUMiWMrdbazbcVnuFHc=
Received: from SZ-jihb.starsmicrosystem.com (unknown [113.105.127.219])
 by gzga-smtp-mta-g1-5 (Coremail) with SMTP id _____wD3360vh8BlsNaAAw--.2577S2; 
 Mon, 05 Feb 2024 14:58:55 +0800 (CST)
From: Hongbin Ji <jhb_ee@163.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com,
	Hongbin Ji <jhb_ee@163.com>
Subject: [PATCH] xyzModem: Correct xmodem blk verification conditions
Date: Mon,  5 Feb 2024 14:58:50 +0800
Message-Id: <20240205065850.7556-1-jhb_ee@163.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wD3360vh8BlsNaAAw--.2577S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKrWkuw1UKrW5KF43GF1fXrb_yoWxtrcEgF
 W8Wr17tw409Fsxtw47u3yfZr18t34kGF18K3WUAr98Kr1UZFsxJrn8Jr1rXFWjg3WUZry3
 Wan8tws5Ar4I9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRE9a93UUUUU==
X-Originating-IP: [113.105.127.219]
X-CM-SenderInfo: 5mkesvrh6rljoofrz/1tbiYRB7fGV4G6TRFgAAsT
X-Mailman-Approved-At: Mon, 05 Feb 2024 14:51:45 +0100
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


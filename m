Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B682C0218C
	for <u-boot@archiver.kernel.org>; Mon, 27 Jan 2025 09:38:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6DF3980FC4;
	Mon, 27 Jan 2025 10:38:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=qq.com header.i=@qq.com header.b="I9vP4YRw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E029A80FF7; Mon, 27 Jan 2025 10:38:40 +0100 (CET)
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.48])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3823E801DE
 for <u-boot@lists.denx.de>; Mon, 27 Jan 2025 10:38:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=1425075683@qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1737970696; bh=DcnIMgjOuzUfrUIOyKHtqCThVxDFNXFrlUAck1cWVLM=;
 h=From:To:Cc:Subject:Date;
 b=I9vP4YRwWSVz71/Lt30dTSR+HoM1FNvh+XP3LMTWYZhPSUWdZHKYO+fifruYePDS6
 Mfw6kX5ufaoUJcMPDHRnUYJ7DH/EQ+QNSuVRhhKRcm1/CMQ0f2ByUbSHtE2w7c4TaN
 1RD76NN+dPq+hYIOplIiSgVVy1OjGdntcJTM2fWE=
Received: from ubuntu.localdomain ([112.51.40.31])
 by newxmesmtplogicsvrszb20-0.qq.com (NewEsmtp) with SMTP
 id 98E86C6D; Mon, 27 Jan 2025 17:38:14 +0800
X-QQ-mid: xmsmtpt1737970694turgzdwfr
Message-ID: <tencent_5BE562924C2EF9DCF6F00FBEB0D50437020A@qq.com>
X-QQ-XMAILINFO: OVFdYp27KdlJDDvDLDGqFxBVbX+KoO9iKxMqcwrBfjKhbPTnxOzRBK9mam7SZI
 /3EIvEbpfu9afXKsgtPXu/XmUSuAzbWHi3mXWSZo6MNAmT8VnCBgDxue3On15oZ4sbCxofS8B7a7
 n+2EEHI3vvFHn7nxWJZFX6/QVdk6Qd8B5YGoIw7d2fNNu7nBtytaxtHiU/16Xm/+6tnoBTSO1aPQ
 8tTH+j48P8HyfRV6rY/QnNHuBUWCE4tlO2b/plnB1uMlrWzMtW9nB9oSTDZKwOccDNmtevLE97ss
 NqIBX9UPz5UDtsaZ5pb9u8y3gRqDyVHQD1EboGRq6pbcPQen+Yw7s5r6XIjJDpmXpyLGakDcUvAk
 qsV6nNHnfY05lrN8qW/ntvSZ80J+wpmFHtura5t9R/8ztmAP8tDa4AAE7wbD3+lc/6Y5c+C01V2b
 b9vFa/xAsu+xMIqTaVE4G/aQEcla6SnsMx6fGFK+9nzB/ZIBiUaV2KL1TlqA8oO/aTAhjZlHLmVe
 6OmNofPxnQccjkcF/GHi/yK1oRsXbI7VnjEVA2nlhkW2c324Ok0711rfN18aCUnxGQAdWgawQaJM
 PX4XX6Zjb37JJjmH6X+vihE8BpUcf/POprqzr8h2yiHQtuyeewuyTRmHwt/BmQpFJH87UJhfmwqd
 aWzdxzRnAwGxM8Wkr2BwSXomKv0daAhje88zTzjahAtNM3WIPfB7jktTUrDKLwTC1aS3WhAY078x
 Md436VsFDlI0onzQfRQeQQ2ly680wWI6OnK9cCu5iqBNgJxU7CrAg9uRAtB85B2C4YDi3gY2L4Sz
 ezk0pDw803nmt+eW77cE4/9qqAk2rkG+mOHn8kU1DvgZOSW72iVOPUvEPfnfeNTcD4+EIE4IIvxr
 r5N0A9zqaRW96dl1AlZqEbL8taeRmarl0iju3ixrfMsaDt5BgwcctB/5uDAfWxSOdgt8+aa+xUwE
 J4/7ECndUo+JfIHCTaq2agttq4ZUMdzJtqOYjrUAuq4qFOSORd+Q==
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
From: 1425075683@qq.com
To: Liya Huang <1425075683@qq.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Subject: [PATCH] API: system info adds FLASH and clk fetches
Date: Mon, 27 Jan 2025 17:38:11 +0800
X-OQ-MSGID: <20250127093811.68959-1-1425075683@qq.com>
X-Mailer: git-send-email 2.25.1
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

From: Liya Huang <1425075683@qq.com>

Refer to api/api platform-powerpc.c implementation

Signed-off-by: Liya Huang <1425075683@qq.com>
---

 api/api_platform.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/api/api_platform.c b/api/api_platform.c
index 7a789bd2016..d5cbcd6e201 100644
--- a/api/api_platform.c
+++ b/api/api_platform.c
@@ -17,9 +17,15 @@ int platform_sys_info(struct sys_info *si)
 {
 	int i;
 
+	si->clk_bus = gd->bus_clk;
+	si->clk_cpu = gd->cpu_clk;
+
 	for (i = 0; i < CONFIG_NR_DRAM_BANKS; i++)
 		platform_set_mr(si, gd->bd->bi_dram[i].start,
 				gd->bd->bi_dram[i].size, MR_ATTR_DRAM);
 
+	platform_set_mr(si, gd->ram_base, gd->ram_size, MR_ATTR_DRAM);
+	platform_set_mr(si, gd->bd->bi_flashstart, gd->bd->bi_flashsize, MR_ATTR_FLASH);
+
 	return 1;
 }
-- 
2.25.1


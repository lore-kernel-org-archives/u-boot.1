Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90242C83026
	for <u-boot@archiver.kernel.org>; Sun, 29 Jun 2025 05:18:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F88C80B9B;
	Sun, 29 Jun 2025 07:18:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=techyauld.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id C73F58206E; Sun, 29 Jun 2025 06:37:47 +0200 (CEST)
Received: from regular1-10.263.net (regular1-10.263.net [211.150.70.204])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8ADD2806D8
 for <u-boot@lists.denx.de>; Sun, 29 Jun 2025 06:37:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=techyauld.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=yzheng@techyauld.com
Received: from localhost (unknown [192.168.167.32])
 by regular1-10.263.net (Postfix) with ESMTP id 861C28DB;
 Sun, 29 Jun 2025 12:37:35 +0800 (CST)
X-KSVirus-CHECKED: 0
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-SKE-CHECKED: 1
X-ABS-CHECKED: 1
X-ANTISPAM-LEVEL: 2
Received: from localhost (unknown [118.193.106.122])
 by smtp.263.net (postfix) whith ESMTP id
 P25991T139744826545920S1751171854827691_; 
 Sun, 29 Jun 2025 12:37:34 +0800 (CST)
X-IP-DOMAINF: 1
X-RL-SENDER: yzheng@techyauld.com
X-SENDER: yzheng@techyauld.com
X-LOGIN-NAME: yzheng@techyauld.com
X-FST-TO: trini@konsulko.com
X-RCPT-COUNT: 4
X-LOCAL-RCPT-COUNT: 0
X-MUTI-DOMAIN-COUNT: 0
X-SENDER-IP: 118.193.106.122
X-ATTACHMENT-NUM: 1
X-UNIQUE-TAG: <7913d5d4f3915be3751e5084ed891c21>
X-System-Flag: 0
X-SENDER-AREA: CN-CN_110000
Date: Sun, 29 Jun 2025 12:37:35 +0800
From: brock_zheng <yzheng@techyauld.com>
To: Tom Rini <trini@konsulko.com>
Cc: David Feng <fenghua@phytium.com.cn>, 
 Albert ARIBAUD <albert.u.boot@aribaud.net>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Subject: AARCH64 clean bss bug
Message-ID: <zfknlzcemnnaka5w2er5wjwefwoidrpndc4gjhx6d5xr6nlcjr@pasfayjiutii>
Series-to: trini@konsulko.com
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="abf2duei6pw2x33e"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 29 Jun 2025 07:18:12 +0200
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


--abf2duei6pw2x33e
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit


Hi, all

    I found a bug on AARCH64 platform about clean .bss section after relocating.

    In crt0_64.S, it use instruction 'ldr' to load the start/stop
    address of BSS after relocating.  My testing shows that
    __bss_start loaded successfuly, but 'x1 <= __bss_end' got the
    address _BEFORE_ allocating.

    If I swap the two instruction sequence, the result is swapped
    also. But neither code can gives the right result of those two
    addesses _AFTER_ relocation.

    my patch use 'adr' instead of 'ldr', seems OK for my RK3568 chip.


--
Brock Zheng <yzheng@techyauld.com>
郑 祎

北京中科腾越科技发展有限公司
北京市 海淀区 东北旺西路8号 中关村软件园27号院 千方大厦A座2层 (邮编:100193)

--abf2duei6pw2x33e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-arm64-fix-up-.bss-section-cleaning-after-relocating.patch"

From 799060d6d373236951afa9d3e571b36fc9e9d026 Mon Sep 17 00:00:00 2001
From: Brock Zheng <yzheng@techyauld.com>
Date: Sun, 29 Jun 2025 12:34:17 +0800
Subject: [PATCH] arm64: fix up .bss section cleaning after relocating

       __bss_start/__bss_end is not loaded correctly by instruction 'ldr'
       using 'adr' instead. Seems OK on RK3568 SoC.
---
 arch/arm/lib/crt0_64.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/lib/crt0_64.S b/arch/arm/lib/crt0_64.S
index 30950ddaf9b..b45c1b65dc4 100644
--- a/arch/arm/lib/crt0_64.S
+++ b/arch/arm/lib/crt0_64.S
@@ -158,8 +158,8 @@ relocation_return:
 /*
  * Clear BSS section
  */
-	ldr	x0, =__bss_start		/* this is auto-relocated! */
-	ldr	x1, =__bss_end			/* this is auto-relocated! */
+	adr	x0, __bss_start			/* this is auto-relocated! */
+	adr	x1, __bss_end			/* this is auto-relocated! */
 clear_loop:
 	str	xzr, [x0], #8
 	cmp	x0, x1
-- 
2.50.0


--abf2duei6pw2x33e--



Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38569C36010
	for <u-boot@archiver.kernel.org>; Sun,  6 Apr 2025 00:25:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A162282B00;
	Sun,  6 Apr 2025 02:25:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="c8qQNaez";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B9E7D82B41; Sun,  6 Apr 2025 02:25:05 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 762D682AAF
 for <u-boot@lists.denx.de>; Sun,  6 Apr 2025 02:25:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=5bca=WY=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1743899102; bh=gkveRiBi8UmKOMRyl58sgplA93JqXjQKoVRTRnLLWjc=;
 b=c8qQNaezT5XVnrEXWG0cT/6H0bOiKJ3IP2AQfsRRDTfYIP8MD/5AdAu3y3DUMG0bwGtrhSdrb
 SyVzBjMPA+TlqM78QKP//ELBOgV/1QmHDWhJ3RZxmSATfP0MWsX0KiNOL0z2H5V2AT5xEaYaMkN
 1JxJOHukWGz5x3TcS471N0UAGRfo1hSvT7YbTi9XxxyTdFU7FewlpoW36lNwED+77JQK/GOqEuf
 XLLwSccVty99GOh4cdST0xgnEzmbTbzzKJZCJdAKiKoXonNa4nPEp6I7AIbEPbhXQ1OlfmQOKBw
 Uyy5heHiAKTSJITBKrEW3eKpohIhIaDoojwZXfcZhY/w==
X-Forward-Email-ID: 67f1c9dbfb2b6fde09d69f2a
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 1.0.0
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 02/11] rockchip: Remove partitions env variable for RK356x
Date: Sun,  6 Apr 2025 00:24:23 +0000
Message-ID: <20250406002447.1555596-3-jonas@kwiboo.se>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250406002447.1555596-1-jonas@kwiboo.se>
References: <20250406002447.1555596-1-jonas@kwiboo.se>
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

The partitions env variable is using an outdated partition layout that
is typically expected to be used with older vendor miniloader blobs.

Rockchip devices will run fine using any partition layout if the first
16 MiB of MMC storage is ignored/skipped.

Remove the partitions env variable to stop encourage users a continued
use of this outdated partition layout on RK356x devices.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 include/configs/rk3568_common.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/configs/rk3568_common.h b/include/configs/rk3568_common.h
index 09b7b71c6afd..a68ca381db57 100644
--- a/include/configs/rk3568_common.h
+++ b/include/configs/rk3568_common.h
@@ -29,7 +29,6 @@
 
 #define CFG_EXTRA_ENV_SETTINGS		\
 	"fdtfile=" CONFIG_DEFAULT_FDT_FILE "\0"	\
-	"partitions=" PARTS_DEFAULT	\
 	ENV_MEM_LAYOUT_SETTINGS		\
 	ROCKCHIP_DEVICE_SETTINGS	\
 	"boot_targets=" BOOT_TARGETS "\0"
-- 
2.49.0


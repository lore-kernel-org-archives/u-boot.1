Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E982C83F1A
	for <u-boot@archiver.kernel.org>; Sun, 13 Jul 2025 23:38:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A5F482DA1;
	Mon, 14 Jul 2025 01:35:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="GbYJRBiY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E79F830C0; Mon, 14 Jul 2025 01:35:42 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2097482FCA
 for <u-boot@lists.denx.de>; Mon, 14 Jul 2025 01:35:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=afea=Z3=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1752449738; bh=jtqyvno6CUAvGzGPyTIEzZw5mKEwfrJAoVQQEI6ahQw=;
 b=GbYJRBiYni7a8flw79oLUB9sqz54WBU9nLhk97mE/KxnS9Gng+1gcxYHol8nVTYCl87p3hFwG
 PrH4Qfgf8BCZXmEre1GcwX+QX5zmZbrunOeVFthw2z9lvpHKylBpJis1kXWBN1VAISW23YEkX/2
 b2MDxIp8VK5GGJudlwiKhi/AjVcImao8jiuw/REh2QXH/aRgKOCRyZIDvvWPbrgdtNsFp0+S3Cb
 /EH7VCE2EhTYESiQVkD9vCs70wggjK/Qo6rgON40D/RrH2VXA9r9nWmrf5M15T6PiB3yEeJyv/G
 Jw8uVrYe+J7SLfFXraLJEfxnGMlfQGozGP1gcuXIMJvA==
X-Forward-Email-ID: 687442c75c59ddd2f404fffa
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 1.1.6
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>,
 Heiko Stuebner <heiko.stuebner@cherry.de>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Jonas Karlman <jonas@kwiboo.se>
Cc: u-boot@lists.denx.de
Subject: [PATCH 16/17] rockchip: odroid-go2: Add myself as a reviewer
Date: Sun, 13 Jul 2025 23:34:04 +0000
Message-ID: <20250713233429.1376172-17-jonas@kwiboo.se>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250713233429.1376172-1-jonas@kwiboo.se>
References: <20250713233429.1376172-1-jonas@kwiboo.se>
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

I have the ORDOID-GO Super variant of this board. Add myself as a
reviewer to help review future patches targeting this device.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 board/hardkernel/odroid_go2/MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/board/hardkernel/odroid_go2/MAINTAINERS b/board/hardkernel/odroid_go2/MAINTAINERS
index 9e83bc9452c8..ee06c2fa6518 100644
--- a/board/hardkernel/odroid_go2/MAINTAINERS
+++ b/board/hardkernel/odroid_go2/MAINTAINERS
@@ -1,6 +1,8 @@
 GO2
 M:      Heiko Stuebner <heiko.stuebner@cherry.de>
+R:      Jonas Karlman <jonas@kwiboo.se>
 S:      Maintained
 F:      board/hardkernel/odroid_go2/
 F:      include/configs/odroid_go2.h
+F:      arch/arm/dts/rk3326-odroid-go*
 F:      configs/odroid-go2_defconfig
-- 
2.49.0


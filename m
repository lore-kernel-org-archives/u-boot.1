Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03996C4345F
	for <u-boot@archiver.kernel.org>; Mon, 22 Apr 2024 06:33:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 17A6E883A7;
	Mon, 22 Apr 2024 08:31:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="GOyKeEai";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB04F88329; Mon, 22 Apr 2024 08:31:05 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0FF4D883A3
 for <u-boot@lists.denx.de>; Mon, 22 Apr 2024 08:31:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=8fac=L3=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1713767453; bh=a9uvU7d+90v//mykerEGzjyrjDl+KqBCI44C54hpG0k=;
 b=GOyKeEaiiUbOKclLAXWfDGkpu05uV5ezTxNTwJBRithX2SXrB7EbQOTDpGFLpzHwsh5t7oNil
 U+DBDgwncUpmd7mHHBWYvhcpklBsSmm2LlP1kNo43kJiF/fo+aFSfMGASEvGCPw+Ji/zijadS2l
 FKhpiFxMJlR2FZwDoY9iKjxIEmErfHgvYYah+eOE96TKD8Sg+qo0UlbGWtqSbcsTAxlm7wZt0yQ
 DG1RrhSVVmqo7E85W1wqvm+k5vExzKZ3dYArNALyZNbENEwR9rvv7mJmtkE3Cz2r1BLLlJutirC
 LWfQXwHbHYxwPDr8uY+hXwz3w4QWtr9kvS8ZldefNr2w==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Weizhao Ouyang <weizhao.ouyang@arm.com>, Elon Zhang
 <zhangzj@rock-chips.com>
Cc: Quentin Schulz <quentin.schulz@theobroma-systems.com>, Dragan Simic
 <dsimic@manjaro.org>, u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v3 20/28] rockchip: rk3588-toybrick: Add .dtb-file entry in
 Makefile
Date: Mon, 22 Apr 2024 06:28:57 +0000
Message-ID: <20240422062936.681359-21-jonas@kwiboo.se>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240422062936.681359-1-jonas@kwiboo.se>
References: <20240422062936.681359-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 6626041c34ba165ad4474408
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

Add Rockchip Toybrick TB-RK3588X .dtb-file entry in Makefile.

Fixes: 9fdd9a546986 ("board: rockchip: add Rockchip Toybrick TB-RK3588X board")
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
v3: New patch split from rk3588-toybrick defconfig patch
v2: Fix Makefile entry from .dts to .dtb (Quentin)
---
 arch/arm/dts/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index 313ef34f5cb7..77c31d7b1edd 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -180,6 +180,7 @@ dtb-$(CONFIG_ROCKCHIP_RK3588) += \
 	rk3588-quartzpro64.dtb \
 	rk3588s-rock-5a.dtb \
 	rk3588-rock-5b.dtb \
+	rk3588-toybrick-x0.dtb \
 	rk3588-turing-rk1.dtb
 
 dtb-$(CONFIG_ROCKCHIP_RV1108) += \
-- 
2.43.2


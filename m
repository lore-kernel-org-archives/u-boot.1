Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64526C36010
	for <u-boot@archiver.kernel.org>; Sun,  6 Apr 2025 00:25:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 02ED282B32;
	Sun,  6 Apr 2025 02:25:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="vWjLVkoK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C9CFE82B2F; Sun,  6 Apr 2025 02:25:11 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7CEA782B46
 for <u-boot@lists.denx.de>; Sun,  6 Apr 2025 02:25:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=5bca=WY=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1743899107; bh=hOgMI2Ao+wVeVSQ5AM3jDb3eaUsD5sHsDo+imKqh3nA=;
 b=vWjLVkoKrpmHz2Cxa32H1AJF7DQrtqAi2f9tdaIgLzuMTyW7dx+LDuYs5oGq46vP9rmyIptUH
 hWZk/jzgRulpS9+8DUuZDn9p1DluTvS7gIRmfGUtOuvzmVpdiWAQ+Hwqz+CvwwTcLCs6iNJ+2MF
 ljFvZ3evxKmUyjEkpLJ2DxubCEYTz6RWVbkPVThgoNtowYNndDOJiY+kFPlp/xc+DCGo5SwwO7q
 s/zpZ0FZUK0JhnZ1xkoP+HMCgLQXtY7K6WQ+PL4lyLPHjWPA2HUdiijfSx+CM82YuIpAsj7XFIa
 o0kzGvgqjCX7hp28RIeUehBn7LrG5Nv2Ts0+bKkWvIBQ==
X-Forward-Email-ID: 67f1c9dffb2b6fde09d69f3f
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
Subject: [PATCH 03/11] rockchip: Remove partitions env variable for RK3588
Date: Sun,  6 Apr 2025 00:24:24 +0000
Message-ID: <20250406002447.1555596-4-jonas@kwiboo.se>
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
use of this outdated partition layout on RK3588 devices.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 include/configs/rk3588_common.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/configs/rk3588_common.h b/include/configs/rk3588_common.h
index e6654c275ac5..7b02560971ad 100644
--- a/include/configs/rk3588_common.h
+++ b/include/configs/rk3588_common.h
@@ -28,7 +28,6 @@
 
 #define CFG_EXTRA_ENV_SETTINGS		\
 	"fdtfile=" CONFIG_DEFAULT_FDT_FILE "\0"	\
-	"partitions=" PARTS_DEFAULT	\
 	ENV_MEM_LAYOUT_SETTINGS		\
 	ROCKCHIP_DEVICE_SETTINGS	\
 	"boot_targets=" BOOT_TARGETS "\0"
-- 
2.49.0


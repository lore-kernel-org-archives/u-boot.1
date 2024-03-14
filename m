Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85230C5475B
	for <u-boot@archiver.kernel.org>; Thu, 14 Mar 2024 11:58:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 88B5B87F69;
	Thu, 14 Mar 2024 12:58:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="dXTzgCLn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 363FF875FA; Thu, 14 Mar 2024 12:58:08 +0100 (CET)
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com
 [46.235.227.194])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5CC8687CFF
 for <u-boot@lists.denx.de>; Thu, 14 Mar 2024 12:58:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=collabora.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chris.obbard@collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1710417486;
 bh=LFuC7tXNzbTiil4EkW0juNWPbNj1rg3N3b0o+3LPQ+I=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=dXTzgCLn60XmtID2b9YunmWtaE2rAmYxtqXz3WGjDeluIEVbgrZHkQ8OnyA+zUAMf
 qGnMuoFxIh02WbDrp0Ae8K/a/wTp+vjd8KEtsb4TGMA/PB9Q19o/viKXvwCWVSudOH
 vpZTF1gfVOGKwLjE0ZpX2B/B32TNXKYHGQSnwGc4ULAjADd+grz6GLhLj05PbkWvna
 fDo6tJGI24vYc/FaY6cllTb0GhI3lII5Wb9Zrkh52mOykyWfJ61uaV6/zZRHb4FVpu
 qdM6YI96wdLsECgfi38hYp9x996ZdkcYBK7cMB3JSItCc+H6IWYUP4dQDvv7h0b7VM
 dqvEVVNWLvJNQ==
Received: from obbardc-t14.home (cola.collaboradmins.com [195.201.22.229])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: obbardc)
 by madrid.collaboradmins.com (Postfix) with ESMTPSA id 5B85537820EF;
 Thu, 14 Mar 2024 11:58:05 +0000 (UTC)
From: Christopher Obbard <chris.obbard@collabora.com>
To: u-boot@lists.denx.de
Cc: kernel@collabora.com, Christopher Obbard <chris.obbard@collabora.com>,
 Dragan Simic <dsimic@manjaro.org>,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 1/2] =?UTF-8?q?rockchip:=20spl-boot-order:=20fix=20typo?=
 =?UTF-8?q?=20in=20comment=20succes=E2=86=92success?=
Date: Thu, 14 Mar 2024 11:57:54 +0000
Message-ID: <20240314115801.241575-2-chris.obbard@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240314115801.241575-1-chris.obbard@collabora.com>
References: <20240314115801.241575-1-chris.obbard@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Fix a simple spelling mistake in a comment.

Reviewed-by: Dragan Simic <dsimic@manjaro.org>
Reviewed-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
Signed-off-by: Christopher Obbard <chris.obbard@collabora.com>
---

Changes in v2:
- Improve patch subject (suggested by Dragan S).
- Collect Reviewed-by tags from Dragan S and Quentin S.

 arch/arm/mach-rockchip/spl-boot-order.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-rockchip/spl-boot-order.c b/arch/arm/mach-rockchip/spl-boot-order.c
index 79c856d2a0a..8f479ac0ec0 100644
--- a/arch/arm/mach-rockchip/spl-boot-order.c
+++ b/arch/arm/mach-rockchip/spl-boot-order.c
@@ -29,7 +29,7 @@
  *   -ENOSYS, if the device matching the node can not be mapped onto a
  *            SPL boot device (e.g. the third MMC device)
  *   -1, for unspecified failures
- *   a positive integer (from the BOOT_DEVICE_... family) on succes.
+ *   a positive integer (from the BOOT_DEVICE_... family) on success.
  */
 
 static int spl_node_to_boot_device(int node)
-- 
2.43.0


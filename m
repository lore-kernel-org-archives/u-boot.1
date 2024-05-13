Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52EBEC25B5F
	for <u-boot@archiver.kernel.org>; Mon, 13 May 2024 03:28:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 746B2882B6;
	Mon, 13 May 2024 05:28:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1715570918;
	bh=oVOZMmeBrvXHiIIr+PVx221RxvuJAZI0MJqNQ428rLk=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=LXoEMlvjMqfKgRJWKeJlIadfajw0MOn8Z8n9RylkiaJq7VGpoq66AbeDccFFZNvjO
	 0VntEuIZXLpK0VWjdzV3iSp4e49j9cdWxIqllK83jyY1rQPWXu2PYSB64lYBluTmDC
	 1Y4STF2P36dlPmTUJGTj9x7ktotN6eH6N5KzYMU2RqdkfhJdjwIRjRWb2b38x6YYG8
	 NAx1DZIjV2uzhWSJcC0KeUercIyezI5fjrAXgHzhTBJXs+0i5CR5PWFi5EVLYvJ8nZ
	 fsADzHxuEUEqUGHPfJE5ekzgbyAmAvLSOJWDG+lvES9qQibuXSObqh9Ks9Ekg21v6E
	 Pkq/N2Pr+1mdA==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 8CEB487D43;
 Mon, 13 May 2024 05:28:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1715570917;
 bh=oVOZMmeBrvXHiIIr+PVx221RxvuJAZI0MJqNQ428rLk=;
 h=From:To:Cc:Subject:Date:From;
 b=mEliUuvh+Lto2giwm3QyagacnRnftbYEEBSwNs67Rb5vQtHgbHkhxHVnv81r3iFbK
 wXDCYsAgSobdYPbdeEeNu+cQjRBr2c8+Am9XjztSN8Kv0yMOYzGlFlc/VP0cUTgavF
 yZJrnB/SAHR548PQoqAVTemExN+CagTKG9+A0YUOGa032wfgBW2irj+W1NN7n/WrWe
 +zMkUwZQ05GFzcbVzPdjYc3NpUFeU11cEM9M3VWRdNhij+JKsKZjjDncyabsH0kMzF
 Rs82LrvLZfk2WcyzNd3foRkFwznLEEacrp3+hEVVP7JbmYCMkWKG3qChmDs8y19Uan
 +c+xaNNfSZY2g==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Claudius Heine <ch@denx.de>, Fabio Estevam <festevam@gmail.com>,
 Stefano Babic <sbabic@denx.de>
Subject: [PATCH] ARM: imx: Add doc/imx/ to i.MX MAINTAINERS entry
Date: Mon, 13 May 2024 05:28:06 +0200
Message-ID: <20240513032822.139706-1-marex@denx.de>
X-Mailer: git-send-email 2.43.0
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

Make sure i.MX maintainers are CCed on doc/imx/ patches.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Claudius Heine <ch@denx.de>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Stefano Babic <sbabic@denx.de>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0462ade4ac6..6aed4a526ee 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -307,6 +307,7 @@ F:	arch/arm/include/asm/mach-imx/
 F:	board/freescale/*mx*/
 F:	board/freescale/common/
 F:	common/spl/spl_imx_container.c
+F:	doc/imx/
 F:	drivers/serial/serial_mxc.c
 F:	include/imx_container.h
 
-- 
2.43.0


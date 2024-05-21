Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CB47C25B74
	for <u-boot@archiver.kernel.org>; Tue, 21 May 2024 09:40:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9254588131;
	Tue, 21 May 2024 11:40:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1716284414;
	bh=jgGhWWvg1sY55wspfdH4v1zy6zeRcsbnYv9xnrDShFU=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Ndch4oBD/trsH+NiPbu48ikBzWJ7Ntr1lH5yed6iHfTtqRyg2UpatH8l7N/ZxcOrM
	 bs218pSn2M238NNATJvf7TwsT1zFSyy68+lwzUD4CTrQRg9xv3qi7t7xpjzqly4Lzq
	 QlYCwrJM3QU5qjGORIkx1qhv+d7Pry/uiyf0NCIS2qiVO73osW3q0T6v9hfOSZqIgv
	 vAfjCVI10ykNXKOHzhMNQkiIcq/7na+V20XJIl6ibZblDPMbwLUjC06KoA4siDp0m+
	 Bvzlk5q896cC10NxMH6URAcIeswxmPuIaZUz/cpX5k/jaXi7paHEU0jPw2H9earEoQ
	 0CfT4dfxiHDVw==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 1172E880E5;
 Tue, 21 May 2024 11:40:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1716284413;
 bh=jgGhWWvg1sY55wspfdH4v1zy6zeRcsbnYv9xnrDShFU=;
 h=From:To:Cc:Subject:Date:From;
 b=DoDyMdNX/al+QksZLkKsacIwPYoUSCWGoDVlDbngAKmGszDp93dZikiku1K06iP4s
 JOUJMPMOFz+qRTJq/49pVkr5xP+RO7f5/6nT/j0lEh8kUa4QF011b22Xex7bPG6zKn
 ECHp/jXUO8l9afti7IaKoBGgoVUj3/GRFLpqi/sNEEzv4VoqHU8j4m1XPP+vK8tbQi
 lgYoyw54Ge/IVgwDOWipsiI5DF5K1VOOFjsFToSMcCLc061zyml/TOED2TbsYerc9S
 vV0dHMaEjZM4kBCcK11s8+08MyZHSR20fzSNSTBlvuWjZns0ZnZ0VYC+XM0Pv7qcOC
 9FOjrOu55QpDw==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Fabio Estevam <festevam@gmail.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Philippe Schenker <philippe.schenker@toradex.com>,
 Martyn Welch <martyn.welch@collabora.com>, Stefano Babic <sbabic@denx.de>
Subject: [PATCH] ARM: imx: Increase PHY auto-negotiation timeout to 20s on
 MX8Menlo
Date: Tue, 21 May 2024 11:39:38 +0200
Message-ID: <20240521093950.8810-1-marex@denx.de>
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

The ethernet PHY on MX8Menlo board takes a while to come out of
reset, increase the auto-negotiation timeout to prevent it from
timing out in case the ethernet is used right after the board was
reset.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>
Cc: Marcel Ziswiler <marcel.ziswiler@toradex.com>
Cc: Philippe Schenker <philippe.schenker@toradex.com>
Cc: Martyn Welch <martyn.welch@collabora.com>
Cc: Stefano Babic <sbabic@denx.de>
Cc: u-boot@lists.denx.de
---
 include/configs/imx8mm-mx8menlo.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/configs/imx8mm-mx8menlo.h b/include/configs/imx8mm-mx8menlo.h
index a86bd76a3c7..5cc60af91e5 100644
--- a/include/configs/imx8mm-mx8menlo.h
+++ b/include/configs/imx8mm-mx8menlo.h
@@ -8,6 +8,9 @@
 
 #include <configs/verdin-imx8mm.h>
 
+/* PHY needs a longer autoneg timeout */
+#define PHY_ANEG_TIMEOUT		20000
+
 /* Custom initial environment variables */
 #undef CFG_EXTRA_ENV_SETTINGS
 #define CFG_EXTRA_ENV_SETTINGS					\
-- 
2.43.0


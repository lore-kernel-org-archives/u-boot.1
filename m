Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41D5DCFB424
	for <u-boot@archiver.kernel.org>; Sun,  6 Oct 2024 23:12:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA7F988B9E;
	Mon,  7 Oct 2024 01:11:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1728256318;
	bh=RLgH/YnkpDlL4hIFcIGA/e5hi0XiqWLiQAQaTqYAGqM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0UdWf9r1xnKg5PR86nyRrTKqpChnPCqCLQW7FbowNLwkzJyLhPcNq/gi6LXyQezQE
	 UV4QpBOLj0xptn4uIM+vgPZT57eJ+GH6KnAiXaNtFF3GYmCQNdnN+4SIXs0hJ5TgBS
	 ZEzuog6HKBBp2CJFn7WTsaGIUv2B4tNoy363nOdJoyQ5niCuJ9xbQL8lIKkEr+b5FT
	 FzZaNWfyasURQhNRUctxm46Ma7g85HY8j3NB7W5/C8An9+PWRllVEj5IUoU01fexfM
	 PVd4cRKavVuiXjyTsLseLhKaaKFFjWcEM3Bc7cwAkY+8qULE4D0Nqm/9BBlp6hWzu/
	 9DkxSB+HTsMSQ==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 7CB31889AA;
 Mon,  7 Oct 2024 01:11:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1728256317;
 bh=RLgH/YnkpDlL4hIFcIGA/e5hi0XiqWLiQAQaTqYAGqM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=NExg6reS0OKaVpFbuX4GamHAKc/7nJWCRN7GsBzlIpUEK7T2Ken2AdTiHYN2+asuf
 sZJVDMXGy6aOK/3IuLY8PVfegN7+VVuZUE7KkC55D29+sT57TMGRmD0VjlJv7qtgan
 zCG/Zpj5bs24u8m2ilvOcHqsdo5uaF2cbXdYgX1na1K7AksM/D6nVRwfG1b31jV5o3
 dZ6Sc/8u2UPTMmDva0uL7rW6B2ABoSiem8xZd9nPviC2wa9DGss4YYirIj7wvbLGus
 D6KdZsQMndGTx2+uj9jTx/8JYww+FlrInUZ5YG0/un5FWbQOP1nZzn3MAM3D4aBsx7
 jil01G55E3opw==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Andreas Geisreiter <ageisreiter@dh-electronics.de>,
 Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 Fabio Estevam <festevam@denx.de>, Tom Rini <trini@konsulko.com>,
 u-boot@dh-electronics.com
Subject: [PATCH 2/2] ARM: imx: Update MAINTAINERS file globs for i.MX8MP DHSOM
Date: Mon,  7 Oct 2024 01:11:10 +0200
Message-ID: <20241006231142.126771-2-marex@denx.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241006231142.126771-1-marex@denx.de>
References: <20241006231142.126771-1-marex@denx.de>
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

Update the MAINTAINERS file glob to cover all of i.MX8MP DHSOM related files.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Andreas Geisreiter <ageisreiter@dh-electronics.de>
Cc: Christoph Niedermaier <cniedermaier@dh-electronics.com>
Cc: Fabio Estevam <festevam@denx.de>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@dh-electronics.com
Cc: u-boot@lists.denx.de
---
 board/dhelectronics/dh_imx8mp/MAINTAINERS | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/board/dhelectronics/dh_imx8mp/MAINTAINERS b/board/dhelectronics/dh_imx8mp/MAINTAINERS
index db69781a852..cf9f77252c9 100644
--- a/board/dhelectronics/dh_imx8mp/MAINTAINERS
+++ b/board/dhelectronics/dh_imx8mp/MAINTAINERS
@@ -2,7 +2,5 @@ DH electronics DHCOM i.MX8M Plus and matching carrier boards
 M:	Marek Vasut <marex@denx.de>
 L:	u-boot@dh-electronics.com
 S:	Maintained
-F:	arch/arm/dts/imx8mp-dhcom*
-F:	board/dhelectronics/dh_imx8mp/
-F:	configs/imx8mp_dhcom*defconfig
-F:	include/configs/imx8mp_dhcom*
+N:	imx8mp.*dh[cs]o
+N:	dh_imx8mp
-- 
2.45.2


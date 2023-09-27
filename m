Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75477E810DC
	for <u-boot@archiver.kernel.org>; Wed, 27 Sep 2023 12:46:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DCC1486D93;
	Wed, 27 Sep 2023 14:46:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1695818807;
	bh=FvD66zdZNTnLz/Oia9Tt6/38K4QCX9PStrkbt4XStjA=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ho1xw1ChK1GZD37hNdgzE+ObI7h3UkNmFZplHS8wVWmOd6u2i1WT25XYVPaDbWfPa
	 QcHozRYfebt7BvpGjUsB/zfmBLL/U/yoaYiHYqyYFBHeaIbSYh4l8gmCtbq5mcCf9t
	 Snln0JZVg3fUYImLCjic8m3r7u09PYzzEZQObIfnyW8/ZwvOha1WLKeudVHZAsb3jc
	 BMa3QfS2Yyxvr+ma68YxtO+X97Q/DoGH2oZStGh09+ocYbBhNHvYg97vYPmfIWNFaW
	 yeM29MN4i4gJWJKlWe+VnxDYFKfUbelxEPLgNHH3qLNeNjDNwJ2epvz+EjALH1z23o
	 IZDfVmJSDT6EQ==
Received: from maia.denx.de (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested) (Authenticated sender: hws@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id D12B986D59;
 Wed, 27 Sep 2023 14:46:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1695818806;
 bh=FvD66zdZNTnLz/Oia9Tt6/38K4QCX9PStrkbt4XStjA=;
 h=From:To:Cc:Subject:Date:From;
 b=g+HZ878BE8GV0+c2pP8GolBHYTMjHZfsKxoxIGBPdyLnachJAaPhviTSKrIcccaIe
 4zrf6DBPzr0NfV9bOqASkmN7Xyk+WmjfvmvJQ5lCSIu4t0IpoesRWj75jD0wEbHyF1
 kDriHp3itQ1IqK9VJqYFZx7/3lt3mkRV3bl0vxOyveFRcqvIq8BLd/xrPD/dDkroUj
 Svs1st+cAifp9DMdN5XXJLoNaFEUM380Lnm9+VE9sYW5kfpD97QeQ6No/q07UrgOim
 8bssfFsw1Ov9tZQRIvS3QJmJv2GPU9Czs/4ljkoqgi25pLeQKHPdOjNSCjpEXML9T4
 AmgO5H4mGiJBA==
From: Harald Seiler <hws@denx.de>
To: u-boot@lists.denx.de,
	Marek Vasut <marex@denx.de>
Cc: uboot-stm32@st-md-mailman.stormreply.com, u-boot@dh-electronics.com,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Harald Seiler <hws@denx.de>
Subject: [PATCH 2/2] board: dh_stm32mp1: Only print board code with
 CONFIG_SPL_DISPLAY_PRINT
Date: Wed, 27 Sep 2023 14:46:25 +0200
Message-ID: <20230927124625.247858-1-hws@denx.de>
X-Mailer: git-send-email 2.41.0
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

Ensure that the SoM and board code information is only printed when
CONFIG_SPL_DISPLAY_PRINT is set.

Signed-off-by: Harald Seiler <hws@denx.de>
---
 board/dhelectronics/dh_stm32mp1/board.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/board/dhelectronics/dh_stm32mp1/board.c b/board/dhelectronics/dh_stm32mp1/board.c
index f9cfabe2420..b933761d0de 100644
--- a/board/dhelectronics/dh_stm32mp1/board.c
+++ b/board/dhelectronics/dh_stm32mp1/board.c
@@ -229,8 +229,9 @@ static void board_get_coding_straps(void)
 
 	gpio_free_list_nodev(gpio, ret);
 
-	printf("Code:  SoM:rev=%d,ddr3=%d Board:rev=%d\n",
-		somcode, ddr3code, brdcode);
+	if (CONFIG_IS_ENABLED(DISPLAY_PRINT))
+		printf("Code:  SoM:rev=%d,ddr3=%d Board:rev=%d\n",
+		       somcode, ddr3code, brdcode);
 }
 
 int board_stm32mp1_ddr_config_name_match(struct udevice *dev,
-- 
2.41.0


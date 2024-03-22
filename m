Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E76A9C54E71
	for <u-boot@archiver.kernel.org>; Fri, 22 Mar 2024 11:44:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 159D388225;
	Fri, 22 Mar 2024 12:43:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1711107821;
	bh=0k637n1HW6P0eUCRsAatIwfvlhwPqOkxCBMluFt69uw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uDUtqJhrtY6EZ1aZ8PlRIVBbaJXgRvlFugEIWiLO4CnHCZiLoapgpl8evZwdb2QFr
	 1IO3SBuJ7c7qii4XmlzI8AMQCAzYhGKAL2ZGHrgbdWwi7sDDVmSHRBt5uTebcfbzgS
	 4CRDBp3U2VH2b+XqZABPv+wsTSfYaDyVERzoHUmdHxNTZtyj01SN/v0lCSb7txnUyG
	 9+a8SUFlHbr2snoL56u/FMpOY8Zxbebf3z1cSCZGnfGoDD1uQkkDjww5v8yLCd0DBu
	 5H1MdbbriLQ3d5fRtoD4xLlxUQ7S0YzDBw1ou3O4LvcPlzIlcE1PUq3qnRrjIERHP8
	 kCT6oL8Zc7pLQ==
Received: from localhost.localdomain (85-222-111-42.dynamic.chello.pl
 [85.222.111.42])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: lukma@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 1FC51881EB;
 Fri, 22 Mar 2024 12:43:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1711107818;
 bh=0k637n1HW6P0eUCRsAatIwfvlhwPqOkxCBMluFt69uw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Vundh7uMurEbv1EEI/0t1qinq0V2UEJ1RWR5h6ixONml8BPIbu+AlucYbp+0yhkCd
 imihYmEkh1hqym4/BkNAKBiqUDhgSCVVh18z/vXrRipWoUj7j/TCYiKnavahf3hpeJ
 umahPbn2/O7QUc14YEvFLicEsJk+ZAnfzoyqxKSLx5E68bm/4WvrEPdijgDX/BqpB5
 uwwtaDdKNWVrbpirCRY5Rh6Cc/yCjUZ39RqswXpI0cIkCJ+BrYWqOH7OaQRqsJ3Q8f
 +dmACxIuL9tqv1H17gs3gLyz/2jLJu1wbcTotV3q5Ctb3tC6huh4YOVWuo1Dx3JY8s
 eIH6qd8ta94wQ==
From: Lukasz Majewski <lukma@denx.de>
To: Stefano Babic <sbabic@denx.de>,
	u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>, Anatolij Gustschin <agust@denx.de>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 06/12] arm: xea: Add support for multiple dtbs in u-boot
Date: Fri, 22 Mar 2024 12:43:09 +0100
Message-Id: <20240322114315.2720727-7-lukma@denx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240322114315.2720727-1-lukma@denx.de>
References: <20240322114315.2720727-1-lukma@denx.de>
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

As XEA board uses imx287, which has some constrains on SPL (u-boot.sb)
size - it must be less than ~55 KiB, multiple boards versions are included
in u-boot proper's FIT image.

The decision of using proper configuration is based on information passed
from SPL (u-boot.sb) in OCRAM dedicated location (0xE000 - 2).

This board also uses falcon boot for production setup, so the proper
dtb is flashed during production (also based on GPIO values describing
HW ID).

Signed-off-by: Lukasz Majewski <lukma@denx.de>
---

 board/liebherr/xea/xea.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/board/liebherr/xea/xea.c b/board/liebherr/xea/xea.c
index d9cf27c81b..615d266b8f 100644
--- a/board/liebherr/xea/xea.c
+++ b/board/liebherr/xea/xea.c
@@ -287,6 +287,21 @@ int dram_init(void)
 	return mxs_dram_init();
 }
 
+#if defined(CONFIG_MULTI_DTB_FIT)
+int board_fit_config_name_match(const char *name)
+{
+	u8 rev_id = get_som_rev();
+	char board[11];
+
+	sprintf(board, "imx28-xea-%d", rev_id);
+
+	if (!strncmp(name, board, sizeof(board)))
+		return 0;
+
+	return -EINVAL;
+}
+#endif
+
 #ifdef CONFIG_OF_BOARD_SETUP
 static int fdt_fixup_l2switch(void *blob)
 {
-- 
2.39.2


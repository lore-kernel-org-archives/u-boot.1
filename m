Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBA07C531D0
	for <u-boot@archiver.kernel.org>; Mon, 27 Jul 2026 09:09:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B56C880CBF;
	Mon, 27 Jul 2026 09:09:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9CxXaTpO9XBj; Mon, 27 Jul 2026 09:09:42 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EB83F80C46
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785143382;
	bh=MMYBGv76VQ5abVBIl18A4h2P7U7Bu0wq6kzwhpw23EQ=;
	h=Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=IQETjgBx2A7lSqwXcpAjnSMD8+8N1bg5cdT6YPtNqYs/0zoZUlF8Vg2RkKYU8/kI6
	 JCrc8X+yQPCBW+RUbFOEp0cvWlghsODcIuETAiT5D2H4f46aSMYBryFpZEl1O+75fz
	 HuISCOr0PZiGUzK8tZkoOh0P79bwHYEqpRBJWuRqNPbRJM4LtqXb1TPBFP2K6uhn8G
	 7RTUCFhGOG08nMIYwNEYIKv4SOKYufwaCjicYCvaIeyCbyzh5BQFJxSsAEA/U0p0KX
	 G7Ypt2MP6kx8MleLTkEn+Mo0KIU0mQwK/62XCETciDnfRLDRnrbXc4VUuWDrysSuEs
	 EGFfIEkl+Qtog==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id EB83F80C46;
	Mon, 27 Jul 2026 09:09:41 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id B781342A
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 07:10:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9D59980C72
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 07:10:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RbN388IkBmcd for <u-boot@lists.u-boot-project.org>;
 Mon, 27 Jul 2026 07:10:34 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=136.143.188.94;
 helo=sender4-pp-o94.zoho.com; envelope-from=zhuxu_ran@zohomail.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 8B0B980C75
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8B0B980C75
Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com
 [136.143.188.94])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8B0B980C75
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 07:10:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1785135193; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=K6Smn8GxC5R2kyfKtv1PPmOU6SwHQFXmU8/OdIKjEvxzWsWzDypIo1nAB4aDabI1PV5TRvtabcEqwEvZlXoPIsIWsyR5GiRtDhpJva/exzRrsTpkecE4aFe0XUf+kOJWjDKQPTh/+kaRZtfswoUjK9gs4ldnaMaRF5eDTkRYrM8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1785135193;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=MMYBGv76VQ5abVBIl18A4h2P7U7Bu0wq6kzwhpw23EQ=; 
 b=Mi3eBFbCC3at0kB35HFmLf71erVEESxWn8EbyEDqf0yCRQbtRIlo4YQzdeRBqYhr3GsmgHsiVCDEvHJ13XoD9iZkDuoitm+FmyiGHY8FeIH3ivUL7ApbJ3p3ilVeRZUZUXFCd5LcaTVPLrygUBXBmBqBxywppL85jC/gqGH3l3A=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=zohomail.com;
 spf=pass  smtp.mailfrom=zhuxu_ran@zohomail.com;
 dmarc=pass header.from=<zhuxu_ran@zohomail.com>
Received: by mx.zohomail.com with SMTPS id 1785135190238403.47511468447374;
 Sun, 26 Jul 2026 23:53:10 -0700 (PDT)
Date: Mon, 27 Jul 2026 14:50:12 +0800
Subject: [PATCH RESEND v2 3/7] riscv: licheerv_nano: Enable hardware system
 reset
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260727-milkv-duo-upstream-dts-v2-3-51486b4549c7@zohomail.com>
References: <20260727-milkv-duo-upstream-dts-v2-0-51486b4549c7@zohomail.com>
In-Reply-To: <20260727-milkv-duo-upstream-dts-v2-0-51486b4549c7@zohomail.com>
To: u-boot@lists.u-boot-project.org
Cc: Lukasz Majewski <lukma@denx.de>, Tom Rini <trini@konsulko.com>, 
 Zhuxu Ran <zhuxu_ran@zohomail.com>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Stefan Roese <stefan.roese@mailbox.org>, 
 Hiago De Franco <hfranco@baylibre.com>, 
 Thomas Bonnefille <thomas.bonnefille@bootlin.com>, 
 Kongyang Liu <seashell11234455@gmail.com>, 
 Tim Ouyang <tim609@andestech.com>, Leo Liang <leo.liang@sifive.com>, 
 Guodong Xu <guodong@riscstar.com>, Andreas Schwab <schwab@suse.de>, 
 Junhui Liu <junhui.liu@pigmoral.tech>
X-Mailer: b4 0.15.2
Feedback-ID: zu08011227cebe1cdc0a3c888970fc8ff20000fdeb8191029d28effb173cd24d002d21ee86c1a1faa7169085:ZohoMail
X-Zoho-CM-AccountID: 475a6e82b6074d1cdb8624e432e1257a5f0812bb6089f487c4846d9f660201e2
X-ZohoMailClient: External
X-Mailman-Approved-At: Mon, 27 Jul 2026 09:09:33 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt;
 c=relaxed/relaxed; t=1785135193; 
 s=zm2022; d=zohomail.com; i=zhuxu_ran@zohomail.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Feedback-ID:Reply-To;
 bh=MMYBGv76VQ5abVBIl18A4h2P7U7Bu0wq6kzwhpw23EQ=;
 b=I0s48TG1iE6/2WXPwAQ7oa1HhyOQVTMF4RsI1YtIgzo3AugJfHNc6wVksivAk5tN
 OPELdLrPuDMlZExmtlBjBAK7A19CMCfXyI4OyhXjFQV80AqCvSp8UWvIPXfeYvvsG31
 MLSuEvqgoM/srZYMiZpwrFh6gdh+KDcptdRYmUWI=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=zohomail.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=zohomail.com header.i=zhuxu_ran@zohomail.com
 header.a=rsa-sha256 header.s=zm2022 header.b=I0s48TG1
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
From: Zhuxu Ran via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Zhuxu Ran <zhuxu_ran@zohomail.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

SG2002 uses the same RTC system reset registers as CV1800B, but
LicheeRV Nano does not bind the existing CV1800B sysreset driver.

Enable board-specific initialization and bind the sysreset driver in
board_init(), following the approach used by Milk-V Duo.

Signed-off-by: Zhuxu Ran <zhuxu_ran@zohomail.com>
---
 board/sophgo/licheerv_nano/board.c     | 9 +++++++++
 configs/sipeed_licheerv_nano_defconfig | 1 -
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/board/sophgo/licheerv_nano/board.c b/board/sophgo/licheerv_nano/board.c
index e6099d35dbf..c0685c44662 100644
--- a/board/sophgo/licheerv_nano/board.c
+++ b/board/sophgo/licheerv_nano/board.c
@@ -3,3 +3,12 @@
  * Copyright (c) 2024, Kongyang Liu <seashell11234455@gmail.com>
  */
 
+#include <dm/lists.h>
+
+int board_init(void)
+{
+	if (IS_ENABLED(CONFIG_SYSRESET_CV1800B))
+		device_bind_driver(gd->dm_root, "cv1800b_sysreset", "sysreset", NULL);
+
+	return 0;
+}
diff --git a/configs/sipeed_licheerv_nano_defconfig b/configs/sipeed_licheerv_nano_defconfig
index 9aa3ede10c5..ab29f327d7a 100644
--- a/configs/sipeed_licheerv_nano_defconfig
+++ b/configs/sipeed_licheerv_nano_defconfig
@@ -17,7 +17,6 @@ CONFIG_SD_BOOT=y
 CONFIG_BOOTCOMMAND="run distro_bootcmd"
 CONFIG_SYS_CBSIZE=512
 CONFIG_SYS_PBSIZE=544
-# CONFIG_BOARD_INIT is not set
 CONFIG_SYS_PROMPT="licheerv_nano# "
 # CONFIG_CMD_BOOTDEV is not set
 CONFIG_CMD_MBR=y

-- 
2.55.0


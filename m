Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FFD0C55ABF
	for <u-boot@archiver.kernel.org>; Thu,  6 Aug 2026 13:05:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3D4606081E;
	Thu,  6 Aug 2026 13:05:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id z-DZId7tIQmB; Thu,  6 Aug 2026 13:05:07 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 28D3060807
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786021507;
	bh=7eq7ormTdd18xn3pDEICMdGz/bHjQVrPxCvIQ30Vr+g=;
	h=Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=dSnlIE1FSEq3bTjdESzsogTbHnUvpMSVBobkVCcV2xulXEbgozqynEvWKTrUQqESp
	 UwGbv3YnFzaORoGpIASXlQmb+30Jn9yIV76UTe4p4L8CM2OjGqRXKrCMzyI9JIKWUt
	 QIgomCFY4tEEkDC2ggeDudid4xVisJk8exa4/k7VUShjBS77IiyvsyhtJKOrD2STQW
	 4lt+/9FfkRGU6dtv3SExmd29p7muVkf9rvHtzQuuAEy5Od8Qf50VW7wp6TVnezWAtL
	 ibt7AwcF/WSTtxtz6jSc6EiBRsX2ukHq7arE6CFhVUD+53Xqb4SK6H9ukHxDU54PeP
	 k/FhRRMv65FTQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 28D3060807;
	Thu,  6 Aug 2026 13:05:07 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 2942C198
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 12:16:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0EF2D80DB5
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 12:16:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PnAXk74uQvGW for <u-boot@lists.u-boot-project.org>;
 Thu,  6 Aug 2026 12:16:33 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=136.143.188.94;
 helo=sender4-pp-o94.zoho.com; envelope-from=zhuxu_ran@zohomail.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 1622080D3F
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1622080D3F
Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com
 [136.143.188.94])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1622080D3F
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 12:16:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1786018441; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Fi+wmjjdiDT1D3hzJh8ymoA+H87QEMpk6X03fjbM1WlWZC4KkUYaz8mcWIJvzYcOnlLm0x3dOREIeETnisYWZrwsLGAhyuGchl6DewN1Tu/ERyDmZfM2mTjS7VJ2D/+CB2/oKelQrsJN4AWMULItDKAYfnOGeTKM6UWuXGhrwQI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1786018441;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=7eq7ormTdd18xn3pDEICMdGz/bHjQVrPxCvIQ30Vr+g=; 
 b=ZlFer6G37LPTqMny0ESvMMmAdiDEPSdBHgt/VzLY3whlThHUlGM7YtFfEYQwWRT++VYmsIVlMrzFq6rLKsN3KoKFoAjsFugyS0xmVY2UmbsJXcbDQC7V8IOJXQ+r22605VLx+RKVQSvQj1Ezk0izB+KnRcPlnr5Nykfduaes7lc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=zohomail.com;
 spf=pass  smtp.mailfrom=zhuxu_ran@zohomail.com;
 dmarc=pass header.from=<zhuxu_ran@zohomail.com>
Received: by mx.zohomail.com with SMTPS id 1786018438728858.4963597422915;
 Thu, 6 Aug 2026 05:13:58 -0700 (PDT)
Date: Thu, 06 Aug 2026 20:13:23 +0800
Subject: [PATCH v3 3/7] riscv: licheerv_nano: Enable hardware system reset
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260806-milkv-duo-upstream-dts-v3-3-917cf70a2337@zohomail.com>
References: <20260806-milkv-duo-upstream-dts-v3-0-917cf70a2337@zohomail.com>
In-Reply-To: <20260806-milkv-duo-upstream-dts-v3-0-917cf70a2337@zohomail.com>
To: u-boot@lists.u-boot-project.org, Yao Zi <me@ziyao.cc>
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
Feedback-ID: zu08011227a6cee9691ae4820777b2872e000001ab1120ad5e7d78e2e8012d32155e5c9d9a60c052be3dda63:ZohoMail
X-Zoho-CM-AccountID: 475a6e82b6074d1cdb8624e432e1257a5f0812bb6089f487c4846d9f660201e2
X-ZohoMailClient: External
X-Mailman-Approved-At: Thu, 06 Aug 2026 13:05:01 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt;
 c=relaxed/relaxed; t=1786018441; 
 s=zm2022; d=zohomail.com; i=zhuxu_ran@zohomail.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Feedback-ID:Reply-To;
 bh=7eq7ormTdd18xn3pDEICMdGz/bHjQVrPxCvIQ30Vr+g=;
 b=drtXewrJOA4GYRh7IB2TxMLja8Br4n0qAdcIvHjx7/rwN8vLhiw1qiy4+kjPgl45
 1DY4lt8NQQqeduBkwB171slM12w5rQ09dD9uVGx473XcSEJMBaHsM0CVKqJskjZzsfx
 ZLqP00gcjKrSPiIIaxohNal/k7cxtR/JU9z4VQis=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=zohomail.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=zohomail.com header.i=zhuxu_ran@zohomail.com
 header.a=rsa-sha256 header.s=zm2022 header.b=drtXewrJ
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

The LicheeRV Nano configuration disables board_init(), so the existing
CV1800B sysreset driver is never bound. This is an existing board issue
exposed while validating the upstream SG2002 devicetree conversion.

SG2002 uses the same RTC system reset registers as CV1800B. Enable
board-specific initialization and bind the driver in board_init(),
following the approach used by Milk-V Duo.

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


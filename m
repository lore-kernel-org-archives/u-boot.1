Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F235BC61DCD
	for <u-boot@archiver.kernel.org>; Fri, 28 Aug 2026 08:40:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6054580ECD;
	Fri, 28 Aug 2026 08:40:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 42NHKr4r1QEf; Fri, 28 Aug 2026 08:40:15 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787906412;
	bh=KDh+4fJGkRoB8OU0pYvGXt5znqOX+KA64hH6C1Gi2r0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cFEj5F9Fs3Dz+iMFJvjuQICVmaKCdX4eV4e/GxMuhJ247Gcec51UF1cE4flDGSbgm
	 GW3d7FqBLJTeUcrrFnySS7D7FtYnZR5SPtcSTsVeOUDWbH5Jg6SEd2QQEiO401NPVK
	 KLGBD3Bq06QxzGuCkxtjnoUOb3CQNbGD879etZGvO7KpOZ5q4Y2S57kIyYf1kzCu7w
	 g//iSMBbmFpfxGth3FM3xo15Fvxj7xtQVF8Rh5SIvcT4EP7uO0qVuDrlH8g+11blgI
	 0JaauMlmbYrHdeMm/Q8SxE6OMaTv33MIhKlgECEaV37xZRLT8SJaeXTGHhPnAf4lef
	 Y66p7vwn2CzNQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7F47B80EAF;
	Fri, 28 Aug 2026 08:40:12 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 02EB3386
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 08:40:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DD654407D3
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 08:40:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kjezc5vaGnzn for <u-boot@lists.u-boot-project.org>;
 Fri, 28 Aug 2026 08:40:07 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::333; helo=mail-wm1-x333.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=kHD4U7Yx
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 by smtp4.osuosl.org (Postfix) with ESMTPS id DA92C40767
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 08:40:06 +0000 (UTC)
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-49b0eab380eso6450065e9.0
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 01:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1787906405; x=1788511205;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KDh+4fJGkRoB8OU0pYvGXt5znqOX+KA64hH6C1Gi2r0=;
 b=kHD4U7Yxuevl5G5fXVeAq9rM2xU/bnscaILUHjK6upXJW0Nm7cr3HKo/UhsfOj8EQb
 987S5fYPIC3erIjG2C8xzuTG06ZRxj5VKvlgfHyFy78XuoIjGbkc9Eb1pBM3U9xo67BN
 KKP5OxvYWjsVn1gRliM+yZp8/c+kclJuw4n7A1mdo1SDl09tcg7X3UoUzmBQXRJFO4b3
 Yt01Oy33O5K6mZrTozBVmblFNSEIR4zhZe+JSqtoA+FDqqeybYZ3n6u8ULEa9vjyK+15
 YJvOwJuZqDCBwfVlWBiUpAl6MUOJeukhBg8arbzS7mW5bEteLC5pg4n0jGgwoe7fLSBS
 DSuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787906405; x=1788511205;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=KDh+4fJGkRoB8OU0pYvGXt5znqOX+KA64hH6C1Gi2r0=;
 b=OT5ZGgwlW4hVH4VbpHEu0fux8mudVq5A/nuCro51Oky7TAdy2nIEmZLnvEo8RnSev/
 O07pqOyhyuSbYfMh3yXVPTkyY74Hpi1gDisKQ5pTd1U/GSnFjCDJxqgTL23lQDZ3NlIb
 6JDMHifoaMWRamCanA5eb4781HRNkER/lst2zZRBbZ2/acRFG426xTxfDhD2PkHVMlYW
 T57C+/TDCNmTzwflQ/cP55DmTRHloqClE3q/5NK9RgujZ72Ezuw4jr5jX/j2KR8t0344
 FzlBUPSXfRv7b4NVjRzMdJe1slgJsfabF3ELU5hD4vP0vMa4eF2HZX99q4lBgr/OObym
 7Xdw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrKg+X8bkTk7ZkPctSiDNUyyi+8fHZ0kYbyc53CRo7EIU6qFgb7ieZnMcSQuxniBwtWJhtndQw=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++moU55A67cRL13NVVMjgsVBWJkTzLIpf2XX4Cuplgm5YyzrlqU8
 +ZdiKbyFJNIehwHX/5GCfNQjdd9sGKBgpja+/WcA8IPoCVEiObIq/sVlBMgVPbmmK7o=
X-Gm-Gg: AR+sD12vZFNroVsQGA1uqF8JAABFtGlmg7KTSzjftIedprzSxLR4+ug7nk5+8OmqnsF
 HUEXD02qUWoAMjLH0R3WCclOkT/qy2lXcxvhu93+hlOBhCwxuz2EgPJ4QVj5i5dPBz2yuhQUoCY
 AsQPkgVDIzpUJv9C3bIODSxoU9vlOlAUUSJSoZ050n1hT5Q/ElUQgGWpzyaaSuZmyA5cYtDuDAt
 BG1ZS0qDfysKaVYAbDJV0ThLDJLLEJMu460/BgBbORP/2gV1Gi5JKwm530y3Q1v7b2bgp5Hcz36
 Ds3QxRCPuKESa2IaM/uZLj1wVkqyS9EEZt/irMno07Xg043ZSdKd5JJHxi3+ziyr2y/w1BAEoP6
 StYtqT5sFSxnQV5T0rg/pyW4Ax5esfbiM+7XIDEwtfWX3IX4FOerQiMG/9kzQSFuk4+ycWeOM1m
 rLuDxAwTs9/W00MCtSvsH471y3dkkbS1n1Qtdwtb1cahsk3crz62DjZaCyjh12TgjKsFhsfIrvF
 fddlK55RIIxJ+Tcybr7chtnDDe6NXV0s/0k8LxY0RDgrRCPN+48P0yGRjpa8axYpy+VI3x39dxK
 o+Xc3yadFw==
X-Received: by 2002:a05:600c:3b25:b0:493:f783:c46a with SMTP id
 5b1f17b1804b1-49b91a67d36mr55127755e9.6.1787906404597; 
 Fri, 28 Aug 2026 01:40:04 -0700 (PDT)
Received: from macbook.homenet.telecomitalia.it
 (host-212-171-227-71.pool212171.interbusiness.it. [212.171.227.71])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49b9500c80asm34428435e9.9.2026.08.28.01.40.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 01:40:04 -0700 (PDT)
From: Carlo Caione <ccaione@baylibre.com>
Date: Fri, 28 Aug 2026 10:39:57 +0200
Subject: [PATCH 2/3] arm: mediatek: add RITY devicetree compatibility commands
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260828-ccaione-upstream-mtk-fdt-prepare-v1-2-bf80b489eb0f@baylibre.com>
References: <20260828-ccaione-upstream-mtk-fdt-prepare-v1-0-bf80b489eb0f@baylibre.com>
In-Reply-To: <20260828-ccaione-upstream-mtk-fdt-prepare-v1-0-bf80b489eb0f@baylibre.com>
To: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, Johan Jonker <jbx6244@gmail.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Chris-QJ Chen <chris-qj.chen@mediatek.com>, 
 =?utf-8?q?Pablo_Sun_=28=E5=AD=AB=E6=AF=93=E7=BF=94=29?=
 <pablo.sun@mediatek.com>, Carlo Caione <ccaione@baylibre.com>
X-Mailer: b4 0.16.0
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
Errors-To: u-boot-bounces@lists.u-boot-project.org

RITY boot environments invoke dtbprobe before EFI boot, or fdtprobe when
devicetree authentication is enabled. These command names and their
positional arguments form part of the RITY image interface.

Register compatibility aliases beside mtk_fdt_prepare and share the common
argument parser and preparation service. Expose only the alias appropriate
to the selected security mode.

Keep the authenticated fdtprobe failure policy: failure to authenticate a
signed DTB or DTBO wrapper is fatal and panics with the established
diagnostic. Other preparation failures return to the caller, and
mtk_fdt_prepare remains recoverable for interactive diagnosis.

Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 arch/arm/mach-mediatek/Kconfig           |  3 ++
 arch/arm/mach-mediatek/cmd_fdt_prepare.c | 47 ++++++++++++++++++++++++++++----
 2 files changed, 44 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-mediatek/Kconfig b/arch/arm/mach-mediatek/Kconfig
index 75fa88a1510..aedc5992965 100644
--- a/arch/arm/mach-mediatek/Kconfig
+++ b/arch/arm/mach-mediatek/Kconfig
@@ -240,6 +240,9 @@ config CMD_MTK_FDT_PREPARE
 	  environment. It also accepts the interface, device and path arguments
 	  explicitly.
 
+	  Also provide the RITY-compatible dtbprobe command, or fdtprobe
+	  when devicetree authentication is enabled.
+
 config MTK_FDT_AUTH
 	bool "Authenticate MediaTek RITY devicetrees"
 	depends on MTK_FDT_PREPARE && FIT_SIGNATURE
diff --git a/arch/arm/mach-mediatek/cmd_fdt_prepare.c b/arch/arm/mach-mediatek/cmd_fdt_prepare.c
index 91d56f747ef..5184aa851a7 100644
--- a/arch/arm/mach-mediatek/cmd_fdt_prepare.c
+++ b/arch/arm/mach-mediatek/cmd_fdt_prepare.c
@@ -4,21 +4,32 @@
  */
 
 #include <command.h>
+#include <vsprintf.h>
+#include <linux/errno.h>
 
 #include "fdt_prepare.h"
 
-static int do_mtk_fdt_prepare(struct cmd_tbl *cmdtp, int flag, int argc,
-			      char *const argv[])
+static int run_mtk_fdt_prepare(int argc, char *const argv[], int *retp)
 {
-	int ret;
-
 	if (argc == 1)
-		ret = mtk_fdt_prepare();
+		*retp = mtk_fdt_prepare();
 	else if (argc == 4)
-		ret = mtk_fdt_prepare_from(argv[1], argv[2], argv[3]);
+		*retp = mtk_fdt_prepare_from(argv[1], argv[2], argv[3]);
 	else
 		return CMD_RET_USAGE;
 
+	return CMD_RET_SUCCESS;
+}
+
+static int do_mtk_fdt_prepare(struct cmd_tbl *cmdtp, int flag, int argc,
+			      char *const argv[])
+{
+	int ret, status;
+
+	status = run_mtk_fdt_prepare(argc, argv, &ret);
+	if (status)
+		return status;
+
 	return ret ? CMD_RET_FAILURE : CMD_RET_SUCCESS;
 }
 
@@ -29,3 +40,27 @@ static int do_mtk_fdt_prepare(struct cmd_tbl *cmdtp, int flag, int argc,
 U_BOOT_CMD(mtk_fdt_prepare, 4, 1, do_mtk_fdt_prepare,
 	   "load and assemble the MediaTek RITY devicetree",
 	   MTK_FDT_PREPARE_USAGE);
+
+#if CONFIG_IS_ENABLED(MTK_FDT_AUTH)
+static int do_mtk_fdt_prepare_auth(struct cmd_tbl *cmdtp, int flag, int argc,
+				   char *const argv[])
+{
+	int ret, status;
+
+	status = run_mtk_fdt_prepare(argc, argv, &ret);
+	if (status)
+		return status;
+	if (ret == -EKEYREJECTED)
+		panic("Invalid dtb/dtbo.");
+
+	return ret ? CMD_RET_FAILURE : CMD_RET_SUCCESS;
+}
+
+U_BOOT_CMD(fdtprobe, 4, 1, do_mtk_fdt_prepare_auth,
+	   "load and assemble an authenticated MediaTek RITY devicetree",
+	   MTK_FDT_PREPARE_USAGE);
+#else
+U_BOOT_CMD(dtbprobe, 4, 1, do_mtk_fdt_prepare,
+	   "load and assemble a MediaTek RITY devicetree",
+	   MTK_FDT_PREPARE_USAGE);
+#endif

-- 
2.55.0


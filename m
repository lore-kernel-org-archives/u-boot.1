Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8FCAC61DD9
	for <u-boot@archiver.kernel.org>; Sun, 30 Aug 2026 10:18:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 47E6760639;
	Sun, 30 Aug 2026 10:18:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DFqMrWE84Y4K; Sun, 30 Aug 2026 10:18:56 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788085136;
	bh=fcbhmLDFNyF4EedyunkC0OODhfm/CZfxzQ0pII7A8Fs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=H8qLzZv6wLfCjWi8ahI03+M5ypOebt4OoZY1EbN7YAjr5JLnuzDIFbH5rhY/NQeuK
	 kJdHoqBhMOCcBHMZF2FN2GAC3Zutb0FGdPhy33UYhINnXBKtHBKheg9RnErjUrJyE2
	 9dmDHp8IZhMIKWWzE0DTM3ooiZXIgAFY3pDiGciQOmNDn20UFs5AGiwN4ITtAZMeAB
	 CMyxiaE/251ES5jZjha0ZE4aMXxre1dKH77X5yxOcEtDnU/P0iR1mfT+eKZLYAYmUk
	 bdJjoxJWBj6CNcWWoYPIWVD1Y35QMqlmYPbAYb5aSSFlv1pMHOPiN937cPr/ITKVq3
	 G4cLS1AQC3jNg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A5B3660613;
	Sun, 30 Aug 2026 10:18:56 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 6772F230
 for <u-boot@lists.u-boot-project.org>; Sun, 30 Aug 2026 10:18:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5938C80E09
 for <u-boot@lists.u-boot-project.org>; Sun, 30 Aug 2026 10:18:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ee1PmT9kCOiQ for <u-boot@lists.u-boot-project.org>;
 Sun, 30 Aug 2026 10:18:51 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42d; helo=mail-wr1-x42d.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=TlvYu99i
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id AC7C380E07
 for <u-boot@lists.u-boot-project.org>; Sun, 30 Aug 2026 10:18:49 +0000 (UTC)
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-47c2b362ee2so2113950f8f.1
 for <u-boot@lists.u-boot-project.org>; Sun, 30 Aug 2026 03:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1788085128; x=1788689928;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fcbhmLDFNyF4EedyunkC0OODhfm/CZfxzQ0pII7A8Fs=;
 b=TlvYu99idzMSnwje38XerpRpfH4BlOszgZGDc0ImnYLrRwkxP6AtkGOOZeAtvhWxTc
 QQTrGAeOdUbc0EgETbGkI8h1k2zpUHpwn3zYNt89uyGtv2vNzv0EaYi0JV/3QybL0V1c
 OwSfizOjMgMYQxo402+Tyg3mrpwx2mCwYrJ51063P4rQW80k5CRfwtEg2Dzg7pEHEQVb
 PV2QS8TMw/sVk5JlFnoFhpT46UXyEPeVJt7F1baj8aziMOA2Mgm0euRlGDRVqq+DFbFj
 AFsNTD6xZn4Lt8OO7+1kX95l2TdKMTtzxhW+R99i8E0zB81uMfYCITrTjnu9xzvEh8FZ
 Ab2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788085128; x=1788689928;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fcbhmLDFNyF4EedyunkC0OODhfm/CZfxzQ0pII7A8Fs=;
 b=JmNTU/m60lX3ymJDYWnthKxVF3hiuJJJpSPE8k8zXxDHZK7dLQxhrBO9xPOj83QLPn
 ujgtkb5+SQZRC52POZ6d/9hZZUVYuz25TQlN4eX/AvYloQtYb3PT8el4g6AdRzV9kYx8
 1bAaUH1otcrWdj9I1Sr+kTlbgdpQKJ0Jp8t3CqSneqr7zc0EzBCz7yCFNJd7SBepUWc3
 cYG2vChkHv+LW8mJN/bpE7dROJ0bgDMRTduR2bU8jtqbN3+zwJJZ6KML2yA/qHUCh7O2
 2parRepxCasOeafFZgDtN97exQjNmnQv75gimVa+NZvq5PIRVP4wfVsUK7n+kUNErg6k
 1fkA==
X-Forwarded-Encrypted: i=1;
 AKwUvBy5rW/2luyR1T6jhcm9GRVzeodeiqiE0BUogNlPCm0JZEXv+naCyDfM+udwmNRIZtd6h/gIvWA=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++nd3AdWBdvw2ErhzNc4BgpqhUs0Beh88vfqlCKP1FUqx67jUOt8
 xeWv0/C1uaL0UkvGFXfbbaFdW+DDxeMXBHp7ggqZx65mQID4pudxBrPgZd3hZtL7hsU=
X-Gm-Gg: AYBFou2+u39bSBWL69TZd+6AWux5FurpG4pq26Xz7HCUSRBWo7lyCykJzK+hsrtQjWm
 0p/wUqlEqFYAxCaGzc9gjAqHdSGLgBwiRS4Ba/2WlKqAnw/nMSZ8I860w5EmR8QsoSjHjdrcLZ4
 AR2qX6JfEGGALCnT8rCQfs+HyzZx/JmS1L1iIZ6dyOS9FS4C5Y5Wlrd8u6DqMJ+9qvazHcX7kPE
 ZiEIA+XRNRKTLbjnoLSoU+DvFtsdLlvu/H7M5qp+cfUvEfbtV+XEMKDLX54JjG3oPV5/8ulYYQ8
 uPs2pZvWiHEACK/z+O2ZRGciue25eVs+GsXQy3j4JIGyzl93fX9I4Khik7VyoG+lQGuW3jjjuK4
 lQ9I3uNc30eQYhTMzvEWuJ8P+2qUVftGCJw8veaBQQBuASE3tSVnKfn+qC93l4md6vocLiSQN12
 6bIDldMC6VNhjvDpdHsibOlnn/TxaWCqlf0Habj4awLEc2daF6/AydGPvIPSQSeEuzqKW9WRcWJ
 bW232TyKdtKhTohaMdjlClRKKAyrcHz1cwz+frd+aVaDlhZO1m3xQwI0Thdo5LSWK5zDQYsmhEX
 4xA2
X-Received: by 2002:a05:6000:2403:b0:484:3310:f394 with SMTP id
 ffacd0b85a97d-4843310f432mr10196575f8f.23.1788085127937; 
 Sun, 30 Aug 2026 03:18:47 -0700 (PDT)
Received: from macbook.homenet.telecomitalia.it
 (host-95-232-147-181.retail.telecomitalia.it. [95.232.147.181])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482fbab3fcesm14644619f8f.5.2026.08.30.03.18.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 30 Aug 2026 03:18:47 -0700 (PDT)
From: Carlo Caione <ccaione@baylibre.com>
Date: Sun, 30 Aug 2026 12:18:40 +0200
Subject: [PATCH v2 2/3] arm: mediatek: add RITY devicetree compatibility
 commands
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260830-ccaione-upstream-mtk-fdt-prepare-v2-2-f9cfce2ed42a@baylibre.com>
References: <20260830-ccaione-upstream-mtk-fdt-prepare-v2-0-f9cfce2ed42a@baylibre.com>
In-Reply-To: <20260830-ccaione-upstream-mtk-fdt-prepare-v2-0-f9cfce2ed42a@baylibre.com>
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
 <pablo.sun@mediatek.com>, 
 Carlo Caione <ccaione@baylibre.com>, Simon Glass <sjg@chromium.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Peter Robinson <pbrobinson@gmail.com>, Vincent Jardin <vjardin@free.fr>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 =?utf-8?q?Ramax_Lo_=28=E7=BE=85=E6=98=8E=E9=81=A0=29?= <Ramax.Lo@mediatek.com>,
 =?utf-8?q?Chris-qj_Chen_=28=E9=99=B3=E5=A5=87=E9=80=B2=29?=
 <Chris-qj.Chen@mediatek.com>
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

Register compatibility aliases beside mtk_fdt_prepare in cmd/mediatek and
share the common argument parser and preparation service. Expose only the
alias appropriate to the selected security mode.

Keep the authenticated fdtprobe failure policy: failure to authenticate a
signed DTB or DTBO wrapper is fatal and panics with the established
diagnostic. Other preparation failures return to the caller, and
mtk_fdt_prepare remains recoverable for interactive diagnosis.

Document both aliases, their shared syntax and the authentication-failure
behavior.

Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 cmd/mediatek/Kconfig              |  4 ++++
 cmd/mediatek/fdt_prepare.c        | 47 ++++++++++++++++++++++++++++++++++-----
 doc/usage/cmd/mtk_fdt_prepare.rst | 11 +++++++++
 3 files changed, 56 insertions(+), 6 deletions(-)

diff --git a/cmd/mediatek/Kconfig b/cmd/mediatek/Kconfig
index 777b9778e1f..31fa6e8d528 100644
--- a/cmd/mediatek/Kconfig
+++ b/cmd/mediatek/Kconfig
@@ -17,4 +17,8 @@ config CMD_MTK_FDT_PREPARE
 	  arguments the command uses storage, storage_dev and dtb_path from the
 	  environment. It also accepts the interface, device and path arguments
 	  explicitly.
+
+	  Also provide the RITY-compatible dtbprobe command, or fdtprobe
+	  when devicetree authentication is enabled.
+
 endif
diff --git a/cmd/mediatek/fdt_prepare.c b/cmd/mediatek/fdt_prepare.c
index a861fe8804e..482deb0d581 100644
--- a/cmd/mediatek/fdt_prepare.c
+++ b/cmd/mediatek/fdt_prepare.c
@@ -4,20 +4,31 @@
  */
 
 #include <command.h>
+#include <vsprintf.h>
 #include <asm/arch-mediatek/fdt_prepare.h>
+#include <linux/errno.h>
 
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
 
@@ -28,3 +39,27 @@ static int do_mtk_fdt_prepare(struct cmd_tbl *cmdtp, int flag, int argc,
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
diff --git a/doc/usage/cmd/mtk_fdt_prepare.rst b/doc/usage/cmd/mtk_fdt_prepare.rst
index aa10516c2b1..35b505a068a 100644
--- a/doc/usage/cmd/mtk_fdt_prepare.rst
+++ b/doc/usage/cmd/mtk_fdt_prepare.rst
@@ -3,6 +3,8 @@
 
 .. index::
    single: mtk_fdt_prepare (command)
+   single: dtbprobe (command)
+   single: fdtprobe (command)
 
 mtk_fdt_prepare command
 =======================
@@ -72,6 +74,15 @@ default image contains the flat devicetree payload. The command loads the FIT
 at ``fw_fdt_wrapper_addr_r``, verifies the selected image and extracts it
 before assembly.
 
+Compatibility commands
+----------------------
+
+RITY environments use the same positional arguments with compatibility
+command names. Without ``CONFIG_MTK_FDT_AUTH``, ``dtbprobe`` is an alias for
+``mtk_fdt_prepare``. With authentication enabled, ``fdtprobe`` provides the
+same interface and panics if a DTB or DTBO fails authentication. Other errors
+are returned to the caller.
+
 Configuration
 -------------
 

-- 
2.55.0


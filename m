Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9007CD8C8E
	for <u-boot@archiver.kernel.org>; Sat,  6 Jun 2026 08:48:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 018BA84987;
	Sat,  6 Jun 2026 10:48:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="dZtZ6FTP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3ECE584940; Sat,  6 Jun 2026 10:48:02 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 03DF884948
 for <u-boot@lists.denx.de>; Sat,  6 Jun 2026 10:47:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+me.samcday.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id E673C445C7;
 Sat,  6 Jun 2026 08:47:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C198EC2BCC6;
 Sat,  6 Jun 2026 08:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1780735670;
 bh=6JJBPlMFup7dpeSbbmcYNkzZFnXR1fI12Nt5LGz9MCQ=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=dZtZ6FTPfDjGYA75/dQwAQz3Cgcr1G8kcSPimLGLcqluVJrOWIiUIBb1Lyg3BhmCs
 rU6m2DR4LitAWzoOKXC7a7pjbrq23ayyBWH9kzOrspxtdeo5lfx5XdroyLeMsNeep8
 Aa2i+G0JeTjq+mW8jZRjy3NxgHs49D4H5UDmEL3s7YSrmbMLNuioovtvKETHAwk4fd
 RkFQfOQJ/wRJcgIsKpSAdt3lg8o7PrciSrUEmRG0YzJe6UAVbV6IzxoYLG+7AitMuY
 87gvtav4wAp4ohBU4hHaHkgm7rKoCc2SBrMka+CKwAT0gFJXEZmUVMb0fjiDxBvp1z
 Hx7fitwqtq2nw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id AAB2CCD8C85;
 Sat,  6 Jun 2026 08:47:50 +0000 (UTC)
From: Sam Day via B4 Relay <devnull+me.samcday.com@kernel.org>
Date: Sat, 06 Jun 2026 18:47:32 +1000
Subject: [PATCH 01/11] button: qcom-pmic: introduce exported setup method
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260606-pm8916-pon-v1-1-170c9cbe5099@samcday.com>
References: <20260606-pm8916-pon-v1-0-170c9cbe5099@samcday.com>
In-Reply-To: <20260606-pm8916-pon-v1-0-170c9cbe5099@samcday.com>
To: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>, 
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, 
 Casey Connolly <casey.connolly@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Leo Yu-Chi Liang <ycliang@andestech.com>, Anshul Dalal <anshuld@ti.com>, 
 Kever Yang <kever.yang@rock-chips.com>, 
 Neha Malcom Francis <n-francis@ti.com>, 
 Justin Klaassen <justin@tidylabs.net>, 
 Jamie Gibbons <jamie.gibbons@microchip.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Luca Weiss <luca.weiss@fairphone.com>, 
 Mateus Lima Alves <mateuslima.ti@gmail.com>, 
 Sughosh Ganu <sughosh.ganu@arm.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 George Chan <gchan9527@gmail.com>, 
 Antony Kurniawan Soemardi <linux@smankusors.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Peter Robinson <pbrobinson@gmail.com>, 
 Ariel D'Alessandro <ariel.dalessandro@collabora.com>, 
 Dmitrii Merkurev <dimorinny@google.com>, Sam Day <me@samcday.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780735669; l=2256;
 i=me@samcday.com; s=20240502; h=from:subject:message-id;
 bh=oTF4eBQpgeurSjGv0sN01MsXdq3y55kE5LVS7G1ONMw=;
 b=JrFh35c8rOLG6/VBROQi+EqmMPeDVSDSc0Ba6wjxWWaiIdtcfypmHpEWqHw5A6ynBOu62JS/t
 pW4mwq4kGr2D5F+SMmizY3LF43JuSoJS0tRNIuocvAwTwsclsoX41bu
X-Developer-Key: i=me@samcday.com; a=ed25519;
 pk=bzyS0akxWMqr9+AXzgBRIp28KKpEOs+GjYMc2yf+aeU=
X-Endpoint-Received: by B4 Relay for me@samcday.com/20240502 with auth_id=595
X-Original-From: Sam Day <me@samcday.com>
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
Reply-To: me@samcday.com
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

From: Sam Day <me@samcday.com>

The qcom_pwrkey driver is currently binding to both the individual
pwrkey/resin nodes, as well as the parent pon node.

In the next commit, a new glue driver will be introduced for pm8916_pon,
which will continue binding these buttons, as well as additional
drivers.

button_qcom_pmic_bind was renamed to button_qcom_pmic_setup and exported
in a shared header, which the new pm8916_pon driver will call.

Signed-off-by: Sam Day <me@samcday.com>
---
 drivers/button/button-qcom-pmic.c |  6 +++---
 include/button/qcom-pmic.h        | 17 +++++++++++++++++
 2 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/button/button-qcom-pmic.c b/drivers/button/button-qcom-pmic.c
index b823490d6d5..d9ac6a51df5 100644
--- a/drivers/button/button-qcom-pmic.c
+++ b/drivers/button/button-qcom-pmic.c
@@ -13,9 +13,9 @@
 #include <dm/lists.h>
 #include <log.h>
 #include <power/pmic.h>
-#include <spmi/spmi.h>
 #include <linux/bitops.h>
 #include <time.h>
+#include "button/qcom-pmic.h"
 
 #define REG_TYPE		0x4
 #define REG_SUBTYPE		0x5
@@ -174,7 +174,7 @@ static int qcom_pwrkey_probe(struct udevice *dev)
 	return 0;
 }
 
-static int button_qcom_pmic_bind(struct udevice *parent)
+int button_qcom_pmic_setup(struct udevice *parent)
 {
 	struct udevice *dev;
 	ofnode node;
@@ -227,7 +227,7 @@ U_BOOT_DRIVER(qcom_pwrkey) = {
 	.name = "qcom_pwrkey",
 	.id = UCLASS_BUTTON,
 	.of_match = qcom_pwrkey_ids,
-	.bind = button_qcom_pmic_bind,
+	.bind = button_qcom_pmic_setup,
 	.probe = qcom_pwrkey_probe,
 	.ops = &button_qcom_pmic_ops,
 	.priv_auto = sizeof(struct qcom_pmic_btn_priv),
diff --git a/include/button/qcom-pmic.h b/include/button/qcom-pmic.h
new file mode 100644
index 00000000000..d321bbab460
--- /dev/null
+++ b/include/button/qcom-pmic.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+
+#include <dm/device.h>
+#include <linux/errno.h>
+
+#if CONFIG_IS_ENABLED(BUTTON_QCOM_PMIC)
+/**
+ * Binds the qcom_pwrkey driver to compatible pwrkey/resin child nodes
+ * belonging to @parent
+ */
+int button_qcom_pmic_setup(struct udevice *parent);
+#else
+static int button_qcom_pmic_setup(struct udevice *parent)
+{
+	return -ENOSYS;
+}
+#endif

-- 
2.54.0



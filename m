Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4743AF364CD
	for <u-boot@archiver.kernel.org>; Sat, 11 Apr 2026 07:12:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3183984255;
	Sat, 11 Apr 2026 09:09:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=seznam.cz
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=seznam.cz header.i=@seznam.cz header.b="mOk7uOzC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1269684118; Sat, 11 Apr 2026 02:04:16 +0200 (CEST)
Received: from mxd-2-a16.seznam.cz (mxd-2-a16.seznam.cz
 [IPv6:2a02:598:64:8a00::1000:a16])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 72EE084099
 for <u-boot@lists.denx.de>; Sat, 11 Apr 2026 02:04:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=seznam.cz
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael.srba@seznam.cz
Received: from email.seznam.cz by smtpc-mxd-7644845457-sbn6w
 (smtpc-mxd-7644845457-sbn6w [2a02:598:64:8a00::1000:a16])
 id 5ee64eb705e81ade5f4f82e9; Sat, 11 Apr 2026 02:03:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seznam.cz; s=szn1;
 t=1775865820; bh=s2nWCNAqzqMnhfWnKCObMbfXatl2EZK1a5sWJdvQiIE=;
 h=From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:To:Cc;
 b=mOk7uOzCV4yBseuu7W5CLXmtoDX1PEaDCvXuyNTLmIuXu60cts17yYyftYoi8cgRq
 c1rqqbRzlgWJYL3CiWFdLn+6BMG+YmgxJbVbdGniI6BRALaqkw+X7/jlLDrzApBQEr
 If5uVEzpquNoGjjYJaM9wekKxhEmJdRVjjKAOWimljMtROafmxL/bZmiQlKMcq/m0c
 LecAzIDdN/CslaK3jSIIV2CTZnJm6ia8wFyzmMGPoWYAR+/rRALY6jtJ3AcOItj5+V
 VBvLjrCrab8IvDT/H0hiVkHJplEo1BViKJsFuwtdFyj0Y6y0okBiotJHmomZrxaBsw
 7vQF6qn7oET1w==
Received: from [127.0.0.1] (ip-111-27.static.ccinternet.cz [147.161.27.111])
 by smtpd-relay-6597cc8696-xddnz (szn-email-smtpd/2.0.72) with ESMTPA
 id 7693eb5f-b9a6-4c27-a032-bf67f49d6e98;
 Sat, 11 Apr 2026 02:03:00 +0200
From: michael.srba@seznam.cz
Date: Sat, 11 Apr 2026 02:00:07 +0200
Subject: [PATCH v2 02/10] of_live: support in SPL
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260411-qcom_spl-v2-2-9609557cf562@seznam.cz>
References: <20260411-qcom_spl-v2-0-9609557cf562@seznam.cz>
In-Reply-To: <20260411-qcom_spl-v2-0-9609557cf562@seznam.cz>
To: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>, 
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@arm.com>, 
 Anshul Dalal <anshuld@ti.com>, Peng Fan <peng.fan@nxp.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Andrew Davis <afd@ti.com>, 
 Hrushikesh Salunke <h-salunke@ti.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, Ye Li <ye.li@nxp.com>, 
 Andre Przywara <andre.przywara@arm.com>, 
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>, 
 Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, Dhruva Gole <d-gole@ti.com>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Heiko Schocher <hs@nabladev.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Lukasz Majewski <lukma@denx.de>, 
 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Michal Simek <michal.simek@amd.com>, Yao Zi <me@ziyao.cc>, 
 Peter Korsgaard <peter@korsgaard.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Tingting Meng <tingting.meng@altera.com>, 
 Tien Fong Chee <tien.fong.chee@altera.com>, Alice Guo <alice.guo@nxp.com>, 
 George Chan <gchan9527@gmail.com>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Alexey Charkov <alchark@gmail.com>, Ronald Wahl <ronald.wahl@legrand.com>, 
 Michael Srba <Michael.Srba@seznam.cz>
X-Mailer: b4 0.15.1
X-Mailman-Approved-At: Sat, 11 Apr 2026 09:08:55 +0200
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

From: Michael Srba <Michael.Srba@seznam.cz>

Add CONFIG_SPL_OF_LIVE and if set, initialize of_live in spl.c

Signed-off-by: Michael Srba <Michael.Srba@seznam.cz>
---
 common/spl/spl.c | 11 +++++++++++
 dts/Kconfig      |  6 ++++++
 lib/Makefile     |  2 +-
 3 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/common/spl/spl.c b/common/spl/spl.c
index 8256fa97862..179694a38cd 100644
--- a/common/spl/spl.c
+++ b/common/spl/spl.c
@@ -17,6 +17,7 @@
 #include <irq_func.h>
 #include <log.h>
 #include <mapmem.h>
+#include <of_live.h>
 #include <serial.h>
 #include <spl.h>
 #include <spl_load.h>
@@ -510,6 +511,16 @@ static int spl_common_init(bool setup_malloc)
 			return ret;
 		}
 	}
+	if (CONFIG_IS_ENABLED(OF_LIVE)) {
+		int ret;
+
+		bootstage_start(BOOTSTAGE_ID_ACCUM_OF_LIVE, "of_live");
+		ret = of_live_build(gd->fdt_blob,
+				    (struct device_node **)gd_of_root_ptr());
+		bootstage_accum(BOOTSTAGE_ID_ACCUM_OF_LIVE);
+		if (ret)
+			return ret;
+	}
 	if (CONFIG_IS_ENABLED(DM)) {
 		bootstage_start(BOOTSTAGE_ID_ACCUM_DM_SPL,
 				xpl_phase() == PHASE_TPL ? "dm tpl" : "dm_spl");
diff --git a/dts/Kconfig b/dts/Kconfig
index af8d30b45ab..b30bc5db5d1 100644
--- a/dts/Kconfig
+++ b/dts/Kconfig
@@ -86,6 +86,12 @@ config OF_LIVE
 	  enables a live tree which is available after relocation,
 	  and can be adjusted as needed.
 
+config SPL_OF_LIVE
+	bool "Enable use of a live tree in SPL"
+	depends on SPL_DM && SPL_OF_CONTROL
+	help
+	  This option enables a live tree in SPL.
+
 config OF_UPSTREAM
 	bool "Enable use of devicetree imported from Linux kernel release"
 	depends on !COMPILE_TEST
diff --git a/lib/Makefile b/lib/Makefile
index d0ffabc2b47..bbd540e9687 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -13,7 +13,6 @@ obj-$(CONFIG_FWU_MULTI_BANK_UPDATE) += fwu_updates/
 obj-$(CONFIG_LZMA) += lzma/
 obj-$(CONFIG_BZIP2) += bzip2/
 obj-$(CONFIG_FIT) += libfdt/
-obj-$(CONFIG_OF_LIVE) += of_live.o
 obj-$(CONFIG_CMD_DHRYSTONE) += dhry/
 obj-$(CONFIG_ARCH_AT91) += at91/
 obj-$(CONFIG_OPTEE_LIB) += optee/
@@ -55,6 +54,7 @@ obj-$(CONFIG_BITREVERSE) += bitrev.o
 obj-y += list_sort.o
 endif
 
+obj-$(CONFIG_$(PHASE_)OF_LIVE) += of_live.o
 obj-$(CONFIG_$(PHASE_)TPM) += tpm-common.o
 ifeq ($(CONFIG_$(PHASE_)TPM),y)
 obj-$(CONFIG_TPM) += tpm_api.o

-- 
2.53.0


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F17B3CD342F
	for <u-boot@archiver.kernel.org>; Fri,  8 May 2026 04:08:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 58EFC84BBD;
	Fri,  8 May 2026 06:08:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=seznam.cz
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=seznam.cz header.i=@seznam.cz header.b="y7JchV/o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F2BAC84C06; Fri,  8 May 2026 02:34:34 +0200 (CEST)
Received: from mxd-3-701.seznam.cz (mxd-3-701.seznam.cz
 [IPv6:2a02:598:96:8a00::1200:701])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF67684B92
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 02:34:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=seznam.cz
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael.srba@seznam.cz
Received: from email.seznam.cz by smtpc-mxd-5f4d8d5f6f-gj4cr
 (smtpc-mxd-5f4d8d5f6f-gj4cr [2a02:598:96:8a00::1200:701])
 id 57ba01460cb4552f5613cd18; Fri, 08 May 2026 02:33:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seznam.cz; s=szn1;
 t=1778200432; bh=SwGdq8aw6PlZ+WsOZmBdvDo8PBGK8bN+LN456aseK7I=;
 h=From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:To:Cc;
 b=y7JchV/o3sGzz3QTEC1o3EKB9cN6fXoq2e9XHQl57ujy6oQ9T1yw5f0VwoHsNA0m9
 3mKIwegXX9DfIoWSOlfMt3qvtG2g19WGkr/YMRcu1SRWI1WaqUrYXAGjAUvcvHdpiC
 lwFMXti1bUX7vwkFKUtM/t38hQ+KSrqEtPCKUMaj+5U2NDjscrEu0uuYEi3LPUZ4ff
 6i0/AsEgB/V/KIz3qZ+cwdjqDYqIzjq6T230lS8Sl5mNyy70fFKbkQfI3XB4eFTr7j
 E6CcxgGDTmLHV7Jq+CoY27VwVmvp+1Y18C3+qUsJ3sWECC1ik9eyYa+HryA0xfjqbH
 8Fhjc83VmPcDQ==
Received: from [127.0.0.1] (ip-111-27.static.ccinternet.cz [147.161.27.111])
 by smtpd-relay-6597cc8696-xddnz (szn-email-smtpd/2.0.72) with ESMTPA
 id 278e1cfb-60b5-4366-b379-8b25f9b08dbf;
 Fri, 08 May 2026 02:33:37 +0200
From: michael.srba@seznam.cz
Date: Fri, 08 May 2026 02:33:24 +0200
Subject: [PATCH v6 02/11] of_live: support in SPL
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260508-qcom_spl-v6-2-aaac1ab17b50@seznam.cz>
References: <20260508-qcom_spl-v6-0-aaac1ab17b50@seznam.cz>
In-Reply-To: <20260508-qcom_spl-v6-0-aaac1ab17b50@seznam.cz>
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
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Michael Srba <Michael.Srba@seznam.cz>
X-Mailer: b4 0.15.1
X-Mailman-Approved-At: Fri, 08 May 2026 06:08:16 +0200
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
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 common/spl/spl.c | 9 +++++++++
 dts/Kconfig      | 8 ++++++++
 lib/Makefile     | 2 +-
 3 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/common/spl/spl.c b/common/spl/spl.c
index 722b18c98ed..6c9a1a1cbcc 100644
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
@@ -510,6 +511,14 @@ static int spl_common_init(bool setup_malloc)
 			return ret;
 		}
 	}
+	if (CONFIG_IS_ENABLED(OF_LIVE)) {
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
index 6b501c2239e..20b5834b8fa 100644
--- a/dts/Kconfig
+++ b/dts/Kconfig
@@ -86,6 +86,14 @@ config OF_LIVE
 	  enables a live tree which is available after relocation,
 	  and can be adjusted as needed.
 
+config SPL_OF_LIVE
+	bool "Enable use of a live tree in SPL"
+	depends on SPL_DM && SPL_OF_CONTROL
+	help
+	  This option enables a live tree in SPL, allowing the sharing
+	  of OF fixup code between U-Boot proper and SPL.
+	  See also OF_LIVE.
+
 config OF_UPSTREAM
 	bool "Enable use of devicetree imported from Linux kernel release"
 	depends on !COMPILE_TEST && !SANDBOX
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


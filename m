Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 432C6F94CA9
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 20:08:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4816284337;
	Tue, 21 Apr 2026 22:07:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=seznam.cz
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=seznam.cz header.i=@seznam.cz header.b="fQMCBND+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0392983FFA; Tue, 21 Apr 2026 21:45:10 +0200 (CEST)
Received: from mxd-1-a09.seznam.cz (mxd-1-a09.seznam.cz
 [IPv6:2a02:598:128:8a00::1000:a09])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 09B0083BC4
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 21:45:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=seznam.cz
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael.srba@seznam.cz
Received: from email.seznam.cz by smtpc-mxd-fd5c5cd95-bfmjc
 (smtpc-mxd-fd5c5cd95-bfmjc [2a02:598:128:8a00::1000:a09])
 id 230781d77809d5be22ae4d89; Tue, 21 Apr 2026 21:44:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seznam.cz; s=szn1;
 t=1776800661; bh=1en3rM7TNB8TmtiyKMvGuK2JZoWRfOuH94hBYEXzpgk=;
 h=From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:To:Cc;
 b=fQMCBND+Cu4oDd9cib0CNo1sCaKAVfUbbRxB51Ad1js8A++C3mrfswkCAe+4UXiUW
 4cmmbGXeGGpQIOJYc7UzNQbjRQA0oKCgmT+uZlkX1L88A0+IwW0464qVEfoh82Zd+O
 UKIxCCrJFdTZJsOCcZcxBVv1VNkghPxcjXq2VF9f3q8W7PRFgkheQ4WU5SQWKydiT2
 f3h9+5/pW0syzl5a4dRvmaVxRaJUf4gUxH11fUM/G93Gi7HhcSXp2FvS9WpNDXJes+
 No9AvILzA8rN1LRu4N6pd2Bgjp1Q8s/s7hwzsmh4nrsIXMGAPooTPtZyBI3PjSh+6e
 1XuTzVGcTUh9Q==
Received: from [127.0.0.1] (ip-111-27.static.ccinternet.cz [147.161.27.111])
 by smtpd-relay-7c7c659656-cskk5 (szn-email-smtpd/2.0.72) with ESMTPA
 id a5005564-c3e1-401a-b151-c3a77dcd955c;
 Tue, 21 Apr 2026 21:44:05 +0200
From: michael.srba@seznam.cz
Date: Tue, 21 Apr 2026 21:43:45 +0200
Subject: [PATCH v3 02/11] of_live: support in SPL
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260421-qcom_spl-v3-2-efee3f76754d@seznam.cz>
References: <20260421-qcom_spl-v3-0-efee3f76754d@seznam.cz>
In-Reply-To: <20260421-qcom_spl-v3-0-efee3f76754d@seznam.cz>
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
X-Mailman-Approved-At: Tue, 21 Apr 2026 22:07:20 +0200
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
index 8256fa97862..13559baf059 100644
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
index af8d30b45ab..aeb1014253a 100644
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


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 239E0CD3436
	for <u-boot@archiver.kernel.org>; Fri,  8 May 2026 04:08:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B78A84C06;
	Fri,  8 May 2026 06:08:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=seznam.cz
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=seznam.cz header.i=@seznam.cz header.b="p7LDj+vt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2ED0F84B42; Fri,  8 May 2026 02:34:37 +0200 (CEST)
Received: from mxd-1-a0f.seznam.cz (mxd-1-a0f.seznam.cz
 [IPv6:2a02:598:128:8a00::1000:a0f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E592A84BC7
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 02:34:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=seznam.cz
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael.srba@seznam.cz
Received: from email.seznam.cz by smtpc-mxd-5f4d8d5f6f-lmwqj
 (smtpc-mxd-5f4d8d5f6f-lmwqj [2a02:598:128:8a00::1000:a0f])
 id 45fc99ae1ef2cdc7445555f0; Fri, 08 May 2026 02:33:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seznam.cz; s=szn1;
 t=1778200425; bh=trEpWKqY8oPcclt1AJm23G60J57XnGZiRDwNSWc+Zec=;
 h=From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:To:Cc;
 b=p7LDj+vtGOe3T4gLZOvzConqwfM0qLsq063sRrntJyotFVFdd9G38aY+41hS/7A7P
 ErH44+Rlg8IaZGHYKKt+7Ep1UTriIm9OB9cqQGgiaWRmKk3DTwrQni+w5Vi4k1TbLH
 weJaJyXq+EmTyE3hkhLXEs441PS/uybxR82BpjbxtSeat7VwEcnH9/AbOrshejTzrR
 6XAiCMMmkNJQrPBtF3wnYD0KGGV8/jK4asOR1saXZ7K03q1EXfjzMaCC0wz+oAVlvd
 2RyJbzhh23FYOCPGnGDxxUWj3LjaFLrJNfQnwAcIIpUvCj2ypD6N7JAVgrwLZ/DX9p
 k7eCyjH7UBRuQ==
Received: from [127.0.0.1] (ip-111-27.static.ccinternet.cz [147.161.27.111])
 by smtpd-relay-6597cc8696-xddnz (szn-email-smtpd/2.0.72) with ESMTPA
 id 9a466eca-171d-4fc1-ad8b-596c4794e056;
 Fri, 08 May 2026 02:33:39 +0200
From: michael.srba@seznam.cz
Date: Fri, 08 May 2026 02:33:27 +0200
Subject: [PATCH v6 05/11] mach-snapdragon: add u-boot-spl-elf-sdm845.lds
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260508-qcom_spl-v6-5-aaac1ab17b50@seznam.cz>
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

This custom linker script is required to produce a bootable ELF
for the sdm845 SoC. An xbl_sec.elf must be provided, which will
be put in a section in the ELF as required by the boot rom.

Signed-off-by: Michael Srba <Michael.Srba@seznam.cz>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 arch/arm/mach-snapdragon/u-boot-spl-elf-sdm845.lds | 44 ++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/arch/arm/mach-snapdragon/u-boot-spl-elf-sdm845.lds b/arch/arm/mach-snapdragon/u-boot-spl-elf-sdm845.lds
new file mode 100644
index 00000000000..3740209d499
--- /dev/null
+++ b/arch/arm/mach-snapdragon/u-boot-spl-elf-sdm845.lds
@@ -0,0 +1,44 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+
+/*
+ * The boot rom uses the segment type to identify the xbl_sec program header.
+ * See https://github.com/coreboot/coreboot/blob/643efabd2af9f7ac/util/qualcomm/mbn_tools.py#L143.
+ */
+#define PF_SEGMENT_TYPE_XBL_SEC 5
+
+/*
+ * The boot rom expects this to be equal to a seemingly magic value possibly specific
+ * to a particular xbl_sec.elf. If you're extracting your xbl_sec.elf from an xbl elf,
+ * you can just reuse the value; otherwise you can either compute it yourself or use
+ * coreboot's tool.
+ * See https://github.com/coreboot/coreboot/blob/643efabd2af9f7ac/util/qualcomm/createxbl.py#L638.
+ */
+#define XLB_SEC_SEGMENT_ADDR 0x0000000014699000
+
+
+TARGET("binary")
+INPUT("./xbl_sec.elf")
+
+OUTPUT_FORMAT("default")
+
+ENTRY(CONFIG_PLATFORM_ELFENTRY)
+PHDRS
+{
+	data PT_LOAD FLAGS(7);
+	xbl_sec PT_LOAD FLAGS(5 | (PF_SEGMENT_TYPE_XBL_SEC << 24));
+}
+SECTIONS
+{
+
+	. = XLB_SEC_SEGMENT_ADDR;
+	.xbl_sec : { // XBL_SEC nested ELF
+		. = .;
+		"./xbl_sec.elf"
+	} :xbl_sec
+
+	. = CONFIG_PLATFORM_ELFENTRY;
+
+	.data : {
+		*(.data*)
+	} :data
+}

-- 
2.53.0


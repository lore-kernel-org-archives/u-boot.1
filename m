Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9F88F364CD
	for <u-boot@archiver.kernel.org>; Sat, 11 Apr 2026 07:11:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1CA30842A2;
	Sat, 11 Apr 2026 09:09:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=seznam.cz
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=seznam.cz header.i=@seznam.cz header.b="WmqEvRDH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 07AC184199; Sat, 11 Apr 2026 02:04:11 +0200 (CEST)
Received: from mxd-3-715.seznam.cz (mxd-3-715.seznam.cz
 [IPv6:2a02:598:96:8a00::1200:715])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 65EFD8416F
 for <u-boot@lists.denx.de>; Sat, 11 Apr 2026 02:03:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=seznam.cz
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael.srba@seznam.cz
Received: from email.seznam.cz by smtpc-mxd-7644845457-lgzgl
 (smtpc-mxd-7644845457-lgzgl [2a02:598:96:8a00::1200:715])
 id 23ecccbd78e298d4224500e3; Sat, 11 Apr 2026 02:03:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seznam.cz; s=szn1;
 t=1775865796; bh=/ACGPa6zL8Sb90YIJDHGUmmBBKj5bBWU4xeIH6xizW8=;
 h=From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:To:Cc;
 b=WmqEvRDHGodFdzcebg6kaowDIxto8VIu3rjEJ7WM1IQfYxqmOdvdXyelAMek2RZhp
 Obfz49wxxIMNGJH5rWerkhmJfUVEFk628dKy8Mxv1ej0iadqzA4sDl7MJsvu+4pFQ+
 bSgi7lXVm/N/Ul953Ot1h9VgNLJWpbsvTX8JVqBxiZZ2ggjTm6wPfFq5QA8rvu0wv7
 J1+Jo8OliQ2g4cllBMiyhlPdB1GxlnmfUEJEgq5EzyAgU32IX4JNw2icPHRpoibFl4
 RUvWXbTmgOe/npel7qe/xesqbb4Mu1022/aqLKJOq9mGzXdbZBxaK5w1/ZIDsnqa/l
 o6UiHrvVlRGwg==
Received: from [127.0.0.1] (ip-111-27.static.ccinternet.cz [147.161.27.111])
 by smtpd-relay-6597cc8696-xddnz (szn-email-smtpd/2.0.72) with ESMTPA
 id 8ac3fd86-ff03-456b-a689-fb6e0824757f;
 Sat, 11 Apr 2026 02:03:02 +0200
From: michael.srba@seznam.cz
Date: Sat, 11 Apr 2026 02:00:10 +0200
Subject: [PATCH v2 05/10] mach-snapdragon: add u-boot-spl-elf-sdm845.lds
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260411-qcom_spl-v2-5-9609557cf562@seznam.cz>
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

This custom linker script is required to produce a bootable ELF
for the sdm845 SoC. An xbl_sec.elf must be provided, which will
be put in a section in the ELF as required by the boot rom.

Signed-off-by: Michael Srba <Michael.Srba@seznam.cz>
---
 arch/arm/mach-snapdragon/u-boot-spl-elf-sdm845.lds | 25 ++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm/mach-snapdragon/u-boot-spl-elf-sdm845.lds b/arch/arm/mach-snapdragon/u-boot-spl-elf-sdm845.lds
new file mode 100644
index 00000000000..10912f416cc
--- /dev/null
+++ b/arch/arm/mach-snapdragon/u-boot-spl-elf-sdm845.lds
@@ -0,0 +1,25 @@
+TARGET("binary")
+INPUT("./xbl_sec.elf")
+
+OUTPUT_FORMAT("default")
+
+ENTRY(CONFIG_PLATFORM_ELFENTRY)
+PHDRS
+{
+	data PT_LOAD FLAGS(7);
+	xbl_sec PT_LOAD FLAGS(5 | (0x5 << 24));
+}
+SECTIONS
+{
+	. = 0x0000000014699000;
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


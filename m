Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ED63FF885C
	for <u-boot@archiver.kernel.org>; Sat, 25 Apr 2026 23:47:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0527F84178;
	Sun, 26 Apr 2026 01:47:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=seznam.cz
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=seznam.cz header.i=@seznam.cz header.b="Oat/eN7v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3F11C83FDB; Sun, 26 Apr 2026 01:27:52 +0200 (CEST)
Received: from mxd-3-71c.seznam.cz (mxd-3-71c.seznam.cz
 [IPv6:2a02:598:96:8a00::1200:71c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7481583FF5
 for <u-boot@lists.denx.de>; Sun, 26 Apr 2026 01:27:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=seznam.cz
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael.srba@seznam.cz
Received: from email.seznam.cz by smtpc-mxd-68df9c878f-gdfk6
 (smtpc-mxd-68df9c878f-gdfk6 [2a02:598:96:8a00::1200:71c])
 id 1f63cb72446d9f1b1eca072c; Sun, 26 Apr 2026 01:27:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seznam.cz; s=szn1;
 t=1777159621; bh=Vz1YH3Np7ua0HMOVX3+rgXSu6x6fZqa/ED8vmq0x8rI=;
 h=From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:To:Cc;
 b=Oat/eN7vvx9Y2FQOGqmtzI+5z909Qu0irckAkfmsgg/MUSuO8xYyth6/wEy02g0IJ
 TxMFJP8v8XKrZ4O+8z1F3YVLaEp18aJUk4wBGUQYYtLlkzRHpqrIcG9/rJW2v9PkQy
 BFOhnacl9RWWZDF7+OTpuozz7kT+XW+3VWgoO44e69mJh/I/4hki+B7fp2O2y5T52i
 rnCY7PaBPAKC5/OEO7Xz/cEykzVrvmz3EX+0N7vHDCU/gkb7jRc887/m6hv38TO6Pt
 5vjc/rnMzydUDvtenylfogFK5YTlBL/c1axH4Zw5SBkSLiEtdZcOT+45hHQY1Cz7sd
 mFfiIJ6WguTdA==
Received: from [127.0.0.1] (ip-111-27.static.ccinternet.cz [147.161.27.111])
 by smtpd-relay-7c7c659656-cskk5 (szn-email-smtpd/2.0.72) with ESMTPA
 id 0ec834b8-329f-441d-a5e8-300bb97906fb;
 Sun, 26 Apr 2026 01:26:56 +0200
From: michael.srba@seznam.cz
Date: Sun, 26 Apr 2026 01:26:08 +0200
Subject: [PATCH v4 06/11] mach-snapdragon: Kconfig: fix duplicate
 SYS_MALLOC_LEN
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260426-qcom_spl-v4-6-8cf4133ff883@seznam.cz>
References: <20260426-qcom_spl-v4-0-8cf4133ff883@seznam.cz>
In-Reply-To: <20260426-qcom_spl-v4-0-8cf4133ff883@seznam.cz>
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
X-Mailman-Approved-At: Sun, 26 Apr 2026 01:47:27 +0200
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

Signed-off-by: Michael Srba <Michael.Srba@seznam.cz>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 arch/arm/mach-snapdragon/Kconfig | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm/mach-snapdragon/Kconfig b/arch/arm/mach-snapdragon/Kconfig
index 976c0e35fce..f82cd0d3291 100644
--- a/arch/arm/mach-snapdragon/Kconfig
+++ b/arch/arm/mach-snapdragon/Kconfig
@@ -11,9 +11,6 @@ config SYS_VENDOR
 	  Based on this option board/<CONFIG_SYS_VENDOR>/<CONFIG_SYS_BOARD>
 	  will be used as the custom board directory.
 
-config SYS_MALLOC_LEN
-	default 0x10000000
-
 config SYS_MALLOC_F_LEN
 	default 0x2000
 

-- 
2.53.0


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14B4AC4828F
	for <u-boot@archiver.kernel.org>; Fri,  9 Feb 2024 09:50:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 89F5B87E56;
	Fri,  9 Feb 2024 10:50:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id E9E7187E6F; Fri,  9 Feb 2024 10:50:16 +0100 (CET)
Received: from smtp-190f.mail.infomaniak.ch (smtp-190f.mail.infomaniak.ch
 [185.125.25.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5D9AC87E5F
 for <u-boot@lists.denx.de>; Fri,  9 Feb 2024 10:50:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch
 [10.4.36.108])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4TWTc50XFVzcPL;
 Fri,  9 Feb 2024 10:50:13 +0100 (CET)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4TWTc36QY8zMppKR; Fri,  9 Feb 2024 10:50:11 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Fri, 09 Feb 2024 10:49:57 +0100
Subject: [PATCH v2 01/20] rockchip: avoid out-of-bounds when computing
 cpuid
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240209-jaguar-v2-1-6c9ffe09b924@theobroma-systems.com>
References: <20240209-jaguar-v2-0-6c9ffe09b924@theobroma-systems.com>
In-Reply-To: <20240209-jaguar-v2-0-6c9ffe09b924@theobroma-systems.com>
To: Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Peter Robinson <pbrobinson@gmail.com>, 
 Jagan Teki <jagan@amarulasolutions.com>, 
 Klaus Goger <klaus.goger@theobroma-systems.com>, 
 Heiko Stuebner <heiko.stuebner@cherry.de>, 
 Otavio Salvador <otavio@ossystems.com.br>, 
 Andy Yan <andy.yan@rock-chips.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Anatolij Gustschin <agust@denx.de>
Cc: Dragan Simic <dsimic@manjaro.org>, u-boot@lists.denx.de, 
 Quentin Schulz <quentin.schulz@theobroma-systems.com>, 
 Quentin Schulz <foss+uboot@0leil.net>
X-Mailer: b4 0.12.4
X-Infomaniak-Routing: alpha
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

From: Quentin Schulz <quentin.schulz@theobroma-systems.com>

The expected length of the cpuid, as passed with cpuid_length,
determines the size of cpuid_str string. Therefore, care should be taken
to make sure nothing is accessing data out-of-bounds.

Instead of using hardcoded values, derive them from cpuid_length.

Cc: Quentin Schulz <foss+uboot@0leil.net>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
---
 arch/arm/mach-rockchip/misc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-rockchip/misc.c b/arch/arm/mach-rockchip/misc.c
index 7d03f0c2b67..15397cff009 100644
--- a/arch/arm/mach-rockchip/misc.c
+++ b/arch/arm/mach-rockchip/misc.c
@@ -102,7 +102,7 @@ int rockchip_cpuid_set(const u8 *cpuid, const u32 cpuid_length)
 	int i;
 
 	memset(cpuid_str, 0, sizeof(cpuid_str));
-	for (i = 0; i < 16; i++)
+	for (i = 0; i < cpuid_length; i++)
 		sprintf(&cpuid_str[i * 2], "%02x", cpuid[i]);
 
 	debug("cpuid: %s\n", cpuid_str);
@@ -111,13 +111,13 @@ int rockchip_cpuid_set(const u8 *cpuid, const u32 cpuid_length)
 	 * Mix the cpuid bytes using the same rules as in
 	 *   ${linux}/drivers/soc/rockchip/rockchip-cpuinfo.c
 	 */
-	for (i = 0; i < 8; i++) {
+	for (i = 0; i < cpuid_length / 2; i++) {
 		low[i] = cpuid[1 + (i << 1)];
 		high[i] = cpuid[i << 1];
 	}
 
-	serialno = crc32_no_comp(0, low, 8);
-	serialno |= (u64)crc32_no_comp(serialno, high, 8) << 32;
+	serialno = crc32_no_comp(0, low, cpuid_length / 2);
+	serialno |= (u64)crc32_no_comp(serialno, high, cpuid_length / 2) << 32;
 	snprintf(serialno_str, sizeof(serialno_str), "%016llx", serialno);
 
 	oldid = env_get("cpuid#");

-- 
2.43.0


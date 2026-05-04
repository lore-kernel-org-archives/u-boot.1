Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13E86CD3427
	for <u-boot@archiver.kernel.org>; Mon,  4 May 2026 18:59:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C15D4846E7;
	Mon,  4 May 2026 20:58:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="pU9Z/o3g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 78D3084694; Mon,  4 May 2026 20:58:04 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A8C408467B
 for <u-boot@lists.denx.de>; Mon,  4 May 2026 20:58:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4891d7164ddso22593175e9.3
 for <u-boot@lists.denx.de>; Mon, 04 May 2026 11:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777921080; x=1778525880; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=/ZulRluJl68KBmeNojtl1EQ8+o8Ec+So3RM0A9vFYyY=;
 b=pU9Z/o3g+RY8Wr1YPpbaHw7x8JI6XkrdV/6jIZ55nmkJIhtZx6nVUo/OVOgqTGFUEQ
 XqZWNA6eUzcsM750t1nT4Qzvv8md0KYEG7OSaqMkHwNDLsnt7EtVVSPASEv+y6eDUB4X
 FRzEejUwfYnf75MLkmrRsllbrD7FstCMay9B0cB3icHhNNFl8apptlAuqMja/sYkfVe2
 WtGDSc+DafCINg9sHDJh2wti1xWnvhxi73tsg6Novz5GyiQ7RQPyMN+/k0magZyTnbrs
 6JRbvtpy8iGwiFhtWr8v+R1gUoMMqVUN+Kw1Odyfun+owL40XaQ3TL6kYoKCEi9ZYlsM
 VOlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777921080; x=1778525880;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=/ZulRluJl68KBmeNojtl1EQ8+o8Ec+So3RM0A9vFYyY=;
 b=ZWef35e/jumYmvQscai9k36O5nxFlwkAMyuyoK2ik/68u1dD1D+wOD/uElGOVmXBn+
 hU9rc0djhbPQBoApzEY8eP/TkYQUJAi5tNI84TwS0b3WnTBihVIL9dobCeViuF2DRwFY
 nKJB8Gx3QtxWygaFXosA15zWUq2xeSRRr5i6YS+BFQf7Khr6oMv8K4dGDey/zqiJtofE
 S3dkUtPA1llBDqPeoI+pVhOmtdSFYLz4S4agmB3do9WoIdg3fjtChDR/x6rFcj6wgI7J
 Vd8RdU/cUaPc538MCJHdf9HE/37a6Tjyz9uSuIXIktOsyRPFZmJ7pbVFRndOJs4XzKQb
 g9zA==
X-Gm-Message-State: AOJu0YydhuF/qSSsnUR/i5aaaAt81+m6RRRYRUmUkhW61SBDg0OGbwxJ
 lu0EKce1zmHZmUrER+QUWggDT9ltsB5q14duGSINHec+iwq7lw4zf02HswAXhmfciXQ=
X-Gm-Gg: AeBDietyzRG2tEfrCSRT8ryYigj5HbsXZ89vdGWr6YLQ7Dl/EC7oVQKg8U/UJzdoPhA
 zwPLg4W091CJixGRz1OcwPv65TK5iDpSe9CbeleFk0kVwM3LfdjMn3w9HkmdV4OgWtSrY3YU/Lu
 SIals6YB3q9jmGriUaEhJRsaSiDLLyhgSBlRWbrF2eBl5hr7/dkM5T+SEh0mI4KpYLOy0bsA+6s
 VEj25nN2VUwtUBZS7AlGlalHNI8UZiuCKTP5yTeJFl1Hcw75Mu2ng1WFYcVqA/HtncfNRfFWtJ3
 eidba0CZww3xnVqyrrOjasWWfWce7HjJMsxwWPYVWmQg3MxKTNqy+2wEhmM9pA8QOS4eEsk8Qe5
 0nt4pbPGrP8amrzcsdqoResacgaGykbmQLp3RjeKHdwy7T9MOhSHapgYQ+CGCZPLEkmsPi2BnRC
 mA5FcnjFXdDlZAZcNZt/HSlT1/YSiSlv0uh8qqhwMdZywgdw8cQTl9CuNLa4Ia8iDhCW/8xsYgb
 Wjuwzw=
X-Received: by 2002:a05:600c:3b86:b0:471:700:f281 with SMTP id
 5b1f17b1804b1-48a988c639cmr199142205e9.25.1777921080021; 
 Mon, 04 May 2026 11:58:00 -0700 (PDT)
Received: from lion.localdomain (p4fc3dd86.dip0.t-ipconnect.de.
 [79.195.221.134]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4500f9c2cd5sm2861f8f.23.2026.05.04.11.57.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2026 11:57:59 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Mon, 04 May 2026 20:57:42 +0200
Subject: [PATCH v2 14/15] mach-snapdragon: fetch serial# from SMEM
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260504-b4-modernise-smem-v2-14-c01ec2ff3886@linaro.org>
References: <20260504-b4-modernise-smem-v2-0-c01ec2ff3886@linaro.org>
In-Reply-To: <20260504-b4-modernise-smem-v2-0-c01ec2ff3886@linaro.org>
To: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>, 
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Casey Connolly <casey.connolly@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Alice Guo <alice.guo@nxp.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Kuan-Wei Chiu <visitorckw@gmail.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, 
 Stefan Roese <stefan.roese@mailbox.org>, 
 Philip Molloy <philip.molloy@analog.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Marek Vasut <marek.vasut@mailbox.org>, 
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Rasmus Villemoes <ravi@prevas.dk>, Heiko Schocher <hs@nabladev.com>, 
 Michal Simek <michal.simek@amd.com>, Sughosh Ganu <sughosh.ganu@arm.com>, 
 Antony Kurniawan Soemardi <linux@smankusors.com>, 
 Luca Weiss <luca.weiss@fairphone.com>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1306;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=kWbuxz1EP92wGmsijki9uWwU4t4xvZaUkWatNrkv1kI=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhswfb+Rvx+z36wgzNot+yPjxtdkj69fcrLMZX/GHGbNp3
 X1rvKmxo5SFQZCDQVZMkUX8xDLLprWX7TW2L7gAM4eVCWQIAxenAExkshfD/wTftAcHTX3vLKiU
 ztorrXZWS1+vN8bsYtb3z7u2PU3yyGH4K5jdfby3nbm7cs615cd4w2o0wuzOPlX0uTZjM3vy0S6
 V4wA=
X-Developer-Key: i=casey.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

If available, otherwise fall back to cmdline.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 arch/arm/mach-snapdragon/board.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
index 7610891191fd..63055a60af44 100644
--- a/arch/arm/mach-snapdragon/board.c
+++ b/arch/arm/mach-snapdragon/board.c
@@ -31,8 +31,9 @@
 #include <fdt_support.h>
 #include <usb.h>
 #include <soc/qcom/smem.h>
 #include <sort.h>
+#include <soc/qcom/smem.h>
 #include <time.h>
 
 #include "qcom-priv.h"
 
@@ -251,11 +252,16 @@ static const char *get_cmdline(void)
 }
 
 void qcom_set_serialno(void)
 {
-	const char *cmdline = get_cmdline();
+	const char *cmdline;
 	char serial[32];
 
+	if (!qcom_socinfo_init())
+		return;
+
+	cmdline = get_cmdline();
+
 	if (!cmdline) {
 		log_debug("Failed to get bootargs\n");
 		return;
 	}
@@ -473,8 +479,11 @@ int board_late_init(void)
 	else
 		memcpy((void *)addr, (void *)gd->fdt_blob,
 		       fdt32_to_cpu(fdt_blob->totalsize));
 
+	/* Initialise SMEM if it wasn't done already and ensure it's memory is mapped */
+	qcom_smem_init();
+
 	configure_env();
 	qcom_late_init();
 
 	qcom_show_boot_context();

-- 
2.53.0


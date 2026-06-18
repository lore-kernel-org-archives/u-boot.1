Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C60CCD98ED
	for <u-boot@archiver.kernel.org>; Thu, 18 Jun 2026 11:59:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F92F84A09;
	Thu, 18 Jun 2026 13:57:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="n2Xs+Wyf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 935688005D; Thu, 18 Jun 2026 13:57:26 +0200 (CEST)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD2588056B
 for <u-boot@lists.denx.de>; Thu, 18 Jun 2026 13:57:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-463f1165e16so686747f8f.0
 for <u-boot@lists.denx.de>; Thu, 18 Jun 2026 04:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781783844; x=1782388644; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=y2MwtdeN4kBgUZOBXCfFvVgDrwStiqshYVRHAo8vWno=;
 b=n2Xs+WyfIwc5GG6LFf+XvdFt2pU0Tyf5wWVp+q2gMEvawvHxgU4Dbs1CpCG8wbb2SO
 eypgw96OvOrWRIrocjyLvrNoiyc81UJnPKtODxR6kBC2dDDxi8KYnDU0uoKc/6XN4Amw
 oqE5V7UBwqvbR4aMO9qwePLi9h2WWnFmnfmTM5iHSQrshjQFg3Wq1Ic7YhujlWk3GdaP
 8RgzUnd7dllWzprc6vXNPsCFqcDHHoDEZ8301ZXoCxP0vB5Ey+wVsc12YUslOKz0pk2J
 oqdfGdbdtq3r8H7ju4Z+X8RwrLnBsT+MtEnKdjD9zpWBSnObJuN+zmkf0xfJ10JtVx99
 emLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781783844; x=1782388644;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=y2MwtdeN4kBgUZOBXCfFvVgDrwStiqshYVRHAo8vWno=;
 b=crHWhCDrXWqjwjFuvFaCWYcCbgOlBKgErmQO5ciN25HB2Hhu5q5h+3a/CUlgUzcO7R
 sg0w56P5PAU2pHuxCu4uirp3sNumBOTEtVupxnJ2I3iG1p/aQo6CWTDWa1vJYLmpknY3
 8HeF8zw1RMZ/KRD903NrKCfT3puHCmdcSLqz+ueNvs/I0GZ62+tQIWaiKdmr6dTcjO8W
 Pn7gEflPCIGYtxUXzVSvUa2FU9mpDyCFKQKCDRFgtDd1wB2rAO3Vy36GSP343VJEwN1t
 +k3VTskt4NwF83disLflJqsty9MFk5kIEaIS+WM20ufQ89xmIP/C7HhkPkgSE4Nu9s+D
 JTrg==
X-Gm-Message-State: AOJu0Yyp46hpAw40jzlFcC29VjB2yQdXwUnCzA4ZcJpzZ5GQ2BGDtJUb
 4mmxzGf4b97LpNvqb67ry1dYp4R+o4zq5I7jlivnxMb2wSwcu95UBD8QJzHQzyb/5CY=
X-Gm-Gg: AfdE7cmLwUxjsC1tsTMzMBc+CnXJQZ4OU5GeRFvmqAji5AycAsXvbqX40DGmYMLrCkY
 04REK8K/K2RsOm9AgEIaiqPzDGBhpel8EN9Ygm1N1Mnw10KCYEDCDd8vtMwGuU1ptbqi7AbCbSp
 M93FJwLg/xiwzw2g6CwC0ZhqbfcsUXQpvt1GAOjVKWBPIBLUXUXEvodj1Rj/4Tv/Wv/Uq8mJgaa
 gdnVOd/lgN7EDjAQ2+3UmrBHO7T4s25nas/3pJCrC4fk1vtqTBnErZwCehc+UtgLLdlJb7PVgaz
 qUqecvY4/oP4ZYi8cROi6rp32xvTFy8ngZegtKftaim0O+wOXo6URXteZzTA3ssBsBUYJWsECgG
 uC12Kjo9WB2KI0bf/eflge0w2IUjhTPMCzs2SgWc4/y1yD1V0NCWL6XTO2vSwgX13gIPJSV7jiX
 wQCC/AHy9DS0czucoAjL9GGVGsTm168W1deo2sm5FJY9zSZhIDcTU6kVmiwqg2E6cHxw==
X-Received: by 2002:a5d:5443:0:b0:460:2477:2284 with SMTP id
 ffacd0b85a97d-4623955c2d9mr11381651f8f.39.1781783844189; 
 Thu, 18 Jun 2026 04:57:24 -0700 (PDT)
Received: from lion.localdomain (p5b29e032.dip0.t-ipconnect.de. [91.41.224.50])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46289c3b3a3sm14448355f8f.30.2026.06.18.04.57.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jun 2026 04:57:23 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Thu, 18 Jun 2026 13:57:02 +0200
Subject: [PATCH v3 14/15] mach-snapdragon: fetch serial# from SMEM
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260618-b4-modernise-smem-v3-14-472391477988@linaro.org>
References: <20260618-b4-modernise-smem-v3-0-472391477988@linaro.org>
In-Reply-To: <20260618-b4-modernise-smem-v3-0-472391477988@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1367;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=K26Rs1uX2gWOY87qO92bapcJkY4Xb3SuedemIjO31cU=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhizju6wbpodU3ojI55/5J2vjalXLi7Hesx1WWhXt9/336
 pjUYVn2jlIWBkEOBlkxRRbxE8ssm9ZettfYvuACzBxWJpAhDFycAjCRHc4Mf7gvup/c9UZ5f5Hz
 FHb+Px+cXruaV6QuO/Hr+e1JVuz/1Bcy/LOb/dz/mX5EZFK1udnWFyEHKlRWulf5C19I+zr39qK
 qfi8A
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

If available, otherwise fall back to cmdline. We call qcom_smem_init()
during board_init() so that it will be functional post-relocation
regardless of if SMEM was used pre-relocation.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 arch/arm/mach-snapdragon/board.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
index b87c12e102e1..4ef046942d82 100644
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
 
@@ -200,8 +201,10 @@ void __weak qcom_board_init(void)
 
 int board_init(void)
 {
 	show_psci_version();
+	/* Initialise SMEM if it wasn't done already and ensure it's memory is mapped */
+	qcom_smem_init();
 	qcom_board_init();
 	return 0;
 }
 
@@ -251,11 +254,16 @@ static const char *get_cmdline(void)
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

-- 
2.53.0


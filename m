Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F68FC54E58
	for <u-boot@archiver.kernel.org>; Mon, 18 Mar 2024 23:16:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A808387BC9;
	Tue, 19 Mar 2024 00:16:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Wirno5pJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CFE5E87D09; Tue, 19 Mar 2024 00:16:48 +0100 (CET)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E0AF987861
 for <u-boot@lists.denx.de>; Tue, 19 Mar 2024 00:16:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-413f4cb646dso31892955e9.1
 for <u-boot@lists.denx.de>; Mon, 18 Mar 2024 16:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710803806; x=1711408606; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=c6ZM15uUUmha+RGseHVO/OgEFs12byEfeMOHHIk+r8s=;
 b=Wirno5pJP2lkHL/f94E1riLiIRZ1jeQQprrQ6Q/f4P6fmAwtWvgFKC3P63ArGSUYWI
 8PkQV1G9tvau07sty8ALQR1NkZmnrfRSpbMj/TgqcJwkOHFjEvxu3dDYzdSv/S3zNAvP
 eQBlp4Ah1g649oPmenpMF/u8/89/UxE0B88C2bizy3iWxk/sgwjog8L/eMuiBus+5Jcl
 ZZI7zB9l//rdQQKOJz17mGWTRFKQ4muNbyW+cgLwwHl4/fgnBQTI9khIy2thQKiX67rj
 1yD00zi+ZueG5aAxLHn5jUzx/cnU16jdeWXkErrV+iAps2FfqOY9BLx7p8enY/bbO/1I
 WiKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710803806; x=1711408606;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=c6ZM15uUUmha+RGseHVO/OgEFs12byEfeMOHHIk+r8s=;
 b=sUsxtvWshWe5HLAhpyHnGwc3ZXhA/PAKmlXSQvW7w16X1quxspabQ4MaxEGaHg34SB
 CJEz40mzjekH177EQgQGhPdrq1AdHAAxh/cPb2VS8k1A5OzTIUpVJJWOZCSj7+4e9vVq
 gBSs29a1nx49B4fQpZhfvTpj+dW6RGvCfHptMnP4pcQ2fBhPP+XuMeiYwnZNt39gp82o
 Sl9tjaZXEqZfU9JuSk6Vs4Sx4L19nse17b0NTlER1CZ/9N0bWTL2FHMg7iJTEfa770Lq
 wa+Li7q8hU5rREURl7YPGbjVXbt2e0WInBf6nckyHvbI8HEZzabXe2lZyWQYz3LLhviB
 n35Q==
X-Gm-Message-State: AOJu0YxIxAkLRYqDFb8loNfnGZuAtnkXrgCs9av9m39L/h1uQ6Ml4E0q
 9+EP3SWuIAYjyyIxYV+RS9Cdw9k0XrXXDIJ9p5TAfLeA5Lywyz/WAbc/9Heua2k=
X-Google-Smtp-Source: AGHT+IHO/0NBfY6c8SRdas0RCVU/QQ4eg9/dueTkHpkTp9DIBRs0dMzWhNx+ay7XoAlWBg7fao/DiA==
X-Received: by 2002:a05:600c:a02:b0:414:9fa:1da2 with SMTP id
 z2-20020a05600c0a0200b0041409fa1da2mr5093761wmp.15.1710803806235; 
 Mon, 18 Mar 2024 16:16:46 -0700 (PDT)
Received: from lion.caleb.rex.connolly.tech (host-92-17-96-232.as13285.net.
 [92.17.96.232]) by smtp.gmail.com with ESMTPSA id
 v7-20020a05600c444700b0041420706396sm2646551wmn.12.2024.03.18.16.16.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Mar 2024 16:16:45 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
To: Caleb Connolly <caleb.connolly@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Ramon Fried <rfried.dev@gmail.com>, Sean Edmond <seanedmond@microsoft.com>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH] cmd: sysboot: null check filename
Date: Mon, 18 Mar 2024 23:16:36 +0000
Message-ID: <20240318231640.1343956-1-caleb.connolly@linaro.org>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Currently if ${bootfile} is unset and sysboot is invoked with no
filename specified then U-Boot will crash will a null-pointer
dereference. Add the missing check and a matching error print.

Fixes: 993c912d304d ("cmd: sysboot: Create a sysboot command dedicated file")
Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 cmd/sysboot.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/cmd/sysboot.c b/cmd/sysboot.c
index 63a7806debe4..d14c570d96ab 100644
--- a/cmd/sysboot.c
+++ b/cmd/sysboot.c
@@ -76,8 +76,12 @@ static int do_sysboot(struct cmd_tbl *cmdtp, int flag, int argc,
 	}
 
 	if (argc < 6) {
 		filename = env_get("bootfile");
+		if (!filename) {
+			printf("Specify a filename or set the ${bootfile} environment variable\n");
+			return 1;
+		}
 	} else {
 		filename = argv[5];
 		env_set("bootfile", filename);
 	}
-- 
2.44.0


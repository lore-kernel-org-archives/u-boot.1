Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CF52D75E34
	for <u-boot@archiver.kernel.org>; Sun, 24 Nov 2024 19:20:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6685B899C2;
	Sun, 24 Nov 2024 20:18:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="JZEeMc+w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6804D89920; Sun, 24 Nov 2024 20:18:04 +0100 (CET)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 183FB89578
 for <u-boot@lists.denx.de>; Sun, 24 Nov 2024 20:18:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a9ed49ec0f1so601873666b.1
 for <u-boot@lists.denx.de>; Sun, 24 Nov 2024 11:18:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732475881; x=1733080681; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=tUPs0yp6kU8qCe+jxwHLZfTPx5odl1foc42JUWMVeHU=;
 b=JZEeMc+wUJfudqw7d3MUqFz2JOc5I4sxo8rJYi0yed0JfR5y1rehv+GhG+ISjVRyMk
 1k1Df2Mv6Ouk6DXK9VmMGSpPx4HvxFBYcTvaqaCu2kXUyCfJ9SDjInfh7AxL+xqgAaW+
 BV3/z+H/RM5eTY95Q3UvJfuz1Ht5kBtHliR5IDKCqFN2Gb26gDgImRjlsjU4j2YSurh1
 Pbe5G7E8RZ0HHtdhMFXatfgxUXkIbEY4xBxQeu7YSPNKXwnheAkdsqHXsjAV9qtr05yq
 lWXzgnxb6JuA508NJ3MsA44kZ6boFf9mI00VTKXIPkBrg6nyAf3Giq0bHidArunzFySU
 swVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732475881; x=1733080681;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tUPs0yp6kU8qCe+jxwHLZfTPx5odl1foc42JUWMVeHU=;
 b=LBFwj9v8z9OPBfWGR4uR6hmjl/NsjSTLXQslq7hA1H2E/YYd9UrPWqnpyvcQqPY+QF
 ccWRmpZS4g8bPWj+/X4R0WYTOi+epNV1JY7XxNMD6Ogmac+SGfq1kAoGFoCYk0znlIan
 oLkff8OD0q/v85FzX3nZSxTwOZyac9lS2+bqqFWZnpovS6dvlXw0Tq6G6zAnAYMFMNig
 oSSQelHrh62BOTYkqQGnegy/75rgn1fZSkcwtd8VyOmUxZvae2yac5B1svZQqyKWueQW
 o9drpFbPpd47mJ0riOwoM7NaYZ5VUOpgSgxiZw52TWSgNpwCn75oAOkaLz/PhJVEzoNh
 G5jQ==
X-Gm-Message-State: AOJu0YweTHeUnbLpOQfhrZTJoaez52POF/i8L827zXlZ0vAVtxxBT9t6
 kth1xHhM3evd8HRhI8fkWoN+8ijHcALJq96psMRpxJ0bylT6PJ9bGnPmSLVINNKBYJW4WstR+qu
 mSSg=
X-Gm-Gg: ASbGnctwRrN6t5UfLDzU2xYMDGOkK0/fIH9REmtodL21exg5OX2K3j0EHnU5MM9VxTk
 NCLKRcjYpjwmDoyVW9Jy+UMdk/XN0v4zsK8p+Liwd1GlnP6YojP5DINTmZpSxVe1IWsMEf7wBCu
 1jF4VkA6DBGUn7PUFYdG59maTgEtRHymFLsmAvSBuJz7wHIs4m6Fy2xXtJGivp+paizMofx8FcD
 +ltDshE7RA5eyA3RQ4cERF5bmC1vVHKLP9QG2XDMBqFu6tchefFRtlkIvYg+/XWoelI
X-Google-Smtp-Source: AGHT+IFpKr1XQMAtOmZCQ+kvYfMS7Z0gHaL7p5GgG1CO6QTmEVIsAYm6ThPVeD0AOj09tYQrCY8wRg==
X-Received: by 2002:a17:907:ca09:b0:aa2:c73:3720 with SMTP id
 a640c23a62f3a-aa50a0a7d77mr820548466b.58.1732475881638; 
 Sun, 24 Nov 2024 11:18:01 -0800 (PST)
Received: from lion.localdomain ([2a02:8109:888d:ff00:ca7f:54ff:fe52:4519])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa50b28f848sm371874566b.36.2024.11.24.11.18.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Nov 2024 11:18:01 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Sun, 24 Nov 2024 20:17:56 +0100
Subject: [PATCH 14/15] mach-snapdragon: fetch serial# from SMEM
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241124-b4-modernise-smem-v1-14-b7852c11b67c@linaro.org>
References: <20241124-b4-modernise-smem-v1-0-b7852c11b67c@linaro.org>
In-Reply-To: <20241124-b4-modernise-smem-v1-0-b7852c11b67c@linaro.org>
To: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Mario Six <mario.six@gdsys.cc>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1342;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=vXtKUBdkMOD+rs8Qv8lyRTm3q8cJlHAlpVPQp8PMFtk=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhnTn6pv9d8um73rrHyrTrHLbyzhgjZzVy4Bbdy7dY9/Io
 Lgg4GdYRykLgyAHg6yYIov4iWWWTWsv22tsX3ABZg4rE8gQBi5OAZjICQGGv2LZ58Uu/JlsFbeB
 r3lV5xLhoE1/cifEvl4u71h5w5bR1Yrhn6W4x/XLoR+TPxhKlb1MNijXuNWyRfDM5i1SGbP326g
 f1gcA
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
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

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 arch/arm/mach-snapdragon/board.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
index 269d39e4f6e1..dbac8aa2709a 100644
--- a/arch/arm/mach-snapdragon/board.c
+++ b/arch/arm/mach-snapdragon/board.c
@@ -30,8 +30,9 @@
 #include <malloc.h>
 #include <fdt_support.h>
 #include <usb.h>
 #include <sort.h>
+#include <soc/qcom/smem.h>
 #include <time.h>
 
 #include "qcom-priv.h"
 
@@ -198,11 +199,16 @@ static const char *get_cmdline(void)
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
@@ -353,8 +359,11 @@ int board_late_init(void)
 
 	/* By default copy U-Boots FDT, it will be used as a fallback */
 	memcpy((void *)addr, (void *)gd->fdt_blob, fdt32_to_cpu(fdt_blob->totalsize));
 
+	/* Initialise SMEM if it wasn't done already */
+	qcom_smem_init();
+
 	configure_env();
 	qcom_late_init();
 
 	/* Configure the dfu_string for capsule updates */

-- 
2.47.0


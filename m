Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC2C8C3DA59
	for <u-boot@archiver.kernel.org>; Mon, 15 Jul 2024 10:11:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3A24588872;
	Mon, 15 Jul 2024 12:08:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Xu7ASPxL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D0C0E88863; Mon, 15 Jul 2024 12:08:52 +0200 (CEST)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D2CD588856
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 12:08:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-58c947a6692so5207011a12.0
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 03:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721038129; x=1721642929; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=J2Xb8QGSmLC3HVEoB3mz/KYofOPaOn10RTD7PCXi0JM=;
 b=Xu7ASPxLVYm4DqhgyV6YfszH8tXGOOHxWvSiIPSDf7VKa0gP4HOsHoKpzJ6sUVdBw/
 14W+Cespe5crxDNDpuEVswYrutAWo3v86CDJF7sjtQjoepYAWUHJj+Uci8JINRlNgcM7
 MIz5U9jX4XZKNK9SBuzN4qSV/biY9gDlLm1xp38pK6AafRDVliHez/kpODEIJVDiVNDj
 0l6MT1s1njdEGYAfd3u8tu/x6lDmzG6Ma9cJq7PBYsQojo9/lXqKXAc+ird5TkzQEAtP
 HZS8GlqbIOsV5EO0mr+/oaMAK1CAKFOYgX6X5ARt5sQnbRas940SJzrAR+ZM4hGF418V
 ZzyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721038129; x=1721642929;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J2Xb8QGSmLC3HVEoB3mz/KYofOPaOn10RTD7PCXi0JM=;
 b=Vnh2aP6j4KO0kbZvfc/uszI24cXPGRk8CDp7Kio0JZ1TymTbfJGSk8mwmWAg4KCAZU
 UhTEK7uMaZkq6gilOQHNU1jAhUhP0WkHvS0tIvX89q/hhuhpqayL6/n4dpdXBJ8TXico
 0DlzJcF4wsBnRZcZ6T5GT4QF/vJDrDAogdLuCrfMpJUg/QX2mNHaGwZeIhfYuZdzezF6
 o4mWGtG4h2BMc9akUJCX07fDhcJmPhX8i9cqGz5aBE/wfv67nq9iSb+Muv8fTZWtk63w
 PT1hLPVkrN7K+ZrZP3Lf4RwOdkB3zcWIAQszkhlimRZmKIPtlCoHAlyhix2nOyZjoeJl
 cX6Q==
X-Gm-Message-State: AOJu0YzvV744QMjA9Z9n+AyH82YSs9vnW0uLkuZqc0BQN070SZ51buwU
 akx5PoMuSYJCc2N0AnlKyKmpZI7WH2B36e+RdXNVF9o+G+LFMYR+y/A3pK+mhEk=
X-Google-Smtp-Source: AGHT+IG7iNrSRqYf9ZatIVp9QAw9L8o7jC7RfZYzfnWkPZbsohh65LCVML9TkqYVPB9Z8h+eDlmEeQ==
X-Received: by 2002:a17:907:9492:b0:a77:dd1c:627a with SMTP id
 a640c23a62f3a-a780b68a25fmr1690203566b.8.1721038129341; 
 Mon, 15 Jul 2024 03:08:49 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::7424])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a79bc5b7eb4sm198102266b.60.2024.07.15.03.08.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jul 2024 03:08:48 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Mon, 15 Jul 2024 12:08:16 +0200
Subject: [PATCH v6 17/24] power: regulator: qcom-rpmh-regulator: adjust
 headers for U-Boot
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240715-b4-qcom-rpmh-v6-17-0c948a25d018@linaro.org>
References: <20240715-b4-qcom-rpmh-v6-0-0c948a25d018@linaro.org>
In-Reply-To: <20240715-b4-qcom-rpmh-v6-0-0c948a25d018@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1182;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=Oc4JtpqXYn1MXtM0lGX9maQ83ydNTHJPWFTQLcLax0I=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmlPUHlFmTGZ/ivsNkcWEqRiVwKr6guKPPhhgxW
 m29hRrzjUyJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZpT1BwAKCRAFgzErGV9k
 toocD/9fWy048IDH4ZZlmps5+t235/UG60MFHzNkrEPfnaStyUV2eDo3HHVv/gUiW65nLKan6nS
 i6uFtYJIWE5GPmLkGUVXq/w1r5lkIBZc3rwfFsi+Y1dilCkxPLVvM4jt6iuQDLhL9qIvIofn7A8
 7+3IbkG9I5YrrsP1JpUKUbq7oZ0NJrBrFYkA8C7sj5hAPz4lsX3XuJtKbglZTKqmkUe73/E05ws
 685v/PgpA14e21SYHhQzxsYyPmJTTXu0ws/tH8m1DzXc7eNCr7eXQAxWVSY/cJ8LpI1c9eeGCoW
 unDQs5LjUqT1hqxhJpV5QxGI6JK7XBz8vdgkebVwKxdVJuP1u9g+Rfc4AY4LvSuLoEA3EnfvsZ/
 Y+VyIfzMUnT1kX8tK0g0LcPGYeTkPBpSwv839A/68zJNeXaOpyI/aXxkNsu531KJ6RCpK7pnXob
 zwzGqxBNryAVGECEbQqG+vvNVmxOZetTAwOvgBHWzmyD6lhPQpHOPPZwx6a5XDTXhwateO88L4b
 U/e2/Q+G0RVubTTTXtnbfeOwrMtA5GUtu4hzcHwFyLpVW/aMMVXCgIeoy/3zr4avlgHozT+A8Ae
 S+nJin97gHSos99S5xF9iZbzaiozQpifSG4ki03IYjWOdSw8ZjnbC6wrUpUELahK3G6WaLSmkGl
 WlknYzwPLR6CX9g==
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

Remove unused/unsupported Linux headers and add necessary U-Boot ones.

Acked-by: Sumit Garg <sumit.garg@linaro.org>
Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/power/regulator/qcom-rpmh-regulator.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/power/regulator/qcom-rpmh-regulator.c b/drivers/power/regulator/qcom-rpmh-regulator.c
index 80e304711345..5f522de44734 100644
--- a/drivers/power/regulator/qcom-rpmh-regulator.c
+++ b/drivers/power/regulator/qcom-rpmh-regulator.c
@@ -4,17 +4,14 @@
 
 #define pr_fmt(fmt) "%s: " fmt, __func__
 
 #include <linux/err.h>
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/of.h>
-#include <linux/platform_device.h>
-#include <linux/slab.h>
-#include <linux/string.h>
-#include <linux/regulator/driver.h>
-#include <linux/regulator/machine.h>
-#include <linux/regulator/of_regulator.h>
+#include <dm/device_compat.h>
+#include <dm/device.h>
+#include <dm/devres.h>
+#include <dm/lists.h>
+#include <power/regulator.h>
+#include <log.h>
 
 #include <soc/qcom/cmd-db.h>
 #include <soc/qcom/rpmh.h>
 

-- 
2.45.2


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E608C3DA41
	for <u-boot@archiver.kernel.org>; Tue,  9 Jul 2024 09:35:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5663B8860B;
	Tue,  9 Jul 2024 11:34:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="M/t8hVzb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2E875885FA; Tue,  9 Jul 2024 11:34:52 +0200 (CEST)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3646888578
 for <u-boot@lists.denx.de>; Tue,  9 Jul 2024 11:34:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a77ec5d3b0dso284532666b.0
 for <u-boot@lists.denx.de>; Tue, 09 Jul 2024 02:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720517690; x=1721122490; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=jH0R95mN5pldYprNk4prMMlGbwfbh+fDoPDrw/JE4nE=;
 b=M/t8hVzbQbNwFMzKPJN0sz0NVDII6ri/n9UfLbiM17w9vbOdb7J1QahFLnEpXTx+oU
 ZTq2BAEgvqDtt8zWFlFL3myMDjcx787PKknplTGyYb0zxsr0o3sqbpLx8GeaA0v7iCnL
 UbS8OBByPpvODjGut4QJF5vrUGx8tGqqE9f1aAoeECPyYXOo5ELsZspPN9jv9vSp4Ecb
 yuTyPG9Tm1dAxSbKxuwEbqXCogVuxcq6WLwWFzLR8pA3yDQPlYwLx40yE0HIGIphC989
 nJALAPTQvuub+HTwF5Li6kYbfm0VXNBbvghEo/59p8cgJmHHEsxPqU6rxoBImm76C5IA
 Ms+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720517690; x=1721122490;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jH0R95mN5pldYprNk4prMMlGbwfbh+fDoPDrw/JE4nE=;
 b=TNKLBUbcrx5OO+lSijYfZJwwc9ZM9HHMTvZH2kb2Fa22JyV8vZXo46HAcjel12TSCt
 v0szafWt51mWQ+dnVt7YxLIKVxeUS6rJzSkDTCqmReXGn+/qguKIaZKJRJkM/Q7gXK8U
 EZKAm+uGt4pyjq2wK/wfzN8ANAXNdfTrG/WtcP6O1xFY54eLo68IyUcWMirx35A0qQz1
 Q9BxJYDeLs9wket09b/J9pPetKtHwYN3OwxSiKIFmtuYUYCMMAy1j3diCwmaxJn2kQuF
 FbckEL2cqy6QqjpB5jahiy+TfQCmtbMExLWvX1fZVcts3J5aoDvAYkVNQSo7UHikx45r
 nL1w==
X-Gm-Message-State: AOJu0YysBRDULVg/0eBNWWxmvyWBXvxdXFBTf8QbJ1+cUHqsocY41zS3
 75wzDyWm/03QbPKmZOMe97AaD96op4//r5p1tbCVKkEd+Ii4ZCpMCJmKfBOgX98=
X-Google-Smtp-Source: AGHT+IFmJDZ6s+g22JQgrR9TskQOBSFRmejVtGy8EQsGaqN1c7bXM1p2Lu/vAjzdqywg+jbqQtuyyw==
X-Received: by 2002:a17:906:c9d7:b0:a72:8296:ca40 with SMTP id
 a640c23a62f3a-a780b6b1e73mr127025866b.18.1720517689741; 
 Tue, 09 Jul 2024 02:34:49 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::18f8])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a780a7fefaasm62884566b.140.2024.07.09.02.34.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jul 2024 02:34:49 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Tue, 09 Jul 2024 11:34:31 +0200
Subject: [PATCH v4 03/21] soc: qcom: cmd-db: adjust headers for U-Boot
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240709-b4-qcom-rpmh-v4-3-c06d0a26644a@linaro.org>
References: <20240709-b4-qcom-rpmh-v4-0-c06d0a26644a@linaro.org>
In-Reply-To: <20240709-b4-qcom-rpmh-v4-0-c06d0a26644a@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1152;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=Q9jtXt+bM5+Tfqs/wRnlsYqeup5IIKqNtAQZppHLN1Y=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmjQQypu93c0UF6IeoRQ8NWO3bn9Bf5EwpzzH4w
 ZUG1itnOO+JAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZo0EMgAKCRAFgzErGV9k
 tpQ2D/9oQkQHsjSMkJJknJfqLlalW6rzjcow2QD0NkRpDAETwqs6szPvQbV5uRFp8v/HvfVrXgt
 1BgWjz0Y2n+dBCE8jRhWrFpc1JhOv0rlafZOW+miGe/xu61dKl1i/BVayTBtKdrj4NF3x7Wh2Ad
 Jhx6YK/1354+bj932hZ6xtUET+piicdA/wHd1aZipRnIYpae65AMrQAiyhRE0VTPOvooBu08uIn
 K5ykDSPmxltRuDfnZwVbarj+aFsYAvssQ5o+FbN+Qabs6NpshRMSyCaeL2sgNzdpmBn1mXNe54+
 WzeL7/pBgQqs2NCn9QKb4W1TSyYeO5jOHHGz97ygp1+QnfzAyW8/0MkT6WQKBFOG7Cy2CTCjbb8
 VU0NipLixE2aofcNCPzGY+YhlfB+rbYracsNXYGMaHbdVcUcfYXdOJDOzG3tBTA3AE9UNgs9jwr
 D7CTA96W/1M0mw08xCQ9E6BxKFRu8Ac6ctZ/68eKIwMr3F3f0WvYQgI9oGxw3sSZFOzJMCtjvKi
 VpZ6GLJOgK05h3Jtv/eIIb2+d74VGE1jJw3Birt6iHeqlkWOVRJqYPlHz0pLlTmO54Qnyu3nm56
 LXctty0cG7bPjqJq1MaycF6CObJ6LIImkniBMQM+F+Yy3hAWy/03uF2509js2yrsFSgaN5qlBSC
 yjlHEcrqtpynLqQ==
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

Replace unused/unsupported Linux headers with appropriate U-Boot
alternatives.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/soc/qcom/cmd-db.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/soc/qcom/cmd-db.c b/drivers/soc/qcom/cmd-db.c
index d84572662017..685b6d530136 100644
--- a/drivers/soc/qcom/cmd-db.c
+++ b/drivers/soc/qcom/cmd-db.c
@@ -3,18 +3,16 @@
  * Copyright (c) 2016-2018, 2020, The Linux Foundation. All rights reserved.
  * Copyright (c) 2024, Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
-#include <linux/bitfield.h>
-#include <linux/debugfs.h>
+#define pr_fmt(fmt) "cmd-db: " fmt
+
+#include <dm/ofnode.h>
+#include <dm/device_compat.h>
 #include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/of.h>
-#include <linux/of_address.h>
-#include <linux/of_reserved_mem.h>
-#include <linux/platform_device.h>
-#include <linux/seq_file.h>
 #include <linux/types.h>
+#include <linux/ioport.h>
+#include <linux/byteorder/generic.h>
 
 #include <soc/qcom/cmd-db.h>
 
 #define NUM_PRIORITY		2

-- 
2.45.2


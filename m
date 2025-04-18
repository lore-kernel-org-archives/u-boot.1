Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3791C369AB
	for <u-boot@archiver.kernel.org>; Fri, 18 Apr 2025 08:30:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 64DA482EC6;
	Fri, 18 Apr 2025 10:30:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CCgzUdWI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB71C830A0; Fri, 18 Apr 2025 10:30:14 +0200 (CEST)
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com
 [IPv6:2a00:1450:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EBF1582D5E
 for <u-boot@lists.denx.de>; Fri, 18 Apr 2025 10:30:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ant.v.moryakov@gmail.com
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-30effbfaf61so19053551fa.0
 for <u-boot@lists.denx.de>; Fri, 18 Apr 2025 01:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744965012; x=1745569812; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Y4uUpiaxIe3f9U5zJl5ydilEyTzQIzGo6H4gPBo1x1c=;
 b=CCgzUdWIPgjJkFGE8LpLIjaHSHIopNu08+xTlu/4wla7bhzoytNxvGEg5s8EtKFXMh
 IJQWk9M+QsmH2vrjpVD9DDf3o+IZ76ycP3nB6i/9ivN8csxAHZ5Cklj11MTTFv4nG5ys
 zXAxz0ukEmEW2Z//xFnQqZbFp/7MTwt75RzTLEVReU5BkIC4kzZGpadKitURR77qnkZU
 qKzk0Pg+e6uMMCOA7RNjx+7VADWJO4mQ2BkX7rGbc3yC0QRyZPU9k1dLuSEvuXXxyVlh
 BeM9hpe5WE4p+Yj0LhGI1i5+0R5UhsQdWmB6uRigrJHFSWLcylpu6yyzroM6iMCcxYWZ
 xrgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744965012; x=1745569812;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Y4uUpiaxIe3f9U5zJl5ydilEyTzQIzGo6H4gPBo1x1c=;
 b=UcAHU5/zk902F8qs72Lls+pWRu2y6yqdfxhInLeRWR5CgpWi9K/fQsRMd/cp6DkKwP
 R1QHvq/ZvbFA8NPHmwxuUH4DGEE83DnFsR4f9UveGt9rfwXH2f1sPdNA5a8qy2M+nc8d
 Q+/nmOIC6UtizOBj1V1Lugmd7XGoBqEnXd6iGc1SC61aeYhJnFW37EraDjzrwhQOJBvG
 NUdSN+DBA5FenUsx25Ijr0kvLROsVOFWgHLo8ZKogZLRLCa1FdXqw5EXI+fvKHqWrZvZ
 Sq4ZJsA1zjfINswqskvPyH8RJeFvzHzLi+hd68+MbOH++7Vepksyk8lRxV0A1xbY+htP
 Pmpw==
X-Gm-Message-State: AOJu0YwASnTAZdGRIIy2ZIQsYQqGO/fNGnIZ2lmg+mQDiGleuLViBsZq
 5HGcZPvNhK+bvyYsUP8BnMuDpyQv/t8NE6HFrG/OW9dDSmnnXQlenNG9gA==
X-Gm-Gg: ASbGncvw/gGprGrTyOnaoCmptqsLe34thF+BERPA1zTORlAsmKlrXj7VnBVUHDSPALC
 8/P4yXQ5MZy2n4tAxq/K6dedv3hl+GMB/SgvKMS7McHTpEvjyHJqeBqOsCGI4w15Pk8HZkF7kSO
 QO9282BJ8XRnikM9GMdszN0g6EAVyR2jwKhA/WQANyn0NWwQG0s0N1qlrkLc0dtkhnrlri35jtc
 QJJKddqhDL6+kyFGBZIgOfBF2QTMWwqZ74QExFRnYQSiDiY5FmCQlujceK+kRZzydbx8U2YfdvE
 8MqXXpL3ZzlfZsE1dXsk/QM4DfAZBZSb0oVAFOdT7s5Cx+I5H8xJJ+r9eMOFkx4QzZzw7DQkyen
 QwNz6tk5n
X-Google-Smtp-Source: AGHT+IEDFGxWK0Ipzm1vW7gWNb2PvcaLNHpsP35SlpxL/uSdWnVym73JeBz/fbRWI2V0fVjkU0eNOw==
X-Received: by 2002:a05:651c:312b:b0:308:ee65:7f44 with SMTP id
 38308e7fff4ca-31090df91f3mr4855871fa.8.1744965012016; 
 Fri, 18 Apr 2025 01:30:12 -0700 (PDT)
Received: from anton-desktop.. (109-252-120-31.nat.spd-mgts.ru.
 [109.252.120.31]) by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-310907a7635sm1625511fa.60.2025.04.18.01.30.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Apr 2025 01:30:11 -0700 (PDT)
From: ant.v.moryakov@gmail.com
To: u-boot@lists.denx.de
Cc: Maks Mishin <maks.mishinFZ@gmail.com>
Subject: [PATCH] tools: image-host: Fix potential memory leak
Date: Fri, 18 Apr 2025 11:30:09 +0300
Message-Id: <20250418083009.15859-1-ant.v.moryakov@gmail.com>
X-Mailer: git-send-email 2.34.1
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

From: Maks Mishin <maks.mishinFZ@gmail.com>

Signed-off-by: Maks Mishin <maks.mishinFZ@gmail.com>
---
 tools/image-host.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/image-host.c b/tools/image-host.c
index 4a24dee8..453cd38f 100644
--- a/tools/image-host.c
+++ b/tools/image-host.c
@@ -1029,10 +1029,13 @@ static int fit_config_process_sig(const char *keydir, const char *keyfile,
 				   &region_proplen))
 		return -1;
 
-	if (fit_image_setup_sig(&info, keydir, keyfile, fit, conf_name, noffset,
+	ret = fit_image_setup_sig(&info, keydir, keyfile, fit, conf_name, noffset,
 				require_keys ? "conf" : NULL, engine_id,
-				algo_name))
+				algo_name);
+	if (ret) {
+		free(info.name);
 		return -1;
+	}
 
 	ret = info.crypto->sign(&info, region, region_count, &value,
 				&value_len);
-- 
2.34.1

Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1AC5C87FD1
	for <u-boot@archiver.kernel.org>; Tue,  5 Aug 2025 14:25:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 832018383E;
	Tue,  5 Aug 2025 16:25:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="B1KTgrfM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 79A9D83045; Tue,  5 Aug 2025 16:25:33 +0200 (CEST)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F32E183839
 for <u-boot@lists.denx.de>; Tue,  5 Aug 2025 16:25:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-af95ecfbd5bso444289366b.1
 for <u-boot@lists.denx.de>; Tue, 05 Aug 2025 07:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754403929; x=1755008729; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=J4xsJH6rguGWoB2X1+zyizkiCpI98Vl4Mwl1fyDJhFg=;
 b=B1KTgrfMtZ2l/Q4YhxMGcWMOzEG3vfDOZcP7iCpMd65XvEa3FviR0HQnT+Hu1xu86T
 Mp3zg3AKBPyT+SdlClGoRWpBorD+wGpK23ltCSHUfNW15tYLVkIsMl3lkHlaymG5948C
 KDtb78zZYiPTf8AheYafyhkw3d9u9R12DSLMijcKW3xyGeD5UXZPhNrINfNuTJi9q9+l
 BBbmz/AgwoYTA+ez1g/VO+CzltMInemrnWe0zZJUh/2mE9eeOJ+SemEaRYUUxJcjW9wd
 39CYh75FBDi5gklDtctC3mLMRjed6gmGMINDSMQpt1rspeEn9HkYD4AJekGUcY7AqLo0
 qyhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754403929; x=1755008729;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J4xsJH6rguGWoB2X1+zyizkiCpI98Vl4Mwl1fyDJhFg=;
 b=BG+mITzxs+od6TuzGhYkPyDTx70BCQMUh+1wFi+D+/fupezBmPCibiAqrscT/RS4+f
 aAjQxSQ370MbWMlOtdWkr7pIPCcGGewdn8c9FykeAOVJBt0M7trC/F2lsl3WCnZ6/ntv
 HARXFD1pJSWWbtMTCRcpLTvuBX4yJlGlVC8/MtaxJFe/NDr7DXaWnZutpIXN3jdQLEOB
 DQxeXj90TkVj+DI03zwmNKdbUS9lrIUI85JCI7rKyTaKxQDg113lJEAABaq8an4s4nmJ
 5H/ZiafMdoS6dJZVoDtP91zjMGyDcVmKV1j78j/Zixm/2cO9/Xp+ZNZsG7q8qTJvxImZ
 w7jw==
X-Gm-Message-State: AOJu0YyEhY6cr1exlkGZzfBAIIQ6XMLFQnY/wiRf2TWQCl9zxNAgtm4r
 Mv3NvFVnTZTfuibBC8VT/ECCvaF3/WnkWZhmKsO542hazlb1lAlZ1z1yY81J18d0cLkXhG1Yh4q
 Z9bRT
X-Gm-Gg: ASbGncu50ci05t83vrMiF6aiiWYWuIl+/s3N5RXZRiTJymw5Wq7TIYeEOd4aqk5q2i8
 NoUePqXbfo+0vJSAEUqHcDeXelgI35DyCSX2eIBVG5YLN8UGc64qtch8+nmGOs2PpF+CkDS2GI0
 CfDpEuSbl1VrXEeUK/F23tTBe1z/cRdNSofXfGs7Rf7fn3VhS6l6mEFlp3QvCwnOe8Yhr9vu92a
 5niDiV5b0NYSiInPdb2YLJY2EVWv9m7PmJKl9N/1KMtqNkTS+MgFKOboXwa/OZQptZhltPbMjI1
 Ydo1dsjBiQ1TWkJpRdgzR3VNTTnhdhjcNwUDchft7LQ4HcwFfpsY3PsRTEcBlk/NI+1J7gd1s6y
 YKS8FDZ5P+fbFZFOFhrQQ2vZsuK4NYaR/TxXybRXC5ViW5pp7tnY=
X-Google-Smtp-Source: AGHT+IEyShN0WXlsJhzF7/hpfww2magMKl2skLVi4nN+rpWEE93MHtmmphwznedWqqAi5wk2DFabkg==
X-Received: by 2002:a05:6000:2510:b0:3a5:8a09:70b7 with SMTP id
 ffacd0b85a97d-3b8d94b5e94mr10641530f8f.38.1754403498989; 
 Tue, 05 Aug 2025 07:18:18 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:f9e:3c01:60bc:24e3:6dcd:9f35])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c4534b3sm19307801f8f.47.2025.08.05.07.18.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Aug 2025 07:18:18 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Tue, 05 Aug 2025 15:18:16 +0100
Subject: [PATCH 1/4] net: mvpp2: Fix impossible test
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250805-net_mvpp2-v1-1-624ef87cadb9@linaro.org>
References: <20250805-net_mvpp2-v1-0-624ef87cadb9@linaro.org>
In-Reply-To: <20250805-net_mvpp2-v1-0-624ef87cadb9@linaro.org>
To: Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.12.0
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

You cannot test an unsigned char to be >= 256. Instead make the
variables start and end to be ints.

This issue was found by Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 drivers/net/mvpp2.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/mvpp2.c b/drivers/net/mvpp2.c
index 184c1f9a46a..c0328345973 100644
--- a/drivers/net/mvpp2.c
+++ b/drivers/net/mvpp2.c
@@ -1722,8 +1722,7 @@ static struct mvpp2_prs_entry *mvpp2_prs_flow_find(struct mvpp2 *priv, int flow)
 }
 
 /* Return first free tcam index, seeking from start to end */
-static int mvpp2_prs_tcam_first_free(struct mvpp2 *priv, unsigned char start,
-				     unsigned char end)
+static int mvpp2_prs_tcam_first_free(struct mvpp2 *priv, int start, int end)
 {
 	int tid;
 

-- 
2.39.5


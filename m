Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42B9FD0C852
	for <u-boot@archiver.kernel.org>; Tue, 13 Jan 2026 11:08:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8DB3583015;
	Tue, 13 Jan 2026 12:08:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sartura.hr header.i=@sartura.hr header.b="vmL7Vl18";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A4E683045; Tue, 13 Jan 2026 12:08:22 +0100 (CET)
Received: from mail-dy1-x1333.google.com (mail-dy1-x1333.google.com
 [IPv6:2607:f8b0:4864:20::1333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E9D1C82C7F
 for <u-boot@lists.denx.de>; Tue, 13 Jan 2026 12:08:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=robert.marko@sartura.hr
Received: by mail-dy1-x1333.google.com with SMTP id
 5a478bee46e88-2ac3d5ab81bso5233710eec.1
 for <u-boot@lists.denx.de>; Tue, 13 Jan 2026 03:08:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sartura.hr; s=sartura; t=1768302498; x=1768907298; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=d1+aJCPuXSARm5Mh5CL6rklHNlCFqVgOR2Vf2wAEcas=;
 b=vmL7Vl18xDw10VUrxvgkCrAf/YNQ9Ky3dDWMJlM6h0vqdiZR/zLdWUJI+WWq86hHsB
 CVadhTs/0I9oXCKRYzrvMpWsEBRodsNU/0lTm7ZEV1N9cZDWk8ycNDBnjZk2BJJY5Hvy
 tZubPBQ+bW/idgfhfrsiIbkPUFrfojQ+yNDQO0e4xuvAoQWwtiC+6TqXscUmxSZuF1z8
 G0Bvl12N63w9xRFksTFpUiSR2/1Frf3ZXSmSJQyPedno2dWvUs2Rgs03UsGNTx6ZT2pH
 mvpqWjnfn92LkGHtExxA8ejm/vGt/mEDeyWoywyunSIjPNDDJr+jkaPXvqMMXK0sixTH
 gHVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768302498; x=1768907298;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d1+aJCPuXSARm5Mh5CL6rklHNlCFqVgOR2Vf2wAEcas=;
 b=UHPLePQmJhrTq6i16xi8feiLuJgAyPPdE5N0fGN7Z775WJLSUPyF9faA3U2ujikxC9
 wBvJPU5Sc7WD+kGhnNYqKAhnp/cCL2tdRmjfowGthKWebVlLjVUFvt3rvRKByhgzTLiK
 MfsRMWrPXymKZ0/kQ2mxggufPS+NUgGJIWP5Mo4tIAHJwU2KcWf+WWlux5O0PCL8A62W
 cqHnu1Dp0SdW3faVuEGpOVfG2CJL8SpzxmTnleE8vXzCET4hGSYnRL64/dCPcqjsTNzj
 lxc+oSBtKzyRLwL6v1g5+I6gFMLxavQgpNAwl6akFEYbuFSBCHv1pMWKY5xyqtm8K6bI
 KyPA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWTZFnn4MpsjYskWRx19IS2csztuBVbcBFJ/EUGmXNuvnCNQqLt6MZTB/dgKDo1/vwZdD/MmKg=@lists.denx.de
X-Gm-Message-State: AOJu0YxECCuELRDIy81ez5lNubMDHlWohzMbcq2SAIoRZERcr0SeoU/q
 /zwep6c9Cz0YrXPgNfoUctY7bz+oYbrdOAXt3fewvpZ7M5DRW93O22CZ8ImYnRqrB9o=
X-Gm-Gg: AY/fxX7QsJVo9kDRcB+yc7n9EIdrGfn9z31qppJSJOj0PTWMJVm8FrZdkghNiJ6yd3g
 9bCsiA5CTP0MXLLOXCIoU0NfvfH8Xx4tLZd/VE9zgz0K26DPIhxxGMkHBznG5c7hPhTWjwNyc2q
 iqvKjsEKNubjfB1Bur9rkT24fcDosz6TLOg3LflAiwIOKEpvWFB0qbvMotPyykW7G4nS022xnSY
 p4+WS9GRV8NLdkt7UWXweZ/MoR6jx5F/Kzp3Xw9oxo/gMpyahamNEazVCcU/eBXTK7BvzW1hMPf
 9YX/OVyDkOIvI5HLR/UB52JqVGx/wm3jRawZ7EAxRRsY7aGcENBzNcsyZp/K2njyfJJyS0Goa81
 +DgHxmuueb64YcjB7iNOmGyjAOJ78Y31g56B754iVCL2K26h/gGiAX7PnMoBfzKNSuzsWqhE09d
 mzaSUV5asiJT7CIyvFutha7gvkRM1Z8e3Z8wGSpED5m2/M6i3ivbdf13bq2y2vNLlRcrl7DM6IJ
 3uMKAfN
X-Google-Smtp-Source: AGHT+IHJz1hqs9cI25sRZLj+kvJC4uHAmA8Rz6cKLi3I0t1Wkr3+TQ4q6+DsvAHQeylTDrulhTZJWg==
X-Received: by 2002:a05:7301:4301:b0:2ab:ca55:89ab with SMTP id
 5a478bee46e88-2b17d357488mr15099511eec.42.1768302498222; 
 Tue, 13 Jan 2026 03:08:18 -0800 (PST)
Received: from fedora (dh207-14-52.xnet.hr. [88.207.14.52])
 by smtp.googlemail.com with ESMTPSA id
 5a478bee46e88-2b1706c503csm20934863eec.15.2026.01.13.03.08.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jan 2026 03:08:17 -0800 (PST)
From: Robert Marko <robert.marko@sartura.hr>
To: neil.armstrong@linaro.org, trini@konsulko.com, jonas@kwiboo.se,
 funderscore@postmarketos.org, u-boot-amlogic@groups.io,
 u-boot@lists.denx.de
Cc: luka.perkov@sartura.hr,
	Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH] tools: amlimage: include <inttypes.h>
Date: Tue, 13 Jan 2026 12:07:38 +0100
Message-ID: <20260113110806.648534-1-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

PRIuN, PRIxN, etc macros are defined in <inttypes.h>, without it being
included errors like:
tools/amlimage.c:124:38: error: expected ‘)’ before ‘PRIu8’
tools/amlimage.c:126:31: error: expected ‘)’ before ‘PRIu32’

Can be hit depending on the host compiler and HOSTCFLAGS.

Fixes: 18c1654567dc ("tools: mkimage: Add Amlogic Boot Image type")
Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 tools/amlimage.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/amlimage.c b/tools/amlimage.c
index ecb06bc535b..bc6e19b9c24 100644
--- a/tools/amlimage.c
+++ b/tools/amlimage.c
@@ -2,6 +2,7 @@
 // Copyright Contributors to the U-Boot project.
 
 #include "imagetool.h"
+#include <inttypes.h>
 #include <u-boot/sha256.h>
 
 /*
-- 
2.52.0


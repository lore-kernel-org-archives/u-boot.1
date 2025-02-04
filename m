Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 287E3C02193
	for <u-boot@archiver.kernel.org>; Tue,  4 Feb 2025 23:34:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C9E880104;
	Wed,  5 Feb 2025 00:34:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bHXJeMl7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F4C9801F5; Wed,  5 Feb 2025 00:34:05 +0100 (CET)
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA28480087
 for <u-boot@lists.denx.de>; Wed,  5 Feb 2025 00:34:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-3eb98b3b63dso1644278b6e.1
 for <u-boot@lists.denx.de>; Tue, 04 Feb 2025 15:34:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1738712040; x=1739316840; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=9/rqocKTeSlQDp/En9aPJXaf5LF5cwgoIfnawHr5Kgw=;
 b=bHXJeMl7gyoeLw8d+gjiBN+nicRM4rAdZsJnEO3dzUnqKP4w6gTBc/czaCpLfZh51D
 +XOKVkaClqB2u+0TtR8szEHHmq7UO8g5P2w3F+gtBKDix0vF5jPEGIATa4BO/dAYyXEa
 ffwWfqh032QQNiBYfUQMyI9AVVZb2G0wofjZw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738712040; x=1739316840;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9/rqocKTeSlQDp/En9aPJXaf5LF5cwgoIfnawHr5Kgw=;
 b=bOZjPFpiUIn7v/Fdlp9GARl0pm+Fc5Mlzr/l6EGDfQ7qrVU54wnfV2rUpGA2WJv3wM
 tr3TKklLD8l+zO2noddb+9MNlJ8AjoW0aTFwIyMQdHkBW+8SyWiKozwoq14bSHGGaC4C
 h9Jc2fcjBix3fUSQHs/Q5ZANkkBinsHPmUPe6KIzVDm3Lhp7NTscpIeHylzA2lAB4ONq
 3uGV5gKbXs8H7v4DQ7iTIt41ULaf4qvph90zWxphV9l2AsPBtJuRdujKI15XfumWWWse
 IlBTBXur5xEoObMRqfEQ85IUGD0m56AL2dMMvsVqWQx/Dbx+E8REuLFg/UWqPvfBCxIy
 ruHA==
X-Gm-Message-State: AOJu0YyOWxS3Z8pCnGHbh6pb95U5yOAoyW1IiDsCog6DxSxEG3wen+03
 6gBZVGhQyKaX3QDoJBpoM2/LbaYtmvS32UxEN2Vssh6m23VWJpPZhCnCwMHf/V3GAWnOclUKpyU
 =
X-Gm-Gg: ASbGncv1KibX5txkjr5U6o9cYqPpWLikTe+DvFEIwb06SInAIE/+Moyu6THDsgqsM9E
 /+K0mFnYMPDeltHKIbC6oidfGGD2xZ4SSvB9E09Cz+g2P/iYUBEZDwVvCKq5ectUWNrpKf4/Tr4
 SHu2tfXiTByFv17mXtFqMuyw+0o2r5bQpHNmucqgNRE2gYpJEg+dwsRlgUk+DT25aMdp29fdLms
 EugSUm4MSWXf42B1MDag7Ye3vfCELZFr9exE8lD78QrDIZGsEziWn97gr0npeomBsDqB1LCOnvz
 OSvGTw+Lblkt+RATDq2scx98biRHMVamLypIx6zSlLN4I9e+dxFt
X-Google-Smtp-Source: AGHT+IFseqKgHzCMiUVKoK4zLwyC6/d5nii3iBbuajQNjaJ+AqShcWN13Kma9/czAvCJH/tX6kLswQ==
X-Received: by 2002:a05:6808:4488:b0:3f1:cd30:d67f with SMTP id
 5614622812f47-3f37c11113emr516947b6e.11.1738712040270; 
 Tue, 04 Feb 2025 15:34:00 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-726618ba0c2sm3612130a34.46.2025.02.04.15.33.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Feb 2025 15:33:58 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Brandon Maier <brandon.maier@collins.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH] buildman: Update tests for newer filelock module
Date: Tue,  4 Feb 2025 16:33:53 -0700
Message-ID: <20250204233355.2293249-1-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
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

Recent versions of this module call time.perf_counter() so add a patch
for this also.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/buildman/test.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/buildman/test.py b/tools/buildman/test.py
index 385a34e5254..c5feb74a105 100644
--- a/tools/buildman/test.py
+++ b/tools/buildman/test.py
@@ -836,6 +836,7 @@ class TestBuild(unittest.TestCase):
         tmpdir = self.base_dir
 
         with (patch('time.time', side_effect=self.get_time),
+              patch('time.perf_counter', side_effect=self.get_time),
               patch('time.monotonic', side_effect=self.get_time),
               patch('time.sleep', side_effect=self.inc_time),
               patch('os.kill', side_effect=self.kill)):
-- 
2.43.0


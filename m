Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6188DC369B2
	for <u-boot@archiver.kernel.org>; Thu, 17 Apr 2025 13:49:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE3D682D21;
	Thu, 17 Apr 2025 15:49:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="vUX4xqKZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A91638303B; Thu, 17 Apr 2025 15:49:46 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9EA4982D18
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 15:49:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stephan.gerhold@linaro.org
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-ac25520a289so118157366b.3
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 06:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744897784; x=1745502584; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=8xpB0jWd8kGRJomohmWAlUlzO/TCQCrn4/W68q739pU=;
 b=vUX4xqKZls5NBR4SwnENPqs2qMIVSBMIOKA6PXXAveYIuJVM91bKK4NgkvXZ2vo9p0
 k6pnyug8CCIbu/xVqNE3NLX47emLGB789zGilffFGC/OL3hoPFSItWRdO74OFKefXYHp
 yS/MCw6AH2dMDPBxvsE418MQW8QnG9/1OK1VvptqveU3R5BdmtWSX56GEIVP7X8z3OT0
 0gL7KdnOcCEnNS19XS50RY1u0iD4qzBQ5D7y+I41BB9d2HL96ur9IBAGCaUruj18kcoF
 qbJGjM5YuDGcMap2FGUcjuPWqgjB/b0ofoio98BS1WK4USpl0ukchK0llW6PBRvxz7kd
 gtrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744897784; x=1745502584;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8xpB0jWd8kGRJomohmWAlUlzO/TCQCrn4/W68q739pU=;
 b=cKSmzm3r9HeOz7imRH7+XbcqxmUsPyyOJcFEliNEyt4T1orsXhueRt5tFtxaQHpuX+
 yt0rvMZ28WS8CE8thUm7lIMb+ppqBTSrLYj0CL4e/VoNroUg+9YJg44lhK9/fwb5CUeu
 aCD6b73PCz54SKH40MQD+ru6i0JmzkLoQADR1Kim3vDMUwiqPT/11YfGwpuOMICWtdpr
 fDShZ0uVaTPccJcULAw951OVCh5e2xYFpaDwvy6nv7oFQsHF2XJOmx7WkRnFwmCdKV/7
 8Ew6KCK5pKe+SXKRF/vkr1JWjEMoM9XcNfHs7NqKsUzpIJj7nNIx5oZ/NAmvQRioCbxL
 9cKA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW3T1S4vnHGQAgg3vTfRATq1ydf69z1oDzAj3ZiR6zE3R4g1amVekrp6YR5LQfXCl1wDKySk58=@lists.denx.de
X-Gm-Message-State: AOJu0Yzzt4xRwjR7YjxDF6JqJEpXSt82t0i2Wki2SHk7gXc3e9fUUkfj
 vzgbHmvAoql5K+XbE6m5HUtA4ir2U1l+clffIrHPp5b/6v9CbILZyPQc1zJ5lw4=
X-Gm-Gg: ASbGncsAMhFvdjELRStg2ToD/DFAwjjBLtrff9wdRkgNwJcGZRFfEG9czXYPSOL5blq
 1BQxj353VLBF0R0qW5EFpX8iwZNfOGKQIb6p9PR+rdYAyYtpgDSRH89FOPLy/wJjD8psxFy3AOt
 vX0hNf28DUAl+jUCmT0G2UhdvO6ctXfqigVIyqEmfoXH2e/KFVZj8EKygBp9/5MAintn7qsRp4C
 q1Fp72HFcELz/tSEr0DiBOr/SkYuDXagvaN7qvb6i4uKkiRqnnyEX3QPEQqC9WxgPy3fchgPGy7
 58M+UC0hJLXF5Tragk3iaylTIo8JWLPo/1P0wXreX2lrcaSNI567
X-Google-Smtp-Source: AGHT+IGlGIyep517oSp9JiB70H8LXGXAFDo0oLbeOtLHj+AkTmjtC1VDU+cK1IBipY9EQ4y8FDPr9A==
X-Received: by 2002:a17:907:2da5:b0:ac2:e748:9f1c with SMTP id
 a640c23a62f3a-acb429e6f1cmr560260966b.33.1744897784017; 
 Thu, 17 Apr 2025 06:49:44 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2454:ff21:ef30:893:de18:edbc:9b79])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-acb4d5bc6fesm171515066b.37.2025.04.17.06.49.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Apr 2025 06:49:43 -0700 (PDT)
From: Stephan Gerhold <stephan.gerhold@linaro.org>
Subject: [PATCH 0/3] board: dragonboard410c: More fixes for U-Boot v2025.07
Date: Thu, 17 Apr 2025 15:49:10 +0200
Message-Id: <20250417-db410c-fixes2-v1-0-76ad994da152@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANYGAWgC/x3LQQqAIBBA0avIrBPGwRK6SrRInWo2FgoRiHdPW
 j4+v0LhLFxgVhUyP1LkSh1mUBDOLR2sJXYDIY1ozaSjtwaD3uXlQtpFT+iCQUcW+nNn/ktflrW
 1D9e2RulfAAAA
X-Change-ID: 20250416-db410c-fixes2-7db207c10724
To: Casey Connolly <casey.connolly@linaro.org>
Cc: Sam Day <me@samcday.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>, 
 u-boot-qcom@groups.io, u-boot@lists.denx.de
X-Mailer: b4 0.14.2
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

Fix some more issues in the U-Boot configuration for the DragonBoard 410c
that I noticed when testing the current master branch after the recent
changes were merged. Ideally these should go as fixes into v2025.07.

Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
---
Stephan Gerhold (3):
      board: dragonboard410c: Fix button cmd name
      board: dragonboard410c: Drop custom reduced malloc size
      board: dragonboard410c: Enable support for KASLR in Linux

 board/qualcomm/dragonboard410c/dragonboard410c.env | 2 +-
 configs/dragonboard410c_defconfig                  | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)
---
base-commit: 5b4ae0f3f040908602c80908c3023b5454883d4a
change-id: 20250416-db410c-fixes2-7db207c10724

Best regards,
-- 
Stephan Gerhold <stephan.gerhold@linaro.org>


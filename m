Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7366FC46CD2
	for <u-boot@archiver.kernel.org>; Tue,  2 Jan 2024 11:55:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF601876BF;
	Tue,  2 Jan 2024 12:55:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="aAl1PqhZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 32566876BF; Tue,  2 Jan 2024 12:55:35 +0100 (CET)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 42DAF876DD
 for <u-boot@lists.denx.de>; Tue,  2 Jan 2024 12:55:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3373a30af67so1819068f8f.0
 for <u-boot@lists.denx.de>; Tue, 02 Jan 2024 03:55:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704196531; x=1704801331; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=NhhPCSPsK7/aXANE7adVogeu2jWO+gPc7u9TKdIw9yk=;
 b=aAl1PqhZn9FEqSQ5HiLL+K93TX8XCJ3PFm+KglWuY6ZkuZ3C667Y1abxCaNEAIZ702
 eIhYoAeckYs5y6AbeGwN09nnpootgcfMdV0E/p3aYbIztDutQvYVfzaNf83dG1vwUMwr
 51PzT78WZMZODIdlDH1hVLTOvz1ze7sb5JHbbMN9MR1DtG9BrLRk1Jag/qnoUsg/Dyws
 fGG8b9jcXk55cOReWLBmbGRcvRIMS/mqKtcYbsXhqn4Nn/rBw40KhLrHsrXrYs/f4qP9
 hbq76IVbztwm1k08s2YcwQNOFTOD3MYXAHr+sKLW2IoNTOetPS26a71uhQwIhwC9h9Dw
 ROiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704196531; x=1704801331;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NhhPCSPsK7/aXANE7adVogeu2jWO+gPc7u9TKdIw9yk=;
 b=P/oWzLUTfDMgjLMAp2DAI0ODivmX5p2OOtJICgWsLcOYtgE8DtEDErAkv1K10rvS8k
 ugoSWYtstf+bm8U3IOEqFBNW8VWJw8hJ+kpKs2qZ/OqGhg18xY0q0mitynaO+jU7pU/a
 1OMfToh5yKcGu8g6DypjtoZo1JOAsroKJQqF/lgXByALq5g9v3H68sRHEvcFqkzxaQOU
 IH18Ny7u+rT2OVd9pMMbYiSllU/6nPUtj4Bmwn+702/V7/s2H4iw0CxPnQx7Nrq0yxH9
 ddKAty0wBIFEBpOw3x9tfRYyigX+ogoYYVXMlUw4WtKPQkgteUQ4QLJAl67vt6Y+//8F
 iMPQ==
X-Gm-Message-State: AOJu0YwVUUUPD9g8tn6pPi9vcO6S5hFTJD4XyERwTC34Cm2wLhAC5Ors
 tGiKZDtdSI3SHGWbvCdY2IGHEj/CR9UVfANdsxL3jEw0MG4nDJQa
X-Google-Smtp-Source: AGHT+IHgRGBD8Rduo/2x+XFIbapLYbj52EqMf+Nlfav007POHkvHk0mcnny+3P3pxPvxRsKPJIJ3qg==
X-Received: by 2002:a05:600c:8519:b0:40d:4eed:fd63 with SMTP id
 gw25-20020a05600c851900b0040d4eedfd63mr5289900wmb.40.1704196531484; 
 Tue, 02 Jan 2024 03:55:31 -0800 (PST)
Received: from lion.localdomain (host-92-17-96-230.as13285.net. [92.17.96.230])
 by smtp.gmail.com with ESMTPSA id
 q11-20020a05600c46cb00b0040d2d33312csm44177645wmo.2.2024.01.02.03.55.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jan 2024 03:55:31 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Tue, 02 Jan 2024 11:55:30 +0000
Subject: [PATCH] pytest: update requirements.txt
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240102-pytest-requirements-update-v1-1-8840af19df70@linaro.org>
X-B4-Tracking: v=1; b=H4sIALH5k2UC/x3MQQ6CMBAF0KuQWTtJWxTRqxgWBD44C2udKQZCu
 LuNy7d5OxlUYHSvdlJ8xeQdC/ypouHZxxksYzEFF87Ou8Bpy7DMis8iihdiNl7S2Gewu9xCW9e
 +ma4tlSApJln/+aM7jh83bcN8bAAAAA==
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Caleb Connolly <caleb.connolly@linaro.org>
X-Mailer: b4 0.13-dev-4bd13
X-Developer-Signature: v=1; a=openpgp-sha256; l=916;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=NhhPCSPsK7/aXANE7adVogeu2jWO+gPc7u9TKdIw9yk=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtTJPze9lj708MSxinC2u//nB8ReYHyh6Sxd6Mlwfyqzm
 YTJJoG9HaUsDIIcDLJiiiziJ5ZZNq29bK+xfcEFmDmsTCBDGLg4BWAiWb2MDO1udW61m87+8TAq
 OTW7+ftqr4tcqf6H/gbstvx3Ytf1lBkM/6x+1a6pWfPr04Sc0IVBq+Yqzr69UfPXW/ONlrFMW49
 UK18AAA==
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

Update pygit2 and py to their latest versions. Even in the venv pygit2
still links against the system libgit2 library which is failing on
latest Arch Linux.

The py library also needs updating to fix a KeyNotFound exception during
test initialisation.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
base-commit: 7f4c3400d5991d2314036de1f92235a209b4f294

// Caleb (they/them)
---
 test/py/requirements.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/test/py/requirements.txt b/test/py/requirements.txt
index f7e76bdb9181..62f3e4ccad04 100644
--- a/test/py/requirements.txt
+++ b/test/py/requirements.txt
@@ -11,10 +11,10 @@ more-itertools==7.2.0
 packaging==21.3
 pbr==5.4.3
 pluggy==0.13.0
-py==1.10.0
+py==1.11.0
 pycryptodomex==3.9.8
 pyelftools==0.27
-pygit2==1.9.2
+pygit2==1.13.3
 pyparsing==3.0.7
 pytest==6.2.5
 pytest-xdist==2.5.0


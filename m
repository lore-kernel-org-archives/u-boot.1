Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C486CC87FCA
	for <u-boot@archiver.kernel.org>; Thu,  7 Aug 2025 14:29:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B7E98458C;
	Thu,  7 Aug 2025 16:29:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="wo9mZ/i/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3432083C64; Thu,  7 Aug 2025 16:29:07 +0200 (CEST)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2093D84514
 for <u-boot@lists.denx.de>; Thu,  7 Aug 2025 16:29:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3b7823559a5so515674f8f.0
 for <u-boot@lists.denx.de>; Thu, 07 Aug 2025 07:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754576943; x=1755181743; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=uc+pqrlQ3WUd9lx+X1xHKMkIAq/slOGr+ezxwCzMvJc=;
 b=wo9mZ/i/7tc/I2gD25x1cX0gDsVoHsMZPGu55vF1hD9jRHb1iBzAiW+3fUXUsm8F9W
 j8eQ8K1zewPL2T28MpnNoJmdowswbwovrlTLKW4FTK0KzD4JxvB8SLoKEb3cDnOyKRX7
 uGqgU8TisIkohu+cf+GqJUZl8oCHg125nj9UfOm2++3T74etkZ5VcrtQQNqQ0k7LlgOH
 lRWnqnPi89mf3hcffTApb3dm0RSzmIrrRy3cqSXOdPdZMjj8Y4RyMv/RLoOf24ewfc53
 sKR2CKFtX7nVgKEtJIEDihX3mOv1UqyqraM+TOkgXHZ+vSg4r9snWWWtobqA2HjKvnc+
 IqSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754576943; x=1755181743;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uc+pqrlQ3WUd9lx+X1xHKMkIAq/slOGr+ezxwCzMvJc=;
 b=P6r8u8YLS7fUg7pZT5cJiLQ9/iGnHWv/hiIjiNV5wubgiHJ3s6vIKkgelsR439CuoY
 xhoZPenD0bQxc7+9I1VF94etrtPZzN9wS/VA8r51PUzeOu0QhMb0d3UlS5Fz3ne1H3Gi
 B5R+BQr1j7xnTA6oJCD0bAJFKh1GULpBMFu0s6jQTVtmxuNdUMFTSZlBCu8XmoUX+TCM
 PMJeSCR6rGDaQ+4iz5ApprlQ+Nf9q01McnoZTXWx+5PlPtCGMNAQReAYGtoCjJ/KFqfW
 PhBtecVFa8UtVcabRzUbqmn0oijxngWMTSa+haMTgcOqG50ibJBJcSTQomLDJEe1s9vD
 s3dQ==
X-Gm-Message-State: AOJu0YwGMCfOj+EXtgRADcRFKMCF3gZaTM6kfUcjvSCSvB4UntljjTSg
 5emGVJD/V5Xkte4pNNMI0m3eNyo3pxXvlgVidqF9vTfkp3cauhSrSDcEPfH2xkC0b3A=
X-Gm-Gg: ASbGnctbplNyldT5o1R8ZTAIHq3Lz/+RGZOCrwd3AXTMh+63U3d4K8JZNfuYEWiwvYN
 UrLXz13o27mCvrNfT3Va4Eo/cwlh7T/9vFRNtkCKHID+oFtSu+FtjHGRp/6+xVzx38hEGKZ2Su6
 /RfJfZyHQGUy3PGF008oQzA66FbadanoXWaMFT+FtDuCFLz0CaB+0r5yjqxdgreVN9+wW/FfGxi
 wFMhGhiivCq82x/WfhhpNCcvMk2v2ZRmA07Zx8mkYVl85xkOvaoRT16E7GPxZI5AbJcQIu3cQpY
 MaZYYJvuoEcpKgEkNpZA00a9A34ggfX/Ojt0FEHqfj/VELoVCEH7/afoiiP7ynyHEtnEyzVJ0g3
 PNnQRq25eBmgcfVmMvq7G3pyh6jflaw4AJTEKH5d34bQjC7TmKAo=
X-Google-Smtp-Source: AGHT+IF2X32o/6yagxpcXpJW0Iz9dssEiKHKFyfNszUwlPh7/xU8G4lRiSF9XLWWZuYopnEQcoSdew==
X-Received: by 2002:a05:6000:18a9:b0:3aa:34f4:d437 with SMTP id
 ffacd0b85a97d-3b8f9f6734emr1437601f8f.37.1754576943406; 
 Thu, 07 Aug 2025 07:29:03 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:f9e:3c01:377e:cf4f:d0ff:80bf])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c453ab0sm27349027f8f.44.2025.08.07.07.29.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Aug 2025 07:29:02 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Thu, 07 Aug 2025 15:28:57 +0100
Subject: [PATCH 1/2] power: axp: Remove redundant code
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250807-power_misc-v1-1-2ac672f15461@linaro.org>
References: <20250807-power_misc-v1-0-2ac672f15461@linaro.org>
In-Reply-To: <20250807-power_misc-v1-0-2ac672f15461@linaro.org>
To: Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>
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

In axp_init after checking the chip ID there is an else clause that
returns ret. ret is guaranteed to be 0 at this point as the code would
have returned above if not. The next statement is a return 0 so the
return ret is redundant, remove it.

This issue was found by Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 drivers/power/axp818.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/power/axp818.c b/drivers/power/axp818.c
index 83ae6ecc138..01f9a209dc6 100644
--- a/drivers/power/axp818.c
+++ b/drivers/power/axp818.c
@@ -248,8 +248,6 @@ int axp_init(void)
 
 	if (!(axp_chip_id == 0x51))
 		return -ENODEV;
-	else
-		return ret;
 
 	return 0;
 }

-- 
2.39.5


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE943C43458
	for <u-boot@archiver.kernel.org>; Thu,  2 Jul 2026 14:04:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D0B9384A4F;
	Thu,  2 Jul 2026 16:04:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="VlUa4f2N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D79F684A47; Thu,  2 Jul 2026 16:04:37 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F175A849D2
 for <u-boot@lists.denx.de>; Thu,  2 Jul 2026 16:04:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-493c52cde9eso10577535e9.3
 for <u-boot@lists.denx.de>; Thu, 02 Jul 2026 07:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1783001075; x=1783605875; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=xD6jMagOrOIwb+vMqyB5qt5dRmgs9QqpP7XiSYb+5Es=;
 b=VlUa4f2NNHm/ihyOMIJdmOZYIgnM1muQtJgjGxmKnhrVUd+mj9AwkS//xSA3cNmZIa
 Fli8CcNei3DvuoU7gySREYytOOrqz1pWJuvvM2CIKcEvtCsUBnkzqsbtOhI9dLe6uzY/
 VoDV3yTKT2nQ/xRnUsccP7ccQzhlHFNg07h7cVi0O+xt3Zckj0EDlJFLA6W2ME64ROfJ
 tvRr6qiqiV9tT91c2X0gCPfl8t+Uy7BmiidpPs6DZCax3WQbuaG7OxvugU09w4VSDQJF
 TT3MQIDbCusp5RQ5AacgSDSJf3+7RNZAD1B5TbODEUN2fdYHHJVDL9yMpwYXbHH44iu4
 Hw3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783001075; x=1783605875;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=xD6jMagOrOIwb+vMqyB5qt5dRmgs9QqpP7XiSYb+5Es=;
 b=jzwIO23Cm+2+eYPnsSBrAkXvlez+AQ8g08TObqWLhKdirmZx5zBikIL3kDvBb+w+px
 kpz8grVciWOvChTVVMbS2Upt2lFNvDKITcPf/BQvMm6DLKHfwd6GN2LWdDJAID5yhQQV
 j7RJxd0E1me6AbikNIG/4KMF50Q1JNot7jLwWcUnp3+Qt0Xgqu+sJNzCWVrpnDw+egGo
 2+vMUvohqE/OxuxWQrEpDET46mkbxpO1N9gDpOb7TpqSwZYkDweS5DGRJIcMYyV1wliz
 9c/HgQpDebiEaxErwl/JFKfCrxYZHvesXRlL8DgTljximx4s8HdoHiUp1QBlzYHCm88A
 oIWA==
X-Gm-Message-State: AOJu0YzrOaNi1+QLI8/wH0TaGDv6RONb2ipsKSgqvGKihfHu6G7px2GR
 OMCYlj7py/JsK/fysrH5nra5GyZtns6/iJvDhHpaYvUGc4bbdG0wkD9VK4ownXi6eJs=
X-Gm-Gg: AfdE7cl99HCz3Pi3k3P5A6tkipv5+Py613u3dlsl89ghAInD0qpYrpd4Qduu7TV6E5o
 P2A8PSl6ov6EXP+vH64+XorCp0/79F25yMm1Jc454KFj9glSKCIIIEUBFpHOiY/rCU0WZmeWnrU
 /+TNvmvCwEL8gsGPAzqmpCyy0aLkCHKI7KZWL7byq4uko22UfO3wV9glXF5QiD0YFkytHicf7uG
 CaHN0jI7hCc4sz2GszJuJEQbwi7Pt0JNSnWUUxSzDCUmC3BvfmCZsbK313M7S3/EgxJEFXHcLjo
 RyNQw5vqPYb2BlioXaEf5N/C8PzDOiA9DBVavxqXiCwH9ewpKbQjOCz7aOb3nUUNI7wL29kxa4p
 OCg/XS2vGI6lYhupJkEqVwYKSHqEC+Sf5LjXwa1bc32JSHliz5oy/BtQV16V9DmBZ1vYvP2w2JL
 ZbZxUuDwm9p3AJOWv4lk1aQtaSxsngyAY8gIH3yjSLbLh6jDheRpsqh16tjb/s5ahG1fWpO9MzV
 jENGdgtUfvU7aMw2dlWNg/fIz7iTSx9GiqCYoKyO7drH4WJqtUscTKKvAQxrwqF51F2YQE=
X-Received: by 2002:a05:600c:3f0f:b0:493:c35c:b4d1 with SMTP id
 5b1f17b1804b1-493c35cb512mr86173525e9.7.1783001075386; 
 Thu, 02 Jul 2026 07:04:35 -0700 (PDT)
Received: from [192.168.1.65]
 (2a02-842a-d52e-6101-6fd0-06c4-5d68-f0a5.rev.sfr.net.
 [2a02:842a:d52e:6101:6fd0:6c4:5d68:f0a5])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-477dde19fd3sm9577619f8f.25.2026.07.02.07.04.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 07:04:34 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Thu, 02 Jul 2026 16:04:42 +0200
Subject: [PATCH 2/2] qconfig: Rename the doc link in help text
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260702-qconfig-check-for-db-v1-2-f0b96bf8fa44@baylibre.com>
References: <20260702-qconfig-check-for-db-v1-0-f0b96bf8fa44@baylibre.com>
In-Reply-To: <20260702-qconfig-check-for-db-v1-0-f0b96bf8fa44@baylibre.com>
To: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, Julien Stephan <jstephan@baylibre.com>
X-Mailer: b4 0.15.2
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

This was missed during the renaming of the tool. Fix it.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
Fixes: ea4d6dead372 ("moveconfig: Rename the tool to qconfig")
---
 tools/qconfig.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/qconfig.py b/tools/qconfig.py
index 9b151566e03..930eb0e203d 100755
--- a/tools/qconfig.py
+++ b/tools/qconfig.py
@@ -1514,7 +1514,7 @@ def parse_args():
         cpu_count = 1
 
     epilog = '''Move config options from headers to defconfig files. See
-doc/develop/moveconfig.rst for documentation.'''
+doc/develop/qconfig.rst for documentation.'''
 
     parser = ArgumentParser(epilog=epilog)
     # Add arguments here

-- 
2.54.0


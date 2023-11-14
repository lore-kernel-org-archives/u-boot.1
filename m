Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18244C4332F
	for <u-boot@archiver.kernel.org>; Tue, 14 Nov 2023 15:18:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6C8D28719F;
	Tue, 14 Nov 2023 16:18:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="s9xt3lVf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BCD1B870BC; Tue, 14 Nov 2023 16:18:10 +0100 (CET)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6A0F486FBC
 for <u-boot@lists.denx.de>; Tue, 14 Nov 2023 16:18:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-407da05f05aso42457995e9.3
 for <u-boot@lists.denx.de>; Tue, 14 Nov 2023 07:18:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699975088; x=1700579888; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=tcS5cWQMgdaqDLOj8U8IULBbzXursLr9thbaS9yFdcg=;
 b=s9xt3lVfRHUC54J5aY+vS2rTg5gWwI20tbGXdIhK+stw2oxom7pIJXYr8tkPOToLi6
 pssf0iE4fXhjcCRucjtRx52O80UXtv4rV+Xw1EmX7d3mrhQarUQKDBAUUaXKkSavI+Fz
 o/G6SA/3WkOgpPUBCosA/I1yc3xYr5iVL1qDCjzAu/DpP6evZmW+dCbcTrx4jvGQdWiI
 knwCNAbFmxpimzw+fxMHaf5Db+y4Ma/ZwkQN/HoTny7Hoi6VboXvLlf4BgnjyiieoZiZ
 cZmGgsxKn3UBp6P+lfSdrjI2I0lDnXs6/X3AREclYrY2NmJ9jF63VSnKfQUXTa02UT2N
 EPxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699975088; x=1700579888;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tcS5cWQMgdaqDLOj8U8IULBbzXursLr9thbaS9yFdcg=;
 b=hle41+5WQRtTODuKw0qHYFtlAS/pX8TjDY89q4NAktaX6Q+LgfIkRTswnqbYFKWcX0
 Wyo0TNcoGR2KySCvr7Ez0TeymOBjEACVwI/9fz4ikWpabagOqQbVRXh65pCGat/KfJxC
 tZ42JSm/Wcm9pXfzto56rLw/hXBtQU9xt9fEvJw0pM6SlhQISd5NtD51vYicArCobO+a
 8IvSQrsnQqBgubEA+C6rN+PYtlj5PEN7C64PtC3VhdKiKgp4aqNK+Pg3jDQpxfpNNAXE
 T9nLyhanc/kt7j21ntp4nICqNmt8J+XdCtgjPkVnZUupCqVF9lle+HLfzM2hBFK2MwKV
 8p/Q==
X-Gm-Message-State: AOJu0YyzTE0m6vekW3CGkCz7m1m1YH1WPAZ5RDJeX6v+osPM1Cylatt1
 BYHtO2ADMiVpT1hsHC2CpQIx/yvym6ihizzSMb3+Zw==
X-Google-Smtp-Source: AGHT+IE/Zzn3TPLdWrBiIENmcDOKYh5o/aw40iXk1nftyDgIVRcIquqVldlMW6YBVTfW7s1dlHbhtw==
X-Received: by 2002:a5d:47c6:0:b0:32f:7db1:22fe with SMTP id
 o6-20020a5d47c6000000b0032f7db122femr10956937wrc.15.1699975087862; 
 Tue, 14 Nov 2023 07:18:07 -0800 (PST)
Received: from lion.localdomain ([79.79.179.141])
 by smtp.gmail.com with ESMTPSA id
 o16-20020adfe810000000b0032326908972sm8099452wrm.17.2023.11.14.07.18.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Nov 2023 07:18:07 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Tue, 14 Nov 2023 15:18:02 +0000
Subject: [PATCH] doc: avoid using deprecated sphinx function
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231114-b4-sphinx-deprecation-v1-1-41687254ad8e@linaro.org>
X-B4-Tracking: v=1; b=H4sIAKmPU2UC/x2MQQ5AQAwAvyI9a6KU4CvisFbRy5JdEYn4u8ZxM
 pl5IElUSdBnD0S5NOkeDCjPwG8urII6G0NZlBURMU6M6dg03DjLEcW70wrsqGX20tXUMFhrZtH
 7/w7j+362DQpvZwAAAA==
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Caleb Connolly <caleb.connolly@linaro.org>
X-Mailer: b4 0.13-dev-4bd13
X-Developer-Signature: v=1; a=openpgp-sha256; l=1360;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=DnoD5kTNav3/2sj83ERgWIbMlNWzqi/UqKtpbIAgbv0=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtTg/vVm8z9n8m6PL9GboHVmQaTjnezbP3XrHk5ebut3M
 Gxa29XbHaUsDIIcDLJiiiziJ5ZZNq29bK+xfcEFmDmsTCBDGLg4BWAi2/Yz/I/P4Wb/bdjLeLwo
 6evGg1sbuzdPdk12v/Xrm49uz9Izwg8Y/jtMzLStXqKrsrZ1+VchvT+/2Sp2zK9YbtvFYDfFLTd
 FKgwA
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

The execfile_() function in sphinx has been removed after being
deprecated for some time. Follow what sphinx upstream does in [1] to
avoid using this function. This fixes "make htmldocs" on at least Arch
Linux but likely other distros too.

[1]: https://github.com/sphinx-doc/sphinx/commit/9ced1e355ad6baecd4e755a598a54877dc0aad44

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
base-commit: 92b27528d777ce85362af45e7d2974a6c856219b

// Caleb (they/them)
---
 doc/sphinx/load_config.py | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/doc/sphinx/load_config.py b/doc/sphinx/load_config.py
index eeb394b39e2c..977b27084780 100644
--- a/doc/sphinx/load_config.py
+++ b/doc/sphinx/load_config.py
@@ -3,7 +3,6 @@
 
 import os
 import sys
-from sphinx.util.pycompat import execfile_
 
 # ------------------------------------------------------------------------------
 def loadConfig(namespace):
@@ -48,7 +47,7 @@ def loadConfig(namespace):
             sys.stdout.write("load additional sphinx-config: %s\n" % config_file)
             config = namespace.copy()
             config['__file__'] = config_file
-            execfile_(config_file, config)
+            exec(config_file.read_text(), config)
             del config['__file__']
             namespace.update(config)
         else:


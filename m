Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F519CA1012
	for <u-boot@archiver.kernel.org>; Wed,  3 Sep 2025 22:10:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 849A883678;
	Thu,  4 Sep 2025 00:09:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="st/dUQ0g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C5DDB8360D; Thu,  4 Sep 2025 00:09:51 +0200 (CEST)
Received: from mail-vk1-xa2a.google.com (mail-vk1-xa2a.google.com
 [IPv6:2607:f8b0:4864:20::a2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 94848835C1
 for <u-boot@lists.denx.de>; Thu,  4 Sep 2025 00:09:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=javier.tia@linaro.org
Received: by mail-vk1-xa2a.google.com with SMTP id
 71dfb90a1353d-544acb1f41dso179043e0c.2
 for <u-boot@lists.denx.de>; Wed, 03 Sep 2025 15:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756937388; x=1757542188; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ZjcY5ChSGfKiO0gAO5mQT0PmflBTBoZd2Q8ODRhRqeI=;
 b=st/dUQ0geaFETXN6YFu1T8N90N4dokDHVPYUPtgrkdLEvfSrEFwq2jmmlVS6c7d1fU
 Tm6ymp1moSKQKfaWicWGMJZepc6YliJkj8Q8AMX9eUsF7olfdrvyMg92qyoUbmwGzJ1T
 DzdVfkc70fQ34hmLlxp35avZshSvjTMEzfJPLG1ES9i8kOF+PYTxQ0xyXSq00tjKDTFk
 SCiDfSc+qws8kY/XPZfkQMtODBFfM+UuzJ45KxxNRnyQ8wKySgKVht6xoBBKOotjSxmh
 OFB405bfgKLEuebdPKKRQH882QT5Im9yB9LhbKqYYao5Ak4g2dR8lidZaPPh1nFgAFPz
 iA/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756937388; x=1757542188;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZjcY5ChSGfKiO0gAO5mQT0PmflBTBoZd2Q8ODRhRqeI=;
 b=BsoeKyq1tGg/y9zcFSNZ67f+q/F67BW0PwyoXSFFjlbwPMgnt1Id7x658FiTJ1KjJ6
 /iy2O0R2DQ0+9L4A9HHamctEPx5V+WdQRKogYcT0+1jSyvbiW4vObm0hktVRBzuccCkt
 3k+dUonlaMnmYzJPkXJiFsS7tRrAQ3ipp8J+imZwoQSJy5HOzB7ILorYgmFN046cdI7C
 HxgDWpwZUKiZ1xloeWsoF8yYhaWtsKpH5TDaAsLKK2vIlw7Cj3F21yVoiKlz0dBujK67
 pCqhe2J6DvS30tks55FxBfQjhZkweniJvIzoDKLZUKiOO8XD26dcoVqV53T6TxYrOYZN
 hIAg==
X-Gm-Message-State: AOJu0Yx59sTS/3GkXMD9Tcj0EwC+aXFuXeUzv4Ylmk/BeLlAXD01061r
 /+HXFB65/Ae3pry+lGtrIz0hL6vH3sBV4wkJdSbiAcMIaZ5Fepzoj6zIJpOSQ7tA8+6c0c+vhO2
 hlWcR
X-Gm-Gg: ASbGnct6uxbqlq71MoCmw04BH1zFdtWaWTERbi1CokemRiWNNxCZ62IyND8CJ9XYeEy
 BTYf+hOw3uXtuguG5wbu9/Iyv+q2efWEYDlvrxyPTpMhUuIzFCnOAauyg1iYiXMEzot8sdnSCK8
 le8nc47EWHRZWg4XnigsjjmToy1Om1OK3OXm1PHLSZX/E5Vb6M3kZeSNbS9t26XfRjdcFZTmdx2
 rj/yNgYe4cRuxfwtx6jGL/w+aT278jXtmwhjaSfxqu8+NS8Aikjo9vWLUSxi0QOnDPZnRROMame
 LLCaFti9lfS6AcbvGMHEfL/sdi79POiirO/URPi7ZGvzk6rCYasZAzgTzwyvvHrZAtpKbod9+Mb
 u//e0heBnr0PzO2z/jjf7qIkU0KINlJjIPhKQMAihoLs+QzCQPQTKPSmk6FY=
X-Google-Smtp-Source: AGHT+IFz71s/d6SErskizB/DrNXnM+1osTPDbanK7m28t1MwJvJrAR1XD/2mnz8T9dCaRdjQa7NnxQ==
X-Received: by 2002:a05:6122:d01:b0:544:cb0f:a659 with SMTP id
 71dfb90a1353d-544cb0fa839mr2537567e0c.6.1756937388129; 
 Wed, 03 Sep 2025 15:09:48 -0700 (PDT)
Received: from jetm-rog-crosshair-hero-x870e ([177.93.10.181])
 by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-544912c7125sm7474211e0c.5.2025.09.03.15.09.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Sep 2025 15:09:47 -0700 (PDT)
From: Javier Tia <javier.tia@linaro.org>
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 3/4] Lindent: Remove wrapper around indent tool
Date: Wed,  3 Sep 2025 16:09:40 -0600
Message-ID: <20250903220942.473282-4-javier.tia@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250903220942.473282-1-javier.tia@linaro.org>
References: <20250903220942.473282-1-javier.tia@linaro.org>
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

The Linux kernel has not maintained the same script since 2017-11-01,
and with clang-format included in U-Boot, it is not required anymore.

Signed-off-by: Javier Tia <javier.tia@linaro.org>
---
 scripts/Lindent | 18 ------------------
 1 file changed, 18 deletions(-)
 delete mode 100755 scripts/Lindent

diff --git a/scripts/Lindent b/scripts/Lindent
deleted file mode 100755
index 9c4b3e2b709..00000000000
--- a/scripts/Lindent
+++ /dev/null
@@ -1,18 +0,0 @@
-#!/bin/sh
-PARAM="-npro -kr -i8 -ts8 -sob -l80 -ss -ncs -cp1"
-RES=`indent --version`
-V1=`echo $RES | cut -d' ' -f3 | cut -d'.' -f1`
-V2=`echo $RES | cut -d' ' -f3 | cut -d'.' -f2`
-V3=`echo $RES | cut -d' ' -f3 | cut -d'.' -f3`
-if [ $V1 -gt 2 ]; then
-  PARAM="$PARAM -il0"
-elif [ $V1 -eq 2 ]; then
-  if [ $V2 -gt 2 ]; then
-    PARAM="$PARAM -il0";
-  elif [ $V2 -eq 2 ]; then
-    if [ $V3 -ge 10 ]; then
-      PARAM="$PARAM -il0"
-    fi
-  fi
-fi
-indent $PARAM "$@"
-- 
2.51.0


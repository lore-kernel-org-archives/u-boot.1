Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAE61CA0FED
	for <u-boot@archiver.kernel.org>; Fri,  5 Sep 2025 20:54:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4197C8392E;
	Fri,  5 Sep 2025 22:54:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="cIw+e8en";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DBE9583959; Fri,  5 Sep 2025 22:53:57 +0200 (CEST)
Received: from mail-vk1-xa31.google.com (mail-vk1-xa31.google.com
 [IPv6:2607:f8b0:4864:20::a31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D1CA9838C5
 for <u-boot@lists.denx.de>; Fri,  5 Sep 2025 22:53:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=javier.tia@linaro.org
Received: by mail-vk1-xa31.google.com with SMTP id
 71dfb90a1353d-53b174ca9bdso1756346e0c.2
 for <u-boot@lists.denx.de>; Fri, 05 Sep 2025 13:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1757105634; x=1757710434; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ZjcY5ChSGfKiO0gAO5mQT0PmflBTBoZd2Q8ODRhRqeI=;
 b=cIw+e8enoLSDfpAZvFOqRK8r0jtG7NZUER85sIGZ1E2orb4YnEKuTUZsXEqWq0M349
 DshFHYHOL1RI1laAdyYE7fQbC03NIwaMG48WhArGaCOc7DsZEYGFejBItaCQSppgfK12
 g0/Igj7qiTxudRU2v92rINpZQnNMFu27OQiOIKq31K6VMBzMRsboP/WKT1NAgyLJnCho
 l3hQ5MvW2NlmD5p6LwQqGDF/zOzO4unACTA1osPhmk/3HAUUDMQS0mM9Cykn+FO6T1JB
 hjq6hk191IiQQN9rKiypWj/B7AmAOtCXtJ3r+TvUyIE2GB7Qs9lTt4arCpucrf5a1Orf
 R+Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757105634; x=1757710434;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZjcY5ChSGfKiO0gAO5mQT0PmflBTBoZd2Q8ODRhRqeI=;
 b=P674hcvCZgd+4TWh5TviK2LXs52zXkGoOsC+eXsIkkU76UpIVZtqBbpyW8ZWQqW1s+
 Y+nlWQwRMuvKo3CpsxfquMt4lixJoTl5Rs8K7vwt9KznssrkJKwdcYwQIRHrpM9TPfIx
 nLfKsgN+vq/t6loTnIuM3s0UsHeZPr2nvJVPtoSN2oCur6SNYmZPfner+i67Sf6Jyy1L
 RsGhwOrBw8BuUJeYJDkQigGkv6a736Xqt4Wu7/uikU7zMQ5JFt2OoyXHV6DBsBADZtZv
 3ZhZob0MDZxE4X7vwKuueHosJj9QZzXz7Pu7maFK0PLzGC5fryrcMVxoyNQDK1r9CDgQ
 Zw3g==
X-Gm-Message-State: AOJu0Yy3tfpYQvGW4WQ6RGLet5KE9fa7WjTnFs6R25iHmKPLU60DQqWg
 Llh6xLnsbCRbuX5xk962RsgMz4/LICkUUvRugt/qZnsFeLcj+ky0+mCFAs//ROF0XidELYUJ6xN
 Zk9sJ
X-Gm-Gg: ASbGncv7fIU51Ne9bbGXGBIFNNYxr/5XPF4uCCokvSs/tr45PEavEX0RKEGh+6MG1Ta
 Ks8GD/AYA1s+eJKchpg7R25Qyqr5iwCHWSAGw90DOMbayDo1x5Es717N2UsbCwGbKuzhScyENbp
 egywPg4DOdRw91/PCneAdcdDoitQYvT+D10w4flRPpWYIq9U7en6AHzI+FXy0qArkBrNwurclmR
 6vOn+8+Pyq5Ay647lNG1fjUflwJb/SrBio0RO8Ph3qHNMAHuelMen5Zn9eQIVFkz9b/eKXT/Vfq
 5HtpKeYFTh4KrRZy12zCZiqWL05LKzl3W8QMzr16iQnaOG5/J5M7GOKWnfrZCK/vxfKzz9FgoyT
 wtKl002xR4O7PoBWo4FACTpp7diI8Zl7oKjokpF9+7ckQ9wHs
X-Google-Smtp-Source: AGHT+IE3SUhT52ODVZAA5inCWEr31FMy/DGu6kBtW6jJ/8HubmYojYsDOdsEbaDFANR6m/UBNXNbIA==
X-Received: by 2002:a05:6102:160e:b0:520:6893:380a with SMTP id
 ada2fe7eead31-53d1357a2c6mr138287137.16.1757105634434; 
 Fri, 05 Sep 2025 13:53:54 -0700 (PDT)
Received: from jetm-rog-crosshair-hero-x870e ([177.93.10.181])
 by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-52aef459c9asm8395330137.1.2025.09.05.13.53.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Sep 2025 13:53:54 -0700 (PDT)
From: Javier Tia <javier.tia@linaro.org>
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 3/4] Lindent: Remove wrapper around indent tool
Date: Fri,  5 Sep 2025 14:53:46 -0600
Message-ID: <20250905205349.127333-4-javier.tia@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250905205349.127333-1-javier.tia@linaro.org>
References: <20250905205349.127333-1-javier.tia@linaro.org>
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


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BFB4D2ED0A
	for <u-boot@archiver.kernel.org>; Wed,  1 Apr 2026 14:17:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A74FA840AA;
	Wed,  1 Apr 2026 16:15:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="aRqKC1BM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC5CC84127; Wed,  1 Apr 2026 16:15:39 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 135C283D8A
 for <u-boot@lists.denx.de>; Wed,  1 Apr 2026 16:15:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4888244e9f9so13427365e9.0
 for <u-boot@lists.denx.de>; Wed, 01 Apr 2026 07:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775052937; x=1775657737; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=dZJd8jcJ2QufDdsWwRqWjudJvGT1Zn2bs8g3ffveHCw=;
 b=aRqKC1BM6RqCKPdbXctnk3GSqQI6TgRJutRZFcKsXxPmqFjWwWB9B2PGHWDoPHI8dL
 OvAwyEeyrX1Cd0533YHdnI8vLRTmI8GD3oj+NodkqBv3OrL64vhKRdeyMLEb6So3fCjY
 hBx9BGkV8xiyr9TRd6ylI8xgyvf1RUanvYuEF9ax/PzdL1yj237IGE9Y7y3fxNqUmLil
 PJgR/NBQxpTCpcZX8Yuqz82leSzu6DtwpUVRO9LyQtljutE3Taoas3FmRyhCqyfGd0EY
 cD72x+kt9WPBLo59nzha4e9kX76rZ8Up4gQCO2Q2bCHznFAMqkhVqZK5I8sWOf+eMwyv
 /X3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775052937; x=1775657737;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=dZJd8jcJ2QufDdsWwRqWjudJvGT1Zn2bs8g3ffveHCw=;
 b=RlNaC1+TpMUm7YCj7YhXLkJWt8Uval8QTRENNy9bPksV/GgHaYMq0SCHhNNd32LRJJ
 xLHNFA9L6J8YdOt+NnnrgLXXu6jsMCpvOoh19t8o3xymqZirXiR2xWAoUqpXbnr+t7Hq
 M/Xt5KCEUI0ibyAy8Rni7lli8AEubO5l8SPwKTQHo4hi8roVQxdUrA/+S6XV03lqa3Zm
 JjbH+HtgLhGiNy3odAOlKcHgDuPx1raF2iwcIHB3SzhOKKSn5uW0QGOejhzUrshqLR7a
 q83ZUlC9dcdl0+SaP6+9mQd8nPeO4tK0jBICdZFt3ncUEw+bcC0E9LdP8PCyasfzNkUc
 UGvA==
X-Gm-Message-State: AOJu0YySyBQhh7ixG6DuQS8GlmpnpOgj5RsdX9juB4YDrin3Hqag5GUv
 fz3WVYdpi9UjcGU0gi4RcRW/u6V0CDUAkyY2magG2lJt4O5J7hWI3PnVKl7IVKUZG48=
X-Gm-Gg: ATEYQzz3cAHyhp4bxH+zKST/rQbsIQnSsKiy6yyQtqg3BU03Pl1+4XI6enl8ny6ZkFc
 gcC9c/9LdgJxIcW/YkClxCuYS4sc1mWQmqxYom6jF+1Hs/+90hG8Ygli9aUUrnoUQoOB86uT7kI
 oqBKJf4RIijrf20DrcWuODZqTDuOJYwLkxHtzeCdgEBS2Js3+CX5sNZFRRsHBglSXzzGTGiMD8S
 2fn3/kLrl4yw5XJ870gIE3UH5H8Eq02q4kIdc0chT74r14OO/KRoVEZUQnz3E2/RGA/gnNjb9im
 B9BNI2zROGP+ZC04YtVwTXvMbxfk6fGXs9rEntVWMEw4ON8r5D7KXWZ4b8DEfqbWUdaW5CRCm3C
 nZsDE847QZc+GSHBjkMVuMWz7Oh6XQ33EhREPND+Vfs5dSQ/2HgnVjdTCOaIE6kYDaBHc3Yg5za
 QZUtnBDfWTI9uYNMz+ZJgjmWU8TddMlLabFLvGy5aeuSxSV6K3An06wPZamLaJP0zc6RQR
X-Received: by 2002:a05:600c:1e28:b0:487:2092:b2e0 with SMTP id
 5b1f17b1804b1-48883569e63mr70615565e9.1.1775052937372; 
 Wed, 01 Apr 2026 07:15:37 -0700 (PDT)
Received: from lion.localdomain (p4fc3dd86.dip0.t-ipconnect.de.
 [79.195.221.134]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4887c8bcaf8sm43224135e9.27.2026.04.01.07.15.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Apr 2026 07:15:36 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Wed, 01 Apr 2026 16:15:26 +0200
Subject: [PATCH v2 10/11] compat: regulator: add enable/disable macros
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260401-casey-ccf-compat-v2-10-414d5b7f040b@linaro.org>
References: <20260401-casey-ccf-compat-v2-0-414d5b7f040b@linaro.org>
In-Reply-To: <20260401-casey-ccf-compat-v2-0-414d5b7f040b@linaro.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, 
 Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>, 
 Romain Gantois <romain.gantois@bootlin.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Raymond Mao <raymondmaoca@gmail.com>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=850;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=w43IAJ/GgxcdhAfepdgBnfs8T9pBTj4C8IelGrdXjr4=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhsyzGlXTdic8CFqycXKRyunSn81t30MfXj1y0Cn7xP+pH
 71tPiy72FHKwiDIwSArpsgifmKZZdPay/Ya2xdcgJnDygQyhIGLUwAmYhDMyDDTl1nSrmHfsQOX
 tSKt7Hq93z037dnM17otWaZ9RpCwljLD/6ycco9/wYXTu1auSrhUvjd499KHJ326C66fl8uvebv
 k3HkA
X-Developer-Key: i=casey.connolly@linaro.org; a=openpgp;
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

These just wrap regulator_set_enable() and provide a closer analogue to
the Linux API.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 include/power/regulator.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/power/regulator.h b/include/power/regulator.h
index 8a914dfc74f4..4011fb1d254b 100644
--- a/include/power/regulator.h
+++ b/include/power/regulator.h
@@ -358,8 +358,11 @@ int regulator_get_enable(struct udevice *dev);
  * Return: - 0 on success or -errno val if fails
  */
 int regulator_set_enable(struct udevice *dev, bool enable);
 
+#define regulator_enable(dev) regulator_set_enable(dev, true)
+#define regulator_disable(dev) regulator_set_enable(dev, false)
+
 /**
  * regulator_set_enable_if_allowed: set regulator enable state if allowed by
  *					regulator
  *

-- 
2.51.0


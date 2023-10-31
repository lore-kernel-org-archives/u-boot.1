Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC9E0C4332F
	for <u-boot@archiver.kernel.org>; Tue, 31 Oct 2023 15:19:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E149687B52;
	Tue, 31 Oct 2023 16:19:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="QPbXLGcA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B225087B81; Tue, 31 Oct 2023 16:19:38 +0100 (CET)
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com
 [IPv6:2a00:1450:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BAA6786C3B
 for <u-boot@lists.denx.de>; Tue, 31 Oct 2023 16:19:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-2c5039d4e88so83368921fa.3
 for <u-boot@lists.denx.de>; Tue, 31 Oct 2023 08:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698765576; x=1699370376; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=bnmq0t0mev2VE3Xp0nGdvAt+i65rh4b+R4V4F5XeAX4=;
 b=QPbXLGcAyXFW+CSCKKrXN49FJuIzM1IIQXrvrNrri8qPcqBeXBG65U/Q4baOU0FNlX
 youPOwVPbGnEaWqL5D2uGPbU2GXhISXo+JrVbwm202m0DVoRe89w9/GNJ7NbRHO/oxrs
 n1iEafrjrujyRHe86PXVfV0uhaWzStIQ/WgPY07MczYifVI5pdseE6uM0m14DNKHu8Gn
 EPTrscVGE+n/jSpfKzk2Cm5vZLSlnF21tubQn6aSiDEzOR9KZ64ODRY5cLaM9sQ4t2e0
 5VBApHYBNkKLNbHsdrmj5VSre7ftXiS72QXLWxwJn9b/UneCYSHbz8tAflE0XvujWW3P
 MRFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698765576; x=1699370376;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bnmq0t0mev2VE3Xp0nGdvAt+i65rh4b+R4V4F5XeAX4=;
 b=Cuy+PF/slTdI5Oh7zkWz2eLbB0pEA/Fu2ijDE/8TGRRGV2uyR8Q7JTqmZEFH6Vfrhz
 38iQEe9iOV6HRj9G3aEF4s6B9KsHsAUFuIooaeP90O6BE/jVl3O4Xpdno2VmEC+mr2/S
 IUqcPwIFB+y0XIZmNd5Vvj/lSRjAd9siHJTdrbuGqB54++M1efNs0+Mb9ZQPjBuKO6Fn
 gaV8YnodfGHU6uKozJ0OCAVAO7qy8L5HJTExsPrgty6DzxE6/TJNcpkvzesyLggb3Bpy
 xBu7vZ/iXSCez6I6iE4c/CodvyJI9rlo4w80wqb6XEHXee6Y4KCDzAM5jnecKtplIAdf
 kFXw==
X-Gm-Message-State: AOJu0YwXQanp30FE6kEKROdNr7UEn/luQwyGCAeKLJyJXoFXTp1AL4jU
 4zXHTYBYct9HDbrFKghGrpetyA==
X-Google-Smtp-Source: AGHT+IGnLADlRb8zbRW9RH0TRfsmC+hdQEg03sf9uibf+0vGC3jGqROnFzAUGWnA5qrNbWf3AffYpQ==
X-Received: by 2002:a2e:b5b0:0:b0:2c5:2813:5534 with SMTP id
 f16-20020a2eb5b0000000b002c528135534mr9082910ljn.51.1698765575411; 
 Tue, 31 Oct 2023 08:19:35 -0700 (PDT)
Received: from lion.localdomain (host-92-25-138-185.as13285.net.
 [92.25.138.185]) by smtp.gmail.com with ESMTPSA id
 b3-20020a05600c150300b004083729fc14sm1966909wmg.20.2023.10.31.08.19.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Oct 2023 08:19:34 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Tue, 31 Oct 2023 15:19:11 +0000
Subject: [PATCH] MAINTAINERS: update Qualcomm maintainer
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231031-b4-qcom-maintainer-v1-1-d905d73d8cab@linaro.org>
X-B4-Tracking: v=1; b=H4sIAO4aQWUC/x2NSw7CMAwFr1J5jUV+LMJVEIskmNaLJGBXCKnq3
 UlZvMXoaTQbKAmTwnXaQOjDyr0NsKcJypLaTMiPweCM89Z4izngu/SKNXFbx0jQuBBtKPYSfYQ
 h5qSEWVIry6F24ZnbuSZdSY7/JfTk7z96u+/7D9sX31aEAAAA
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Ramon Fried <rfried.dev@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: u-boot@lists.denx.de, Caleb Connolly <caleb.connolly@linaro.org>
X-Mailer: b4 0.13-dev-46309
X-Developer-Signature: v=1; a=openpgp-sha256; l=1347;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=IziIq8FurGLivrU5+zwvCd7a2t0l+A9BhbYALZBpiEg=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhlRHaTbLMLeO6A16BT827ai5+8hVzffOM6OZB05fSY2y+
 ntsW+3RjlIWBkEOBlkxRRbxE8ssm9ZettfYvuACzBxWJpAhDFycAjCRPVwM/zPCd7V80crntBbR
 U8qzluUzqOMKqSucIFG95sBOCe/lcxn+yi+aq3P0eLbF59UFayxu1MxnFrnfc9FZQqJ84XOuRzs
 ttAA=
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

As Ramon has been inactive for some time now, add myself and Neil
Armstrong to maintain Qualcomm efforts going forwards.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
I greatly appreciate the work done by Ramon Fried in keeping Qualcomm
support alive in U-Boot the last few years. However it's clear that
he hasn't been very active for some time now.

I am currently working on a large cleanup effort to modernise Qualcomm
support and enable several new reference platforms. To better facilitate
this and to handle Qualcomm support going forwards, make myself maintainer
of ARM SNAPDRAGON as well as my colleague Neil Armstrong (Amlogic
maintainer).

I hope Ramon continues to participate in discussions and reviews going
forward.
---
base-commit: cbba1b7766bd93d74e28202c46e69095ac13760b

// Caleb (they/them)
---
 MAINTAINERS | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index cde778bc4d3d..be3666d14047 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -567,7 +567,8 @@ S:	Supported
 F:	arch/arm/dts/am335x-sancloud*
 
 ARM SNAPDRAGON
-M:	Ramon Fried <rfried.dev@gmail.com>
+M:	Caleb Connolly <caleb.connolly@linaro.org>
+M:	Neil Armstrong <neil.armstrong@linaro.org>
 S:	Maintained
 F:	arch/arm/mach-snapdragon/
 F:	drivers/gpio/msm_gpio.c


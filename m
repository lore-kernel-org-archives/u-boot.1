Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D0C1D3B7E1
	for <u-boot@archiver.kernel.org>; Mon,  8 Dec 2025 12:52:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9BB6483B85;
	Mon,  8 Dec 2025 13:52:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="EuH+HPLO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 51EE483B43; Mon,  8 Dec 2025 13:52:15 +0100 (CET)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6A8B283B32
 for <u-boot@lists.denx.de>; Mon,  8 Dec 2025 13:52:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4779a4fc95aso34572005e9.1
 for <u-boot@lists.denx.de>; Mon, 08 Dec 2025 04:52:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765198333; x=1765803133; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=kd/klw+O1QDJbnhn04DOc3/KiCdWQhdnAZ4+goEaMIk=;
 b=EuH+HPLOdTYgt8wBV5OjbBookoZGj9kV3yo4/2anMg+7pXLyo4TBp2H+PSPY6E8ZQd
 8vyZX45TuFbxiULTOtYWwD6rUGOZiEPjvJH7uoeGKh6780xZVemaaPINj6ats+4oIyNP
 l6GcN7X0Nh44aHdrny6p54Njq+logVFPApQjwrdEy+viqwqGcu+MOECM1Bvf7vKaNngy
 OBK8AV5hBqDbisbyoNPIh/jVU65GOJPy9Z8OtnrL7ta/od844/iMUjcZnnc5FesGrtci
 6/bcbql8rV2nXHYoKiFuwDYRAzWlVMYXVZ7KFnkh4Cv4ZAFGFGMjToJ+w3kKoTt3FU7C
 Ei3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765198333; x=1765803133;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=kd/klw+O1QDJbnhn04DOc3/KiCdWQhdnAZ4+goEaMIk=;
 b=clnyxDCeE7wYRCmwjPHZZ72EvuWnunUoiwoYP+yT1Zo3Ws3Pa0Em2keJW6u5A3Z0IK
 wF0GyjXUL9ztqopUMKiwFcBuXTTZ3iUFtI4mEHYKiT/Ro74m2AQ0UeABdZkgFXXqovcp
 A0t9veWaVfKAfos/rZ+BkjDu8fWeKtkLeS+0pGNj/1NeCPHzvHzeD1a/UJd2BJAkfw6T
 Y3g02anyA1qQTQTTiZiKyPxyufLmVuI0l0SDH3AQlhqo9JOpd4fi7kcYs50pc5pGw4xI
 PP/Ds7M1Sp1UrvSbZn8QB+S+iOEo4Pj7Rk71OAOdlXIkrnMs38GuBHVYEhzySSKTboDZ
 KbPw==
X-Gm-Message-State: AOJu0YzoziAdKbYxMJ3f5j62xr/k1CDfIaYmzMDnC4v6wkBuSeJuNRAS
 r9oCAamsL6Ba/KXQc7ydSDDqahbdL6KsYSNn882was9JEnbeD0BryI9n7hysDaAYjco=
X-Gm-Gg: ASbGncu8gujz/ckoXCOUuRTB+dLMMj1XD15pJBkKXUo9ntVBUFwnmcAJEI3OLOh8lZq
 65IyADchzJRgP3DVn9U1sgFSscDNSPeRK+9ge8VGyy8Dgs68kOEiOm0kE/K6+wyNmS4PZBggeo4
 6NENF4B5qh7V2BqoWY1cwZKTk/GWRLYSYLffkkHvHiy+QnrLkQbP7PDXl1VYxgY4Z7KWqfCqitD
 xh3QzVmUmkeVwrz7YeN2hbZ/LqHTnBbKfnWU1kD9LHd9GZs3A+KLFIW+s1MFS4omx7H+kO/n47a
 PoGpjc7g6QZTMSQmyKo1ysxAC8Ba2NVOPR7Bsfx4giBOA4ccvzdzAW5pmpcDCgCcudnM7OwSW6C
 /bI7Ak+KEO+tFTsuCZib2clQboJyAYQ1FyNSFqEfseg+oNUP4IjlDtLaQ4C+fm+YRzGaMKfo+qY
 gHIcGBpi1hlpON3iMh7gnp+Sj03rvHXAMWmVVPV9Vx0GmmxFZtHQ==
X-Google-Smtp-Source: AGHT+IEyD9mZPZEg0+/lDVbpuDxhrrM4bZXcIg1liEAvRpBtffH+9xxXU6sUjO+XNnFOjuvTJ90dZQ==
X-Received: by 2002:a05:600c:8718:b0:477:a289:d854 with SMTP id
 5b1f17b1804b1-47939df9a42mr82006755e9.5.1765198332837; 
 Mon, 08 Dec 2025 04:52:12 -0800 (PST)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:f7b:b001:fd05:11bc:5c24:a865])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47930920b6dsm260113645e9.1.2025.12.08.04.52.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Dec 2025 04:52:12 -0800 (PST)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Mon, 08 Dec 2025 12:52:09 +0000
Subject: [PATCH 3/5] net: nfs: Add licence header
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251208-lwip_nfs-v1-3-1f5d31e15d00@linaro.org>
References: <20251208-lwip_nfs-v1-0-1f5d31e15d00@linaro.org>
In-Reply-To: <20251208-lwip_nfs-v1-0-1f5d31e15d00@linaro.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Benjamin Hahn <B.Hahn@phytec.de>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Adriano Cordova <adrianox@gmail.com>, 
 Max Merchel <Max.Merchel@ew.tq-group.com>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Andre Przywara <andre.przywara@arm.com>, Tim Harvey <tharvey@gateworks.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Michal Simek <michal.simek@amd.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>, 
 Wolfgang Wallner <wolfgang.wallner@br-automation.com>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>, 
 Martyn Welch <martyn.welch@collabora.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>
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

Add the same GPL2+ licence header to the NFS code as appears on other
NFS related files.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 net/nfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/nfs.c b/net/nfs.c
index 537d4c62de267527c85c5b1ddf2cda696f4ebae4..7bae7c78642cb33e5040c44ed9d0378222069923 100644
--- a/net/nfs.c
+++ b/net/nfs.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * NFS support driver - based on etherboot and U-BOOT's tftp.c
  *

-- 
2.47.3


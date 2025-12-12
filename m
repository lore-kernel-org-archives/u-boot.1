Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05C44D49201
	for <u-boot@archiver.kernel.org>; Fri, 12 Dec 2025 11:33:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F4BD83A5A;
	Fri, 12 Dec 2025 12:32:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="swAcQ1hj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 82773837F2; Fri, 12 Dec 2025 12:32:36 +0100 (CET)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 903F983045
 for <u-boot@lists.denx.de>; Fri, 12 Dec 2025 12:32:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-47775fb6cb4so8720415e9.0
 for <u-boot@lists.denx.de>; Fri, 12 Dec 2025 03:32:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765539149; x=1766143949; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Q9IIRVXl5D7GAI+zDivJqNpb5dKfsC30uVqquD52HiI=;
 b=swAcQ1hjFPbEovrlrdVmYtCHZ3sXh6zdyPklM/rw37p/Ne5yOMNt4sE9mLFy8yr9nc
 bhcKcY1T25yUdg7KIBaxX4OU6m/4PMzeGN2chgUleKkcq3mmyQsiE1EhCmAWXzhOSaz4
 lUepvSaljA1pnJTNxGkqHL8nUa/EYBfhlAap0OVzfBgZu33q5e0iQhWHyp3/0u88YGRK
 BUPawfACndNVK1aHOBkZrWNLHNueRxMSfmoieZhWo/bGQguYlBTJp+eSTUYv/dsb5LWx
 6SvSMNtz0h9I9407yzaIZdEzOSyPmuMQLRjNMgpm0itUK7GTjIuVEZHxUZTUqhcev+KE
 c5TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765539149; x=1766143949;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Q9IIRVXl5D7GAI+zDivJqNpb5dKfsC30uVqquD52HiI=;
 b=iw3tQC9fokjGRBmReKfP5rDSwWfC/BKnQz5bERjk6xY5O0NufKW7RW92g9B7dGupS3
 O0rgIpAh4ghYOFY/OdozMloBFmARWjoN1FJvjfLKCF6pDcWldGg4mI9pqSjb/rD/Rs9u
 1xM/O9Cgk4BNv5y+yxEP1S3+RzNoLi/ZZQXoIzPDU7bsjCQTpSydRW/EkPjfXVuHqLdQ
 NxEJxGbYx/QeZ4XW+UUllC1yk50pWtwCyOnJ6sIoqcWvdqiDxX35wz0GvVObYNSGHCE1
 fK+XpylBEKGymnfh0gt1P93CQ8AQoChINqZfNSZwxXbZDmIdZtGIjDrobcRbqQeOYxdw
 imuA==
X-Gm-Message-State: AOJu0YzrN4r4UbT3zGD7HNoaMEQF2xXlaKHZra2taM6WtAYtjBXNmHKA
 pNikyD5SpkhlmZjo3t1XQiHrEfSpkMpNzJW3aPLOn2Epdnoxp5myIrq2j5cvbcm9rDU=
X-Gm-Gg: AY/fxX6R9tYcnlFbBOysb/8pfexV4GZZFPhwgiLz2ayfPsDnxOf+WLsmJBWskVq2wmJ
 +iYJ+cJrIvQPOfpMVbKIUU3/NKxpDGAID9xjZlEuRPGtVCJujSq5sDHjel6/I1aBvb4KRuN5Q1U
 i/hhYUje6XgA9WZ7eIPSHMr1L3O5uJBGJXiN5Hhi7kAujoeWK/DSSGlrHJAm1kKx38NxK3Jz2ci
 2hLfPIUQWpwSHW+DhN+G+tz612MU9gUWJJFN1alBW6PGuEkNMOTVso29AKFkHjWSSd3AD/pMR4O
 /GC199762dT7ciyilLRB25ezEuOUX95o04qq5qka3qCQQ8FFj6xscHFHREWvLZLvLr3/FdvPBix
 oD02iKkjHA9tSQaq5CqPe9a3UV0go+Zglhfm78i11Gaih70bftlt4P1mQAGd6HTErpCSIVNFML6
 kB0mBjc9MQ0J9709IN4+krIfGkeXXHpMlzVzRGy0i7ZibRn+g01A==
X-Google-Smtp-Source: AGHT+IH1ks3bGEWPODdpWp0NPjMORHCUWGeCpOWqaSChBcsf0ApZweE+qlKd1/kgxiuXfQq22mMYpg==
X-Received: by 2002:a05:600c:8284:b0:477:8b2e:aa7d with SMTP id
 5b1f17b1804b1-47a8f90e53cmr17900655e9.30.1765539148745; 
 Fri, 12 Dec 2025 03:32:28 -0800 (PST)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:fed:3801:9287:1e8a:f239:8d00])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47a8f8f39c6sm26277235e9.14.2025.12.12.03.32.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Dec 2025 03:32:28 -0800 (PST)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Fri, 12 Dec 2025 11:32:26 +0000
Subject: [PATCH v2 3/6] net: nfs: Add licence header
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251212-lwip_nfs-v2-3-9cb5a60520d8@linaro.org>
References: <20251212-lwip_nfs-v2-0-9cb5a60520d8@linaro.org>
In-Reply-To: <20251212-lwip_nfs-v2-0-9cb5a60520d8@linaro.org>
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
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, 
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

Acked-by: Jerome Forissier <jerome.forissier@linaro.org>
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


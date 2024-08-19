Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEA82C3DA4A
	for <u-boot@archiver.kernel.org>; Mon, 19 Aug 2024 21:07:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E3AE88C19;
	Mon, 19 Aug 2024 23:07:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="hbnNMyA9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D14EB88C19; Mon, 19 Aug 2024 23:07:24 +0200 (CEST)
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com
 [IPv6:2607:f8b0:4864:20::c2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B503388D23
 for <u-boot@lists.denx.de>; Mon, 19 Aug 2024 23:07:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-5d59e491fefso2460821eaf.1
 for <u-boot@lists.denx.de>; Mon, 19 Aug 2024 14:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1724101641; x=1724706441; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=lnpF79nVfmNwKoHbtmIWtyTkJufxa3B/Xq7sX/KEJ7U=;
 b=hbnNMyA9HQoZZpYWZ4hZovUiNjglIHohH8Kp5sdoxv0OWy6Dw3rPqMoSKVbh4GrrZ0
 jZ7uElDSBvSBvvljdvUDW2jZusWc1Lce7byQ7CNihQenykWrnD2QlCjuk6Izx0uJmvod
 CCJrOKPNzSsSNYjVRnOQbmSXGtL6i3vP+jpwQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724101641; x=1724706441;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lnpF79nVfmNwKoHbtmIWtyTkJufxa3B/Xq7sX/KEJ7U=;
 b=YUWgDwZiZE3ZKzdGDUkhct8Sk5RVL2ToZo9NhAzUlVr6yO5iWnY35aeHJPV/kBWQih
 QAFumlTIlQ/2gwkFUYDjea4CkvFVO3lRGXSeAfRkqJ+orLMvHai8EL4GLi+TdjHvNUtT
 vxhtAqjtuZQE3vw4elIEFBT07E29kdIXEUhN87alDg8YlyiAwgoi6ZDe4CTDMc9GBITR
 srpkdnwWK5FcS1cbUXkyWsT0mg2B2o/75tcgSCWPf6hwLUMPTzxhdwFY2Z9pTK+aTZIx
 2uMxcVmHb7N3XADvOhC0dcLl4H6k81UCJHX4/kkGnsjwIxgW2DCPhPPV9nb5ORIR1q/U
 a3Ag==
X-Gm-Message-State: AOJu0YwZoGyk7doY/nv9oOlYsHQIvLk9B+YWloaHNRioQDaLaPdB31Y+
 tTcqeN83n/XAjAS5+xJNwceOGI/d59Q49Y1nZJ84lE5NGwbh5fO5mXpGPsDUJ/J9yyUx6JSIWlF
 z
X-Google-Smtp-Source: AGHT+IFLO/pll+1g74R1Tqvg7HbIxI+3XgXeqi/E/iRIaRqulYC9kxP6bgy0AIwIaHQNxeVmJy2tkw==
X-Received: by 2002:a05:6871:b0f:b0:270:fe0:b034 with SMTP id
 586e51a60fabf-2701c3df08emr12091429fac.26.1724101641462; 
 Mon, 19 Aug 2024 14:07:21 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net
 (fixed-189-203-97-236.totalplay.net. [189.203.97.236])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-70ca662064dsm2431341a34.64.2024.08.19.14.07.20
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Aug 2024 14:07:20 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 1/2] pytest: requirements.txt: Resync with the rest of the
 project
Date: Mon, 19 Aug 2024 15:07:18 -0600
Message-Id: <20240819210719.71747-1-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
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

In order to build the docker container, which contains a download cache
of python modules, we need to have our versions be in sync in each
requirements file. Update some of the cases where which are older than
the rest of the project.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 test/py/requirements.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/test/py/requirements.txt b/test/py/requirements.txt
index 2b1489808c00..75760f96e562 100644
--- a/test/py/requirements.txt
+++ b/test/py/requirements.txt
@@ -1,14 +1,14 @@
 atomicwrites==1.4.1
 attrs==19.3.0
 concurrencytest==0.1.2
-coverage==4.5.4
+coverage==6.2
 extras==1.0.0
 filelock==3.0.12
 fixtures==3.0.0
 importlib-metadata==0.23
 linecache2==1.0.0
 more-itertools==7.2.0
-packaging==23.2
+packaging==24.1
 pbr==5.4.3
 pluggy==0.13.0
 py==1.11.0
@@ -20,7 +20,7 @@ pytest==6.2.5
 pytest-xdist==2.5.0
 python-mimeparse==1.6.0
 python-subunit==1.3.0
-requests==2.32.2
+requests==2.32.3
 setuptools==70.3.0
 six==1.16.0
 testtools==2.3.0
-- 
2.34.1


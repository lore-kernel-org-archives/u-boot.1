Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FAB6CD8CB2
	for <u-boot@archiver.kernel.org>; Tue,  9 Jun 2026 19:13:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 90595848DF;
	Tue,  9 Jun 2026 21:13:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="obcmPu9o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B38484910; Tue,  9 Jun 2026 21:13:16 +0200 (CEST)
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com
 [IPv6:2001:4860:4864:20::2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E74998486D
 for <u-boot@lists.denx.de>; Tue,  9 Jun 2026 21:13:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-43d23173511so3943301fac.0
 for <u-boot@lists.denx.de>; Tue, 09 Jun 2026 12:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1781032392; x=1781637192; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=W3qSHm6IOzi6631E/PHsBgOeS3to6INMSS+RrcilEdc=;
 b=obcmPu9ot6kl2CkIa4yLwGJdaBxubPfmZf+92R1R8Pe096H9iNhLCJuHWixiULzRYj
 BTzOhwN45uxO3IGrgN0nmdK7KWf+yRtnPNd6RA96cIDUod1TcDqMMZ0hVRJBxrM4mNQ3
 dYQSXDnY5yR+s9tusI/ks1f2zdjPSYi6sCrPs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781032392; x=1781637192;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=W3qSHm6IOzi6631E/PHsBgOeS3to6INMSS+RrcilEdc=;
 b=PESeiHFgTA2ekmlS2PWzPYMuNfYk3m5QcuBZwYzlpFXKkqSttSsRaFrZIkurHcRhG1
 HWNPrmSCYx+b6EhQTuv5fl1EJz2EXFeXz/lzFai/fbQ1xUV77JGCCZ+ymvt6eC5dxyr+
 5hSrYp0RHAFD+qOMWMINuOBV/SmkD//ABthXyIVkNws+R/PV2ROA2JC1w+7sE839WL8V
 eC/KrS1sZNfgi1vTLwlub2RuDRq0A7zV6I87QXC21SUhqo90DMkGN3ckPW5/lx8V1/wg
 AQY+c9FpUdYrhQ7Om4wPO/8RogdXUVOYqOYqdw47RqiAtjqiIq4X6J+Ak27s8HUGscb9
 XM0w==
X-Gm-Message-State: AOJu0YzSS2MQZudr+w4Mo3JIRI4SLVir95sLSK2KFIN5MUaPxTLIqeK6
 S8AhGOfTJcJ8lsuWoK1Ay1H9wD5JKotgnhj4bBlSApZpu3aAZ6Cxjr3OPtz4Ft0AbbRrCyCJM3R
 Al4scaHI=
X-Gm-Gg: Acq92OGWk0y3HrwI571qRxwhvDwI051qjtycKRst6vesRnlONmrlf6l8WOKmm5R50NM
 +/Bx7nvDGf/t7Q0N4XFUvFphm3mHnraOhdtuiAqUiPC6pgiwYtrD3CDlmGVZ3UnbKLYMsz43lcF
 aOOhk5/Q1mChtmw/8wcjx+5C+gUWPEEHLo/ojP27EZzZdmNX2w79+VWc1zRDtgCYEGPh0qVJFLU
 aGheg53Tq0sFsqXwXth6QFrCxQAw5TFskk9wrnTqBOoylGvdpDPPCPriLGkKSkRVQumUitc6pGU
 sV5FsZFuRaIQe1jctgG2pTROfNVxTXz6cwoSff5YlHGKzBWub+eCja9wXRTutAoEjy8ZM7IkkZC
 CQ0YTtRM0XaSqd4Z0o+q3BFqORdezZIeQFL+0X/06neHXgpPu+Ce/q3Gxo5okD2eT7HNfHOB/C0
 7lp07QvgzhfU5BSm4P3st412PN+EzLhlmVvmqrCjgyidSmWA3iHyvDYpQsjSc+DTSijub60E02c
 jcFYOjVJsyGyMWEWCjvEKn8obmYxU+Ar/bcKk27N9o3WmbLoE6pT6kJlhf/3T8Qpt0fXVxY+ySC
 yRVta4nm9A==
X-Received: by 2002:a05:6870:b208:b0:43e:5d18:e7e7 with SMTP id
 586e51a60fabf-441ed8e4e3emr2774442fac.25.1781032392628; 
 Tue, 09 Jun 2026 12:13:12 -0700 (PDT)
Received: from bill-the-cat.tailc58245.ts.net
 (fixed-189-203-106-235.totalplay.net. [189.203.106.235])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-440d7b928efsm17742771fac.3.2026.06.09.12.13.11
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 12:13:12 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] CI: Sage: Pin to labgrid 25.0.1
Date: Tue,  9 Jun 2026 13:13:11 -0600
Message-ID: <20260609191311.3800039-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

With the recent release of labgrid 26.0, we need to pin to 25.0.1 for
the Sage lab until everything can be upgraded.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 .gitlab-ci-sage-lab.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.gitlab-ci-sage-lab.yml b/.gitlab-ci-sage-lab.yml
index 176d281868bc..e2f368486047 100644
--- a/.gitlab-ci-sage-lab.yml
+++ b/.gitlab-ci-sage-lab.yml
@@ -26,7 +26,7 @@
       . /tmp/venv/bin/activate;
       pip install -r test/py/requirements.txt -r tools/binman/requirements.txt
         -r tools/buildman/requirements.txt -r tools/u_boot_pylib/requirements.txt
-        labgrid setuptools
+        labgrid==25.0.1 setuptools
     # Acquire and turn on the exporter.
     - labgrid-client reserve --wait board=${LABGRID_EXPORTER} &&
       labgrid-client -p ${LABGRID_EXPORTER} acquire &&
-- 
2.43.0


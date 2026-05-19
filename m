Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 092C8CD4F5B
	for <u-boot@archiver.kernel.org>; Tue, 19 May 2026 13:45:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5FE30846F2;
	Tue, 19 May 2026 15:45:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="t7acITnp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F775846FA; Tue, 19 May 2026 15:45:47 +0200 (CEST)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0FB88846F1
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 15:45:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-7e568ab0bc5so4064737a34.0
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 06:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1779198344; x=1779803144; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=vrX1lY9PulHh9RysdDBEMXoOauSXO8BqBKbpIHsoI7o=;
 b=t7acITnphYMIXPZ+BoyYGiL+Qi1vs9z+osM2mQBNeZlB682bOeueNHnrXH/DKOQkTO
 DXnte5XyfcVlUMPQGV9/PggKv63TJ5YoJ+q/4PJ1sD+ZRCDpwBxMCWBDYMRv3T9ZpH89
 m5TRGPfC7u4rJcZFxVy7wsPNygWz2kDBTbhE0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779198344; x=1779803144;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vrX1lY9PulHh9RysdDBEMXoOauSXO8BqBKbpIHsoI7o=;
 b=Lc7pOcgBJwysjVDZFHdWbS+XDCILz6FjWw9M7AIqca9BUJYLTnu9MEr+NfYRSyUIyl
 n+hjOE3VJZxFycEcxFvWfZzXWiVcDD7Ucli+WEm1LRLizW9zoklwDkjQM+0nQ78Qw+6d
 5fwn1fVRoisP1yraDRJRb6fguTaZE+DFGxSlbWNfHsdw02Jiny6Q8IlyDSm0TN2zf007
 ZrtWyOrsUPqS5wydOctnmaB9sUSw+uKUZ1S0Cf3W8JRK8hGneTV8GHZ2U95ziy2Cf7Ez
 wj//gvJ2bnLUh8YHH1mZUA0g1oDQzwn439ZB+QmD1BrVZnrYBwf2/Q2yN/bQa4yH+Eed
 dELg==
X-Gm-Message-State: AOJu0Yx7Qz2RkoclW3ldr7fUpmsgSCU+AU0o10MD73BZMKe0XB+YpaNy
 3TcGbsJRNJPepQCXlPbcLFuJiJDiAHn30EeVhTjmb7/e7DPCPVuFSDKq0vpS2reHcxzJjeoS593
 bnlu+NwOSpozv
X-Gm-Gg: Acq92OEKTIXDqfCOw4tygfr5Lo0PGLqhPosFj3ldHrUIuV8qIAKROYvyXREhz5jcsks
 IjFM8I7ARSMMmQ0gnS7Keiel3UXdjgGC6Xbt+FVId3sjtcPQR6ltUeuGm9QLZGLp1LsrQk70/W1
 lj5QQGbh65TvGVVdcoydXd5IXmg8jNZlD3eakr2DfjwZOr7t6hj99ZkNHIXIBX3lKQtRfw63JQr
 k3lwZSxmlBGcwmNP79HcYLDDzcUGN+5ry2uaTLz7E7RCtdMB5+X7a5KRpkt6CtrqaylaGCmEjT8
 0/lp33+pn0cKJUjhLByg/X0Wosa0Pi5Gx0vB+U1qfecD0qtUyo7+VrOKR0e2nR9n3WmNOWP9cDW
 tEmN3Ebo8EVgrfDt4YRdFn6CWXI1fIoIz54Db7Y8Cee+NHU4zvor8xghzf3HeWlcm2VafMpq4b/
 GNGKytgj2tfLI+jT2GQMNkG9qyd7vNSgOG5AYDnBUF3YnhckzJ5K8Jsyb4+m/U5js73jA65Tu8p
 lYodBERdvGNiigtlR0w1u7PYf87dXYZZWBiud7k0+62IfreortRQES688mnEUSnr12GGiE0XqQ=
X-Received: by 2002:a05:6830:658b:b0:7db:a297:9e62 with SMTP id
 46e09a7af769-7e3f1030402mr14184871a34.8.1779198343701; 
 Tue, 19 May 2026 06:45:43 -0700 (PDT)
Received: from bill-the-cat.tailc58245.ts.net
 (fixed-189-203-106-235.totalplay.net. [189.203.106.235])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e55b7cce95sm10949888a34.6.2026.05.19.06.45.43
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 06:45:43 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] doc: Update urllib3 version for building
Date: Tue, 19 May 2026 07:45:41 -0600
Message-ID: <20260519134541.674893-1-trini@konsulko.com>
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

The GitHub dependabot tool has reported two "high" priority bug,
CVE-2026-44431 and CVE-2026-44432, with this package. Update to the
patched version.

Reported-by: GitHub dependabot
Signed-off-by: Tom Rini <trini@konsulko.com>
---
 doc/sphinx/requirements.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/sphinx/requirements.txt b/doc/sphinx/requirements.txt
index c616c75fefc1..20a99005d71a 100644
--- a/doc/sphinx/requirements.txt
+++ b/doc/sphinx/requirements.txt
@@ -23,4 +23,4 @@ sphinxcontrib-jquery==4.1
 sphinxcontrib-jsmath==1.0.1
 sphinxcontrib-qthelp==2.0.0
 sphinxcontrib-serializinghtml==2.0.0
-urllib3==2.6.3
+urllib3==2.7.0
-- 
2.43.0


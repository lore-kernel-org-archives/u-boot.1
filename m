Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE013E7718C
	for <u-boot@archiver.kernel.org>; Sat, 21 Dec 2024 16:46:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 27B16803A9;
	Sat, 21 Dec 2024 17:46:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="K7SN+2UI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7566F803B5; Sat, 21 Dec 2024 17:45:59 +0100 (CET)
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com
 [IPv6:2607:f8b0:4864:20::82a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3BD5580381
 for <u-boot@lists.denx.de>; Sat, 21 Dec 2024 17:45:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82a.google.com with SMTP id
 d75a77b69052e-4679eacf25cso15567481cf.3
 for <u-boot@lists.denx.de>; Sat, 21 Dec 2024 08:45:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1734799556; x=1735404356; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Cq7naJui+dsJaDZT8Hffj8bYABJSKftmMulzz1/rbio=;
 b=K7SN+2UIwBcp9K7umUXpygi5c7bhTUl7jiup8/C/L0tfIeh1xLAhpJLcujSkTzilOP
 bTUcS2H4g1ObDxYTVXwT/5ecMna7AXCvbzNcUUCHLF9YEaSzzU8fm3mCLaRw+sU11Icn
 qEr5h7ym1Bea9tTPz6gRkSY+SbQzy2XGwVRsk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734799556; x=1735404356;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Cq7naJui+dsJaDZT8Hffj8bYABJSKftmMulzz1/rbio=;
 b=Nz49D3zmt5jqSRkBPVlKDARz7Tn6tBbb4U81dMjLoQBnfrc0llHRVgDt8yRG3p1QCx
 6FK8cpZvXeUr1QMFbGYpvI08X9a1rWsUbAaY5CuAQzoV+HTXhL6Cw7+SFQeFz9a/tsv2
 IgdWZfXT/Ii/0gJqkjT1RrXVmeXLeK+RSi451pmVEB+13pkcOYHP68LbJOcurlYwUIxW
 89UwmMf8OB4QDEkO1SZCTHne5UrvDA2V1boxnbAMcZjhCYFDWVPrR8VYwqtKXkteSj6c
 aQ9b6BVRNIXBP/NSVeqIEsn4MhEesxz/ck0L/epRR1/WjrpgU1mIE+b0aWxDtixQtG+k
 WjqA==
X-Gm-Message-State: AOJu0Yw/iEhrQ10Yif4K4b8ynD1KayBnvUDC9AscTXE6zeu1xg96ehmv
 lD6dTEGN5ifKFLJYRHhgkezMtBIggnrlSdXwjLM8/y43PqoSP25WnY+MQB8X/pNU6LxUaomT+F6
 RQy8=
X-Gm-Gg: ASbGncvHdZw7GPWijuKf5AM+b0C10VhFD+0z6IWZfFL8r/lEEx0R7lLpsWntpnomvvW
 +x2VtT8IaQo9/AYju0EqsN1RDIr8Fx98jAnZo4qTg5bJAtmCYMU5bofJq0XuUG2U5RIjW80hnVf
 x/89zaP+lENyDn51i2gP3Vb0oruFImdnrhbv9iUA3GLd8J/L0KCfgrY+xDXV6/r5cDa0Ssop3yf
 bxiUGzv+ShbxQnGLICkvw9/IMcrtWkMxSFpyr2BkBsPBknfY9fQV8VwNyuA8e2crYiOBNWrJPFN
 /VHD
X-Google-Smtp-Source: AGHT+IHYqGvSQmDvC3k0//FcDDx4MTCSN99ckpsEw/OAlb76YI1vtkNvdSp0IudG/0aEuudOTU9YwQ==
X-Received: by 2002:a05:6214:31a0:b0:6d8:9d28:ff07 with SMTP id
 6a1803df08f44-6dd233accfdmr126403456d6.45.1734799556070; 
 Sat, 21 Dec 2024 08:45:56 -0800 (PST)
Received: from bill-the-cat.tail58a08.ts.net ([189.178.122.190])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dd181d5adbsm27491016d6.115.2024.12.21.08.45.54
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Dec 2024 08:45:54 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] Gitlab: Add DEFAULT_FAST_ARM64_TAG as well
Date: Sat, 21 Dec 2024 10:45:52 -0600
Message-ID: <20241221164552.1836066-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241208190741.4192601-10-trini@konsulko.com>
References: <20241208190741.4192601-10-trini@konsulko.com>
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

Upon further consideration, we should have both DEFAULT_FAST_ARM64_TAG
and DEFAULT_ARM64_TAG values available. This will allow us to later run
a matrix of some jobs, such as sandbox, on any arm64 host and still keep
the world build to only fast arm64 hosts.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
This is inspired in part by that I was able to get one of the Always
Free Ampere instances on Oracle Cloud, but being only 4 CPUs it won't be
good enough for the world build, but is fine for the "all" jobs, as well
as sandbox, I hope.
---
 .gitlab-ci.yml | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index a7bae035319c..cec67c981428 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -3,6 +3,7 @@
 variables:
   DEFAULT_ALL_TAG: "all"
   DEFAULT_ARM64_TAG: "arm64"
+  DEFAULT_FAST_ARM64_TAG: "fast arm64"
   DEFAULT_AMD64_TAG: "amd64"
   DEFAULT_FAST_AMD64_TAG: "fast amd64"
   MIRROR_DOCKER: docker.io
@@ -116,7 +117,7 @@ build all platforms in a single job:
     - when: always
   parallel:
     matrix:
-      - HOST: "arm64"
+      - HOST: "fast arm64"
       - HOST: "fast amd64"
   tags:
     - ${HOST}
-- 
2.43.0


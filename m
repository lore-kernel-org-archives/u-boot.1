Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50BF3C25B78
	for <u-boot@archiver.kernel.org>; Fri, 17 May 2024 17:49:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA804884CD;
	Fri, 17 May 2024 19:49:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ahXyatbe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB5FC884E6; Fri, 17 May 2024 19:49:37 +0200 (CEST)
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com
 [IPv6:2607:f8b0:4864:20::72f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8BCA58818C
 for <u-boot@lists.denx.de>; Fri, 17 May 2024 19:49:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72f.google.com with SMTP id
 af79cd13be357-79305314956so61014385a.3
 for <u-boot@lists.denx.de>; Fri, 17 May 2024 10:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1715968174; x=1716572974; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=TThBCLuKrNo1fmwJIZ6G8FkxXHGHSpe24RgAGiSMQFI=;
 b=ahXyatbel121IuX6lk+HKUm/UiNdHD+O14NHtnDLj1sQTPvJEApxUmXrXXb0YSgODB
 tveF4BaI7UrdEhZqYc6h4+YRx4y4bFvrL4lLO/GTRnFfej0AvYD1Jmvc7lvUeQsn8p7k
 rxxyLUGfg1Xw6Qr7ctq7BaWkcc0WirwjUhDPY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715968174; x=1716572974;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TThBCLuKrNo1fmwJIZ6G8FkxXHGHSpe24RgAGiSMQFI=;
 b=ikn6GWNzYqcI92LmVeBlpb42cDbVsE1y65fDlBry/02sJFd27k8WFDq040JB1LKeYM
 ScEBDGwAhegNh3VRiiobFVI3ecP/4lyFl6aTsT6NbWprbnfRycxUONng+38WAtzORMxC
 7wh/mVLTN8sTCrYaVz6qCtuQ/2N4VjDGa/TH8VkLAFoojRHfyw9jg5hG1nHkBtwXP23n
 8dKPI6dT6CRtWHM0u4niKXNxsRBpi0Gq0Zy8F4xndH/BwDfCKxOPaYHj+EK/DFKpcati
 Et7RP0XOpdKlZ9DjbcdR8R4bOfi35CE79tOBVJHJD2bnp04KW2bQexucaeI83QVtxS4q
 A3/w==
X-Gm-Message-State: AOJu0Yyz82p7FWYh+lhde2eRYRJnfXidDOfiDkgu6kzXSXXZ9TdU7PIc
 yMLT7Hfy+8LaDa8x1INrXZSvB86HezRw8CEbJcehxl3QmdQDraV2XnZTsIqKY/8TXCrXtFIW/VR
 sRR0=
X-Google-Smtp-Source: AGHT+IEllxsHIJ7i0KdiX8ztmfIv37UCuKrQisDKhwq7gkJz1fRmVVCJ/7IJiPullW+tyZsOeOi0ow==
X-Received: by 2002:a05:6214:5246:b0:6a0:6eb3:6b6b with SMTP id
 6a1803df08f44-6a16823fe06mr313435116d6.46.1715968173838; 
 Fri, 17 May 2024 10:49:33 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6a15f1cccf3sm87724996d6.86.2024.05.17.10.49.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 May 2024 10:49:33 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [v3 1/2] doc: process.rst: Use subsubheading for "Phases of the
 Development Process"
Date: Fri, 17 May 2024 11:49:29 -0600
Message-Id: <20240517174930.1028063-1-trini@konsulko.com>
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

These sections which talk about the different phases of the development
process should be using the subsubheading identifier.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Changes in v3:
None

Changes in v2:
None

Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
---
 doc/develop/process.rst | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/doc/develop/process.rst b/doc/develop/process.rst
index 92477d05dd85..a66540a698c1 100644
--- a/doc/develop/process.rst
+++ b/doc/develop/process.rst
@@ -34,7 +34,7 @@ It is followed by a *Stabilization Period*.
 The end of a Release Cycle is marked by the release of a new U-Boot version.
 
 Merge Window
-------------
+^^^^^^^^^^^^
 
 The Merge Window is the period when new patches get submitted (and hopefully
 accepted) for inclusion into U-Boot mainline. This period lasts for 21 days (3
@@ -44,7 +44,7 @@ This is the only time when new code (like support for new processors or new
 boards, or other new features or reorganization of code) is accepted.
 
 Twilight Time
--------------
+^^^^^^^^^^^^^
 
 Usually patches do not get accepted as they are - the peer review that takes
 place will usually require changes and resubmissions of the patches before they
@@ -65,13 +65,13 @@ the Merge Window does not preclude patches that were already posted from being
 merged for the upcoming release.
 
 Stabilization Period
---------------------
+^^^^^^^^^^^^^^^^^^^^
 
 During the Stabilization Period only patches containing bug fixes get
 applied.
 
 Corner Cases
-------------
+^^^^^^^^^^^^
 
 Sometimes it is not clear if a patch contains a bug fix or not.
 For example, changes that remove dead code, unused macros etc. or
-- 
2.34.1


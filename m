Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77DE2C04FFE
	for <u-boot@archiver.kernel.org>; Fri, 17 May 2024 15:45:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 45B9988001;
	Fri, 17 May 2024 17:45:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qLiy8lWG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 758E488231; Fri, 17 May 2024 17:45:56 +0200 (CEST)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3CCEC87ECC
 for <u-boot@lists.denx.de>; Fri, 17 May 2024 17:45:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-6f0ecec6411so1032262a34.1
 for <u-boot@lists.denx.de>; Fri, 17 May 2024 08:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1715960753; x=1716565553; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=yi3n3U3657WepjSlq+M0prBCnyypkRXNmjJv7GaN2VU=;
 b=qLiy8lWGKh78cePg0Wy5dlmTYGIz66civV3QfsZ1wTC8TD25nHfWHh6V060YVqv+1+
 PUyx03duXRHRdUc1PRvS/PKe9sQm5hqwQJUiZWAJOqb09D4pHs97zhIABzMFetWxYztk
 2gx/YoaxV5w7YdNvaASHLeEDxs98v1qqbM9jQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715960753; x=1716565553;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yi3n3U3657WepjSlq+M0prBCnyypkRXNmjJv7GaN2VU=;
 b=Rvb+ua1j8yTULhCp/P6XiggQsedyTlUA/+aNqoeo7qKuqViO+LPFgKgt85onyDHuL0
 HraFXVoPrSy+YACF1IwuBEIMiGyJYAJQ4EskIK/BxZ3brYRDL6XMFMxVKjwa+AbDq1OK
 U2DZvs3LwlUfWPyJcPSC+TblMGcX9zmJxSJ/PhRChNDKawRNYyNZfqpn+2vlofl4gnzQ
 MEj8P5a9zEY3TgAoG9vl+RGrGl4gVnkqnC9JeYIRbkaMLbZoXu+4pL1Lwnr5a41vnKVx
 OwxyHM11zxfjFmiow6hnIpKjhPSR63XTxJV0CRjrHPZGx5PZgz9drz9tVrYCXldt7viS
 WdPA==
X-Gm-Message-State: AOJu0Yy9qQR510VEf9+DHY5LQfkCD7B2T/L4IuMN5xpFgWgJ3+kO2Eku
 0BPM91IugkAnnvsho2eTuixL4SStDmhtKoQGfu0ncuDPZHPc5bs3+O5UNeFbtveCTx6l9uEHBlc
 iX8w=
X-Google-Smtp-Source: AGHT+IELOrLdBwZB07zN646TPh0RIJi++ytPcy6TBr5y64IO28PiXHOvo7dmqql2f2/PjklmyvqLrA==
X-Received: by 2002:a9d:5d19:0:b0:6f0:e5d4:ccf3 with SMTP id
 46e09a7af769-6f0e91336afmr23377883a34.15.1715960752615; 
 Fri, 17 May 2024 08:45:52 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6a35384037esm33953326d6.73.2024.05.17.08.45.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 May 2024 08:45:52 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [v2 1/2] doc: process.rst: Use subsubheading for "Phases of the
 Development Process"
Date: Fri, 17 May 2024 09:45:48 -0600
Message-Id: <20240517154549.1020534-1-trini@konsulko.com>
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


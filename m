Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 378A9D262A8
	for <u-boot@archiver.kernel.org>; Tue, 20 Jan 2026 22:34:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC09583AEE;
	Tue, 20 Jan 2026 23:34:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="USUSdoXP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6CF6983AAE; Tue, 20 Jan 2026 23:34:13 +0100 (CET)
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com
 [IPv6:2607:f8b0:4864:20::341])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 218D783A3B
 for <u-boot@lists.denx.de>; Tue, 20 Jan 2026 23:34:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x341.google.com with SMTP id
 46e09a7af769-7cfd6f321b5so3473055a34.2
 for <u-boot@lists.denx.de>; Tue, 20 Jan 2026 14:34:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1768948450; x=1769553250; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=sKIXP1gRE0d0dU8hQdHpfkF9kYmL70znRPoELwnhztg=;
 b=USUSdoXPiLIJPRnsjk1pyHTQ8cEMIKqJNzEe4ntTFELUbBbWZfH8u+/OssD83QMdP7
 02NEUWl9EaUVQWp4rKwR/FpWYvFR1e4942oje3Jss7R+wpoJ/4p4cXg8f2I9AZwpUhtg
 aqyRiXsCfL/7+VgMuKDdC6YqsP6zDlL2EyFNE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768948450; x=1769553250;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=sKIXP1gRE0d0dU8hQdHpfkF9kYmL70znRPoELwnhztg=;
 b=kVFHldvaMlNcVFf3ySIEP3sSyGKeovdlN2Mj1/TChbuwIUDyR2S7OTFSrEV7iS8ejN
 ZeFjs2wvOnMJGwIdNo+W9bcdTu8FOaaS0FLoL+pRh2PdDdhq4tkrmo2NDOfD3/oUnAyp
 kRtVcEqO05q9u4nh3IgxzVAJS5twOfRdC6A772zpL2eVQQgGYH5+CppIcoZ0BWiM4ZIo
 59IDxnNLiVposwWEdk7xNVoMsbl6wVoowz7k2H82WuTNskNTux2GFs9eMwcX/EYdJqCQ
 IX882qzCqtnSzuwcNGuOV374ueyEEBRxrhekEd/Ij6YHlN2V2FrYUmsu4cScYrC8X/Dx
 WR3A==
X-Gm-Message-State: AOJu0Yy/FYKZKUEY4ZFFy0izPSauuX167X4DHm9PJOcObTvt5e7a5Phx
 OBnMZC7g+OtQ1TN0sXMCaDA6GEeLUCuN7uFiT15HBmkxUYywTvkSeqt0PLc5nD+pd/qkEpFEnoO
 cBQTmO0E=
X-Gm-Gg: AY/fxX4AJDH9VFukZkzmtfkF4R6SpAHO8kizOzYkVqZZa04GO+PHZZLs6Uvhnm+qgJo
 9st2QGkm9VIvFST6/4HXNH8SksH0Ez2+VXxAcH/WqAMcusvb0sWXzWVtyiQ05/TNmzFl74ci016
 CCPj54PyUdkjg4XaTQwK/Mt0U/IN1ifGwhcLOuRHmABzzrioOEtkGjWJySKh9dc8S6zlxGuJdSg
 6e7mMWYhX+LRLLwd0uQydGj7YBN6NgIa+EQgl/8wtknJe3GdFcYH8DrC9EERrM2CTvrGugreibt
 59ibsryfyA7Pgwvz0AzHoa2ko3Hw3tlckEU/Bpu3qOoc5ru+zKoG8gLkkXeZ9qStpA1v8o7MqGZ
 5FXN1s+rG0AXinMbnDjuqLl6YX4VpAv3fJ6G3k43n69zmJDvC0LV+qBnQSBCFcoW3VY8+V0veM9
 Fuvs/FiAtEF/ZyAWEjmHG0Y4nilyH7oyWQZhGZhCEcZe+5iCF5BSJYZZ3io2hB48/+ynNVum+Lj
 +P5fQgkDzlQC78CzgHg2Tz1RuwejMRa6cY9xCroFtUzQxAFvhKK
X-Received: by 2002:a05:6830:3986:b0:7cf:d038:efbb with SMTP id
 46e09a7af769-7d140aaf17dmr1897708a34.20.1768948449667; 
 Tue, 20 Jan 2026 14:34:09 -0800 (PST)
Received: from bill-the-cat.. (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7cfdf2b59e2sm9705687a34.30.2026.01.20.14.34.09
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jan 2026 14:34:09 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 1/5] doc: develop: process: Move Custodians section
Date: Tue, 20 Jan 2026 16:31:42 -0600
Message-ID: <20260120223405.469050-2-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260120223405.469050-1-trini@konsulko.com>
References: <20260120223405.469050-1-trini@konsulko.com>
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

Move the "Custodians" section to be after the "Review Process, Git Tags"
section, in preparation for more re-organization.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 doc/develop/process.rst | 82 ++++++++++++++++++++---------------------
 1 file changed, 41 insertions(+), 41 deletions(-)

diff --git a/doc/develop/process.rst b/doc/develop/process.rst
index 0651a1c23a48..3bda5e6b51dd 100644
--- a/doc/develop/process.rst
+++ b/doc/develop/process.rst
@@ -120,47 +120,6 @@ these can be "cherry-picked" and are subject to the normal merge rules. For
 example, a bug fix can come in later in the window but a full re-sync only
 happens within the merge window itself.
 
-.. _custodians:
-
-Custodians
-----------
-
-The Custodians take responsibility for some area of the U-Boot code.  The
-in-tree ``MAINTAINERS`` files list who is responsible for which areas.
-
-It is their responsibility to pick up patches from the mailing list
-that fall into their responsibility, and to process these.
-
-A very important responsibility of each custodian is to provide
-feedback to the submitter of a patch about what is going on:
-
-  * If the patch was accepted, or if it was rejected (with exact list
-    of reasons), if it needs to be reworked (with respective review
-    comments). Even a "I have no time now, will look into it later"
-    message is better than nothing. Also, if there are remarks to a
-    patch, these should leave no doubt if they were just comments and
-    the patch will be accepted anyway, or if the patch should be
-    reworked/resubmitted, or if it was rejected. However, if a submitter
-    feels it has been too long since posting their patch and not
-    received any feedback, it is OK to follow-up and ask.
-
-    * A custodian may make changes suggested by :doc:`checkpatch.pl
-      <checkpatch>`. They must also in turn amend the commit message noting
-      their change, for example ``[trini: Fix typos]``, and add their own
-      :ref:`Signed-off-by <dco>` tag. All other changes must be handled by
-      another iteration of the patch, or follow-up patch.
-
-  * If the patch itself can still be applied to the tree. The custodian
-    is expected to put in a "best effort" if a patch does not apply
-    cleanly, but can be made to apply still. It is up to the custodian
-    to decide how recent of a commit the patch must be against. It is
-    acceptable to request patches against the last officially released
-    version of U-Boot or newer. Of course a custodian can also accept
-    patches against older code. It can be difficult to find the correct
-    balance between putting too much work on the custodian or too much
-    work on an individual submitting a patch when something does not
-    apply cleanly.
-
 Review Process, Git Tags
 ------------------------
 
@@ -232,6 +191,47 @@ document.
   For example, when your change affects a specific board or driver, then makes
   a lot of sense to put the respective maintainer of this code on Cc:
 
+.. _custodians:
+
+Custodians
+----------
+
+The Custodians take responsibility for some area of the U-Boot code.  The
+in-tree ``MAINTAINERS`` files list who is responsible for which areas.
+
+It is their responsibility to pick up patches from the mailing list
+that fall into their responsibility, and to process these.
+
+A very important responsibility of each custodian is to provide
+feedback to the submitter of a patch about what is going on:
+
+  * If the patch was accepted, or if it was rejected (with exact list
+    of reasons), if it needs to be reworked (with respective review
+    comments). Even a "I have no time now, will look into it later"
+    message is better than nothing. Also, if there are remarks to a
+    patch, these should leave no doubt if they were just comments and
+    the patch will be accepted anyway, or if the patch should be
+    reworked/resubmitted, or if it was rejected. However, if a submitter
+    feels it has been too long since posting their patch and not
+    received any feedback, it is OK to follow-up and ask.
+
+    * A custodian may make changes suggested by :doc:`checkpatch.pl
+      <checkpatch>`. They must also in turn amend the commit message noting
+      their change, for example ``[trini: Fix typos]``, and add their own
+      :ref:`Signed-off-by <dco>` tag. All other changes must be handled by
+      another iteration of the patch, or follow-up patch.
+
+  * If the patch itself can still be applied to the tree. The custodian
+    is expected to put in a "best effort" if a patch does not apply
+    cleanly, but can be made to apply still. It is up to the custodian
+    to decide how recent of a commit the patch must be against. It is
+    acceptable to request patches against the last officially released
+    version of U-Boot or newer. Of course a custodian can also accept
+    patches against older code. It can be difficult to find the correct
+    balance between putting too much work on the custodian or too much
+    work on an individual submitting a patch when something does not
+    apply cleanly.
+
 Work flow of a Custodian
 ------------------------
 
-- 
2.43.0


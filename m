Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63DACC982F0
	for <u-boot@archiver.kernel.org>; Fri, 16 Jan 2026 18:23:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E31BA83952;
	Fri, 16 Jan 2026 19:23:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Awmyq+bm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4634E83956; Fri, 16 Jan 2026 19:23:43 +0100 (CET)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1AF83838A5
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 19:23:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-7cfd53a8c31so1544641a34.1
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 10:23:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1768587820; x=1769192620; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c+Gdpebc1QkyzNIS/yJFnF4ByiQVtKx4D8+CUIWYeFU=;
 b=Awmyq+bmF3AZoTZ0DSfbYO9Fj+WVFH4IK9yZhzTVOinPmQjsTypie+F1qdpgwPuIWR
 Rtu1AJK15hIDAxilJsRKNjrspeB+HggoIS5+sxMK8EU50hUciXaYjHBmbFYM6IjTQjdM
 qOrmiKgsTOZ128Q4me8J/AWuKgcVMHixpFLD0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768587820; x=1769192620;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=c+Gdpebc1QkyzNIS/yJFnF4ByiQVtKx4D8+CUIWYeFU=;
 b=cUwVFKXfzDbMqJBGq4IShnDDlgb78UVDIKgTjdOMiwSTmDfkF9goBaFrffAxBvT23S
 BmzV+Zk0XRLH/QxejC2lN8wU1JiWidb6j+5I9EbcC8/khSvAbhCL0RJCGWa5VFehzbyo
 YZ8QlMlnYh+PbHKZAd0IrJZMFbGf+aNCKdMOho4Bh/FzhkPiiUa/ZbYWqpEpuQfT6ZGU
 pjvYXwdbrZdjSslu+6l8HeZ7tgCMrJBOwjMGLS5l3ogiVx7t2YZyLti5Fvdt7R3ZEF7m
 LQgQNoEPJBn1l7m8k9dH4CmlHCJp6aVwYW5tWq63yirlfm0HLB+x+jFD9VjW08SYZGxj
 AZyA==
X-Gm-Message-State: AOJu0Yye3mZ3WpDAtG6S7hBYE/5tQWBLTouHcLdpKEnMRcIK4aX4vcf5
 vDEo1cR3EKIdagZdFlKQQWSCpLl4Fmd/i9Sl+vdx9G9kslN8anO/YVLCJXJfd/CDYsNSJa+DT4q
 IzLAxmv8=
X-Gm-Gg: AY/fxX4gmkfs4l8VG/4CvuESF93dWrXWyS3jaWLkDx3hohrzr129MxkShsveydO0Zra
 2GOAsOCtHQcvyhcYZ//odFlisOt7HI+16DbRvzuDAeBOm2H0gm9bXHI0rYRwIt6bF0wiz8WSe2E
 vHga7HnUBODD+WbeUU5bEtO0GqY4EHOwPgoN8qr7KqHImgrJe7Op0mWQ52kAfFpVBwbYDPzxldE
 vSt9/tMl+xcIKxhgDKrslExI3vtu92SZ9vqAcWzWoTCGI8aLa6w19fm8Kn0xH2VfIjgKYi1ijIY
 uCeQQM5oTy52Gx90a+D3kIuoZLeZ30gB+Dgb+k39N8ExFgKw59FpPoUEMHcYDPTHJs83JCitNa3
 lu0w9pSz5k6hQ5x4GgLDlPLFb4IDNfQoN8pZ2rEnAikF0v7EGuiGkYVeacALzRsagdriXR9tmZl
 rmoZGTAHnrwpzaeRK1RcYqifNSEBSrVl4CySKFlKMK9O8+k2iBs3vx4yWDUZibaxQI8+7dbemz5
 luOqh9Sur0Fsae2b8UT6BH7GXDfFf/keh4zJBAMsw==
X-Received: by 2002:a9d:4c84:0:b0:7cf:c8c4:366e with SMTP id
 46e09a7af769-7cfd45814ecmr3350755a34.3.1768587819839; 
 Fri, 16 Jan 2026 10:23:39 -0800 (PST)
Received: from bill-the-cat.. (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7cfdf28ef44sm2152994a34.18.2026.01.16.10.23.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Jan 2026 10:23:39 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Quentin Schulz <quentin.schulz@cherry.de>, E Shattow <e@freeshell.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH v2 1/3] doc: develop: process: Move the existing block about
 patch application
Date: Fri, 16 Jan 2026 12:16:48 -0600
Message-ID: <20260116182335.4081828-2-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260116182335.4081828-1-trini@konsulko.com>
References: <20260116182335.4081828-1-trini@konsulko.com>
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

We have a long block about the expectations and feedback about a patch
applying, or not, as part of the Custodian workflow. Move this to the
Custodians section from the Workflow of a custodian section.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Changes in v2:
- New patch.
---
 doc/develop/process.rst | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/doc/develop/process.rst b/doc/develop/process.rst
index 4bfbf0eb9c63..81e1aa7e34db 100644
--- a/doc/develop/process.rst
+++ b/doc/develop/process.rst
@@ -143,6 +143,17 @@ reworked/resubmitted, or if it was rejected. However, if a submitter
 feels it has been too long since posting their patch and not received
 any feedback, it is OK to follow-up and ask.
 
+Another form of feedback is about applying the patch itself to the
+source tree.  The custodian is expected to put in a "best effort" if a
+patch does not apply cleanly, but can be made to apply still. It is up
+to the custodian to decide how recent of a commit the patch must be
+against. It is acceptable to request patches against the last officially
+released version of U-Boot or newer. Of course a custodian can also
+accept patches against older code. It can be difficult to find the
+correct balance between putting too much work on the custodian or too
+much work on an individual submitting a patch when something does not
+apply cleanly.
+
 Review Process, Git Tags
 ------------------------
 
@@ -236,15 +247,8 @@ like this:
 
    #. U-Boot Philosophy, as documented in :doc:`designprinciples`.
 
-   #. Applies cleanly to the source tree.  The custodian is expected to put in
-      a "best effort" if a patch does not apply cleanly, but can be made to apply
-      still.  It is up to the custodian to decide how recent of a commit the
-      patch must be against.  It is acceptable to request patches against the
-      last officially released version of U-Boot or newer.  Of course a
-      custodian can also accept patches against older code.  It can be
-      difficult to find the correct balance between putting too much work on
-      the custodian or too much work on an individual submitting a patch when
-      something does not apply cleanly.
+   #. Can be applied easily to the source tree, as documented in the
+      :ref:`custodians` section.
 
    #. Passes :doc:`ci_testing` as this checks for new warnings and other issues.
 
-- 
2.43.0


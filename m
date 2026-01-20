Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61663D26296
	for <u-boot@archiver.kernel.org>; Tue, 20 Jan 2026 20:13:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 379C983A8F;
	Tue, 20 Jan 2026 21:13:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="RFe11pFX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A771683A2D; Tue, 20 Jan 2026 21:13:36 +0100 (CET)
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com
 [IPv6:2607:f8b0:4864:20::243])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C40AF83A2D
 for <u-boot@lists.denx.de>; Tue, 20 Jan 2026 21:13:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x243.google.com with SMTP id
 5614622812f47-45c83c49213so3773305b6e.3
 for <u-boot@lists.denx.de>; Tue, 20 Jan 2026 12:13:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1768940012; x=1769544812; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Da1pADGq9t9qh2mUuaIa1qECMCgH4x66woxGZ3dvIBk=;
 b=RFe11pFXTuJj6XfF8IQ7L6ReL6u/DtiZU3Iiks40dlk13SvchhdZHoHbsL48LPPaYK
 X/2LKsOSCx5BHVr+EFnRyVjdZjTJtMIAeQZqLIbXUJiYAa77KJl5M/D1TssmXSY9hQTp
 +kOXc+BM+R5QYlbS8muLPPXlvqYmFPT6Ljchw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768940012; x=1769544812;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Da1pADGq9t9qh2mUuaIa1qECMCgH4x66woxGZ3dvIBk=;
 b=wce58GDV4BBGNsaQ3ZEa/4VRTIsbpxSSXTuGlCQM+vi7bYk3OGK03PQlkAKV+N0jfu
 zrN8f8TJgyqNTKqkHeuc+xJJ8Xpvq2fKTRRg4lhZLde/3LAqEYsfLJwcx3rCXRPnX6T0
 SAubkudwlNkXUOAgLfBjrR8ruc1xnZj4yXgEZv76b4GQoZHCSCQUhD0Wz3b8uS6oF0uf
 cawLtaocnx5OsJ1OSBISeYaeOrHGDtt8141vJYm0ugJ6UhdgTsAFZOzRLNjhgzbr74kn
 w3mPdccVghcuhpLDRYWj4ykLNShlOBItOSn1B5sjKsWpOYVjNBRfTLAwLJ6iEkB9wQpE
 Zy5w==
X-Gm-Message-State: AOJu0YyQc+Wo0vv9SWP5iKjO5fkhfdmqDwyRmBfSQ7n+HZQHQlczpESX
 8PfKzDojaNqpwlCJA0Dvx6EkBzLansptb2+xEi206EzhG+FaCRgagwTCfo3uP3rdOJ8R4oTzK4l
 SOk+TmhcZpw==
X-Gm-Gg: AY/fxX6LGbHziLKfco5lfVfyxY66kxdtyVDQG0/nTNx3lA2PvKWvgTUle/L/cjPGwAk
 UUG2MgrQvtREIJhSdQDnHT0gLGkL/aOLM1DeeJmNf+48SUIKNmwOIkCxVn98twCN9kxpruq+Kzf
 8LQFJow46LQuQZStdnvvvS3PiSvsBZ45rWXpODwawR5ZfIqNJr3dqqRyvE9jC7ufyTHJu+rHskO
 XSZ3w3hyvzU4WMuYmFbCq9I5VPULxd9QIwNcX0RQdGUbbR7QpMDlVAmuA5yfgpSVTYYcIgKiYE8
 i1KOpuN1ZzOudMq71bYt2cl51yKAs+bjh4UOuyJshKfATQPUMPTS1eNkFyD8hkb994DRI6kDeEt
 loPNhNhEr1dQbqlbONFkPqeF7LKGB5KdlD1wBEx3Y/5Fw5dxwDS/8wPrdkKYFhlV3qcCVu6Pvbe
 Uw6U2jkEiPRoZaPTki6YJ9Z6J25hBBldPs6N+9CTfJXjQXe7PDkUiddvR0CyQ4t/c6padGk4F/7
 B4C9MEh/y414ftx2ObkWfLu02kARXYuQW3PUGLTOA==
X-Received: by 2002:a05:6808:1186:b0:45e:8536:41d6 with SMTP id
 5614622812f47-45e8536445amr1880767b6e.58.1768940012564; 
 Tue, 20 Jan 2026 12:13:32 -0800 (PST)
Received: from bill-the-cat.. (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-45c9dec6619sm7417337b6e.3.2026.01.20.12.13.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jan 2026 12:13:32 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Quentin Schulz <quentin.schulz@cherry.de>, E Shattow <e@freeshell.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH v3 3/3] doc: develop: process: Explain when/how Custodians may
 edit patches
Date: Tue, 20 Jan 2026 14:11:45 -0600
Message-ID: <20260120201327.451872-4-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260120201327.451872-1-trini@konsulko.com>
References: <20260116182335.4081828-1-trini@konsulko.com>
 <20260120201327.451872-1-trini@konsulko.com>
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

As seen with commit d503633a3676 ("Revert "doc: board: starfive: update
jh7110 common description""), it has not always been clear what is and
isn't allowed by custodians, and what the expectations are. To prevent
further unintentional conflicts, document the limited cases where
custodians are allowed to modify patches directly, and how to do that.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Changes in v3:
- After Quentin's feedback, clarify that only changes suggested by
  checkpatch.pl are allowed without reposting
- Add references for checkpatch.pl and Signed-off-by
Changes in v2:
- New patch.
---
 doc/develop/process.rst | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/doc/develop/process.rst b/doc/develop/process.rst
index 4159a945707e..0651a1c23a48 100644
--- a/doc/develop/process.rst
+++ b/doc/develop/process.rst
@@ -144,6 +144,12 @@ feedback to the submitter of a patch about what is going on:
     feels it has been too long since posting their patch and not
     received any feedback, it is OK to follow-up and ask.
 
+    * A custodian may make changes suggested by :doc:`checkpatch.pl
+      <checkpatch>`. They must also in turn amend the commit message noting
+      their change, for example ``[trini: Fix typos]``, and add their own
+      :ref:`Signed-off-by <dco>` tag. All other changes must be handled by
+      another iteration of the patch, or follow-up patch.
+
   * If the patch itself can still be applied to the tree. The custodian
     is expected to put in a "best effort" if a patch does not apply
     cleanly, but can be made to apply still. It is up to the custodian
-- 
2.43.0


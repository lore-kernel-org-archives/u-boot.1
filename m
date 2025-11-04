Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1644DCCFA04
	for <u-boot@archiver.kernel.org>; Tue,  4 Nov 2025 18:12:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8816183946;
	Tue,  4 Nov 2025 19:12:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="SOuJFMbL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C01D8003E; Tue,  4 Nov 2025 19:12:28 +0100 (CET)
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com
 [IPv6:2607:f8b0:4864:20::c34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A50B83923
 for <u-boot@lists.denx.de>; Tue,  4 Nov 2025 19:12:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-656a67c0762so636953eaf.2
 for <u-boot@lists.denx.de>; Tue, 04 Nov 2025 10:12:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1762279945; x=1762884745; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Gpf/bC01qY5ndFwvPVApZCxs+143yr7LEQneybbt1Os=;
 b=SOuJFMbLUuNl/UjXnIvbWFFlabOJ5cINDh77kCnHbwwhUEzKAVmKnmp5h9T0Wu+Nna
 JfugZ3YF1qY4ZRoiG63BWDHrsJhKqJKmpETPdS/5ywbHAglZ1gtKb2jJAKEXvToKLGWZ
 i3MvA+gN46PDgfnLV+N+yjsLWaRnUnzmyXIHI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762279945; x=1762884745;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Gpf/bC01qY5ndFwvPVApZCxs+143yr7LEQneybbt1Os=;
 b=sl7x3M34SGWA2nitu7TwSeD+knb21tQTF21EOURjAdieW1YzvQA37OxLRoR8CT0+eH
 L5WE3VM/i58DEw1a+ODDJNu+c1cqPzqWaQcunr+wWtULlaRfIy0u4oA9U2lsaWltH5nQ
 8vV272qSlkVYgReEenFcQpIDqHzvkWYFBATleDfsCsTnaeN+FMC/AD4sF6r8F8xnyrh+
 9B/IQ9+l95BlRU+3ir+9GHsMeEGNepwNo1Kn+aroPoxpYwNFlgoxMH97KiJGZMmeCFM2
 9RGpbFUqzSHplaaQEKf2dMUl1eylY9L0BSZZqB4fmMKIZt3mrZH9IujjZ5dDqEpH9JP+
 ysmw==
X-Gm-Message-State: AOJu0YwkAabFoLyxCtIq1wQumxSkJJD4bQXudiqX5GWUnbz0XK2eRipQ
 OTGeMDua8+g2C6DDOP6/3FT3gVnwAmC5cb/lweYB0Qa5+g2574PHsUHFjDKsvOUF7SJu6gt+9JD
 fOOq8dyHA6g==
X-Gm-Gg: ASbGncsewvIIcufP0v/zxFBND8JN9IysMILYrvH4KZ728oe4ZqBQLbnBCPqirdL+Sdt
 4TDcLaXOdMBnA+mqe4qSr5dfKigfQWFCODU4g1DM5XayhKGOtFP3xzNZemlSGXjEpk80VhkV+sH
 EY0Tq9HRfR21cjEpDZhBn3/QfEBPyxyXr4sruulrigcJQOClz0jpN2H/+1fNHAF1V9qpNWpQEka
 2M7WmMkzkW8TYSTDMN9ZMpwsU+s6oF5Dj/hn6sHncVL8+U3eNOBtfDAj95MFfY8H0IXvjBVq0vO
 /FvhQGWpVz1HyBj6toB06CLSV34FJTSIa61GIndfD+4ZinWRaLeJivEmsvezOzr849t776xinTL
 IS56GtXTdb58ch+rVSbRt49NhtzfWFfh7mog5xumvySM0LdijgE+lwrTxmnD9Rd3DkpwDedllGt
 riiHouKTiNKzp6YSQhYv1+N5mG2HA87eV59EaSqL7imffxDrlBxVru
X-Google-Smtp-Source: AGHT+IGccakFF1NYJ4kpNcqJ9yax97FzN35jB0DxkO/vVvJwOH3QM/YhYRF5SVqrQCcAue1UmPCdxQ==
X-Received: by 2002:a05:6808:30a4:b0:43f:64bc:8b7e with SMTP id
 5614622812f47-44fed365430mr136893b6e.15.1762279944771; 
 Tue, 04 Nov 2025 10:12:24 -0800 (PST)
Received: from bill-the-cat.. (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-656b9eaac5csm138479eaf.11.2025.11.04.10.12.23
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Nov 2025 10:12:23 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 2/2] Gitlab: Drop vexpress_fvp from tests
Date: Tue,  4 Nov 2025 12:12:21 -0600
Message-ID: <20251104181221.3980984-2-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251104181221.3980984-1-trini@konsulko.com>
References: <20251104181221.3980984-1-trini@konsulko.com>
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

Now that we have a test for QEMU using transfer list from the previous
stage, there are two platforms testing this particular infrastructure. A
problem with the vexpress_fvp platform emulation in Gitlab is that we
often run it on hosts that are fast enough that we run in to a race
condition when trying to acquire the console and the test fails. Remove
both vexpress_fvp tests from Gitlab (they can remain in Azure) to remove
these spurious failures.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 .gitlab-ci.yml | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index a585ece8a0f9..56fcc77f7bfd 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -551,22 +551,6 @@ sifive_unleashed_spi-nor test.py:
     TEST_PY_ID: "--id spi-nor_qemu"
   <<: *buildman_and_testpy_dfn
 
-vexpress_fvp test.py:
-  variables:
-    TEST_PY_BD: "vexpress_fvp"
-    TEST_PY_TEST_SPEC: "not sleep and not hostfs"
-  tags:
-    - ${DEFAULT_AMD64_TAG}
-  <<: *buildman_and_testpy_dfn
-
-vexpress_fvp_bloblist test.py:
-  variables:
-    TEST_PY_BD: "vexpress_fvp_bloblist"
-    TEST_PY_TEST_SPEC: "not sleep and not hostfs"
-  tags:
-    - ${DEFAULT_AMD64_TAG}
-  <<: *buildman_and_testpy_dfn
-
 xilinx_mbv32 test.py:
   variables:
     TEST_PY_BD: "xilinx_mbv32"
-- 
2.43.0


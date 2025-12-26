Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4F40E8FDBE
	for <u-boot@archiver.kernel.org>; Fri, 26 Dec 2025 23:04:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7EFA383B34;
	Sat, 27 Dec 2025 00:03:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JleAs8Rr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9647E839FA; Fri, 26 Dec 2025 18:54:41 +0100 (CET)
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com
 [IPv6:2607:f8b0:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5D4D7838FA
 for <u-boot@lists.denx.de>; Fri, 26 Dec 2025 18:54:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=visitorckw@gmail.com
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-7f0db5700b2so6507760b3a.0
 for <u-boot@lists.denx.de>; Fri, 26 Dec 2025 09:54:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1766771678; x=1767376478; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BVLXJ67XnSSJEEYJiSh8qh1vjhK2+oqsYc9QG/pORd8=;
 b=JleAs8Rr+dZKTPmSeQK45VtKx1qQYeRtt+A/8Bti2hSjkJ+NBUCPxZj2ArABRf/1YR
 O+wHfTvxxgZ2FPZLYHFHxt8sV9v5cZ7xvGegYCliD2/YwBoQe4HQwci22/ZQWrGRzqs5
 upvaO5/vb4TBDOA4aD5KOKxN6HdGPcXNeyjw1bx3jcKMHAIPZBnuU1GbPGdY2kCbZGM3
 JLDztxTcvB+jx8//chWoGTZQiVdgStmaDWRccPRRMRSgkoYrs92lgTiMgwKcos5/4g0i
 wzDqulzyRLRcgexIYMyBBwti5/uiido8wGGRdzh6U1KmeFeiLzkT0TWFiUwXLgd4fXJ9
 C20w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766771678; x=1767376478;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BVLXJ67XnSSJEEYJiSh8qh1vjhK2+oqsYc9QG/pORd8=;
 b=qP8I9ZjEnIh9b3G6QU2143efK2pF7wSaTGH0ch7TCj0xrY7kV8slTePdcwv32GBUFe
 YOq3Vvkuf4BJp+CD7VFJKMP+zJTq/F4uW4eSHlVN/5dC1eiD6G6lhUW8v0lQwOIH0JzL
 bWkCZ13SsvvEj25crGUkW16uH7ZZhFh4r7P06HsX6oC09dpQtPBNfTXkBx9xhWIpVEh2
 jjnUUjTnACybtMvihYThVaw5CMk6Q+3QlQjufRs/0azLXZYpozRtb1O1rVvLGAdNdtmO
 mGQxSqH3AJDUGPRsIi5lP5/BOrWEDGuhpXCP+wKPzYJuxdat0a+V0EF72g0BGBlJgJA0
 sVqQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXKxrp+t1Hn4mvAGl4dyBcO7Kv+aIgoZ86wy7XBjA2FgMFsIrFAXZAL2WNjVQCtTrUMIDxiVVY=@lists.denx.de
X-Gm-Message-State: AOJu0YxxJN/jhHRQ5+/TFAusYYkkXrNWPw7xR4Z/d6hmggLioFynhG0C
 iQPfkdG7c6+lO7dX/y/tw1GuZT95SqSHqwK+qn2TWQGOXOFrBxvgvEw8eidpuw==
X-Gm-Gg: AY/fxX418s5JitG7/XpMCzuzs9K3P4nitEEmgoXdWNABJUpAbtyq6FGRr9MDxDgkszX
 5CuyayD9dXmCNR/wBmm/68YWHMIphHoJF4uDJgRx1UfuHJHBnHeFVvYPdzaK1KAEbDAAtb7r5TZ
 gWvcRxE9NjkTNzAa74gnIBr40JDFbPv3123cTvipmYKdIrkP0qzRW5t2LELz/otvq11JPeTRgwl
 I796Yzw6DAVp5gDs21/Wu46MW3Vddk1fXfiKjydAF1e/ysesDn4zJIE6LYv11TJm/ctB+cIeq+x
 8ih5zbp9wVTOIFzTsr1DVUJbT5jlhESUx3xciyP4QoVDHuBTMprunm6s6PXCxFVCRf3m4WJ5fwy
 OPuOUKNBlxPo+JONx8i3Au08EdjzyT1dSz6fu7mN9YHbp8xx9iHBblcabF7fg/m8OO8ZNIYqO2i
 7dWjoaop8Hs1nC5PK+eDKkcVjfkkuzY4je+aqjIaeVzGbc15IUfTCcDb9E3zNkoinvZZYq79Uce
 gwYzzAu2hW+Rk7bvEaLHw==
X-Google-Smtp-Source: AGHT+IF6jFCxX8oHzgxt8BMDvnMcp9FOoZ6/TyL6gd+vq7gGP7JiRJPKCp9xvBQX6EDav1dWTdCL3w==
X-Received: by 2002:a05:6a00:1bca:b0:7e8:4398:b358 with SMTP id
 d2e1a72fcca58-7ff6607b228mr18219021b3a.43.1766771677802; 
 Fri, 26 Dec 2025 09:54:37 -0800 (PST)
Received: from visitorckw-work01.c.googlers.com.com
 (25.118.81.34.bc.googleusercontent.com. [34.81.118.25])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7ff7e0a0595sm22463704b3a.44.2025.12.26.09.54.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Dec 2025 09:54:37 -0800 (PST)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: alison.wang@nxp.com,
	angelo@kernel-space.org
Cc: trini@konsulko.com, me@ziyao.cc, daniel@0x0f.com, jserv@ccns.ncku.edu.tw,
 eleanor15x@gmail.com, u-boot@lists.denx.de,
 Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH v2 4/4] CI: Add test jobs for QEMU m68k virt machine
Date: Fri, 26 Dec 2025 17:54:00 +0000
Message-ID: <20251226175400.1154417-5-visitorckw@gmail.com>
X-Mailer: git-send-email 2.52.0.358.g0dd7633a29-goog
In-Reply-To: <20251226175400.1154417-1-visitorckw@gmail.com>
References: <20251226175400.1154417-1-visitorckw@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 27 Dec 2025 00:03:47 +0100
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

Enable CI testing for the newly introduced QEMU m68k 'virt' board on
both GitLab CI and Azure Pipelines. This ensures the new M68040
architecture support is built and booted correctly in the emulated
environment.

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
Changes in v2:
- New patch to add CI testing jobs for gitlab and azure pipelines.

Note: This patch depends on a corresponding patch to the
u-boot-test-hooks repository to provide the necessary QEMU
configuration: "travis-ci: Add config for QEMU m68k virt machine"

The gitlab CI job has been verified locally using gitlab-ci-local tool
with a passing result. Azure Pipelines has not been verified.

 .azure-pipelines.yml | 4 ++++
 .gitlab-ci.yml       | 7 +++++++
 2 files changed, 11 insertions(+)

diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
index e4695f1c55b..41bba8ed0f1 100644
--- a/.azure-pipelines.yml
+++ b/.azure-pipelines.yml
@@ -518,6 +518,10 @@ stages:
           TEST_PY_ID: "--id qemu"
           TEST_PY_TEST_SPEC: "not sleep and not efi"
           OVERRIDE: "-a CONFIG_M68K_QEMU=y -a ~CONFIG_MCFTMR"
+        qemu_m68k_virt:
+          TEST_PY_BD: "qemu-m68k"
+          TEST_PY_ID: "--id qemu"
+          TEST_PY_TEST_SPEC: "not sleep"
         qemu_malta:
           TEST_PY_BD: "malta"
           TEST_PY_ID: "--id qemu"
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index e7234e003ea..08dbffc74bd 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -408,6 +408,13 @@ qemu_m68k test.py:
     OVERRIDE: "-a CONFIG_M68K_QEMU=y -a ~CONFIG_MCFTMR"
   <<: *buildman_and_testpy_dfn
 
+qemu_m68k_virt test.py:
+  variables:
+    TEST_PY_BD: "qemu-m68k"
+    TEST_PY_ID: "--id qemu"
+    TEST_PY_TEST_SPEC: "not sleep"
+  <<: *buildman_and_testpy_dfn
+
 qemu_malta test.py:
   variables:
     TEST_PY_BD: "malta"
-- 
2.52.0.358.g0dd7633a29-goog


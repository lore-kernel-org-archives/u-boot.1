Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38C27E77187
	for <u-boot@archiver.kernel.org>; Wed, 18 Dec 2024 21:10:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AFF4880241;
	Wed, 18 Dec 2024 22:10:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gxaZFxwp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3AB6280291; Wed, 18 Dec 2024 22:10:29 +0100 (CET)
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com
 [IPv6:2607:f8b0:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0161D8021D
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 22:10:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x132.google.com with SMTP id
 e9e14a558f8ab-3a817ee9936so299075ab.2
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 13:10:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734556225; x=1735161025; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=lW/cAblWWB2ELnMQuT0TcnkknEQlkHKIQMo1VNYwFaQ=;
 b=gxaZFxwp2Z6EpjT/PfcOBbPkBYx+RvZ7es+fLbqGhlil6yRDnJzsrEM3uZ/5IkhN/q
 Av2VUnUvytaMEF5GPMtSo9HWHpepRT98W4CfTp/QsQI+AzvEhCKHMWvoXntnsyz5i2eP
 9dctyLtfYxlDVhLmgWPV5bNBdkRY5IVDkwo0U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734556225; x=1735161025;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lW/cAblWWB2ELnMQuT0TcnkknEQlkHKIQMo1VNYwFaQ=;
 b=n5UWB91e8Mdj6Jmpey13WiGuNqOXiIxU2joROFnfjz7aNjbSBZy9ql9A76xBYPG8yZ
 i4dTDn/hFc28tC3UvqQVj5ut/Kz2qj/E69fQuCbUwgqzXkoYCenz8VdJ68526RM+JgjO
 +nyf+AUH76LV9NxflxBI/TjYuJY7JsH7k1JpzQWT486jeeqd9DhJpjX8QTNzh9WyJjGE
 gnZDv3UUw+cIV9y8+Ek+8OVDYRcW3kDu7AP9mTRCZ2hbLUvkV9EJCLzUjODA6VxKwvH+
 axwn6OjLUbj4Y/lcaDe1/1SL41vOsDPM1ml2bHNdBD6qVhiJhVwyOdfwHemaLSdnDM8K
 c/XQ==
X-Gm-Message-State: AOJu0YwgpQ3QUJf/3jO9IdAb/rX/URarW1k5Qf+zGhDjqeFvKKe5Uc7a
 CTJxjz8zUl5hmnmuXi+2AnsUHGZVe4m8prQT2S+h6jMExsfjbRZ3Y9KpFzTrq7+yc/vak8M+B9w
 =
X-Gm-Gg: ASbGncu2JTu/7tqkK7GvFCWeaGk6GNqNZOrANXQkWn8R0mF9YJH0YmfU+xCq7k36f9u
 nOKTWIElwdjzlKT9EXs5Kyj7LrPYa/qDjzJGDt6bhSHQ8ia2b6s8+fk7GJMMoMRrZoTjgRvWEZr
 qpvWUgUhNzN+OZKMKOezutdtNLiOmq7icDNgxRSRY0fPACLzOij5zJhXIIx1+fjwQwsMZGGDjr1
 /1pv84bfF5ypNkxgJApdjTdluEz19JI+uLd577HV4if0cTv/BIHMxEyPD330HMSMdFIaQOHZlJx
 nguTRh1VmcbMzaB0Hg==
X-Google-Smtp-Source: AGHT+IGLw28pf2HeEy1zobUA/sT/Vw9OJ/RlSLwefurIsOinTTDcNI0h+i1Six/f7I4g80oqOkxllg==
X-Received: by 2002:a05:6e02:154e:b0:3a7:86ab:be6d with SMTP id
 e9e14a558f8ab-3bdc4282640mr38704135ab.16.1734556224858; 
 Wed, 18 Dec 2024 13:10:24 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e5e3d5e833sm2449643173.140.2024.12.18.13.10.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2024 13:10:23 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH] gitlab: Add rock3a and 5b to the sjg lab
Date: Wed, 18 Dec 2024 14:10:20 -0700
Message-Id: <20241218211020.742702-1-sjg@chromium.org>
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

These Radxa boards use similar Rockchip SoCs and unfortunately have a
lot of secret code. Add entries for these so that they can be used for
testing.

For some reason the 5b hangs (for me) with any significant amount of
output (e.g. dm tree). The board currently uses this for DDR init:
rk3588_ddr_lp4_2112MHz_lp5_2400MHz_v1.18.bin

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 .gitlab-ci.yml | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index d04868a04e8..1b19da28861 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -715,3 +715,13 @@ rockpro64:
   variables:
     ROLE: rockpro64
   <<: *lab_dfn
+
+rock3a:
+  variables:
+    ROLE: rock3a
+  <<: *lab_dfn
+
+rock5b:
+  variables:
+    ROLE: rock5b
+  <<: *lab_dfn
-- 
2.34.1


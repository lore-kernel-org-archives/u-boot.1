Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA58FC5AD49
	for <u-boot@archiver.kernel.org>; Wed, 28 May 2025 12:38:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7661883ACE;
	Wed, 28 May 2025 14:34:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JLKyWMTK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C32383AEF; Wed, 28 May 2025 14:34:20 +0200 (CEST)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com
 [IPv6:2607:f8b0:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 474B183ACE
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 14:34:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2347b7d6aeeso29679275ad.2
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 05:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748435656; x=1749040456; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+ILPQb9IAJOAKD96AlLeWfB2KJ9RoLzZEmpy1Vz0SmI=;
 b=JLKyWMTKEI3D7Dri0O654FVYnP5R9ijJnyy44ZnORGzfysqkfi2van7o4I498cLGEH
 FzctgpAMcoMxv+IQwCeb0hGOVV7WYt9PQnqHyWUQgjxwamvBlKXSYZoDrSQD1nA5/+6X
 r4wodhLVKoynLxZnD0oRC4aqCbfgZgKAhfKbM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748435656; x=1749040456;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+ILPQb9IAJOAKD96AlLeWfB2KJ9RoLzZEmpy1Vz0SmI=;
 b=Nx47m3yUJqVYqSPZlnfuzqrDpN4w0AvFc2CbXvyAjJnYUxuzby60kQAnYgyqnnNDBA
 8SQ18tEbAzWmfby/mBwHeIQWb/+UVhM3zRZwq1GnpDnKsb2aVv07qoQlBi0iTjeb0mUV
 QCh3nx2yhzuP19FdMhzda0yAoP7j9FYjsite3Lf4hjf+0wIEi8A6ZmNvFHD8e5NdD93o
 qNxHHW8UoEpSkOD7JMyfYalgmyxgKNJL2N+5R8KHGR52o7GuHbsuEnEho+v32CdPuPVE
 WCLtAiWoKw7neUcfMTtxytfHnH/myCJnOWstkTcZ/Vc31Eiti4wTRxW1GFtClFhRnqhJ
 9uaw==
X-Gm-Message-State: AOJu0YwF2+tA7/2Xbw+HA2fcpTsa8OFqw18Z3DsCRu4htzh69Doev1kU
 tIukpd1jfVgWlZGKwZLlBwnWVhVwNWECDIKqK7WCdaqZlATf3HseHA+GqKGopXvg4Cx3JDF7Ffb
 agNlaieCM
X-Gm-Gg: ASbGncstttLprJ40q8lCv/LrHKI0nx5IupP9iHbigbuiTqz9ydZUxvUO1QJyGEv5OV0
 MKWMAsBQq46VR0MmXbnAciEkzCOvt19rtWsTGQ0//iaFOXVSt2I+3cMP6Da2VPjpHOergLftG/U
 xKqR9afyomnEydhdQ+Ib5d75u0MHEQhZSqrJrdfxY63HRq+23DPb9DanmeXqeNrhpE6/fjVH3lH
 CAzEYOA5kgrtTtfBzl7UneVaJxXq0iV79vLgc1GUVCRqcS5lRZN9wVhBpKSR59ZLfz73ldGOg6u
 gYoPo0DnPGinFKZKoU4gR/b9/alceYDHUa/aQ7RdRBKer7HW9kIhV4bWObljKnGMYxRwfkptgZs
 8mIG6dFZVDlve
X-Google-Smtp-Source: AGHT+IHXR+bfoX66xD1FYSIee9r5nu53boVqIP1mVFPqEtD9tc+tTQM4Tuevtemn9wCud0+sM3PPNA==
X-Received: by 2002:a05:6e02:b43:b0:3dc:76c6:436f with SMTP id
 e9e14a558f8ab-3dc9b7656abmr174819955ab.21.1748435645630; 
 Wed, 28 May 2025 05:34:05 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4fdbd4bb408sm205972173.58.2025.05.28.05.34.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 May 2025 05:34:04 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: =?UTF-8?q?Fran=C3=A7ois=20Ozog?= <francois.ozog@linaro.org>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Bill Mills <bill.mills@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Andrew Phelps <andrew.phelps@canonical.com>,
 Simon Glass <sjg@chromium.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH v5 25/25] CI: Add tests for gitlab and azure
Date: Wed, 28 May 2025 06:32:27 -0600
Message-ID: <20250528063224.v5.25.I321f53b875ffb594a569796509e64830b9f3fe09@changeid>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250528123236.1138632-1-sjg@chromium.org>
References: <20250528123236.1138632-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Add tests that check that SPL can generate a standard passage on ARM and
that U-Boot proper can accept it successfully.

- Finish the commit message

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v3)

Changes in v3:
- Add test for aarch64
- Add tests for azure

 .azure-pipelines.yml |  6 ++++++
 .gitlab-ci.yml       | 12 ++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
index 15520c4dafd..434873df812 100644
--- a/.azure-pipelines.yml
+++ b/.azure-pipelines.yml
@@ -459,6 +459,12 @@ stages:
         qemu_arm_sbsa_ref:
           TEST_PY_BD: "qemu-arm-sbsa"
           TEST_PY_TEST_SPEC: "not sleep"
+        qemu_arm_spl:
+          TEST_PY_BD: "qemu_arm_spl"
+          TEST_PY_TEST_SPEC: "test_passage"
+        qemu_arm64_spl:
+          TEST_PY_BD: "qemu_arm64_spl"
+          TEST_PY_TEST_SPEC: "test_passage"
         qemu_m68k:
           TEST_PY_BD: "M5208EVBE"
           TEST_PY_ID: "--id qemu"
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 49f3c588cfc..e33b137be24 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -394,6 +394,18 @@ qemu_arm_sbsa test.py:
     TEST_PY_TEST_SPEC: "not sleep"
   <<: *buildman_and_testpy_dfn
 
+qemu_arm spl_test.py:
+  variables:
+    TEST_PY_BD: "qemu_arm_spl"
+    TEST_PY_TEST_SPEC: "test_passage"
+  <<: *buildman_and_testpy_dfn
+
+qemu_arm64 spl_test.py:
+  variables:
+    TEST_PY_BD: "qemu_arm64_spl"
+    TEST_PY_TEST_SPEC: "test_passage"
+  <<: *buildman_and_testpy_dfn
+
 qemu_m68k test.py:
   variables:
     TEST_PY_BD: "M5208EVBE"
-- 
2.43.0


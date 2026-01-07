Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90DCAD0D16C
	for <u-boot@archiver.kernel.org>; Wed,  7 Jan 2026 20:20:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB1A384082;
	Wed,  7 Jan 2026 21:19:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SyuhV4S/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 89B7A84082; Wed,  7 Jan 2026 21:19:33 +0100 (CET)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com
 [IPv6:2607:f8b0:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 409BC839A5
 for <u-boot@lists.denx.de>; Wed,  7 Jan 2026 21:19:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=visitorckw@gmail.com
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2a0d6f647e2so27909505ad.1
 for <u-boot@lists.denx.de>; Wed, 07 Jan 2026 12:19:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767817169; x=1768421969; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E+CFst0svY82bQjeNuTIp7+6o+MwlPiKwNYf63DgA8Q=;
 b=SyuhV4S/6CD3J0zLFteyc/JD6Zdk+ODVSIxSrvMKcPUsxIvzua2ohS/Cc1NEJZMqsc
 GiUV4y1lPDiE88fsnlLTWAKkXTOIOZKnrayRntgY7vD+/57zJvYwTXxc/bRC+/iAP0q2
 tpEOhoNzLDicy2vtgiaALiohJ/3SVTeBKAlgeVUiR8uwBz7sLhn5LfIKGdHK5xcwJXUq
 G+JMxKRb4PiJJFSb90z7I9kLVmHjbNw8CFHRWlkeEm6bbAgUr0ARb++e6C8s8iC/yJcV
 vjaJ/kiVGAPVUzXUB1u5L941kxklqzDiHTFc59+dn/Zu3hOLO8oJVPva9Ti5ofKKGTfd
 gAiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767817169; x=1768421969;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=E+CFst0svY82bQjeNuTIp7+6o+MwlPiKwNYf63DgA8Q=;
 b=cOh2+iIis9w7lhaGPmkFY5FP1YP7EZ9rfMHWKZoTgmS15Ht7S9v4cgdPA2NrdffFBF
 F24IJTsYZShSsFhje+fL7t/VL4uJp1KD9q0jrAO54bCl/3SzKw+pVwG0POOR76NFb4hQ
 i9w+SIz+6k8TVk+olHWJ2IMnLZSTT9vLSu8V5200q4o+TrKxLI5o6bl78tb9dfteVPi4
 npaFTftSN3iAl8H9OjFExH5UsabAm9QNBQ13IO2LMQD1pf7G4JKzFGmoT71H5VqPh9Sl
 SQ0ZR4tjw0nMgB0BvJ+KrUAFSmXds3o8GlHeOlm5rGkUbVUGPoSHi50zbaa3k4zGu+5g
 Xc3w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVi+9k8orx0YdbQHpBVu9yamWcGmkcOEYwvJ2fFZlEZF3kcf56F1eRZfgkXpukeL8OS4FtEWPY=@lists.denx.de
X-Gm-Message-State: AOJu0YwCt+qsaj02NEvmU6wVMNMQYISKV1S1HhMPj7vBbeKvyRKdsKJ5
 zc2iuyJVckNLHiM1MI20+Kcj0x5pdwmjivXnL5mXhuwae2b5tclkQcpv
X-Gm-Gg: AY/fxX6NW7OAXI5f21XJGv6iBhLKB2nFL8w9XlLftHCe/232ibqlFEC/VHoXR1Hkc5P
 kh91YANHezKhba50u3LVNUkGybdUNq7Lq6u0NivvybHOmNs/ORFGsrzbjRlRYekxbliY0K1vY7T
 uWLVcHg5eHYksopl399Fqg4/Jrfeqi43KAbI433cqbPtYZrJEnMfm9F1zcmGbDgogsdvhbz2ooW
 gSEtbcezRx60MEuQ9zV2BmvOnEMHnsqGvkAzbmOfolKM//yOj90hwQgvwnV7dPsdIUu+yBBuYPC
 b+6Thy5rtNC2HkSyo1X4iWVc0SLFQRzCovmOe+WcHWuPohoWdsWWpXTnaHsZqRiIgfN2YPJNXTQ
 o56RVbbK3hrfCjn3xcYcMdEVQIE17rX1j5m5bf8qPPOYYJew4vhpjWlBMSGnXLSoP9p4vKbjgz6
 SJjYXQyVNsHmQliLpUec7aIevVivkJMdkdMDXWaPChqhSSx4j//xpTCwa+WP36UvhMZ9p4aDINi
 O8V4oTpByCnRGc/AZXlwA==
X-Google-Smtp-Source: AGHT+IHOT59nyrzcMcFz1isjKq7UKuZ0v2ukRnl7/AenRZmsHodrQ6mNRWMZwVhk2Z4Agp8N4AMWuw==
X-Received: by 2002:a17:90b:2711:b0:34f:62e7:4cfd with SMTP id
 98e67ed59e1d1-34f68cbe5e1mr2842273a91.24.1767817169493; 
 Wed, 07 Jan 2026 12:19:29 -0800 (PST)
Received: from visitorckw-work01.c.googlers.com.com
 (25.118.81.34.bc.googleusercontent.com. [34.81.118.25])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-34f5fa947ecsm5766077a91.6.2026.01.07.12.19.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Jan 2026 12:19:29 -0800 (PST)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: alison.wang@nxp.com,
	angelo@kernel-space.org,
	trini@konsulko.com
Cc: me@ziyao.cc, daniel@0x0f.com, heinrich.schuchardt@canonical.com,
 sjg@chromium.org, jserv@ccns.ncku.edu.tw, eleanor15x@gmail.com,
 u-boot@lists.denx.de, Kuan-Wei Chiu <visitorckw@gmail.com>,
 Simon Glass <simon.glass@canonical.com>
Subject: [PATCH v6 7/8] CI: Add test jobs for QEMU m68k virt machine
Date: Wed,  7 Jan 2026 20:18:36 +0000
Message-ID: <20260107201838.3448806-8-visitorckw@gmail.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
In-Reply-To: <20260107201838.3448806-1-visitorckw@gmail.com>
References: <20260107201838.3448806-1-visitorckw@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 07 Jan 2026 21:19:43 +0100
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
Reviewed-by: Tom Rini <trini@konsulko.com>
Reviewed-by: Simon Glass <simon.glass@canonical.com>
---
Changes in v6:
- None.

 .azure-pipelines.yml | 3 +++
 .gitlab-ci.yml       | 6 ++++++
 2 files changed, 9 insertions(+)

diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
index 81a36da7114..e9fee478117 100644
--- a/.azure-pipelines.yml
+++ b/.azure-pipelines.yml
@@ -520,6 +520,9 @@ stages:
           TEST_PY_ID: "--id qemu"
           TEST_PY_TEST_SPEC: "not sleep and not efi"
           OVERRIDE: "-a CONFIG_M68K_QEMU=y -a ~CONFIG_MCFTMR"
+        qemu_m68k_virt:
+          TEST_PY_BD: "qemu-m68k"
+          TEST_PY_TEST_SPEC: "not sleep"
         qemu_malta:
           TEST_PY_BD: "malta"
           TEST_PY_ID: "--id qemu"
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 28a32f9f4d3..ff805fae054 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -417,6 +417,12 @@ qemu_m68k test.py:
     OVERRIDE: "-a CONFIG_M68K_QEMU=y -a ~CONFIG_MCFTMR"
   <<: *buildman_and_testpy_dfn
 
+qemu_m68k_virt test.py:
+  variables:
+    TEST_PY_BD: "qemu-m68k"
+    TEST_PY_TEST_SPEC: "not sleep"
+  <<: *buildman_and_testpy_dfn
+
 qemu_malta test.py:
   variables:
     TEST_PY_BD: "malta"
-- 
2.52.0.457.g6b5491de43-goog


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46821CCD184
	for <u-boot@archiver.kernel.org>; Tue, 21 Oct 2025 15:35:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BEA1C8323A;
	Tue, 21 Oct 2025 17:35:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="zvKAugyq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B3A668323A; Tue, 21 Oct 2025 17:35:31 +0200 (CEST)
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com
 [IPv6:2607:f8b0:4864:20::72e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A8ED82B20
 for <u-boot@lists.denx.de>; Tue, 21 Oct 2025 17:35:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qk1-x72e.google.com with SMTP id
 af79cd13be357-85d02580a07so859285a.0
 for <u-boot@lists.denx.de>; Tue, 21 Oct 2025 08:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761060928; x=1761665728; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wSZJLAj0BMpvgmpRl4uhjkuBlh03exjRc/O7a9UT75Y=;
 b=zvKAugyqKxYBU6NrE7pk4r7cxchjM2r2uQVFlMLWoF54MpK26rRGO8JHFKoHk1KPh6
 rYm7/FfhfYV6VCe/fzsMK9ujtUp4pqnjxSGy46sQg4LmlNUGrjA2/Z8QsXOo4w3Bo2Hu
 nFd8Bqkz9m5g8j6S9K1pxPxbAVUM2Lv/RKnykS1aQGr8ug3GLNbfGSENscWXVtz7Plow
 0Ud4D+YIMdVhnSC3nC2p8tFJmcJyCP4X+v/RA4seLHPZCWdIKmnur3QS9jolGrYmbjjl
 doDCyckQKicQBlHLt2LV6zNwOArTOZBIUn3YP7b/xD2zI4KVOnIstQI83LQUFjYutIAw
 yuRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761060928; x=1761665728;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wSZJLAj0BMpvgmpRl4uhjkuBlh03exjRc/O7a9UT75Y=;
 b=YMWUL6hfdbf/Fo+8xYzYuF8VPatSvwSml7FjUqbnGtRATfDws2vit4dFX5Oayj4QYK
 VcWv8QBYF0DCCSqGOKno+GbuinECYZekEcm8GMIYnAYJfaxohceaO06oweJwUlOqTlyC
 ndCmFjwi4rENcRKapvUAf/QJgN7kDgoT7fugvb9ochP4ylQ2LQOFREK30abmtbx1u720
 tHvE+U716pJeOPv4SpyX5IF7xArI0A2W3xd3P4cRlxIUWbygtHibCDD3JEMhNyeF0AbF
 RsWgFsDw+WFhS7r27vJuM7FoCd4tD652rc6XdtpKnayHmqINF+Y+ke8RjsX2Pwi1DosO
 HLBQ==
X-Gm-Message-State: AOJu0YzXC3PHlh4pqijkRMG1a5z3lzthl5R4FM69AVat3YNxYA+lnR/C
 qQeuvcIVPw/raQcWXlT0wQUPGnmeePTM+SjfMB3LK4FwINFyWG/JCDdSV500NAdE0KUyMnU5eTi
 6OWD9
X-Gm-Gg: ASbGnctwOB+/gsmk5G6H9FwnEJieql/uGoENkoQ27taJpRgCyfxBWZ9N2+YdxsumnVm
 bN3tnb7lajsXSRJ4DwVKhEPa8aUcfau9nreG9mAcCEkt+dvS+4czBZGINtWrLm3NhevpAY2jg7Z
 n3cfRhHYrjoTA5h2Q6tLyFFbi7kxoMw1X3tBQXSYKZhcO6caKonDfq383047zubKH66gGTxgUUe
 5y3W534Q2NaJx1hGT5D/8J+9k4YIO+KtXqopF0vC06Tom25sEqBNvnBCHtu/AtzSKVuLnMykvih
 cW/grUiaO/6g/Ash5fbZp1rzpncyMY6mAL6AYNQVMQnD1vO5RCXdpEx/SuKehROn4LmeSt/Equs
 3DHg3pzdzvPDQKeecy7K1Hpr3KmIamJx9+9Rm4afmXMt9tG43jkaUT+Gqevk0ta3ZCDfHRSkbxh
 9e0lndE7+lMtq06wWoO2NEd9JyeVo10fQdK1POCw==
X-Google-Smtp-Source: AGHT+IGdy2E1LP3mPLxl22wjlIi9e24KIkTl2Vou27IwsKIkKPEWEkp0+9f0uv9EHwhIRps8KYplcw==
X-Received: by 2002:a05:622a:1a86:b0:4e6:df3e:2abe with SMTP id
 d75a77b69052e-4eb73015d1fmr2818331cf.9.1761060927953; 
 Tue, 21 Oct 2025 08:35:27 -0700 (PDT)
Received: from localhost.localdomain ([209.227.150.67])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-891cf58e7bfsm777910085a.50.2025.10.21.08.35.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Oct 2025 08:35:27 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Michal Simek <michal.simek@amd.com>, Adriano Cordova <adrianox@gmail.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Sam Protsenko <semen.protsenko@linaro.org>
Subject: [PATCH v5 5/5] ci: add test entries for qemu_arm64_tfa_fw_handoff
Date: Tue, 21 Oct 2025 08:34:37 -0700
Message-Id: <20251021153443.219326-6-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251021153443.219326-1-raymond.mao@linaro.org>
References: <20251021153443.219326-1-raymond.mao@linaro.org>
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

Add qemu_arm64_tfa_fw_handoff test entries to azure and gitlab
pipelines.

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
Reviewed-by: Tom Rini <trini@konsulko.com>
---
Changes in v2:
- None.
Changes in v3:
- None.
Changes in V4:
- None.
Changes in V5:
- None.

 .azure-pipelines.yml | 4 ++++
 .gitlab-ci.yml       | 7 +++++++
 2 files changed, 11 insertions(+)

diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
index 093596ee378..320f7567e6d 100644
--- a/.azure-pipelines.yml
+++ b/.azure-pipelines.yml
@@ -477,6 +477,10 @@ stages:
         qemu_arm64_lwip:
           TEST_PY_BD: "qemu_arm64_lwip"
           TEST_PY_TEST_SPEC: "test_net_dhcp or test_net_ping or test_net_tftpboot"
+        qemu_arm64_tfa_fw_handoff:
+          TEST_PY_BD: "qemu_arm64"
+          TEST_PY_ID: "--id fw_handoff_tfa_optee"
+          TEST_PY_TEST_SPEC: "test_fw_handoff"
         qemu_arm_sbsa_ref:
           TEST_PY_BD: "qemu-arm-sbsa"
           TEST_PY_TEST_SPEC: "not sleep"
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 9151d251856..033d4f9f0af 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -409,6 +409,13 @@ qemu_arm64_lwip test.py:
     TEST_PY_TEST_SPEC: "test_net_dhcp or test_net_ping or test_net_tftpboot"
   <<: *buildman_and_testpy_dfn
 
+qemu_arm64_tfa_fw_handoff test.py:
+  variables:
+    TEST_PY_BD: "qemu_arm64"
+    TEST_PY_ID: "--id fw_handoff_tfa_optee"
+    TEST_PY_TEST_SPEC: "test_fw_handoff"
+  <<: *buildman_and_testpy_dfn
+
 qemu_arm_sbsa test.py:
   variables:
     TEST_PY_BD: "qemu-arm-sbsa"
-- 
2.25.1


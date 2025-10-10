Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E7ACCCA476
	for <u-boot@archiver.kernel.org>; Fri, 10 Oct 2025 14:46:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2ADB7845DB;
	Fri, 10 Oct 2025 16:46:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="eOIEkBvC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5DB84845DD; Fri, 10 Oct 2025 16:46:16 +0200 (CEST)
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com
 [IPv6:2607:f8b0:4864:20::82c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5EE4E84258
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 16:46:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qt1-x82c.google.com with SMTP id
 d75a77b69052e-4dfd1f48d4cso16787371cf.0
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 07:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760107573; x=1760712373; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nw0Z4OhikAl1XqKYhi/r7zFUS/jwT8pFrq/kDHuuGlY=;
 b=eOIEkBvCMxQcUS4kD5y+DWc2Pa9uBxmPaLcD69P7DVb/oeq6TU5/erQwKOwmExxdMP
 ZcS14Nbxg1/sXlA3JXp2TQaoSFG9cB75yA2vaT+HAKd+NlbZqaRwPiBy7ui9z4LVG7w6
 1IWzGBIZIZ16rDqGd1cjfNyHVWjZN0vkJZFSGS6wfE0IYrTvHa56iQErnncCHVEwyO65
 vTvI9oeuLDlpHaBjlOgwhKXBzjQ798YM5NyRdcO6QgDYD974pduZPpnRR27+zCiavTKq
 TuoeL7d1oCXjWWXLY4WJx2hpgDMz9usCFc+noVQI/Ww9mpE6zcseV4uxEk0l0ZWY0BQV
 VQxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760107573; x=1760712373;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nw0Z4OhikAl1XqKYhi/r7zFUS/jwT8pFrq/kDHuuGlY=;
 b=c3khn9YpvpaHNAaKAax8pGEXzVSjQaRSNgz1omPkWVHdssjPtqsqfNEZ2UO6w0ykrn
 QLWoVm754iSdaSw9bq+5dfrsh9fPnDJBsekn74I/EKLXmo0PR8I6MkuS9XL5aEvRIzjV
 7FxlEhw3t4Y0Nmn0rtbYQ4E0q7pX5Ye1qbsSYQh8B0eqUiptnOEBKS3/LlQAjfqkax4B
 khbZbCAk+vwhB6g+TCDUxR0+8fihvqTJnPEzqWeDfnLzNWQDrPBuYDSpGav3fXL8N+Xr
 XtGjo8aIq8GVL6f7dQUrpsshevY0k4cOvFp0BEROAXicZsspLFraTUfhqCFwaAgMfqnr
 IikQ==
X-Gm-Message-State: AOJu0YwARYjnYgGmp6/IkyUC3WbXD1fJKn3g14Xh/ZDjiMYM+/KHIAQx
 I+w0kcw+XPs/hmxepo5qFAFRzk05X91ylwAjk3U4VSiWZj18Y4Sz4rkreRNFcOKsJAvOOobAL/5
 5/mUG
X-Gm-Gg: ASbGncuFgAJFSLVObLAjBQ4A+3F0GqdlffbYwM7+yIqrS1cDcuMIWzKBq/gHFr+zb6w
 QPXo9o/DJwsYRJRgf34i0oiuQsPB2+k5qEKjFJrE5xBuyDN+TpdpocWYZBeoh6PQmxcbUtE5bFz
 dZgj8hNlTlQQmyez1x2PMC1caWZvmGgNf+6CMisnu/Bsnb9el9ZAPOGNftbyepiDAZKQqKAZa9h
 Aa5vJ6D3oV3ijtrp78yKPwvYa3LxUzeDWGfmBrFs0kGLTvejLO1+1YsHP4Lj72wIrIWtbGW4/Vg
 k9u/a2IqoNDaJ9l6yAGA0C1Efd6QJXiJLuVovx4pVA9fiNetW4rjw6dE0VzKhb+ZsbxCpgWUp0x
 MZpdk3cHfXfNhWNZeyD4SkMVgi7M4kQq2augsXXt+xH9Lyrfel9E7uumLkFG4TLsdhjxM5XC89K
 BALlw=
X-Google-Smtp-Source: AGHT+IFGqUX53W7wK/cRe1fZnBEiHjbexT7YPzootq5F/fdzHDpXmB0J/MQkrE1p7Jr2aqZVRnzeYg==
X-Received: by 2002:ac8:5d05:0:b0:4e4:2006:b009 with SMTP id
 d75a77b69052e-4e6eaccc55cmr151062001cf.17.1760107572806; 
 Fri, 10 Oct 2025 07:46:12 -0700 (PDT)
Received: from ubuntu.localdomain ([209.227.150.67])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-87bc3479344sm17686306d6.17.2025.10.10.07.46.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Oct 2025 07:46:12 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sam Protsenko <semen.protsenko@linaro.org>
Subject: [PATCH v3 6/6] ci: add test entries for qemu_arm64_tfa_fw_handoff
Date: Fri, 10 Oct 2025 07:45:10 -0700
Message-Id: <20251010144517.3573014-7-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251010144517.3573014-1-raymond.mao@linaro.org>
References: <20251010144517.3573014-1-raymond.mao@linaro.org>
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

 .azure-pipelines.yml | 4 ++++
 .gitlab-ci.yml       | 7 +++++++
 2 files changed, 11 insertions(+)

diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
index 4bf4d9e763b..6948ad6b4b6 100644
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
index 5ae02176167..e20e6c6d43f 100644
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


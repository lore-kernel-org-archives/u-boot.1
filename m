Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6DEFC36010
	for <u-boot@archiver.kernel.org>; Fri, 11 Apr 2025 15:32:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 014F7841A9;
	Fri, 11 Apr 2025 17:31:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="X3aN3yeq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 644D684199; Fri, 11 Apr 2025 17:31:04 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD4B784183
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 17:31:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-43edecbfb94so22877925e9.1
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 08:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744385461; x=1744990261; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PgDg8SGREcusCzA799DzdciEfX+rtGREryDUTR6SsJs=;
 b=X3aN3yeqMbCChKynpBShZsg6YbO6XNoDwB7uXDbF4HWA12537cLjR68cPrEa7uiUYI
 cmgTVu6ZSCuxEryKI6d5i5ji3fCBoJ9VkrNx1NeX0bujV+ZxvBw5hrDEsbkKS4HHIqrX
 18D4/BhT15zbiko5d4dMLS8pWMo4u/wqWvoyp57sh2CyEJbOMkuuZahM3xv8js0l3RC6
 IlvAW8xqoOx4YWTqy+4pL3CBdr4DTLGJoexF9GNADG3ytJGApdvgZxbSWYYjsrZvMJuY
 9f81Yrid63dNJOaBrujp1Ux8L5QjQ3sTheiMRI/aRemdrguLqdVECoPT8HM+xpJd7tZs
 E+Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744385461; x=1744990261;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PgDg8SGREcusCzA799DzdciEfX+rtGREryDUTR6SsJs=;
 b=sQfsriAObqyIsV/ONmk1xXhuU7Ge8g7huT7d0zXnSujkEg+1+dEK9hqxSea+Z3/5Gg
 BqIh2AJRyfwBEmvcMzvjBGM1/0QbBfIMv5bpFM/3lrShfoKsR71vCKQrMlzC2EfJEM6w
 zYKNn9OLNGznRdh7IJTwqxb3+RMUrivyOC108VjMYVMzKRmakPvL346R5jRa59CruiMb
 hssBpP/nc/ci4qa8HVUhiVt4T9UDvxJt++d7OnuhKbC9knZ4j80O9CkVdehtc0YLMyBR
 CbtLZ4TQz0mO8fD6CIbU3FH9jE2uhly2hVumenArCmbSPHyoS4GLvDZiqhN6k7BBj+qn
 r1rg==
X-Gm-Message-State: AOJu0Yxl3H1Zz6gi6qik5Y7EjcFlgfizXMvgmG1sf9dkJxA0tTLmOI+m
 xhuZUKLk6wOOSYDkd2X7P90z/vkKgoN4gt3bMMkFm2h42EODUiLwa3ZikaijPnXe94PTVNOq/Yd
 UVHk=
X-Gm-Gg: ASbGnctToLfB3+GxOlqDvckXkNVexoVJLAJXQa6/Rk8zCWenWExPon35teHmTX0wdBE
 9qR63LoIT5iyezO2Md50xg8f4Gab+HwlmgnWQh4OF6DmH1WvW480P2rvmgAMVVx+VdyrWsuUYt3
 qc1n8NwutGQmIRdQiekn8leYl3KFmmShyVaWCRiJ+j7/8ZbONqXNrrJmGYOuW4+9rT4i8p9w66z
 olKPLfG4cIvpAO590w+shV1Q0kC3VzXRBpgpgDqzjQlmEOs12VXc1pOlwWRk9OrY72PRIgCB/6x
 4IcpbpYox58pq0mtH3DLrFLfRXCKZ8mty4ptYWN9MhrAvGRvStl4Of52UEzo
X-Google-Smtp-Source: AGHT+IHYybeb0+mGJbfjpGQV+WnlzjRDa6WSeVGKiBHkIxn+8Qx+/gMf6tjO3X7F0z51Hu3ezuGfJg==
X-Received: by 2002:a05:600c:4f10:b0:43d:878c:7c40 with SMTP id
 5b1f17b1804b1-43f3a94c657mr39427465e9.10.1744385460688; 
 Fri, 11 Apr 2025 08:31:00 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:94cf:dbda:d223:8de8])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43f205ecf30sm90337355e9.1.2025.04.11.08.31.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Apr 2025 08:31:00 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: U-Boot mailing list <u-boot@lists.denx.de>
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Love Kumar <love.kumar@amd.com>, Marek Vasut <marex@denx.de>,
 Michal Simek <michal.simek@amd.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [RFC PATCH v1 7/7] test/py/tests/test_bootstage.py: upload bootstage
 data to InfluxDB cloud
Date: Fri, 11 Apr 2025 17:29:33 +0200
Message-ID: <20250411153040.1772000-8-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250411153040.1772000-1-jerome.forissier@linaro.org>
References: <20250411153040.1772000-1-jerome.forissier@linaro.org>
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

If the BOOTSTAGE_INFLUXDB_URI and BOOTSTAGE_INFLUXDB_TOKEN environment
variables are set, the bootstage test will upload the timing information
to the specified InfluxDB instance. This is meant to be used in CI to
publish results for a particular board/build for later analysis. Note:
use "precision=us" in the URI, not "precision=ns" as shown in most
examples in the InfluxDB documentation. For details see [1].

[1] https://docs.influxdata.com/influxdb/v2/write-data/developer-tools/api

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---

 test/py/requirements.txt        |  1 +
 test/py/tests/test_bootstage.py | 39 ++++++++++++++++++++++++++++++++-
 2 files changed, 39 insertions(+), 1 deletion(-)

diff --git a/test/py/requirements.txt b/test/py/requirements.txt
index 804a427b351..dba380809a9 100644
--- a/test/py/requirements.txt
+++ b/test/py/requirements.txt
@@ -3,3 +3,4 @@ pycryptodomex==3.21.0
 pytest==6.2.5
 pytest-xdist==2.5.0
 FATtools==1.0.42
+requests=2.32.3
diff --git a/test/py/tests/test_bootstage.py b/test/py/tests/test_bootstage.py
index 5619eaf4676..efb27d51663 100644
--- a/test/py/tests/test_bootstage.py
+++ b/test/py/tests/test_bootstage.py
@@ -1,7 +1,9 @@
 # SPDX-License-Identifier: GPL-2.0
 # (C) Copyright 2023, Advanced Micro Devices, Inc.
 
+import os
 import pytest
+import requests
 
 """
 Test the bootstage command.
@@ -40,15 +42,50 @@ def test_bootstage_report_json(ubman):
     assert '"reset~board_init_f"' in output
 
 @pytest.mark.buildconfigspec('bootstage')
+
+# Extract the text string between two delimiters
+def extract_between(text, start_delimiter, end_delimiter):
+    startp = text.find(start_delimiter)
+    if startp == -1:
+        return None
+    startp += len(start_delimiter)
+    endp = text.find(end_delimiter, startp)
+    if endp == -1:
+        return None
+    return text[startp:endp].strip()
+
+def send_data_to_influxdb(data):
+    uri = os.environ.get("BOOTSTAGE_INFLUXDB_URI")
+    token = os.environ.get("BOOTSTAGE_INFLUXDB_TOKEN")
+    if not uri or not token:
+        print("Warning: BOOTSTAGE_INFLUXDB_URI or BOOTSTAGE_INFLUXDB_TOKEN "
+              "not set, cannot send bootstage data")
+        return
+    headers = {
+        "Authorization": f"Token {token}",
+        "Content-Type": "text/plain;charset=utf-8"
+    }
+    try:
+        rsp = requests.post(uri, headers= headers, data=data.encode('utf-8'))
+        rsp.raise_for_status()
+        print(f"Data succcessfully sent to {uri}")
+    except requests.exceptions.RequestException as e:
+        print(f"Error sending data to {uri}: {e}")
+
 @pytest.mark.buildconfigspec('cmd_bootstage')
 @pytest.mark.buildconfigspec('bootstage_report_influxdb')
 def test_bootstage_report_influxdb(ubman):
     output = ubman.run_command('bootstage report')
-    assert '=== Begin InfluxDB v2 bootstage report ===' in output
+    start_delimiter = '=== Begin InfluxDB v2 bootstage report ==='
+    end_delimiter = '=== End InfluxDB v2 bootstage report ==='
+    assert start_delimiter in output
     assert 'u-boot_bootstage_report,' in output
     assert 'u_boot_version=' in output
     assert 'dm_r=' in output
     assert 'reset~board_init_f=' in output
+    data = extract_between(output, start_delimiter, end_delimiter)
+    if data:
+        send_data_to_influxdb(data)
 
 @pytest.mark.buildconfigspec('bootstage')
 @pytest.mark.buildconfigspec('cmd_bootstage')
-- 
2.43.0


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6760C5478C
	for <u-boot@archiver.kernel.org>; Sat,  2 Mar 2024 22:01:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA22687EDA;
	Sat,  2 Mar 2024 23:01:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YIz80Bq6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C436087E96; Sat,  2 Mar 2024 23:01:25 +0100 (CET)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6A20F87EDD
 for <u-boot@lists.denx.de>; Sat,  2 Mar 2024 23:01:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=igor.opaniuk@gmail.com
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-33e12bcf6adso973752f8f.1
 for <u-boot@lists.denx.de>; Sat, 02 Mar 2024 14:01:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709416881; x=1710021681; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YJtJUJcbedJqKOLkywTj0CdSYjis/eHZTLZ328mQ3BU=;
 b=YIz80Bq6BA9xdSJurpPWV6NLOQMUMWa3DjusVxeaiEv484aGtNLRsvnRuOtU+wTstH
 GG1mn/MkNqS9KvX27XoDNHOqs+2f1b8kzss/gDfNP7Mj9tJYyyJIlEnZT323MxrVKpcQ
 zzWWYxz39DT+fFjZPQDvQbGJix8w8EL+P5DGtroKD51xhiyjhuztdzlh6DJc1FKDgDfr
 63RUfO1h2EtVIqJjT4BZjirxWvhLLJKFPuLfDOE7EaXUk5PkxRYk2SE0SF2GO91b76Wk
 sNUpnijbpVqlGCuxg95ZrOiO7eNOwr+rlWT5OlsYgBiu59E8vBy3G2JXPhku23qeYJx7
 aYaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709416881; x=1710021681;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YJtJUJcbedJqKOLkywTj0CdSYjis/eHZTLZ328mQ3BU=;
 b=OqmFAzuW+8LRRJ81umQQEzezjWbBRAQmoqbcaEhmrRXhuLM2r+XiF7hI3F4L2Rj5L2
 2/XirVFAYaqFCRzuahHLmLh2kdSI914j9FXnHgTpvKKSuXbzKYUWTtuWrAA9jgtlkQFI
 Mgm4Zsxqu3kOL3L7tVuu2/QoqZe1wLsZomu1qbPL/8VW/sC3DXa8Y6i5bddzX5t/kim4
 i8wfdcEtRrnoBnPt7G1iVbKk92DuxI0+L8gAy8Crd0bmytJ+TlMJ9zPN3ThOHKxZlMoc
 scrOSQFIvPrtEusezHoeZz3pwmK6UVGG3uCKWHHoe/5DObt4k+VeFsw7GWNCGlS/zmrI
 W0dA==
X-Gm-Message-State: AOJu0YyS/4bBo8UqHMl6iXlCrK4Eh7GQGAxgZmRpV7tiYW8xCj5Ddpam
 r3+BR4sknSEAF7V7msu4yRATBec3YMANU9IOoI04BpPUGk8R2rbpgefreRDI
X-Google-Smtp-Source: AGHT+IFa21k3ZG/3hdOpfnZchF7oVQ8ovFQpPe5V8zBHtJQ1ViBNhXR5qdU4ALKcmr/VqrmaWorTxA==
X-Received: by 2002:a05:600c:19cb:b0:412:9a51:d5ad with SMTP id
 u11-20020a05600c19cb00b004129a51d5admr4295865wmq.2.1709416881484; 
 Sat, 02 Mar 2024 14:01:21 -0800 (PST)
Received: from localhost ([185.186.156.113]) by smtp.gmail.com with ESMTPSA id
 b8-20020a05600c4e0800b00412dad86349sm1991571wmq.38.2024.03.02.14.01.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Mar 2024 14:01:20 -0800 (PST)
From: Igor Opaniuk <igor.opaniuk@gmail.com>
To: u-boot@lists.denx.de
Cc: Igor Opaniuk <igor.opaniuk@gmail.com>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 4/5] test: py: add optee_rpmb tests
Date: Sat,  2 Mar 2024 23:01:07 +0100
Message-Id: <20240302220108.720637-5-igor.opaniuk@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240302220108.720637-1-igor.opaniuk@gmail.com>
References: <20240302220108.720637-1-igor.opaniuk@gmail.com>
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

Add read/write tests for optee_rpmb cmd.

Signed-off-by: Igor Opaniuk <igor.opaniuk@gmail.com>
---

(no changes since v1)

 test/py/tests/test_optee_rpmb.py | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)
 create mode 100644 test/py/tests/test_optee_rpmb.py

diff --git a/test/py/tests/test_optee_rpmb.py b/test/py/tests/test_optee_rpmb.py
new file mode 100644
index 00000000000..8a081b5c494
--- /dev/null
+++ b/test/py/tests/test_optee_rpmb.py
@@ -0,0 +1,20 @@
+# SPDX-License-Identifier:  GPL-2.0+
+#
+# Tests for OP-TEE RPMB read/write support
+
+"""
+This tests optee_rpmb cmd in U-Boot
+"""
+
+import pytest
+import u_boot_utils as util
+
+@pytest.mark.buildconfigspec('cmd_optee_rpmb')
+def test_optee_rpmb_read_write(u_boot_console):
+    """Test OP-TEE RPMB cmd read/write
+    """
+    response = u_boot_console.run_command('optee_rpmb write_pvalue test_variable test_value')
+    assert response == 'Wrote 11 bytes'
+
+    response = u_boot_console.run_command('optee_rpmb read_pvalue test_variable 11')
+    assert response == 'Read 11 bytes, value = test_value'
\ No newline at end of file
-- 
2.34.1


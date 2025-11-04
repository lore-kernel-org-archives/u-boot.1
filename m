Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3631CCFA04
	for <u-boot@archiver.kernel.org>; Tue,  4 Nov 2025 21:55:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 03E5583957;
	Tue,  4 Nov 2025 22:55:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="E263UKtw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 94B9B83936; Tue,  4 Nov 2025 22:55:16 +0100 (CET)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E9F58394E
 for <u-boot@lists.denx.de>; Tue,  4 Nov 2025 22:55:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-7c51f56f3fdso3118821a34.2
 for <u-boot@lists.denx.de>; Tue, 04 Nov 2025 13:55:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1762293313; x=1762898113; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ao3t7fkTbHdZzJ0TcVDtxLtb01kspAn9y8w7jkiAG9A=;
 b=E263UKtw36EfxPH63503SYszWa9px1qaZ4wpWBC4bVMemS/mPK0dmyc/Q2Pu+t5swp
 B86Ww1Iu5/Tn2VaR6uMrLPxL2bkPNeLR6MNvJe+SuhFRx1NC/Wxz0zSr1Xr4C0/oM+nD
 EwLs5HW/UbEgN43VZGwSpuPvRHzrWGIzOlwDI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762293313; x=1762898113;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ao3t7fkTbHdZzJ0TcVDtxLtb01kspAn9y8w7jkiAG9A=;
 b=kEtlHfde4Vzq8fOawRQbRMtbfSUqtL0afLZwNqwhH1B9P8sQrhfS+52TPUICeEHppi
 76H0IKe0ux5M+AN/O8ABzSVtF+HFecyeiDiPSM6j7fbciUG5OouXgpt+5HQjKw0QJkRH
 NzAQ0hxz/75/0xS41YpChJkqUtrsgaqWGC7FLpUC/cZ5mDE+UF+e0GqnO61c8Y7oKwBV
 oStxNPzexBfvksG7cnmrjSx7XyoaXX+BF17IjIoV2sCGGgEBIzFL+AXhI9jkWhHeNOtb
 TxhfZlKfs3HNTjwrZZGlAmnHMcJSYmGiuOcV5/Ok+ZAEGoVTeybhPcQdA5lwvs5dyxIx
 zI5g==
X-Gm-Message-State: AOJu0YydopmcoqhjWkw1kP/n5BVBwTdrgUruyYGJJg03zfpV/lpVfm8h
 VFWvW+XG3pcE3i0n7pSAcqJgQZ4jP2tk4h2Wsdvg4qzXl1XWmHBbRZbOx+CtkwdQvQu5Cf+ZmTa
 lHG0rAoRybQ==
X-Gm-Gg: ASbGnctZQLLvGu2gDucU3nZb4PdiF2t1vCAq+qF0D5DtLykw0uqepw75nsyZ0laBniA
 eGGzARuTJMvRvl60SkqPFMpBIsmdY6ti8YrLlw5vxmm/C/8R7JJuLun+j09enFX3aAtTXBPsqK5
 QBi0eMD8CDf8DHfwzOw7T5fIBIOkYlE5A12wuIlvPDfaDwAVTLi77yevgISBXD8a6BBUeI1H2wS
 LgqsbMXIr4P8vS138pQz66RlPBDAtB/o1u9+26P5D0KU9/4WJewlqRvuH7zE2wlJYr/HrP2NHNq
 d6zJhd4KRTF4djGfSDl4IoLc8fwFQiIs3jrralFWJlX30LjvsQ49wpW6WkGpAgCkB6JUFPDn02P
 t86P6HhkG5InqUfeuGGAF5pX9+7VUUpKEcBZVCHhkMJYOcCGHwM8nKsOt87gpZ5XDGlCadBWoIu
 Rt8hoXNPqijnZbDGYwGYGYWqu0Rg5TyYxFPyKLLYcN6DMzbMFMhco3
X-Google-Smtp-Source: AGHT+IHHu6jX9WGYaA7sNCAAoMUBU4L6inP1gEz9Y3eYtHUI3nBoijokMC66g4dsdLwbGeC6i1RTgA==
X-Received: by 2002:a05:6808:5087:b0:43d:4d13:1108 with SMTP id
 5614622812f47-44fed5025d1mr388529b6e.49.1762293313164; 
 Tue, 04 Nov 2025 13:55:13 -0800 (PST)
Received: from bill-the-cat.. (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-44fd84952c4sm1038073b6e.1.2025.11.04.13.55.12
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Nov 2025 13:55:12 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [u-boot-test-hooks][PATCH 2/2] labgrid: imx: Add a writer using
 write-image
Date: Tue,  4 Nov 2025 15:55:09 -0600
Message-ID: <20251104215509.2371164-2-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251104215509.2371164-1-trini@konsulko.com>
References: <20251104215509.2371164-1-trini@konsulko.com>
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

Labgrid has the ability to write a given file directly to disk. Make use of
this to behave similarly to bin/writer.imx_raw. Note that since labgrid passes
"bs=512" to dd, we need to adjust our arguments for this rather than bs=1024.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 bin/writer.labgrid-trini.imx | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)
 create mode 100644 bin/writer.labgrid-trini.imx

diff --git a/bin/writer.labgrid-trini.imx b/bin/writer.labgrid-trini.imx
new file mode 100644
index 0000000..9dd8dc1
--- /dev/null
+++ b/bin/writer.labgrid-trini.imx
@@ -0,0 +1,30 @@
+# Copyright (c) 2024 Konsulko Group. All rights reserved.
+#
+# Permission is hereby granted, free of charge, to any person obtaining a
+# copy of this software and associated documentation files (the "Software"),
+# to deal in the Software without restriction, including without limitation
+# the rights to use, copy, modify, merge, publish, distribute, sublicense,
+# and/or sell copies of the Software, and to permit persons to whom the
+# Software is furnished to do so, subject to the following conditions:
+#
+# The above copyright notice and this permission notice shall be included in
+# all copies or substantial portions of the Software.
+#
+# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
+# DEALINGS IN THE SOFTWARE.
+
+# Ensure we have all environment variables set
+. common.labgrid-trini
+
+build=${U_BOOT_BUILD_DIR}
+
+echo "Writing build at ${build}"
+
+# This use bs=512
+labgrid-client write-image --mode dd --seek 2 ${build}/u-boot-with-spl.imx
+echo "Done writing build"
-- 
2.39.2


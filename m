Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 334EDC3DA4A
	for <u-boot@archiver.kernel.org>; Wed, 14 Aug 2024 11:06:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 361C588AD6;
	Wed, 14 Aug 2024 13:03:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 54F3788A82; Wed, 14 Aug 2024 13:03:06 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 34DEE88A9D
 for <u-boot@lists.denx.de>; Wed, 14 Aug 2024 13:03:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 91D74DA7;
 Wed, 14 Aug 2024 04:03:29 -0700 (PDT)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1EBAA3F58B;
 Wed, 14 Aug 2024 04:02:58 -0700 (PDT)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>,
 Mark Kettenis <mark.kettenis@xs4all.nl>,
 Michal Simek <michal.simek@amd.com>,
 Patrick DELAUNAY <patrick.delaunay@foss.st.com>,
 Patrice CHOTARD <patrice.chotard@foss.st.com>,
 Huan Wang <alison.wang@nxp.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Thomas Chou <thomas@wytron.com.tw>, Rick Chen <rick@andestech.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH v2 30/32] sandbox: adjust load address of couple of tests
Date: Wed, 14 Aug 2024 16:30:07 +0530
Message-Id: <20240814110009.45310-31-sughosh.ganu@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240814110009.45310-1-sughosh.ganu@linaro.org>
References: <20240814110009.45310-1-sughosh.ganu@linaro.org>
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

The TCG event log has now been moved to the start of the memory, and
occupies 8KB of memory. Make a corresponding change to the load
address in a couple of tests so that it does not overlap with the TCG
event log.

Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
---
Changes since V1: None

 test/py/tests/test_android/test_abootimg.py | 2 +-
 test/py/tests/test_vbe.py                   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/test/py/tests/test_android/test_abootimg.py b/test/py/tests/test_android/test_abootimg.py
index 6a8ff34538..bf6a19fe4f 100644
--- a/test/py/tests/test_android/test_abootimg.py
+++ b/test/py/tests/test_android/test_abootimg.py
@@ -90,7 +90,7 @@ dtb_dump_resp="""## DTB area contents (concat format):
           (DTB)model = x2
      (DTB)compatible = y2,z2"""
 # Address in RAM where to load the boot image ('abootimg' looks in $loadaddr)
-loadaddr = 0x1000
+loadaddr = 0x4000
 # Address in RAM where to load the vendor boot image ('abootimg' looks in $vloadaddr)
 vloadaddr= 0x10000
 # Expected DTB #1 offset from the boot image start address
diff --git a/test/py/tests/test_vbe.py b/test/py/tests/test_vbe.py
index 50b6c1cd91..edeb655c6f 100644
--- a/test/py/tests/test_vbe.py
+++ b/test/py/tests/test_vbe.py
@@ -97,7 +97,7 @@ def test_vbe(u_boot_console):
     fdt_out = fit_util.make_fname(cons, 'fdt-out.dtb')
 
     params = {
-        'fit_addr' : 0x1000,
+        'fit_addr' : 0x4000,
 
         'kernel' : kernel,
 
-- 
2.34.1


Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39778C5DF7D
	for <u-boot@archiver.kernel.org>; Fri, 21 Aug 2026 08:45:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CE419409AC;
	Fri, 21 Aug 2026 08:45:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UBtCMCLfATkX; Fri, 21 Aug 2026 08:45:19 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787301919;
	bh=yYL0NtfL4vy4wt/gzi+BmfGDYPoiHYlXXh2DlgMJ5fQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=F4DOqyC2tZ9wU2mjvexqt5XbNK0CTmTSwgz686nllW5OAdWGuIJoyV7G1fEE8eoRK
	 EzItesioW1B4m/Ddqxa/uhyLGPNpAMAbo6SxkPRc0rFNMbtMDjkAE0XqcHZIrJnpiW
	 lR4Kifi25GymjEow7cXE2/FPlV/bV70BB+gcvjWZIdvGD5chG9T0fGANm2grXxpdN1
	 MhJmo5EHPqTz4j3KGjMEWmkrauRBPZnqHEoizjjvlSgV5SrHpo2Z6dIoMGpHOOa07J
	 wnha1HlYm0gAn6uqMlYjsIS+wnnw4nhFO8yVJIHzQ24dwtqDeenzcY7JuAF3QIqd6w
	 /pUTwgA27QssQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 299B5409A3;
	Fri, 21 Aug 2026 08:45:19 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 9A002263
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 08:45:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8C4EE40071
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 08:45:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qKxUbadLgBEo for <u-boot@lists.u-boot-project.org>;
 Fri, 21 Aug 2026 08:45:15 +0000 (UTC)
X-Greylist: delayed 145 seconds by postgrey-1.37 at util1.osuosl.org;
 Fri, 21 Aug 2026 08:45:15 UTC
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=ziyao.cc header.i=me@ziyao.cc
 header.a=rsa-sha256 header.s=zmail header.b=IJMB9Lna
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.182.15;
 helo=sender5-op-o15.zoho.com; envelope-from=me@ziyao.cc; receiver=<UNKNOWN> 
Received: from sender5-op-o15.zoho.com (sender5-op-o15.zoho.com
 [165.173.182.15])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C7CB64006A
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 08:45:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1787301909; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=g6E3WKNxw9CLQpirJGSYCMk0L8zxfn/Ohnb0qC55Z4wmmzKCU5lPyya1enug/glAqId+6K1TctJrajnzGpOVeOy3LvJLZ5lLgdPfiOiPApZUz6uP5F7bV9V5mD42gW6nFYMHZETvQVFEXA42O+xu3QWpBwOkHLt6VdkxybJAhSI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1787301909;
 h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=yYL0NtfL4vy4wt/gzi+BmfGDYPoiHYlXXh2DlgMJ5fQ=; 
 b=AB1fmxCpsq8vtZidj8z5/inwYOZBTwqVFVeUBMkubJp3GFSI9drLKeJX5pRXqA71qzqfTmMh6j9qjCzqPKN2fgMx+lrg33wIHfdo68blHPMCqRTnvCsyMpJ1W73tzQNZvcv8ZGQrHbvhr5Zx65WxPnC3IIQ/dNOURe1o4PYp3Sg=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1787301909; 
 s=zmail; d=ziyao.cc; i=me@ziyao.cc;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=yYL0NtfL4vy4wt/gzi+BmfGDYPoiHYlXXh2DlgMJ5fQ=;
 b=IJMB9LnaRxhq4lxX7o/FPakdyx+Gl2SEhfWZ68vEttAGXPJJYjouTymFIX/QUCN2
 8ICH88X7tn61ujQ4m6drZHyYiptSloCX+lZsfBjv7kA4M64yIqHaIIa7e98072VN6Tf
 BDWmix2Ieh4txfeiTJmgWK/fzJyQwaE9gMoA1R18=
Received: by mx.zohomail.com with SMTPS id 1787301907879375.810344488033;
 Fri, 21 Aug 2026 01:45:07 -0700 (PDT)
From: Yao Zi <me@ziyao.cc>
To: Tom Rini <trini@konsulko.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org,
	Yao Zi <me@ziyao.cc>
Subject: [PATCH v3 19/19] CI: Wire up qemu-loongarch64
Date: Fri, 21 Aug 2026 08:42:19 +0000
Message-ID: <20260821084219.1703743-20-me@ziyao.cc>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821084219.1703743-1-me@ziyao.cc>
References: <20260821084219.1703743-1-me@ziyao.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Enable qemu-loongarch64 in CI so it could be automatically tested.

Signed-off-by: Yao Zi <me@ziyao.cc>
---

New patch since v3

 .azure-pipelines.yml | 11 +++++++----
 .gitlab-ci.yml       |  6 ++++++
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
index 015fc15d5c29..0c350ae9d46c 100644
--- a/.azure-pipelines.yml
+++ b/.azure-pipelines.yml
@@ -19,7 +19,7 @@ variables:
   k3_64b: "k3 -x armv7,phytec,toradex"
   kirkwood_mvebu: "kirkwood mvebu"
   layerscape_vf610: "ls1 ls2 lx2 vf610 -x phytec,toradex"
-  m68k_remaining_mx_xtensa: "m68k imxrt mx xtensa -x mx6,aarch64"
+  loongarch_m68k_remaining_mx_xtensa: "loongarch m68k imxrt mx xtensa -x mx6,aarch64"
   mips_x86: "mips x86 -x mediatek"
   mx6: "mx6 -x engicam,phytec,toradex"
   imx8: "imx8 -x engicam,phytec,toradex"
@@ -212,7 +212,7 @@ stages:
           built="$built $(tools/buildman/buildman ${BMANARGS} $(k3_64b) | grep '^   ')"
           built="$built $(tools/buildman/buildman ${BMANARGS} $(kirkwood_mvebu) | grep '^   ')"
           built="$built $(tools/buildman/buildman ${BMANARGS} $(layerscape_vf610) | grep '^   ')"
-          built="$built $(tools/buildman/buildman ${BMANARGS} $(m68k_remaining_mx_xtensa) | grep '^   ')"
+          built="$built $(tools/buildman/buildman ${BMANARGS} $(loongarch_m68k_remaining_mx_xtensa) | grep '^   ')"
           built="$built $(tools/buildman/buildman ${BMANARGS} $(mips_x86) | grep '^   ')"
           built="$built $(tools/buildman/buildman ${BMANARGS} $(mx6) | grep '^   ')"
           built="$built $(tools/buildman/buildman ${BMANARGS} $(imx8) | grep '^   ')"
@@ -490,6 +490,9 @@ stages:
         qemu_arm_sbsa_ref:
           TEST_PY_BD: "qemu-arm-sbsa"
           TEST_PY_TEST_SPEC: "not sleep"
+        qemu_loongarch64:
+          TEST_PY_BD: "qemu-loongarch64"
+          TEST_PY_TEST_SPEC: "not sleep"
         qemu_m68k:
           TEST_PY_BD: "M5208EVBE"
           TEST_PY_ID: "--id qemu"
@@ -657,8 +660,8 @@ stages:
           BUILDMAN: $(kirkwood_mvebu)
         layerscape_vf610:
           BUILDMAN: $(layerscape_vf610)
-        m68k_remaining_mx_xtensa:
-          BUILDMAN: $(m68k_remaining_mx_xtensa)
+        loongarch_m68k_remaining_mx_xtensa:
+          BUILDMAN: $(loongarch_m68k_remaining_mx_xtensa)
         mips_x86:
           BUILDMAN: $(mips_x86)
         mx6:
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 9831dd61bc18..e7957c581560 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -415,6 +415,12 @@ qemu_arm_sbsa test.py:
     TEST_PY_TEST_SPEC: "not sleep"
   <<: *buildman_and_testpy_dfn
 
+qemu_loongarch64 test.py:
+  variables:
+    TEST_PY_BD: "qemu-loongarch64"
+    TEST_PY_TEST_SPEC: "not sleep"
+  <<: *buildman_and_testpy_dfn
+
 qemu_m68k test.py:
   variables:
     TEST_PY_BD: "M5208EVBE"
-- 
2.55.0


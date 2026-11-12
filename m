Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F95606A321
	for <u-boot@archiver.kernel.org>; Thu, 12 Nov 2026 11:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=GHKWKMy2;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ziyao.cc header.i=@ziyao.cc header.a=rsa-sha256 header.s=zmail header.b=H466kRKj
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5C1BB4087C;
	Thu, 12 Nov 2026 11:58:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lX-0Q51Oz0QH; Thu, 12 Nov 2026 11:58:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A3FB440D99
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794484734;
	b=Arvu4j53YOkfXQ3u2Y2kSxUWaOgqH6/1EGVr1k730OqvgVN3ChOSkv+dH1LFBFrW1fWR
	 NV3lrCQUgHUySHXacQ+mw+dc4gnCDUEEUwQTk74K+JDOHB//qQDQFxBmzLFMCrsBWGHlO
	 qIKWBD0wbaY7W4M21pClRWpugsg78m4s/00Y7BkgxYZPIoQIZ14F0dSZ36Xd7ZFGjvS7u
	 JZ3EpQel+r6zDTpCTh2ybinea/9S/+6zyZrzVnJAWt/VjFsaXoqOX7ziN1Qs9VtP2iW6t
	 TtBL1IqN51VEzIvklr8Jyt8k5Xv9syNgqM5pLYNxn8zy/ZR7ITlCiNs6XPYEcksZykw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794484734;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-ZohoMailClient:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=rSVh4PALodP+R3DOPCvxERNaVZeTKsRc8oQF+iVGRvo=;
	b=oOn7SwRnfrGVFaIOI6ksXyTgfEMHuax4Et6+IyTcTQi6VXT/eOytzjCpfO7b1ZWIU7BL
	 Jytz1bbaUSAk8bHEYDj0hDBL0I06ARSCJ9kH8Q5J8XAHVZSUZDi/kD0w7tf1n7m66DXHC
	 NZHEOBHl0Hp6B3ZIq/DQVDODOqDp+pVnEPDBoQGCH46JtsQW+BomGdQ6ukFWWBAbC7cY7
	 4zIDUOapPz1oOyevDSK0xJEY27ZtDNFW4qtzutyby9Ag6OTtWHHeOlr4cZxgjHBxFAoiS
	 LwLvlxrlNy6CAJtThFOzLTJ8shA0gFHNF4UrB4UlyLoaKPIr5l+rSLt3hhUsoa01m9Q==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794484734;
	bh=rSVh4PALodP+R3DOPCvxERNaVZeTKsRc8oQF+iVGRvo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GHKWKMy2+B1JNRyz5fIoQw8VkK4nCCOsosHvnoyJvftyCJM7qbIRS4HrbJe3kjKbP
	 Z53kYNPRUlxJUyC5FnwyvXO+SijmWBMS0mCw7q++5RvdH9UsMxUdSZtZaFUgQWP5Lx
	 cpgt1Ca2BA5tXtiAsfrrYzbVpihtj4oeKYaSwGODdKyPAwQ8JxUy3QO9v5l3sJnWwX
	 uRXx+s3H/4oFCLUhoBeeG36fiN7VVjkxWOXxbv7CYzr/GA/8us/xamw0KjgvnnAa1D
	 o/0rUrwO8YNq4B5xfblbCl1d+ooyMLdElIHe8FGt7wvfj2A7+CZFtVSX45hYN2ATzC
	 80edN7DoGSKaQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A3FB440D99;
	Thu, 12 Nov 2026 11:58:54 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id EC10F70B
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 11:58:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D1E438156E
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 11:58:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qnMvPIQu8AE4 for <u-boot@lists.u-boot-project.org>;
 Thu, 12 Nov 2026 11:58:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 33C818156D
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.180.15
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.180.15;
 helo=sender6-op-o15.zoho.com; envelope-from=me@ziyao.cc; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=ziyao.cc header.i=@ziyao.cc
 header.a=rsa-sha256 header.s=zmail header.b=H466kRKj
Received: from sender6-op-o15.zoho.com (sender6-op-o15.zoho.com
 [165.173.180.15])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 33C818156D
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 11:58:50 +0000 (UTC)
DKIM-Signature: a=rsa-sha256;
 b=H466kRKj7U4XIeMPqBt2c7bklP+7DdMtQM/lGFK+JX+gwJUCcn4xhMygxKoee61XZWCAn9vz5Ez/+cuxkYSltEa9k9neo7TITGZeSBORc64GnHDZAc6NISwdbkbruPCXPx0grfHQPGFkWwYLgXUq08Tu+SgNcy1nAzdjivKIfYY=;
 c=relaxed/relaxed; s=zmail; d=ziyao.cc; v=1;
 bh=rSVh4PALodP+R3DOPCvxERNaVZeTKsRc8oQF+iVGRvo=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1794484723939524.817664521505;
 Thu, 12 Nov 2026 03:58:43 -0800 (PST)
From: Yao Zi <me@ziyao.cc>
To: Tom Rini <trini@konsulko.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org, Yao Zi <me@ziyao.cc>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v7 20/20] CI: Wire up qemu-loongarch64
Date: Thu, 12 Nov 2026 11:54:38 +0000
Message-ID: <20261112115438.1837663-21-me@ziyao.cc>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261112115438.1837663-1-me@ziyao.cc>
References: <20261112115438.1837663-1-me@ziyao.cc>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Enable qemu-loongarch64 in CI so it could be automatically tested.

Signed-off-by: Yao Zi <me@ziyao.cc>
Reviewed-by: Tom Rini <trini@konsulko.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---

No changes since v4

Changed from v3
- Collect Tom's review tag

New patch since v3
---
 .azure-pipelines.yml | 11 +++++++----
 .gitlab-ci.yml       |  6 ++++++
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
index fcf7aafade6e..a8f57f5910e2 100644
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
@@ -213,7 +213,7 @@ stages:
           built="$built $(tools/buildman/buildman ${BMANARGS} $(k3_64b) | grep '^   ')"
           built="$built $(tools/buildman/buildman ${BMANARGS} $(kirkwood_mvebu) | grep '^   ')"
           built="$built $(tools/buildman/buildman ${BMANARGS} $(layerscape_vf610) | grep '^   ')"
-          built="$built $(tools/buildman/buildman ${BMANARGS} $(m68k_remaining_mx_xtensa) | grep '^   ')"
+          built="$built $(tools/buildman/buildman ${BMANARGS} $(loongarch_m68k_remaining_mx_xtensa) | grep '^   ')"
           built="$built $(tools/buildman/buildman ${BMANARGS} $(mips_x86) | grep '^   ')"
           built="$built $(tools/buildman/buildman ${BMANARGS} $(mx6) | grep '^   ')"
           built="$built $(tools/buildman/buildman ${BMANARGS} $(imx8) | grep '^   ')"
@@ -491,6 +491,9 @@ stages:
         qemu_arm_sbsa_ref:
           TEST_PY_BD: "qemu-arm-sbsa"
           TEST_PY_TEST_SPEC: "not sleep"
+        qemu_loongarch64:
+          TEST_PY_BD: "qemu-loongarch64"
+          TEST_PY_TEST_SPEC: "not sleep"
         qemu_m68k:
           TEST_PY_BD: "M5208EVBE"
           TEST_PY_ID: "--id qemu"
@@ -658,8 +661,8 @@ stages:
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
index 0338f20b8a2e..d3a83ad0a619 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -418,6 +418,12 @@ qemu_arm_sbsa test.py:
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
2.56.0


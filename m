Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D297CCA462
	for <u-boot@archiver.kernel.org>; Fri, 16 Oct 2026 06:59:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 584FB812EF;
	Fri, 16 Oct 2026 06:59:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2eFOyQAPF5rb; Fri, 16 Oct 2026 06:59:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 85F9F8099D
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792133989;
	b=mjbqV9LWVvzgUqmI26lM/dpYpf03KyVMU8GC/E6njTOZiXtwQlvyTyV0sNUdPMIMZHcw
	 TuG9ibSE+r/uT2/OaMBNGRpH/in6MZa2qMUd7qJfe3J7Tkk7qaa0fubHgRXb0HURD1NcG
	 IkTYFLJ+bzWm6EM1tMGbJKHOQ+YBxbn+XBtPHWUZqCeOQd0rJyjsXGsAQD9o+b4cUww7s
	 XwtW3zdlIFuD6jQXSq/gZhyXxoXQZM9pG++T5unnrzS84CCkaVYjqoOGSRRLfa6JDp/ag
	 t7o90cv8QkuDqvrfBnKrGoN80fLh0Amb4CXQMYf50WOikqKx2P+OB8DXoGnfB3jceCA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792133989;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-ZohoMailClient:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=yvkmBSHUL00ztPu2jSVN/hAZrfR9XL4Irzu/3BRJuZw=;
	b=eB8yQzVn+27EQtjfPxnXp2pQWHKKQKlWVHRV+DA89EmvQi1IpmmJehs6D+feWoC2Fl3s
	 pVuP5bkNg3DPj+edk2drhW2M+4PpSM/mx0OSXQbPtNUneOz9DXzTVljJ8OwMYZIYEqj2a
	 KK5/mwsSHEvCi1l7K5qMgcbsMoqJENhL7wNOn4NNhjvy36iqXBSjnxcOVo8G4gkN6TkuQ
	 +hz88CSytglhavULgoZLUVwk6zMgCrgKlY8TT3ZMtHJ1pjOhEUXhGVFkFdzKGqZCwqlpp
	 HHCEpB/TvtDDgOBM5f2ZgQBkbhf1LiZCeDHGjVJ1SdMBIXMbjBnEAFSboIvKV2lL5hg==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792133989;
	bh=yvkmBSHUL00ztPu2jSVN/hAZrfR9XL4Irzu/3BRJuZw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OaGuXAdtzsXe3SYmqrSrsPR0LRMRJrX6uStBJNsbj+KzE/uvyP0ZjXwYYRB2op5gS
	 jzAABts4zGOT5PFXwD6znBReX9y8PH1yTE28n9l1rX2+gqOJH3/8cBvI9VYu1cKH7d
	 J1vsXshhqs5AOAz6ThmWklbMfh/r92NxODMeLswrCW8+xFJCB/3Q0BKpHgsIlovXAb
	 +SouVW6IzkKSRGivGsMaBuAAEupcKgAwDKW8xiMX07eMafLUtNRWvXRtcsc48HqYhb
	 2w6y9paQFbmmDZlIDXSg++JOibkXxMH3834e5sAe2j3Nbq/tlIwwCtkcJdstxsQTgr
	 AF2kgH6Nwg1jw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 85F9F8099D;
	Fri, 16 Oct 2026 06:59:49 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 85DC7362
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 06:59:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 77CE24009C
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 06:59:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id m9p9ToCT8dwa for <u-boot@lists.u-boot-project.org>;
 Fri, 16 Oct 2026 06:59:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org C6B1340050
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.180.15
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792133987;
 b=LPC9SqBYmkw6dHqNeHdFsJ9N+rutxulqw2G+cClFlwgzJKNAtuCkvtCAMBJCEtr8CsSZ
 I6OLB1OSV9ITXr2RD4Il9kX03vbXAi8xgP9/QkSfEXhyEKSCXAyJdl7UIN9AUSuUQ6vl3
 nSm0LG/ToRODUk9cGRoL941SCcii5PRav+F/MLKr0SRgHXnqHzmYXlylr8QGvmJxG98Cm
 fSMX1XzvHAMWNm1SXTeL7wGH/NuDRi/N1ekXphErrrP+sdTr6sRwGfCyg+3oUYc5y5zxE
 QOi8CJWMXfwO8JRdgu8JLukVwV6dBbr59VbIFWFd756UOkM3SRI7h0GOD1d81Izu3KQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792133987;
 h=Received-SPF:DKIM-Signature:Received:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-ZohoMailClient;
 bh=yvkmBSHUL00ztPu2jSVN/hAZrfR9XL4Irzu/3BRJuZw=;
 b=hOlYYbDJBxpnlQV/gARY/EQaYyDw48ymZvmjExI/CmSC3/aMadYsBM0EhCfpVPN9lVhw
 7Zj2CD7dIVkAkFT5GSD4Ep5VWa4xK6CATmHmVt/evupmUIxgcgSbpcy5d63JyPhM9vx5t
 dU6q3nlF4QraXzpT9Dt/o2GpLzPxt4QyKarMD3O2GKhp23TrT7+rmlv9alBIvR9a96fF1
 tj/5tsz0ppdLUHsRJaIiHBhtao/vtbVfGma2umhFK19hKc1s1rPTOC02pU8wBzyri3dNe
 vYsPOayl9uLMa6VWskyDC+llEkJEtHfUKNHsKuFC6g6ycA9GhrdR24WnUttqcHZeyOg==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=ziyao.cc;
 dkim=pass header.d=ziyao.cc header.i=me@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b=nE0XoAPE; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.15
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.180.15;
 helo=sender6-op-o15.zoho.com; envelope-from=me@ziyao.cc; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=ziyao.cc header.i=me@ziyao.cc
 header.a=rsa-sha256 header.s=zmail header.b=nE0XoAPE
Received: from sender6-op-o15.zoho.com (sender6-op-o15.zoho.com
 [165.173.180.15])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C6B1340050
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 06:59:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1792133979; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=S4KxNiqdVW59WwoLOCD3ich2macLgVzUZV2dTgNl598VDTYmkk+XJlXtTsOXqFw0WiEWqSOeq1oa9fCkOp5i3V2elA8uANjXhnGfDeDm1MR2+rlnUYC/q03vkJub0yXheiQP4RwjjLL1ihdio39e4YJ8kpG2yu8sAMlyVmkFeBA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1792133979;
 h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=yvkmBSHUL00ztPu2jSVN/hAZrfR9XL4Irzu/3BRJuZw=; 
 b=ntOHXLrj3opsdmLGr9sA5NfBE3tbsNatq53sZPfSTTvTbicmFOw64RXLS8Q+CJcTvi6ReJwVZkHEzPNULe0eI0lb4aVT7bg1PXpJq9lw6Q2LkwXeDgEt/lbLRYatS+39d0npQN7zvp+gAC+L1mweTsldMvA6/QT7s59GE3ZUB0E=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1792133979; 
 s=zmail; d=ziyao.cc; i=me@ziyao.cc;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=yvkmBSHUL00ztPu2jSVN/hAZrfR9XL4Irzu/3BRJuZw=;
 b=nE0XoAPEvelUpKJHKUAvqYyEl+Z+KA6bMpz1Paf+ji8gqOgXYXmpNe8FPowbXHKO
 GtIOIhBZQrKLSgfDGnREWwJB+mFbZApd974j0Rg5aIu7cvIKTJUOatEtH9+YcNb005P
 ar6luV1zuAYsS8HMtktmsIAHedVF33urXoJWn5uI=
Received: by smtp.zohomail.com with SMTPS id 179213397857677.07497601279204;
 Thu, 15 Oct 2026 23:59:38 -0700 (PDT)
From: Yao Zi <me@ziyao.cc>
To: Tom Rini <trini@konsulko.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org,
	Yao Zi <me@ziyao.cc>
Subject: [PATCH v5 20/20] CI: Wire up qemu-loongarch64
Date: Fri, 16 Oct 2026 06:55:00 +0000
Message-ID: <20261016065500.137544-21-me@ziyao.cc>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261016065500.137544-1-me@ziyao.cc>
References: <20261016065500.137544-1-me@ziyao.cc>
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
Reviewed-by: Tom Rini <trini@konsulko.com>
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
index 556828f42fe0..2c84de8ed03e 100644
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
2.55.0


Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B5BFC88E4A
	for <u-boot@archiver.kernel.org>; Fri, 11 Sep 2026 10:49:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 357BE8130B;
	Fri, 11 Sep 2026 10:49:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Iq8dbKEVt7sn; Fri, 11 Sep 2026 10:49:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org ED6DF81301
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789123744;
	b=AxEnm0mPsvIAYHVODlENRIfkftAtkm6+faCqaBRZymN6uf+ZM/fWY3fA8g7DniDVD7eh
	 8xv1lmueQT9DxY3wPM498keXFfeUhtw1wLipYhSWce0vmTHffTonoNTvvtoIAnSKbysSd
	 5WfOD8Jp+4po8k+LdOxUgDe1H/GH8KpGNALDQZt5+MVtzu6ijo+dkNiRM2hUdEOIisVRb
	 PD/NMIEtiqRyUO85Kc+vPW6060LBL4o7KkdAPv5xGEHajt6TOjesWNMP+Bn3VroJyKkvx
	 Cvoq/LQBWPGJkiPgIAHOKbB3gcp9LwniIHDAkoEkPNlDT3g8/lYbVarfgIeEfMlRcpg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789123744;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-ZohoMailClient:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=Mhayg9xNlK1g+6artrkmEpaDmRqAEsO9f6wtfRrGMrU=;
	b=kdcuzg7rKdkD0joXUJ1pGV/AsvR5uyyU7nRgEtlZGObB3AWxBuVYkKgoddaU1s63XryD
	 tIKOtBvenwC0U8/aUEHbaYGdfA3S25M1vZ904gF6JmQ2U+RG0e5mRUEkfhnV6A+j6AVr4
	 JS0h4sDLRLurrywnZ2JDSK1pUE3wM/2E+STFXOuZk5c3T+n6NKQgtKzCwZf+MQ0iv40sT
	 KmsNC029EMOjoBM/Umjdgb4qxt5MppcilFoiYP6w4e9IyOIamESq8rGIcinTChGdH0V1D
	 Bnb0TomwZkoa1MwBMRD/6Mx83kKd61P6QSx2SO5gKoW4/6OVocvn7RBFIUuHG8uYY9A==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789123744;
	bh=Mhayg9xNlK1g+6artrkmEpaDmRqAEsO9f6wtfRrGMrU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XqWzMPaOTNSR/mVdtiLEUHLBc6avIWmdG4AvOrtxwgVhF9ACzEdpHILN2NSn9Kt0N
	 jqLG67skRJ/bBhZQEdsKtA50v/OUyMjmG1R5dGRGU/U7p3CMs+4ruS4AIBPAS9fzub
	 LQl1d/o3w7eCG6CpV3sGdMdhqbwu+tOwKgG7IYm7brkEhWI2yAf3NGbkx1AXFhtBlB
	 uqO3k9zttKq+xSa/8n3rfPNtg0HEA5xfwRoxrFQ9Id9TYJ1iRdX/UeDrqnqHqZIE1F
	 +FXlnEISvYBfVjiZzdJbZnL2vNCgyeXrpIRf3zmOssA3bjK5x43hQXaB7lyfiPKPNB
	 oF1Duca8soq7Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id ED6DF81301;
	Fri, 11 Sep 2026 10:49:03 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 87C2832F
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 10:48:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7975040BA2
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 10:48:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wrzHDNuar90R for <u-boot@lists.u-boot-project.org>;
 Fri, 11 Sep 2026 10:48:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org D8FA340AA2
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=136.143.188.15
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789123739;
 b=pLTkjZyV8hp3LV/0uDtzhgTX51KZqnAMvBjzj3Pin6MSaoTveyrHbKkSDsKShxpy8ZKp
 +LdUzA/+TS/killFYhJa8vBhgrQ1TgLq6xSEfiiDd/D4Zc3arY/A31g7qMevcPsDumepg
 WFReEj2KvZ1+PF+utUtdaU0q5jBe65ho1fZXFDbbXVQt+S+Un1UL6AxcMmbFtBp3DFgTJ
 NUn18GX/vsr4oXLNi6uCkpcgKP80zG5JdQ+blFggzKMtT4VprMoIe+kIIe8kmauEAbX75
 D5WH3LPW6+1tBYfwUpCWpvdAf6pmxgory61BhQypE7fjtUAn8og7km5tujSBVACPg2g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789123739;
 h=Received-SPF:DKIM-Signature:Received:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-ZohoMailClient;
 bh=Mhayg9xNlK1g+6artrkmEpaDmRqAEsO9f6wtfRrGMrU=;
 b=jRD7T/1IO0Vhi8+xvMRomEnRR/sIF9dueFJ4RON9ze/d5YjAjlqf4WHqaH71QJ0icF4E
 Ksq6RWE9ckCsoj266XKJgQNJ7LxMAfJ/XeIkSxz3nrSJ8wm9/dx1gyeDEpVkkk4RJLIXW
 3/PSNfie2Sx14WNF3kvnlUei/v6HC0HNWZy/1F1HjKYGEqDqsgL5JZwUgsr4WOf3qchAI
 PXDlz8UTqmwTPcMFOXwIYQtvEVDpkRPpCfSjuDbGp8xjDVyCnzh6xhUrXffRAQsFtTtUO
 iY4h3at7rdxr6YtRiGh6ETjq6MQCdE2M9jGWu1J88puFg0T+gREkaO8Dj/WIHAaJTcg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=ziyao.cc; 
 dkim=pass header.d=ziyao.cc header.i=me@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b=bu3GaItz; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.188.15
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=136.143.188.15;
 helo=sender4-op-o15.zoho.com; envelope-from=me@ziyao.cc; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=ziyao.cc header.i=me@ziyao.cc
 header.a=rsa-sha256 header.s=zmail header.b=bu3GaItz
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com
 [136.143.188.15])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D8FA340AA2
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 10:48:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1789123734; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=gv4z3wVHArAkSDQL3OLskrPh1IyZlp7jP5gYqokrt8IMsY2Oh7i2XcyT33AQi05drogDEiX/5ueuRuXfLXeRHwdia/Yt7qNhhFRKA+jSPl8sPalDlmHY2Myv/vMGzTUTAbRZ5gzNtqzC0nxNj5hrvFtWl2PX5EY0pZM5bbvJNNQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1789123734;
 h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=Mhayg9xNlK1g+6artrkmEpaDmRqAEsO9f6wtfRrGMrU=; 
 b=Y2qk9Cw0Wkw1GHPcgWkTAI3MYD9wM5Netog4fxYzDyTvT4FGiZL7qosGzu9gfx51RBaiUDJU3FfRChV3pfZLq9EQbCskfNd1ZMEhMNloBManADJrCTEGNTOSwoc3DElbbcINbRs1ujElkV+mGn+jp301zmW/7SfxL1kav/Dlqsc=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1789123734; 
 s=zmail; d=ziyao.cc; i=me@ziyao.cc;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=Mhayg9xNlK1g+6artrkmEpaDmRqAEsO9f6wtfRrGMrU=;
 b=bu3GaItzdMViqIMie3ZGv2kfocqSkYhPe73x9jU55QPVn67Z1xwcXbCS2S9HvAmw
 gtHSPt+9HitFOEee+fdoMOcG/HJl4zjAs/5FyOgHT+P3yhD1QPMZnvdchKDGD5Eeue7
 lrdfaRymaE5RIHL85W7biY/J3cXoXyOjmnkAj6ZI=
Received: by mx.zohomail.com with SMTPS id 1789123733641215.6467757709172;
 Fri, 11 Sep 2026 03:48:53 -0700 (PDT)
From: Yao Zi <me@ziyao.cc>
To: Tom Rini <trini@konsulko.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org,
	Yao Zi <me@ziyao.cc>
Subject: [PATCH v4 19/19] CI: Wire up qemu-loongarch64
Date: Fri, 11 Sep 2026 10:46:04 +0000
Message-ID: <20260911104604.2910944-20-me@ziyao.cc>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260911104604.2910944-1-me@ziyao.cc>
References: <20260911104604.2910944-1-me@ziyao.cc>
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

Changed from v3
- Collect Tom's review tag

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


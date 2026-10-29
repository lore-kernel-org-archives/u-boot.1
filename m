Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F00606A31A
	for <u-boot@archiver.kernel.org>; Thu, 29 Oct 2026 05:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Z2VQULTt;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=ziyao.cc header.i=@ziyao.cc header.a=rsa-sha256 header.s=zmail header.b=llOq273/
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 561CA403AA;
	Thu, 29 Oct 2026 05:12:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EDNc_aOrmE5S; Thu, 29 Oct 2026 05:12:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 8FF7240780
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793250742;
	b=bfmmelzg6uvGB5DEd0bVdt26YvZB4uQh7jUX0hvZUB9/uEG2zbuWBQnc44VpPJwx/hhE
	 zS+iBLjMvgeY7D/qALYP4P1JxE9kUof4f2IoWfR5+hv2bheeNYJVB3isw5TwGrQRv3zl/
	 xnjSiSq0U6c6YDgDrpAKxqfCGuUA/qCYXwi/LmJs/GVEt2UQL6BkaGS75frZ/vc39Wmxy
	 N8H7O3hnw6jY+5two+SxxfJf7I41mjM1LM6czZv0FWvVUO7VZGxbAnXURwJh3ollRn/Bd
	 DFrxTxY/epgUOJ5TJqHWSxkm+HsWvy8DHprQIM+cBbQh/FLyTcTQ3K7Ko3r9YJi+o+Q==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793250742;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-ZohoMailClient:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=ewAexJFzZTuuK2AjHqppAnTeDjVlY5sM8rJLYtA5oW0=;
	b=EhJbefzHJofFOuyWm4xb2V56zE5WYcJBdEU5AHtK99BgHgO0fRXsDP61Vuf8gRArwg89
	 Bc8lmHdXAip1UDTQn6VS0Nr+3nUnU6SZGoj3ojSyykg7qyK6/ZAELZhgJGZT20i9qZmbd
	 dQwfZEyn7RUEc6SG6zbHvTRiII/uBdz+ugmohq4h7nK1Xa3RYepPWbSKS3QNcort98+SY
	 N/AeuayMW1JEHlAi9VGFDlbJHPvOOnGZ10wsLEzZF0pf1J+8z5oobz9W+t6yqlaxnniTo
	 CTn6Xw6mEznjhPKnwpsOfukZQ2unGz9RpoDuVOhw77PFyFtn7C5pp/3oK5MLHhR9Xgw==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	dmarc=pass header.from=ziyao.cc;
	dkim=pass header.d=ziyao.cc header.i=@ziyao.cc header.a=rsa-sha256 header.s=zmail header.b="llOq273/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793250742;
	bh=ewAexJFzZTuuK2AjHqppAnTeDjVlY5sM8rJLYtA5oW0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Z2VQULTtTjhtf6aMJcyo76I0tHZ5DLdtxREsfe2hTLgCUmdmUO3+bCiWSy7tdOF8Q
	 WW321cw9CBgW2OWtsketDLrIqFOAhgHqdJfjIMiSLpEzvWv+6/dC44BLUowr6CYJop
	 s0YNiYVCusJidHN36GBV/z9xYpMPRftXEcwE+tb6DByAgN1Jkns/lbAPb0gA1Mhjj5
	 KIzbcktnME10bLmrVNqGjV7Sun+UalP0ZSO+PRxIKF9LlCaTm9L7xQn0x8Ht1eEP9Q
	 5fR6fl9G2u11PjnK91X9oETTFjQ3A3Qno2N3vs9/lZz30KbZHDCDM8To+XrpEXLPzS
	 PeVlX6NmO4Twg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8FF7240780;
	Thu, 29 Oct 2026 05:12:22 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 783082FE
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 05:12:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5E6D840780
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 05:12:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id T6GU1Posco3O for <u-boot@lists.u-boot-project.org>;
 Thu, 29 Oct 2026 05:12:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A47FE403AA
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.182.15
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793250739;
 b=bTqoiF9GNHx+c2OWQdx/ItJlIFEetSiD63UvbissrA/CldzVm3AlEkH018yveKWyTdcV
 yv3mTzR5XuEgqdJdinTQTJD939yholDoakLNMTkDsaTCY0otP4ZLqjPFeo5oqD3zf80KX
 wjnuUbJTm9qps6VH9PxW1uh9Q47ubpxVM+X+uioE0u6CNG7soay0K7Wdd7sB/pRYDUSef
 cgkGu4IWlqKRxgWIp6tfCqrtwplTAlekWpTeHJn/EQw5Kimnkx5dmIoBJmDkUrqwkKSbr
 bx4j9Mw6VsRUp5UrnUxy7mCr9Cv4+WPkBpR7BVrJ+Y4QQjF7WBSWt+hWpCSnU9PpwoQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793250739;
 h=Received-SPF:DKIM-Signature:Received:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-ZohoMailClient;
 bh=ewAexJFzZTuuK2AjHqppAnTeDjVlY5sM8rJLYtA5oW0=;
 b=qCuWlHcHp6qzccvsg9QgxxRN+DiK/YtMFnhHkg5LUmWnKhciu/a8CosMDBKFZwGtxDM8
 1HJzco7rrQxe4t5fkK1nYV1Xe/W3p7xGaUilNGG16htUGEWRmCOOGooZGQtcP+W1GiVkK
 sZpfGbHL46mIGlQQjTsAVy+gmZNubQmfMh+hUQacWRGggsHvsrEcGjzJxg6dSxPi+9TDM
 OeOoUdgHNHoVGEzLkmWkrg7hBbLCFowSMqlc29Vs07r+CXF2llvOfSAwgkZodoDOk0drS
 0YwsZkjPuCt8xfUQSuXe5O7KsNhn+Jc223CDWE2USD+NFJJy4t/6c34VgpO9qbLKXAQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=ziyao.cc;
 dkim=pass header.d=ziyao.cc header.i=@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b="llOq273/"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.15
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.182.15;
 helo=sender5-op-o15.zoho.com; envelope-from=me@ziyao.cc; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=ziyao.cc header.i=@ziyao.cc
 header.a=rsa-sha256 header.s=zmail header.b=llOq273/
Received: from sender5-op-o15.zoho.com (sender5-op-o15.zoho.com
 [165.173.182.15])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A47FE403AA
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 05:12:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1793250733; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Ry1I6XFF9MPv/SI2wDcrlAzieGQZrj+FFKPAAx+jRBQ7b9br5AY2N4hRl1JwAPiS2yJ4fExMxinOvE3WHjC577+6Y3Pqt3NUwfk0j+/Z9hm/ETd7FA4LmtZtKdggw2hwAVqc8qoGCNzajSQ8y/ZXpNAVz8kVm6io4Grwysk2EFA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1793250733;
 h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=ewAexJFzZTuuK2AjHqppAnTeDjVlY5sM8rJLYtA5oW0=; 
 b=J73/+4kfjwblF473M0Y+209KkLfNHEtY67CBRB9La1KCuEYfkP1sIV9u1mCwnU41vV+FdHLsch6MocMLKh4BMep4k3mjSVIj2Xx+DxMGytrq4HQ2JVXL32TTCRu9HFq5z8GtVfj4bdmrsMDaPZ2Ur2xj+b/bR7Q0zZ3L4TMlH9g=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: a=rsa-sha256;
 b=llOq273/steNrh69IWOlvJP+8NfW0BKwfPHzc4pR9A2R8TzDgK01OHNY/+8dh2I/t/NdHmN5hs9LAkrKosX4+hf9u+eO/sG6Q7n3Y9cXtt78F0fqC8GXHi56IPLz9NiIDUzEFX5qrBLEKQLdt5NFntyIrxUYjZsl3xGCrALV//E=;
 c=relaxed/relaxed; s=zmail; d=ziyao.cc; v=1;
 bh=ewAexJFzZTuuK2AjHqppAnTeDjVlY5sM8rJLYtA5oW0=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1793250730110397.1771855756383;
 Wed, 28 Oct 2026 22:12:10 -0700 (PDT)
From: Yao Zi <me@ziyao.cc>
To: Tom Rini <trini@konsulko.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.u-boot-project.org
Cc: Yao Zi <me@ziyao.cc>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v6 20/20] CI: Wire up qemu-loongarch64
Date: Thu, 29 Oct 2026 05:07:37 +0000
Message-ID: <20261029050738.1107663-21-me@ziyao.cc>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261029050738.1107663-1-me@ziyao.cc>
References: <20261029050738.1107663-1-me@ziyao.cc>
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
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
2.56.0


Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE299606A334
	for <u-boot@archiver.kernel.org>; Tue, 10 Nov 2026 07:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=m+zzjZWT;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b=jizwK7UM
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A3DF9406FE;
	Tue, 10 Nov 2026 07:53:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eL1VTrwIe8Pt; Tue, 10 Nov 2026 07:53:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C2A05406B2
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794297224;
	b=ho0HY3bwyXeV3l3xl+j4U7r5WvDRfMlSYNYReZHij0OCgXlMApxCvqTk6Eam6iwr0PbW
	 cwTc7TLp2SD6vnvfkb7sq7EpXwSiFkW5xTGOx0JhIVkxM+tCAHDbtCpdYtEbt9EbC4/EC
	 88o6t9KPum/lJtlbDpMd/JWac9aIT0NHBDGiyIG884Zs15Vfb3USyGHfq4HfwebXkt5YK
	 BPZLgoK+EPmKTza9qcYFH/ht85klHPQej1ueN/Z9sCfC1rntRVqYnTY15UYgBWQDJ+mQC
	 i4xLkDGTtBMGYXMDRZ1nrCtTC88g55DUEpx7Vso0Eku5pQb86re/hyRrHj82rcSJU2A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794297224;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=f04Rw4F3CSpMpg1+RGhgK6n99gqLQCUshtt9YGGVybQ=;
	b=LB1OTjN2+sPd7QI8FNSO1A+GrYKYhNO2fxXnUI+7j+fl7K5gpQYX8hO+N2BrO2lm2oZF
	 pwavWjB4PuCV0ymn1C2tW5sK6sm84t6HcDKLM/+DhKG6snMK9TEY+ZrhWgnfOprxv+oIB
	 9zDTQ/T1moVfPNXCL/MywIUdLNdV/NFPHfdsz3a7w1paQ7VAbzx8JWMhu9tCISDEqLt1x
	 JHMirQnBTOoaKmZouIYJMcrrVxVTDcHL8F3lcinYuHVvaw+B8QhSunQ55phERiucI7vTV
	 WhT61/QBg+sAz98VQxcppBlJ2Fs3GVRu/sLsuQgAw0+HTUR16mN1OS10lBegk32i/xw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794297223;
	bh=f04Rw4F3CSpMpg1+RGhgK6n99gqLQCUshtt9YGGVybQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=m+zzjZWTqzE0CLhrmIoR89ivfzJ/G21IoOgc/aTX7R8x9Kx1NSFuxvPO3HyHrj/OZ
	 hZMRwlHudhIt1k1gGgZ4dnm9tzUfvBAIpyCypSB1cGLha+7zrxV4wMPatwQLIik/+z
	 OLwWyUnkwsksaP3qDKfnSIT5AUOjTamX/kGkpMvRY4bSm0ZgixsRa27EfTfEpHonKh
	 PIpN0WMV+37yRthgOUsNRqepg44ocnDn9ybHLF0ii5iPw+QfGDzrI1FHUXnwZXO+c8
	 +SPVLLnTAPAP8ADhnOMyY1gOMasrxx90YkKiGkxRa7fi7YvnKO3bJtZWHlklOYc0fo
	 fm53bjC9TBe4Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C2A05406B2;
	Tue, 10 Nov 2026 07:53:43 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 8FD8931F
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 07:53:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 75B3560760
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 07:53:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id r5MAfCj73f97 for <u-boot@lists.u-boot-project.org>;
 Tue, 10 Nov 2026 07:53:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A8B3F6074A
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a01:e0c:1:1599::10"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:e0c:1:1599::10;
 helo=smtp1-g21.free.fr; envelope-from=vjardin@free.fr; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr
 header.a=rsa-sha256 header.s=smtp-20201208 header.b=jizwK7UM
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [IPv6:2a01:e0c:1:1599::10])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A8B3F6074A
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 07:53:41 +0000 (UTC)
Received: from localhost.localdomain (unknown [91.160.0.144])
 (Authenticated sender: vjardin@free.fr)
 by smtp1-g21.free.fr (Postfix) with ESMTPSA id 61B2CB0053E;
 Tue, 10 Nov 2026 08:53:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1794297218;
 bh=K3u2/+GILralJYb8ZD7xnx/mbHdVZmDgJQSeS6rMvJE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=jizwK7UMT19iGqLDKlNtmZFGmtszDNNRcIxjFrefi+3VOwtMndXKyrrreXdc8ay1K
 KUbuwfcEQMv3LKnaFv60V7+gGEyRLMf3+68YZ1MVkl4E1mfqE91TOGGCCu9e5Ee/sJ
 NIbiTI1gXgQOseSno8tet/g+kMPuVrVYACEMSrGfyKdfT0QesMLscUGTErKJJINmQH
 oC0eA170t8U8ty846gUZMoD8ws0KkhNv11fDo4xeoLIXT5j83dhlNSnPysu7KGZz2H
 1wXdYhsSaScV+xAvIGkbWFLVYbj1NnuGUpsqohjZyxvmAnbPArSTvEDVGabJ9pEimX
 JHh/i1oyS6GKA==
From: Vincent Jardin <vjardin@free.fr>
To: u-boot@lists.u-boot-project.org
Cc: Markus Schneider-Pargmann <msp@baylibre.com>,
 Denis Mukhin <dmukhin@ford.com>, E Shattow <e@freeshell.de>,
 Rasmus Villemoes <rv@rasmusvillemoes.dk>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Suraj Kakade <suraj.hanumantkakade@amd.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Vincent Jardin <vjardin@free.fr>
Subject: [PATCH v2 1/3] scripts: Makefile.dts: build the device tree with
 DEVICE_TREE= too
Date: Tue, 10 Nov 2026 08:52:54 +0100
Message-ID: <20261110075256.1800130-2-vjardin@free.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261110075256.1800130-1-vjardin@free.fr>
References: <20261110075256.1800130-1-vjardin@free.fr>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The directories built based on scripts/Makefile.dts,
dts/upstream/src/<arch> and its vendor directories, list the device trees
of Kconfig only:
CONFIG_DEFAULT_DEVICE_TREE, CONFIG_OF_LIST and CONFIG_SPL_OF_LIST.

If "make DEVICE_TREE=<name>" selects another one in dts/Makefile, nothing
builds it, it stops with:

  Device Tree Source (dts/upstream/src/arm64/freescale/<name>.dtb) is not
  correctly specified.

The arch/<arch>/dts directories are not affected: their dtb-y lists are
explicit and DEVICE_TREE picks one of them.

Signed-off-by: Vincent Jardin <vjardin@free.fr>
---

(no changes since v1)

 scripts/Makefile.dts | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/scripts/Makefile.dts b/scripts/Makefile.dts
index 3871a4ad412..fd9ff420585 100644
--- a/scripts/Makefile.dts
+++ b/scripts/Makefile.dts
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0+
 
-dtb-y += $(patsubst %,%.dtb,$(subst ",,$(CONFIG_DEFAULT_DEVICE_TREE) $(CONFIG_OF_LIST) $(CONFIG_SPL_OF_LIST)))
+dtb-y += $(patsubst %,%.dtb,$(sort $(DEVICE_TREE) \
+	$(subst ",,$(CONFIG_DEFAULT_DEVICE_TREE) $(CONFIG_OF_LIST) $(CONFIG_SPL_OF_LIST))))
 dtb-y += $(patsubst %,%.dtbo,$(subst ",,$(CONFIG_OF_OVERLAY_LIST)))
 
 ifeq ($(CONFIG_OF_UPSTREAM_BUILD_VENDOR),y)
-- 
2.43.0


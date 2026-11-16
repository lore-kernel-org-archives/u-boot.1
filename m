Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9019C606A322
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 16:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=pE86vbRy;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=pigmoral.tech header.i=@pigmoral.tech header.a=rsa-sha256 header.s=zmail header.b=DnRbrOLs
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EFFA980FA7;
	Mon, 16 Nov 2026 16:27:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mNFy-VKuoj3k; Mon, 16 Nov 2026 16:27:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org F309C80F65
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794846467;
	b=mlCH3s96IfM/SXF4t7lEH7P2fx3CXsY1uLXrpFsfupr2ZWqjnrjKcHGDxYqWb8y81fPv
	 lEauMoHpGaBpUUBVIi0o6+O4xzXPWGNpn72hS0z4DWEeEdp4QZkD9UkFEMyAgXQG/wVZG
	 3H2XYGJLP3Dj2fsO4f09ofWGjQnFu6zDYOfox7Nb2L9W39bGCVxM1pk1DUzRtHOubuQfV
	 zZEbCGVOOExBRX5UCR5TSRA2mp6Yp/2WR5AKAOH4fNqu591jU/LoiKPbyySalLG2ISJWn
	 wF2o5hJtz4niLZkIsZiPssLdTlROSFLjS34+BzHTMrtoK/e2YKCI3cefn/evwbrOivA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794846467;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-ZohoMailClient:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=LgzrYlqcf6LAv/r3kDmgI7DY6O42K0yelIWtj+rCSzI=;
	b=ai5qyMXu00GbazCE+LpJUgsocLmeJT8+RVu7aHRgEvePUQB0z7TMkbLTCwL6LJNmP9qh
	 njHXHy75STxjCszd+mOXxkZcY8v4vDbXBJkX+Lu5lgmYubjSXHd/pwE3OEji13YLGU4zL
	 MVNjf2674w9b595FT6MgmeAmy2CT4LleWgyDUSkRcj1CDwqJ3PRMOKVKZmxn9LfsntWif
	 mAAa8gBP6STFx3F/kf1yzpxD/emb4pvlh7BQuZhI97opS5tFHe94qG3iTtSMw5+QAB+PN
	 HuEu5VrIF1gUJV0W5GiEV740Cuim070xLiNMZJACFrpigvvxTumKMOw5AB9i0IYf9WA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794846467;
	bh=LgzrYlqcf6LAv/r3kDmgI7DY6O42K0yelIWtj+rCSzI=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=pE86vbRyP4I32GQM+EvYxsrWMgdmrq0ngZJyDQ+pSNfGAPGkft4NaiqQNnMjaSboV
	 jXljBAkxNvccLAEuO7W75Lu+/vaO6KN16B/54tVOu9UXvfi5Mdb+RuStOXGVcAPVqJ
	 LHasDpOX9y9AReLkIJczTpMoDeBTIv4k8weFPx0Um+4cwm9oS/ITKS+Ogxa/LS3UOy
	 mf7KvTYSMCAlU7vqx4mmuneb+AzKeHdKZjGS6CyXoBd2p8pfuaw6uyDSOWVzFxZkLU
	 Pne63xPUYgo570LrGf5OSNdW8dSMZfvnxGZmaRCNtuQ3FLwqNNk1MC4aLQdaMzUtvX
	 i51UPc004zFQg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id F309C80F65;
	Mon, 16 Nov 2026 16:27:46 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 7B15B169
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 16:27:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 61D2840282
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 16:27:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CKeMXLZ0D3XM for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 16:27:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org A211F4009E
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.182.15
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.182.15;
 helo=sender5-op-o15.zoho.com; envelope-from=junhui.liu@pigmoral.tech;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=pigmoral.tech
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=pigmoral.tech header.i=@pigmoral.tech
 header.a=rsa-sha256 header.s=zmail header.b=DnRbrOLs
Received: from sender5-op-o15.zoho.com (sender5-op-o15.zoho.com
 [165.173.182.15])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A211F4009E
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 16:27:40 +0000 (UTC)
DKIM-Signature: a=rsa-sha256;
 b=DnRbrOLsk/wK4SBfTr/oWY4wNyOExnMbGBM/p9ZCwbbFpU+7Cc1NF2GrdpQh/VIv0eXpQE+O4rhl6Qzdi4ynBcpp91yAd4VTWMmmLiKDVfilNUA0TSH6c1qgNliPVLDAtwzuzCTjsF/HZrA2MfLJJs/J9Gtd+/5C8vPTB/fxEU8=;
 c=relaxed/relaxed; s=zmail; d=pigmoral.tech; v=1;
 bh=LgzrYlqcf6LAv/r3kDmgI7DY6O42K0yelIWtj+rCSzI=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1794846445583965.4323201008268;
 Mon, 16 Nov 2026 08:27:25 -0800 (PST)
From: Junhui Liu <junhui.liu@pigmoral.tech>
Subject: [PATCH v2 0/4] riscv: Add a common memory FDT fixup
Date: Tue, 17 Nov 2026 00:26:15 +0800
Message-Id: <20261117-riscv-fixup-memory-v2-0-4731aa6c3fb5@pigmoral.tech>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/22Nyw6CMBBFf4XM2jFtiRVc8R+GRSkDjJFHWmg0h
 H+3oEuXJ/dxVvDkmDzckhUcBfY8DhHUKQHbmaEl5DoyKKG0yGWGjr0N2PBrmbCnfnRvrDOTN5d
 aX41pIA4nRzE/Tu/ll/1SPcjO+9Pe6NjPcXlYg9x7P4FS/wRBosAsrVKpdaoE6WLiNibmeZ7Jd
 lBu2/YBLFvprsoAAAA=
X-Change-ID: 20260918-riscv-fixup-memory-d8a9f5d67aaf
To: u-boot@lists.u-boot-project.org, Yao Zi <me@ziyao.cc>, 
 u-boot-spacemit@groups.io
Cc: Tom Rini <trini@konsulko.com>, Aristo Chen <aristo.chen@canonical.com>, 
 Junhui Liu <junhui.liu@pigmoral.tech>, Tim Ouyang <tim609@andestech.com>, 
 Leo Liang <leo.liang@sifive.com>, Eric Chung <eric.chung@riscstar.com>, 
 Yixun Lan <dlan@kernel.org>, Simon Glass <sjg@chromium.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Raymond Mao <raymond.mao@riscstar.com>, 
 Minda Chen <minda.chen@starfivetech.com>, 
 Hal Feng <hal.feng@starfivetech.com>, E Shattow <e@freeshell.de>, 
 Anshul Dalal <anshuld@ti.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2383;
 i=junhui.liu@pigmoral.tech; h=from:subject:message-id;
 bh=bLDmKLptfUbz2RO74AKzdG7q56OOjnTeP1PaiRjIzMM=;
 b=owGbwMvMwCWWvDb1VEXc8j+Mp9WSGLJ+6+3l9n+24PmsN+JKGv9d0jROOj19FJl0ue7azk+Tn
 FjCHkf86ihlYRDjYpAVU2Th8hf/Z63D8+2IQOt9mDmsTCBDGLg4BWAi854z/Hc0/Lpe68v910k7
 5rFKdb2KnvZUzJutuOe7eOerN7yds+sZ/kq5fi1iduHkbW8tN/IT7gor4P629AXbm52GOexR+7a
 F8gEA
X-Developer-Key: i=junhui.liu@pigmoral.tech; a=openpgp;
 fpr=15B30CC69C4BF0CC3C08F85A2A90CDC122DF37BF
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

Update the memory nodes in the OS device tree from gd->dram[] in the
RISC-V arch_fixup_fdt() path, allowing memory detected by firmware to be
passed to the operating system without board-specific fixups.

In v2, add a check in fdt_fixup_memory_banks() to leave the device tree
unchanged when its enabled memory nodes already match the supplied banks
in DT order. This addresses the MPFS case raised in Tom's feedback on v1
without disabling CONFIG_ARCH_FIXUP_FDT_MEMORY.

Updating differing layouts with multiple memory nodes is not covered by
this series. Memory nodes may carry properties such as numa-node-id or
reg-names, while gd->dram[] contains only addresses and sizes. When
ranges are added, split or combined, that information alone is not
sufficient to determine how those properties should be retained or
assigned.

Convert SpacemiT K1 and StarFive JH7110 to use the common implementation
and remove their redundant board fixups. Keep the JH7110 SPL fixup, as it
passes the detected DRAM size from SPL to U-Boot proper.

The matching case with multiple memory nodes was verified on QEMU using
a device tree with two memory nodes.

Signed-off-by: Junhui Liu <junhui.liu@pigmoral.tech>
---
Changes in v2:
- Add a common check to skip memory fixups when the existing banks match
- Drop the CONFIG_ARCH_FIXUP_FDT_MEMORY opt-out for Microchip MPFS
- Link to v1: https://patch.msgid.link/20260922-riscv-fixup-memory-v1-0-83b3166320e6@pigmoral.tech

---
Junhui Liu (4):
      fdt_support: Skip memory fixup when the banks already match
      riscv: Fix up the OS memory nodes from the DRAM banks
      riscv: spacemit: k1: Use the common memory FDT fixup
      riscv: starfive: visionfive2: Use the common memory FDT fixup

 arch/riscv/cpu/k1/dram.c                          | 15 ------
 arch/riscv/lib/fdt_fixup.c                        | 16 +++++++
 board/starfive/visionfive2/starfive_visionfive2.c |  7 ---
 boot/fdt_support.c                                | 56 ++++++++++++++++++-----
 configs/spacemit_k1_defconfig                     |  1 -
 configs/starfive_visionfive2_defconfig            |  1 -
 6 files changed, 60 insertions(+), 36 deletions(-)
---
base-commit: 6487c50b8a40f2668ab98a892b9300ad5c181f38
change-id: 20260918-riscv-fixup-memory-d8a9f5d67aaf

Best regards,
--  
Junhui Liu <junhui.liu@pigmoral.tech>


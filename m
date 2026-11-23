Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC1AE606A31E
	for <u-boot@archiver.kernel.org>; Mon, 23 Nov 2026 19:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=InSTHlbN;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hoZi25fq
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id EF460406FC;
	Mon, 23 Nov 2026 19:37:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BEVtSbdvrgKe; Mon, 23 Nov 2026 19:37:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 00B91406ED
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795462653;
	b=c3kdC50q8Zq13UU/+5xNnwf9ro0eckubf+ETn17AY/8RjHf8sPoediS0Sc9NbvDyd5Et
	 PYvnJwvStV++hv6kAbihZAgaE+6A8rIRPCAVtFchVMB67O4BaHW2gktQlwmjJIziK4KeB
	 2Z6BNe8nwGezB5uXsNqF5XntFg2wZSFO5W3otE3QAYZETgjOp+S1VFhf6elvAVJlRlqqv
	 RYHIk51uEJvCaH2tEhHArFxDh5z5t7FBTs/UAFaRNm1APo8IrEDLa1OrBPwNZjZ+O7YZ/
	 9Hi8IH16LamX4SlJWvr4b9ut4drReBXgOzi7i1KnYoMOJ1iTlBNu5sW2jWqK8nToriA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795462653;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=QF1MGazk0TbQMlUsBa/qWHXwptpAXf4fUnjaQpYLE8s=;
	b=AfwlB/7o5OkjPMnOvIA7vS0+ZTMY/p1Zky++qq1woPHkDmCULRp/ZTEc1Ubek+cVU5zh
	 tGarohNhk83MUDlwyr17paYCjshjFXgUEViTELHAYns+8J3XUAKVjwgg3NxPd44c14KM/
	 Mxa3VH7R27xJinYGgnbykwXQy7Eeoundfw6eSfAX+0ukDQxPSaWBULWxgYJbAe4eUeYnx
	 PTN4TLqunItvtBjFxMhVGCT/jkhlejD39nE75tfIgyiSfj88AQdQRtb4vPzfuDKGzvo8v
	 OPamSZuN5aByoYGIrNtIKixFLTJF86LJyMDr+604QF5viDddhK+GGkvtS78egNkWXsQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hoZi25fq;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795462653;
	bh=QF1MGazk0TbQMlUsBa/qWHXwptpAXf4fUnjaQpYLE8s=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=InSTHlbNKGd2BrV3XPKIBaPG+znyDvmil3XvS2V+vl3SgUhtMl27+zXjziLe6DN11
	 zFOeKjq78AiiT+t0eROhrDVBQ/Voswf8vvDnnaSIs9bt7pEKkjbAWIn826TYbeJ1gu
	 5Kl0c0jX79dj9ULjJ+jCUaCyGxOdfTp5jmatp6eepSs00voWTO0GlmQyyl1vnyKUl+
	 HgseS2bzaKqy17TyP5+pU4vVQke9ieWsHh8bDHBDEXQJH2gBqDM9nZO1IBObttbZj2
	 oFt2IuRoiNI/aBxJaLumGPc929kTFnvfxDACuj4slBKEZEPLNiIJD4NsnufUIdRryc
	 MU2ROH8zaQs2A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 00B91406ED;
	Mon, 23 Nov 2026 19:37:33 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 5CE2222B
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 19:37:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4254C406ED
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 19:37:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LUQFpMKFr8jT for <u-boot@lists.u-boot-project.org>;
 Mon, 23 Nov 2026 19:37:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 6640A406E8
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::132d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::132d; helo=mail-dy1-x132d.google.com;
 envelope-from=linux.amoon@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=hoZi25fq
Received: from mail-dy1-x132d.google.com (mail-dy1-x132d.google.com
 [IPv6:2607:f8b0:4864:20::132d])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6640A406E8
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 19:37:29 +0000 (UTC)
Received: by mail-dy1-x132d.google.com with SMTP id
 5a478bee46e88-38587f3de36so4451983eec.0
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 11:37:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795462649; x=1796067449;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=QF1MGazk0TbQMlUsBa/qWHXwptpAXf4fUnjaQpYLE8s=;
 b=hoZi25fqJedsqacA9JhHPICjcfOjI4qxl6UFmFBh2FKEgnOMZ4Eu1q4GcHl4tvQ8LR
 +PRwFZ+nJXY6UMU/Bm9Ef7GVvhS2DQMVwPJcEHdJqwwZ4c4IfgSPcNwiOn6hnAFTMrqS
 eLh/jjImG+zDB9TocI5xSwe/YGFPIrnMtinF73DG5sgxW+Tx1x4A5TrtpS6Od8rIHCga
 XFyeW1ccvPfgwlaVCFHa8C+Eu+xi46VZPAOM4iVOneNC78bWI6aeYnjdGwUqeFjVR3XZ
 Gr0dCifPKu1HPZEeIO8+JUW4jOjMbYRTUNlvgh1qDZf4voDT8T5yw0Caa0woQTkLTuoI
 mzeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795462649; x=1796067449;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QF1MGazk0TbQMlUsBa/qWHXwptpAXf4fUnjaQpYLE8s=;
 b=G/kzdPCiTLrGzpxta387xiZOSn5ZIbiGMgTzFAWneXWQpNvy/AcztBYup+p3/O8hDm
 j+JuVGvhiKM8cu+/PkNU6BtXR61P7jNiz9gj9MZXzKZ+iQ4d7azfWrt5VEF55rjdLw9t
 gB6BO/BS9463DbSocVq/UVNViQBsF/aFFf2xtQsjvj/pYB1F71i2GbP4HFjqnRqetTUx
 4+5nM5CQizOwtYcIp3WXNVGRAvjmTNFyowC7KkloPK/udGl5qK3PmCkfGLIU8mHm8oR8
 z5N0NC2z/9izLBQqXTGooWif6qWyXBP/rFASqD/xxo5cpHXy6WryFMZkehZPdZ0m2WVo
 v87A==
X-Gm-Message-State: APuU4Z/N0Yl9YyQSnzAIq+7l38cCW2M8mD98b04P6qrH3R6zh6DpE+oW
 KCm7CC1nWt/V5AEozhi/z/4Ksg66zbWl5X3367ir6Yu9mBY5D5GKUlxN1UYCKQ==
X-Gm-Gg: AZFdTZey2h1POtOyFgdiWTd01APJAeBDdjz4BjUuG4UHl8oZp+dihXVedN6XRQFEYMe
 +afOXpnEKEicQpAc9H/tC5hf2UsW3tb8rXJN4mky6C3wJQOrPziWIvInkYrYpt8radcUXlnzooq
 9xIaX+uistXL1EzPqHnrSlUs5DPefYpJE8/LAtptEfZN3ErIXqBcWoa7FBrUNl0DyLTph6bPb2U
 sbEIfs5+TG4U9M7P6LQT1c14lkdxFgv/jF0/YQXKvuqIvGdNuTxVbBpU//jtfDmeBhW8j7dgfEQ
 dfPg7uLbQ/Fsg0ha8rSRPeuMoaWeJSlDguFkGMhqCvWRZi6v9MeENIjAIcHpWweT4f3a9YFyIrG
 U/8jSVs35wd+uEylsmCopFcbiQFrpXZCD4QokooVyWONFCQ3v8CAnHbzcShzINW11ALjT1IR5Vt
 wtNiOPXBH9cYWY0FdVBjei/kGsPQ9m8Tq0MnSRotK2iCx1KpwQZkrXTYWvAasyFXnMIV0grRAR2
 MYXZjAwF8NOC1cDhqZBEVTkUwyAH2VFjuqpSYQPXeSjI27cp1eHqsCjRS4Xc+J6qxwvIPCAmXBz
 Wv7fcqrHKWcRHFGqBW5NDaZl75mR
X-Received: by 2002:a05:693c:88db:20b0:386:1920:ea0c with SMTP id
 5a478bee46e88-3861920f023mr10479373eec.37.1795462648830; 
 Mon, 23 Nov 2026 11:37:28 -0800 (PST)
Received: from arch-rock5b ([45.112.0.246]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-385677c0c1dsm41796268eec.21.2026.11.23.11.37.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 11:37:28 -0800 (PST)
From: Anand Moon <linux.amoon@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Anand Moon <linux.amoon@gmail.com>,
	Yixun Lan <dlan@kernel.org>
Subject: [PATCH v2 0/6] riscv: spacemit: Add GPIO and pinctrl support in SPL
Date: Mon, 23 Nov 2026 19:36:58 +0000
Message-ID: <20261123193714.5096-1-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.56.1
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
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series consolidates common U-Boot device tree properties for
SpacemiT K1 boards and enables GPIO and pinctrl support in SPL.

The device tree changes move common early boot properties into shared
DTSI files, reducing duplication between the Banana Pi BPI-F3 and
MusePi Pro boards.

The remaining patches add SPL build support for the SpacemiT K1/K3
GPIO and pinctrl drivers and enable these drivers in the K1 SPL
configuration.

The series consists of six patches:

1. Move common K1 U-Boot nodes into a shared DTSI.
2. Remove redundant MusePi Pro device tree overrides.
3. Move common K1 U-Boot properties into the shared DTSI.
4. Add SPL support for the K1/K3 pinctrl driver.
5. Add SPL support for the K1/K3 GPIO driver.
6. Enable GPIO and pinctrl support in K1 SPL.

Changes in v2:
- Consolidate additional common U-Boot properties into
  spacemit-k1-u-boot.dtsi.
- Reduce duplication in the board-specific DTSI files.
- Retain board-specific configuration where required.

v1: https://patchwork.ozlabs.org/project/uboot/list/?series=530594

Thanks
-Anand 

Anand Moon (6):
  riscv: dts: spacemit: k1: Move common U-Boot nodes to shared DTSI
  riscv: dts: spacemit: k1-musepi-pro: Drop redundant DT overrides
  riscv: dts: spacemit: k1: Move common U-Boot properties to shared DTSI
  pinctrl: spacemit: Add SPL support for K1/K3 pinctrl driver
  gpio: spacemit: Add SPL support for K1/K3 GPIO driver
  riscv: spacemit: k1: Enable GPIO and pinctrl support in SPL

 arch/riscv/dts/k1-bananapi-f3-u-boot.dtsi |  86 ----------------
 arch/riscv/dts/k1-musepi-pro-u-boot.dtsi  | 113 ----------------------
 arch/riscv/dts/spacemit-k1-binman.dtsi    |  29 ++++++
 arch/riscv/dts/spacemit-k1-u-boot.dtsi    |  89 +++++++++++++++++
 configs/spacemit_k1_defconfig             |   6 ++
 drivers/gpio/Kconfig                      |   7 ++
 drivers/pinctrl/spacemit/Kconfig          |   8 ++
 7 files changed, 139 insertions(+), 199 deletions(-)
 create mode 100644 arch/riscv/dts/spacemit-k1-binman.dtsi
 create mode 100644 arch/riscv/dts/spacemit-k1-u-boot.dtsi


base-commit: eb7af371cb8c9964d0551f3b94c7f138debb0cb7
-- 
2.56.1


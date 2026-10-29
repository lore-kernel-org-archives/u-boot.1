Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3905C606A31D
	for <u-boot@archiver.kernel.org>; Thu, 29 Oct 2026 13:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=DV8eAgnR;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=m1NJg6PT
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E290080F7B;
	Thu, 29 Oct 2026 13:47:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xZE8uvIu0N_r; Thu, 29 Oct 2026 13:47:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E6A9280F71
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793281658;
	b=X3uMqCyEl3r2MZf6UyiIvsaHOosHy5X/cTOhMOQ5hIq9///br7UJ+6vybb8HPOrH9zcz
	 drefnEpwRuvC6ErPnc0bJj+Xj0kNTQhgfAZ4E0OeUW0z0IUKM2iV5ZiZlENccKf+EjTV7
	 u6i0/FduR1rWbipFvW8u+X63TvaREj4lCNg4tx6feus92EnFh3WSes4wLcLVu3MvTtSHH
	 sSnO1N38wIyTJbPDCwu0HiEnSIXGokAjmtyO4nyh782kG1TyOSbDlQdIoMMNO7p9WqPRO
	 vjjjoEFnsZxcCAAPGktLQozKqHptAgyhAG92vt0Ahw9eFLuwZSuwBXkloDHI394eGfg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793281658;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=q+1T+3m7Vy77owVo41vHA4WXptCOXm8Ye89/CxY4iaI=;
	b=EnDi8IL7XpilDGVj59CIms1dxi6Ki0ZldHHU98ZsD5ueJKhSxkQ6kqa6Wu1JvC5Urox9
	 oyQ8OZYWQ7U0d7z3AbJGrWph5q8QnDQIuINlO8SbiDPRjAKH8xnlFeV3HbaUgRxAXfcIz
	 jg6Kzal7OQofMdfX97bpVWHeBIUkc8jjI7j22YMBC76g4V9HGtdwgjpgxsZI4IuLuA36Q
	 R8g3VCVJjuqoHefDERXrtBZGZyfCN57tN+yFLHIS2VaUbmCIFppyxLT11W4ybhn1I8OQV
	 Ixam5LtTyVABeP950X5nVHTSy+CZkeyydytX/QgSitcDGAcwaZhg95bTmGSETxkp/1Q==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=m1NJg6PT;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793281658;
	bh=q+1T+3m7Vy77owVo41vHA4WXptCOXm8Ye89/CxY4iaI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DV8eAgnRh+o+c5+iWtXZ6hzuP4CzOJgHLgyN6rkWcdpCh3roKj5gQeDdE45keCW3M
	 Wn6E1Qz1CruvFHm7WY6sG9C2Is/r0dYjQq+b2htGM08RMf1Esf0fLRK3WpyJCuTXXu
	 RUAYgC9uYMTeBlRZBwtcOBRYVsM7GSswV+gpXv8eHICkDhmuexWCD/2PQJZHKeAYRH
	 HMjc5UC4U0zlMVySeUfMBCyp1FmFJGUtSh7JPOWTqCdMypzN/zjstkT1S09s35zvqp
	 3qbLonHhbjKp4+lakHPkooRqxUePMZ2gAgnX+b1A/6SxKIioN0iSphxTPWX+LczjUE
	 fDbrc4CiSxUxA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E6A9280F71;
	Thu, 29 Oct 2026 13:47:37 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 6BB97972
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 13:47:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 51EA880F55
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 13:47:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QqKfvMsbqBSq for <u-boot@lists.u-boot-project.org>;
 Thu, 29 Oct 2026 13:47:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5712880F51
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1336"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793281655;
 b=Dtj4hnzj5ANEUOnnTLwVhlOwCD26nqX894tqTKk9TvJBhTiwmFOa8NDXtMeDPobN+Nl/
 8Ug6npBy+mhGkb7hP4TxR2ngBcaJ+zdABvxAC2J6BqAOkaJLlsgPPPHyZJOJ+Z7Ltx/7s
 r9iFNKoyl0Vp3FaLU961EFgsnNecvvioEChvSUOVmV2rgeXLIO5GrTraUeIYA8SkYMqA0
 sK12GuE2w3Lx+hZpPorq0YxqbpDSCko2GKl9nRTXUdN9IvjuYwp1mO2luoTJYcAO7AqsM
 tkWx88P3lsDxqozRwSFT4FCbsv9bECHEFTbkrC64mvI+9DV/SJJbsnnhPQIHe3vhJLg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793281655;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=q+1T+3m7Vy77owVo41vHA4WXptCOXm8Ye89/CxY4iaI=;
 b=rmidDsIXeMR27/10j3QDbuhdS/nrJo4DiL+7p9j41knW9hI8UTwO9JLOJqBjHn0pAGoZ
 XLTDrhosKlRaIPVH/Xodtj2EtXbJieS3bpmRKzanXBvvR8oaZrGt4F6y/xP2rZ47Wri0k
 4Qmjy6TJrWquYUUBX32/p5b9rx084ymZoOcNktGKP6qgrK0bl0ZZByfo5pVnERIJv9lgw
 z33X1Z05wBWO81gZAw+B2/h+Gp37XwWNd3+7z0qmxRaGicABPX9vaXHvEftmS8UtYiG2B
 xaTMuxJlW05/ytSo3AMaWyDxH59r53o8voAj3n/m3LNahqjdQUXseUxp+7yuJoa78GQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=m1NJg6PT; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1336"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1336; helo=mail-dy1-x1336.google.com;
 envelope-from=linux.amoon@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=m1NJg6PT
Received: from mail-dy1-x1336.google.com (mail-dy1-x1336.google.com
 [IPv6:2607:f8b0:4864:20::1336])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5712880F51
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 13:47:33 +0000 (UTC)
Received: by mail-dy1-x1336.google.com with SMTP id
 5a478bee46e88-33fb4680717so1325170eec.1
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 06:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793281652; x=1793886452;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=q+1T+3m7Vy77owVo41vHA4WXptCOXm8Ye89/CxY4iaI=;
 b=m1NJg6PTICvlR6pqQ9kWVdhTg5+1bGp9JSdBtS6QgZzPgo0pTUWE/NAXLEO4UB+bbN
 MHvwwoohpVvsfyePcucAfUxUyAaRC0lpwBTIVqjg/b+n3aiHMxieor9itc5zmCfsAmkE
 yLCA/80l7DERR+xzB1hj4henc/npBKFiDlWmY0e1d/m8OMSB35/7S9Vnv5iHNr1FqkNU
 hnKZ74K8yc1bCW6ca1AyV/nUzk2p+lS12mxzywuIlnnRlMGBU5Qcfmf7BK0x90u1A71g
 NAlw789Ag66cIB7ZLLVQKJnB5Xfhc4m+OXH55Odol1XorVQwErFnr5bDVFauEcLc6QnT
 /0jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793281652; x=1793886452;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=q+1T+3m7Vy77owVo41vHA4WXptCOXm8Ye89/CxY4iaI=;
 b=nSZPsx2ZZTmF3rpMCbn4qJop3gkDOOXmu/bRGa7q+bcWYQ7YVZxATkTGQQKGBq2Oah
 Y6R3nlB/sumkv453PDDfrDa7wV0nlPKu1ubT6Hi3Jyp6iWyFMeosvntaic91pYI2nvYU
 ExOIY3aujzvoSsaur7n0mCYbraKk0dyBw5ea/r5xn7Ufpapp8QoXcpe5lOjAK3g/05wf
 2SqDjcNwBGjJYMLvzROqvw1uQpeR1JtEij5c6Ij7ScwvSkYOkmO5iWbVVGOQr13kPdxo
 Fe8KARYQZhNLcXOLHf9GleQLezd5SRNVurZvMFmEa1gOrDaubTyRVxlSqowjYC7QFnKj
 Y/lQ==
X-Gm-Message-State: AFq9FYLEbw0Q4gOcOfnXvCbo+otVLOVfqJam2ErPWFYvvQehZk+avoPG
 318yK3s1vlP7DEaEj3d08YcjlYTV+uF1XsbVDxmU7JIlKHjSVUL1DCDifdm78w==
X-Gm-Gg: AYBFou2Z1Hr7yB4NL8yaWNUEjbSUY52ZPqhPL9EY99s81y0JfoyD8l+EqxdThPRfcCW
 j/AR4qOFLZ0m+/JQFpz15uAE3KvDGTLEnRQefSUHENM4hPMZ5DU2+oI7jXls6x8BLdmkhd1hqiX
 AOOFW8udFg5C9DlpoWWVdVUKxPoQmCxgvpBtpttdhFNWr5wrcXzB5dvapRJGcORrkNctLXmxNuq
 77G5dk1u8Z8YZoKLoncyT0O0rcuK03zLPEPT5PfUXgUCXzc/o12wJw6D1ZAJCUljPnf9vQ6XaE4
 vAlTiiEh5cJ2My9tjSG086tzn/yv5XwE/Vr8pPdKXyQNu7qtQvFF/bew4r1ZCzsVMh9TRhZgZbF
 ipOt4cVENNViGmwT+gptOoWnFqrbu14+7Kye5L00Dq+/ofAMhYfKHAAenoZdieMdH/1Y2lwvNLk
 AYi/WMJggGN+Qq+y+AWQZB17M7ujZ3MjaYZxab8QKuvVEbODgDFGeTHBbmzdRL+FAREVH1rNyd0
 S8VRajMlrdqMMmrN+DK4ppBscvzSYr1eXadKTuKfqS5Wrsl5owXBa0JnalSjdMc1ClX2Y6wD62H
 kzZt9KYoTMjLZY/WV709AAGZS49k1w==
X-Received: by 2002:a05:7300:56a7:b0:343:fb75:a5f2 with SMTP id
 5a478bee46e88-36a203ac526mr6728701eec.9.1793281651773; 
 Thu, 29 Oct 2026 06:47:31 -0700 (PDT)
Received: from archl-rock5b ([45.112.0.182]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a2390a812sm18032339eec.14.2026.10.29.06.47.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 06:47:30 -0700 (PDT)
From: Anand Moon <linux.amoon@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Anand Moon <linux.amoon@gmail.com>, Dave Klotz <DaveWK225@protonmail.com>,
 Eric Chung <eric.chung@riscstar.com>,
 Hung-Chun Tseng <alan.tseng.cs@gmail.com>, E Shattow <e@freeshell.de>,
 Yixun Lan <dlan@kernel.org>, Huan Zhou <pericycle.cc@gmail.com>,
 Tim Ouyang <tim609@andestech.com>, Leo Liang <leo.liang@sifive.com>,
 Yao Zi <me@ziyao.cc>, Tom Rini <trini@konsulko.com>,
 Guodong Xu <guodong@riscstar.com>, Raymond Mao <raymond.mao@riscstar.com>,
 u-boot-spacemit@groups.io
Subject: [PATCH v1 1/6] riscv: dts: spacemit: Clean Up K1 U-Boot Device Tree
 for SPL Initialization
Date: Thu, 29 Oct 2026 19:16:50 +0530
Message-ID: <20261029134705.3767-2-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261029134705.3767-1-linux.amoon@gmail.com>
References: <20261029134705.3767-1-linux.amoon@gmail.com>
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Consolidate common SpacemiT K1 U-Boot device tree configuration into
spacemit-k1-u-boot.dtsi, replacing the MusePi Pro and Banana Pi F3
specific overlays with a shared K1 configuration.

Separate the Binman layout and DDR firmware packaging into
spacemit-k1-binman.dtsi, keeping image generation independent of
board-specific bring-up.

Keep common clock, UART, I2C, GPIO, and pinctrl settings in the shared
DTSI to support SPL initialization and reduce duplicated board-specific
configuration.

Move the I2C8 regulator configuration to dts/upstream so regulators
can be mapped by name to the corresponding nodes in the board device
trees.

These changes provide a cleaner foundation for migrating peripheral
configuration to the upstream device trees while minimizing duplicated
settings across SpacemiT K1 boards.

Cc: Dave Klotz <DaveWK225@protonmail.com>
Cc: Eric Chung <eric.chung@riscstar.com>
Cc: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
Cc: E Shattow <e@freeshell.de>
Cc: Yixun Lan <dlan@kernel.org>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 arch/riscv/dts/k1-bananapi-f3-u-boot.dtsi     | 121 ------------------
 arch/riscv/dts/spacemit-k1-binman.dtsi        |  29 +++++
 ...ro-u-boot.dtsi => spacemit-k1-u-boot.dtsi} |  80 +++++-------
 3 files changed, 59 insertions(+), 171 deletions(-)
 delete mode 100644 arch/riscv/dts/k1-bananapi-f3-u-boot.dtsi
 create mode 100644 arch/riscv/dts/spacemit-k1-binman.dtsi
 rename arch/riscv/dts/{k1-musepi-pro-u-boot.dtsi => spacemit-k1-u-boot.dtsi} (66%)

diff --git a/arch/riscv/dts/k1-bananapi-f3-u-boot.dtsi b/arch/riscv/dts/k1-bananapi-f3-u-boot.dtsi
deleted file mode 100644
index 3077cdee55d..00000000000
--- a/arch/riscv/dts/k1-bananapi-f3-u-boot.dtsi
+++ /dev/null
@@ -1,121 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+ OR MIT
-/*
- * Copyright (C) 2026 RISCstar Ltd.
- */
-
-#include "binman.dtsi"
-
-/ {
-	memory@0 {
-		device_type = "memory";
-		reg = <0x00000000 0x00000000 0x00000000 0x80000000>;
-	};
-};
-
-&uart0 {
-	bootph-pre-ram;
-};
-
-&osc_32k {
-	bootph-pre-ram;
-};
-
-&vctcxo_1m {
-	bootph-pre-ram;
-};
-
-&vctcxo_3m {
-	bootph-pre-ram;
-};
-
-&vctcxo_24m {
-	bootph-pre-ram;
-};
-
-&syscon_mpmu {
-	bootph-pre-ram;
-};
-
-&pll {
-	bootph-pre-ram;
-};
-
-&syscon_apmu {
-	bootph-pre-ram;
-};
-
-&syscon_apbc {
-	bootph-pre-ram;
-};
-
-&i2c2 {
-	bootph-pre-ram;
-
-	eeprom@50 {
-		bootph-pre-ram;
-	};
-};
-
-/*
- * The kernel pmic@41 nodes use the standard regulator-* properties only;
- * U-Boot's regulator framework looks up suppliers by `regulator-name`.
- * Carry the U-Boot-specific names (vdd_core / vdd_1v8 / vdd_1v8_mmc) here
- * so SPL can program the bucks that DDR training depends on.
- */
-&i2c8 {
-	bootph-pre-ram;
-
-	pmic@41 {
-		bootph-pre-ram;
-
-		regulators {
-			buck1 {
-				regulator-name = "vdd_core";
-				bootph-pre-ram;
-			};
-
-			buck3 {
-				regulator-name = "vdd_1v8";
-				bootph-pre-ram;
-			};
-
-			aldo1 {
-				regulator-name = "vdd_1v8_mmc";
-				bootph-pre-ram;
-			};
-		};
-	};
-};
-
-&emmc {
-	bootph-pre-ram;
-	max-frequency = <204800000>;
-};
-
-&sdhci0 {
-	bootph-pre-ram;
-	max-frequency = <204800000>;
-};
-
-&binman {
-	u-boot-spl-ddr {
-		type = "section";
-		filename = "u-boot-spl-ddr.bin";
-		pad-byte = <0xff>;
-
-		u-boot-spl {
-		};
-
-		ddr-fw {
-			type = "blob";
-			filename = "ddr_fw.bin";
-			align = <64>;
-		};
-
-		u-boot-any {
-			type = "section";
-			size = <0>;
-			offset = <0>;
-		};
-	};
-};
diff --git a/arch/riscv/dts/spacemit-k1-binman.dtsi b/arch/riscv/dts/spacemit-k1-binman.dtsi
new file mode 100644
index 00000000000..2ff6bd2cc43
--- /dev/null
+++ b/arch/riscv/dts/spacemit-k1-binman.dtsi
@@ -0,0 +1,29 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Copyright (C) 2026 RISCstar Ltd.
+ */
+
+#include "binman.dtsi"
+
+&binman {
+	u-boot-spl-ddr {
+		type = "section";
+		filename = "u-boot-spl-ddr.bin";
+		pad-byte = <0xff>;
+
+		u-boot-spl {
+		};
+
+		ddr-fw {
+			type = "blob";
+			filename = "ddr_fw.bin";
+			align = <64>;
+		};
+
+		u-boot-any {
+			type = "section";
+			size = <0>;
+			offset = <0>;
+		};
+	};
+};
diff --git a/arch/riscv/dts/k1-musepi-pro-u-boot.dtsi b/arch/riscv/dts/spacemit-k1-u-boot.dtsi
similarity index 66%
rename from arch/riscv/dts/k1-musepi-pro-u-boot.dtsi
rename to arch/riscv/dts/spacemit-k1-u-boot.dtsi
index d6299c96949..94107da3e5f 100644
--- a/arch/riscv/dts/k1-musepi-pro-u-boot.dtsi
+++ b/arch/riscv/dts/spacemit-k1-u-boot.dtsi
@@ -4,12 +4,13 @@
  */
 
 #include <dt-bindings/clock/spacemit,k1-syscon.h>
-#include "binman.dtsi"
 
 / {
 	aliases {
 		console = &uart0;
 		serial0 = &uart0;
+		mmc0 = &emmc;
+		mmc1 = &sdhci0;
 	};
 
 	chosen {
@@ -83,77 +84,56 @@
 	};
 };
 
-&i2c8 {
+&qspi {
 	bootph-pre-ram;
 	status = "okay";
 
-	pmic@41 {
+	flash@0 {
+		reg = <0>;
+		spi-max-frequency = <50000000>;
 		bootph-pre-ram;
-		compatible = "spacemit,p1";
-		reg = <0x41>;
-		interrupts = <64>;
 		status = "okay";
-
-		regulators {
-			buck1 {
-				bootph-pre-ram;
-				regulator-name = "vdd_core";
-			};
-
-			buck3_1v8: buck3 {
-				bootph-pre-ram;
-				regulator-name = "vdd_1v8";
-			};
-
-			aldo1 {
-				bootph-pre-ram;
-				regulator-name = "vdd_1v8_mmc";
-			};
-
-		};
 	};
 };
 
-&qspi {
+&qspi_cfg {
 	bootph-pre-ram;
-	status = "okay";
-
-	flash@0 {
-		bootph-pre-ram;
-		status = "okay";
-	};
 };
 
 &emmc {
+	compatible = "spacemit,k1-sdhci";
 	bootph-pre-ram;
 	max-frequency = <204800000>;
+	status = "okay";
 };
 
 &sdhci0 {
+	compatible = "spacemit,k1-sdhci";
 	bootph-pre-ram;
-	cd-gpios = <&gpio K1_GPIO(80) (GPIO_ACTIVE_LOW | GPIO_PULL_UP)>;
+	pinctrl-names = "default", "uhs";
 	max-frequency = <204800000>;
+	pinctrl-0 = <&mmc1_cfg>;
+	pinctrl-1 = <&mmc1_uhs_cfg>;
+	status = "okay";
 };
 
-&binman {
-	u-boot-spl-ddr {
-		type = "section";
-		filename = "u-boot-spl-ddr.bin";
-		pad-byte = <0xff>;
+&pinctrl {
+	bootph-pre-ram;
+	status = "okay";
+};
 
-		u-boot-spl {
-		};
+&gpio {
+	bootph-pre-ram;
+	status = "okay";
+};
 
-		ddr-fw {
-			type = "blob";
-			filename = "ddr_fw.bin";
-			align = <64>;
-		};
+&mmc1_cfg {
+	bootph-pre-ram;
+};
 
-		u-boot-any {
-			type = "section";
-			size = <0>;
-			offset = <0>;
-		};
-	};
+&mmc1_uhs_cfg {
+	bootph-pre-ram;
 };
+
+/* Keep the existing binman layout and DDR firmware section. */
+#include "spacemit-k1-binman.dtsi"
-- 
2.56.0


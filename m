Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 044DC606A31C
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 10:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=coknyHz+;
	dkim=pass (2048-bit key) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256 header.s=s2025 header.b=VxZ/qmEz
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D32DD606CA;
	Mon, 16 Nov 2026 10:28:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RbAZNLRGpWN7; Mon, 16 Nov 2026 10:28:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org F1F5D6071E
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794824902;
	b=L2eQ606ttgleUb0Pp/0w4TuMsfPfXjFi4V6NW9/jaEj/gQoki3oFsmrGTK2KdkCqOF4b
	 lgDtfIdryIaTfp67AQtw2shucDS1BnKMhB5HLc63prrLpaVhMsuWICphydoPq4r8aswje
	 B9sQ2gBJNe2MTmu5IeZwEy9F7Z2CtJ56jna5t2DvwGqBky12boP+xSXOKUbw5jeZNGhM6
	 xZqiO3+8I+F+ZjQJXYBw7ZwaKSOb5yyFloDrtTMMxkaQg+/c9NlSRluTZQX0L7rEVqZF/
	 +zh/rDxQxHSTVpwlGIXf/inwPXBheAF60WF8ocbY9aPtp9h4QW94lOXjBLpaHl+qTVw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794824902;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=d2KEsTWj+jgPV6SrhtL7+OxEPanXyY7qi5PnHYNC1bg=;
	b=hcYCz48VEi3qUtNegDGlhT/85YIFNt5iMlN3AtBLJmfl14QEZ8XjKWDZx1NCT82Itz4N
	 OoT7KOm1Eqz6AUP1243dHxioNETDQQhTexxaLBaR/P4J/dHAQUshQWfggYQ5Lp4sPUUJO
	 88RYUivVgNxlp1p3zdjuIHq11ObwOgt0o06Bxpir3Gtd2/NIyymJ0lXfw3jMkukMJULWa
	 g8ZQjUqZkkL3fBnk3XZfqTJilDi+5A+sKuXX3tyNdiAreFPzTp6bxnwi03v4Fj9hIiLXP
	 52bjaTgUdDdvYbKgLtQDcnkBUadK/zgAP+c2Xjmn5dgD++W7BxYN+qhpoSuiBsmxzIQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=freeshell.de;
	dkim=pass header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256 header.s=s2025 header.b="VxZ/qmEz";
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794824902;
	bh=d2KEsTWj+jgPV6SrhtL7+OxEPanXyY7qi5PnHYNC1bg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=coknyHz+kdjPKaQFIeUC5RPgVF+gEOpmz+ovYIoNvjOerw+/NS3v09DBCVu92lKZC
	 /tShtyk0mshFXsRg58zAiGXqsy6lPo0mgRa3LRm5RPYqfMe6+EcgGTt3uzJaGaFaVW
	 TYFZ+FmgcHtrMwPt0WfmPYz3rPB5+ChgeVKkVtkQCj3jaNB0bRp0bJZCjVnGwi+0Z6
	 q05Gxf2MDnXa4Kfc+SzewE/OXIKdfHAV83G6WzUBvRIO6NAv7SkhQvU+OXDGOR9eIR
	 yPSrYR3eHxwCJoouEq+vATIsWwVTC255c+AYQvA6wSTDcKJ0wFR+2m0kiUUf08basU
	 ow6Jrwbu3WKLA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id F1F5D6071E;
	Mon, 16 Nov 2026 10:28:21 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id B92A94DD
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 10:28:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id AA91F6071E
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 10:28:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uOM5ce6ZrvDo for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 10:28:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 7F38F606CA
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a01:4f8:231:482b::2"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:4f8:231:482b::2;
 helo=freeshell.de; envelope-from=e@freeshell.de; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=freeshell.de
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b=VxZ/qmEz
Received: from freeshell.de (freeshell.de [IPv6:2a01:4f8:231:482b::2])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7F38F606CA
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 10:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
 s=s2025; t=1794824855;
 bh=d2KEsTWj+jgPV6SrhtL7+OxEPanXyY7qi5PnHYNC1bg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=VxZ/qmEzY/CVflpSRyTX3EcepwclPaQW/7sseJqqoZLqf0BYy+j2tpBfr/cXA7jIc
 ChsRnxJ5TL7ox/UIphUaZ3W+iREL5e0pJgM+WiCduyccIn83WF6kxaLQ6cQIFyX+ri
 MqXBsnzaPErFKotHQlfBhRlynFULT5A1vmulh4kEh11I52bMteYflmIOrCdmr34Mbs
 UxTrYFjBn4js6ZIz8/OJdCH4mQHBZnIDdy23hM1kUZBtu0x5JTKMiLI5zm+IrwxhFI
 zl8N0Fu30ARumMz7kSRNeXI6FNwt8dMmpUcCeTc1MrR6Zau3ekVngJ2dIA41kMx0/g
 t2tdpHY8W6rmg==
Received: from hay.lan (unknown [IPv6:2605:59ca:364f:d400:6ecf:39ff:fe00:8375])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 4AEC8B2214DE;
 Mon, 16 Nov 2026 11:27:33 +0100 (CET)
From: E Shattow <e@freeshell.de>
To: U-Boot Mailing List <u-boot@lists.u-boot-project.org>,
 Sumit Garg <sumit.garg@kernel.org>, Yixun Lan <dlan@kernel.org>,
 Tim Ouyang <tim609@andestech.com>, Leo Liang <leo.liang@sifive.com>,
 Yao Zi <me@ziyao.cc>, Tom Rini <trini@konsulko.com>,
 Guodong Xu <guodong@riscstar.com>
Cc: E Shattow <e@freeshell.de>,
	Junhui Liu <junhui.liu@pigmoral.tech>
Subject: [PATCH v3 2/4] riscv: dts: spacemit: k3: Drop guest properties from
 M-level IMSIC
Date: Mon, 16 Nov 2026 02:26:28 -0800
Message-ID: <20261116102653.36927-3-e@freeshell.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261116102653.36927-1-e@freeshell.de>
References: <20261116102653.36927-1-e@freeshell.de>
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
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Junhui Liu <junhui.liu@pigmoral.tech>

The mimsic node describes the machine-level IMSIC, whose MMIO region is
0x10000 (64 KiB) for all 8 harts. However, the node also specifies
riscv,guest-index-bits = <6>, and per the AIA specification the
per-hart stride is 2^(guest-index-bits + 12) bytes when guest interrupt
files exist, i.e. 2^(6 + 12) = 256 KiB per hart and 2 MiB for all 8
harts. The described region cannot hold even a single hart's files, so
the node contradicts itself. OpenSBI enforces exactly this constraint in
imsic_data_check() and rejects the node with -EINVAL, preventing the
M-level IMSIC from initializing:

  fdt_driver_init_by_offset: interrupt-controller@f1000000 (riscv,imsics) init failed: -3
  init_coldboot: irqchip init failed (error -3)

Moreover, guest interrupt files exist to act as the supervisor-level
interrupt files of virtual harts; there is no machine-level counterpart.
riscv,num-guest-ids is equally meaningless for the machine-level IMSIC.

Drop both "riscv,guest-index-bits" and "riscv,num-guest-ids" properties
from the mimsic node so the node matches the actual hardware layout.

Fixes: 56f37e391a62 ("riscv: dts: spacemit: add initial support for K3 SoC")
Signed-off-by: Junhui Liu <junhui.liu@pigmoral.tech>
Reviewed-by: Yixun Lan <dlan@kernel.org>
Link: https://patch.msgid.link/20260729-k3-mimsic-fix-v1-1-368c0aec04b9@pigmoral.tech
Signed-off-by: Yixun Lan <dlan@kernel.org>

[ upstream commit: 01e2f07c44fc46180bdb10e70506f8acf44a53dd ]

(cherry picked from commit d44cd4bcf93bb5c99a4762ed5f11656b93f9e5cc)
---
 dts/upstream/src/riscv/spacemit/k3.dtsi | 2 --
 1 file changed, 2 deletions(-)

diff --git a/dts/upstream/src/riscv/spacemit/k3.dtsi b/dts/upstream/src/riscv/spacemit/k3.dtsi
index c3f2dce0969c..2d022e1364f1 100644
--- a/dts/upstream/src/riscv/spacemit/k3.dtsi
+++ b/dts/upstream/src/riscv/spacemit/k3.dtsi
@@ -1287,9 +1287,7 @@
 					      <&cpu4_intc 11>, <&cpu5_intc 11>,
 					      <&cpu6_intc 11>, <&cpu7_intc 11>;
 			msi-controller;
-			riscv,guest-index-bits = <6>;
 			riscv,hart-index-bits = <4>;
-			riscv,num-guest-ids = <511>;
 			riscv,num-ids = <511>;
 			status = "reserved";
 		};
-- 
2.53.0


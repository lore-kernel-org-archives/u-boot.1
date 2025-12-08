Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19ABDD3B7E2
	for <u-boot@archiver.kernel.org>; Mon,  8 Dec 2025 18:47:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A26383966;
	Mon,  8 Dec 2025 19:47:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=ziyao.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=tsmtp0001.email header.i=@tsmtp0001.email header.b="FLu3D2Jd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 93BD083981; Mon,  8 Dec 2025 19:17:36 +0100 (CET)
Received: from mail82.out.titan.email (mail82.out.titan.email [3.216.99.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B504836C8
 for <u-boot@lists.denx.de>; Mon,  8 Dec 2025 19:17:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=ziyao.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=me@ziyao.cc
Received: from localhost (localhost [127.0.0.1])
 by smtp-out.flockmail.com (Postfix) with ESMTP id 4dQ9F81Jbyz2xHB;
 Mon,  8 Dec 2025 18:17:32 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; bh=6EMxjtv+OBigCRBvipgdwca7lr++fbmPdG7swV4GMKs=; 
 c=relaxed/relaxed; d=tsmtp0001.email;
 h=from:to:mime-version:cc:subject:date:message-id:from:to:cc:subject:date:message-id:in-reply-to:reply-to:references;
 q=dns/txt; s=titan1; t=1765217852; v=1;
 b=FLu3D2JdKiV1MfPr/Ag4VW1kLjY4QZizw8JajQoDoC+3wxscbxdWDz3WomRw7fid5OmqqnPP
 qY94jwlKQxLdsZVFM1cAlG/T1R0Ax43bgHHqyUXJtmZKHsSKf0vnmn96OSt3uViRtYgy29Y2tq3
 +ZS2goyRDulJ4WJ9xBJaVX2M=
Received: from ketchup (unknown [117.171.66.90])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by smtp-out.flockmail.com (Postfix) with ESMTPSA id 4dQ9F65JLgz2xCX;
 Mon,  8 Dec 2025 18:17:30 +0000 (UTC)
Feedback-ID: :me@ziyao.cc:ziyao.cc:flockmailId
From: Yao Zi <me@ziyao.cc>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
	Yao Zi <me@ziyao.cc>
Subject: [PATCH] MAINTAINERS: update my email address
Date: Mon,  8 Dec 2025 18:17:08 +0000
Message-ID: <20251208181709.39819-1-me@ziyao.cc>
X-Mailer: git-send-email 2.51.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-F-Verdict: SPFVALID
X-Titan-Src-Out: 1765217852029272322.27573.8836042698919584857@prod-use1-smtp-out1001.
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.4 cv=a8/K9VSF c=1 sm=1 tr=0 ts=6937163c
 a=rBp+3XZz9uO5KTvnfbZ58A==:117 a=rBp+3XZz9uO5KTvnfbZ58A==:17
 a=IkcTkHD0fZMA:10 a=MKtGQD3n3ToA:10 a=1oJP67jkp3AA:10 a=CEWIc4RMnpUA:10
 a=LpNgXrTXAAAA:8 a=B-eU9YkUAAAA:8 a=3iA4PtbMAAAA:8 a=8AirrxEcAAAA:8
 a=6ohNodAXAAAA:8 a=hD80L64hAAAA:8 a=8KfAxfXsqzVHh88hsYAA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=LqOpv0_-CX5VL_7kjZO3:22
 a=5R5j_Wwxudb6U4qMCugr:22 a=ST-jHhOKWsTCqRlWije3:22
 a=0gLUg1G2xj6MhZ7RLP3J:22 a=3z85VNIBY5UIEeAh_hcH:22
 a=NWVoK91CQySWRX1oVYDe:22
X-Mailman-Approved-At: Mon, 08 Dec 2025 19:47:42 +0100
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

My old mail address, ziyao@disroot.org, has stopped working. Switch to
my new address, me@ziyao.cc, and map it in .mailmap.

Signed-off-by: Yao Zi <me@ziyao.cc>
---
 .mailmap    | 1 +
 MAINTAINERS | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/.mailmap b/.mailmap
index 0e01452a70cb..7b0d730b618a 100644
--- a/.mailmap
+++ b/.mailmap
@@ -159,6 +159,7 @@ Wolfgang Denk <wd@denx.de> <wd@pollux.denx.de>
 Wolfgang Denk <wd@denx.de> <wd@xpert.denx.de>
 Wolfgang Denk <wd@denx.de> <wdenk>
 Wolfgang Wallner <wolfgang.wallner@at.abb.com> <wolfgang.wallner@br-automation.com>
+Yao Zi <me@ziyao.cc> <ziyao@disroot.org>
 York Sun <york.sun@nxp.com>
 York Sun <yorksun@freescale.com>
 Łukasz Majewski <l.majewski@samsung.com>
diff --git a/MAINTAINERS b/MAINTAINERS
index 1789f023631a..6ce0bbce13dd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1605,7 +1605,7 @@ F:	drivers/pinctrl/pinctrl-k210.c
 F:	include/k210/
 
 RISC-V T-HEAD TH1520
-M:	Yao Zi <ziyao@disroot.org>
+M:	Yao Zi <me@ziyao.cc>
 S:	Maintained
 F:	arch/riscv/cpu/th1520/
 F:	drivers/clk/thead/clk-th1520-ap.c
-- 
2.51.2


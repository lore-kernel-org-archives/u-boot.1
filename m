Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4A3EC0218A
	for <u-boot@archiver.kernel.org>; Mon, 27 Jan 2025 23:03:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4577A8186D;
	Tue, 28 Jan 2025 00:03:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=samcday.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=samcday.com header.i=@samcday.com header.b="Tj21xjCt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C42C68186D; Tue, 28 Jan 2025 00:03:05 +0100 (CET)
Received: from mail-10625.protonmail.ch (mail-10625.protonmail.ch
 [79.135.106.25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D7AD981974
 for <u-boot@lists.denx.de>; Tue, 28 Jan 2025 00:03:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=samcday.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=me@samcday.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samcday.com;
 s=protonmail3; t=1738018980; x=1738278180;
 bh=7qERrANn0BiDPpV31aSjs/0qt9YUAYSWY0EbDXOw3II=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
 b=Tj21xjCt8P4jB2TMRspOEI3depMUZcZV1SHiei9uwpKYX9tNFCCF/QidnN8hn9O30
 4n32ME9Hw6rej3GioiXFi4HZOosGA45x2Pi+1zSNVygwlHtBHIOfwZDJy9L6Xss4gj
 Hh27feZWVDE5HjukcHgE1ypLvxBrt4sRg2QtEGyFvIr6J4wBr/4oypN3/E30zDg5YZ
 O1d3qYcGHpMEiEtFouAZ+9XAnAfbKXGHA4al9g+DSMhBVPpcQIedo0xZSOXSacL2nq
 8xthYmWNTrPD2xEQquMDsx9Vn9KonH85NUlYSAdpwvaEu5qi7bODCH8716TVJK8zSR
 uo+S6ob7/Bk1g==
Date: Mon, 27 Jan 2025 23:02:53 +0000
To: Tom Rini <trini@konsulko.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Sumit Garg <sumit.garg@linaro.org>,
 Mark Kettenis <mark.kettenis@xs4all.nl>
From: Sam Day <me@samcday.com>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, Sam Day <me@samcday.com>
Subject: [PATCH 1/6] armv8: spin_table: Fix missing includes
Message-ID: <20250128-msm8916-smp-support-v1-1-39587f18cf0c@samcday.com>
In-Reply-To: <20250128-msm8916-smp-support-v1-0-39587f18cf0c@samcday.com>
References: <20250128-msm8916-smp-support-v1-0-39587f18cf0c@samcday.com>
Feedback-ID: 25366008:user:proton
X-Pm-Message-ID: 3e904534a681feab702af92267c773f7f8b7c3a5
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

Dropping the common.h header resulted in the spin table header missing
asm/types.h and the source unit missing the errno.h includes.

Fixes: 7410cde67de ("arm: Remove <common.h> and add needed includes")
Signed-off-by: Sam Day <me@samcday.com>
---
 arch/arm/cpu/armv8/spin_table.c   | 1 +
 arch/arm/include/asm/spin_table.h | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/arch/arm/cpu/armv8/spin_table.c b/arch/arm/cpu/armv8/spin_tabl=
e.c
index 485294b88d0ac5516f58fb616ca59eebe30ef022..13b300f5c67a6dd257b2cb53350=
a7b5bafa3db96 100644
--- a/arch/arm/cpu/armv8/spin_table.c
+++ b/arch/arm/cpu/armv8/spin_table.c
@@ -6,6 +6,7 @@
=20
 #include <linux/libfdt.h>
 #include <asm/spin_table.h>
+#include <errno.h>
=20
 int spin_table_update_dt(void *fdt)
 {
diff --git a/arch/arm/include/asm/spin_table.h b/arch/arm/include/asm/spin_=
table.h
index dec18c6e5c1ba15c8f96ccae8e9bb5415c845a5b..8fc61237e07559f267e1da1fbc8=
ee646ef08721f 100644
--- a/arch/arm/include/asm/spin_table.h
+++ b/arch/arm/include/asm/spin_table.h
@@ -3,6 +3,8 @@
 #ifndef __ASM_SPIN_TABLE_H__
 #define __ASM_SPIN_TABLE_H__
=20
+#include <asm/types.h>
+
 extern u64 spin_table_cpu_release_addr;
 extern char spin_table_reserve_begin;
 extern char spin_table_reserve_end;

--=20
2.47.1



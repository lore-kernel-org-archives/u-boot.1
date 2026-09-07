Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E17AC79F99
	for <u-boot@archiver.kernel.org>; Mon,  7 Sep 2026 10:17:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1775E80BCA;
	Mon,  7 Sep 2026 10:17:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eyglSpiLpYui; Mon,  7 Sep 2026 10:17:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 23F0E80BD4
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788776260;
	b=kfV1kiTMOiaGmEGCF59RDT/cwqRCmyO+orc/iy+p2q5rs0+M32/sy9euqpr/Ryqu4gC9
	 w4ZVpLj1jrvtpuZBk9L31RQry7mIC4M1GK+TagiQZXb9ZCS1V0TfqX9oF8DDKLtOd5523
	 hsUiHczGVl6LWxciWomtAOUNia5UuhoOLvy57vpVPFNs8AhiyQLg69GB+yliY54AEMoxB
	 pKI+0u34EJj3QP6odeYfhzumbsAM3LGQ+7s0SfrXb85NUGfO8CRKoaK7UgamXesHTPe5L
	 /qoIWTXiXB7gb5a2yKAJAJ6XOZLtKF71PAqh2EfNmSdAXqK/GPuFM/CuBBY0ccm7KQA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788776260;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Virus-Scanned:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=LNVGdTUww3zmbqUbvqQOJf58pqyryfuZQ+HuBKUhV7g=;
	b=tasqptnTI66RQ1zPY3JApqgcwNR5JOp9CTdDFaJi3/D8Q3kJPhu5VQTzSJbP1NRYZ6Nz
	 0wlAEXgHoJs91JgjwYwCbFKHjfPHMzCGb1kgrKj+GtvZCRLvVr/w9mxHqsNGFonrDmOTG
	 joGBJ/v4f48WA9wNJHCUFyfHOcIUu6Upi5C0us3ds2S8Dy/x2pziOZLXSblw0mKWubEt9
	 j6PrZY9OpNvjWgYAceYKCnKcYXdg/sZhlvFyZYQoJ1VR05I6jfWU0t7wCJCndWZvvJAa4
	 w2Fnr0+4+rnmX8qi0O8Uzr2HAvgMbct0Or6hHVZoeGKNyDIt/u8ya8zga+06gXM+b4A==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788776260;
	bh=LNVGdTUww3zmbqUbvqQOJf58pqyryfuZQ+HuBKUhV7g=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=pqI28Wc3QPVFxxCj7HwQgJw8bQ0NALmkNhd4udIAq9njOBV4Q16KVYMEBP2V7zIRs
	 ZABIYQ/ukroK/shxrq9jVvM3L2bkaZUxetTSt9LAHpMl6rJb8zFYUI3ic5LntNQe5Z
	 BdoZXOBTWwstVF668I8vLFaiNOw/KvFk2xj7cuCsCseuD7XvNhmuqTh2wtwLzZDd/h
	 hl7v3JQkVzLA8Nb4jv/HrQCTj8pP8rFcLF4BpqhcTBVh3/+P3QT45h/Wzm0hdCQ+HQ
	 66tSVP5E99Cxnw0aDwquMj6RymB/jjsHEX3v7Cg9vDvvtb+B6UUJy2g5HKyHPbv5fj
	 d6xCOKCFmraeg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 23F0E80BD4;
	Mon,  7 Sep 2026 10:17:40 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 4321349D
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 10:17:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 34DE540566
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 10:17:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hkkedLxZzZv2 for <u-boot@lists.u-boot-project.org>;
 Mon,  7 Sep 2026 10:17:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 73D1940564
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=188.40.3.216
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788776257;
 b=D0+5SUUeK9igugOY40gPMrw6dVyqvaiym/pWb/3t/+SIUptHDzrQrtfsoJtEEukye51G
 J87flKaha1QRmF5XA7YZ443hpMiluPQOdf/CvlgcGHikRHYjkerfTXu3pKJXenlMWRzLz
 Z0w880IEg0aW/HtAL2szJjFahQClnIn5SweHDWii16ql7VGqJtW1fzQBIj+05APxmR8fD
 XrbJCJHsJPQ/ZbSWygW3HaKcDvZAY51xe25n6yPzwC39VttYjKAsAVJ9q3InZzz65snjf
 xzAfm3rqVigvy8wnt0x8Mf+RFfYFY2ZzCf3iLu5k1LCqKpwBHqBPDaJ+csKlRcvTpug==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788776257;
 h=Received-SPF:DKIM-Signature:Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Virus-Scanned;
 bh=LNVGdTUww3zmbqUbvqQOJf58pqyryfuZQ+HuBKUhV7g=;
 b=DPti3+ejW8xCB/REvgEqGBqGGGJKB7LWF+lgNoGtfs6VpisVePbxJyiW74gRfBTlOyYW
 4l+wxcyqG/9niq4mh+GxDzAejxpxXU+PZNE4z+rfcVKvN+6PyNLg5kpDtkN7TS9b27QDX
 nW79EHz7UQ3Q4JzhzfXOs1FsRsgDIdogP9BQy1MgIbRzKI5jTkf7bpVOIacFiEzgtT/gg
 SGg7/Xg7qoLhnDjQ9jhayJoD3VnJvgv3Lbh+wr/9OV6J3yY2dKGgUFuB6A0Bw7+unkbZb
 qbb0g+Lcc6p1xzOWTLYQzhTbTFZM9wOHUicMPRRJrSyJALHFmMeT9TaLFFyRdRZwEow==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=ew.tq-group.com; 
 dkim=pass header.d=ew.tq-group.com header.i=@ew.tq-group.com
 header.a=rsa-sha256 header.s=default2602 header.b="aAgloD/S"; 
 arc=none smtp.remote-ip=188.40.3.216
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=188.40.3.216;
 helo=www537.your-server.de; envelope-from=nora.schiffer@ew.tq-group.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com
 header.a=rsa-sha256 header.s=default2602 header.b=aAgloD/S
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 73D1940564
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 10:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Content-Transfer-Encoding:Content-Type:
 MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References;
 bh=LNVGdTUww3zmbqUbvqQOJf58pqyryfuZQ+HuBKUhV7g=; b=aAgloD/Sf3v3yu9l4TIq4WnWBj
 GbvNvJE86aAmeY5Mry+dbBk5qwj99zGwDIAzODoC5SjGhDBTyiQGGbCnNpJqUsWGGGPHDvLuSA/0a
 Hr19Meje06006KNklvS5VCkSVlJphVf5nn8uDNzfHQrz+0XjxJgDQKcGvXcl19qUFBP0HyvrketYk
 zbbh9BKY94ncvoK6RR+DM0PNzt1khRQ0tob1eBKLzYpYART1/sIHXqdBuVqHqyXDnYWc+qQBdOIik
 lIndLd/z3FEZtXRa1gHiYP3ELqaC9ctVFA2kb5cA44s+sBBPa/YsZxDRbz2xSJUJEniFYMXHUKFVQ
 TUZO4vGQ==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <nora.schiffer@ew.tq-group.com>)
 id 1x3WPh-000N5R-22; Mon, 07 Sep 2026 12:17:21 +0200
Received: from localhost ([127.0.0.1])
 by sslproxy03.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <nora.schiffer@ew.tq-group.com>)
 id 1x3WPh-000GM7-0o; Mon, 07 Sep 2026 12:17:21 +0200
From: Nora Schiffer <nora.schiffer@ew.tq-group.com>
To: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@ew.tq-group.com,
 u-boot@lists.u-boot-project.org,
 Nora Schiffer <nora.schiffer@ew.tq-group.com>
Subject: [PATCH] arm: mx7: Change IVT/DCD address to 0x911000
Date: Mon,  7 Sep 2026 12:16:56 +0200
Message-ID: <20260907101656.30039-1-nora.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28116/Mon Sep  7 08:24:32 2026)
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

Addresses below 0x911000 must be avoided to work around ERR011166 ("OCRAM:
The first 4K of OCRAM (0x910000 - 0x910fff) is not available during boot
time"). In particular, we have seen boot failures caused by this when
HAB is enabled, but there may be other factors that influence it.

As the IVT/DCD header is 4KiB and SPL_TEXT_BASE is 0x912000, this just
removes the unused space between header and text and does not reduce the
maximum SPL size. The SPL memory layout notes are updated to account
for the change, also rewording the text to make it clearer.

A similar change (without the doc update) can also be found in the NXP's
vendor U-Boot branches.

Signed-off-by: Nora Schiffer <nora.schiffer@ew.tq-group.com>
---
 arch/arm/mach-imx/Kconfig |  3 ++-
 doc/imx/common/imx7.txt   | 40 +++++++++++++++++++++------------------
 2 files changed, 24 insertions(+), 19 deletions(-)

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 561f1ee044a..b59d39a5f6d 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -217,8 +217,9 @@ config SPL_IMX_ROMAPI_LOADADDR
 
 config IMX_DCD_ADDR
 	hex "DCD Blocks location on the image"
-	default 0x00910000 if !ARCH_MX7ULP
+	default 0x00911000 if ARCH_MX7
 	default 0x2f010000 if ARCH_MX7ULP
+	default 0x00910000
 	help
 	  Indicates where the Device Configuration Data, a binary table used by
 	  the ROM code to configure the device at early boot stage, is located.
diff --git a/doc/imx/common/imx7.txt b/doc/imx/common/imx7.txt
index b9db10341ad..622df90b3a0 100644
--- a/doc/imx/common/imx7.txt
+++ b/doc/imx/common/imx7.txt
@@ -2,22 +2,26 @@ U-Boot for Freescale i.MX7
 
 SPL Stack size and location notes
 ---------------------------------
+
 See figure 6-22 in i.MX 7Dual/Solo Reference manuals:
-  - IMX7D/S OCRAM free area RAM (OCRAM) is from 0x00910000 to
-    0x00946C00.
-  - Set the stack at the end of the free area section, at 0x00946BB8.
-  - The BOOT ROM loads what they consider the firmware image
-    which consists of a 4K header in front of us that contains the IVT, DCD
-    and some padding. However, the manual also states that the ROM uses the
-    OCRAM_EPCD and OCRAM_PXP areas for itself. While the SPL is free to use
-    this range for stack and malloc, the SPL itself must fit below 0x920000,
-    or the image will be truncated in at least some boot modes like USB SDP.
-    Thus our max size is really 0x00920000 - 0x00912000. If necessary,
-    CONFIG_SPL_TEXT_BASE could be moved to 0x00911000 to gain 4KB of space
-    for the SPL, but 56KB should be more than enough for the SPL.
-  - Pad SPL to 68KB (4KB header + 56KB max size + 8KB extra padding)
-    The extra padding could be removed, but this value was used historically
-    based on an incorrect CONFIG_SPL_MAX_SIZE definition.
-    This allows to write the SPL/U-Boot combination generated with
-    u-boot-with-spl.imx directly to a boot media (given that boot media specific
-    offset is configured properly).
+
+The i.MX7D/S free OCRAM area is 0x910000-0x946C00. Some ranges are used by the
+Boot ROM while loading the program image however; conflicting with these
+addresses will result in image truncation and boot failure in certain boot
+modes:
+
+- OCRAM_EPCD and OCRAM_PXP are reserved according to the reference manual
+- 0x910000-0x911000 are unavailable due to erratum ERR011166
+
+In consequence, the SPL image (which contains a 4KiB IVT + DCD header) must fit
+inside the following ranges:
+
+- Header: 0x911000-0x912000 (4KiB)
+- SPL code: 0x912000-0x920000 (56KiB)
+
+For historical reasons, 8KiB of extra padding are added between SPL and U-Boot
+proper in the combined u-boot-with-spl.imx image, making the U-Boot offset 4KB
+header + 56KB max size + 8KB extra padding = 68KiB.
+
+The full OCRAM can be used at runtime for stack/heap/BSS. The stack is set up to
+grow from the end of the free area at 0x946BB8 by default.
-- 
TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht München, HRB 105018
Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
https://www.tq-group.com/


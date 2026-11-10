Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9180606A977
	for <u-boot@archiver.kernel.org>; Tue, 10 Nov 2026 07:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=i9xsJjVz;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b=S6rGcXHF
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 91DEC406B2;
	Tue, 10 Nov 2026 07:54:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IUs0oKL5ZJNh; Tue, 10 Nov 2026 07:54:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org DA27A406CC
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794297245;
	b=AeD+glXzUSvMqYGEz3xm0zzvYxlMG3Cb0ZsaZEVYL8pbgeVuF8iP0lFwEwMeqsAUK5oh
	 g8FI713fqY3BGUvP/4CFONvDKAavk3aqwa3H3+qQbUtkX9K2xspOpVpkkfHVvY1lBPgEE
	 tOQSqLUz+mC/n11bk/NoxLWM9zJ5W12LRg1tkOU6+QqtULtUNB5YfQe6kj3k+dEFFz0+i
	 fhS3rHCbv9YgQc5oOEvgBjI5Wj6KtmV1u2EmnQA8Oj9YebunWb+fhtMPLNAJrx2Zj750G
	 27xAHFs3sToZal5YM/fst92SQGfmISZSNWwV5heEKb8tTQBVGwxFPeMLFlyoVfrLiRQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794297245;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=mkHXyu1ToUsmZfomO8o6xTw3wUTOgeb1+Nb3tLXhcmM=;
	b=cGi3oXU2HXNMgAb+fI1qtG3JhkhU1kIXyiFwK5zTSDSj7TcsBMXCkRuPr/QHx7b8fs4E
	 RjyYpg0X4jtiOxtTwCiJpy806H0md5B0UUyqjwk4bv8s14GTUT7bo7ew+sN8mJPS34iup
	 CVjDN/d9E1Oo/TdRxtxSJtJ785AVIf+RrLbThqG2w5dYZ2U+x3iCbwHAnGgUkRZfyGgVP
	 1ecFIPuCSkwlitTqOiDYOKhHQXwwPUUtE/2yNk6+Axh0GamkJ5pWRDHQO0Y9R4Ns+1U79
	 AHpgNQx+oS9NVs8pIfmazm3HkTmDIIibOlc176la7G+cwwpF07GJBpGVrWTts/G8oxQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794297245;
	bh=mkHXyu1ToUsmZfomO8o6xTw3wUTOgeb1+Nb3tLXhcmM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=i9xsJjVzC4d4akXznlnWOhU+h+lNNCEWnFal4YlpZ1+eU2d78SsCuYdbR7mAJAVSN
	 J21nmHKRMWw/NM8WYc6USBN0UlyJXuubEurauOUbhvexPFGKkTIujmnA2qvesw4ee0
	 0Gu6BVrEg4G51SWo7TQtgpAf3G6vjKyTheoIipkuu42Nj8w1vnI1l5MXNYjT33A4UU
	 6qDeb6HNOg9Q6AcJS5+5mLcUby2imtxhpCGiE8Wx8a4B1HTX7YLOo0jjUN7hASwR/n
	 Pl/H2aPxr9XrNoRPcJKwtThz7woUDMkJ9klJbEZq4Eac811tYNdBrt5fX+XaOjCj45
	 JcXcYyNxoPVog==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id DA27A406CC;
	Tue, 10 Nov 2026 07:54:04 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 194ED31F
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 07:54:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0ABC860760
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 07:54:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OZWgT3X2wHgJ for <u-boot@lists.u-boot-project.org>;
 Tue, 10 Nov 2026 07:54:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 12C456074A
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a01:e0c:1:1599::10"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:e0c:1:1599::10;
 helo=smtp1-g21.free.fr; envelope-from=vjardin@free.fr; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr
 header.a=rsa-sha256 header.s=smtp-20201208 header.b=S6rGcXHF
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [IPv6:2a01:e0c:1:1599::10])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 12C456074A
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 07:54:02 +0000 (UTC)
Received: from localhost.localdomain (unknown [91.160.0.144])
 (Authenticated sender: vjardin@free.fr)
 by smtp1-g21.free.fr (Postfix) with ESMTPSA id 7D2ECB0051B;
 Tue, 10 Nov 2026 08:53:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1794297241;
 bh=5y++AG0CX5yWL0gKYKdNUbmDf46377VqbzBgw+9hOLs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=S6rGcXHF+1uTmtMXN7VLRq9aMismRAW6F69OQ7Stm8AKP6McSBUXf+ugQm7ugzLvC
 574FnKJid/TKcpu4V6MLUZgQ47Rl9bMw83Hx6ZGj99KepPylcoVVHtc9fKPzr+RyXS
 Jjvc0Fj370gFix5lvG1JqDfy2cMY50hrBrDvGcGFDIAkwYwHJrws9Njr2NW5xFPPam
 iMiHd+yikxZsegBXV5RrXjwwWTkgsnXLEU7B7mVaC6Nxlt/+Mb4NXIA/BEoGyvbYe7
 q8P3Lf16J/stsj99uFzQdjJCP/XcqjRRFp8ienwQ9PejtNqrekiqpygglZZBmJsslk
 R9RNtXpgCTv1A==
From: Vincent Jardin <vjardin@free.fr>
To: u-boot@lists.u-boot-project.org
Cc: Markus Schneider-Pargmann <msp@baylibre.com>,
 Denis Mukhin <dmukhin@ford.com>, E Shattow <e@freeshell.de>,
 Rasmus Villemoes <rv@rasmusvillemoes.dk>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Suraj Kakade <suraj.hanumantkakade@amd.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Vincent Jardin <vjardin@free.fr>
Subject: [PATCH v2 2/3] scripts: Makefile.lib: add check of -u-boot.dtsi in
 the device tree source
Date: Tue, 10 Nov 2026 08:52:55 +0100
Message-ID: <20261110075256.1800130-3-vjardin@free.fr>
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

The U-Boot extensions of a device tree, <name>-u-boot.dtsi, are looked up
only in arch/$(ARCH)/dts.

Let's try <name>-u-boot.dtsi in the directory of the .dts first, then the
usual candidates of arch/$(ARCH)/dts.

Signed-off-by: Vincent Jardin <vjardin@free.fr>
---

(no changes since v1)

 doc/develop/devicetree/control.rst | 4 ++--
 scripts/Makefile.lib               | 4 +++-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/doc/develop/devicetree/control.rst b/doc/develop/devicetree/control.rst
index 7d6117d5c4b..5c1b46b94ab 100644
--- a/doc/develop/devicetree/control.rst
+++ b/doc/develop/devicetree/control.rst
@@ -203,8 +203,8 @@ constraints are even more extreme and the devicetree is shrunk to remove
 unwanted nodes, or even turned into C code to avoid access overhead.
 
 U-Boot automatically looks for and includes a file with updates to the standard
-devicetree for your board, searching for them in `arch/<arch>/dts/` in this
-order::
+devicetree for your board, searching first for `<orig_filename>-u-boot.dtsi`
+in the devicetree source, then in `arch/<arch>/dts/` in this order::
 
    <orig_filename>-u-boot.dtsi
    <CONFIG_SYS_SOC>-u-boot.dtsi
diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 7cdfacd3ae5..e3b49148b7c 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -223,13 +223,15 @@ ld_flags       = $(KBUILD_LDFLAGS) $(ldflags-y) $(LDFLAGS_$(@F))
 # Try these files in order to find the U-Boot-specific .dtsi include file
 u_boot_dtsi_loc = $(srctree)/arch/$(ARCH)/dts/
 
-u_boot_dtsi_options = $(strip $(wildcard $(u_boot_dtsi_loc)$(basename $(notdir $<))-u-boot.dtsi) \
+u_boot_dtsi_options = $(strip $(wildcard $(dir $<)$(basename $(notdir $<))-u-boot.dtsi) \
+	$(wildcard $(u_boot_dtsi_loc)$(basename $(notdir $<))-u-boot.dtsi) \
 	$(wildcard $(u_boot_dtsi_loc)$(subst $\",,$(CONFIG_SYS_SOC))-u-boot.dtsi) \
 	$(wildcard $(u_boot_dtsi_loc)$(subst $\",,$(CONFIG_SYS_CPU))-u-boot.dtsi) \
 	$(wildcard $(u_boot_dtsi_loc)$(subst $\",,$(CONFIG_SYS_VENDOR))-u-boot.dtsi) \
 	$(wildcard $(u_boot_dtsi_loc)u-boot.dtsi))
 
 u_boot_dtsi_options_raw = $(warning Automatic .dtsi inclusion: options: \
+	$(dir $<)$(basename $(notdir $<))-u-boot.dtsi \
 	$(u_boot_dtsi_loc)$(basename $(notdir $<))-u-boot.dtsi \
 	$(u_boot_dtsi_loc)$(subst $\",,$(CONFIG_SYS_SOC))-u-boot.dtsi \
 	$(u_boot_dtsi_loc)$(subst $\",,$(CONFIG_SYS_CPU))-u-boot.dtsi \
-- 
2.43.0


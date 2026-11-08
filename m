Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC29606A322
	for <u-boot@archiver.kernel.org>; Sun,  8 Nov 2026 16:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=XSJ/0X4a;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b=a6G4mJc/
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1EAE5405EF;
	Sun,  8 Nov 2026 16:03:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 43cWColU9A2T; Sun,  8 Nov 2026 16:03:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 61F6B40604
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794153793;
	b=a6L+Xn8WvgScsvZrBwuswlOxcUyrFPq0pSKeFmTtsmopS12De+jDXo81DjUq2bjfIxcJ
	 CgO2rRuwWWVp1CBObaen+iue3LOrjiWVQS33KfdyIfCpLp/BNWE6iWEyWufLMAXu0iN9C
	 YDuMlgmpPMySO7lWaWrK1UMhSSZGdUsdhOoXq4bQUwIx8LhDY1y6W1IyExDMpbpusI5a2
	 O4zFRoBBxO39Enc0Hceo5NsGHVI0QF4sCajNVE0qi9RgF0uAFZavsqesDqCDg6G8z3ykf
	 MawXZrV3Be6rTuUXVgaZuGafUHPnDDa8irX3cHVwhjULtSLy3ZUmGCWGpXYriThU3bg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794153793;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Emlcfh3nVnhAGoElkHkmYVTdq7FnlhwA1W2JRQBsn+A=;
	b=syEp7HocuUF0NXCdTjTAOMVjsuBkapsGNSoV2g+USo+BnD6PHj8DyQfhKZ7dZBRIQYXI
	 qqoV4hJTwRkTQFTDJ9SpSEMC0XJRvJiGWEn1p0AtQoGaVo64reHVwZvBhdWf35V2IL9G+
	 Gcryu5wf19KWEfTN2UVHbxZqcILtOauDWRZq2cMcJl8OoZ3+aV03z3NVfx5KS+6XYR8aS
	 3ef3r7Xm4k3ypsDjsX8Vh+XEzXMGKfOMm8DoVqn9UQhlWJF+7SPZG+KtldQ8HoLbx08bz
	 SJGONH9QSqeZjwAK1/y/879q/d40qbHEp/9QlsjcKVYTzgWeK9lrIJQCqfEpKgsvP/A==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794153793;
	bh=Emlcfh3nVnhAGoElkHkmYVTdq7FnlhwA1W2JRQBsn+A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XSJ/0X4aVfdla6338uBbYLRnpoqGBl7KbbA411Mag3SRIpdri77LgtHChu5Ub/Z/r
	 3vWJYG06IevoYHq/K2kgbY0gbrpwWFc2EwFtaZlt8HAwFWJJ9TXG1NP/o0OVZZ9eX5
	 BQSd6wyPrQOokeiQcSwmQiD19H2dMzDmSPk0mV70+b0+yG/YciRIc/pNYdjYYYm6h5
	 WH1dpsmfORm+bkhxozOeRO8PsuAslC+Joy1402YEKR0y3B/u6BLRmpgAsyf3C5Kf//
	 qj0n4iamVEZi+W4x1vxNduWmoSnWlyNlJCb79OAyzUkVzztUF7LQEgihSY2VQUo7kX
	 v/ipnKwFGnN+Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 61F6B40604;
	Sun,  8 Nov 2026 16:03:13 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id C4F199D1
 for <u-boot@lists.u-boot-project.org>; Sun,  8 Nov 2026 16:03:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id AB537400A8
 for <u-boot@lists.u-boot-project.org>; Sun,  8 Nov 2026 16:03:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 23GC-na-mAMS for <u-boot@lists.u-boot-project.org>;
 Sun,  8 Nov 2026 16:03:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org EC6304005E
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a01:e0c:1:1599::10"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:e0c:1:1599::10;
 helo=smtp1-g21.free.fr; envelope-from=vjardin@free.fr; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr
 header.a=rsa-sha256 header.s=smtp-20201208 header.b=a6G4mJc/
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [IPv6:2a01:e0c:1:1599::10])
 by smtp2.osuosl.org (Postfix) with ESMTPS id EC6304005E
 for <u-boot@lists.u-boot-project.org>; Sun,  8 Nov 2026 16:03:10 +0000 (UTC)
Received: from localhost.localdomain (unknown [91.160.0.144])
 (Authenticated sender: vjardin@free.fr)
 by smtp1-g21.free.fr (Postfix) with ESMTPSA id 9A60DB0054C;
 Sun,  8 Nov 2026 17:02:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1794153788;
 bh=/JdETNZX6doaL3uToRLgSZBM6XijjjcLVKSWffK5ONw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=a6G4mJc/c9iUueenkdRyo0GA37R0wQgdFjkUsKIqYloklXTHd64nTdTOegDhTqX05
 DA28OLOqmsLEhIoeAzMJMm2BALGjL3CFWTTmMHGkmBF+ljwmpINrH67Z7OXVysnf6p
 iJmuWN++hMW027Xb4SN6BQ1DY6Bq0O/5j7tPQvUAfErfkdOdNd2Vv6kcD/BmRWUKEW
 bnkMX5Ic5KdcdRDjCs3y97HcUp777SaA83HWRAS8AjPtb/SR6tPjZuOBzaRePDLBCF
 abJ0/7IgbPewXAa/sipV57qfSB33VmxRQqCQFIFMvP08RadFFwTOI0fEIsXNYIw04j
 y938ycIy56q4w==
From: Vincent Jardin <vjardin@free.fr>
To: u-boot@lists.u-boot-project.org
Cc: Suraj Kakade <suraj.hanumantkakade@amd.com>,
 Markus Schneider-Pargmann <msp@baylibre.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Denis Mukhin <dmukhin@ford.com>, Simon Glass <sjg@chromium.org>,
 Rasmus Villemoes <rv@rasmusvillemoes.dk>, Tom Rini <trini@konsulko.com>,
 Vincent Jardin <vjardin@free.fr>
Subject: [PATCH v1 2/3] scripts: Makefile.lib: add check of -u-boot.dtsi in
 the device tree source
Date: Sun,  8 Nov 2026 16:50:18 +0100
Message-ID: <20261108155019.1485598-3-vjardin@free.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261108155019.1485598-1-vjardin@free.fr>
References: <20261108155019.1485598-1-vjardin@free.fr>
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


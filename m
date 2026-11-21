Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F64B606A320
	for <u-boot@archiver.kernel.org>; Sat, 21 Nov 2026 12:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=y6lhuCEA;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b=iDRTokSs
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EE6C3812B9;
	Sat, 21 Nov 2026 12:06:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id L1FGXyxavAF1; Sat, 21 Nov 2026 12:06:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 41E6F81205
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795262784;
	b=BN5xu8+o1LYY8Vptg2uba72WycWQaXXNAYNoZH4cLDHg7xpRKCGedY4fQRtLtV126Ehl
	 kHFxDguNkMgm9yqeMOnGcE1dJPWh5C8ObMcPnuLGhKo6RrtprxU94biFtm+ow2bDaTd1o
	 WTbexQOmXPFDiAxdN/51+MSqe91gt9yzrHrlcZwnZFlF6NDVueZud7HYRClpEgMTCV8W0
	 +Og9vmzZ7vLggdHEsZphismk0WSrlIvGt9XFW7Ra3djOLwRWUZK0iY5nouVUD52hkwMfJ
	 v7ixZPAuMuC2EkEicr/RZAkh4cADLEQ3pum7L3gQhF8bzZtNwRCKfp67t2Fa5ZLFHrQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795262784;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=mkHXyu1ToUsmZfomO8o6xTw3wUTOgeb1+Nb3tLXhcmM=;
	b=c3gF2EI6pf8yvxShYePDTxVfdMNb6f0wU5TCKL6Zcre4GPu/ObvfXgdHRhBm5nJ6YaT3
	 BsNZFDC0yu0i4EI8rwq/8AeR+sCzbB3/DlM8d8Iln/mIxEngFmvTKAmeUUFXGMeC0estf
	 5nIZ1sJV2tif5pIidBMTL1O17G7rtTN4ScBdzjiz4nm5x4zvQhR0jUGdRLJ5gSYMqMtqc
	 ZXQhXZLWa2uozPlmS2VubwHruN9OB8qNX4Nzs0zU/DcDrUaHJ8Sp8zVO28GXGEjMZW/My
	 mAbWCpNEFs9ThavIaun9qeDOuQApbPmuV3RHloUcKIi0YRbg0sP5vpsclta7z/Efhsg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795262784;
	bh=mkHXyu1ToUsmZfomO8o6xTw3wUTOgeb1+Nb3tLXhcmM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=y6lhuCEAb9p2JzzLNW0u0IbP4CmYyPHFQn3oeFXkvy61jM2rUyc6vHQDfRpeOu547
	 rmyKcAoxIZ3za6Bws43UB4E6NLtAeVnRteWfn/WquIzCgf6Umn9dvsbW2hUcttRTVo
	 YW5pUu3B2vOhEYoDgEHzSwdVoV9gjm04H1SRE6/RKieTmfb2i2DSp34T+emOENrrDj
	 ZhHcB6Q9SP7g397C5NrlWNgB9STt5HEjTzwlQGtAtWksDNlCiCJI/1QGiKxD2J56Ma
	 sccrRxtP1D3TebYFpq2LsL0/RWb3cBj6BYTUgbKtGuPWfdw3757nrGeWorPbwmq4uX
	 2Jw7nU0LO27wA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 41E6F81205;
	Sat, 21 Nov 2026 12:06:24 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id BD865759
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 12:06:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id AEDEE40A70
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 12:06:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id R-PoP4g7d_qg for <u-boot@lists.u-boot-project.org>;
 Sat, 21 Nov 2026 12:06:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org E60CC40A09
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=212.27.42.1
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=212.27.42.1;
 helo=smtp1-g21.free.fr; envelope-from=vjardin@free.fr; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr
 header.a=rsa-sha256 header.s=smtp-20201208 header.b=iDRTokSs
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E60CC40A09
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 12:06:21 +0000 (UTC)
Received: from localhost.localdomain (unknown [91.160.0.144])
 (Authenticated sender: vjardin@free.fr)
 by smtp1-g21.free.fr (Postfix) with ESMTPSA id 40C42B0054C;
 Sat, 21 Nov 2026 13:06:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1795262780;
 bh=5y++AG0CX5yWL0gKYKdNUbmDf46377VqbzBgw+9hOLs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=iDRTokSsEfIvUhoy5dfkduKOs1hYsYQRWp6W9Pk20fP1wRLVqtrysfhuUNTbR7Fb0
 T2BvhPtcO6dlnlo0tEMmnYjFNmQ3UvPPEQBXSLIb5QZEwW6B3aqtWyQRpqEdOfJdSn
 j4edS66yRo/G34OGWH/V3Uh+cG7Hp9anvg23P75996AJkI0e+w3iCI1qWT5b0ztF6B
 u4vJ/fDocQa0YJZGM83bTDABohYDOqbJpO2c0yVdmGpVEiC5A96qUlQCKgHwmqT2Cz
 k1hm3xQcBo5xWEjk8nSJkqYt9UkXPc/aravmy+9PcTLvKKjaqYHknWAzf508rvVBG5
 HBIJ0KmBax6qA==
From: Vincent Jardin <vjardin@free.fr>
To: u-boot@lists.u-boot-project.org
Cc: Suraj Kakade <suraj.hanumantkakade@amd.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Denis Mukhin <dmukhin@ford.com>, Tom Rini <trini@konsulko.com>,
 E Shattow <e@freeshell.de>, Rasmus Villemoes <rv@rasmusvillemoes.dk>,
 Simon Glass <sjg@chromium.org>,
 Markus Schneider-Pargmann <msp@baylibre.com>,
 Vincent Jardin <vjardin@free.fr>
Subject: [PATCH v3 3/4] scripts: Makefile.lib: add check of -u-boot.dtsi in
 the device tree source
Date: Sat, 21 Nov 2026 13:04:43 +0100
Message-ID: <20261121120445.3795725-4-vjardin@free.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261121120445.3795725-1-vjardin@free.fr>
References: <20261121120445.3795725-1-vjardin@free.fr>
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


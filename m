Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4264CA5FE6
	for <u-boot@archiver.kernel.org>; Sun,  4 Oct 2026 06:18:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 51F7680EF4;
	Sun,  4 Oct 2026 06:18:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GdllroqQY2YI; Sun,  4 Oct 2026 06:18:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 56C7080E39
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791094724;
	b=J0egEoMY/xB26+a1q8BjHAXcGkjtEOVRYSKounFPDxrxW1bpjxU6KqE/KRXR4dj2LwRi
	 xpodQBPpDqwrsrytgOiUsoaWMYh23ZuDli+QfjKLgE0AiBV5O5SX85zTpsQ05NRha83+l
	 w8+x9Wk1gaNFazDIfEsPTQr4ak93vnWg62ko3JxD0xRfmSiHETOt2/yV0MxYnHmKS4aX6
	 wYZ3RyIUXKlEihOQY1qQU69DfuHUnneJCfazzjGwHoOkG5uMyzpfdbbqkTzvuKTenF2TL
	 cAGaFGhoYSutV6WrX5U5JQFAjmY3Q+ex7/4mouVK1qy3VTnY6nEzeY8HlYhr1zX+Vvw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791094724;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:DKIM-Signature:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-MBO-RS-META:
	 X-MBO-RS-ID:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=apbfyL+ltEj6/O1OxgRb5R5Bvo3OuDArGWakbBwMR04=;
	b=h5KncQCfyQW+cI/hwk4Zv+iCx0c0wNEHtxyl6FOcP+hRJo9CNjjwtX7nH4WibWdCYSet
	 SGV/el5XbsKciNsgMWDdvaDxEnaj6KOa12Ks8aAaUeAKZsfuohi7pLX+DM/cILkXkD2TZ
	 Ny6LpIk/kMHi8exebHhXNenoXqUTOLIbho0MAfwQ+p6Xw2XgHvDrjSwc4qp5npzBZcQCL
	 tsIAkBV4XdEpffu/EXawuOjENYameJlxZ11p9NhtA19MAd5DDGfVF7NuxN6un+RK3y1m8
	 cjkd3m2eu0QXD1QfcuSyMrlkwcKOFg2XcTXDOQl4zothn3lx6lFJPignWfJvl9kKaAw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791094724;
	bh=apbfyL+ltEj6/O1OxgRb5R5Bvo3OuDArGWakbBwMR04=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=gfs4alhQMvGtrNtOHA4yKnBtU+UfsGUYtei8ItghCOkO8lW0QDgrpaX5C6YUy9gei
	 uHlD8NcBDxwRj44jV2jMG8PmH+2H1eBYLa0yJwbXLf6TbKVByvPA80zibeYTy5rQq2
	 ksb0UXs504pHpSpAeSoImk9hL2WGOdDIqtDsfVHmbQHpkNxRJBkapHRXLEGg5FAOEf
	 4hx7MmX9Q9n2YAcmgo2nruO1qd8PB254R5L1x9k/uoNw0pQ/6n6tuxlFJSpl4PcSOo
	 fnFDpLPRmcwQKHPTpMBn8+od2sKIhUA8N8PgiEPmPcxMnyzLlpN9BFh6ePvDC4epE7
	 v2SHeIWrJIs4g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 56C7080E39;
	Sun,  4 Oct 2026 06:18:44 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 31BAC335
 for <u-boot@lists.u-boot-project.org>; Sun,  4 Oct 2026 06:18:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2ECF460622
 for <u-boot@lists.u-boot-project.org>; Sun,  4 Oct 2026 06:18:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xhBLy00ZETyn for <u-boot@lists.u-boot-project.org>;
 Sun,  4 Oct 2026 06:18:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org BE0E36061D
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:0:465::101"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791094721;
 b=ksNSdG2HAPw3765ooW8HN30/WFZzvOOWpsEkoR957CWm6rB6ZOzceiKkIEVQy0m2tdrG
 hgsw/DGAlAvyveHhhaxASKD5p5xPy1LMghkaRgAxyToZk5xScYFOGRtSX1snie7x1VTHh
 6j+9ITFXvgTC2BDS7PFk0NC10d+Qg5nv4QGlVVfwom0SG6G3bsTdqwIeMGxplKV+Gh20e
 GGN69BCbiD7QhpWwQRyKKRf2IfspklualywA41ZL8drSHJ2j8elkEWzsi/N1RStuABKrv
 oWMY7WfzD/cEmFbGhgCWsOYAZNxsoEtQ657gmNHKRVwxYQnw22xcZc5JXqFzjbt9llw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791094721;
 h=Received-SPF:Received:DKIM-Signature:From:DKIM-Signature:To:Cc:
 Subject:Date:Message-ID:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID;
 bh=apbfyL+ltEj6/O1OxgRb5R5Bvo3OuDArGWakbBwMR04=;
 b=NC+mU72rkBFcIzrsWG9tFhORNDLO/ILhxgHkefbDR6FECoZ1cpN160JMqzR2G8fATBiE
 /jy2OTOYDylyAGKWO+nveFrHyB8d/pyeKkSJsfn1ZwtgAEmbXoMQs7HXDDZsWNGpvI6lF
 F1w3sS3MjPnWBzZMWOhAsxNtTUftfQMBFApl91u4/EM5m0sR63vKedUqHHZMXjCeYNSvB
 G2FDGDH4hIDO8lUOmO4Ll6uC50YFIcbXIRig99i8nGwTKFd0sSjrL3/OgYi2i0j1R2h52
 eVHBZ0hWbwqPvrI+Rs8V6z1y4CLcObeL7lAKMxBiSsBlxPIGvpJMREuzq9GZTGRC7xA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=mailbox.org; 
 dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=eXra8ah6; 
 dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=YvW3DEB2; 
 arc=none smtp.remote-ip="2001:67c:2050:0:465::101"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::101; helo=mout-p-101.mailbox.org;
 envelope-from=marek.vasut+renesas@mailbox.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=mailbox.org
 header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812
 header.b=eXra8ah6; 
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=YvW3DEB2
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BE0E36061D
 for <u-boot@lists.u-boot-project.org>; Sun,  4 Oct 2026 06:18:38 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4hyC586btBz8v0B;
 Sun, 04 Oct 2026 08:18:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1791094716;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=apbfyL+ltEj6/O1OxgRb5R5Bvo3OuDArGWakbBwMR04=;
 b=eXra8ah6IquhyYQFJuVD21z0Rd8nOV9dO97yXFc3noRHn2NsN6E89eOxOZFHDJ0teDIihL
 bHlMtoEtr8VSPKVNt5W2sHu3O6AYJE43r8shOnp1nGO2F7fK0CF5THoH2/pCuqo9KfNzAH
 lPyPWpkqdPkYqlnefG1XlnwsCZyLgj97q7EmH13IeZiiJRcUoHxemYZyu8w/iYMF3eQE/G
 ch6SGAZ7tTkovhN2k4bt0ltDEVkmPmNd2oJ7QZXpTd5AVTctUy+oHiHru+ymdrT/5NNbET
 OczCowSjy3vRSpiTJHMXO1BKwbrA3UauC/zmx3ZbIIklOIiOzzU1Mm+ga95WuQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1791094715;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=apbfyL+ltEj6/O1OxgRb5R5Bvo3OuDArGWakbBwMR04=;
 b=YvW3DEB2H7CmfhhgLe1bshFd8WeoSiRhL8NOomUI/k4ngdlk2exgeZoJkb1VANkKQL2UYv
 mLwc6EIjGVJeRaFM5UVFYDrmKhMTRgpXzHuEOv/MT3yxE6Lxn1f7YLSf2FIBWZypJZaLSU
 kkxpnQQzrgD1k+9VTGUBTMFSxSCP50RdSs1n4MUboxW6Gu9pEvUwX+YBuvwTI3RusN3Syq
 VYVHCCee1A47Q9gCNeu8IPAutCxkNyv/5oaCwJZoEhx0svsYw4721K4rQx9RydKbpjRq8W
 KEZ3nsoORzEd9aFWoSEpsXsng+Jzqm/j/nVN8Va5BENZwkkB3Lqqr7cuKp5peg==
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?q?H=C3=A9ctor=20Or=C3=B3n=20Mart=C3=ADnez?= <zumbi@debian.org>,
 Mattia Maldini <mattia512maldini@gmail.com>,
 Rasmus Villemoes <rv@rasmusvillemoes.dk>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Vagrant Cascadian <vagrant@debian.org>
Subject: [PATCH 1/2] kbuild: Pass -Eno-node_name_not_empty to DTC if supported
Date: Sun,  4 Oct 2026 08:17:42 +0200
Message-ID: <20261004061826.1028380-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: ifpq3gn7q9iyp3pqapr7rrdonpheassp
X-MBO-RS-ID: 5e8b225c0c0c5d892e0
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

Since DTC 7c78c8542d73 ("Added empty node name check") , U-Boot binman
use of placeholder node names such as @fdt-SEQ and @config-SEQ triggers
DTC ERROR (node_name_not_empty). Inhibit the error, as these placeholder
nodes are updated by binman and replaced by proper nodes, the encoding
in DTB is temporary. Since -Eno-node_name_not_empty is only available in
DTC 1.8.0 and newer, introduce "dtc-option" make function which is very
similar to "cc-option" and other such Kbuild functions, and add the DTC
option conditionally.

This can be triggered on e.g. Debian Testing (as of 2026-09-07) when
using system DTC to build a DT which include binman placeholder nodes:

$ export DTC=/usr/bin/dtc
$ $DTC --version
Version: DTC 1.8.1
$ r8a779g3_sparrowhawk_defconfig
$ make -j$(nproc)
...
./arch/arm/dts/r8a779g0-u-boot.dtsi:61.16-70.9: ERROR (node_name_not_empty): /binman/section/u-boot/fit/images/@fdt-SEQ: Empty node name
./arch/arm/dts/r8a779g0-u-boot.dtsi:76.19-80.9: ERROR (node_name_not_empty): /binman/section/u-boot/fit/configurations/@config-SEQ: Empty node name
ERROR: Input tree has errors, aborting (use -f to force output)
Check /path/to/dts/upstream/src/arm64/renesas/.r8a779g3-sparrow-hawk.dtb.pre.tmp for errors

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: David Gibson <david@gibson.dropbear.id.au>
Cc: Héctor Orón Martínez <zumbi@debian.org>
Cc: Mattia Maldini <mattia512maldini@gmail.com>
Cc: Rasmus Villemoes <rv@rasmusvillemoes.dk>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: Vagrant Cascadian <vagrant@debian.org>
Cc: u-boot@lists.u-boot-project.org
---
 scripts/Makefile.lib | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 122c8e78204..330ab3892e9 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -378,6 +378,19 @@ DTC_FLAGS += $(DTC_FLAGS_$(basetarget))
 # Set -@ if the target is a base DTB that overlay is applied onto
 DTC_FLAGS += $(if $(filter $(patsubst $(obj)/%,%,$@), $(base-dtb-y)), -@)
 
+# dtc-option
+# Usage: DTC_FLAGS += $(call dtc-option,-Eno-node_name_not_empty)
+dtc-option = $(call try-run,\
+	printf '/dts-v1/; / {};' | $(DTC) $(1) -I dts -O dtb -o /dev/null,$(1),$(2))
+
+# Since DTC 7c78c8542d73 ("Added empty node name check") , U-Boot binman
+# use of placeholder node names such as @fdt-SEQ and @config-SEQ triggers
+# DTC ERROR (node_name_not_empty). Inhibit the error, as these placeholder
+# nodes are updated by binman and replaced by proper nodes, the encoding
+# in DTB is temporary. Since -Eno-node_name_not_empty is only available in
+# DTC 1.8.0 and newer, add the option conditionally.
+DTC_FLAGS += $(call dtc-option, -Eno-node_name_not_empty)
+
 # Generate an assembly file to wrap the output of the device tree compiler
 quiet_cmd_dt_S_dtb= DTBS    $@
 # Modified for U-Boot
-- 
2.53.0


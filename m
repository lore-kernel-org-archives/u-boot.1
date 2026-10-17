Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 554DECCF2C1
	for <u-boot@archiver.kernel.org>; Sat, 17 Oct 2026 17:35:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1E4E16064E;
	Sat, 17 Oct 2026 17:35:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qJjre_mqJAwc; Sat, 17 Oct 2026 17:35:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 4E45460625
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792258511;
	b=VhhFlxLuCuTQjQhvPa2IU63pt51W0vq9xvpYpPMnBiGgTcoYiVtHQZx4auwI5SJ8wv3p
	 qooSUYz7BJB9k2UOdTR46I+xx54UNyhlvtGg0fesx4XTFcJDhUxyrb5bpyIkClwfGZ7v2
	 WL/aVgpAQ6DIBWGCSUzQ70X34Wf27iRkXh+eRpddXYavGux58sFBQNEIPGhZpaAjy7zfz
	 c7XoOPyp4tIn7BF5V7T8sO8jQTJdPMasJRAVkUZuWSpZc2FJdjPj1D7XQMZxJfqR+CpCv
	 FCtJHj0O+Ae+UkY8IvCoAPPSouBnnEn6fbtbi80vZuxCCstW8UMqmYhdxe7fEk8ULwA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792258511;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-MBO-RS-META:
	 X-MBO-RS-ID:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=uCpbS+Z+aH0PtHS9pcMPai8ZlLV2t4ll18bhxQJU3c0=;
	b=rTriWIXJ13K60H6oraTe0oTxu0ACU3OSw922fLclu3vdv0dbq1deJ0EmrWgvP059+9db
	 JNL50wqrsld5NyePo1+4KUoJtwV7zOyBOGyLZ1zZCifRhJ3hV3rjt1DYUJ3yM8Bsmqsip
	 9vdeb/unY0wkDBhSfFMZ7sYUAa5RkoNzc/krysrQBqYsTu7Vz0iJB9q9qDLbJToTa/LTC
	 yWe7V056/4iubHj4oqqVSoOJazuHMwc0BtGV0+QV8hXUOL/cP2R7BT6mtCF3BkjCSTaMd
	 M9D8QGfQoPFeT3JWe0nwYi8cnLjxBYuzptn09OBQtjIBiXWDyhmNvq9BU0z2R/OcKWw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792258511;
	bh=uCpbS+Z+aH0PtHS9pcMPai8ZlLV2t4ll18bhxQJU3c0=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=K5r5oF4v6ea5/6+36Ulnc4Dk8m+ujkiePiBN1ldTgKsEmwGRLPSIyjF5bU2Sk963d
	 AQhPw7gYcfuySVGZ0Lsv53kdpHNj20nFC48PJGkqrPESqT6zNNyetbf1IIGqY53JZk
	 /7XAhuf2nDMVE8sxn2NXbJFAUQhI6f4Lk/H1bAFV5O1ahZfkjHlfBsKpDMnX7taPnZ
	 Zubd17a21TT+/49af7ZK3j0YWKvVFRaePHUhblWKrxWMzoQE9SyT0MEJ3Zanyj0Hng
	 8mJ9LMWq7SBBj2gapnEVUL1PMs5EaqNCZJXhYl3MJEIdSlyzlUgoC5Nntz8CUGK2tw
	 5ME3ESCAHboAw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4E45460625;
	Sat, 17 Oct 2026 17:35:11 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id A64EB977
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 17:35:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8BCD840832
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 17:35:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id I1ocD8GffxcN for <u-boot@lists.u-boot-project.org>;
 Sat, 17 Oct 2026 17:35:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A3E3040821
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:0:465::101"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792258509;
 b=ADPfsP4+BhkhBUSqYzFXEV1BqXF7thn4A40xjmH4KFQTTJZC3osz2lW5a0SdUlrGAkqw
 IFcvIvp3ENe5awHQSvgtuOOCaYpN41RAl1pcbZB/lB35iS0OJN4RkdPqlsY5xJYj5M8g1
 OTmyukxpViVbYZ1hVxUnK/aBcWueAXWX/6tU/+oplLVDnnGPlZ/AJ12rYXwgp4WYhq45H
 amLRqVsyevK4Iktn2JlB0reKzbLVpkDEGBIqcH9ZGCNSw81PaH8JFyY6tqxnpZRPNnDZz
 4u2ZHKyMZ29aWCkGxenwYBFru/QZMEEir2Fd9PGPeg59zj+mUZ+9cSFwJI+IrgqLhCQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792258509;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID;
 bh=uCpbS+Z+aH0PtHS9pcMPai8ZlLV2t4ll18bhxQJU3c0=;
 b=e9Or3W9XEYJWm8k1g8KOtWSmJpYiRZDzTk7t4552B1KgtdAPb2yofNZ1+laPvzUctG0w
 R8MLNYv0WNsCjjJ/WUDxI7gT1Inq4bePf7HkFx4O8MXwzjctteLXyTbdzAgm22SdSdR7Y
 tRdF3ajmbYDT5PlU19Hwhwys5ftZAHAfrU3nb3Pvm4JsR8NXuCtRF7AgBsq9RCFZAY/m7
 pM71w1eAaVUDHJ53frZt869EiCynfGFioLwGLRboQX+KmBBCD7Iw2Gma6XX2iWhhoIjmG
 H1oNQf4lrb0kOc6NrtVo3i3QmYqeToIVifYL0vgMnbnd5WbJ+4EyMdsLwR89fugbVmg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=mailbox.org;
 dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=NfTnEy3i; 
 arc=none smtp.remote-ip="2001:67c:2050:0:465::101"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::101; helo=mout-p-101.mailbox.org;
 envelope-from=marek.vasut+renesas@mailbox.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=NfTnEy3i
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A3E3040821
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 17:35:09 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4j6TTk4bPxz8vSk;
 Sat, 17 Oct 2026 19:35:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1792258506;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=uCpbS+Z+aH0PtHS9pcMPai8ZlLV2t4ll18bhxQJU3c0=;
 b=NfTnEy3i170wLVJtgHo3iTaVAxDiYhDLall4JKVLXf6QIhtn7sNkFZ7KkiOIqeokGjNdCa
 rTnWsZLwccLvYUe5nixfiLfFpTgSXdNvL/F3X1GSDm8csuC7VK30YXnfrL0+XoPvCXh6Mu
 P63NTHSIYVOGeV9mPWgyYDcm/r7EVUPdlAS8zUtXthevOII38bJ2RtD2RTnEmZ89wPfYlU
 UkUwKdVfn3xJ8lwC8FgI138SMHMVRUN7Ff/lz5CorZJ0IAFl/lYZ1vC9IODKesB8Sq0Sf9
 0DGkNnP7TduEG2GymAHWCFDHfFVTb+A61UigFfY1o+aOjBG8DvxIg2qCtZZISQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?q?H=C3=A9ctor=20Or=C3=B3n=20Mart=C3=ADnez?= <zumbi@debian.org>,
 Mattia Maldini <mattia512maldini@gmail.com>,
 Rasmus Villemoes <rv@rasmusvillemoes.dk>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Vagrant Cascadian <vagrant@debian.org>
Subject: [PATCH v2 1/2] kbuild: Pass -Eno-node_name_not_empty to DTC if
 supported
Date: Sat, 17 Oct 2026 19:34:28 +0200
Message-ID: <20261017173458.226395-1-marek.vasut+renesas@mailbox.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: rjxauyjsc1ep5uxp64tkzdyf16cfrn8e
X-MBO-RS-ID: a52fcbdca3eafa397f7
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
V2: No change
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


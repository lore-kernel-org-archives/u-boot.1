Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 851CCCA5FEF
	for <u-boot@archiver.kernel.org>; Sun,  4 Oct 2026 06:18:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E345360625;
	Sun,  4 Oct 2026 06:18:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oN1c9i5TFYs3; Sun,  4 Oct 2026 06:18:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 2238360622
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791094726;
	b=CLjup3cPTWyPgxNzrpzXy1EphrIT7kXJCk3qIsjM6CkmP/yTLXIUJZC13vSIag8sSr+K
	 HlYGaKoiPQbPVfGf5zeCdc8k5mnKrQlCK6eUQK7j2ef6a+lbIMqfTbPKWqMS3xYQwyZp9
	 xyP6LqH2PccU0qWdxMvwv/17eB4kdQLbiwK+wlCJ0JARVnBCvUPQ9nxrG3/uZCdLZVA61
	 mq6YtUuXaH17RurVd/ASi0Q5aHNoh/el02p1pJeIXHo4QDFcJpXRlYuXEThyknDkXec3G
	 9kasL9aJ1t9htDWithqgCWaAyydKJBg0UuATp2FybzZeFvZSUpyGEfi4UBY7laYEaqQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791094726;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:DKIM-Signature:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-MBO-RS-ID:X-MBO-RS-META:X-Rspamd-Queue-Id:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=mbca5L6GIAPskjwQCUODufdoMpmDRWfN17ijirvYv4M=;
	b=TgEMhAOOyxH2CHM8PBxi2r0QGRg7IE9ZVq7RiY7oiGKBkyWnDWXY8MuYIeE6US8tPtfP
	 r6QdaslzLKJwsjLPu7xLeOBMXXlZEIE4GCeEMFGzagMegfPOTTN0R6jKptBvxBOqdTVWx
	 5CawgRO89obuLBY+jCA3qv/RF42X+Y5n6nVF7aK2JjITMbcuVYIc8gZD7FEU+3jmxZmXN
	 h6jRA1vUdMe8uU/a6N4o7ZVyLwP1tmZygT6zSiuCxYJjvRvzO7swbJexd6wrgNO0dl4i0
	 bN9P3D28kU0EMZ+1/wr9wabmuUfaxa6/M7sQTgQfavUpeYvY73MCfjhWLB2HpqDQ66Q==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791094726;
	bh=mbca5L6GIAPskjwQCUODufdoMpmDRWfN17ijirvYv4M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RfJS5hc+CuQM2FE6jV3Gjw0E/MwKlo5SHH+ZV0rES5TU6FhNMnDO5kOVWvOUZ+dkJ
	 1tbqrbDx+QsRkkyRfBZIWHsrqghS3FMiNBAvw8C+NK+gb0fcAnKDri16J6XYkHlAQt
	 eemgDiuCv7gFZda8+HzldgSXFL5Eafk4IuRc7WBZNyr/5zM5LaVvqXzSqV7o6qZlvI
	 nCA88fAN9wBVmQ/MlnFD8lLx4g5h+sqaLZt7SDRF0ah6hHV0FNBigaTfvjJVEz8Xxv
	 e5tY+PrXaAxmkGierU2GDS/O++6pT7PMl0FjwwSigANpDnhNfN9ybZrlMF8hQhBaSd
	 IK69mxUX8xVbQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2238360622;
	Sun,  4 Oct 2026 06:18:46 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 7B1E3282
 for <u-boot@lists.u-boot-project.org>; Sun,  4 Oct 2026 06:18:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6CEAC406AB
 for <u-boot@lists.u-boot-project.org>; Sun,  4 Oct 2026 06:18:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kOlROdrY7XYk for <u-boot@lists.u-boot-project.org>;
 Sun,  4 Oct 2026 06:18:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 86633406A8
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=80.241.56.171
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791094722;
 b=ZobcUCvY0ZyjioCASfERGMcyedODhjAZnLSoPvKagRn9IbVDFcAUiLfXrQXvISWxDss/
 KA7iBB12t+xL760PbSHRR2+malRrn7/Ljtqwl8jRkGYnmA2BUHlaDUbtWaHvFtIalKlk8
 AKzRDpNEiIyFvTVteQBlBHmQyZzoW48hXeN/7tYKvo5SvjUuFb3F401eSHksA0uqOUJ5r
 AwP3JPRQ/S7L8up8y7CWQmAOPu+uJOad1huZbaoErwvJISac3ouEV35tWPsHeZ0CG0/Es
 GmNayy3N13+sUATeKupqoCQRTBc2jSvC9xAYwH9jZ9tUY+/bwoNxtYsaMf1uTxPmYJQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791094722;
 h=Received-SPF:Received:DKIM-Signature:From:DKIM-Signature:To:Cc:
 Subject:Date:Message-ID:In-Reply-To:References:MIME-Version:
 Content-Type:Content-Transfer-Encoding:X-MBO-RS-ID:X-MBO-RS-META:
 X-Rspamd-Queue-Id;
 bh=mbca5L6GIAPskjwQCUODufdoMpmDRWfN17ijirvYv4M=;
 b=GR2n3fTQL8ja2UbxLAfanE4rN+9gKwnQGJQBXVeUCuipczV9tNxMO+mODYIRuNk/BR8b
 ZthUOc37O7qcfqWyQRQFwXAXp6kH/HAM7FnzVsY0qpFC0wCKHdrNvMscabPpZC29JbI1x
 ShkAr2GhTkaG5H/Lo7jhT049Zk5/sEK1hkmXVbkRFZQYX7K6RQac11ZF6c5hKquo+9y/S
 vJFxUwge2Q9JjwbjOeEZzu+kfiIhwTM6mepVuTGFWEq/7zRH14AUOmyftLEJf3QgLeURV
 b39N8rLiETqMfXh5vb4Lbtd2CX6LRZPgswh8ujnlqWW9HCYodtd3/0uBgTaCt7EgYfQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=mailbox.org; 
 dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=iGVCVKAl; 
 dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b="iDR+Z/dd"; 
 arc=none smtp.remote-ip=80.241.56.171
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.171;
 helo=mout-p-201.mailbox.org; envelope-from=marek.vasut+renesas@mailbox.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=mailbox.org
 header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812
 header.b=iGVCVKAl; 
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=iDR+Z/dd
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 86633406A8
 for <u-boot@lists.u-boot-project.org>; Sun,  4 Oct 2026 06:18:41 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4hyC5C2lQ1zMlbC;
 Sun, 04 Oct 2026 08:18:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1791094719;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mbca5L6GIAPskjwQCUODufdoMpmDRWfN17ijirvYv4M=;
 b=iGVCVKAlC8PaIqVx6GZ4cDbUghkH4lH816md9jNDb0pO7mIa+V1I6SwFcCGcjFuTN8OIQN
 8V9+81Fgu1XZqN5EZVMG5nIjnqH8r3ELqgZ5kTO96XEt+/qErzQj3pPuoXmGTE8flui1r1
 zI7VwGfiqq4UwIs+60WCJoFbvnugQHYBXq/CZosLWAMsuZrtOmgdiq56/J1rR0jNCt390/
 ExQsXT+4Hk8Bp/wyOyC9mGYBR2tI+6F9NJiY6Br0u7ACsgxehE8X4JnaKhKXbffwpCqOGk
 B0lrtPTQUCzMAL8mCxX2G1IeZUHwVssnj325I8c75POhJxtCrDW6rFShiDFOSA==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b="iDR+Z/dd";
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1791094717;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mbca5L6GIAPskjwQCUODufdoMpmDRWfN17ijirvYv4M=;
 b=iDR+Z/ddgMPmiY6VObX0GkAGwgnEIbuXrRTy3e011Dqa0Ms/LDG1z9VPBIMfYLuXjCWEeM
 FBF/c+pEafRLrFsIN8y/rMAW/XQhOK2IDm+nIoAili0EWuKvKgpsKDmuSA3H3wgJrG5bHz
 HKyJtL8ryFX1PTz3otvcXZewEGO9XdeFFGnLUpVaeNT3YBS4+UksyIq4HdoNPehlVeiiFI
 H+HG8iSBjVly2k7Cu0QD6j4kjhxjaakifLMrJCkKi3PugVOrCAQBNzeA9Dh4gIzvxp3K1I
 gzJo9SaCYInVt1IaWzBGYcF0SvqJmOc7VO+UvSafqKzY9DslxpoXKo5OH3O1WQ==
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?q?H=C3=A9ctor=20Or=C3=B3n=20Mart=C3=ADnez?= <zumbi@debian.org>,
 =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>,
 Rasmus Villemoes <rv@rasmusvillemoes.dk>,
 "Rob Herring (Arm)" <robh@kernel.org>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Vagrant Cascadian <vagrant@debian.org>
Subject: [PATCH 2/2] kbuild: Do not pass -Wno-graph_child_address to DTC
 unless supported
Date: Sun,  4 Oct 2026 08:17:43 +0200
Message-ID: <20261004061826.1028380-2-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20261004061826.1028380-1-marek.vasut+renesas@mailbox.org>
References: <20261004061826.1028380-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 93bd4913df0f8c2210d
X-MBO-RS-META: pr4dxa9ka9kykgfmb3spz4har6iobptb
X-Rspamd-Queue-Id: 4hyC5C2lQ1zMlbC
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

DTC commit cba90ce82064 ("checks: Remove check for graph child addresses")
removed -Wno-graph_child_address command line parameter. Apply this option
only to DTC older than 1.8.0.

This can be triggered on e.g. Debian Testing (as of 2026-09-07) when
using system DTC:

$ export DTC=/usr/bin/dtc
$ $DTC --version
Version: DTC 1.8.1
$ r8a779g3_sparrowhawk_defconfig
$ make -j$(nproc)
...
FATAL ERROR: Unrecognized check name "graph_child_address"
Check /path/to/dts/upstream/src/arm64/renesas/.r8a779g3-sparrow-hawk.dtb.pre.tmp for errors

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: David Gibson <david@gibson.dropbear.id.au>
Cc: Héctor Orón Martínez <zumbi@debian.org>
Cc: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
Cc: Rasmus Villemoes <rv@rasmusvillemoes.dk>
Cc: Rob Herring (Arm) <robh@kernel.org>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: Vagrant Cascadian <vagrant@debian.org>
Cc: u-boot@lists.u-boot-project.org
---
 scripts/Makefile.lib | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 330ab3892e9..3817115816b 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -357,7 +357,6 @@ DTC_FLAGS += -Wno-unit_address_vs_reg \
 	-Wno-unit_address_format \
 	-Wno-avoid_unnecessary_addr_size \
 	-Wno-alias_paths \
-	-Wno-graph_child_address \
 	-Wno-simple_bus_reg \
 	-Wno-unique_unit_address \
 	-Wno-pci_device_reg
@@ -391,6 +390,11 @@ dtc-option = $(call try-run,\
 # DTC 1.8.0 and newer, add the option conditionally.
 DTC_FLAGS += $(call dtc-option, -Eno-node_name_not_empty)
 
+# Since cba90ce82064 ("checks: Remove check for graph child addresses")
+# the -Wno-graph_child_address is no longer available. Apply the option
+# only to DTC older than 1.8.0.
+DTC_FLAGS += $(call dtc-option, -Wno-graph_child_address)
+
 # Generate an assembly file to wrap the output of the device tree compiler
 quiet_cmd_dt_S_dtb= DTBS    $@
 # Modified for U-Boot
-- 
2.53.0


Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 107CFCCF2C1
	for <u-boot@archiver.kernel.org>; Sat, 17 Oct 2026 17:35:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CBCC960634;
	Sat, 17 Oct 2026 17:35:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dy-VJLILWJTn; Sat, 17 Oct 2026 17:35:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 0931460689
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792258516;
	b=tNIoTQHQmP+RVRdgx+p7148H1jSRXE7LsFoCnpaAeIV2UhH+TPwvJk92mB4ibtUyFfcd
	 B8yU4VSBGEM4KXvl2NhiavWVZgkDsr7UI7xIPKDPJV6hti3KjLn7kFfU1HGMiq3NkDebk
	 BRfHqiETIdr5M9shou1W7ee8BAM41yOVy1hycqH/QgXgmq9mC41DHccn0uUE/BMatPA9C
	 VTpYnXvgJjjEx0DeDqifSgjIaSB1QOZTl5KZ7oGv/FZ4eAggpmKXow6JqJMAEU4bR9/Je
	 jC/JRp/O0PASWx8AsgnwwpTkWQ+6zO52mgC+TcpkgT2gymR06VC+ze01mRt7AQmd+gg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792258516;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-MBO-RS-ID:X-MBO-RS-META:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=mR0AmvoMcMpzf5qunN7z1riuTxbuYeJ3iU8SflKWswc=;
	b=hqf8Hqu1IMP3qoYstuWzmeeVNNWC7i/buiT2YVEMZTU+4vOT9Q78uW2DZKIIvPzfcF7h
	 pxw5KimeCXhTBw6TbNLKO9Qt9SUpptkqQM9hUgnIpk3asLqVOXOd4kCj0u1iicuRTRsKv
	 OBeI8DUR7RPTN4wU/NWJGlffeFr0a+aITbQk/6q483tkvM08dO+pJZBHjs1Q2/gLqBfFB
	 v3jXtjG5zFtf5NvF9Jn9mticF6NNOA08dg42hZhr2fvvuDdYJhNe33bBuHOL4HPTzLKJ8
	 Q6zrJyAaINafOXw3DtiPcYQx0lIg4iTC1NfxOXgBWLJhFJKDjVscMf5O+OMuBpgwdag==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792258516;
	bh=mR0AmvoMcMpzf5qunN7z1riuTxbuYeJ3iU8SflKWswc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EcxNgtsP3a7WE8at196+srNVjPHUrPggM3B2P1sG7AqT8i9GdDO0nQiROy/VapuQH
	 Hb6B4TeebLtm6FTU1YNvH9csMiORDzKxYdCrCCBgYKeRqXOCV5DYqog/gq9Npgto48
	 jkHLk365MhgOP2gfLjEYrbQslR12AUfzdHECpf0H9RtC484z+bU3iLEkx79Oqx8QQ5
	 j17kB6y5YUxyX/gQ2CNmZmOhC3ec3jmH3SFaMxM3F3V/laHIozP1MAVN+lT5jMYAhJ
	 HFAenY56onmvqD4BfUgFYATS9mRRl0coZwZBUBEez+i9Uio5dx0zKVTNEoSUmJxj4E
	 c+vxd/RXze5PQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0931460689;
	Sat, 17 Oct 2026 17:35:16 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id C914A2A8
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 17:35:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id AF7F4400AE
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 17:35:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wngGw-b-OyMb for <u-boot@lists.u-boot-project.org>;
 Sat, 17 Oct 2026 17:35:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org B04D44004D
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:0:465::102"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792258511;
 b=NMz4/PLslmvKcaMw8BN8NzYCAQTpdeYpcj4//y07U4iIFnd98p69RjefGiZWiZUXe4KP
 Ngx0PSzhBihv+vc7QCIhGc09M7ab9Y7nsH68JCLik2KoFCjBQiP8qU1LBvftQ7OveEYQq
 jiqSmlj8iXP7O6WN/KsXaMTFYcLkDTNbK3vvm5UdZJUnbAO/2J/GyVy98vZojbLWg278P
 F+NR3LpDsq7Ea5rxyJeSfF85XYuBezGo9/PvN8e4HDN7RMtNCHs1B6ztMgQy4NQV0G3e7
 XcIimLHm7/mffd9McbBzWfc8s66DCxixQLiuoFJaZGGL1OXAEvEEaiVSoQ0zhKrNuGQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792258511;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-MBO-RS-ID:X-MBO-RS-META;
 bh=mR0AmvoMcMpzf5qunN7z1riuTxbuYeJ3iU8SflKWswc=;
 b=HArgdVjs7M4HaMpaDPDOAks59aaL/2pjJcZ54UUfWe/Hs3xggB0rjlFrWEC2o7APxfrZ
 eN0rt8nBGMVE3/mXFK9q2Tkd8IfH8+EbhIECq0PdrUy68dtSmrXfgnwdbHrHxpfnEc+VM
 jBUTOshJp0iR9pUEfNskdYMj1Hd5GJlZzUzFaviCIK8FAQedabUCyaJvYaiVw9Q0YJMJG
 JIvgb6zua3uSD/QmwAR902zZOnsPK9HNWRP6CYdOaFD0VGv7IreCkLQI8FGuAttycAH20
 IPFMULPd7i6FjhafRJZRuCtieg63KxzblHSJMymDXBUJyyB139phZ/zQIDMfdR0Dr/g==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=mailbox.org;
 dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=WmvWEmcr; 
 arc=none smtp.remote-ip="2001:67c:2050:0:465::102"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::102; helo=mout-p-102.mailbox.org;
 envelope-from=marek.vasut+renesas@mailbox.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=WmvWEmcr
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B04D44004D
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 17:35:11 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4j6TTm0ZVyzKp2V;
 Sat, 17 Oct 2026 19:35:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1792258508;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mR0AmvoMcMpzf5qunN7z1riuTxbuYeJ3iU8SflKWswc=;
 b=WmvWEmcrN2bva2s/JR9ictcpChWqLYeJoB8LcwdoQHRro8gdZxsZLQvmunRGh2gUU1UKJS
 9RipqXr5NniyXyCr5UdmzmTPY7WXYII8djF5QNje8ZNso+k/kWfHr43HXkKUXi1i4rEG3a
 cXOcFfF15RMsBzOc6uPUzs9l9F8dT7IKwh1QtWBVDPeD1zVVmYs2uQSjgKFtTYahvqOJgI
 sx82a6FOZTdCtxdJlx4pJHIB/A88wZPkJ7YkUpl71oXRXkDNZb+8wQHStbhh1RiwQnaPAF
 tL9bQ6CaNLRLTfL7XDNpOrrK9nFHsCIecs1gKgCddKEe1tuntaT0liN6Qr+NFw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?q?H=C3=A9ctor=20Or=C3=B3n=20Mart=C3=ADnez?= <zumbi@debian.org>,
 =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>,
 Rasmus Villemoes <rv@rasmusvillemoes.dk>,
 "Rob Herring (Arm)" <robh@kernel.org>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Vagrant Cascadian <vagrant@debian.org>
Subject: [PATCH v2 2/2] kbuild: Do not pass -Wno-graph_child_address to DTC
Date: Sat, 17 Oct 2026 19:34:29 +0200
Message-ID: <20261017173458.226395-2-marek.vasut+renesas@mailbox.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261017173458.226395-1-marek.vasut+renesas@mailbox.org>
References: <20261017173458.226395-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 59dada7ca0a22f80259
X-MBO-RS-META: 7x7ew9hfdrnm81b1u7c4pkoxg4zczp6z
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
removed -Wno-graph_child_address command line parameter. Drop this option
unconditionally, as it is flawed according to the aforementioned DTC commit.

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
V2: Drop the parameter unconditionally
---
 scripts/Makefile.lib | 1 -
 1 file changed, 1 deletion(-)

diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 330ab3892e9..01fd809dd29 100644
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
-- 
2.53.0


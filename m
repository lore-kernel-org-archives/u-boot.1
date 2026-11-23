Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E496606A31E
	for <u-boot@archiver.kernel.org>; Mon, 23 Nov 2026 18:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=pGUFmYn4;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=qtNq0ms9
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 408E8405D2;
	Mon, 23 Nov 2026 18:20:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CfCOLi7kJz-5; Mon, 23 Nov 2026 18:20:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 80DAD40711
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795458038;
	b=E9cvEYqCPNbzE4a+kQ8Qfzw/Ji3O36piJ1CWrpLsZT/5aXt7D8g8TkmNKM8JBEYgX6nZ
	 PtTJFNb7FulpvXTyP4UVK/n/oUt90OGbIZsM/DWlzufaSi0ZYcA/ADKwSBtTWCDg9afM8
	 n3ErEoMzH/Ew9jwXVwMDZnMWixHMhstMvJIN2NJGXJLh+L9VCdkc/y8hYnPYmgh3/8C3T
	 1uhJsqjBxGaX5lC3pU9fEcLk5NrJCDr6uFEadM3oExV0Z0whl3I+pIEAjedRgb+P2CL1M
	 oHYS2C4a70wm6n9NW5Xm+40TuAssF+r1q0enYdzyJ241saNI/e0mR7Aw5TofC0cWSiw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795458038;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=6NQI1A2G5537CgxvBQnGDfIcbagcQUTWdXLKcfUho0Y=;
	b=sYLXCXpd4ISpq/CMAsU6S5Wk9CnMwgcyR2qQT6LbIOsG0UunSNf2iEzpQlmcmXQ8DRZp
	 UjSirJM5YGo+0ZINcAeb3cjZH0meCcsAP/A7YKTDIUijJnV2aFFiF0B0o5NPto9pJ0drt
	 vRCtMYLdxyUA13U9K15j4Gvr7Fjfz8eFkaIPKz2czbkYZIahKTTP9HtjTbDbXb+Yxbi1b
	 Ub+pNKgeJBvh5GmUNaXLlTFOeJHzTcYT8OfiNJPn8a5a3M0rew3ipeBHTTvsu70+9eplU
	 c1oHDHVqTiv+ArzadPlfXm7a6HJH23JYvGwXxSACTor6zSpsPJspO7sCvlq3FOTaiJQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=mailbox.org;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=qtNq0ms9;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795458038;
	bh=6NQI1A2G5537CgxvBQnGDfIcbagcQUTWdXLKcfUho0Y=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=pGUFmYn4KDILn3dSOCcxFNHEAfqUPgxiGB6QYt/Ag1usB8TtfEB6HYawizLlMTL6c
	 272dmQFnYOnvc65rXKzOBm/sFx2MGmJdZ/C8M2C6lo7BfW7t6lJcMLRueP278PZC+D
	 g5lgZNc2Ncbdgandx1odjGXFVWtoJsGHsLe9oZLIxG/XJpdppjaWLVvMpk7LK0HSh+
	 +JbR122BeOHr3M/Xo8lcAUcDPHvCdPops/zP2/GyOmh4NKhcGyELd+OQd44BvRZCyi
	 nvH7jilL6dqXXyiiHGhdrx/pMuS943T4m3zoNb67Fwo6aVJ0WzNHg3E/FSRezj3Ttg
	 t1uojmV2Zy8fg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 80DAD40711;
	Mon, 23 Nov 2026 18:20:38 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id E6D49715
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 18:20:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D7A6040711
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 18:20:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eW_S4DQRs1k7 for <u-boot@lists.u-boot-project.org>;
 Mon, 23 Nov 2026 18:20:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org D7DFB405D2
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:0:465::103"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::103; helo=mout-p-103.mailbox.org;
 envelope-from=marek.vasut+renesas@mailbox.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=qtNq0ms9
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D7DFB405D2
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 18:20:36 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4jYDl41Y5yzKnsG;
 Mon, 23 Nov 2026 19:20:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1795458032;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=6NQI1A2G5537CgxvBQnGDfIcbagcQUTWdXLKcfUho0Y=;
 b=qtNq0ms90DpiDu+Yg88RxRYHe58IOFy9SxItTfbMRXRtC7F51JLXCqWPKhrjuvEjSW99uT
 gNoypWV2WE16H3xbLiR1gU4Slp68/2D9cjnKMCKckrp7pMEToLHqBnMUXoFc5J6bPcQqzN
 TS4M3lrrRnrwGPitxE15yg11eEw9WZPwdWaVgAuQHlQdfYWmajK8ATrCHvGDzwiXKhtsR3
 8tqsajzNDIi0rok8kYyNiz3x2esbMwchXDRdttv7NWzBTnGK2zz0GusRVxC5ONTYe9bnbg
 mZY5JzFY+ezz0CVfsE3N7nEcYHGNwjGDD5kFcBjE18mEmgKK6fXoXqrvqZhTQg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] arm64: dts: renesas: ironhide: Drop stale ECC reserved memory
 nodes
Date: Mon, 23 Nov 2026 19:19:49 +0100
Message-ID: <20261123182030.168916-1-marek.vasut+renesas@mailbox.org>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 9xe15cyuqh7megcnhdoxdwx7uobu71er
X-MBO-RS-ID: 905b5b7e4e8ba853ec4
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The current state of DTs synchronized from the Linux kernel does not
include Linux kernel commit 47ecb59d32cd ("arm64: dts: renesas: ironhide:
Align inline ECC carveout sizes with bootloader settings"). However,
the r8a78000-ironhide-u-boot.dtsi already relaxes the ECC carveout
area restriction in a way that matches the aforementioned Linux kernel
commit. Therefore, drop the stale ECC reserved memory nodes currently
included in DTs synchronized from the Linux kernel in favor of the
up to date ones present in r8a78000-ironhide-u-boot.dtsi. This fixes
the following warning when U-Boot starts:

"
ERROR: reserving fdt memory region failed (addr=1acccc0000 size=33340000 flags=2): -17
ERROR: reserving fdt memory region failed (addr=1ccccc0000 size=33340000 flags=2): -17
ERROR: reserving fdt memory region failed (addr=1ecccc0000 size=33340000 flags=2): -17
"

Once the DTs synchronized from the Linux kernel include the aforementioned
commit, this commit can be reverted, alongside the other ECC carveout areas
temporarily listed in r8a78000-ironhide-u-boot.dtsi .

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org
---
 arch/arm/dts/r8a78000-ironhide-u-boot.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/dts/r8a78000-ironhide-u-boot.dtsi b/arch/arm/dts/r8a78000-ironhide-u-boot.dtsi
index cfa39f7858d..b251309758f 100644
--- a/arch/arm/dts/r8a78000-ironhide-u-boot.dtsi
+++ b/arch/arm/dts/r8a78000-ironhide-u-boot.dtsi
@@ -95,16 +95,19 @@
 			no-map;
 		};
 
+		/delete-node/ ecc@1a66660000;
 		ecc@1acccc0000 {
 			reg = <0x1a 0xcccc0000 0x0 0x33340000>;
 			no-map;
 		};
 
+		/delete-node/ ecc@1c66660000;
 		ecc@1ccccc0000 {
 			reg = <0x1c 0xcccc0000 0x0 0x33340000>;
 			no-map;
 		};
 
+		/delete-node/ ecc@1e66660000;
 		ecc@1ecccc0000 {
 			reg = <0x1e 0xcccc0000 0x0 0x33340000>;
 			no-map;
-- 
2.53.0


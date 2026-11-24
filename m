Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B227606A31E
	for <u-boot@archiver.kernel.org>; Tue, 24 Nov 2026 06:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=J45GWiEV;
	dkim=pass (2048-bit key, unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=LJ6RfZyj
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1832780EFF;
	Tue, 24 Nov 2026 06:03:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uJzNICDIHUIp; Tue, 24 Nov 2026 06:03:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 4957D80F32
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795500182;
	b=dR5hrYvPm5TLtDgbzcihIC9VQeA4flE3twxRn79zpCx8WrZvtH2t2Xsye+P9qhlcz7m5
	 4uhKrG+i6DaZaxiah1laO9y3Xz+aCNqqFtQzAiy2q0NjIekr3fLlTb0pL9dBuTfABq+Bw
	 madLzlqcfqkyk7rR/PcEVhcuUTOPzm9bIDOnfneZTYmSOi3Ljq6niQfXUnJ5hwlOk01aj
	 bE7lyg08FoVqOUjOQNFXegwQQaT45nS/FWJj9HwGOG4arkXpuzFR/G7SVefOwuZ7gP5Of
	 zDB2CJbnCrmko+2xddJPs3FVMtZLSRbnKQKStWyA5X9N+Rm0J4mrnjIdWyJ4giiw1OA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795500182;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-Last-TLS-Session-Version:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=cxzcvGKSIviIxs/O8X0HAWqHLt+90oDZpIVj9OD6yuI=;
	b=Wot84srmFnHM/ywWhDF4Dkn85tOCA9kb+1/p/Wdwrw8+aYmXMngMTJbJmWCwH7sx6TOv
	 4OnqWxG7oIFd4oJ6OJdBjmCXlUoXjeJ19zLgz0N4S50aY1zziqR8gjXmYFXduLogxDlY5
	 l8Eg4G/MeT5F0JDWEX2oulgF3KcDgzZY+UgqqK5K2tnwPnn+pKtf1PJmnTdzpgsAHoZEc
	 1f6JVOZ2Q5Uga7emJ9fiHjDnCDphbcTMT4ZY/2azciuAvqC5QuEMdKZU15Vub8wQw399k
	 A3emWoczsHUfycRMAnxj86jeHa40S0U+Cez/zN/eHGc6dn0m8zjSaCu6dl6E5NhAKdw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795500182;
	bh=cxzcvGKSIviIxs/O8X0HAWqHLt+90oDZpIVj9OD6yuI=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=J45GWiEVJLdGZ3Oy2ElKFwuCf9OI7pCz6QiOOMnOibs1E+zoFOpuiXgnS5vix8J2l
	 iWmSPDT71TAhvicxo+ZD5jbvfiyod3Q/cCOJdkKZVI6+yR2EvTPiFph9045uSryESS
	 BOoMEmJ1ZTtEXfWv9NMLe3EBtUO64qQ2nLpLFr/eyTN79c369x7JfJXBfn+GYmnlsv
	 MRHRyi1drdN0IxPrAnynfvaO6Co6lePtdgmsMRbHGcerVS1yQEUpgjBu/wFjn8SVcW
	 9k7dWAyCLCUD5zgz5HyPVNJdUxNW5cy1o2DzSmqQn5pQG0TTHSc1MnZ5HGHTcgpU9E
	 puzaLptyytVmA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4957D80F32;
	Tue, 24 Nov 2026 06:03:02 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 012FD3A8
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 06:03:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DBC7F400AB
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 06:03:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SmCqHBA8S419 for <u-boot@lists.u-boot-project.org>;
 Tue, 24 Nov 2026 06:03:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 7FBF840068
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=178.251.229.89
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=178.251.229.89;
 helo=mx.nabladev.com; envelope-from=hs@nabladev.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=LJ6RfZyj
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7FBF840068
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 06:02:59 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 29D1F10FA99; Tue, 24 Nov 2026 07:02:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1795500173; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding; bh=cxzcvGKSIviIxs/O8X0HAWqHLt+90oDZpIVj9OD6yuI=;
 b=LJ6RfZyjqoVh3dv52up3IecT28uApUv/xK2OiJwU9eh8gmIHXBibvyntAaZ5zuO4WeaZ4n
 ES2gKX+ENndQ7RW5dFJ3Bfb+/AyRBr8n8BrRqpmOZBqaxt97Q23cln6OnBLWPxohfgpMIB
 k01veMS/11vT0LxyDOR8U5hKQITe85qbstBXhN9aL6I00yHHdSfpzZ/hDRRBDmWIkwh84T
 1Xfh2rZ1MAdwgnaNxTa3UmBkax2JKD+ZEdYLGqaHIjKKzsNrrpj+hePUjfjWGGmGEg3Jix
 HO2GTFzrzmyC4v+kPWmflN6cDhjC6yd2ZG9x4HeN9Sozz9Hb0CscwKxQEPJuHg==
From: Heiko Schocher <hs@nabladev.com>
To: U-Boot Mailing List <u-boot@lists.u-boot-project.org>
Cc: Tom Rini <trini@konsulko.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Heiko Schocher <hs@nabladev.com>, Peter Robinson <pbrobinson@gmail.com>,
 Marek Vasut <marex@nabladev.com>, Michal Simek <michal.simek@amd.com>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: [PATCH v2] Update maintainers and get_maintainer.ignore
Date: Tue, 24 Nov 2026 07:02:42 +0100
Message-ID: <20261124060245.509053-1-hs@nabladev.com>
X-Mailer: git-send-email 2.55.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-23.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Dinesh has left Altera (Info from Alif Zakuan Yaslami) and
has not changed yet his email address.

Signed-off-by: Heiko Schocher <hs@nabladev.com>
Reviewed-by: Peter Robinson <pbrobinson@gmail.com>
---

Changes in v2:
- add Reviewed-by tag from Peter
- drop change in .get_maintainer.ignore
  as Tom mentioned.

 MAINTAINERS | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6edf740a9ce..33af5ed3075 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1137,8 +1137,7 @@ T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-i2c.git
 F:	drivers/i2c/
 
 I3C
-M:	Dinesh <dinesh.maniyam@altera.com>
-S:	Maintained
+S:	Orphan
 T:	git https://git.u-boot-project.org/u-boot/u-boot.git
 F:	cmd/i3c.c
 F:	drivers/i3c/
---
base-commit: e578056c766d653270b14557c2a9d8daec414c17
branch: maintainerupdate-v2

-- 
2.55.0


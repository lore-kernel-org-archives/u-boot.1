Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF9B606A31C
	for <u-boot@archiver.kernel.org>; Thu, 12 Nov 2026 11:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=KFX+ab6O;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ziyao.cc header.i=@ziyao.cc header.a=rsa-sha256 header.s=zmail header.b=aTtFiEOJ
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2C2194097D;
	Thu, 12 Nov 2026 11:58:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EMCsxuyDPfAD; Thu, 12 Nov 2026 11:58:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 8565C40D84
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794484695;
	b=EZUj8gGA6H7o/buQ3L3NfEXHjn0kvupm1cVOmmppDNo8haKcqdxQSnPrGs/POrOvjXvI
	 2wrv1hUSTMSTwvf12xX+aT7tcI9W6EraIFE3mNYAgsOVM8IciwN6HKyP2nC29wfrvcUPL
	 f/5bFlliAz56JgJDfJOIAVGUdSHAjOQ7IOey4bE6OjewYDd0A9/SUHtXkjc/ldJKXEa/5
	 Sfb09ivvx0lygGAWQSl4UTK8vZIXZJKGBiD/FjJwYcgkA30nzjd6NV3A1Y77sOx6sQVis
	 2k6uT8rrRkWNNfjVdJ5IESSPO0QqDJ2rC1SZaX5f9vABx5k548iUtw4lDj5qRyUy/Ew==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794484695;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-ZohoMailClient:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=OzGs/tnWQXP18C9eR8B44MrGIq1yxSjGObiN/v6zYTM=;
	b=dOzagwcqI8FqECK+byd5Tpbkmh5L/u6FabXDIrrK1EgNc+vKN/XNwzhbhwXWqKDCZw5G
	 YSN2prdRGjmZa1pGAw4ekHOzPvNwQn/icpfv/gNMQno5uITdCGHOrtPx9/VutGhS1XiMs
	 FkU4Erk+RXRQt4hY/tx12JeFd7ImHjee5rPTVGN4t/YbR680gz9j4RN4EzVKlmn/nkur7
	 ixwye+8VqntRZH0XI9A/2hA1u94KYPCGpsa8tJjOr2AypwmttU3Iq3peL6WEqF8grwRGJ
	 WsmR/unAUlqss/J7BCCTLKb5hzWHCMtvt3OttqOr0qMo19Niz2Bp0veLWlC5GJ9n7lw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794484695;
	bh=OzGs/tnWQXP18C9eR8B44MrGIq1yxSjGObiN/v6zYTM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KFX+ab6O6/wUWJv0lbrdwTQRd20eduFgYhuhlsfcRPZrbuGtHO6NkjsDizMKUY9bV
	 NW5j6c/ir37MQOONCfig+NnSHFi58MRTVrA9hhQkk6rOuYP5Yx/++HzRI9C1UI1Dk3
	 lytQN5KZJkWDMzY4p4lFp1+xkkGsj/JlTNT6D7L7uvGpJKABz19VgabGDpCfStAP2v
	 1fniqoVP7NqQUrQ3lST/kPCUJAkO6wFvj7MZ6LwJhO572Ahl08rkNRGtcmulnswZ2I
	 RnAoj8AQNfoW2PEq9Q5oHh0E+gtn7H4McAsWmGcRE7D5oOLAaPeUYM/qPcLDvH/p5b
	 lTsLynIZ4gkrw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8565C40D84;
	Thu, 12 Nov 2026 11:58:15 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id F3CD9235
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 11:58:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D9F4A400B3
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 11:58:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4URsSKzNocca for <u-boot@lists.u-boot-project.org>;
 Thu, 12 Nov 2026 11:58:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 2BA9C40042
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.182.15
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.182.15;
 helo=sender5-op-o15.zoho.com; envelope-from=me@ziyao.cc; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=ziyao.cc header.i=@ziyao.cc
 header.a=rsa-sha256 header.s=zmail header.b=aTtFiEOJ
Received: from sender5-op-o15.zoho.com (sender5-op-o15.zoho.com
 [165.173.182.15])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2BA9C40042
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 11:58:11 +0000 (UTC)
DKIM-Signature: a=rsa-sha256;
 b=aTtFiEOJ4h9RiMsLbO4lVngKr5nXSVTzL1bSrFvQnBQtZ2WbgZxPO8aqFP9W7ZTzn+Xxn/IIDJ9kYVMBQKUJlHWuQ525FCvl9MFtqNFh8OipL4f2Uxx+WwYWDZfZ+hIJI1NZxB3S+SELKE+WnEoaK8y0hmMkFOruBI5OHfl/DnA=;
 c=relaxed/relaxed; s=zmail; d=ziyao.cc; v=1;
 bh=OzGs/tnWQXP18C9eR8B44MrGIq1yxSjGObiN/v6zYTM=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1794484683258485.34060182438884; 
 Thu, 12 Nov 2026 03:58:03 -0800 (PST)
From: Yao Zi <me@ziyao.cc>
To: Tom Rini <trini@konsulko.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org, Yao Zi <me@ziyao.cc>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v7 19/20] MAINTAINERS: Add entry for LoongArch
Date: Thu, 12 Nov 2026 11:54:37 +0000
Message-ID: <20261112115438.1837663-20-me@ziyao.cc>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261112115438.1837663-1-me@ziyao.cc>
References: <20261112115438.1837663-1-me@ziyao.cc>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-21.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add an entry for LoongArch-specific code and documentation. Jiaxun and I
will maintain the LoongArch port.

Signed-off-by: Yao Zi <me@ziyao.cc>
Reviewed-by: Simon Glass <sjg@chromium.org>
---

New patch, no changes since v3
---
 MAINTAINERS | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index b6ce499d0c20..c712c69507e3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1178,6 +1178,17 @@ F:	lib/getopt.c
 F:	test/log/
 F:	test/py/tests/test_log.py
 
+LOONGARCH
+M:	Jiaxun Yang <jiaxun.yang@flygoat.com>
+M:	Yao Zi <me@ziyao.cc>
+S:	Maintained
+T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-loongarch.git
+F:	arch/loongarch
+F:	doc/arch/loongarch.rst
+F:	drivers/cpu/loongarch_cpu.c
+F:	drivers/timer/loongarch_timer.c
+N:	loongarch
+
 M680X0 ARCHITECTURE
 M:	Kuan-Wei Chiu <visitorckw@gmail.com>
 S:	Maintained
-- 
2.56.0


Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6C98C79FA1
	for <u-boot@archiver.kernel.org>; Tue,  8 Sep 2026 22:18:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C21A540681;
	Tue,  8 Sep 2026 22:18:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pzEDL2Dr9QMp; Tue,  8 Sep 2026 22:18:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org D864240675
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788905914;
	b=qYSSDVIop3jmHWl29rdttxsy3oD66D9YkP5o9uTUQNNxtHFAem6NbuucgAQvnVqnQkEb
	 hwrpMX3sOfU2E8x4mMnKbXcbTAIdOor2IPcW7G/RysAEYhiggCxP0kFfqx6e3DTSY8WFZ
	 J54BYoMXalXZxglOKKqZ+SXvxYnfSUwWzgLcb2H1QmwlDC8l9jwcL132Qn+SYBvNZnRuV
	 sih5aKWkXH1O7v4QpZIl0tuBeOmF023jeQtEg+tIX73fO62wRL8EhXay3jqhsgRPP0Fwi
	 i1F+rLxOaAChOnrSHJnONCh48q+TNOdSEES6d3Sj1i4QOvKpZluZQbpWvi75k86rFgA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788905914;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-ZohoMailClient:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Mry3ilSsfWfXNsiDCT16dluguC8E+iUqkXYGHWNXfbc=;
	b=VwPKXiHm4W9/sgAwe/h5SDCKOMKSKuio4Asp3YdbZBZ58y1jr6FOAeibO1Tnc9HDhvYa
	 bXoN3q9GfXDTfJdtJ3HJDLIyIVtoPw8tbYCmY3zqAOAQTBdZ4hMbosX/lXfXN9B0A9Bnx
	 cdPgSShZTO20vPixIZNb8y/AJtyPq9iB6+W4B5cz5KesUPNiIvcCQgN8YzNZYpp2pS7d0
	 PGYowhA8kthb5m6PM867F33BnaIxEwria4x8eqnIFqomJoyyk4W0qbUKs2JiZILdkO8St
	 wDmuFVsnYgIpyl/Wwwqxl6N4b8uKYDk43HBD7CI40MVO+siJ2AoPXzkZBwL8L+lXtUA==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; dmarc=pass header.from=ziyao.cc;
	dkim=pass header.d=ziyao.cc header.i=me@ziyao.cc header.a=rsa-sha256 header.s=zmail header.b=hohHy0+0;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788905914;
	bh=Mry3ilSsfWfXNsiDCT16dluguC8E+iUqkXYGHWNXfbc=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=P7mgMkB59Q+kGWppw3D2dOM2DM7GlhQs9RrJoRNSaHuk7UtKuMfT/7lfID9dkTNlQ
	 OkF382bl6b7FHXYxT9Fvd901YEzFqzeztr54jwaI6Q2iZJ6OjDeioGzo8sJlREVQnb
	 Oe9fr1Fq88YuQdj6iRgET3npstevWgP9ylVqdJ+AU93jv7rC+FCkCLMBmZ95uhm4IW
	 x+dkozntWLH76yIKUx3IM9tIqxsqr8q20U8yedGCu4dd8ZplPcaTb5PGjK7lJBtq1H
	 PvhT+fyT010EofJsQvv7yotEuIczEoMYD/UU65auMELmFR0kwWqXi9VKEgbhkVYpK7
	 WLK/72zYVLBUg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D864240675;
	Tue,  8 Sep 2026 22:18:33 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 8AC8330D
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 22:18:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 80A2740670
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 22:18:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7pNXOZ7vu1ST for <u-boot@lists.u-boot-project.org>;
 Tue,  8 Sep 2026 22:18:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 0BC7A4064E
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.180.15
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788905911;
 b=Bc/atM9eAdkrOwoDeEmHWA2FhDOvH+rQNE1GvCdDtuJdemn9882V8j0/uB7ewA2frHKG
 5H6uL0s/FLlgfA6bQJwKEYJFGVeyBH6BLpa3eLOrvWkgNw4+DJzZRUwcNmqIKyAfEpCi9
 zu0rk/IAvGy/te9391UDjrLpP3Bv24sYQZdpA1bM5AQC38/AfPbpQb2GXMLoCGtZOUIkX
 g0hKbuNkwQOfo0d9Vn4Dh/2SWC7oAA/u2m2lnOEGe4H32ZfwGbg0So3qVP+TYUJLULUeE
 yts1hrctLk7+eAMnhGVX9bKnOBJYPd6rSIguDT3W2JJhw32ql7mI1x0tzq8OFarzMDQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788905911;
 h=Received-SPF:DKIM-Signature:Received:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
 X-ZohoMailClient;
 bh=Mry3ilSsfWfXNsiDCT16dluguC8E+iUqkXYGHWNXfbc=;
 b=YeUFYqfN+8t0CFWtsr0Nvo8kgZFdHPC5emoTecczwRkIXzsR4yBtVIVAkR+zF8NrSLdr
 VIueDlqzK6CmAWaGtpGZmt2mi30/vh6Th0IQZYpxVw+GU2zB3FrPz3SkdzBXhBdIX6Pl6
 p3Xv/93SXXdsMazJb79/Nf77F874o5Zf09YNtdNlpVEMgGCNuvKQuElWKrxTxqamsNNog
 EeNAZdCY28dPg1mFvWQMld/V64LfABiK8T294Q1HwNpGGKyEDiFWeEORLAQwMoiyOyEB/
 iYkDlL86wbk4UU6GDvBlwYC+ItO6vcfaIz4O+2ZiZ4sKKPl1/GeUn6mIw+xg72RyycQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=ziyao.cc; 
 dkim=pass header.d=ziyao.cc header.i=me@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b=hohHy0+0; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.15
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.180.15;
 helo=sender6-op-o15.zoho.com; envelope-from=me@ziyao.cc; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=ziyao.cc header.i=me@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b=hohHy0+0
Received: from sender6-op-o15.zoho.com (sender6-op-o15.zoho.com
 [165.173.180.15])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0BC7A4064E
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 22:18:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1788905894; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=eaYd0Go3kGJrSJlrWz6MZBNvpqeqK8KIz3MboEBLFtO4FnSTmi442DWB6Ehcg55ZV3z5ppHqFouyOMDCDz8kd/CaSI7MSx/j7klkXFRqgHyLH/ng6felUbOoYeM4pkxOEmfutOZbU7EyTcwI5f0JjrdJa6QNHnF33EqHT5qHhTo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1788905894;
 h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=Mry3ilSsfWfXNsiDCT16dluguC8E+iUqkXYGHWNXfbc=; 
 b=Y5nIMnbYOJmejhXZJ5sxk21p9moMzSF1t0epq7jpuv2kdjgRmjbzOb3E80C3HLUjGtJSL+gnCSLOyuHy+r/+v1CVdAN92g1Aul98uxSILl8rZ91YFJKOyT5enddF8lW1nXbRhVVZWJp8nAGDOUFxU1w8N15HLwKcJMww/k2Yfis=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1788905894; 
 s=zmail; d=ziyao.cc; i=me@ziyao.cc;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=Mry3ilSsfWfXNsiDCT16dluguC8E+iUqkXYGHWNXfbc=;
 b=hohHy0+0hSieBlS2lRDFZJhzG2RDZAQ1jTkptBocvBSR6z917mOUVnbi6fkWMhji
 1hYBtImrdgtj9Kl8ySQcCbXIGcIIzAfMBkIwyo2MI7uqhoP9WjavrW/3QvlQohCjNYI
 EKoth4QvaPPzjg+oMDv8cpvDYfOoIIqoklsDzvKo=
Received: by mx.zohomail.com with SMTPS id 1788905891306871.4133636646299;
 Tue, 8 Sep 2026 15:18:11 -0700 (PDT)
From: Yao Zi <me@ziyao.cc>
To: Tom Rini <trini@konsulko.com>, Tim Ouyang <tim609@andestech.com>,
 Leo Liang <leo.liang@sifive.com>
Cc: u-boot@lists.u-boot-project.org,
	Yao Zi <me@ziyao.cc>
Subject: [PATCH v2] MAINTAINERS: Make RISC-V entry cover all paths containing
 the keyword
Date: Tue,  8 Sep 2026 22:17:41 +0000
Message-ID: <20260908221740.27927-2-me@ziyao.cc>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
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

So files like riscv_timer.c won't be accidentally missed. Also remove
hardcoded paths that will be covered by the pattern.

Signed-off-by: Yao Zi <me@ziyao.cc>
---

Changed from v1:
- Cover all paths containing "riscv" keyword
- Link to v1: https://lore.kernel.org/u-boot/20260904193517.22312-2-me@ziyao.cc/

 MAINTAINERS | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4e9ccca5ca44..537d52efbb2f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1512,13 +1512,9 @@ M:	Leo Liang <leo.liang@sifive.com>
 R:	Yao Zi <me@ziyao.cc>
 S:	Maintained
 T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-riscv.git
-F:	arch/riscv/
-F:	cmd/riscv/
-F:	doc/arch/riscv.rst
 F:	drivers/sysreset/sysreset_sbi.c
 F:	drivers/timer/andes_plmt_timer.c
-F:	drivers/timer/riscv_aclint_timer.c
-F:	tools/prelink-riscv.c
+N:	riscv
 
 RISC-V CANAAN KENDRYTE K210
 M:	Sean Anderson <seanga2@gmail.com>
-- 
2.55.0


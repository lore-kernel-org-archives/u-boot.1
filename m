Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFEB8C5DF87
	for <u-boot@archiver.kernel.org>; Fri, 21 Aug 2026 08:45:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 59C8981187;
	Fri, 21 Aug 2026 08:45:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wy9TydmCTYR0; Fri, 21 Aug 2026 08:45:17 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787301917;
	bh=8is9vSj8hbloAtwYmr3SGdSG4zlqaA54/+Lteh0RqeE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eS8GElYVHH7QOyLLlN+G+qa81QzpmNtnemRhA9+8J5/0/rconyGpiPJ+0DCD0sSWk
	 E/QvveYcgMUeA3ql4o7Y5kULIrgGFEfE4efHFyJtMyOUB8zmXfymVJS4+iACo3VcX0
	 wm1MXFyEpL+HUC21eT0SwRg2PAxcQpn5QUSmODOiF854Tp9KY6L+f+3G8haPHmZjse
	 UXLHLujshd9uVt4lJr3FtL5R4NYb9aw8W5WZfswCYzcwhqUjGGduPT/YEoTOPLzX5R
	 ACJ6WJAsNxij0Pa2f6h7x1/KbIqz73N6f0AC1Ir7/yqOu6pJs+TDlaYvm8HK+5hebk
	 ezEx0C1VuQXwg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 607258118B;
	Fri, 21 Aug 2026 08:45:17 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id F0A8B4B8
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 08:45:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E269D60662
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 08:45:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XCeDh_q66m8M for <u-boot@lists.u-boot-project.org>;
 Fri, 21 Aug 2026 08:45:15 +0000 (UTC)
X-Greylist: delayed 146 seconds by postgrey-1.37 at util1.osuosl.org;
 Fri, 21 Aug 2026 08:45:14 UTC
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=ziyao.cc header.i=me@ziyao.cc
 header.a=rsa-sha256 header.s=zmail header.b=KjLze8sw
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.180.15;
 helo=sender6-op-o15.zoho.com; envelope-from=me@ziyao.cc; receiver=<UNKNOWN> 
Received: from sender6-op-o15.zoho.com (sender6-op-o15.zoho.com
 [165.173.180.15])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E6FCB60661
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 08:45:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1787301907; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Cu0PMlU5Lon3EfzO5QpThncfghhbcu/c0opgRMHlTuxv3Ms4XnlsDo8aANC/g5pSpBxLCtoT2y1lyyvm2nV7TyAqwVOzB097Z+qfcPBBFVkmzFd195cbY8M+N7pDEM6RA3BCQzmdoQaLOaM2iLLte2ECk4awsxTGtG2AfX8vU6Q=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1787301907;
 h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=8is9vSj8hbloAtwYmr3SGdSG4zlqaA54/+Lteh0RqeE=; 
 b=SigHseSDuIY89Zhh/cpBC3lipkJvZ6/jjxLjW7IbSbnn0EqylaoTifwvPCsSVxBzNlekWQHytvyhekHfEBFVQJdHG5TtMPH24tevCwgS4DQQrLnCV1hr1PerLXen/t5Ma79AcWNc4C5NiEhYsPHEd0ebyk8TQq0+9gUr1MKCAFU=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1787301907; 
 s=zmail; d=ziyao.cc; i=me@ziyao.cc;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=8is9vSj8hbloAtwYmr3SGdSG4zlqaA54/+Lteh0RqeE=;
 b=KjLze8swVcVfvCK0U+wl+6JyjN7Fk3w3R+iv9RQacZY5L2UxKtbZJA2GrkWf6Ef3
 7Pcol/mYxesGt+2kynN/j49b54ohKKh9M0r+1XjENkrxvkF9O26QPWNrfud8gL8OHNI
 3b+pTGD8I+GA+CFyDopEvkmkst2h3x3GyiD9oGpE=
Received: by mx.zohomail.com with SMTPS id 1787301905821728.4911541559039;
 Fri, 21 Aug 2026 01:45:05 -0700 (PDT)
From: Yao Zi <me@ziyao.cc>
To: Tom Rini <trini@konsulko.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org,
	Yao Zi <me@ziyao.cc>
Subject: [PATCH v3 18/19] MAINTAINERS: Add entry for LoongArch
Date: Fri, 21 Aug 2026 08:42:18 +0000
Message-ID: <20260821084219.1703743-19-me@ziyao.cc>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821084219.1703743-1-me@ziyao.cc>
References: <20260821084219.1703743-1-me@ziyao.cc>
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

Add an entry for LoongArch-specific code and documentation. Jiaxun and I
will maintain the LoongArch port.

Signed-off-by: Yao Zi <me@ziyao.cc>
---

New patch since v3.

 MAINTAINERS | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index a9b438d0074e..d4ed4b2d115e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1233,6 +1233,17 @@ F:	lib/getopt.c
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
2.55.0


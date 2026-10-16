Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83D04CCA462
	for <u-boot@archiver.kernel.org>; Fri, 16 Oct 2026 06:55:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EC1A6812D2;
	Fri, 16 Oct 2026 06:55:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HVhOK9Vqw7Wx; Fri, 16 Oct 2026 06:55:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3046C812AC
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792133729;
	b=ruvenBOPY/ucBEMshkUtpTkJMDx3tOGqlo4Y5PFMxhjWoyfAVrgO7g1Zbuf+bZsu+EDr
	 JbMWmBhOwoIsiBmAXSmUbrvhub4g7AYYPN40MG3AEbIBCiCyzKn/Ij8o9G6cvFby+a757
	 2Fr7Leyyj2QFe4UHLfemPoQ53ZTcqaa9pMsrvSzlmFx8M9IcIDC0UBbN58C3yRROYzI1m
	 p30MvpjJig8xqmU4L1Vo52+ts/fgMT8hnRL3NRPSRBKTAis1yNO8eOnIkVzKA3zrOKr6j
	 HBqb3WCkZdWg84xhYQ3ztf6FA9it8Gt/6fDk9ZUaHy0Co4HF+gqRXF/BOE9Uvt0vaYA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792133729;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-ZohoMailClient:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=vN3k0cN/OS+5kGASpFVb+u+MQfH20dDlVyV3jiNlP7M=;
	b=C1oFyMFInSY4f+oP8Tvz0SN3uEOHlIn8BpkymoH3QQTjphuRMqVi7reh/lfmiegGackX
	 Zw1+qIZ0SJHNKWERL9G7ZPmtc2cZfnGlrS989F/6EC1KA4yUJ85ksEo8rP6h/ePtWvxYq
	 LBXKM/sxm7HwMbDWBe4HXOXBxWAcNjEym2CDX/GnKGbqoMmdHfqQpxkP8IUPs/YSzVuJM
	 1Pi23LTaEc79g0VQ/y48LmfNBIR0fvWZAUaVRxf1rbGRa8Dh6r28ZjAh3HOcqOPGrwCwB
	 tKDFDHgxY9wVjDH+k1zMuQ5CJQsGZwz7QMByw78vQ/kwiNhas3NiXERoDH457LShbjw==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792133729;
	bh=vN3k0cN/OS+5kGASpFVb+u+MQfH20dDlVyV3jiNlP7M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yLbS3ZMmWbCSwMiGXIEfepeq6Qlm3UAkMMidwJE+yd7XAS8CNSHC0dU7fihFpvIAZ
	 yTE8uiGY0aaxz9v/R0bzpcnEupSeHgJDq69OohBZTwiVAHMP1wCRDGwGbom2ztpDPm
	 OCL8kZMz4xytg1ilQ6jDEcMpNMkcREEzJHOxPiFSMap857aLH/54mKjOliS5LaZ5kC
	 HkP4UBKxu/XE3gMWtWgGKmKVJsA6b+jHVKA8RvKj4raYDPYNiPuB1EK8TCXStQPV+l
	 WtyT4XP7eyE7Gr1JCfK4Re5raTGLYWbiKoFbRfPGWO4yfSDn5y08w8tagbiKNlyMny
	 LFrZMmtcm+KCw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3046C812AC;
	Fri, 16 Oct 2026 06:55:29 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 799F91E9
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 06:55:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6B27740969
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 06:55:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id F8JmeFAR0qON for <u-boot@lists.u-boot-project.org>;
 Fri, 16 Oct 2026 06:55:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org AC20940960
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.180.15
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792133723;
 b=VO48n24Suz+MJXTlBeQTcQceLLpQ9YKrLGiYnKU/yCQiVemBMQF1oQVvjGalXayKknsg
 G1RTkJx6Vgisjkq+p6YxJoi6OB8ZfKpjshSbuDdzxZspiwSF8eP/SQrGTFFHuqrAle6Oh
 d/EXwyA6Xvq2K61Nak8ItYhUwlIWVFPR8rcjnrL8jzMQ+6NpwQY5/16rk4Br4GKitcaeV
 2yUkIdRMLyagpQUI6m+wxIKGCrC9luRipZGy0pgbAcCuQbeU+p/6dL9r0Eq4OpBP8v3RL
 J5vi9ow5RWm7FX13zjBdLaVqSpQ7fnpXL0d+eqOYb7z5m8ryWZQbQ4ih0pEtytdLlIQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792133723;
 h=Received-SPF:DKIM-Signature:Received:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-ZohoMailClient;
 bh=vN3k0cN/OS+5kGASpFVb+u+MQfH20dDlVyV3jiNlP7M=;
 b=PGG5FC+iBx6A4ihLDNSQ+ATfPd56BxJsgY4pj+apk6aULbRwpf75T/rFXRiUt5t6BwcI
 N+Hjqc15rRE5MMwAItzPT21l4h4ks13R9wzmHAb6+EG6w58jPS7g7A29yOHrkU/AR3laL
 I7Zd+Co1EAmVA25nHTFslDLJPdwI7prDgvsM5lrw0uyxW3svMAlNDjvn02yF04ccgkj22
 cHEC1aeiyJphaVnmw//ITO43jiSeHQB/U9UHdnTswg00xNWKfeJfmvC9/icyARy/EWhgy
 H8FEwwQJDYWBB70/34Dlz1Hkyxcgl5LXKo+AYtSwj/8O24VAm5pwawpzZ/YlRliazBQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=ziyao.cc;
 dkim=pass header.d=ziyao.cc header.i=me@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b=V+2N1iMA; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.15
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.180.15;
 helo=sender6-op-o15.zoho.com; envelope-from=me@ziyao.cc; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=ziyao.cc header.i=me@ziyao.cc
 header.a=rsa-sha256 header.s=zmail header.b=V+2N1iMA
Received: from sender6-op-o15.zoho.com (sender6-op-o15.zoho.com
 [165.173.180.15])
 by smtp4.osuosl.org (Postfix) with ESMTPS id AC20940960
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 06:55:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1792133717; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=dV/mlluEHKinyKWQCh8ZV5/BkmwuOLvdVv9WvKYqe11iMcfqBHk1SbwJOe0grGS1pZzinEpRb+BrvKkpEFdSTgb7p5K4FlRt3p+9H9pv8QG/Lna3yss/oxz1YoQZBDKXOKXlR7YaJ3cmjDXj9VSkgfzHksfhCcVrYGcVVrB/LFw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1792133717;
 h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=vN3k0cN/OS+5kGASpFVb+u+MQfH20dDlVyV3jiNlP7M=; 
 b=cx2ZU/NbuE+DYZ2HpNartlk68EF2JKS+XxsMmsC1+ZJd7ICvoIhaZ4XbVrIBkoBBplXoWJ+7QxsL5y+QOBAtXk55AIY8WbCkMR+OVPJLKjofC8UwORJl7Kuawi4WH2O3ZlrXUnx3l5nLFmX4pgFkTkHdQ0+BaUM9N6yN5Rjve7w=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1792133717; 
 s=zmail; d=ziyao.cc; i=me@ziyao.cc;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=vN3k0cN/OS+5kGASpFVb+u+MQfH20dDlVyV3jiNlP7M=;
 b=V+2N1iMAPe0JT18p2X1QIVFq/ZpogBW5QBGYLM1EguVLd5cd1DIKG68sDe+37w3o
 EY3IBLHLkY1PngskI/b/hxHtQDOeHAgMqZKRfUsPM//qPb5itx4P6jP3TgSnDcEIF/G
 o7wJhPm9tN+aqxsemHxmJ+/j0iNx3psZ54hZFqHQ=
Received: by smtp.zohomail.com with SMTPS id 1792133715959597.8279926275497;
 Thu, 15 Oct 2026 23:55:15 -0700 (PDT)
From: Yao Zi <me@ziyao.cc>
To: Tom Rini <trini@konsulko.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org, Yao Zi <me@ziyao.cc>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v5 02/20] linux/io.h: Use map_physmem to implement ioremap
Date: Fri, 16 Oct 2026 06:54:42 +0000
Message-ID: <20261016065500.137544-3-me@ziyao.cc>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261016065500.137544-1-me@ziyao.cc>
References: <20261016065500.137544-1-me@ziyao.cc>
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

From: Jiaxun Yang <jiaxun.yang@flygoat.com>

ioremap API is here to be compatible with Linux drivers,
to maintain compatibility we need to ensure we are using
the same way to determine virtual address for IO devices
from physical address.

map_physmem is U-Boot's standard way for doing the trick,
we should follow that. For architectures VA == PA it has
no impact, for MIPS it has it's own ioremap implementation
in asm/io.h anyway.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Signed-off-by: Yao Zi <me@ziyao.cc>
Reviewed-by: Simon Glass <sjg@chromium.org>
---

No changes since v3

Changed from v2
- Collect tags

No changes since v1
---
 include/linux/io.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/io.h b/include/linux/io.h
index 79847886be95..ada6525a1c6a 100644
--- a/include/linux/io.h
+++ b/include/linux/io.h
@@ -59,11 +59,12 @@ static inline void iowrite64(u64 value, volatile void __iomem *addr)
 static inline void __iomem *ioremap(resource_size_t offset,
 				    resource_size_t size)
 {
-	return (void __iomem *)(unsigned long)offset;
+	return (void __iomem *)map_physmem(offset, size, MAP_NOCACHE);
 }
 
 static inline void iounmap(void __iomem *addr)
 {
+	return unmap_physmem(addr, MAP_NOCACHE);
 }
 #endif
 
-- 
2.55.0


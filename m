Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB6E606A31C
	for <u-boot@archiver.kernel.org>; Thu, 12 Nov 2026 11:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ggv3Lpgt;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ziyao.cc header.i=@ziyao.cc header.a=rsa-sha256 header.s=zmail header.b=i+g5Q6qL
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 099B9815CC;
	Thu, 12 Nov 2026 11:59:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tZ0hHBK7VTAd; Thu, 12 Nov 2026 11:59:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 543CD81586
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794484759;
	b=UdPFs2ORVdJo0KcyQ00FvP8mOo3guxoI21RVIIuYVB47NfI8ihqdzPMvJDyr5BPu+OT6
	 a54SCU9HzNR39QcRd+M9S4YnQtaXiKhckKQPcWiS1oiuAIDcSSng//g8HqXA3MfP+7YTh
	 XzZOdMu5ub3wzCy5785/XhjospkmlD3+jVE338rrVxiGzYQja5hfGYkO5YzCd2CQ2xubH
	 XR/AAQuWglWD7UGt4nIe9mXErk+4CMmHW3FzhKuVIYIqu707l+XUrJXAmEWYfC8qamCOS
	 RO4j0Wg4epDepgusnip+JjRZzFxR5zIgrf0e72Q7mnU+asOPZBoG01KgjBGR0ztniAg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794484759;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-ZohoMailClient:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=q6aSX6ONRm63NPz6iXzvq+27gKJ/JN79ri18cTmRWhA=;
	b=nUrN+EKeM3ZcD+UqFGSt3c7UsGKvBU8GxejGivuhecBHv/p+pIhAbX3xdaUQsNQmAEkY
	 SklnGvfYjcdMLS4DLiRiEQSQlt/eP06kyjahcUiIK00chMTuDmoX8nDszmRkFN2jof4Pw
	 EocK8K9bdm8NXzdSlf1l/+SVfZbyvkHuTUKRRMN+W7na8grnQQ25xyBoiD7dYls6iCdGG
	 y3f/XjbuCACJY+J2WSHSpBDkDF5rtfT/4h4srxyhVLSyOnMI4sdZhByXutNUjYVFcSb+O
	 BKZZEZcNXCPQ5w2lm1lkuZUfZHwi9ytrMfQPT5mzg74jgopZMmSMeVK9avfboDM0k2w==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794484759;
	bh=q6aSX6ONRm63NPz6iXzvq+27gKJ/JN79ri18cTmRWhA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ggv3LpgtuWNT8YN31zXJGxmGyaXBZRLdNDGP24tjtStK94nK0FVvA0dcBri3ecfAm
	 MohJGirE719ZhOhQU0H7P/buh2jxjVSWbhQAwbDjP3mMI6daHvkoGJKBkjYRhzphjL
	 XMNDQyb1fljKvKxR1RZoTePcae0WPBTOKHC2MRsBZuJ4/iIQi1a1pEB75gCb4z87a7
	 Je53UbA37+9f3iGZWoGS2HPZX0C+00rb0hIiM+1BYhVfTZZ+e5PY+ACkHJsdUI+IOW
	 0nRcghinovw8HkTX64+5/Ooch3FmVG5S3PvQZ7UDFzNiTx2NgWRmoMQE+qVy0J9gd4
	 hfvRqUk9ITBCA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 543CD81586;
	Thu, 12 Nov 2026 11:59:19 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 5DAA570B
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 11:59:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4F24360A85
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 11:59:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id N2zLysBiwfMB for <u-boot@lists.u-boot-project.org>;
 Thu, 12 Nov 2026 11:59:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A7CDC607F7
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.180.15
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.180.15;
 helo=sender6-op-o15.zoho.com; envelope-from=me@ziyao.cc; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=ziyao.cc header.i=@ziyao.cc
 header.a=rsa-sha256 header.s=zmail header.b=i+g5Q6qL
Received: from sender6-op-o15.zoho.com (sender6-op-o15.zoho.com
 [165.173.180.15])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A7CDC607F7
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 11:59:14 +0000 (UTC)
DKIM-Signature: a=rsa-sha256;
 b=i+g5Q6qLnYuXSGHEFbZvMFQFsn1DZmJHfdJ3fZ2s+OzF+QBmURqwhs53JwpguvyYOLKwcIBwF79xINAQwUiUzS6zCsqk140rS6zVNTbcz8ySsuVbqbVZIlsNmUTDLFfg0zJdX4zXqOyYoMdX4QWjaQv8t4UwY+e8uZ3GKGx+QDc=;
 c=relaxed/relaxed; s=zmail; d=ziyao.cc; v=1;
 bh=q6aSX6ONRm63NPz6iXzvq+27gKJ/JN79ri18cTmRWhA=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1794484499352552.7638715269876;
 Thu, 12 Nov 2026 03:54:59 -0800 (PST)
From: Yao Zi <me@ziyao.cc>
To: Tom Rini <trini@konsulko.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org, Yao Zi <me@ziyao.cc>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v7 02/20] linux/io.h: Use map_physmem to implement ioremap
Date: Thu, 12 Nov 2026 11:54:20 +0000
Message-ID: <20261112115438.1837663-3-me@ziyao.cc>
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
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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
2.56.0


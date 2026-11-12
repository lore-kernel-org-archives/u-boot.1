Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2184606A32D
	for <u-boot@archiver.kernel.org>; Thu, 12 Nov 2026 11:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=yzdwe7PE;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ziyao.cc header.i=@ziyao.cc header.a=rsa-sha256 header.s=zmail header.b=QuNZQ3zW
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 71BD540CA6;
	Thu, 12 Nov 2026 11:55:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zzDWP83KWZKk; Thu, 12 Nov 2026 11:55:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org BF974409F2
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794484557;
	b=jdFvlc76+DLoPK6jY3h+9G2ZOefC2QQ9yzSig43Gzd+9yYPp9i5O56gpJEJTriVgUskw
	 sGelNp5LDhB2Mk1KKOLLDBTF4IvGIEUO78RyKxC0Io/QWjYKLNtQFWunN3eL8wQaDgbhr
	 2PH6FJEEXVh4NfYeg4tOkPGXmsF5aXbZLf/E50/61GD5E02aiayxyHbgMzdPlTxwb2AMp
	 6YE4ea8PT0pgwMZSYfgA5VPwlVFp5Zdf22srpmLMevJ1UI6SljrF43ue+dT44VF9taBUf
	 m1XopN0GuZo/g09Afv8NsdTl7XPw6k7Gd/v+ip5kzy2k0EviOhJNVqcYCIgQ2j/+ZKA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794484557;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-ZohoMailClient:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=vEi+eFzOU1Za4qzWsBj0VXvrGv0dhkmiQoX+t4byaCc=;
	b=RyBgOLlV8tCFdXQ3aUD/wZarBeWK+Z8Opma5oY8gs5DqyTxSq/b3k5JIATbacsX/NMG5
	 CcfQXAylKoVpofJ2phShG+eq3QrjVV8J49MbHB5x8sCbuyRbQDvsq1+DESKGNlrvulYS7
	 k5RkVDj2qXSDptSIAm5ZL/NClo2RV/CbO+n+ittzwnWdNFAG7QnwPfjxdf/ZrH6a+pxPc
	 iP6EtVcIXvKJihhiw6Q4GGhXhTAsM07Yfgcv8xfzguAI2CIdO5M63aHYHQ3BV6J1m430f
	 vS1pAPzuLXUjiJ3QGwVO5e+yIp5oKv94ct6x/JtvrCJZGOX4XqqrfNSU8Mk3g9K3cRQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794484557;
	bh=vEi+eFzOU1Za4qzWsBj0VXvrGv0dhkmiQoX+t4byaCc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yzdwe7PEzU4DU6F/WTxf58EeNzpIWIL0stN+tmLySEFxIlVUENzMGjzg8yV5z6EoU
	 0P26V5Y7cclyibMG5MmjXXf2deJi6OgKelI+qYQ7ZDPu9M7AemUZzcb5DCJfY6Zc0N
	 GNtUoziZC75f5s/A7jQBSYIlFfPg5inrZXUGal4PRWUwh2RHIw7YszesQBTO8UGz9E
	 nZc3rJRiiD7jhRHVpF2XVdxboC69/g4JFnPC8HlivM6h04cEhohm0jVoedekMqF3xL
	 Bp9hL2yda97wNYLMrsR0WY+2fYYUEbmz358DkkqfaU+Zyd5AsDYJHYl62sfBS1oRxu
	 VfmAvJ9tWMsag==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id BF974409F2;
	Thu, 12 Nov 2026 11:55:57 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id F13D828C
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 11:55:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E2FAB400B3
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 11:55:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NweViaDeGxIF for <u-boot@lists.u-boot-project.org>;
 Thu, 12 Nov 2026 11:55:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 4E90240042
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.180.15
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.180.15;
 helo=sender6-op-o15.zoho.com; envelope-from=me@ziyao.cc; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=ziyao.cc header.i=@ziyao.cc
 header.a=rsa-sha256 header.s=zmail header.b=QuNZQ3zW
Received: from sender6-op-o15.zoho.com (sender6-op-o15.zoho.com
 [165.173.180.15])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4E90240042
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 11:55:55 +0000 (UTC)
DKIM-Signature: a=rsa-sha256;
 b=QuNZQ3zWtQpZ5kg3mlDDnTMxAq8srOh17kuYOyjGI9e4REItY3Tj2QdykBCKweLzeI4+8rZpPJGiBynLJPqfSoSiBtPlTFxKLnRPYkPuCfbhxh+fQmYMNg7qFjYW0UuXDwBGyXG1euwQMQG4JAyRN5Kn8m0uekxIBHHPxCVmNkE=;
 c=relaxed/relaxed; s=zmail; d=ziyao.cc; v=1;
 bh=vEi+eFzOU1Za4qzWsBj0VXvrGv0dhkmiQoX+t4byaCc=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1794484548857107.30549148401053; 
 Thu, 12 Nov 2026 03:55:48 -0800 (PST)
From: Yao Zi <me@ziyao.cc>
To: Tom Rini <trini@konsulko.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org, Yao Zi <me@ziyao.cc>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v7 05/20] image: Define IH_ARCH_LOONGARCH
Date: Thu, 12 Nov 2026 11:54:23 +0000
Message-ID: <20261112115438.1837663-6-me@ziyao.cc>
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Jiaxun Yang <jiaxun.yang@flygoat.com>

Allocate the next value to IH_ARCH_LOONGARCH.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Signed-off-by: Yao Zi <me@ziyao.cc>
Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
Reviewed-by: Simon Glass <sjg@chromium.org>
---

No functional changes since v1
---
 boot/image.c    | 1 +
 include/image.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/boot/image.c b/boot/image.c
index 289e80f23a7f..cb12f9db01c1 100644
--- a/boot/image.c
+++ b/boot/image.c
@@ -86,6 +86,7 @@ static const table_entry_t uimage_arch[] = {
 	{	IH_ARCH_X86_64,		"x86_64",	"AMD x86_64",	},
 	{	IH_ARCH_XTENSA,		"xtensa",	"Xtensa",	},
 	{	IH_ARCH_RISCV,		"riscv",	"RISC-V",	},
+	{	IH_ARCH_LOONGARCH,	"loongarch",	"LoongArch",	},
 	{	-1,			"",		"",		},
 };
 
diff --git a/include/image.h b/include/image.h
index eb19f6d34e39..41310155beed 100644
--- a/include/image.h
+++ b/include/image.h
@@ -139,6 +139,7 @@ enum {
 	IH_ARCH_X86_64,			/* AMD x86_64, Intel and Via */
 	IH_ARCH_XTENSA,			/* Xtensa	*/
 	IH_ARCH_RISCV,			/* RISC-V */
+	IH_ARCH_LOONGARCH,		/* Loongson LoongArch */
 
 	IH_ARCH_COUNT,
 };
-- 
2.56.0


Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CDDFCCA462
	for <u-boot@archiver.kernel.org>; Fri, 16 Oct 2026 06:55:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C2AFF409AC;
	Fri, 16 Oct 2026 06:55:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oYbHx9EXWvVf; Fri, 16 Oct 2026 06:55:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org CFF764099B
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792133737;
	b=ZO967DLfQEVFKysukaIJNObmN53YMhmvQ2id5Y9G5y8sDxvqelFKkeo+s1KWC4GM6kYp
	 kYlCONvNKBIT8F+Ff1YSysgFooY7VuYHQ9113NXAoCNIvHh3J3bxCFUAfcP7WTwrJTjn2
	 WQfv3arNWB7SVpBgKYVL2ZIOaobGdcvLEOo6MqwgwA7rt+OsX5YBCuI2TFCCPI+naOj5L
	 SzbeU1T9tKTGUtrEebopS/gMzU3JlqJivpTBUn9I+5WiznNe9syVpPRM+MUWM5Q3iDhkQ
	 hqgOlDoEm54grZg8t7cGl0RzftX2LKhyvv/dWDw3ZK2dCjbHCDiadPIJJjxSmlbRqFA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792133737;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-ZohoMailClient:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=L5WWJleYDxdloeiXkMHJQojKZem/27SZgbldKjS+rtk=;
	b=nTc6hAq9K2YViL1EzTOFerjJRKkZAQB1q9my3vS8WI+vcL5vU7iDZwQWrcsE044nVVV7
	 FXaNMeLOoBTNKw2sTxN2UaaYUPEt8i8mLXMIvlErS6T5EYHmJjnxD6eurncfq68YhL5w0
	 f9rw6Mf3sIedYmu75aqrI1BPD1qQrSzHtOW1A0NCSQLNwcb35dBycwjJEsK433XjsADu8
	 PwJSzLm4w61h9jif/eV6Azy2iclH5hXNTszCzjEaCXCyB5JxIIyQ8ymKmqDMLQSA+4C9w
	 qKBrxCkVxkScPULcecu2hdjSuq9yNFMnak67ed/ruZHIwsm+T0sBjUWqUSuf+zBJ3yA==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792133736;
	bh=L5WWJleYDxdloeiXkMHJQojKZem/27SZgbldKjS+rtk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yBxBVJOEk6MvWlCuTKW2Ne4uSDTOAPgrnET7yIqkxNO3TgfVeHsxyqtR2bfIUTJOc
	 /VVu6KP3T/U0psF9IKjNSPdmSeywskjI6B7gS0cIvHuGIwyFL57vdpIPhKbQwya+LS
	 Aioc6jCBzK9Im4k3FMGi3S7NXpQPVGrKZpE7oVXC8NWDXtBxmQfBbb50fiZfYb292b
	 h3FJ/UdfEscFjKTcy2InAIRmeYhWuNjC89o5vgUck4+2xORrKRsznb6JxZZJxy26d8
	 SIV8x7BEklQcBxc18ZUdzceIgWyRKbszV9QG0tdTZfXozw9UwqxTw6o5wNpgfaQdI5
	 K8AjBWIbt0gSg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id CFF764099B;
	Fri, 16 Oct 2026 06:55:36 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 423D779D
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 06:55:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2876560AC0
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 06:55:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TD6NTz8YW8w1 for <u-boot@lists.u-boot-project.org>;
 Fri, 16 Oct 2026 06:55:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 8E8576087B
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.180.15
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792133729;
 b=DXY/xxEV/h+kmhiaxW5A+U1XnmOcpDjDNKPGA6L9bSZG9V1TGDU2z5eSJ7XZR9Qjt5ml
 H44DYyGTXxKgtDH2MC7GA3HDAM1Psq0dCs9AEUXjC8B/QLM5VCrtlczF4SXQc9NsmCw7i
 pgQMp9QCpKu4UyjfkTaAFp6VgWmuujqcoFvIFDcHFY6eyabzeUTIzN94K8BROv8XFBWk2
 tf38w9CQtFPYh3gx5NdB1WPRu2BxkUDVxxhOAuOxKIuKARWz8SZbt/tAMCqFnOHbKzOLk
 J6F0g6s1GuoQ4yhZs718xz6GOcOq5SLWluBDLU7pAHiByxzMt/L/4n65VJ8tA4uqPxg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792133729;
 h=Received-SPF:DKIM-Signature:Received:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-ZohoMailClient;
 bh=L5WWJleYDxdloeiXkMHJQojKZem/27SZgbldKjS+rtk=;
 b=M4RwCc9j/S2KzxfeTOufHP0BWQrGCAI/IV4PdqcqZvtbW3zhm2d57Hc6DXrKZOZzYA26
 ZKl9mDnyoMTxXqnJgvwrXKdosHAjTWRA98iY8OIP90K4iDCiVNFZ3+8AY4LyGMFF68zow
 uVZi9pUnRMQBYy5VSOmTcBmztZOhpRukK5/ANx054CAG8/jJ3/pXY9pb2iQaHSmn6Dr/C
 QjhCEfOEhbTvUGT8YiHH+8zXlyM4kxZUoXjT5kyXfv9KSjft7pdC0pZnrJlZH9TliIPdZ
 JXlxg5JVTtTQnNISys8+vQlP0FrfS+f/Bk/MUZAEGFY1mmn0/knx/ArGbiny6vo7kXQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=ziyao.cc;
 dkim=pass header.d=ziyao.cc header.i=me@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b=SbUWicS4; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.15
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.180.15;
 helo=sender6-op-o15.zoho.com; envelope-from=me@ziyao.cc; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=ziyao.cc header.i=me@ziyao.cc
 header.a=rsa-sha256 header.s=zmail header.b=SbUWicS4
Received: from sender6-op-o15.zoho.com (sender6-op-o15.zoho.com
 [165.173.180.15])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8E8576087B
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 06:55:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1792133723; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=NCIEmOb4U9Gm1f4dFT9cYGahmMyCNXb1nyk/5EdEhU5ZX+CxbAg2thCou8vsteTROqKs9P3fLu2kdwW8BvuJ7zDGg5KfKKayvkhNQ6LHF4xtBvlsFLQdy/jH4bwG/WURH9U1NOOllZGAxks8E7ncZVX3ffCRDRxRGGdXnisD63o=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1792133723;
 h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=L5WWJleYDxdloeiXkMHJQojKZem/27SZgbldKjS+rtk=; 
 b=H41w4xy3DCNnmB0WDUgfy6MH6ZaGiEL8LGucx3GkYZ2RmH2E2elbUbMrAIL+M8A2dN8MhJ+692ctTB4TOhDjZOU0MpLShhOFzUrhbUu6T+oW0vv4Fro1uly5HPG6K7ZV16oEI/8pOyk/YdSu+LoQVdWJkMMqpq3Qy/V4YESK9nY=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1792133723; 
 s=zmail; d=ziyao.cc; i=me@ziyao.cc;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=L5WWJleYDxdloeiXkMHJQojKZem/27SZgbldKjS+rtk=;
 b=SbUWicS4VjEsenzfgTC2Qn4k49PrJ0goemvnKg/iBKw9j7hLb9l0hxGh2c/OQVoK
 yHLETvyxgPU6syknglwlP9zIyTa6UJ7gFfzTx7YG0GuwHa6mDTptPk06c0Y1vJB/qd7
 q1t2c44rtK1eO58dWPTOvKZwDtfGe4wVcDOxAmJg=
Received: by smtp.zohomail.com with SMTPS id 1792133720542382.4805411652487;
 Thu, 15 Oct 2026 23:55:20 -0700 (PDT)
From: Yao Zi <me@ziyao.cc>
To: Tom Rini <trini@konsulko.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org, Yao Zi <me@ziyao.cc>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v5 04/20] elf: Define LoongArch bits
Date: Fri, 16 Oct 2026 06:54:44 +0000
Message-ID: <20261016065500.137544-5-me@ziyao.cc>
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

They all come from glibc's elf.h

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Signed-off-by: Yao Zi <me@ziyao.cc>
Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
Reviewed-by: Simon Glass <sjg@chromium.org>
---

Changed since v4
- Add back the accidentally-removed EM_NUM

No changes since v3

Changed from v2
- Collect tags
- Drop a redundant blank line between /* Version */ comment and
  EM_LOONGARCH definition

Changed from v1
- Re-title to "elf: Define LoongArch bits" (with the semicolon)
- No function changes involved
---
 include/elf.h | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/elf.h b/include/elf.h
index b88e6cf4032b..23157f5d6b4c 100644
--- a/include/elf.h
+++ b/include/elf.h
@@ -225,7 +225,8 @@ typedef struct {
 #define EM_MN10300	89		/* Matsushita MN10200 */
 #define EM_MN10200	90		/* Matsushita MN10200 */
 #define EM_PJ		91		/* picoJava */
-#define EM_NUM		92		/* number of machine types */
+#define EM_LOONGARCH	258		/* LoongArch */
+#define EM_NUM		259
 
 /* Version */
 #define EV_NONE		0		/* Invalid */
@@ -705,6 +706,12 @@ unsigned long elf_hash(const unsigned char *name);
 #define R_RISCV_64		2
 #define R_RISCV_RELATIVE	3
 
+/* LoongArch Relocations */
+#define R_LARCH_NONE				0
+#define R_LARCH_32				1
+#define R_LARCH_64				2
+#define R_LARCH_RELATIVE			3
+
 #ifndef __ASSEMBLY__
 unsigned long bootelf_exec(ulong (*entry)(int, char * const[]),
 			   int argc, char *const argv[]);
-- 
2.55.0


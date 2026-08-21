Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2C81C5DF7D
	for <u-boot@archiver.kernel.org>; Fri, 21 Aug 2026 08:43:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A49BC4092B;
	Fri, 21 Aug 2026 08:43:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dK2Ea5hD0LPb; Fri, 21 Aug 2026 08:43:32 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787301812;
	bh=WGtsud+NTB+RaFn52kiw+VU88dYOUWHg6wQ0Xy0+9To=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Tg9Eby6VZ/Y9SBFlwPMfAkXDDdJteAP1PEvsX1uvc6aeVrygolabhsKh77AbSnxpf
	 yFkOSKZIbLMBqjeRIp8gW2ffkhzmxhndzG7wlPc64qrESjZKzKIJ8PBE9brZoAZCTc
	 xZFvPNfxQnHtbt0pPjeERyyjmeQQ4qPiNXYS6Lx2VKQYvt/Fp32wIwOEwWjRrtHe+f
	 SdjiccGWHnkr+trtct8MzDAqoVocf6WfI14WqP/1JMNSs9Of8vUtwWOnqkcJdKQxnW
	 QWB2YckxQJ5AZ/ucyjvixjfk8KLQtrQH8af/T8SBp8HZ7EtZYRv5eBNG/QX2auFDZ2
	 S4+TWcADetkCA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4F08C4090E;
	Fri, 21 Aug 2026 08:43:32 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id CDCF6263
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 08:43:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B43B480FA9
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 08:43:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id f9Ua7Xap3tvD for <u-boot@lists.u-boot-project.org>;
 Fri, 21 Aug 2026 08:43:29 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=136.143.188.15;
 helo=sender4-op-o15.zoho.com; envelope-from=me@ziyao.cc; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=ziyao.cc header.i=me@ziyao.cc
 header.a=rsa-sha256 header.s=zmail header.b=W9q6dYjq
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com
 [136.143.188.15])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B7A2080F8B
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 08:43:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1787301801; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=F1uy+cTQc7RrGXhraRgukT62yKD3DwxbkDkz5HaEL2myA687PDuM1hZtrPkWMjRID82lP7kgAG4PyPdnGROwsjbYP+QDnvC9sD9/aKl836I+Kwny+D5cx1E50DZIssicP6Kcp1sB6eGAK/cgwIcHn8tZbUaHcCImt+mLrmId6So=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1787301801;
 h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=WGtsud+NTB+RaFn52kiw+VU88dYOUWHg6wQ0Xy0+9To=; 
 b=f0SZnm4fWa2uxwDahZJfxOzg4aDTyZrjRVPt0GcAPIxEsZ3Y7eI8sYHHFG61guhYl5Gx3dSLmzyJ6XX/80A4Op3jXT0mfSpjy9BZPrmJb2bC0BmiWFnwynU2Elgyg66NLLVNgBz1oOzHCE8nyfmCbSqec1NutUqC8fGf0tYzPLc=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1787301801; 
 s=zmail; d=ziyao.cc; i=me@ziyao.cc;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=WGtsud+NTB+RaFn52kiw+VU88dYOUWHg6wQ0Xy0+9To=;
 b=W9q6dYjqorbeSGkH7ZL0W5oghC6AluGE7LYUk8yum2NR8jKscEA4pySCjqs8+8fW
 uEH3xrKnlonokjUCGYTn+UcfXPoAQuoX8vylHxtQIeCV1PBNETiQr6Fpmk+fX1JYYV0
 zJeP+owYqmr4C66m8f3tig7bCvxhbH6702ECyybY=
Received: by mx.zohomail.com with SMTPS id 1787301799789459.5049361191568;
 Fri, 21 Aug 2026 01:43:19 -0700 (PDT)
From: Yao Zi <me@ziyao.cc>
To: Tom Rini <trini@konsulko.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org, Yao Zi <me@ziyao.cc>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 05/19] image: Define IH_ARCH_LOONGARCH
Date: Fri, 21 Aug 2026 08:42:05 +0000
Message-ID: <20260821084219.1703743-6-me@ziyao.cc>
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

From: Jiaxun Yang <jiaxun.yang@flygoat.com>

Allocate the next value to IH_ARCH_LOONGARCH.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Signed-off-by: Yao Zi <me@ziyao.cc>
Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
Reviewed-by: Simon Glass <sjg@chromium.org>
---

(No functional changes since v1)

 boot/image.c    | 1 +
 include/image.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/boot/image.c b/boot/image.c
index 185d52ba492f..fddbf01e04f2 100644
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
index 742e2b8cba7a..df19f60a4523 100644
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
2.55.0


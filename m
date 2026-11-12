Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63314606A881
	for <u-boot@archiver.kernel.org>; Thu, 12 Nov 2026 11:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=oan8+CZ+;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ziyao.cc header.i=@ziyao.cc header.a=rsa-sha256 header.s=zmail header.b=VSy5Or5I
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 40318607F7;
	Thu, 12 Nov 2026 11:59:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HRbE6Iymtqv4; Thu, 12 Nov 2026 11:59:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 95E9560B67
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794484796;
	b=HXjDDY6uujSy/G0UqAj6nwk1p/U8AM68bdSjcXVPs96QpFMUHscP3ak0aYDnX6sG6rwc
	 VVEriFo12hsLJiJa87Pt//y/7rU6udEVQNPYWdaSnl769/8AUE+BlZaV31ltKUIpccfV+
	 l6igvLz/k4Kcr8s00EaS+OIoF8hqfUrkVdhnAUb5NPffos2fQrH1STPJihxBrvYIDKKv+
	 LyzsvT8PtkAnP/lwJROW2qCI47gjfaj1qAuqU1gmNA632zy5q+N9e0B1uNNrRLRX+YuhL
	 xiV18s2AjV6tZMSqjauJdp/HkXq9GMtGw05Z+dLoZr+qXll+7G80LsJHHGIihVC11pA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794484796;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-ZohoMailClient:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=sbgF7+Pns7F77tVPpxMJ37RO9bTDAekap75eVx9+MzQ=;
	b=jRFoLgAjAN2Yt6cVhcGzwj+SxLY58yF1Xfh9vH1qsd6l0jiNHSmmFlZG/9zzmebCLsV0
	 IFrNQQpbUTKJOcYa4mOiFNFeMj9IQRysdohcsIwKXn0weJBVFZvwKXg7tiITki30vmzmw
	 36lkuXchokFaeZjDuy/OtIAbEcNotxLM1cZOvK0Rc6BQZZzjkGfYVuy+Qr9E+6mbK8FaF
	 vD4VYHK5S0x4wYM1NLjyg6P56kKZUoMIyRRBVG+EJlXzQTSmMNDnM6F3QUT/HNwRpqbsa
	 FWhvBtK7xlXIjS+CEbKWJnPesureM8l/lGhXMjKk6JaDIqUhrah9H8lUSnbj+ThuNLg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794484796;
	bh=sbgF7+Pns7F77tVPpxMJ37RO9bTDAekap75eVx9+MzQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oan8+CZ+tnnI7N7saFbNXG9uUWVizqBuwlV87z/z3tPicPg7XHg0hs//vjMR+fb8e
	 aDb6Oiiy87VvMpJwiQ0UfYQoOspEvRilGvjP30NMjTjHm2hjy/pNTMbpk88jO4hXlc
	 PFW12XHsaUCDhDwR0+3KzEZIeFrA2mJLUnjAgo8fgj7UuLI+bjHST+xbALNF6Rbgnr
	 LDzQnilRKwV76jFtWxvy9AMEisXlXzqVyuje2+W5cgHmzJ2uecd/fkXxl2gO6Bh0ir
	 jeKvKuUot+GzdAFz9cUfYELy2HdRvGSC5qEM7CxhEEcNYqb7kzRcBGmWyMHHO1fD3A
	 mxD9x2FtWIPwA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 95E9560B67;
	Thu, 12 Nov 2026 11:59:56 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 74E401A6
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 11:59:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7291A400B3
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 11:59:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NIzZgA_4oaIp for <u-boot@lists.u-boot-project.org>;
 Thu, 12 Nov 2026 11:59:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org C733440042
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.180.15
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.180.15;
 helo=sender6-op-o15.zoho.com; envelope-from=me@ziyao.cc; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=ziyao.cc header.i=@ziyao.cc
 header.a=rsa-sha256 header.s=zmail header.b=VSy5Or5I
Received: from sender6-op-o15.zoho.com (sender6-op-o15.zoho.com
 [165.173.180.15])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C733440042
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 11:59:54 +0000 (UTC)
DKIM-Signature: a=rsa-sha256;
 b=VSy5Or5IvWEbBdyTpEH0AE39y2NId2DhM1qk2UK2nToOVHgI1VdQ/pFyJv/vDGlVywaAV61QGJlNYK/b1T8WD6sFbBbSx7QnQ56UmTXrhqeYv+9L8zdDgmMfSc9jVutG0C4/zIrlEV3jE39RSgmjrY/ve21cbvxOhhkWfwBhsqc=;
 c=relaxed/relaxed; s=zmail; d=ziyao.cc; v=1;
 bh=sbgF7+Pns7F77tVPpxMJ37RO9bTDAekap75eVx9+MzQ=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1794484505679583.1849878225905;
 Thu, 12 Nov 2026 03:55:05 -0800 (PST)
From: Yao Zi <me@ziyao.cc>
To: Tom Rini <trini@konsulko.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org, Yao Zi <me@ziyao.cc>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v7 04/20] elf: Define LoongArch bits
Date: Thu, 12 Nov 2026 11:54:22 +0000
Message-ID: <20261112115438.1837663-5-me@ziyao.cc>
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

They all come from glibc's elf.h

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Signed-off-by: Yao Zi <me@ziyao.cc>
Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
Reviewed-by: Simon Glass <sjg@chromium.org>
---

No changes since v5

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
2.56.0


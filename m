Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB499C5DF7D
	for <u-boot@archiver.kernel.org>; Fri, 21 Aug 2026 08:42:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5160B810A1;
	Fri, 21 Aug 2026 08:42:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fPS9xySbsPtR; Fri, 21 Aug 2026 08:42:53 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787301773;
	bh=t7WR/WUxrU7LMScxW10tm0fezabc+TDxDSvWxGX5MzE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=X1Ruts2/9mUIflAJjIEk/6I+xgLijLcyAfSZF7mB/qFus2GZjAbY/WBJlDGpJmDHR
	 VSXkFIYLLIMGCBpn08n2VXtxEsolpZmXiOc/5Ft3JN5zbOzYUeVDlU6CvNRZ/5XYhl
	 COXd+/ZygMfbUbFpHqUPudXpOPphMukVuRx4v7Lim2e7xdJOOEtIk3vyM8EnAvDN29
	 SjpmWXzMct0nG+0b/4QV0x9DF5cd4pFtLVUVqMGFxmFrqQQwW96x+54Jk+2Yvpdkbk
	 ZhAP/qiDl7arbJLUVE4q397IpPDLWSGd3fJ+W5bCETMtomWbmsuQ3pxO5jmghbXjuU
	 uaS93dukFhodA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 295218101C;
	Fri, 21 Aug 2026 08:42:53 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 246C3263
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 08:42:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2255760661
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 08:42:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id H_o2ansohvPR for <u-boot@lists.u-boot-project.org>;
 Fri, 21 Aug 2026 08:42:50 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=136.143.188.15;
 helo=sender4-op-o15.zoho.com; envelope-from=me@ziyao.cc; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=ziyao.cc header.i=me@ziyao.cc
 header.a=rsa-sha256 header.s=zmail header.b=H0qiR8nB
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com
 [136.143.188.15])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 67C1C60662
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 08:42:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1787301759; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=L9qwjmpwPsWhzLU93FA1flEBQapgqcruEbnTFzjXnDeqMcEC3Z1PpYdyVmwG/o+t8y9AEEC80frnrt8rD04apcPoLGF34+h85v1yRb55ei0rCGYf3cE8ildRRK5InQqz9o+sBzr2iNkrsHzZLSKoqkijOHkhRc2CI6lTixKYQYA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1787301759;
 h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=t7WR/WUxrU7LMScxW10tm0fezabc+TDxDSvWxGX5MzE=; 
 b=c2zQYKxGKeHgQG73pFDc6r3MyZm17ETrgBy5uJ1AFU1x5lmxUwN+dWPExKJatPYTtQTpqKxjklb8C9EX2Pnbd5ydjJGOZVI31yu+BWYM4AylS9RrithG1xonHdor3kyxuaK2Lbm5ruj1IReBLUsGUcaj85+/ut9ZuQVMNtCgeJY=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1787301759; 
 s=zmail; d=ziyao.cc; i=me@ziyao.cc;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=t7WR/WUxrU7LMScxW10tm0fezabc+TDxDSvWxGX5MzE=;
 b=H0qiR8nBk/BaRRapnnLGrfQIqctilD018GRw6z5BsBzpFSutKhoV7EO25Txibrju
 vLVqW/lazDxWvFD51EXxRAyQf7YI7hsKmUZ4HrRmQzuSNIaQnGk1H8CsuZ29wwENmkP
 JHaTz94CBjSQb+32O02iaBJ54xpLvpwASorSqJe4=
Received: by mx.zohomail.com with SMTPS id 1787301757124631.7781623780454;
 Fri, 21 Aug 2026 01:42:37 -0700 (PDT)
From: Yao Zi <me@ziyao.cc>
To: Tom Rini <trini@konsulko.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org, Yao Zi <me@ziyao.cc>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 02/19] linux/io.h: Use map_physmem to implement ioremap
Date: Fri, 21 Aug 2026 08:42:02 +0000
Message-ID: <20260821084219.1703743-3-me@ziyao.cc>
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

Changed from v2
- Collect tags

No changes since v1

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


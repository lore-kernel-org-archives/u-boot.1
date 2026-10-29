Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4576606A31A
	for <u-boot@archiver.kernel.org>; Thu, 29 Oct 2026 05:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Fm9XHcbE;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=ziyao.cc header.i=@ziyao.cc header.a=rsa-sha256 header.s=zmail header.b=pdpe979s
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C21AE606BD;
	Thu, 29 Oct 2026 05:08:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cT4ymtihRs4i; Thu, 29 Oct 2026 05:08:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 02AB1606CA
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793250511;
	b=lt8BFrne4QKIGD19kSaEjjhXJ7YjhfHMF0z1K4HMglsfmVn2zsFEZt8C1YsNqGaqW4i3
	 KdXbvWvQmcCBHTcKZ6sdMPLZ7hMoA/907GzX+/R1/ZcfhsWYCnEe1lFcBQ54Xv9Tul+qC
	 N6LFkHHI01aT5ViUnDyXMx2pWz0W3qePnoN7mkgzVhpQlVG9I03JrvBLhLUsGdhRqIhr5
	 UBM4zr62rEPtsDeg8W1MZOcBbd4EnYPwoD0Ao2t260DDxtNBkvYXd3UTGVy6Zn4AkyY1j
	 7S3OjrvgqmtZ8DFLd4pZIorBz7GTETP1boxsVL103duVYbsciTjVWmqDTYMKUGMZ8+w==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793250511;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-ZohoMailClient:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=q6aSX6ONRm63NPz6iXzvq+27gKJ/JN79ri18cTmRWhA=;
	b=BmLQTwAlWvTBcXTriCfcnrnqHjm4GFTW881UTLtxFPPf6ItJig49JkjOvspuUDLn+2Is
	 T04i6YBJSOhXZfGQRTJvrA118qjW5rbe9n2bp/Eckba5JAHb0foHJNIiNmxoVxm6p/LQF
	 r6EVBa/YJfurnx02cA5AXTjpGSfUMLnVui9vSPgC/YhDWXCHJLc8M65dM/pYVziKW3k5/
	 ALXt5NEleTlirrHAM/4a12x0nyETjy/TS9CuP1h83TpIPaMGvmLkVqCfShDMw2CFgXOLe
	 EIMwOtidYL8PVvHXu+/A9F4jgekwQUzYqgpHCMNVtz+USL/wpAIyZEKu7yAB0d6bF+A==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	dmarc=pass header.from=ziyao.cc;
	dkim=pass header.d=ziyao.cc header.i=@ziyao.cc header.a=rsa-sha256 header.s=zmail header.b=pdpe979s;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793250511;
	bh=q6aSX6ONRm63NPz6iXzvq+27gKJ/JN79ri18cTmRWhA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Fm9XHcbE53bKx/xR73sddCxTlu00dDfxWtP49Iiny+aVWucE1aR69pUZSPey3gAXm
	 q3KDDCamzu7bG5MVU+EgTFybdzk2q51X3QShcfJAi/bYFoWB9B0urTtt+Iy+xYfuxo
	 /sOT9A5fcx1BEhBUuNoYIvOfPSR6iDmmNa3ZAcTr7g5NoPqcqLIVFXb4L0kA8+KoN8
	 gjjlGSouNuZRW460DnLJg/l0YqGF5GTguCWVVVaJxzWqNcrFPHAblXLv0cL4x+sbD9
	 5ymbk97UYnO+o6CfLQFn+omMMUjul7Jf9kEj9/8ACrClPstqY2sm1mumNDytFPpMDt
	 4eQpbkDOEQbdQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 02AB1606CA;
	Thu, 29 Oct 2026 05:08:31 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 7A72A235
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 05:08:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6C564606BD
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 05:08:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id a2kBsDqX9RYC for <u-boot@lists.u-boot-project.org>;
 Thu, 29 Oct 2026 05:08:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C78DB6069F
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.182.15
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793250503;
 b=YGuQ3jNhDmxXP0IlhV1+KtpRw7B8k0PpFDugIqop7leFEizsdUgA3y3QmQmUfOaoKzTX
 R6r1l5xj58uzEs4eztnF/83eaPQjaRwmsrkj7kSGvI9NzNIw+VBGzSjlrW5pMTzPFzEly
 iuv8haDgy/BcBCP/x+U5se0tgom7A5b0trkQ2FF6/y6ZbKz3btta/AJ/Nkkc4PT2gRG0K
 Wk3QYLsq3kscid7JuzT3PagNimWLr9VkhHEmgJWz+QAubmgzi5BzcT0G3Xa4zGD0m/wi0
 XfGSF3jG+6MYeWI/26vSacNTZdMpyJzYO9P0/oO6e4SqMyoRUFnu9vMQzyD4skMTjxA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793250503;
 h=Received-SPF:DKIM-Signature:Received:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-ZohoMailClient;
 bh=q6aSX6ONRm63NPz6iXzvq+27gKJ/JN79ri18cTmRWhA=;
 b=B9888LqCfsnPOhfEAgJRrpI0G0V6gKhC80kvRo11sE2lB7CzQ4ygWemNCBlgh5oCAK3I
 o54Y9CGtpWrEwAs8xA2zkdLPwEL7rADDFcPjguX+XhehiX3KN/kWteQXtvAVDwNWFkwol
 30dgKzL4LLn0R7PGVINyzQy5j0hZgnUAt2ZeodAUBUPj7g1bm+30BimUJoNiG4lUSuwVy
 oap33Xa9O8sNkZ2dnIyBRRHVm5TTNeojhEpDXIIaNa/TTLqANeaUEqYZdrOYnpiCj4tv9
 DqBWJXhwkb/wMcyfsUaELI8v3GOydDQ+IS9Na9BXN5KUIcpmUsQUVlVMfqHbqHsQ3tQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=ziyao.cc;
 dkim=pass header.d=ziyao.cc header.i=@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b=pdpe979s; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.15
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.182.15;
 helo=sender5-op-o15.zoho.com; envelope-from=me@ziyao.cc; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=ziyao.cc header.i=@ziyao.cc
 header.a=rsa-sha256 header.s=zmail header.b=pdpe979s
Received: from sender5-op-o15.zoho.com (sender5-op-o15.zoho.com
 [165.173.182.15])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C78DB6069F
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 05:08:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1793250495; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=XCx4tfWgWlwDpjiRFTSTh8M4GvQcpuLKJv8dEMQWkM2YJJ/pYgenVogqZI306xZgSSfsxp4vNShFLaN/o2koy9HOe6Tfknr5CbgVpuxZfHhixxhIlRWuDiWwK/IBSVqCHfRTzoPKYkoLcP90OjWSebwg37yxV8kA5dgpgOcGaGI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1793250495;
 h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=q6aSX6ONRm63NPz6iXzvq+27gKJ/JN79ri18cTmRWhA=; 
 b=iMX7VerRBcYJDjz3AUxgwoK3fX9uFeu5INQ4RCJgXzkFIa+PJj761RQ1gl9A0Bz0kttsjde3UNE5J/1rn/X0OZQT7S9w7Zgj8p8qWP8eW1qaH1wPFtFHiw3ndc+/skcnxrGO1Xi0pBYx5piH/L/UNagPkMJEzsd2VW+CfjMH/UU=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: a=rsa-sha256;
 b=pdpe979sr4L/MTFAQSqP8ZxVztDbVcX3PfpsybXTZTcpWgfbYTiMUt6pTIGOAWeQh+yoO2nd/HBUkOMtfQnfPm5qHwg7MdfUKtedV2k3YZeSWUbz9fglaktSyKFlQIzEKXQT3ajf9zyCWGmd3pAgoxxp/ixi/1ke+u7Mq+/PUfQ=;
 c=relaxed/relaxed; s=zmail; d=ziyao.cc; v=1;
 bh=q6aSX6ONRm63NPz6iXzvq+27gKJ/JN79ri18cTmRWhA=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 17932504939430.5434148971462491; 
 Wed, 28 Oct 2026 22:08:13 -0700 (PDT)
From: Yao Zi <me@ziyao.cc>
To: Tom Rini <trini@konsulko.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.u-boot-project.org
Cc: Yao Zi <me@ziyao.cc>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v6 02/20] linux/io.h: Use map_physmem to implement ioremap
Date: Thu, 29 Oct 2026 05:07:19 +0000
Message-ID: <20261029050738.1107663-3-me@ziyao.cc>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261029050738.1107663-1-me@ziyao.cc>
References: <20261029050738.1107663-1-me@ziyao.cc>
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


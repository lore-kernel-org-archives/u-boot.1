Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAD6EC624D3
	for <u-boot@archiver.kernel.org>; Fri,  4 Sep 2026 19:39:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C4E9460BA6;
	Fri,  4 Sep 2026 19:39:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SVJWaUfkpaxM; Fri,  4 Sep 2026 19:39:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org F395E60B86
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788550747;
	b=j5RkNvOhjAaFhb2jkc4obaOWhVOWcN9ttwmFmRpaYq4gJLLtRTeqb+QEdVLATl+sWGXv
	 CUDp84yOplhyuOIKzbpvPy9fdzAxAUBmW7DPaFnlCbzKm91oqsE93gCnxZ7sSJf3F1qhU
	 prrEJhTd8U1sAlaVtODN/+t975Iu6bMfG0zFayZmEmiTCkPCys8iKatPbx/6ExmhTvfiQ
	 Bq4aOcq5rN+7LUaJUSURIbYM1mCbj4fZKijT4qmKWKVY7gjU1lJtg0rISsw0aoFhphjfA
	 IQL3oqVH7qOGntPS1vr9K6zEwkZNMbJBISVqC0pyEXgMcTbRraptAjpG/ZiOcTXqYbw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788550747;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-ZohoMailClient:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=K3daQ0knocUGdtIDebQPqDv7NlneTqqc9iYEgtne8W0=;
	b=C4imcXQgNqCAnPYwAtlTC3wuRyIBol0zXBtKEM45b+CTjy/vhhLaE+Fi5ePXf/VaK8Lo
	 BMlyn68KdYiqGTf0sTAt6+7RJTbVbESP59QLcocR8T9cJekW6ZvebQq1XKBCF1d02cY20
	 ks1pyyCRwbIKkG3pbJEPxisXIBdSWhIGXiy3jetTKIA/a4zkYAUAisrVSC+uqPBO9eMSc
	 bvKz9in2WxaZMiuB9H7Av1lzIdh1yFlwkO5u2bojg6f5BXx/IQh48vavL0RJmce5Y6OS2
	 8/9kD40UXTkbzpLKfJiIBVM1Y3oYmjc+ADuQ8t/I4bdrbLhxClrM2z4CTTz99G0QD3w==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; dmarc=pass header.from=ziyao.cc;
	dkim=pass header.d=ziyao.cc header.i=me@ziyao.cc header.a=rsa-sha256 header.s=zmail header.b=F47+5ro2;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788550747;
	bh=K3daQ0knocUGdtIDebQPqDv7NlneTqqc9iYEgtne8W0=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=TAQMiOOU9D1qME+MJlMhtwArHepgkBc5jC1S/fiCBVZ6/XbJOJEcctB44gyUR/kGV
	 BnTJbM8XhzIx41B6bv+kgcRu8Taabue7NOvkAFioUuAqKuqcCMA9lbs3idyodskgfd
	 oSty9KC/N+iJpxj4sNVg4zdNEhivflCFnwbtvHOayCkBSyksuHIYopolJMi20I/YGk
	 hcpMpr0rduIAIJuJh5/dLmf/XxPVD/w/LE1qZX4Mh+RZTafcXuymsEq9bV01VvX/4y
	 fMai5v5nJ19GlRlnUakTfp1+KhSUhM2g856TsHMGmLanLYGBPJ+viycIm8d4tXgTRJ
	 IjfUbaeUKK0cg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id F395E60B86;
	Fri,  4 Sep 2026 19:39:06 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id ABB3D463
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 19:39:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9172160B86
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 19:39:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CxZWi1S3pxia for <u-boot@lists.u-boot-project.org>;
 Fri,  4 Sep 2026 19:39:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org C6E5560616
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=136.143.188.15
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788550745;
 b=AhMQJjhgdNUaliXvFZwsVcrqpdUMjsu9u4cBjuP7/+UcCpKtu29KVcXtOUdIiU2++qZf
 FfNzNAOQvLQIJVLor/Cya+qRHMP6XtkgM+j+e2OK5mePF4vOifmV/ODasYPUOZOLQIT30
 DbQiz6d9AKAqUs4BabetlPmBsr1ptLars8zSsrax0S2RDQ2E37NXTxBVWJPIx1STalRfc
 jd0Mrukr3q8QNqGcyHaCnbShhlkXpElPmIoEvqKs3iE3BOYkFpSyn+bllFKJV4NnIYrvA
 WwQr+5o60jKUeoD3HCQZmHeWxzBjZTUBVuLs7U6B/CSiZ320OZZW+VkMHLPQ9bx9Onw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788550745;
 h=Received-SPF:DKIM-Signature:Received:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
 X-ZohoMailClient;
 bh=K3daQ0knocUGdtIDebQPqDv7NlneTqqc9iYEgtne8W0=;
 b=PMXnyxCxaS1btpDyGhygg9/H0vt4pxuTRzgqIVPfxDYC8raocQK8QhTCNjO4SSmXIblR
 i1aTU1VAgul6u5BB6wKZg6lCY64hjUW+Q3jO9UH8B6+H0aX5E9bjYkj7fZHKP/MNbuD9a
 0HF5OxCnIaZziIe8LoQwXIccVaEEuUKrShOG+jGB3mEFR759Kuva6s53GioHJeZU8S181
 LPuIV8HyHHyfW3m97KT7voFj+JQgdOX7adwC3AxOLP6YEdGUfOGuSvrLxyLTGg2n0VW9O
 PuwVv5Y0OudO7lYycY0SJMs6hTLCP56X+wwDUK9gw4N/iV5tc53Jq/2cPGTCbMG3GDA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=ziyao.cc; 
 dkim=pass header.d=ziyao.cc header.i=me@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b=F47+5ro2; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.188.15
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=136.143.188.15;
 helo=sender4-op-o15.zoho.com; envelope-from=me@ziyao.cc; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=ziyao.cc header.i=me@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b=F47+5ro2
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com
 [136.143.188.15])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C6E5560616
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 19:39:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1788550728; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=C3Qcz2dh6ZqRYHzENdmGBYe/KOG3mXL2CkfJB8ihk53soqEHs3i4e/ve7+EnXRrx+1yHxCtpQhMiFrAqkgJHFPcdqjCwGsFWdXgZh8NZPF4iH1r5gI0ZDLaICs5qh6lt6tAHfFs7hrVX0Ek5J0lGs+JHW7opAiuspAoJMLS4Ruk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1788550728;
 h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=K3daQ0knocUGdtIDebQPqDv7NlneTqqc9iYEgtne8W0=; 
 b=gzv+oL+uAGL+IoaAvHEVvLdes+JrDONDLzHAW/7VQ12j1cwd4P7ftVtGGFSIN6YhN5Mp5NG5ICg01UScZmTpmfEqjxCdr58H4Dlq+/45bBLWbNYaLpdyWwg9OqmM64C6QmydZ4mJBInBhPGtEQWG2XvZcKIDX/HrrMW9he7XfWM=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1788550728; 
 s=zmail; d=ziyao.cc; i=me@ziyao.cc;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=K3daQ0knocUGdtIDebQPqDv7NlneTqqc9iYEgtne8W0=;
 b=F47+5ro2/UPS8+Nw7azTTBnL0fLro5kyBK0Sum40La8yxrQatuIkcomRHLjMoQzG
 XRIsTO9LkAO4Q4eXYK2XAsBAnR4FW4RECNmLqyGiJYi13l+KtByUnHubN4doqwX8RNB
 pUge8rm0v5MToSY0BeZVIPQ26I2/erKzODMywTK8=
Received: by mx.zohomail.com with SMTPS id 1788550726075814.9717324735154;
 Fri, 4 Sep 2026 12:38:46 -0700 (PDT)
From: Yao Zi <me@ziyao.cc>
To: Tom Rini <trini@konsulko.com>, Tim Ouyang <tim609@andestech.com>,
 Leo Liang <leo.liang@sifive.com>
Cc: u-boot@lists.u-boot-project.org,
	Yao Zi <me@ziyao.cc>
Subject: [PATCH] MAINTAINERS: Include riscv_timer.c in RISC-V entry
Date: Fri,  4 Sep 2026 19:35:18 +0000
Message-ID: <20260904193517.22312-2-me@ziyao.cc>
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

Maybe because it was added after introduction of RISC-V architecture,
the generic RISC-V S-Mode timer driver, riscv_timer.c, isn't included
in the RISC-V MAINTAINERS entry. Cover it with the RISC-V entry.

Signed-off-by: Yao Zi <me@ziyao.cc>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2b3a9ac1f2ae..ab8e611e4eb8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1518,6 +1518,7 @@ F:	doc/arch/riscv.rst
 F:	drivers/sysreset/sysreset_sbi.c
 F:	drivers/timer/andes_plmt_timer.c
 F:	drivers/timer/riscv_aclint_timer.c
+F:	drivers/timer/riscv_timer.c
 F:	tools/prelink-riscv.c
 
 RISC-V CANAAN KENDRYTE K210
-- 
2.55.0


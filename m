Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 456F0C982CC
	for <u-boot@archiver.kernel.org>; Sat, 19 Sep 2026 04:40:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D6ACC40BC4;
	Sat, 19 Sep 2026 04:40:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uoEb7NO0izca; Sat, 19 Sep 2026 04:40:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 833DD40B47
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789792842;
	b=OhTGgYiFh6c0IYHswytQdGZxkGqFE32hVohasrdo4FrczU5BrD/NPptg8vZKRV/rIBp8
	 qTf+KN3AepHEjXbBpd8U0y9Jv54NybD6BOm2bAYqf/QiZqtNlXkIP9JIApO27x36BRe6O
	 FKXjypa8QZ9RVlD+qQMA47ly7n3FO9TNexNlA3vvxxXVIChDTAyMQsTlyEk54Hdzovni5
	 T+sdVQ/gz0ECqzkhn3eGGwALpzgmkC0FYEtT2XfXGOo79NwGDgMbtMtiIWmuHcJGkq4eR
	 ap84I7AkPHV9s63lqHB/P2VMIYScGX4C8t7oMJuuWa2p0t8erOp3dzLDHUfMr3CnJlg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789792842;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:From:
	 Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-CM-TRANSID:
	 X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=C3aUuAl3JIR0loVaBLgr9h5Iqret+wgiadUfF8Dd384=;
	b=ORPlbLh/K1qa59s4FlMSlgOtkvy95oxIf12YMk/Cc51PmPv7/y26XT8bARj3ml5+WSxb
	 Fu+PuLZA5/zOoVIpUMhs7OP5rPW1oNG3q6m/KBYswG/OqiqbcMmn52d9lokR2SvupGv/J
	 fHilNfW4k1PRLijDDecrPG7UHqrktTWW/+8ywSqeHU8bAMf4Jpp84iLjHFGsq+5oz7WdN
	 mt/iqeGGWpN/IJHf6OIXRVE+4AznkLfy1+krALeQw+aL+PGD4qofQk33r8cZzQf4N7GxF
	 xPUhe7Cdt+v7016AP4YKim3GevIph8hTEILJdNzaWU54rdZLCWMIUHmGicUK2eQygHg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=none header.from=iscas.ac.cn;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789792842;
	bh=C3aUuAl3JIR0loVaBLgr9h5Iqret+wgiadUfF8Dd384=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=CmFuaP2iTHeVHLAnY/bqH9e156UAtHF7fq7TxGDGT531YqiMCRqKOL+kjn2KHs+eP
	 igHkF12tvOJc5xwapcc7Pt4PQs57M+MVz3Bakw39ZwyEWszwMlVfe2gVeL9UKnVZ2w
	 JRkP7ffF9vj7sZljTN8GOTyTnR1c+9GP1tuOl0Cm8mqdmHD1CZ0eVHOhBoB7oaeAPV
	 +TtW+odhBe3hipvk7UhUczSjOUBLFbshtU78Yb+/FaLYgDC2Le/bT3Gfq1hyybCP0g
	 yr1spCeyAhMrkRoxhbZwnP6QI31E78p/8qGKqAj26QenI7eh4KvH0NdZhDTc0FChUo
	 +ETSvQycj8IFg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 833DD40B47;
	Sat, 19 Sep 2026 04:40:42 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id E547F362
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 20:37:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CB19640CF0
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 20:37:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ztqkf-kqGYAW for <u-boot@lists.u-boot-project.org>;
 Fri, 18 Sep 2026 20:37:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org C530740CE4
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=159.226.251.81
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789763833;
 b=j85DZeo3BaUJR1+WGfPqRphHGVTGLicEhMaFi1yycxkOsidT0tkCI0SCemPUNW23iYm1
 U3wy4P7VGz1kEgmdy9DXFyHBe6OJJaBGAhSPF68WPws6Wyuq+YNCz3F4fJAO47tCB//SM
 HEcUFu74SKkdLf3xQr6aIiDzqFLFeO8hZ78P7ry4ZjvY+BBo2a8n2Ejep40McQq3aKJji
 Z/E7/2U//Z9oQStr2iA+x7NDnf+Zlnzd3K3dQWBlcjzqt7RRVjA+n5ys43SgzKCGQwSWN
 J6d773h8RgL7ioyILlQuijHNnZlf2p+8t/OApqDLs/hxywyBB2iJg9c2PWXtDptdNwQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789763833;
 h=Received-SPF:Received:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
 X-Mailer:X-CM-TRANSID:X-Coremail-Antispam:X-Originating-IP:
 X-CM-SenderInfo;
 bh=C3aUuAl3JIR0loVaBLgr9h5Iqret+wgiadUfF8Dd384=;
 b=T/g8yWOOkKMN9DKStEsarRvPckdjuECb4s4lkEZMjjiBkFEDlX8+ZD3vqG2H7ADnjzqr
 RARpVm73qr9Vn/lDU3hndP7mgZrnldoGH0OiWE41PfOy7bHCZ58SFDbsPekPqFeyBH64+
 O79aMNxTom4gG+F81zgXEw7t8xk2+y9HtiUr3j/6fFbKS5KF30YrV56hbbQukrm/v1XxE
 KTkitt6zazEWshWHRdv5M2x366vOtjZnWfM1u6lYGY7WqwATgL3BBC6HpYUzkZQZJl9wn
 PLhKqUg9G+yj0N36pXYLMN7qD/4KPtyoWBQWU7lfuGD1Hn8HhYNQZaN3JyQ1Z7UEk2A==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=none header.from=iscas.ac.cn; 
 arc=none smtp.remote-ip=159.226.251.81
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=159.226.251.81;
 helo=cstnet.cn; envelope-from=gaohan@iscas.ac.cn; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C530740CE4
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 20:37:11 +0000 (UTC)
Received: from [127.0.1.1] (unknown [223.166.93.127])
 by APP-03 (Coremail) with SMTP id rQCowAAnKTc7n61qyLwRCA--.13452S2;
 Sat, 19 Sep 2026 04:29:49 +0800 (CST)
From: Han Gao <gaohan@iscas.ac.cn>
Date: Sat, 19 Sep 2026 04:29:41 +0800
Subject: [PATCH] riscv: thead: fix D-cache flushing
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260919-fixcmo-v1-1-0a9db1d0fa61@iscas.ac.cn>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMSwqAIBAG4KvErBNUSqirRIsax5qgB1oRSHfPa
 vnxPyIE8kwB6iyCp5MDr0uCyjPAsVsGEmyTQUttZKUq4fjCeRXoSiNN4RCtgVTePKXkO2ra3+H
 oJ8L9XcN9P4evZ/dqAAAA
X-Change-ID: 20260919-fixcmo-cf56064fccd6
To: Yao Zi <me@ziyao.cc>, u-boot@lists.u-boot-project.org
Cc: Tim Ouyang <tim609@andestech.com>, Leo Liang <leo.liang@sifive.com>, 
 Tom Rini <trini@konsulko.com>, Han Gao <rabenda.cn@gmail.com>, 
 Han Gao <gaohan@iscas.ac.cn>
X-Mailer: b4 0.16.0
X-CM-TRANSID: rQCowAAnKTc7n61qyLwRCA--.13452S2
X-Coremail-Antispam: 1UD129KBjvdXoWrZw1DGryxuF45AFWkCrW7Jwb_yoWDJrbEgw
 1fGaykWrWfK3ykXanxWrZYkF93A3WrGrZrAr12vr45Gwn0qr45Xa92y345JF98u3yYkrWf
 u392qFWfGrnI9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUIcSsGvfJTRUUUb4kFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
 6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
 A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
 Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxVW8Jr
 0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
 6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr
 0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v2
 6r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrV
 AFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCI
 c40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267
 AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_
 Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjfUYCJmUU
 UUU
X-Originating-IP: [223.166.93.127]
X-CM-SenderInfo: xjdrxt3q6l2u1dvotugofq/1tbiBgEODGqtRU+oDgAAsu
X-Mailman-Approved-At: Sat, 19 Sep 2026 04:40:40 +0000
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

Use CIPA instead of CPA to clean and invalidate cache lines. This
fixes stale DMA descriptors breaking USB enumeration on TH1520.

Signed-off-by: Han Gao <gaohan@iscas.ac.cn>
---
 arch/riscv/lib/thead_cmo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/lib/thead_cmo.c b/arch/riscv/lib/thead_cmo.c
index b8051e29e02b..763ff799eddd 100644
--- a/arch/riscv/lib/thead_cmo.c
+++ b/arch/riscv/lib/thead_cmo.c
@@ -40,6 +40,6 @@ void flush_dcache_range(unsigned long start, unsigned long end)
 {
 	register unsigned long i asm("a0") = start & ~(CONFIG_SYS_CACHELINE_SIZE - 1);
 	for (; i < end; i += CONFIG_SYS_CACHELINE_SIZE)
-		__asm__ __volatile__(DCACHE_CPA_A0);
+		__asm__ __volatile__(DCACHE_CIPA_A0);
 	__asm__ __volatile__(SYNC_S);
 }

---
base-commit: 211de43d0f954a00a490220c1aac9db298287c40
change-id: 20260919-fixcmo-cf56064fccd6

Best regards,
--  
Han Gao <gaohan@iscas.ac.cn>


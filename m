Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93087CA5FCE
	for <u-boot@archiver.kernel.org>; Mon,  5 Oct 2026 05:12:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4DC904069B;
	Mon,  5 Oct 2026 05:12:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZlxP-D7EeyyL; Mon,  5 Oct 2026 05:12:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 966C840695
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791177162;
	b=sWFOyFL+KfYUoWa+ioI3J4+Ju7YxqZgGLtR+Zu+ksI+RyrwGm7F8UBaI6Hrmm/wbAkjV
	 nF0++1DHM24mNWE4aq2fwTXSR40mrtw1lwZRBzEHn7O8Rp1U8kJcUk/e1rUMSgOfl5uVR
	 id9oIk9nMwVtIAGzxYIjRzbYcyWTsXKFuAb/lT33udu63QKTaYct59e5SHlCxzblKPKQB
	 euQ2nxbYRvUk3OYCMubXKcwhQHQNhLFsgzH5gzsxBkL0hel4gJDIAoY95d4WkixiwElMn
	 +fEtL2Cr/tHzZkqZjNTKhW/tvQ/ECnEMxUe/3/0/YWtRwdxoX5htbSV5CdPY4tItkmQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791177162;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=SGkEhfkpfC0rSQTLu3m5TMOTVOcg5qGVmGKsOOhnV54=;
	b=JvmvN3YhSvhurFRNUR9kqeXBE1RCR+9TkkkhMSNUcVyOFfsZQbwppQ28liBc92JwR7TO
	 0D96+pghvGNDWubUxJAFsEZClVopn4o2gHGIe89FBreSLYHftvCa6VCCgO4ghSn9u88a2
	 /dNMzswflnE3x4Za/eMKI8ZT0ThlTiPNkyqFcEJoi71bNUTaDLkYxlZRH3MkJLC3mO6qC
	 r2N1AAj2F6iu40GyTEyKR6XeX/m+aieWkSdTxG93zIehb4CqK+nMEVDkSVKnWY6xAlHJ5
	 +aMbUPnKXNibrTcRbM/L7Jzg3QUdLQHsK3JgpOvvjzzJI2wGPBe/pSMFPxygcYux9Ug==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791177162;
	bh=SGkEhfkpfC0rSQTLu3m5TMOTVOcg5qGVmGKsOOhnV54=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bmLHci+/DtwIT8vZ2wEuk1O5wG09tqwekMUGfvuaVX9J4CkL0ucv91urF8UphJ6q2
	 OOomnpnxPV2oFSFOfKVcen7ZqZh/gSSuRi4me9ioK6qf6zrRn1iSZZJB27f2goEFSd
	 sDdPRK5guyh+rwwTXDQbJaPoglGjD8DizT2175uAGNtYlrxFD6Icx29X/wt9edIrYG
	 +6IhkANyc7vXCU2pdCDV3iWzbGFoK/sa/GcUuN0GlXOWafRV4LUVVle6yRx1wrHP6u
	 vum+W2d2zr2NZeJ/VIOFP1fWbMh819PAQadvx7l0rX+8AyqO29z1NVsT918iHh8k9H
	 3NaCufOmQTryw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 966C840695;
	Mon,  5 Oct 2026 05:12:42 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id E95A9335
 for <u-boot@lists.u-boot-project.org>; Sun,  4 Oct 2026 15:27:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CF87D6060C
 for <u-boot@lists.u-boot-project.org>; Sun,  4 Oct 2026 15:27:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZKDezwyV6Fdy for <u-boot@lists.u-boot-project.org>;
 Sun,  4 Oct 2026 15:27:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 6168460604
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=220.197.31.4
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791127654;
 b=mg4qZLldwEbbWMHdIYP5/2C3/wwzJkcKVOIFKsE/6cXIb+y4LMVNvPNWxoRoDioFPHVO
 L9CQBIO/QfO8B7EaPDMuDcd/Peqd+hUIVwpjSUd4VwT45JTVQveu01q75BnkQvsXtk4ar
 MR+KsE+tPx1tbzTYRvilXcFbHOXmk+ElIYgdHCGD5wR28OyVgnn3LZtBWaWYWy55lCeCV
 EqI1ivYy0RZbA7T7LWEmtcAAMDCYkxpK5e5LM5T6OKsmEltSOSCPbBj0i3t4qkOY/b2ks
 b3eo5RvZVuOTjblW5xMuWRbWkye94t7Akm8pFhnegeAkYTcY927aL55sxyfOlzor3/g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791127654;
 h=Received-SPF:DKIM-Signature:Received:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
 X-CM-SenderInfo;
 bh=SGkEhfkpfC0rSQTLu3m5TMOTVOcg5qGVmGKsOOhnV54=;
 b=sowq139v3NhrrjHs0QIF7jbKzmLIsHcIuNH/v+A3O/eZWIqhe1rxuXpe0Dvk06Hk6+sq
 V+EK2ipaRKZoyT3gpfhnBTmB3jRAL6wlqMzMhX4d8WkKTjLsGonmgsb+urRufrQ9kIuJW
 RoId4u+RswtwIx/YSi9TCBMviVBh0ClT++9jn0FAvCfcxnA0N5rgvCrFGF9jut9ffp6yE
 PMdMsPAiL+m3hcGyYXIgvh2KzXHnZ7R9240MokY4BFs13SKgH9/KVdvjrLSBJW95FrRDT
 7T6fKzHoiWaUwm3MkZfuB6nrNUgQOmszXl+4fMRQds+FKxlSq67CdVUv9dPqcNyFvgA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=163.com; 
 dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256
 header.s=s110527 header.b=mNdfo59A; 
 arc=none smtp.remote-ip=220.197.31.4
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=220.197.31.4;
 helo=m16.mail.163.com; envelope-from=18102059357@163.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=163.com header.i=@163.com
 header.a=rsa-sha256 header.s=s110527 header.b=mNdfo59A
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6168460604
 for <u-boot@lists.u-boot-project.org>; Sun,  4 Oct 2026 15:27:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=SG
 kEhfkpfC0rSQTLu3m5TMOTVOcg5qGVmGKsOOhnV54=; b=mNdfo59AWBXqxLe9a7
 C8zE840xiLJDso4R0tWKcAl4OcYJfOGg2kAsmMd1y6Ils9DSN5EfqY2c9dHwYD1t
 C2t/51PXvMmTPF/e7bRq5dhVSmq54e/dLtNchlsXvD5G4h9LB5X49UwUXWNCk4st
 azP5XOOtmt7adfdiahJeowiUo=
Received: from localhost.localdomain (unknown [])
 by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id
 _____wDXf95TcMJqQD0ECQ--.17534S7; 
 Sun, 04 Oct 2026 23:27:20 +0800 (CST)
From: Xiaoyi Suo <18102059357@163.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
	Xiaoyi Suo <18102059357@163.com>
Subject: [PATCH v3 5/5] lib: sm3: use memzero_explicit() for the message
 schedule
Date: Sun,  4 Oct 2026 23:27:14 +0800
Message-ID: <20261004152715.1574-6-18102059357@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261004152715.1574-1-18102059357@163.com>
References: <20261004152715.1574-1-18102059357@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wDXf95TcMJqQD0ECQ--.17534S7
X-Coremail-Antispam: 1Uf129KBjvdXoW7GF47Jr1fGr1fGFWxWF45Wrg_yoWDKFg_u3
 WvyrW8GrWDKF93AF1fZFsYqFyqkay7Ar1Sg343Xr1S9ry7Xws8Zr1kW3s7Z3yrKr13AFZx
 u3srursFkw15WjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRt9NVPUUUUU==
X-CM-SenderInfo: jpryiiysqvmjivx6il2tof0z/xtbC7hh9GGrCcFhz2wAA37
X-Mailman-Approved-At: Mon, 05 Oct 2026 05:12:03 +0000
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

sm3_update() and sm3_final() clear W in the block where it dies, so both
clears go away from -O1 up. One of them is the clear the "Zeroize
sensitive information." comment is about.

sm3_final() also clears the caller's context in the same block. That
store survives today, so leave it as it is.

Cc: Tom Rini <trini@konsulko.com>
Signed-off-by: Xiaoyi Suo <18102059357@163.com>
---
 lib/sm3.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/sm3.c b/lib/sm3.c
index 058800997..4564cdb2a 100644
--- a/lib/sm3.c
+++ b/lib/sm3.c
@@ -230,7 +230,7 @@ void sm3_update(struct sm3_context *sctx, const uint8_t *input, size_t ilen)
 			input += blocks * SM3_BLOCK_SIZE;
 		}
 
-		memset(W, 0, sizeof(W));
+		memzero_explicit(W, sizeof(W));
 
 		partial = 0;
 	}
@@ -263,7 +263,7 @@ void sm3_final(struct sm3_context *sctx, uint8_t output[SM3_DIGEST_SIZE])
 		put_unaligned_be32(sctx->state[i], digest++);
 
 	/* Zeroize sensitive information. */
-	memset(W, 0, sizeof(W));
+	memzero_explicit(W, sizeof(W));
 	memset(sctx, 0, sizeof(*sctx));
 }
 
-- 
2.43.0


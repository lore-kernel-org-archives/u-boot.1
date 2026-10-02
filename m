Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15374CA5FD4
	for <u-boot@archiver.kernel.org>; Fri,  2 Oct 2026 16:47:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BF39660BBB;
	Fri,  2 Oct 2026 16:47:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4YCbOXXD7Fe8; Fri,  2 Oct 2026 16:47:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 9CC2F60612
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790959639;
	b=RLIKQn/wo86VOjO229B41SqcYDkU84jMWO0UB9SmCE5R+SzecUgbTxxx9oR4oOQS4B/t
	 KyxS49b5DBs1cIwHjvVdCTXoaSVQInvTHWEtP8/SOoiEZpP0cNineCXurilVbbzI7Yh8P
	 leBj1mBhwOpvc9zEFqnjCNRH0DRi00jdKLbFd2OH/IS1dIKpkmNRZMiV0j1Kx18oDbPex
	 rHk6wE6rdC/l1qgwRambs1WMJ4pllNiNB/sQZnLngpOABYA772fRwNN14lein9x31e2By
	 PXF73mmPJMSveZquqp7qDWHALQkTlbJFyot0g/RwYZOjiUxcgaTxu84In8Z76ETZcoQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790959639;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=7q9sFEOgDjSpeWWVlMILP5a38KGseUt2SVP/omK/1Ys=;
	b=S15z3aRo8mzirRtlG3FdMcaQ72rsteFNMfP2OM1BfsDlYAW9mUiHHrBTDNc2mI5zpnys
	 RfSZbN+rskgGoEeCCbdwdtnfj0Gxsg5No8tvhT168Tv3W3JD1Gy5OXD4DbdyLKeJ7MHOY
	 lMCqBGYqR512zzXXnYUDx0lpag9gobONcV+JyP+MeGrFgG3FGSBB4Cmbps6Es6vhxCEpp
	 qxy1ivU5+UdAi1sRbobc9YN9DSpBxjRu2z31bIB7j3WLesv8xJPXPM0SWEmQdZBrs0yKz
	 Hl3pKeiy+3XTawsdGmRghYYtf/apTr+S4EwSmc0cX8BWatWeEKLEO4gqrgA1pnDG46g==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=mDzj3hgv;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790959639;
	bh=7q9sFEOgDjSpeWWVlMILP5a38KGseUt2SVP/omK/1Ys=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zgzll0H6vjGnNEApgOkjoISFws5kdl3FD0xKEnsFp90iQAxetjk6c8lAmhIZt3Og3
	 KURJiLoDWMJicmXnEbwjYbJQ1w/aRQVwF0UhTyZrXOC+xXHK/oJWbyHqIK/AHFD9oV
	 LbSggHiY+aVVG/A6s2q/mMgRWhwGlIKt0pDCCEoN2eCwVhmrs2wM06H0S3BEsog9zs
	 EqRFNNBlwIWYu+FDIm3O2sp2yfHGt7veURKDh+cE95Q3lvre4qHoYVPXzE2CKKwtkW
	 3tFqWM/5tzRjfJuqmqpMm2TS4cv9Cb0/mZIlfilFx1i16PIErdxWIKno07X/kHfb5m
	 WmG3Z/h15pdzA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9CC2F60612;
	Fri,  2 Oct 2026 16:47:19 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 435E134D
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 16:18:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3522760708
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 16:18:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mXSaUilfJ_K8 for <u-boot@lists.u-boot-project.org>;
 Fri,  2 Oct 2026 16:18:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org A39AE6065F
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=117.135.210.2
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790957926;
 b=Y94tZ9PfI9j6bW1njCayN+VD+J/FfvxIYkOyPfKivFYtyG2X518ucN0Yonu7E4V6tXO7
 Gvy29bEUwGtts8UxQbtFKdGGBywhaFZu7oCvAwmpC+kf6XakOKQ8qpXo19jL2y4eDe/6c
 n2jb53ae0XpZeRUA8zSdDh+v1XgLJgdgLPjESiBunv8qRLFU+svvJwDKhlgdfZbxcj1qG
 +rhRyRqvEBjvhx8BNw8RSWe4JDXnVAY96hGmsrYKq4wVifHmPPA39gAd5g6JnkZuKLfCO
 jYDTHF8NeHFWuKLt51n2I608nd8CofKFtP3WiezSKyJMDpSNBm7DCoZT/3WWzEH4bSA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790957926;
 h=Received-SPF:DKIM-Signature:Received:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
 X-CM-SenderInfo;
 bh=7q9sFEOgDjSpeWWVlMILP5a38KGseUt2SVP/omK/1Ys=;
 b=gPQV33FQxnbeaswIviaj4pW+ClanaSbh+NdQ7FfO//63IRhMRaHAORry2vHpfTlefg0J
 OchcAZsUnRYA45XjL+R0yGdKnTIWxk71IkEN1WuOyM57FYlhYWOUKEbu9/AlNtVznoQkz
 cUJcMa2ZfNRduNVmhqHcyF0NrbnmKwY0PRIIZE4ToEBUCJxe5GlHsRZ8bugd4aG2O4QdU
 ZI49b5QdlB3tNoEa5fdfLPxT1ygGNtcRJSKqb4GvK10lfzJViSoKeAo1wgbCXmrAQ7V67
 PfwnnM+e+Yb1S9aLFrW0M5Uf2QpC/XZpQf9m0q9CR5w2FTjmRq6dQ9iK/KQHLGjMHow==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=163.com; 
 dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256
 header.s=s110527 header.b=mDzj3hgv; 
 arc=none smtp.remote-ip=117.135.210.2
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=117.135.210.2;
 helo=m16.mail.163.com; envelope-from=18102059357@163.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=163.com header.i=@163.com
 header.a=rsa-sha256 header.s=s110527 header.b=mDzj3hgv
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A39AE6065F
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 16:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=7q
 9sFEOgDjSpeWWVlMILP5a38KGseUt2SVP/omK/1Ys=; b=mDzj3hgvYmGqNnudk1
 XkTZwHj5aem/nvL3Snxbnn1rBNwha1WZlWiYoYLOcFNgUIzEzt529R1PvXVrQtYW
 0d/TqORT7ydu1Ye8xlMnYxAuwbN2C/C4M3SBVuqj/K10VXVBkxKT0ZFNklf/jCo7
 WlKdsa/2BZU7TlAveb/lUpuZQ=
Received: from localhost.localdomain (unknown [])
 by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id
 _____wDXvWbI2L9qGvUkCA--.16429S4; 
 Sat, 03 Oct 2026 00:16:09 +0800 (CST)
From: Xiaoyi Suo <18102059357@163.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
	Xiaoyi Suo <18102059357@163.com>
Subject: [PATCH v2 2/2] lib: use memzero_explicit() for the SM3 message
 schedule
Date: Sat,  3 Oct 2026 00:16:07 +0800
Message-ID: <20261002161607.688-3-18102059357@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261002161607.688-1-18102059357@163.com>
References: <20261002161607.688-1-18102059357@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wDXvWbI2L9qGvUkCA--.16429S4
X-Coremail-Antispam: 1Uf129KBjvdXoW7Gr1UZryfArW5Zw1UWry5CFg_yoWkCrX_uF
 1vyry8GrWDKF93ZF13AFsYqFyqka17Ar1Sgw1aqry29348uws8Zrn7Ww1kZ3yFkr13ZFZr
 Cr9rursFkw1agjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRWv3b7UUUUU==
X-CM-SenderInfo: jpryiiysqvmjivx6il2tof0z/xtbC7QryjWq-2Mpc+wAA34
X-Mailman-Approved-At: Fri, 02 Oct 2026 16:47:13 +0000
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

sm3_update() and sm3_final() clear the message schedule with memset() in
the block where it dies, so the compiler removes both clears, including
the one under the "Zeroize sensitive information." comment. Use
memzero_explicit() for them.

sm3_final() also clears the caller's context in the same block; that store
survives today and is left alone here.

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


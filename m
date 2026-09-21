Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F6EEC982E6
	for <u-boot@archiver.kernel.org>; Mon, 21 Sep 2026 23:08:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 72C3C60635;
	Mon, 21 Sep 2026 23:08:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kgL0thZOJB_R; Mon, 21 Sep 2026 23:08:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 6F7B4606E2
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790032088;
	b=ZonWKo+gpGALk+ZYwIKBzd7fsc4uP6E0sHszb55j7wuK7nfJ+y1rSAMvX7VKz7ta/mCG
	 LSWQb+eBp6WDIlJT8gvtCT8BdFeofu70OfltguUgALAXPEmhGWfMt4l3wpVmfAzgRG1dY
	 V1BrHesSwiXARDs3tNJA/NiTaFwrkGVsdnxvP23f1Q6xaQ1ws1bUaK1rlsSet/IuleTO2
	 df6EIXo/Bm4nCa5YTnHzqQKGj+hbNaFHX2bOUABOpwMRW+yqz6ytXqHFpZoWj9duDmYDy
	 JfFGRNKZngp/b5w4c8VKkmfrVTt/ZADEnI1z1u7BoIoRR6NrN1Wg1RSzjyZvP6mwc0Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790032088;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=JBt3km+oq8rxHOrYJGJBVULkS9OsfhLcNIEugKmJnEs=;
	b=CDJfLns+BkeeeCteOuSttKK1n7RdsZsL/A8Fu3xnJa85mYURpx00TkGZnsyWpMUIJ5qc
	 W4Bqz2thvpq2tDYPyhRsA9KDE49ATaRrG93bWtpTlqYBpUHTDsjtZXbZli/991kXJDx7l
	 nMY8pG6IUEIH3AObR6pnj+omvqyh0cFDxT2WIVg5/3fP1lWPGCRX8NlvQquvNOyoXx4/z
	 Fu9ZBPyIVp0oGee/7gIWlk5GlkvRdKm3wiHJSyCFPdzl1AdcvnMaGp4ZagI52tVUtSqkF
	 Kj4PXsDowE88jUL/fViyaNDxI5JSUBnYcI8APIBK98VrKxUOqHPO/mFDWISCXkPR3gQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790032088;
	bh=JBt3km+oq8rxHOrYJGJBVULkS9OsfhLcNIEugKmJnEs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CQC4Y3HxvJ1sWRmw+3nlmt7kX+3XkaXladkWWUP1bczakYU/3YfunSsXdvlb5bMRr
	 sRmeZ5F6ti8Qhv2cp9vJgFtusWFhX8+6K1dCXVXgDqCdd2Dz/S6ziu9Muu/S/hT9v8
	 a7swh1aoI6CBde1bHMH7Dbe2iKtKZsbIoiFHz9RpPd9LtISM+Fi5vrI/gHWaruLguv
	 mmC4EW8qywIHRNaU1X3hOh7XI81MN1NlK18YX1ioSX8ZqD1yI+RNxa/c2D1XUtKdtG
	 3NeGeNnuaHFddWCY9Nknmbr+Eu9SxVv1w5wPwNjhlM/86YQAh9WK2sKBNnd5MJje/t
	 sFMy2GvTi2xJw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6F7B4606E2;
	Mon, 21 Sep 2026 23:08:08 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 658C6522
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 15:15:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4813A40A26
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 15:15:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rG3XSneq7j-E for <u-boot@lists.u-boot-project.org>;
 Mon, 21 Sep 2026 15:15:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org C100040685
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=117.135.210.5
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790003747;
 b=VCtzFCs7kDujhbxDFKbmunhj/DlP6VsVFEck5cA0zn3mUNHw1wFTxMqH4Be/9YWtTp+q
 Pc3DVGW/bszomN18UOekrBMvthQTCvHDjKJzPHO84glY2E4neRg10YlsXz+O/9X+fbXkq
 L8NbTh7nlVMpneHjeEL3WEEhgw1aPXiBzf9z4Jx9prSpeLShY9TnBv3tL7+kmi8poF3RB
 PC2oMvIf4mCHEufFDj1gZIIQwmn1Ff4IuZRR9H1fGtDhpRD3URCE0tOn01AOoc9atAkaH
 aqOMZxDpIQSf+THH+GkMdEtalpNAZrOShPoN9zXbb+jd5oafhro7+sjNiVjDYFwP9RQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790003747;
 h=X-Greylist:Received-SPF:DKIM-Signature:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
 X-CM-SenderInfo;
 bh=JBt3km+oq8rxHOrYJGJBVULkS9OsfhLcNIEugKmJnEs=;
 b=Z+eVUkejZWiYtkhdWgE5GmLDTafNJjR9C9mes2UdVIYTqXHxHfsvtRGQPtfKnzTYd7m9
 8sfB1QRa0H7EO/+NtQgsEdyh8/toFo9tKtNJqPjB+NJ12vQu1zn+ypAhraCVHnzB8t9iy
 FLn3POtbS00EGxffvFmFi78YQ5nni1uI329w738OJ1TdJg1c3/7RkQgWqS/thWC+BRKus
 VmcpbLVy/eiO1nmtiXEC1shP6jf0Hjsz/XHsd9GuI3SJRIjimMiLo6K/lrrEH6ytTi0S7
 M5me4J4X6rRkZ89GTOSLhLDGW18TWLUSaBLua0A+hogayGU+tHDY2zJXq8dGlc+UW8A==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=163.com; 
 dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256
 header.s=s110527 header.b="pX6/P0jg"; 
 arc=none smtp.remote-ip=117.135.210.5
X-Greylist: delayed 128 seconds by postgrey-1.37 at util1.osuosl.org;
 Mon, 21 Sep 2026 15:15:46 UTC
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256
 header.s=s110527 header.b=pX6/P0jg
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=117.135.210.5;
 helo=m16.mail.163.com; envelope-from=18102059357@163.com; receiver=<UNKNOWN> 
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C100040685
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 15:15:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=JB
 t3km+oq8rxHOrYJGJBVULkS9OsfhLcNIEugKmJnEs=; b=pX6/P0jgwxpI8zsYXJ
 FzExVPrDPp5769/RfUw3p0dvEFXs/KByovSlKVWTDuHk/fNgWWseBZkXT2zVvUBg
 VNCSt9v7QuCaMRcsr57PXoXMsRTkxMRZXIXxrF2i0bAh8IsMc1s5UC7siJ5khJd+
 BIs1XHMiGqsvvQ8JU4rs4k9CQ=
Received: from localhost.localdomain (unknown [])
 by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id
 _____wBXPaWPSbFq0xQ+CA--.40149S4; 
 Mon, 21 Sep 2026 23:13:21 +0800 (CST)
From: Xiaoyi Suo <18102059357@163.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
	Xiaoyi Suo <18102059357@163.com>
Subject: [PATCH 2/2] lib: use memzero_explicit() for the SM3 message schedule
Date: Mon, 21 Sep 2026 23:13:15 +0800
Message-ID: <20260921151315.1167-3-18102059357@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260921151315.1167-1-18102059357@163.com>
References: <20260921151315.1167-1-18102059357@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wBXPaWPSbFq0xQ+CA--.40149S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7Ar15Cw47XF1rZFW5CrykKrg_yoW8Wr1UpF
 W7K3WrGr4rKw43AF17ur1xK34UKan3AF1UuFyDWw15Za98CrZYqFyUKrWqkr95Ww4UZFyS
 yF45tFWIyayDXrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0p__M3kUUUUU=
X-CM-SenderInfo: jpryiiysqvmjivx6il2tof0z/xtbCxhF9GGqxSZEheQAA3p
X-Mailman-Approved-At: Mon, 21 Sep 2026 23:08:02 +0000
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

The message schedule W in sm3_update() and sm3_final() is cleared with
memset() in the block where it dies, so the compiler deletes both clears.
-fdump-tree-dse-details names them:

	Deleted dead call: memset (&W, 0, 64);
	Deleted dead call: memset (&W, 0, 64);

The second of the two sits under a comment that says "Zeroize sensitive
information.", so the intent is explicit and the clear the comment promises
is the one the compiler removes.

Use memzero_explicit() for those two clears. sm3_final() also clears the
caller's context in the same block; that store survives today and is left
alone here.

Measured with GCC 13.3.0 on x86-64 against the default branch, with
u-boot's own include prologue: two deleted memset calls in lib/sm3.c
before this patch, none after it.

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


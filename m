Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B11DCA5FF5
	for <u-boot@archiver.kernel.org>; Mon,  5 Oct 2026 05:12:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5A79280D32;
	Mon,  5 Oct 2026 05:12:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lXVXshgNwSRd; Mon,  5 Oct 2026 05:12:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 23B2B80D10
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791177160;
	b=UvkqvMkPDz/t7EVFbmZcivfY+ye61dqLbOGoSDhZZrAwNLPEYs0RNZ91Xn7TOjbpt+oJ
	 eYRdSQ/x3GK9bZUZe3pvAtuqitKbZAKjQdEYDrVh4XyFhLlb9JBL6U7FtjSQVTf8PXS/p
	 8pjV3ErHgrgEY0P9DK2XyR9A9ourN6L1+cflESzBWtdEZIZDvO+tPa904JY5MMy4oj2LZ
	 XnPyyOvrd/YOTYJbosW1mG5W8q416qCfhETECVOYEFufVh0XiBHOvn93FKrFGNsvrKzXy
	 eW2YaSbm6KT9TQNoxBb3gYvhqr7ZYQVtkZ1YoYb27msshZIUmL0BLObS8bPBTx+g2Ug==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791177160;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Fzau1T1qsz6t7o5wX2jPG3U0jKqHhqSNC6/Pr2MSkjY=;
	b=pus/s94dnhGm6ArTDQdfC+fDQzGPmwHtBFg424G1ZmWEz4qVbw1Z5P9rPHkOLAXPAUR6
	 hQKTsxZrIDLLUECPUhAtN+jGU1hOIJUVQ4Om7DiNzGl/jpX6UZKJdJLMt35bdfXISBZWC
	 qfbXLFtKy7oLe7+edAlNd7OHlLVQ62fV1rH6MYLsorFjxbnYUdam4U/2a6J7i6DlCnn74
	 8DgEFa/teSjUHD4Kf8C6AjK2C5ZJeR3/inPJymrxhZ+9HFWumwFnH89Kd6c+kvNxyrjNo
	 bbdSVO9ujs8JjASI0cUGF5lhFIcCtQvvMYeUIRXzBCLETPD2LVgM9aE189c4O8UOfxw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=pass header.from=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=VaNb97h5;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791177160;
	bh=Fzau1T1qsz6t7o5wX2jPG3U0jKqHhqSNC6/Pr2MSkjY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gHPIxpU3/dDN7QaDi/tUJ6piOID27bElGR/6c6Q6oeNBjyQ7tZYCfxaJm1o0gXoES
	 2fx3nNTxEhDPhudKtAjEOvPm9ks19Do6AI7mzBNB7ebIMhuMkiJOg6J0lat+DsO85U
	 NdsGMyk2/elQDQ4Ck4r2+2eyzFZ9Sufv2jKZsXtL9XP087gtTNeA57+bnq9HPrrOoD
	 XixNAmpgYMgKhhFEbGMVivwiJM62n5mF3ARK7iew4ahZV1LRECEwJvQ+EntYIqf2/6
	 JPeiRbPeA4dvbhGqOHATaGdRRAnH8JV+aW43wKDPwu5TFIsNPUOh5bvncHRQetW35b
	 YTuLDdjJIhxnQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 23B2B80D10;
	Mon,  5 Oct 2026 05:12:40 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 065E2335
 for <u-boot@lists.u-boot-project.org>; Sun,  4 Oct 2026 15:27:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E0B8280CD3
 for <u-boot@lists.u-boot-project.org>; Sun,  4 Oct 2026 15:27:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rLDVDUPts4R6 for <u-boot@lists.u-boot-project.org>;
 Sun,  4 Oct 2026 15:27:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org AD4C880CC5
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=220.197.31.4
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791127652;
 b=taiNrpPF1Ex9fix65q13EHrAyEJU90r090qdRufKJfupQESc31KMsuOw827I7NacORrO
 Hm131PeERkeWTR3vyzWmBsTDOuyJHiemLiE/7wYms0sukMnZa7TFM4iCgWMW05V5T3M+X
 I91JJYGhC5iWeerz7y7lweGSijfK4CF+QoPcMXPBaOl3UBW+YYkk9N/ptDYV1yV4LHsE+
 HDme2gaapORv0K03pJ2Rzn7WMRIMu5U3rXTVfB0v3T+h/YHW/RYDPwd6C/DmpJlCvbtmt
 B/BsQ2Eig5B5/QOHQaCwE0+/afF6iJ/1iYOGI0MIzOyr9fB4mVVbJi/pk2bOCB4H90g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791127652;
 h=Received-SPF:DKIM-Signature:Received:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
 X-CM-SenderInfo;
 bh=Fzau1T1qsz6t7o5wX2jPG3U0jKqHhqSNC6/Pr2MSkjY=;
 b=PfoeThcq0EuhrbE7RXYV/lG0dUf5QAFkNim7MguSTeeGhOv7dYsZHfdrQRepJmocaC6v
 Ar3nKbmbZSaDjePObSE2YMLOaNgQqSiKECVzzeSw1xuWwGM4+fcU7UvbmcbIPOXQ+oyrY
 Ud1AHpo0Beo7QyuXyh2l98jx6/N9zQuchN6jTQ2R3We3Y6gZbZNrbRvIFUY4b5b6VcNCO
 si4SrwjbcQDAXxRqvPatBOAkdxIxaj+xqmGbefeJMTUYB+DM2IorrO/SDB0KTEPKOPEJq
 NaAQf/SapYK7SZFMzIWmbaPKJAr749a+iKQt+UhvawRaRdwSwA58YwSXXUvLWlfdb3Q==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=163.com; 
 dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256
 header.s=s110527 header.b=VaNb97h5; 
 arc=none smtp.remote-ip=220.197.31.4
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=220.197.31.4;
 helo=m16.mail.163.com; envelope-from=18102059357@163.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256
 header.s=s110527 header.b=VaNb97h5
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
 by smtp1.osuosl.org (Postfix) with ESMTPS id AD4C880CC5
 for <u-boot@lists.u-boot-project.org>; Sun,  4 Oct 2026 15:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Fz
 au1T1qsz6t7o5wX2jPG3U0jKqHhqSNC6/Pr2MSkjY=; b=VaNb97h5S9foEsyCIG
 mx0NWM8JOQAgPgdMYYq9qoXQ+ZHSmeIiD3Hpj15DRk6tHTdRNIpZSBDLH3EQHHO4
 /Lc9nr7q/lknP7Dm53dGu9Z3b5DcbjZfW1fgy26axqfGCXkOfKgJo5i8pj4uNsL9
 fyxy94i6Z6pRWh8BbbjI5ke0c=
Received: from localhost.localdomain (unknown [])
 by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id
 _____wDXf95TcMJqQD0ECQ--.17534S3; 
 Sun, 04 Oct 2026 23:27:16 +0800 (CST)
From: Xiaoyi Suo <18102059357@163.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
	Xiaoyi Suo <18102059357@163.com>
Subject: [PATCH v3 1/5] lib: add memzero_explicit() from Linux
Date: Sun,  4 Oct 2026 23:27:10 +0800
Message-ID: <20261004152715.1574-2-18102059357@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261004152715.1574-1-18102059357@163.com>
References: <20261004152715.1574-1-18102059357@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wDXf95TcMJqQD0ECQ--.17534S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7KrWxKw1kAr4UKr1xtFy8Grg_yoW8Zr1xpF
 sF9r4rGr4kCr1xGry3Cw17Zr4UXws5Jr1jgasFgw4DArZxKFnYvFn29r1a9F9rArZFvF4I
 vrWfW34q9rnxJ37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piyrWxUUUUU=
X-CM-SenderInfo: jpryiiysqvmjivx6il2tof0z/xtbC7RZ8F2rCcFZyNQAA3Z
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

Import the helper Linux uses to clear a buffer the compiler must not
remove. include/linux/string.h has it as a static inline with a kernel-doc
comment above it; this is that code, copied as it is, so a later fix
upstream can be picked up the same way.

barrier_data() comes from <linux/compiler.h>, which Linux includes from
that header too.

Link: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=bec500777089b3c96c53681fc0aa6fee59711d4a

Cc: Tom Rini <trini@konsulko.com>
Signed-off-by: Xiaoyi Suo <18102059357@163.com>
---
 include/linux/string.h | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/include/linux/string.h b/include/linux/string.h
index 986499dfc..a51b39e5d 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -3,6 +3,7 @@
 
 #include <linux/types.h>	/* for size_t */
 #include <linux/stddef.h>	/* for NULL */
+#include <linux/compiler.h>	/* for barrier_data() */
 
 #ifdef __cplusplus
 extern "C" {
@@ -106,6 +107,26 @@ extern void kfree_const(const void *x);
 
 #ifndef __HAVE_ARCH_MEMSET
 extern void * memset(void *,int,__kernel_size_t);
+
+/**
+ * memzero_explicit - Fill a region of memory (e.g. sensitive
+ *		      keying data) with 0s.
+ * @s: Pointer to the start of the area.
+ * @count: The size of the area.
+ *
+ * Note: usually using memset() is just fine (!), but in cases
+ * where clearing out _local_ data at the end of a scope is
+ * necessary, memzero_explicit() should be used instead in
+ * order to prevent the compiler from optimising away zeroing.
+ *
+ * memzero_explicit() doesn't need an arch-specific version as
+ * it just invokes the one of memset() implicitly.
+ */
+static inline void memzero_explicit(void *s, size_t count)
+{
+	memset(s, 0, count);
+	barrier_data(s);
+}
 #endif
 #ifndef __HAVE_ARCH_MEMCPY
 extern void * memcpy(void *,const void *,__kernel_size_t);
-- 
2.43.0


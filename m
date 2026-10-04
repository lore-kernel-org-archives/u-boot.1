Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 291A7CA5FE2
	for <u-boot@archiver.kernel.org>; Mon,  5 Oct 2026 05:12:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9398880AA6;
	Mon,  5 Oct 2026 05:12:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9oebpNxNR6ie; Mon,  5 Oct 2026 05:12:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org E777180A80
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791177152;
	b=e3O8KrkMI2qy2+hMURZ28zn2BCGhShrnzZbuXfUNoOm3UjMKcOz+ekqtLEa0256+nE8C
	 0/l7XJm1KVWaPLxEFpRwqrOTwjyFiZnaAxtv/XFk60oQnFOFd8h7mmQqK+152BqwEVOST
	 mTIPZl71YtleOrXKkhOslaDd7GxKx+7k09krJ7ulJai6fo9XK7+NORCFp9n2+jjz8dZgJ
	 LnMNvAGEQFogQqfPSiJm3amxTLoE/nouwBzdtpaFuPVyVr+Vsg9yAFsrIknpvy9FPeKKT
	 8W6Ju2wTGvu7i/pzRodzUMSnHDm7ZVF86lFPVFWr8GCcQ/GlbhkeeiXG70rj7r0exkg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791177152;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=BArcvSDeg6uwHteCEPJOO5IHntmCgeu9B6QxWRtofYc=;
	b=dEUCwL7IT4rYOSUUvgk3rq77Iamhl3WHdvQLQXiCqBln8KC+RnDMchkehZ5FU/fgJeI+
	 d10Q0vLD6JWskHvy+NwNjoyx8KrTgmCC/b/dzirtUDMh5KgiXI3F8nRuW/3TQUxbKHEjD
	 DUaELTLZK1zPQPqmldfhG7EATXdfa2MOy7wZJQ7q402adaTXB0bPhz8rXDkN/ry+1GK2c
	 /+1tE+rwvsZN8qE3qFB7JBJfw4LfLa92mupkYUVZ/nJY40BliYOtspkgufG/4Q5/eS6zm
	 A/gJ5ccSEoqfZ+6yEcsMjElN2k7MLitqY4LumNjgIS1wsltVTG1LBIDm9Fw34/y9wbw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791177152;
	bh=BArcvSDeg6uwHteCEPJOO5IHntmCgeu9B6QxWRtofYc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oI0ZgALKWlQK0BOVj8QXootPyca7ZeCrM7oj9sw70GnfDROrEd3renVybfRvEE/we
	 1NNiNIXnt9Kx0ejOPrro/s9l+fQtNxZpTw0g++8d+59sC8gaxrwP6qiqzxxNzcwsAx
	 nxawANY1CtqpEtY8uPdFoTS7/SqMRecMKP2LPVRKLV1mHvy7m6BnUQSNVBYyjbnoCj
	 6GA+QDrGbuy9BQn/Qw9tHGhaaIbhejJe/OtBDvXrfpWDEOt+Ub2SEWgQYC1hak81sk
	 ekN9FBDXgz34ZaaNFulyMJ81ZKm6k2yuKvSTJePOmvGy7IsyHPj5WzTf6CxIJwXinI
	 xwPW5zGRRNfsA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E777180A80;
	Mon,  5 Oct 2026 05:12:31 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 7161C435
 for <u-boot@lists.u-boot-project.org>; Sun,  4 Oct 2026 15:27:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6EA0860607
 for <u-boot@lists.u-boot-project.org>; Sun,  4 Oct 2026 15:27:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4oEw2CNAwqv3 for <u-boot@lists.u-boot-project.org>;
 Sun,  4 Oct 2026 15:27:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 9D27760604
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=220.197.31.2
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791127651;
 b=B9BKsqDkI2zWqNgK89E9/Y8hySEgsjMSz8MEO+ijLvuBcbzyu3DjMDc6rqfrg/dlEQpW
 HcngjjpbbDvEDtzRGDJIHrewCjkLcrevp2WChY8ha1snHHiJIFwgKSY3GG8XZMdggmmrG
 knWs+xBeulmPQ0qSfZ4f9auQb6K7yeazfJ+oU34lqxPk2dLzjpryRdNDqrcZ9UVRviRwr
 xUjI0fmaYEwMsoIY7ahZG5+HCgQ8qolTSaVSd+XF+nE30zyYm3IEtis6gPzaFF7xvuwNU
 nLe4dckyzVroq8baENjB7VoBId5aTNoC5JwlQxxVTbR2Yv8a9oOlExKUA4CIR4a5tVg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791127651;
 h=X-Greylist:Received-SPF:DKIM-Signature:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
 X-CM-SenderInfo;
 bh=BArcvSDeg6uwHteCEPJOO5IHntmCgeu9B6QxWRtofYc=;
 b=HWscyKEWC7qU8SvcYjaCgfdXDy3+k+0VFirVAiAT9t4vER2yTG+I8030Mj9kZ1RELw5Q
 79Rcj7F4nRvSTGfR8yW4+VE3D3QEKcgAjI8pMjHDksS6b50oHUKyO9xoMtHy9i+uzAgkt
 IhQIg2DfdS6iyRV8wTATaDHisgVdaHPWyxL1AhrsfYCSKw1w4xdwg9j70y2tFktFL/ord
 wXxA1LntvQjP11rvUttUwEKaCEa0T0IWgijGW54Zc03E3EIgz0Axnsk4ZgxNu4BzE1AKg
 oEnyBzOA5XNad5EaqiMoSFVcRXGfNFChsTEPV66ePhVtTBDqTAY6Nd8UuidWk7XN/OQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=163.com; 
 dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256
 header.s=s110527 header.b=NLKtwUTL; 
 arc=none smtp.remote-ip=220.197.31.2
X-Greylist: delayed 169857 seconds by postgrey-1.37 at util1.osuosl.org;
 Sun, 04 Oct 2026 15:27:30 UTC
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256
 header.s=s110527 header.b=NLKtwUTL
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=220.197.31.2;
 helo=m16.mail.163.com; envelope-from=18102059357@163.com; receiver=<UNKNOWN> 
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9D27760604
 for <u-boot@lists.u-boot-project.org>; Sun,  4 Oct 2026 15:27:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=BA
 rcvSDeg6uwHteCEPJOO5IHntmCgeu9B6QxWRtofYc=; b=NLKtwUTLwRhv5oUtlZ
 QSd3Oci1jhPN7HApww8JJrJ4x0l/+RyKiFT06l8NNIW8bpb3DN10XPZ3yruws6Hm
 lc4JZirlpAdnWMYfdQFAqOmzCzSL5Fsv3mlrvYfS6Sm1eL7/v2A0s8Xr8DgBHO3y
 rrLqhz4aUMOmHUAyp+/k3+3WM=
Received: from localhost.localdomain (unknown [])
 by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id
 _____wDXf95TcMJqQD0ECQ--.17534S5; 
 Sun, 04 Oct 2026 23:27:19 +0800 (CST)
From: Xiaoyi Suo <18102059357@163.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
	Xiaoyi Suo <18102059357@163.com>
Subject: [PATCH v3 3/5] lib: sha256: use memzero_explicit() for the HMAC key
 schedule
Date: Sun,  4 Oct 2026 23:27:12 +0800
Message-ID: <20261004152715.1574-4-18102059357@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261004152715.1574-1-18102059357@163.com>
References: <20261004152715.1574-1-18102059357@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wDXf95TcMJqQD0ECQ--.17534S5
X-Coremail-Antispam: 1Uf129KBjvJXoWrtw1xGr43ur43XFyfZrW5ZFb_yoW8Jr4rpF
 ZrKF93JF4UJryvgF9Y9w1Iqr1UKws3JF1UJF4Yv34xJa17X34kJFWUKFWFgFy3ZrWkuryS
 kF4UtFy0va4DArJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRveHdUUUUU=
X-CM-SenderInfo: jpryiiysqvmjivx6il2tof0z/xtbCxRd8F2rCcFcUBAAA3m
X-Mailman-Approved-At: Mon, 05 Oct 2026 05:12:02 +0000
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

Same as sha1_hmac(): the key schedule and keybuf are locals cleared just
before the function returns, so those stores are dead too. keybuf holds
the key, or its digest when the key is longer than a block.

The memset() that initialises keybuf is not one of the clears, so leave
it alone.

Cc: Tom Rini <trini@konsulko.com>
Signed-off-by: Xiaoyi Suo <18102059357@163.com>
---
 lib/sha256.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/lib/sha256.c b/lib/sha256.c
index c2e77c854..226af9b2d 100644
--- a/lib/sha256.c
+++ b/lib/sha256.c
@@ -307,11 +307,11 @@ int sha256_hmac(const unsigned char *key, int keylen,
 	sha256_update(&ctx, tmpbuf, sizeof(tmpbuf));
 	sha256_finish(&ctx, output);
 
-	memset(k_ipad, 0, sizeof(k_ipad));
-	memset(k_opad, 0, sizeof(k_opad));
-	memset(tmpbuf, 0, sizeof(tmpbuf));
-	memset(keybuf, 0, sizeof(keybuf));
-	memset(&ctx, 0, sizeof(sha256_context));
+	memzero_explicit(k_ipad, sizeof(k_ipad));
+	memzero_explicit(k_opad, sizeof(k_opad));
+	memzero_explicit(tmpbuf, sizeof(tmpbuf));
+	memzero_explicit(keybuf, sizeof(keybuf));
+	memzero_explicit(&ctx, sizeof(sha256_context));
 
 	return 0;
 }
-- 
2.43.0


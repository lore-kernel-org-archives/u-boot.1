Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 742B3CA5FDD
	for <u-boot@archiver.kernel.org>; Fri,  2 Oct 2026 16:47:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9B59481082;
	Fri,  2 Oct 2026 16:47:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sTfdQH-0oBRQ; Fri,  2 Oct 2026 16:47:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 9275B80D85
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790959637;
	b=XG8nqN8/JVFhoDuocbp5qxr1zIeDqXYfKwthMmBc9R37gARJdJfBO7ZiToFvC2hvGd/7
	 HWQO12qnYG7MLG/yMcPD23zjc4x8A9wgHxXWYOSziRrNX0v5q+Fc+6NcSsmyJtX+KhZ7f
	 2gHlOPeX2dFWm2eMyYlZj06C2ap/z+9b8tEVp8UDv6TdKxgxHi/EtugqHJ6k3kxhvrbDw
	 as1FD0GAfNk805Kk6heMgTU+aWxMWD3qA0gUF73rQqdrRcKne9Xg2jijUK1YGjcMM2WPK
	 pIWGdNqixzAnasywwfb3c39zj5zU/0bjDAhdqen4SqSRyrYLdpd/kobGq5irthb/VPQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790959637;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-CM-SenderInfo:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=RSpd7j30tzvQLBUoeKgOS09st+XeiJa11ay+driW+Cs=;
	b=XrZW08izveaqiluN2JPdxwOR8c/j3PMNgBnGJPQYcWN5A0gpUbFiwdtMdBAUvKjpHIQ6
	 9FPFoSzbXUw2wBUDX6zFR0I7A6cC5uH1P2hLBz8ZcGXQxNMpdN6bMxucA92A3AXvvW9e4
	 ExQH8ZrtOpWJjHYHUzBcBwbUmv2H6fx9n0BNU93EXJ1Aq4jQwG+vjE4wf6e6aJ6hDrVlg
	 2AhlEvWmyPX28shoSKPrWOe2R+tlTm2oZsLqEzl+iiaU03fGU8peDpsUXD3x+CLzHwFyJ
	 ISu9KaEDeON/XDq4jM3+HcwO9u1tdLn8LnGcMF90EkVVH1helj7YP+sGSQFhQgyBj6w==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790959637;
	bh=RSpd7j30tzvQLBUoeKgOS09st+XeiJa11ay+driW+Cs=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=y1PPF4A61J/0ioRyFryLQ7diWxp9KK7QcmGWEnEoLF7FuGpLhfRiL/YI55n7JTGwn
	 WKbXy3ypB/eTkcv337iFO0fbqreRUN3TOwljPHSKADKjDtbIX0T49PkfL70yQ0X9z5
	 cLX0FU2MQ+FvTcv0KE6Iu7d6cthNqa5oVtaw+F8dhaZ4Vppg2YnJPnz1SmShcwuNMx
	 Y4M6AVwhW2jEpFVyM4mShUQxv2QEzcZNARfovzep7kLEVZLfGxS75eEYR0UB2nAYS3
	 heCO4lBvTLlWInxon9wdRCZ58bY0mmDoipah4UvPv5cmImty/xn2uKAvCkyodAbINC
	 uYAAX58+XU2hw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9275B80D85;
	Fri,  2 Oct 2026 16:47:17 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 67669282
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 16:16:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4D3E9606F5
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 16:16:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dyoMoCIKVLB4 for <u-boot@lists.u-boot-project.org>;
 Fri,  2 Oct 2026 16:16:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 7693360668
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=117.135.210.5
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790957785;
 b=fHdvnnJ5FnLvjSx1PrSif8+A7AJXXng1uyWpUIgzLVQcf6NbIfe0Aog4sN8S8RL8zgNc
 PQUdKI5dDOdWRWAeQZjG11vaD9MJlvh5vCOxsHbvHcstCIgx4WVkCfT93IlhYqtenPDER
 fitLrIa/QprgIMyO+wBwW+ZbQnYVInCbeP+uCHVM2JMmIaOom1RgQxWld6JavL6JxUl67
 Uez1sr9GsQNIluma1bC3wj9HG/ChsjTZax3AeFmY2DZXkWk2GBLo0n/Odl+98SaklPixg
 AuPiwczlSdeC6GD5tPEkLW3+jeWS9n9CDEJLhJT7m/2WTkKvD5nN6HShX1o8Wcvg/XQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790957785;
 h=Received-SPF:DKIM-Signature:Received:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
 bh=RSpd7j30tzvQLBUoeKgOS09st+XeiJa11ay+driW+Cs=;
 b=NbklC44maGycdTOSeZkzA30aMOwrrkhslON/Npmta0p/zK97Z0Z/6NSMiPKg2pPJQxIC
 pA5YnVx+5YrP0kYtoQqHAg0PQxX6WELmcTNsHDK8z+Cz4poocM4VjAfkOdt7PMfFAY4bw
 loEi4JDanzUuVV1I8QvaLLGiZHA+ujI078nFn4ysRMtKNIOMjJvr2mXwuHYVE6pMtJ+rN
 2S6LySDS3qeERNW6wpp66JdnHF+1jaJzw9J/bHPv/BRpKGrpJInQNSeR7COokDbMwkeEB
 l9Id5jp1V1Kj6XQOS4XPUytyQmpn4ssiXgZJCsg6gQ8vuaXVaB/UCieHS9OQmD+HEdg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=163.com; 
 dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256
 header.s=s110527 header.b=DiZgWoM1; 
 arc=none smtp.remote-ip=117.135.210.5
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=117.135.210.5;
 helo=m16.mail.163.com; envelope-from=18102059357@163.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256
 header.s=s110527 header.b=DiZgWoM1
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7693360668
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 16:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=RS
 pd7j30tzvQLBUoeKgOS09st+XeiJa11ay+driW+Cs=; b=DiZgWoM1QHJPYThVkR
 CMtaZA4/XF86xyeXH8lJYbscamYp9NA5aHGrKiwElUfL5DAcLXPF/LWvrbXnzr7R
 tGdqxsdbGdbTtQHOcImtUIasPPMiTT6MNnEHt3i7MvPByj1MNC3A+xr2F29M+mNN
 jVEwYQDHR3PtG4BtzUcnrjP/k=
Received: from localhost.localdomain (unknown [])
 by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id
 _____wDXvWbI2L9qGvUkCA--.16429S2; 
 Sat, 03 Oct 2026 00:16:09 +0800 (CST)
From: Xiaoyi Suo <18102059357@163.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
	Xiaoyi Suo <18102059357@163.com>
Subject: [PATCH v2 0/2] lib: make the clearing stores in lib/ real
Date: Sat,  3 Oct 2026 00:16:05 +0800
Message-ID: <20261002161607.688-1-18102059357@163.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wDXvWbI2L9qGvUkCA--.16429S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7CFW3Gw4xXFWfAr1kGr43GFg_yoW8WFyrpF
 ZagF43JrWkCryIvr1fZF4xt34rGan3Aa4DW3ZrK34rZ3W5XFy0qFyjkr1agryDXF4Iya4j
 vF4rKasrGF4Yv3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0p_uWL8UUUUU=
X-CM-SenderInfo: jpryiiysqvmjivx6il2tof0z/xtbC7QnyjWq-2Mlc2gAA3Z
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

sha1_hmac(), sha256_hmac() and the mbedTLS sha1 shim build the HMAC key
schedule in local arrays and clear it with memset() before returning;
sm3_update() and sm3_final() do the same with the SM3 message schedule.
Those buffers die with the frame, so the stores are dead and GCC removes
them from -O1 up.

Patch 1 takes memzero_explicit() from the Linux kernel and uses it for the
three HMAC key schedules, where the buffer holds the caller's key. Patch 2
does the same for the SM3 message schedule, whose clear sits under the
"Zeroize sensitive information." comment.

In U-Boot the caller is the TPM 1.2 code, where the key is the usage auth
of a TPM key. Reading it back requires something that reads the stack
afterwards, so this is the lifetime of the secret rather than a direct
read.

Measured against main (211de43) with GCC 13.3.0, each file compiled on its
own with -fdump-tree-dse-details: the dead store pass removes the clears
in all four files before the series and none of them after it. checkpatch
reports no errors and no warnings.

Changes in v2:
- memzero_explicit() is now the Linux kernel version - a static inline in
  include/linux/string.h - rather than a function added to lib/string.c
- shorter commit messages, and function names instead of line numbers

Xiaoyi Suo (2):
  lib: add memzero_explicit() and use it for the HMAC key schedules
  lib: use memzero_explicit() for the SM3 message schedule

 include/linux/string.h | 21 +++++++++++++++++++++
 lib/mbedtls/sha1.c     |  8 ++++----
 lib/sha1.c             |  8 ++++----
 lib/sha256.c           | 10 +++++-----
 lib/sm3.c              |  4 ++--
 5 files changed, 36 insertions(+), 15 deletions(-)

-- 
2.43.0


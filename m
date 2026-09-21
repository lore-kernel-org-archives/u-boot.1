Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53293C982FB
	for <u-boot@archiver.kernel.org>; Mon, 21 Sep 2026 23:08:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C61856068B;
	Mon, 21 Sep 2026 23:08:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id S5QAWA3fzcuj; Mon, 21 Sep 2026 23:08:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org B457760656
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790032086;
	b=QGi9y8JBrnG/b42Hw+Bg73iMVWaWrd8eEJYZ2eOASD5IeDI1z9ekkhdOneVdw6CrLBR7
	 KzJxFI+Sk12dGXf0pXcHXOVu+ZWT/kTB8WsbA+5+RnsEM7XEsDDkBQ5ttPdBh2omnthky
	 vYlmXAnZS4xtFJQ96glKDGjTXZw30IUPGz9WaYYr1HOSWiybuRMpInADawVVa3MxETEUD
	 JAPShFRdlQNl6+4CgevI3MXkJbsE5W0a4c73cBqirsLVtopmMbr1baRGCeFtIAB/0MQzd
	 /mP/0ET5le3fgcMHHUZluEMhvLxCOSrMnn4zkmo2fkWwpLv6Rul1MOmK8WYn2XJj6vg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790032086;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-CM-SenderInfo:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=gNhWKgk5Rulf53aFoxZ3L0o+Jg+BiX++YtXevWqJo7o=;
	b=CYnRNqiQeLI+dGUAPJP3wwa7L9p9JENUm2Wp70daCZlI4dNpgXyItsk2GGEkiYc5y0Lc
	 plsKwjFtgJS/wcyH46pdnUZlkqkqiCMlh7Of+JWnCwRDOp8qYRzbXYWkbY0GhYDtOYUFq
	 a40sL6L7+xM6WbxxC0HMgyFc2fQX6JAD3K7fqgy57ghTRwwHB0dOj8g3BLVq6+Xg4lsyv
	 PHUFa3hV7jN2FVQXwbJE6FjVfYfcbXArv8czJ+XW6WE+ccU8QGNFfRU8bDpHWsjriy5+7
	 NULqu15O86y/0q/EZyUkFjIWLeCcOhCFovsPVRUCs6XyHNjELo7/XPOfthMmB+5197w==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790032086;
	bh=gNhWKgk5Rulf53aFoxZ3L0o+Jg+BiX++YtXevWqJo7o=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=sL7i8Zq4GJjg3OwJG+WJSDpTebUEbQ9UHvrR7AOc2qWjhhWtnR4fNAsmTkHlJtJvv
	 dGkuakayYyVK0sUy2sl8ObMF8TbG99fiIIcbmmpSkj28YxFZaLt8nwWbZb0EpzeY1r
	 D3Cbmvox9CU4FCt8VaSOlRR3kk9GeD/+LhJzygtM/UdEf7QwWrCLSyL6yqcflRVjPL
	 eZ1zgttVPRtd520imu4IQSSe3vwLoHAennBLUAdwx8a6H5lV4Ps4DLaieE9eiTwaQK
	 pwASwUQgEG6Tl5sJcxYq/LEaT6luU0l5TMb+m+G1vmbAgX/wgf4rfJGZYCXwetN5g8
	 XYK7Tr1Iuj05w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B457760656;
	Mon, 21 Sep 2026 23:08:06 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 55CB313D
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 15:15:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 478BE40754
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 15:15:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LvhcwIwJKHAU for <u-boot@lists.u-boot-project.org>;
 Mon, 21 Sep 2026 15:15:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org C1056406A0
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=117.135.210.2
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790003747;
 b=h6upQ3ewx3tEd3ZSg8DhrzieaJ4H6uIDHehF6aY2VyYcPaFaZHnK6qcWDgcZdy5FqxNq
 CFhsn4aGKZId4t1lpYnLWHeuU4+NHbBOrJodHq72jStvs6ag12mKwJg8nJvR2x9VPZLrD
 qb12Jt91PVD+iB7pe84zHrx0uUmWfebIHvVQvdYDFejOqiIATZyTwIjalxAB67meMZV15
 hueIXOo+x1LV8ANlNFOVD7zpPOAxNLxQgnnKBPMePuyBgbqf4S+JJYGUnuiilKs2e61Fi
 m29RSoxpy9pwmFnD0fzu+ZTCIUTEntXKXcclboPkTP4TWIHSdwIYB7ufBjM4+8lLzzw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790003747;
 h=Received-SPF:DKIM-Signature:Received:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
 bh=gNhWKgk5Rulf53aFoxZ3L0o+Jg+BiX++YtXevWqJo7o=;
 b=n8GAeTkJAk3eKthMJZ9VCO4yudP0CWZfEFtwZg0N5oEwWpdLwMFj7BlZdil+tefCPmMJ
 YI5emxa9XB29tA+2LWRD98k4qppm1ZCPDSp6h0qYzu1A/8xi5Qh/60jmGf1KIVX3hQ7uE
 lZrVJ+3wYpGqR0D+Qv+AZ/e6iBIre4gX2iSFFEXA8MOUlgwpg/P6SGWInblEIq4xK0dQC
 NIvO2AXtgK3+mWqTF/AjUKOvCEAPUFuZeyOYNOn4r9gUbaN68uLReyZM3DeQgqxvO1p5m
 uVSPg/XKU7mZK3RA0Uo2mbB/3fx5wz8preik6N1a9KJjkkrnay6VA54HWF1EaalsjWg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=163.com; 
 dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256
 header.s=s110527 header.b=ifZ4HJ88; 
 arc=none smtp.remote-ip=117.135.210.2
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=117.135.210.2;
 helo=m16.mail.163.com; envelope-from=18102059357@163.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256
 header.s=s110527 header.b=ifZ4HJ88
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C1056406A0
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 15:15:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=gN
 hWKgk5Rulf53aFoxZ3L0o+Jg+BiX++YtXevWqJo7o=; b=ifZ4HJ88OTCb5cs1jP
 lZ2CBAC6L2v60JAzvJbExGn7JCBb+BMxR+FcFzwSJkOmzHS+KPJiGQ8MuF55QGsR
 hAxd6qAyTnQvaM3VCX7Z0ih5L1m5iMPAXHJjYKg3MHuF0Wi5Fe8m0BV4UB9QoYNj
 8kNT8rDF4UMcKdG+DjJlzubk4=
Received: from localhost.localdomain (unknown [])
 by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id
 _____wBXPaWPSbFq0xQ+CA--.40149S2; 
 Mon, 21 Sep 2026 23:13:20 +0800 (CST)
From: Xiaoyi Suo <18102059357@163.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
	Xiaoyi Suo <18102059357@163.com>
Subject: [PATCH 0/2] lib: make the clearing stores in lib/ real
Date: Mon, 21 Sep 2026 23:13:13 +0800
Message-ID: <20260921151315.1167-1-18102059357@163.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wBXPaWPSbFq0xQ+CA--.40149S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7CFW3Gw4xXFWfAF4rCFWxZwb_yoW8CryDpF
 Z3KFn8Wr1kGrySvryfZan7t34ayan3Ja4DJ3ZrK345Aas8Ja4rZFyjkF4IgryqqrWIva4j
 vF4rJa4kKFy5W3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0p_Man8UUUUU=
X-CM-SenderInfo: jpryiiysqvmjivx6il2tof0z/xtbCxRB9GGqxSZAVXwAA34
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

sha1_hmac(), sha256_hmac() and the mbedTLS sha1 shim build the HMAC key
schedule in local arrays and clear it with memset() before returning.
Those buffers die with the frame, so the stores are dead and GCC removes
them from -O1 up, and the key stays on the stack: the pads hold
0x36 ^ key and 0x5c ^ key. In U-Boot the only caller is the TPM 1.2 code
(lib/tpm-v1.c:577, :641), where the key is a TPM key's usage auth.

Not remotely reachable: reading it back takes something that reads the
stack afterwards (the next frame at that depth, a core dump, /dev/mem, or
an unrelated memory disclosure). It is the secret's lifetime, which is
what those memsets were written to bound - CWE-14.

Patch 1 adds memzero_explicit() - a memset() the compiler may not delete,
built out of the barrier_data() this tree already has - and uses it for
the three HMAC key schedules. Patch 2 does the same for the SM3 message
schedule, whose clear sits under the "Zeroize sensitive information."
comment.

Measured against main (211de43) with GCC 13.3.0, each file compiled on
its own with the usual include prologue and -fdump-tree-dse-details:
4 deleted memset calls in lib/sha1.c, 5 in lib/sha256.c, 4 in
lib/mbedtls/sha1.c and 2 in lib/sm3.c, and none of them after the series.
A probe that reuses the frame recovers 20 bytes of key at -O1, -O2 and
-Os, and recovers nothing at -O0, where the memset still runs.
checkpatch reports no errors and no warnings on either patch.

Xiaoyi Suo (2):
  lib: add memzero_explicit() and use it for the HMAC key schedules
  lib: use memzero_explicit() for the SM3 message schedule

 include/linux/string.h |  7 +++++++
 lib/mbedtls/sha1.c     |  8 ++++----
 lib/sha1.c             |  8 ++++----
 lib/sha256.c           | 10 +++++-----
 lib/sm3.c              |  4 ++--
 lib/string.c           | 21 +++++++++++++++++++++
 6 files changed, 43 insertions(+), 15 deletions(-)

-- 
2.43.0


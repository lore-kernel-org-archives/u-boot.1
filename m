Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18EC5CA5FCE
	for <u-boot@archiver.kernel.org>; Mon,  5 Oct 2026 05:12:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BCD6480CEE;
	Mon,  5 Oct 2026 05:12:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id A6vgu-X9fGM3; Mon,  5 Oct 2026 05:12:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org E13A380CC2
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791177158;
	b=RL9mjRnzLjUs17H9t7InqMoJOhqCYDFxdakMavFjoie2QgdcKAYve0OjcFH4ome7Njoq
	 Axkw7v3mj/LBIal+ptnczJkJWjujuq0fufo/aHlLqUlU20v/IH3vKbLPUZWbVqEvfTxSw
	 ZxCLZKfGJcsrTQIsSqgfAZdWy/q58AcZXN7XvPO+KzMh2TNuf2i4+wV1i7r/DPyMcKSgI
	 3Ell36jGCDR2Dvf0YXk/h463IuGabGMZl6R/cXN85HSy1Jt8UqAdhv5eUtrkSFEWGAcD9
	 d1nmGtdnp2k7GE29m5i3tYbayZMevBd8BRqEP09FbKz9YhjcS5lLT2nBFNMbdkyDe/Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791177158;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-CM-SenderInfo:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=jIMbzSah0g1APwCE4FCU6MbUn+SrmHEZXa4bKHCkJgo=;
	b=NhXMPPPmNgjyAGz9oE6GfsNg/xxdcbHWig7YnF7C1/JVr8Hjh28gdDE/W4b9oeviVGAy
	 rmwVmXwGaHLvioeryBE7s3yIBjJyUNslVJRWQdmiNbjNqkiUeDYRYszMqimJXSEemWIkT
	 aMiab47f1Lc6FDUe8CiPw+ctVir/9FIC4UiLPY3xHm/e89XYDrxMTo0mT0MWw0Ow1YBul
	 Rm9M+ZG1ubeyA2MFqEwusrQtTaU8KJtiRxGjJcm1cFKxeKpIjWV457cztFQIWWNFCqtXJ
	 feDQtTha15nSudDdZz3zG57Muplkw7+vvTPB70flEzeCIFpWJ9YyveeKdTy9ZYN5XQA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=pass header.from=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=nS5MjqWb;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791177158;
	bh=jIMbzSah0g1APwCE4FCU6MbUn+SrmHEZXa4bKHCkJgo=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=vDAsC6+xIx58woHwKfRuBoPv56FC1wak4c3fG4YBA7X7z+Hfqmzicn8ogDDIOPmkI
	 JuNAFYW0I8BZNmhiciUoP7cwLEDEZIcv8cp6YJBUUYZM9m/xjj4b8cTWMahLnJbStN
	 zUsqi4cFQXQ4H1xajgyNGbPzYh5NvspjMThdwRZJzHTzFq3QDFO9OQMsYXrMQfxJNU
	 kZM3aVghG3WTjx4wEotKxUE2WFpn38ti45elMelN3WSX3Begok0+OvI3YWRJihyxia
	 VAMSX6mdMEB62B6X+Lcx5C9VhnVrmnithtHTVTE75XM8Epf3MAXFNP1mFQF2PwHeoc
	 LivaLdLmMOuBw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E13A380CC2;
	Mon,  5 Oct 2026 05:12:37 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id E0918435
 for <u-boot@lists.u-boot-project.org>; Sun,  4 Oct 2026 15:27:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DE5A980CD4
 for <u-boot@lists.u-boot-project.org>; Sun,  4 Oct 2026 15:27:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7XeUxz_MOGxC for <u-boot@lists.u-boot-project.org>;
 Sun,  4 Oct 2026 15:27:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 77D5D80CD3
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=220.197.31.3
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791127652;
 b=rxJRx0Dyn/AG3UNQ4MzzKuJL9ooDI95WIw5GbYioYfGeHcBH6IIXVN+bG/1Ypxj1N9Hy
 dZK5vAjQgNLKvz94aCaJB19cT7vcBDPxQ8cgT5QZ7Rspki5GsXhzWkOLM0jN/M6LPapUw
 AZA3YHzEBzMn62AtvIyemcnyFmMCOsDe7sGHgI8kWsgrrWohTWoAiMscluvlV2p+5M8gO
 p+R0LR1aJ2Ne0EJNfypjeH6uDa3AwkpTanjJL6lF0RodpJ6iTYQzpRcSAxc2pgcPfbhz4
 v2M2wEKRDxhRDQ4bTQXyR9BYFr2MHKvgzJKr9N85VVbJk7AfN39sbt0xTRzX1/+Z1UQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791127652;
 h=Received-SPF:DKIM-Signature:Received:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
 bh=jIMbzSah0g1APwCE4FCU6MbUn+SrmHEZXa4bKHCkJgo=;
 b=IktGUqnWQN7qzjk6lXkrj79exjtMEZ9s77CI8RmPZbVo/oAsJ2c4ARK+JZoYHn49xkFm
 q6RiISN4lCohMGOJ6bL0zoCGcDvQ3LyB+jo/VcV9I7uRAIth4dn3BIFQeLczMOUeDtNFK
 MUybEjuT/rJiUqY5x9wWDg/duOyDu4HW2gR+71pyqhZCHxqxWmhgSC9H9Na4UkRmmFmHa
 TPvz52Q/4voAAV4QjOdXllKGBeGPqiMeUSsJ1DBhKRDEYJnIe6Aiqk4yLNw9ah67/p2tr
 3wZ3wppgeU2lnN48nkkO8WQIy9Prv8sOnEh2Sq74XFPgA/lB8+cMPVG6ng01FhA+WaA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=163.com; 
 dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256
 header.s=s110527 header.b=nS5MjqWb; 
 arc=none smtp.remote-ip=220.197.31.3
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=220.197.31.3;
 helo=m16.mail.163.com; envelope-from=18102059357@163.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=163.com header.i=@163.com
 header.a=rsa-sha256 header.s=s110527 header.b=nS5MjqWb
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 77D5D80CD3
 for <u-boot@lists.u-boot-project.org>; Sun,  4 Oct 2026 15:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=jI
 MbzSah0g1APwCE4FCU6MbUn+SrmHEZXa4bKHCkJgo=; b=nS5MjqWbv3vd2GRQx/
 kuvC/R/C4L5rcYxo7cikZDjDtaypj89xd49wJM0yTaGjtvppPE0gtaDyLxh1Qpro
 JBO5q6C2rvY/mKhDOR9xgqxU+89ANyv9ZUWRSFT+j/ZCjnOQIqq1FCHc1UmUm1Gc
 D3B9+SAXhZHeN6bzBpJDmqWO8=
Received: from localhost.localdomain (unknown [])
 by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id
 _____wDXf95TcMJqQD0ECQ--.17534S2; 
 Sun, 04 Oct 2026 23:27:16 +0800 (CST)
From: Xiaoyi Suo <18102059357@163.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
	Xiaoyi Suo <18102059357@163.com>
Subject: [PATCH v3 0/5] lib: make the clearing stores in lib/ real
Date: Sun,  4 Oct 2026 23:27:09 +0800
Message-ID: <20261004152715.1574-1-18102059357@163.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wDXf95TcMJqQD0ECQ--.17534S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7WFy3Kry7tw1kAr4xZFykuFg_yoW8Aw13pa
 9IgF13Jr4kJrySvw1fur4fX34fWan3J34DWr13Ww4UZa98XFy0qF1jvr4fK34DA3yF9ay2
 qF45Was8GFyUZa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0p_Man8UUUUU=
X-CM-SenderInfo: jpryiiysqvmjivx6il2tof0z/xtbC7hR8F2rCcFRznAAA3y
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

A few places in lib/ clear a buffer with memset() just before the buffer
goes away. The store is dead by then, so the compiler drops it and
whatever was there stays on the stack.

Patch 1 imports memzero_explicit() from Linux, where it is a static inline
in include/linux/string.h, and links to the upstream commit it comes from,
so a later fix there can be picked up. Patches 2 to 5 use it, one function
each.

For sha1_hmac() the caller is the TPM 1.2 code, where the buffer holds a
TPM key's usage auth. Getting it back needs something that reads the
stack afterwards, so what this fixes is how long the secret lives, not a
way to read it from outside.

Tested with GCC 13.3.0 against main (211de43): each file compiled on its
own with -fdump-tree-dse-details; the dead store pass removes the clears
in all four files before the series and none of them after it. checkpatch
is clean on the five patches.

Changes in v3:
- the import is its own patch and links to the upstream Linux commit
- one patch per function instead of grouping them together

Changes in v2:
- use the Linux version of memzero_explicit(), a static inline in
  include/linux/string.h, instead of adding a function to lib/string.c
- shorter commit messages, function names instead of line numbers

Xiaoyi Suo (5):
  lib: add memzero_explicit() from Linux
  lib: sha1: use memzero_explicit() for the HMAC key schedule
  lib: sha256: use memzero_explicit() for the HMAC key schedule
  lib: mbedtls: sha1: use memzero_explicit() for the HMAC key schedule
  lib: sm3: use memzero_explicit() for the message schedule

 include/linux/string.h | 21 +++++++++++++++++++++
 lib/mbedtls/sha1.c     |  8 ++++----
 lib/sha1.c             |  8 ++++----
 lib/sha256.c           | 10 +++++-----
 lib/sm3.c              |  4 ++--
 5 files changed, 36 insertions(+), 15 deletions(-)

-- 
2.43.0


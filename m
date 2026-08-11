Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FCFBC5AC67
	for <u-boot@archiver.kernel.org>; Tue, 11 Aug 2026 23:17:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id ABE6A608C5;
	Tue, 11 Aug 2026 23:17:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NaQlK8_ySfir; Tue, 11 Aug 2026 23:17:08 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7D148608BB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786490228;
	bh=ERSaALPrZKgl/pM5+AnFqOTYbHeZT6cj5aXGESE7b18=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=iMh/OT0R7z9zk0QdvF4aXyvs3gERfsO4ZbGuhyZPYfNEY6dvZcXj9+frFoNppPxkA
	 4QLG2UAjkYMsD02MPqH6bQrcv8AS/4javh9jgTVf1NH9sEja1wRPueo9yJeIJ5ekUP
	 GkEhpMnkeRhk8hiwXqQXivO932d+pTKUnLqlU6vjQZBPGde/z64x4OvJ0iXyHDepG+
	 HXLbc+FIq+m1DO39zrX7is2qA8sZDMOz3gBIwjOoE9hbW28WQqJiWDPUy6vETILtE2
	 r/OMbA5G1vGWorDpwccmSx70WB1vR3t0CtbA5LJvEzEa35kv/q40u9nZUTiR5tbGtS
	 C3F90B7IJUdSw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7D148608BB;
	Tue, 11 Aug 2026 23:17:08 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 32F6D2E0
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 23:17:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 240D181190
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 23:17:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WUxFPT1Vhzcj for <u-boot@lists.u-boot-project.org>;
 Tue, 11 Aug 2026 23:17:05 +0000 (UTC)
X-Greylist: delayed 22454 seconds by postgrey-1.37 at util1.osuosl.org;
 Tue, 11 Aug 2026 23:17:04 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 2E6238112C
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2E6238112C
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.73;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=7f0c=gf=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2E6238112C
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 23:17:04 +0000 (UTC)
X-Forward-Email-ID: 6a7bad6da067a7a17f1bb551
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 2.13.10
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Tom Rini <trini@konsulko.com>, Randolph Sapp <rs@ti.com>,
 Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Joseph Guo <qijian.guo@nxp.com>,
 Emanuele Ghidoli <ghidoliemanuele@gmail.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 u-boot@lists.u-boot-project.org, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v2 0/3] boot: image-fdt: Restore suppression of irrelevant
 ERROR message
Date: Tue, 11 Aug 2026 23:16:46 +0000
Message-ID: <20260811231650.3150771-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kwiboo.se; 
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1786490224;
 bh=ERSaALPrZKgl/pM5+AnFqOTYbHeZT6cj5aXGESE7b18=;
 b=bt6aE8LsodLhl/vbLfsbh3ShO7w/p+rf/BIbANgcIkwglrXWZc4oaDxBAuZKnXLkZtYCkbLH3
 aWwlOKsrRyjkHWmv0VY9iY7LKUAf/TwDjDAP0+k7Z06CxQpHpTv4CzcQ/AkLt4eaOnO665n/QRE
 KaCh60ap2TzBgMy9G/cwxsAXQ7ik6dmXySJukVBrOutzqXudq+Ie3G86Rp6QBvyghmchSvhNHJc
 hQpAVNgIkVls54JzUq7MBs4RoxQMTC+SVMaw2OO7QKjNDJdvw9fiA1lt0J4mZsaFXFuQxnlzd8B
 HvGbKh7OLLmo0GJ6LMDEy9Jg77C4WKb5ioL575HIWLQA==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b=bt6aE8Ls
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

This series changes the returned error code for lmb_alloc_mem() and
lmb_free() may return to help restore suppression of the verbose ERROR
messages when FDT memreserve and reserved-memory is being processed.

Changes in v2:
- Change lmb_alloc_mem() to return -EFAULT when region is not part of
  the LMB memory map
- Change lmb_free() to return -EFAULT when the region is not allocated
- Change to use a debug message when -EFAULT is returned

Two similar patches to suppress this ERROR message can be found at [1]
and [2].

[1] https://patch.msgid.link/20260713-downgrade-v1-1-183a2300741b@nxp.com/
[2] https://patch.msgid.link/20260810-suppress-fdt-res-error-v1-1-e9641eb0aadb@oss.qualcomm.com/

Jonas Karlman (3):
  lmb: Return -EFAULT when requested region is not part of memory map
  lmb: Return -EFAULT when freeing unallocated memory regions
  boot: image-fdt: Restore suppression of irrelevant ERROR message

 boot/image-fdt.c |  8 ++++----
 include/lmb.h    |  4 +++-
 lib/lmb.c        |  6 ++++--
 test/lib/lmb.c   | 12 ++++++++++--
 4 files changed, 21 insertions(+), 9 deletions(-)

-- 
2.55.0


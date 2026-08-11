Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B335C5AC67
	for <u-boot@archiver.kernel.org>; Tue, 11 Aug 2026 23:17:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 60F57608F4;
	Tue, 11 Aug 2026 23:17:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id P65-o1fDzfBD; Tue, 11 Aug 2026 23:17:13 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 27F84608DD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786490233;
	bh=zI4HCTs0ecWREoRYyYhJAX3AJ4TptSpbtFbPh/iYhW4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QfRtKCV9Hsr4OcsTRZ3F8qXZ/AEQFrb8pn5oiL7lp1CT6HQGjAgIlZ0hUhaA4z7Tn
	 0FiDD6sqcsfcA8l4SYDUVt83jlAuHg/nX6AjlOBpAKz2F8bDX6BoLzVC8YWPo3N1SA
	 nEQhkA/DWgbHYFgRHokXYVouWAAlcbUEVwo/yn/OJe3bj6EiwSEnwpdVU3W/dWj15q
	 +RWHoJ43NwXi4rDNMlWS3Ija15ROqzJZeGwTVCVV/TZ0S70VMFFYOfc1lcgYfcrnxu
	 5nq+xc5vNlLKtlWIf2FR8okDrFuEPXSXj2xDXIaW6diQzPxHj/MbDrl7sjSXO9l0wY
	 gEUwxVKs5bvAA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 27F84608DD;
	Tue, 11 Aug 2026 23:17:13 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id A81CD2E0
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 23:17:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8266581192
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 23:17:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nb_dxrOpFakW for <u-boot@lists.u-boot-project.org>;
 Tue, 11 Aug 2026 23:17:09 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.66;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=7f0c=gf=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 992C08112C
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 992C08112C
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.66])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 992C08112C
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 23:17:09 +0000 (UTC)
X-Forward-Email-ID: 6a7bad73a067a7a17f1bb5eb
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.66
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
Subject: [PATCH v2 3/3] boot: image-fdt: Restore suppression of irrelevant
 ERROR message
Date: Tue, 11 Aug 2026 23:16:49 +0000
Message-ID: <20260811231650.3150771-4-jonas@kwiboo.se>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260811231650.3150771-1-jonas@kwiboo.se>
References: <20260811231650.3150771-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kwiboo.se; 
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1786490228; bh=zI4HCTs0ecWREoRYyYhJAX3AJ4TptSpbtFbPh/iYhW4=;
 b=KNT5rfbCCVMNaH88TmQ7/rwp1xuylRNYTJ4xLHHBN8nUVRgjb3R3O6MDZjy5zaYUepppe4eO9
 hxwVH6zP/9IkEqx0iveafrZKw7eOP687M3NziQpHqXYB+bLGhMJzQLGmEseTYoUVCIYMTy5W4rs
 OeBV1IE0gA0l0uIjMZpwJKxXd3UOgVD1ne1v0ubtcw1R2bFifjuCGwttDnXHom/BjaRMQDnZmrW
 1D0mxVydfBpWShAwjv4bBIF6v9zL1E3KvO1gpYU4Rb+QQZ6mL8qe4AUe8dMx/tgsAqYGicpunty
 EA+J4GGu6S+iqmBbrGoxZDwH2SynFRjVAI06h84pQ7vg==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=KNT5rfbC
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

The commit 623f6c5b6ab7 ("boot: image-fdt: free old dtb reservations")
removed the suppression of ERROR messages when -EINVAL was returned due
to the memory region not being part of the LMB memory map.

This causes an irrelevant ERROR message during boot, e.g.:

  Model: Radxa ROCK 3B
  [...]
  ERROR: reserving fdt memory region failed (addr=10f000 size=100 flags=2): -22

or

  Model: Rockchip RK3288 Asus Tinker Board S
  [...]
  ERROR: reserving fdt memory region failed (addr=fe000000 size=1000000 flags=4): -22

FDT correctly contains reserved-memory for 10f000 or fe000000 and U-Boot
correctly does not make these regions available in the LMB memory map:

  memory[0]      [0x200000-0xefffffff], 0xefe00000 bytes, flags: none
  memory[1]      [0x100000000-0x1ffffffff], 0x100000000 bytes, flags: none

or

  memory[0]      [0x0-0x7fffffff], 0x80000000 bytes, flags: none

With lmb_alloc_mem() and lmb_free() both returning -EFAULT when the
requested memory region is not part of the LMB memory map it should be
safe to ignore these errors when FDT memreserve and reserved-memory is
being processed.

Print -EFAULT errors using a debug message to restore suppression of
this irrelevant ERROR message when memory region is not part of the LMB
memory map.

Fixes: 623f6c5b6ab7 ("boot: image-fdt: free old dtb reservations")
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 boot/image-fdt.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/boot/image-fdt.c b/boot/image-fdt.c
index 9e0e0f93edd3..956a3d97c420 100644
--- a/boot/image-fdt.c
+++ b/boot/image-fdt.c
@@ -91,10 +91,10 @@ static void boot_fdt_handle_region(u64 addr, u64 size, u32 flags, bool free)
 		ret = lmb_alloc_mem(LMB_MEM_ALLOC_ADDR, 0, &rsv_addr, size,
 				    flags);
 
-	if (!ret) {
-		debug("   %s fdt memory region: addr=%llx size=%llx flags=%x\n",
-		      free ? "freed" : "reserved", (unsigned long long)addr,
-		      (unsigned long long)size, flags);
+	if (!ret || ret == -EFAULT) {
+		debug("   %s fdt memory region%s: addr=%llx size=%llx flags=%x ret=%ld\n",
+		      free ? "free" : "reserve", ret ? " failed" : "",
+		      (unsigned long long)addr, (unsigned long long)size, flags, ret);
 	} else {
 		printf("ERROR: %s fdt memory region failed (addr=%llx size=%llx flags=%x): %ld\n",
 		       free ? "freeing" : "reserving", (unsigned long long)addr,
-- 
2.55.0


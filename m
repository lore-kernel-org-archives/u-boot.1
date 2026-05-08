Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6410CD3445
	for <u-boot@archiver.kernel.org>; Fri,  8 May 2026 23:33:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F22884CE4;
	Sat,  9 May 2026 01:33:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="TbTQ8x9G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5085484CF2; Sat,  9 May 2026 01:33:28 +0200 (CEST)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E1AE884CB5
 for <u-boot@lists.denx.de>; Sat,  9 May 2026 01:33:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7dcdaf06498so1895829a34.2
 for <u-boot@lists.denx.de>; Fri, 08 May 2026 16:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778283204; x=1778888004; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=lJWK+PNrSxeUwTYI4X1H/4cfXV3o/Oq1T+Ry8y+VPY0=;
 b=TbTQ8x9GVl4jjvfllGzP3VNSX52UzlRdaRA1ei6oLzROsUn+gQUhUmB4zwviDQ0CT2
 tw4AeOsMxBO7SH1KpFaeoFMzjKEjOzxt4f736KGCTNK4Yz3/+YlpOnKKUh0hZPV8tv7m
 xyjGqYQFlsnxaShV9kFnfsN8hVeBx0bBEYCAk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778283204; x=1778888004;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lJWK+PNrSxeUwTYI4X1H/4cfXV3o/Oq1T+Ry8y+VPY0=;
 b=aYeT7BkC58OQE1ZJKAyQdVozkFgwBJP3MuC6YtwFsSZgnMhs3v7fSRB/7Muz6Zv3yq
 aGQTO9cDaKG7FD/h+nqFXAsV2QKHSeXOi8zILyBnoa3lUjEZl23jq4tYXxQ3CTnxiNPI
 mwotzuX/Y+EYolncSW6WwJsN1+oq22hJTPFcHbSHPl1yWBxBG5KO2C0bk2O2wy5kJalt
 r/z3GGclAQ4qpahcA2chTEyZIqNp9jcXBJFqtbExhvk2m/kUBC8EwIWavfBBorQ0MXkP
 DhuuI3Yz9zjiI5jTdBulF+QhriPNI3lUg2ElH9dTTVAs/B3BBW83g9Jfv0yoj3Tf38rs
 U0eg==
X-Gm-Message-State: AOJu0YzZ3/F3ThSs+ZeviGzPqqity5HZDOHOjDjth3kVX7nOuyHtLkNK
 J/aq6S1/RuMG/X3e2LE/5HLtwCPYk2YzjXJIOMo0oBuzEbFhKTWEhtQ1H2H9K+wAXj5yCeGEWHg
 OWpqpBw==
X-Gm-Gg: AeBDiesV3Dx6AQFy7gOIm/1IzKdfFu4xglekb1o2nnovirxsfWafJ8PlZCYVk6FInQa
 sIQK7oGTcbHzUFBOxzy8OtOkjztNU00NVPFgOHcjc7DC2+SJjIw39md982vc4cHLevfNrWcn9rs
 H80wFN5/XhV6Q5lyxNXaR5F1bmkGTpEfA14jPc7OKDrRJ/kUB4Ih2a8RMZJmZm6+ynFWg1Ed1Pc
 0r+gnjTJkh7SvkWJISG+uJEnNXIrQDiUYEA3myQ8z8Pz3vTJ4Qc3axwxeD0o/SlZ7C6q7MZ+Zpk
 WX3YBsPqPiaW7cmVBiKTvD2bMuh5qfB10/Ag2H++KY1eFuErwxWewRn3evL1h/SUoaHv7YAC7v7
 PuuaFEmiYGo/DDf5qrE+lUWHn9yNyIl/qhJGNzLlRApPuIHqq6BixxX0jr2W3pYxtbDy+T/aAa2
 DhxxoWB8yYJ+YR80Po8N8qjr5YjIdmGeD7VbI49Vc=
X-Received: by 2002:a05:6830:4191:b0:7de:c87f:53f4 with SMTP id
 46e09a7af769-7e1defe7b29mr8749589a34.15.1778283203995; 
 Fri, 08 May 2026 16:33:23 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e367be2aa5sm1975933a34.4.2026.05.08.16.33.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2026 16:33:23 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Matthias Brugger <mbrugger@suse.com>,
 Peter Robinson <pbrobinson@gmail.com>, Stephen Warren <swarren@nvidia.com>,
 Stephen Warren <swarren@wwwdotorg.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] rpi: bcm2712: Extend DRAM mapping to 16 GiB
Date: Fri,  8 May 2026 17:32:42 -0600
Message-ID: <20260508233254.2022495-1-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

The bcm2712 memory map only covers the first 1 GiB of DRAM, but Pi 5
models ship with up to 16 GiB. Accesses above 1 GiB fault because the
range is not present in the MMU page tables.

Allocations above 1 GiB used to be blocked at the lmb layer because
memory above ram_top was reserved as no-overwrite. Commit 0efb6bc3e36d
("lmb: Reinstate access to memory above ram_top") removed that
reservation, so callers like tftp now route allocations into the
unmapped range and trigger a fault.

Extend the first DRAM entry to 16 GiB to cover the largest addressable
range for any production Pi 5 model. Smaller models are unaffected
because aarch64 only faults on actual access of unbacked memory, and
no peripheral region lies between 1 GiB and 64 GiB on this SoC
(peripherals start at 0x1000000000).

Fixes: 0efb6bc3e36d ("lmb: Reinstate access to memory above ram_top")
Signed-off-by: Simon Glass <sjg@chromium.org>
---

 arch/arm/mach-bcm283x/init.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-bcm283x/init.c b/arch/arm/mach-bcm283x/init.c
index 7a1de22e0ae..3d11c9e5c3b 100644
--- a/arch/arm/mach-bcm283x/init.c
+++ b/arch/arm/mach-bcm283x/init.c
@@ -69,10 +69,10 @@ static struct mm_region bcm2711_mem_map[MEM_MAP_MAX_ENTRIES] = {
 
 static struct mm_region bcm2712_mem_map[MEM_MAP_MAX_ENTRIES] = {
 	{
-		/* First 1GB of DRAM */
+		/* DRAM, up to the 16 GiB maximum supported by Pi 5 models */
 		.virt = 0x00000000UL,
 		.phys = 0x00000000UL,
-		.size = 0x40000000UL,
+		.size = 0x400000000UL,
 		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
 			 PTE_BLOCK_INNER_SHARE
 	}, {
---
base-commit: 3cdd19089f1b1b7cd08530f33ff4708abcfd426c
branch: rpi-us

-- 
2.43.0


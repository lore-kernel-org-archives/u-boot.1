Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70A49CA5FE6
	for <u-boot@archiver.kernel.org>; Sun,  4 Oct 2026 19:59:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EF32860705;
	Sun,  4 Oct 2026 19:59:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id z464PWSxhqJv; Sun,  4 Oct 2026 19:59:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 376866070D
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791143948;
	b=JqZkrOEH3D/rYA1Q1VNplbssgyG5RPhx2tGaE/jellqx/HDn8jShrmONionItYfKNhn7
	 qsHMQzfTtoQRpZxt/pr2udbWP2qUPkRwqAgu6bCp0H9qLMgE7z+r9iw62yb6dJqntoL5j
	 vCMJZDf6YboK3nVQcCInpHPy8qCoy34FS5Wg6Fu8q3QHQr6+/e4q1GSe2lFEZKwoGoj2L
	 1gADjnq3FjX/G5Qn+1Bv5Ookh03QryT2KcgiujrM9aTu1Ho/6R9hrzUL0I/xWcdgEXmu1
	 VUFH7Ow2Qy1eDCYqZJqbllQc8k/xSqDdulR9/lTUnsy51hneWD+ALh10oNrqONEgkBw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791143948;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-Forward-Email-ID:X-Forward-Email-Sender:
	 X-Forward-Email-Version:X-Forward-Email-Website:X-Complaints-To:
	 X-Report-Abuse:X-Report-Abuse-To:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=75ACF+g3K4m8R/wwGTue9ardUsV9VZ2n49gEMmDT7bA=;
	b=Fx3XbwRBz2WTMGOBmOCjeyhEVJSmi4vu1RbKRujncR5aJnOs3KQJti5BD9r8uxzVTXOa
	 Wn6wNoMQCMgcwFzPvjYFgbvfVtyUspYhJxBQgvo2QgVOkMF30KQp5d+yCyijpN1sOk00W
	 cKs0a3YprtwPj/w2kZ4CAtz+kUCzF83TgSlLfZpV2uJCZLypanmYrfFFdKhZx+bty6HsA
	 YZE5Z2sQi6g8tpApP/PFbYenIYXiALMcF/OmvQ8X844ITJTNYO9gj0h8G/mJNYszpC7Iw
	 4uFRPVS7iiJ9/QKxrBpzv2PC2Zj1xinNorIcU1DDXSJhwlb64JQnqPvX2dLVLYsCGLQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791143948;
	bh=75ACF+g3K4m8R/wwGTue9ardUsV9VZ2n49gEMmDT7bA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XUdEh5udXQ/Kklgp+cxMGCVa2v5CBWDTlFK2oXgQlEa6bAimGLnyyu6OTVUqDfwyb
	 ANH414N2A6d5SAkitEn3PHrbkL6fTQb/ao+0iqlfLDjfhI684QuYCSP6jFPbareYK8
	 zwIz9VJqcizM7LXcDu+v8Bkst6DD6BIIWP01ouWSJCn04gh8TwdAY3+lJdaPcA/Jmg
	 Sp+fdo916nF4h2mCCiV7UlCnSq/WTV7lE8NNKJRFeMA3brlXfeT84TjLmrqR7i+wTK
	 04QbUV/npUXI6oiN3DZoH1fuod/6IubOt+ids3GX20CFcV/1Bkdg6TYSxW+ua+03lz
	 VXta52rPj0TWA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 376866070D;
	Sun,  4 Oct 2026 19:59:08 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 4D2DB323
 for <u-boot@lists.u-boot-project.org>; Sun,  4 Oct 2026 19:59:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3F505400C8
 for <u-boot@lists.u-boot-project.org>; Sun,  4 Oct 2026 19:59:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id D52BlobGlWOv for <u-boot@lists.u-boot-project.org>;
 Sun,  4 Oct 2026 19:59:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 598E840075
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=121.127.44.73
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791143945;
 b=mvoXW0tRiU0cqPQE1ttNFDjAaML9bL2lNNWFd6LKQQ9Lfo13Y75IWwthFHUl8nKsrPxH
 us6WqJeRYftQoXzuNCVMHRZxio4kail3llXGEfqbUqIO3sZbKr8DTecRtp1yNCu3ZQO5h
 K0/7hrgXRsVfB4Jm1OMCPQd2R9wcYFSNTyHTbx9bthU60pG8HRH1Hdyyr+NvJ+YJcJeku
 /csazCwKzZxmOGluTpJ9z0RCJi7Nl8g5y9H1AdLbcGQZL188IuldMBfFSVZWjQd7TtjCm
 dZhB4mRYOu3G7xhro9hIbDHU7ZdUCwS4EpTwT6AeyBjxBeitd+sH5N2j0qWKilxaZ+Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791143945;
 h=Received-SPF:DKIM-Signature:X-Forward-Email-ID:
 X-Forward-Email-Sender:X-Forward-Email-Version:
 X-Forward-Email-Website:X-Complaints-To:X-Report-Abuse:
 X-Report-Abuse-To:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
 bh=75ACF+g3K4m8R/wwGTue9ardUsV9VZ2n49gEMmDT7bA=;
 b=EkmlaPD/KRcFliRiJAWx4wg0A5j+aHbliP3fyi3HnP1nft6jmpYE/U8BdREbJt3fL1qT
 QkLe6O8I9TYs3upT2Wb3OUmqYfFpUmb/1xE1iUh5z4Ew3Wh64HsthNx/mAdS/pwKiUfWA
 0RR+VwfiTATlWdVmSJjAGACeavpZkdw3CsDNe93H3pxky3SIYB7jeg48tY4uhH9A2rnsF
 b0CQFm1WVP+KFCEGZgEQo/VbSWZ1bmlQKkO6F5RGvkJYjlpAaiX69+iDG8N/MRXQmjzVu
 YHhOoUIVRb4NZWZ+ceNWrfHvO7ca0ZCee7aVGZcXxMxR2QwBhAiw63Mc7LopteDEwxQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=kwiboo.se; 
 dkim=pass header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b=L+YGCz3u; 
 arc=none smtp.remote-ip=121.127.44.73
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.73;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=8573=h3=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=L+YGCz3u
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 598E840075
 for <u-boot@lists.u-boot-project.org>; Sun,  4 Oct 2026 19:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1791143944; bh=75ACF+g3K4m8R/wwGTue9ardUsV9VZ2n49gEMmDT7bA=;
 b=L+YGCz3uJ5h0885IXdQJBFQiwKfytk1YD/UezwEn6r6k64Q2V1sH0NMCWU5H8D8nh09mPnWqS
 /bgGONqz3UkAJBGFXj37KQQhccqSoBukRWi6rzPYUW0EoI4VWhIZuH0cbmKKvr8n0KEzSZJ4QCz
 BU9hhrovycZQF68yTwYat/Qz5/zosy2Yr53R3mSpoqCxb6imYHuMRzj3EeGTicIvXvOWBMqtSrt
 TJKdNJIqEuYHrgIacHlPBPKcoSPBvoNWvW+cWH/iw7W17FBbAPKqlaohnkX23O2YO0CQFY7a3o5
 YgqCKK2SwExziuAJtV7QTfpvWTlcZOWt3JE/RMAz2thg==
X-Forward-Email-ID: 6ac2b004550bbe43c208e0bc
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 2.18.1
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 2/2] rockchip: mkimage: Update init code size limit for RK3328
Date: Sun,  4 Oct 2026 19:58:52 +0000
Message-ID: <20261004195853.59863-3-jonas@kwiboo.se>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261004195853.59863-1-jonas@kwiboo.se>
References: <20261004195853.59863-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The RK3328 has 36 KiB SRAM at [0xff090000, 0xff099000). With 4 KiB of
the initial SRAM typically reserved for BootROM during early boot.

BootROM will load init code of up to 32 KiB (0x8000 bytes) to address
0xff091000 in SRAM, before jumping to it.

BootROM typically jumps to init code with following registers:

  x0: 00000000 ff091004
  x1: 00000000 32334b52
  x2: 00000000 ff520000
  x3: 00000000 ff500000

  sp: 00000000 ff090f50

mkimage is enforcing a 30 KiB init code size limit for RK3328.
However, the BootRAM can load up to 32 KiB of init code.

Change the init code size limit to 32 KiB using the <size> - <reserved>
pattern to closer match the actual limit of BootROM on RK3328.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 tools/rkcommon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/rkcommon.c b/tools/rkcommon.c
index ccd1cb5b1ef6..cb904db20b4e 100644
--- a/tools/rkcommon.c
+++ b/tools/rkcommon.c
@@ -145,7 +145,7 @@ static struct spl_info spl_infos[] = {
 	{ "rk322x", "RK32", 0x8000 - 0x1000, false, RK_HEADER_V1 },
 	{ "rk3288", "RK32", 0x8000, false, RK_HEADER_V1 },
 	{ "rk3308", "RK33", 0x40000 - 0x1000, false, RK_HEADER_V1 },
-	{ "rk3328", "RK32", 0x8000 - 0x800, false, RK_HEADER_V1 },
+	{ "rk3328", "RK32", 0x9000 - 0x1000, false, RK_HEADER_V1 },
 	{ "rk3368", "RK33", 0x8000 - 0x1000, false, RK_HEADER_V1 },
 	{ "rk3399", "RK33", 0x30000 - 0x2000, false, RK_HEADER_V1 },
 	{ "rk3506", "RK35", 0xC000 - 0x1000, false, RK_HEADER_V2 },
-- 
2.55.0


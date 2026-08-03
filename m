Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F83FC55822
	for <u-boot@archiver.kernel.org>; Mon,  3 Aug 2026 19:10:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2606C606DB;
	Mon,  3 Aug 2026 19:10:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6LNYw173hF0T; Mon,  3 Aug 2026 19:10:00 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 04602606B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785784200;
	bh=7DIdnUwyuE9P9CH/KR6tfF8MmCkeoXgtxmnwci8kAd0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=D1yfGqQ5JzgmUg92pY0KcVe4hDl5zHM4DV3O5wq15KIKraGpPg3Mcfb9WOp3UDJ8m
	 nrE9HSrWm+YSKGb1/Wj5eu2b3UdHNgpULbg3KPbGr+JzTy9TOUMKfkyTUgzWs1JdAO
	 IQReKx4Uc39YsXuB6fqlofOzVbGOR5eVotQgzHOK8xBPqAQo/IPQ/i3Ds+iaz5xGOx
	 SA8pyIqASECwLiSrIwvFxE1M2Br7pKiJgS3217XF9Vuh5YcbN/koLvdl81vUnBXwYM
	 V9DukaxIHxjAUv3Smc9smqmih8ojwArV/sRZluQ6kVmVJtqeef2AdqewQKvnXpotDe
	 spD7nhF0KzovQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 04602606B0;
	Mon,  3 Aug 2026 19:10:00 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 4C86B296
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 19:09:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3E1F180BB7
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 19:09:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8FtmXFN1mmjA for <u-boot@lists.u-boot-project.org>;
 Mon,  3 Aug 2026 19:09:56 +0000 (UTC)
X-Greylist: delayed 1594 seconds by postgrey-1.37 at util1.osuosl.org;
 Mon, 03 Aug 2026 19:09:56 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 2BB8A80B03
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2BB8A80B03
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.66;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=eb25=f5=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.66])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2BB8A80B03
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 19:09:56 +0000 (UTC)
X-Forward-Email-ID: 6a70e782ae1ce3dd2fb7e578
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.66
X-Forward-Email-Version: 2.13.2
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.u-boot-project.org,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 2/6] rockchip: rk3506: Update ENV_MEM_LAYOUT_SETTINGS
Date: Mon,  3 Aug 2026 19:09:40 +0000
Message-ID: <20260803190946.2259514-3-jonas@kwiboo.se>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260803190946.2259514-1-jonas@kwiboo.se>
References: <20260803190946.2259514-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kwiboo.se; 
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1785784195; bh=7DIdnUwyuE9P9CH/KR6tfF8MmCkeoXgtxmnwci8kAd0=;
 b=Ntpt8HDswEPCRQ/OAPpuSNqpxhoQo753iSR0eymzkarrioo3IQOqmJI9YV+aiS5m6i6eQFotz
 xZ64b/pfXnEqK66YcQ+t6XGGcd6OYHqnRwD61f57Y6ySjDdLE41/jff1zjAeBIES0RcNfhdXcme
 kYB6JyQo2LBFc72bnhAfE4419Qy6n8IOMR7cR1e8zLKGWnw5OqnCkcbsRM9AamNxDPVsjdHHIlF
 ZIGcJDejUJW+9NCxW2ll6sO4FdgKdNCy+9HVb73i38m4NneFUHShjOjwhG7Wm8Dw2I6VAhN8k+R
 Xbx4O+f+oo0fCxOEko4XygPfyf8+ABoYDq3MsrvAYktA==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=Ntpt8HDs
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

The RK3506G1 has 64 MiB integrated DDR2, the RK3506G2 has 128 MiB
integrated DDR3 and the RK3506B support external memory up to 1 GiB.

Current memory layout cause issues using compressed kernels or ramdisk
due to the default load addresses being used.

Change the default load addresses to also work on SoC variants with
limited memory, keep all default addresses in the 0-64 MiB range.

			 old		 new
  scriptaddr		5 MiB		2 MiB
  pxefile_addr_r	6 MiB		1 MiB
  kernel_addr_r		32.5 MiB	8 MiB
  kernel_comp_addr_r	128 MiB		48 MiB
  fdt_addr_r		30.5 MiB	4 MiB
  fdtoverlay_addr_r	31.5 MiB	6 MiB
  ramdisk_addr_r	96 MiB		48 MiB

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 include/configs/rk3506_common.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/configs/rk3506_common.h b/include/configs/rk3506_common.h
index 5e4ef67289f0..210549504855 100644
--- a/include/configs/rk3506_common.h
+++ b/include/configs/rk3506_common.h
@@ -18,15 +18,15 @@
 #endif
 
 #define ENV_MEM_LAYOUT_SETTINGS			\
-	"scriptaddr=0x00500000\0"		\
+	"scriptaddr=0x00200000\0"		\
 	"script_offset_f=0xffe000\0"		\
 	"script_size_f=0x2000\0"		\
-	"pxefile_addr_r=0x00600000\0"		\
-	"kernel_addr_r=0x02080000\0"		\
-	"kernel_comp_addr_r=0x08000000\0"	\
-	"fdt_addr_r=0x01e00000\0"		\
-	"fdtoverlay_addr_r=0x01f00000\0"	\
-	"ramdisk_addr_r=0x06000000\0"		\
+	"pxefile_addr_r=0x00100000\0"		\
+	"kernel_addr_r=0x00800000\0"		\
+	"kernel_comp_addr_r=0x03000000\0"	\
+	"fdt_addr_r=0x00400000\0"		\
+	"fdtoverlay_addr_r=0x00600000\0"	\
+	"ramdisk_addr_r=0x03000000\0"		\
 	"kernel_comp_size=0x2000000\0"
 
 #define CFG_EXTRA_ENV_SETTINGS			\
-- 
2.54.0


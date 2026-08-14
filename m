Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF280C5CFC1
	for <u-boot@archiver.kernel.org>; Fri, 14 Aug 2026 11:21:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9674F811C6;
	Fri, 14 Aug 2026 11:21:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id E2NX5CAVwDA5; Fri, 14 Aug 2026 11:21:39 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 95B0C8123C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786706499;
	bh=Vi1VHTjPeRf8Z94+H10WxltCi9zA3eGR7xJDaRqXCAo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SYfj5k+tKlz01u8IxTkPxhyevSpvZBD4y3BYsyONStfuV6pj9dFKMd5L2wJgQ28H6
	 NHYKG0M7C2ilWm3e/okK2tb9jE9Y/7j6StCqrGpHaGrpEluVhQA06TjFJ+XO6gkWav
	 Kjk02d3cArFvi/lKGEgkmRa+Vlh8EwYIGHHcXc3AqCIcW11dsJAZ1WLMS7yBmB8XxG
	 dFiGeGgqawyna3OrjErs7p4T3jYGVdLPiva60JvkG1nINehOedUj+agHhpiYBgPxrL
	 7RuYSx9MjfiFkOaj5Q8Y3E4P/5D2olVupdgboi8QFqvkXb4UbOdkBvdlVdkQm1I29T
	 ejjPxxEYAWKVg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 95B0C8123C;
	Fri, 14 Aug 2026 11:21:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 1ADCB3A0
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 11:21:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E1B65607A0
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 11:21:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IpyDh5jIQU9f for <u-boot@lists.u-boot-project.org>;
 Fri, 14 Aug 2026 11:21:30 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::334; helo=mail-wm1-x334.google.com;
 envelope-from=fra.schnyder@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 1E8E36060A
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1E8E36060A
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=h0RKfEA7
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1E8E36060A
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 11:21:30 +0000 (UTC)
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-496bb7cdf51so12393905e9.2
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 04:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786706488; x=1787311288;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Vi1VHTjPeRf8Z94+H10WxltCi9zA3eGR7xJDaRqXCAo=;
 b=h0RKfEA7GztYJBkA61jrkquJObbFcqGVVF9sQnvYrIovEYGRrA6RoXgZQgCYegb99E
 z7H9hYufv+Mabp+Q5usSfFtJkjC3VkgXyodZ7Rc8O1IRdVoQZY0mxxQL7lKNr16JgtwD
 FRE0XMlyk/vMB6nS1DEhyRKhAJRbG+xNCqq94rQb+fWqfaHsIWimpXXP8dwr2tO/pxqW
 hPAN5KtjE5aZs5kam1xciLwMMyLatGTflyaXUfPQr3jNSf/wjJdu4r1SOxPNXsykFhwR
 ZPlNIGHbLv/Gbhwci7miryTVuTI8k7HD+QaZcqdh9TcX8h5IvP4kMw2CPQcjlJiQUV2g
 OnEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786706488; x=1787311288;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Vi1VHTjPeRf8Z94+H10WxltCi9zA3eGR7xJDaRqXCAo=;
 b=iw5esHjEfnOK1cXmH7u/DeSgPj1dDpHrNGBG84SBHqAemRG6UA/CpinogUXbGYSAy6
 fWvJefdPxOjN8f88R98/Os124bXeodGDChmpniDVcc14BPo3tc0R/04rw/l/IYKGDPxB
 7zJksdDoUurgjZ1uCj91Glm9CyxRGBEP9eMZXihfsNutGWzGVZtQqqgU1QMuI3GgAMX4
 Hx97XbjD+Xh/4oDLCeICOGu7FLfxYHd9Lwa1+aQxBUfGEqe1v91eyYE6mxBACvMapV83
 M6IN61vVHd1AA/L9sPhLbr2+dT6DEe+IfK2of8zWXZpWFzP0MD587sEBPoD1SeuovmF3
 G4kg==
X-Gm-Message-State: AOJu0YwVqpGF0SrjA988C4cMJXNmUPXeZOaqEncLT8eTCafqeHeU+MTV
 RGBrGEZDgIVRl9gar467LO0WPxIslAvj6yZixfRiFl3js3bvkRqBFVFO84F+w1jc
X-Gm-Gg: AR+sD10GCkkMHQrBnIogU1+p5Jm8WYg1sNMt9p6DhcIR11ujzayU5B6v4W8E7gq6m3P
 gnaTL8EwrcP6Qo/w5TjnwitzMN/hXLaG2f1QVd9bNVNQ4aIIKh84CFsRupRiaWgEhBW5s8wJGtc
 y/pZRn40iZcWH5pwFdR828zm0eXUJB7jTK3ez6mdZNqRejwTZ3Xd0k97FvykzZRw07X0NGzIOfX
 rH0F4rFYgRK3EFuboXlms1F1uf0PF1xq9HZyX4S4LmwBeIYrwBLG31KJZHIXI4n4vbbXpX8qJS1
 tiErVSkTRw7w/9y0cD5t8B2rYCL+WMFCStHds/wxJgMduCRjIBSuH7wy8F1pW4w0DJ+oQHxrAe0
 1CQ8IEJb/smm26XPh3t6zqJEu9zHWRIuYUK5JCYgSeYcG99eX9kgoFlIXdtlp0eiFm/dWNnuQYW
 V/WFErle45jUc9TS+CJK9T2xicr/Dmr4B275hHAn+Q5HkLW/iDdt+RT1F3JHRmATPiOYdasg+2Z
 jX8CT4u9t1IKlSmI/JkFbajF0Q1ZIe6eTuCgdIr0SE5cMdzOv2c+sq4LaRpoHcNyFzjg0ZXrH5F
 0Zk0uDxqddn2E9rmCHB4C2vh4cqqTlXzq84p3Q==
X-Received: by 2002:a05:600c:3113:b0:499:83f1:398 with SMTP id
 5b1f17b1804b1-49987977373mr61633985e9.9.1786706487836; 
 Fri, 14 Aug 2026 04:21:27 -0700 (PDT)
Received: from [127.0.1.1]
 (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch. [83.173.201.248])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49988b2a509sm41692355e9.14.2026.08.14.04.21.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2026 04:21:27 -0700 (PDT)
From: Franz Schnyder <fra.schnyder@gmail.com>
Date: Fri, 14 Aug 2026 13:21:23 +0200
Subject: [PATCH 8/8] toradex: tdx-cfg-block: Remove product ID limitation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260814-get-rid-pid4-table-v1-8-b8605ac094d0@toradex.com>
References: <20260814-get-rid-pid4-table-v1-0-b8605ac094d0@toradex.com>
In-Reply-To: <20260814-get-rid-pid4-table-v1-0-b8605ac094d0@toradex.com>
To: u-boot@lists.u-boot-project.org, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Tom Rini <trini@konsulko.com>, Fabio Estevam <festevam@gmail.com>, 
 Franz Schnyder <franz.schnyder@toradex.com>
X-Mailer: b4 0.15.2
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

From: Franz Schnyder <franz.schnyder@toradex.com>

In the progress of decoupling from the Toradex product ID table,
the implemented product ID limitation is now obsolete, as no new entries
will be made to the table. Therefore, the implemented limitation logic
needs to be removed, as otherwise new PID's written to the config block
will be assigned as unknown.

This also means that `get_toradex_modules_idx()` is now obsolete and can
be dropped.

Signed-off-by: Franz Schnyder <franz.schnyder@toradex.com>
---
 board/toradex/common/tdx-cfg-block.c | 21 +--------------------
 board/toradex/common/tdx-cfg-block.h |  1 -
 2 files changed, 1 insertion(+), 21 deletions(-)

diff --git a/board/toradex/common/tdx-cfg-block.c b/board/toradex/common/tdx-cfg-block.c
index 9ddb944fc42..f01f3ea68f8 100644
--- a/board/toradex/common/tdx-cfg-block.c
+++ b/board/toradex/common/tdx-cfg-block.c
@@ -229,20 +229,6 @@ const u32 toradex_ouis[] = {
 	[1] = 0x8c06cbUL,
 };
 
-int get_toradex_modules_idx(int pid4)
-{
-	int i, index = 0;
-
-	for (i = 1; i < ARRAY_SIZE(toradex_modules); i++) {
-		if (pid4 == toradex_modules[i].pid4) {
-			index = i;
-			break;
-		}
-	}
-
-	return index;
-}
-
 const char * const get_toradex_carrier_boards(int pid4)
 {
 	int i, index = 0;
@@ -416,7 +402,7 @@ static int write_tdx_cfg_block_to_eeprom(unsigned char *config_block)
 
 int read_tdx_cfg_block(void)
 {
-	int idx, ret = 0;
+	int ret = 0;
 	u8 *config_block = NULL;
 	struct toradex_tag *tag;
 	size_t size = TDX_CFG_BLOCK_MAX_SIZE;
@@ -484,11 +470,6 @@ int read_tdx_cfg_block(void)
 		offset += tag->len * 4;
 	}
 
-	/* Cap product id to avoid issues with a yet unknown one */
-	idx = get_toradex_modules_idx(tdx_hw_tag.prodid);
-	if (!toradex_modules[idx].pid4)
-		tdx_hw_tag.prodid = 0;
-
 out:
 	free(config_block);
 	return ret;
diff --git a/board/toradex/common/tdx-cfg-block.h b/board/toradex/common/tdx-cfg-block.h
index 32305c61c83..c712fad30ac 100644
--- a/board/toradex/common/tdx-cfg-block.h
+++ b/board/toradex/common/tdx-cfg-block.h
@@ -188,7 +188,6 @@ extern u32 tdx_car_serial;
 
 int read_tdx_cfg_block(void);
 int read_tdx_cfg_block_carrier(void);
-int get_toradex_modules_idx(int pid4);
 const char * const get_toradex_carrier_boards(int pid4);
 const char * const get_toradex_display_adapters(int pid4);
 int try_migrate_tdx_cfg_block_carrier(void);

-- 
2.43.0


Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1B15C982D2
	for <u-boot@archiver.kernel.org>; Fri, 18 Sep 2026 03:16:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6825660BF2;
	Fri, 18 Sep 2026 03:16:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uzt0zp3ksFJh; Fri, 18 Sep 2026 03:16:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org A4AC260BF1
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789701395;
	b=oR9OgpZGDOvLkbNBjUgrTAwBxeXtFKIT5D9O1s4kiyvFdym1UMqgeWTQhqYBorUV4mM/
	 1P2egDQJHTruG+HMOxoG8jXYL7wK73Xtwl8VCF/ZMn0Cf4tcYxk6MjW+7U0aroMAzb1Ck
	 t6jvrtgAaQ+y4S+WwFBN/j8VJWCPm8CBgFWzmeiLMCFIOvA/gSSgvSE870tkFJ7TfY8m+
	 xN8S7iAxUoermA52/WF4cS/SNOMRIlCrvW8o1xaujwNYn7Z9fzaM1kQTol7Vk31N9Lpsp
	 G07pT94shyN12zEHBAjT3JkBuBGMj4zFo42K/xmIhlSWZm4dYnMYxyYjo6tYGvQGgaA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789701395;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:
	 X-Google-Original-From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=3pkN2fZXq7RGg5QDmbJNkLZpgp8XEmuwO1YZvXiHTJc=;
	b=sGlvSV2wnAEDec9g7TAYRY93rKSk5SF7c2fXG0V7E60ssDtWwYyn+r6pS1ZfA9BNBY6t
	 UwI8X9+6EBrzIFjIfhPSG8jnNNqV11xEtVmfeAhX/zRZRGfA0XC1qDE57jCLqrnHtHon0
	 UvnNN84f1Cheps73k3tZIKhD3b+PHVE3d++8f/I6F4aqSs8W+o1KOVJRkX/LKkFve5sM6
	 vaaLHe6X9Ef1qNWjUmT8qdIOT/gwOlxKrcwfuR8Smznuo1FU4IlRgIfUb/UOoVlyg0E9F
	 xbvuy9MS5J6OwpTO7BQnzu5ZALh5SsSzAY+s5g0Q4fVc1FLwZtPjdZfZeiyXApd+jfg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789701395;
	bh=3pkN2fZXq7RGg5QDmbJNkLZpgp8XEmuwO1YZvXiHTJc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lT9ertIIzRv388E6f+fBGFRAu52o4+vtygD9q0xVmtCm9t69p22mj5/h2NllAtdu6
	 z6Hb0eH9tballjphaxpfrGHQqpblrMzqXbp48mVgdSiY0F3hqcpE/3dSWJqn4Ji3GC
	 PuOoxZtmTet0c7Wjn9yN+zhg2wD8h6yw5jfB/iPZMulztKjlp01tlAT6VGI02EgEFF
	 DK9JqZgUJofGgDv0OeMwhIBRIhBcQexg/E8Uh+tMNfu1YZi6GoAuJKAxlhTNTEkDan
	 W3rCKap+sLvxw0358MXjrw8WytecDWX+YjdpZJggNUYtfRB/Qc+ZIHNabjEZgfBh52
	 1oc6zobJ3qliA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A4AC260BF1;
	Fri, 18 Sep 2026 03:16:35 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 82F6129B
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 03:16:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 754AB81189
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 03:16:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FJpUoKgGp_jc for <u-boot@lists.u-boot-project.org>;
 Fri, 18 Sep 2026 03:16:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org E4FE5811AD
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:39::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789701394;
 b=KPmIZtPX96pQ4f6Z58jAWhhG510ekCUI+bRMUV90rs2/viNAdH8+IQtmAFguLnDV6pHO
 /bLa4XKE/lMwTY5FK3bwKsU/08ApWB2FufZ6pTR2g4hxW+MN9mQz4HJkSyps8jXOFJVUF
 /LNJJabK70jy+5ICtg/2AIwOUtISl+oheo8GnAlJm9hqGIde4syFas6L5rHYB2TXj/SU+
 sP95oUyXv5sgxPgNoQrHjCvOq3bph0K2ISTRTyzGVeXUFlAKls0GfxHIcAkocqfBrPs7h
 AWJ8bISFl8cLD4JhVyfr9tnFr+0lizQFkA5rn1Qj3efZ6cbvJU2oEC8b6tCPRaTI5Dg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789701394;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:X-Google-Original-From:To:Cc:Subject:Date:Message-Id:X-Mailer:
 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
 bh=3pkN2fZXq7RGg5QDmbJNkLZpgp8XEmuwO1YZvXiHTJc=;
 b=HTM6Lmq82GBDUiLsJeX5vQPV/qgL9lluSgV7QCcrAhfnD0LYgBTezY7mPB0Qfe2U+AbP
 HqoFFatwTZiqngiQ8AMhZ7b8fXE1VmI/r9o5fRWoX64Kn065ELv5Mh32sUeEdEWEhCr7o
 puNEQNexuKbarfPq2WM9UnFco/j/9ZWiFVHSCdNJJlhrjBiTHN80PX63KACHNKDRrbcI+
 grwATEPI8tSxBG68BSr+NjTTUTs07JuOKA/0XbukDcAGBq6szceAPvQcKqFKfubKc0cDZ
 Jr5aXVp7o7CTuZ1wQcEOtnT3HC1/TB2ZQYbfUPNwh5lY9MplCLG244DYeV3bdoqN/1w==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=gks5LYeY; 
 arc=none smtp.remote-ip="2607:f8b0:4864:39::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:39::10; helo=mail-pj2-x10.google.com;
 envelope-from=jim.t90615@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=gks5LYeY
Received: from mail-pj2-x10.google.com (mail-pj2-x10.google.com
 [IPv6:2607:f8b0:4864:39::10])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E4FE5811AD
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 03:16:33 +0000 (UTC)
Received: by mail-pj2-x10.google.com with SMTP id
 d9443c01a7336-2dd77300816so533485ad.1
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 20:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789701393; x=1790306193;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3pkN2fZXq7RGg5QDmbJNkLZpgp8XEmuwO1YZvXiHTJc=;
 b=gks5LYeYSu3Xt51q97RNBjFGmHFmZEjCIp7HDKSpUrRG54iDWOAB8fYyXY7z2u+Mr9
 tXD4tAdvunh89oXkT+52uO3drBkTSCBVGQcHheQIG8z8M5+97HSWd6zMyhJHSoTGH0Xx
 iKNoyQUVMj7S8o4u6faI1+ZWkC4OnkfohjOJqipw49i4moJhyOPOcWWIH3BvEj6M3BC3
 loORu17w56bzCPqlexquGF0ftqDT+k60oWqDeb/T2EKpKlF1fxGPX7oqzN2B56z7sxnI
 E82XPTDs/yLndsYcMIF3ynarOGJaO/+/t0qYDYL5lASaLyMc4P2/6af+3gQ7lERVKDrR
 LCbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789701393; x=1790306193;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=3pkN2fZXq7RGg5QDmbJNkLZpgp8XEmuwO1YZvXiHTJc=;
 b=sHbNHIGkIoLBsJ3qI3ng2h9+eOGI0bWacqcg8NY+nUPcqEQCTXed7UyyIC+3PXT4b7
 Onh1CfmejAbkRTkkY6GjOm2aiWAKmVi8EkOMhUt+lnb5N7Iv9/g1T68XHPBVQvSnu0H5
 OSpo0hPvJiO5EW8lZ4H3aCYP0zEJrY8ZybtpsFF27oCVNNtH54/g97heg0D5KqhpsOxB
 tkT5y0at6BkDTkVa56myjN+rSdT38TeYFUc8SsnemMa+gUOphQAsV4RsYPHJxtN/IuBw
 nLo9ZGfHaNCdGYT8U+zihYAsXsV9PZHme7P5VgXRLFnU3ITWKBQh2Izj4knIkWFeid/q
 nBEQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBz4TmcUxjLdlCoE9XcqCiek0RVJ9kRDO0wjFVJeVpBjdiHKbXpVhlpCaXpicShgveolr/ca/Gw=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++keqFJaYwylikzeSIN0Eb6fIay9TBGIlf7C/SONnXlM/Hkwi2xN
 Ft6bA6JPiYjfuEpqbEjllw9VoCRGmnOucVdOJDSwAW9ez5RpvbzU9Sfw
X-Gm-Gg: AYBFou0Ro388MPAN/wyxNPvl2d4iFB7rvbS6yvgGcHctdpaYnV1GFxF2Sg1MY5FUMc7
 emPR1Z2SDUtTojR92Ym6IIQEKH5jtxtZgzQfyH2d24KxKlEcRUWmd3oFj2ZffKxcfb/grqvMW3D
 oziaR4ewm6z6y5yij2BX3hHYuI7WEk5yZWfpqQLyYDNjObxFDq+CFuoHkCBt2BaDRl6M5q3PZxG
 p7UDWBmy6C7CRjeSsFzCFUQVVzZ7Q9Oese0MvjttwRtmzTfoDq+Po/5AQjTTcQPa5dnUzv3TRD1
 aPcBXH7FTsSCz2C37Ylm1Z+LuS+McpTn1zfXQd9tGWWAdEcyDtChG3qpKBEcgDbhKdnfBbC+STr
 7s6U9dx08JHrqE2zwNcwGvXvfnM7U2aUVxSNvfc/Kk0fa1JKZHgzIwGoM43cb3uKqN/1EIcW+I1
 rbb3qDzgBvclL1EOqTeTHIsbq0lAmaiG467auJCvzGsjC7m/zRg+NHr7UBzGSTbcdNh04EGwfeI
 saYpW+S
X-Received: by 2002:a17:903:1b63:b0:2dd:68a7:d853 with SMTP id
 d9443c01a7336-2ddb2146bd6mr14792345ad.9.1789701392601; 
 Thu, 17 Sep 2026 20:16:32 -0700 (PDT)
Received: from cs20-buildserver.. ([2402:7500:500:6259:4c39:1ad1:29eb:e47f])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ddb75b53fesm874505ad.59.2026.09.17.20.16.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 20:16:32 -0700 (PDT)
From: Jim Liu <jim.t90615@gmail.com>
X-Google-Original-From: Jim Liu <JJLIU0@nuvoton.com>
To: JJLIU0@nuvoton.com, jim.t90615@gmail.com, trini@konsulko.com,
 dhphadke@microsoft.com
Cc: u-boot@lists.denx.de, u-boot@lists.u-boot-project.org,
 Stanley Chu <yschu@nuvoton.com>
Subject: [PATCH v1 3/6] board: nuvoton: arbel: Configure GFX interface
Date: Fri, 18 Sep 2026 11:15:51 +0800
Message-Id: <20260918031554.1855939-4-JJLIU0@nuvoton.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260918031554.1855939-1-JJLIU0@nuvoton.com>
References: <20260918031554.1855939-1-JJLIU0@nuvoton.com>
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

From: Stanley Chu <yschu@nuvoton.com>

Select GFX_PLL as Pixel clock source

Signed-off-by: Stanley Chu <yschu@nuvoton.com>
---
 board/nuvoton/arbel_evb/arbel_evb.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/board/nuvoton/arbel_evb/arbel_evb.c b/board/nuvoton/arbel_evb/arbel_evb.c
index 17728f8435a..aa2bda25e79 100644
--- a/board/nuvoton/arbel_evb/arbel_evb.c
+++ b/board/nuvoton/arbel_evb/arbel_evb.c
@@ -6,10 +6,14 @@
 #include <dm.h>
 #include <event.h>
 #include <asm/io.h>
+#include <linux/bitfield.h>
 #include <asm/arch/gcr.h>
 #include "../common/uart.h"
 
-#define SR_MII_CTRL_SWR_BIT15	15
+#define NPCM_CLK_BA	0xF0801000
+#define CLKSEL		0x4
+#define PIXCKSEL_GFX	0
+#define PIXCKSEL_MASK	GENMASK(5, 4)
 
 #define DRAM_512MB_ECC_SIZE	0x1C000000ULL
 #define DRAM_512MB_SIZE		0x20000000ULL
@@ -22,6 +26,18 @@
 
 DECLARE_GLOBAL_DATA_PTR;
 
+int board_init(void)
+{
+	u32 val;
+
+	/* Select GFX_PLL as PIXCK source */
+	val = readl(NPCM_CLK_BA + CLKSEL);
+	val &= ~PIXCKSEL_MASK;
+	val |= FIELD_PREP(PIXCKSEL_MASK, PIXCKSEL_GFX);
+	writel(val, NPCM_CLK_BA + CLKSEL);
+	return 0;
+}
+
 phys_size_t get_effective_memsize(void)
 {
 	/* Use bank0 only */
-- 
2.34.1


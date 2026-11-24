Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F265606A31E
	for <u-boot@archiver.kernel.org>; Tue, 24 Nov 2026 20:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=t8U3RWQx;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=PxfAIMqa;
	dkim=pass (1024-bit key) header.d=forwardemail.net header.i=@forwardemail.net header.a=rsa-sha256 header.s=default header.b=VKU63FT7
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9B8F940653;
	Tue, 24 Nov 2026 20:59:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JiUftjZpPD9H; Tue, 24 Nov 2026 20:59:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org DC4DB405BF
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795553948;
	b=rgVNWjsmqYgens7dwsDbFBOvrtP7GGnxjdX01HLcddkd2gCeYopsog7XIWwO/lGX203g
	 g0NIAfS4cyEeKd+EzRjbRp3bN1om+CqxdpvuBc2AUXVw4hL5jmRWkemo/PqVHsTkj/F27
	 KY2pMvpu6D0s6bT5Zti21hqwQQRx5POLdnkYarHo7FfsMcfxeAlnYnLpjBzQgCxwiz65z
	 ZF3ySE0IRTV+8MNA/SfavDqgYDNXJ0VlbQ2qVWXC6xkd2zeNxY4vbD79/dl1qOoZGT7H/
	 zeUhjVWaMFmc21GawINKsxBlcKxTHOXOfYyeiR0kCTRwCY4Ctlfgf2tqkx/ajyC/iKg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795553948;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:DKIM-Signature:CFBL-Feedback-ID:CFBL-Address:
	 X-Forward-Email-ID:X-Forward-Email-Sender:X-Forward-Email-Version:
	 X-Forward-Email-Website:X-Complaints-To:X-Report-Abuse:
	 X-Report-Abuse-To:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=N6rJI55ePI+jEXwYXAN0zpiBul1Mm/5g4sXLjSp2FkY=;
	b=mOETDg9EHTXJGRib2M9/+IAhLQL5oD8FBCEV0U9Yu/jHJV2oaqCphiB44RiFK6Frpnmc
	 gu3+QqWBO5Vb4lEGgW1IQZu8jNr11W7wJhI3uQO0eCb2Vz9YmFboN1JFH5QyG02Z/NOz9
	 qYKUVobX3nUIkuw52NpY0lkZF9L2IqnCnAP/EewbGBELO5Qb2osTnuFng+U1KiphI6zSV
	 kLJJ2taSg7YMxPZWJelX3RcgIlCnRx4NaMcImxskyJQy1wDMAw+Qf2KVsqkA/Qqmgw0sZ
	 xsB/jlQtz6M27aAoKPmtRw/TKiRGjz099750ZDSX7VziyXkOAuyuVO1vU12+txUSocw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=kwiboo.se;
	dkim=pass header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=PxfAIMqa;
	dkim=pass header.d=forwardemail.net header.i=@forwardemail.net header.a=rsa-sha256 header.s=default header.b=VKU63FT7;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795553948;
	bh=N6rJI55ePI+jEXwYXAN0zpiBul1Mm/5g4sXLjSp2FkY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=t8U3RWQxnwxikit0IgBu05x82XOUgIjLj306UfVj9b7A66beLiVd/FyvqQTckSLjA
	 ioL9EwfdC9x5WN4iEexZhubB3ic6itpXkNz5F368xvP3HDgdK9VEJwBq5PPY7BBtUL
	 SXgDQgrrGEQOQooN4A+m4msO1lC1x1ZPAj528y4TgieSrdao90q732aambpX0ZRekv
	 lX0jwQmCNR3s/NgbkRgDzLfI25U3cCpUB7fXQC71lb3vbsOrqk6ZpK77rs7J+w0aop
	 V+VXXb6gIaYplZBydKEu9o1VieHRpKVKoVewHwtfCZMqMESYTd/Ug7JfTagHQHXRsw
	 eSxo9OdN+33bQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id DC4DB405BF;
	Tue, 24 Nov 2026 20:59:07 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 505C12F5
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 20:59:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3C663405F0
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 20:59:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FpXn04lH_ANs for <u-boot@lists.u-boot-project.org>;
 Tue, 24 Nov 2026 20:59:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 2614E40352
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=121.127.44.73
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.73;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=cbd4=jo=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=PxfAIMqa; 
 dkim=pass (1024-bit key) header.d=forwardemail.net header.i=@forwardemail.net
 header.a=rsa-sha256 header.s=default header.b=VKU63FT7
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2614E40352
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 20:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From: CFBL-Address: CFBL-Feedback-ID;
 q=dns/txt; s=fe-e1b5cab7be; t=1795553941;
 bh=N6rJI55ePI+jEXwYXAN0zpiBul1Mm/5g4sXLjSp2FkY=;
 b=PxfAIMqato9h7+cr2ACTjNuX1DxBSqRjDMNUNalhrYRKV+lqHfNgn4+FSCOhxSmGTcHoAC2n0
 MlmybEUK3S3fZiEPTiivuKKtqx+4TFgPJt15Z5yixn8skGf27wC2Zw1zqbgSLuNMgkR8g8uWEjw
 aEr6P38IV9UhYRmxbjUeys7S/NMONtvG2LeNthcoIsFI2eaP6KQnvf+nXBuoemn+hctJLl8tndG
 Z+Xbt6DO8gVtR7jmx2AQHEbw/Ao1mURRTsQJFxF7xXFBzWMFDQkg5I57bqsidIiCcQjxIFIz08m
 VluOozor/U0at4M13fYQQysF2wTQ5qJxFL9LqHYnbISg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=forwardemail.net;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From: CFBL-Address: CFBL-Feedback-ID;
 q=dns/txt; s=default; t=1795553941;
 bh=N6rJI55ePI+jEXwYXAN0zpiBul1Mm/5g4sXLjSp2FkY=;
 b=VKU63FT7/sjF/AixcLW1a0g8XHzPbO8FGRrS2OanmVRf/YVv986lhEf9xE7bdJDiqZyH4devE
 NGDLkHygfDJ3EGGK8aoS7j+iH9UHKzPyunr7cLy81jYinSK4gIASsP1D+FVx8rdf2jL5M2C6ULt
 nQY+EjfQH+/e+miWo1bMYo0=
CFBL-Feedback-ID: 6b05fa941eedfc30af5a53a9:20164d2ed561713841877e250a80613c
CFBL-Address: abuse@forwardemail.net; report=arf
X-Forward-Email-ID: 6b05fa941eedfc30af5a53a9
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 2.19.37
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Quentin Schulz <u-boot@0leil.net>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org, Jonas Karlman <jonas@kwiboo.se>,
 Simon Glass <sjg@chromium.org>, Quentin Schulz <quentin.schulz@cherry.de>
Subject: [PATCH v2 3/4] rockchip: rk3506: Use FIELD_PREP_WM16 macro
Date: Tue, 24 Nov 2026 20:58:44 +0000
Message-ID: <20261124205846.1536932-4-jonas@kwiboo.se>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261124205846.1536932-1-jonas@kwiboo.se>
References: <20261124205846.1536932-1-jonas@kwiboo.se>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Change to use writel() together with the FIELD_PREP_WM16() macro instead
of using the rk_clrreg() macro or custom write-enable bit handling.

No change in behavior is expected due to this code style change.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
---
Changes in v2:
- Use FIELD_GET() for TIMER_EN check
- Collect r-b tags
---
 arch/arm/mach-rockchip/rk3506/rk3506.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-rockchip/rk3506/rk3506.c b/arch/arm/mach-rockchip/rk3506/rk3506.c
index 2ed1dcc128e0..7fc41b8bd097 100644
--- a/arch/arm/mach-rockchip/rk3506/rk3506.c
+++ b/arch/arm/mach-rockchip/rk3506/rk3506.c
@@ -6,7 +6,8 @@
 #include <dm.h>
 #include <misc.h>
 #include <asm/arch-rockchip/bootrom.h>
-#include <asm/arch-rockchip/hardware.h>
+#include <asm/io.h>
+#include <linux/hw_bitfield.h>
 
 #define SGRF_BASE			0xff210000
 
@@ -32,7 +33,7 @@ int arch_cpu_init(void)
 		return 0;
 
 	/* Select non-secure OTPC */
-	rk_clrreg(SGRF_BASE + 0x100, BIT(1));
+	writel(FIELD_PREP_WM16(BIT(1), 0), SGRF_BASE + 0x0100);
 
 	/* Set the sdmmc/emmc to access ddr memory */
 	val = readl(FIREWALL_DDR_BASE + FW_DDR_MST1_REG);
@@ -71,13 +72,13 @@ void rockchip_stimer_init(void)
 		return;
 
 	reg = readl(HP_TIMER_BASE + HP_CTRL_REG);
-	if (reg & TIMER_EN)
+	if (FIELD_GET(TIMER_EN, reg))
 		return;
 
 	asm volatile("mcr p15, 0, %0, c14, c0, 0" : : "r" (CONFIG_COUNTER_FREQUENCY));
 	writel(0xffffffff, HP_TIMER_BASE + HP_LOAD_COUNT0_REG);
 	writel(0xffffffff, HP_TIMER_BASE + HP_LOAD_COUNT1_REG);
-	writel((TIMER_EN << 16) | TIMER_EN, HP_TIMER_BASE + HP_CTRL_REG);
+	writel(FIELD_PREP_WM16(TIMER_EN, 1), HP_TIMER_BASE + HP_CTRL_REG);
 }
 
 #define RK3506_OTP_CPU_CODE_OFFSET		0x02
-- 
2.56.1


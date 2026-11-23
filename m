Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A16606A31A
	for <u-boot@archiver.kernel.org>; Mon, 23 Nov 2026 10:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=GN8uRHLG;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=pTEc76ew;
	dkim=pass (1024-bit key) header.d=forwardemail.net header.i=@forwardemail.net header.a=rsa-sha256 header.s=default header.b=Girl9Emg
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DD3B660726;
	Mon, 23 Nov 2026 10:37:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8p63-nlujW0F; Mon, 23 Nov 2026 10:37:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D89B160651
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795430240;
	b=KnGhr73+9gpHficReTnTvzJxkjvRNozK62NzuwDDnQOVbNITtjh7H4nKOHmSsyeJFGoO
	 km04mtUSYApiOZFpqxsANk2MWSKtnp6NHjKxdY8aZQ7alaFgmu48GGiLiUH3ZSn1bSnPw
	 T6F8FDwhQf9/Jn1+flNakfqQ4W6vcA2d68ecQ5siKYwwT7YIYK5SF0DG88O4ANEf0DWxs
	 MdzBVTK3iblKk/4VaO3MYfFqPEUTNc1pM5eOPinFiX3fZ/3gtaxGY8yhcaR4AHrGK0A3N
	 vJSuhW7S1DRY+vY3a7VSzztG9SYypX0Xn97Si1Spryle/XeQL6gmDZi/A0RhzCkMheg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795430240;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:DKIM-Signature:CFBL-Feedback-ID:CFBL-Address:
	 X-Forward-Email-ID:X-Forward-Email-Sender:X-Forward-Email-Version:
	 X-Forward-Email-Website:X-Complaints-To:X-Report-Abuse:
	 X-Report-Abuse-To:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=ecwkmweKJUDA9aB7s9d+tRuW6bFa85dQtg+LPdkn2Po=;
	b=EDU2stZApa7TXSyMiwcDsTD4QBa9op7gjGZYpCVeLAS3XPJmd8u9urd7kp9u6UF6lEsd
	 ZXLqZVL9EriByLTsD30cfChNbvXChJ3pOi9EIF1RZwxog8TKGxAt4n15M6iPU9/FedqoN
	 ZkZ/AlnnL+1qDIxCWMQdfmI0bzKvGd37P9lBPaHtwUNcVWUM0OFuW1IfQvK2d5uMwnMmA
	 H5PiBaUjj/9hNO7dYsn+Soxum6uE7Hmc1S5wtkCFOUB1hd7RfEQhJDhDhw9z2xbTA+GxK
	 X4fOn9Y42AxV+A5fqxmO4Wtt054/Xfex2wIchW04amwl/V6g1xLA0t+Kf8K3yPQnQ3A==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795430240;
	bh=ecwkmweKJUDA9aB7s9d+tRuW6bFa85dQtg+LPdkn2Po=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=GN8uRHLGRdKdgcCyIiKxgioOIXVbvwrsf/zRdSZKf89zZ76yxXT5FjODZofoumOJk
	 CgLMlr2odbowWnXELAmSDUxQocWGlGssr9alQLQ392a5aOfPnnUUwRO6kds4hItqfK
	 o3nUOLAxwcy1hx3EkfeUPmd9aLQhbzs5vVkLs2VKphYj4xEvxR6SfiKhodWdZmaJCC
	 MgwS9UrA9KzU6dWDXXv011pmai0FW3n96hEciFZ9m+uMi1X3f1w7U2cFCQV9nu1eXf
	 x/Hqjvey9i1O6YF9S2lDYyjHYCu66rOh03o1k1uCSOxEtX+R9rkswG7sJ3/x1Dhuf5
	 dTIN6E43GMHWw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D89B160651;
	Mon, 23 Nov 2026 10:37:19 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id A380722B
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 10:37:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8885A40082
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 10:37:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id m_L-aaqwge-w for <u-boot@lists.u-boot-project.org>;
 Mon, 23 Nov 2026 10:37:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org A9E9F4005D
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=121.127.44.66
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.66;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=ac5f=jm=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=pTEc76ew; 
 dkim=pass (1024-bit key) header.d=forwardemail.net header.i=@forwardemail.net
 header.a=rsa-sha256 header.s=default header.b=Girl9Emg
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.66])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A9E9F4005D
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 10:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From: CFBL-Address: CFBL-Feedback-ID; q=dns/txt; s=fe-e1b5cab7be;
 t=1795430236; bh=ecwkmweKJUDA9aB7s9d+tRuW6bFa85dQtg+LPdkn2Po=;
 b=pTEc76ew+PavRXUkZeGMnG7uAC05tFsoG1SlDYpwikwfu7jWEORk9WW7bAuOF9dwNjcwswWuq
 cc3Gl8I5L+Vi14cBSXIwvSRRO+oLnIOVaIj7hkOvya1nHix70yrxNPRBx/IL1416zJ3XWzevlz4
 78OGTRAMvhKBc+SX0SLPI7PDh4Q3Cn7u9AOrQMOpKGQJVeCudGrLbOWwm7SfUOxS5BJqhJN/RkP
 rhsSI6OdekRb692wzUNr1jKjBGjHwlG8uF9lnWlu8F0Jyn+kkkc4qFLmMehnd/gIlMgTfM6YPZp
 Gk/TvIlw1gGsChAywpJyG6zJ7Vba7t8YR71R3ADi5ySA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=forwardemail.net;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From: CFBL-Address: CFBL-Feedback-ID; q=dns/txt; s=default;
 t=1795430236; bh=ecwkmweKJUDA9aB7s9d+tRuW6bFa85dQtg+LPdkn2Po=;
 b=Girl9EmgIfNSxPwS0Np+JT7lp6xoFookosYPWYC7dI3Y96tXNmzD/wwVlCTNnbu8w/6omJJNH
 teT1gqkePcN+mVvV5VswSrUhsXV5WmHSli0uZURYtTnK1yoohCtnLNVfRNK1zdFVPPXm6gA5Mbh
 8G8cBeOHKN2kmAhuNGKWnoQ=
CFBL-Feedback-ID: 6b04175be4e978ea9d8b596c:8c3e208f8626722a943962b620b4535b
CFBL-Address: abuse@forwardemail.net; report=arf
X-Forward-Email-ID: 6b04175be4e978ea9d8b596c
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.66
X-Forward-Email-Version: 2.19.37
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Quentin Schulz <u-boot@0leil.net>, Tom Rini <trini@konsulko.com>,
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>
Cc: u-boot@lists.u-boot-project.org,
	Jon Lin <jon.lin@rock-chips.com>
Subject: [PATCH] spi: rockchip_sfc: Only use x2 clock rate on version 10 and
 later
Date: Mon, 23 Nov 2026 10:37:11 +0000
Message-ID: <20261123103712.1389502-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.56.1
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
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The detected NAND ID may read back incorrectly on RK3506 using a
requested speed above ~50 MHz due to x2 speed being used as clock rate.

The FSPI_VER value, clock names and vendor kernel sclk-x2-bypass
handling seem to indicate that x2 clock rate should only be used on
FSPI version 10 and later, not 8 and later.

Summary of FSPI_VER reg, clock names and vendor kernel workarounds:

   SoC       Reg address       Value
  rk3568  FSPI_VER  fe30002c: 00000005
  rk3588  FSPI_VER  fe2b002c: 00000005
  rv1106  FSPI_VER  ffac002c: 00000006
  rk3528  FSPI_VER  ffc0002c: 00000008 (vendor sclk-x2-bypass)
  rk3562  FSPI_VER  ff86002c: 00000008 (vendor sclk-x2-bypass)
  rk3506  FSPI_VER  ff48802c: 00000009 (sfc->version set to 6)
  rk3576  FSPI0_VER 2a34002c: 00070010 (SCLK_FSPI_X2)
  rk3576  FSPI1_VER 2a30002c: 00070010 (SCLK_FSPI1_X2)
  rv1103b FSPI0_VER 20d4002c: 00070011 (SCLK_SFC_2X, sclk-x2-bypass)
  rv1103b FSPI1_VER 205c002c: 00070011 (SCLK_SFC_2X_PMU1, sclk-x2-bypass)
  rv1126b FSPI0_VER 2146002c: 00070011 (SCLK_2X_FSPI0)
  rv1126b FSPI1_VER 208c002c: 00170011 (SCLK_1X_FSPI1, sclk-x2-bypass)
  rk3538  FSPI_VER  fde2002c: 00670013 (SCLK_2X_FSPI)
  rk3572  FSPI0_VER 2a02002c: 00470013 (SCLK_FSPI0_X2)
  rk3572  FSPI1_VER 2a08002c: 00470013 (SCLK_FSPI1_X2)

Vendor kernel use x1 clock rates for RK3528, RK3562 and RK3506 thanks to
use of vendor sclk-x2-bypass prop or version downgrade, effectively only
use x2 clock rates on version 10 and later.

Change to only use double clock rate for version 10 and later to fix
use of SPI NAND on RK3506.

There are no in-tree use of SPI flash on RK3528 targets, and RK3576 is
reporting version 10 so this have no expected behavior change.

Fixes: c769855be257 ("spi: rockchip_sfc: Support sclk_x2 version")
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
This is based on the Linux patch [1]
[1] https://patch.msgid.link/20261122174357.1295391-1-jonas@kwiboo.se/
---
 drivers/spi/rockchip_sfc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/rockchip_sfc.c b/drivers/spi/rockchip_sfc.c
index 60e74117057a..b802be1039b8 100644
--- a/drivers/spi/rockchip_sfc.c
+++ b/drivers/spi/rockchip_sfc.c
@@ -109,6 +109,7 @@
 #define  SFC_VER_4			0x4
 #define  SFC_VER_5			0x5
 #define  SFC_VER_8			0x8
+#define  SFC_VER_10			0x10
 
 /* Delay line controller resiter */
 #define SFC_DLL_CTRL0			0x3C
@@ -593,7 +594,7 @@ static int rockchip_sfc_adjust_op_size(struct spi_slave *mem, struct spi_mem_op
 #if CONFIG_IS_ENABLED(CLK)
 static int rockchip_sfc_clk_set_rate(struct rockchip_sfc *sfc, uint speed)
 {
-	if (sfc->version >= SFC_VER_8)
+	if (sfc->version >= SFC_VER_10)
 		return clk_set_rate(&sfc->clk, speed * 2);
 	else
 		return clk_set_rate(&sfc->clk, speed);
-- 
2.56.1


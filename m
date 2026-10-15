Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09FA3CC6B34
	for <u-boot@archiver.kernel.org>; Thu, 15 Oct 2026 09:21:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 97D8740462;
	Thu, 15 Oct 2026 09:21:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4FWXIMgDgxN5; Thu, 15 Oct 2026 09:21:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 07120404F8
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792056117;
	b=TwHs6AS3SQnnfBhk1M7VO7rXVxYqPNIJbN0gOvGinwC9Bx1wY6+tWDS2Kb0mr2sQVtzA
	 GPDBvAnqenr3aqXVCBlUJTFgh+U5SyKeiUOsz/Vo6/HTu3gsfPxBs9erlHe3p6NOr5sjt
	 8fO82OgCTiRu0XMcM7O1NlEjGCqznqeA2MqZ7Kf06tp7zlgA4JCDpXuFvbu4Z3MX6Iuq7
	 lUwbtMGz/1sKDcjHTGH+v4EC85koEoTHUw04SkgnUIO9moVIoyRvUeHSiXZjkFCo/gpIS
	 D1YBqwrKy2sejsGTBAKT9n/mPTg7m4Tb92HAyonHSN1uni5nO/5vrk/WwSdiuC9wFLw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792056117;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:X-Virus-Scanned:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=FtxRyTZPFHc+Kxct+9+OoSPzJlw0Cs6nM29DCw6kIEc=;
	b=lSo9ydauO4bO5B7dYgT/EzrEWq18Z4Hc+HVqiMhqFRUtcNNVygQFv0D+mwyg7A7PTCgY
	 4LUNxwVZJrbGb/7nedtDLw2E3Q3loMGJkf3ttcSUJrtMfmphZNwsqwONHs4w2d8+CjY8q
	 YzuPm6LIWC+qUwzeoMxiLYGv0SbddWu9Dr1qfQDqucVaO4ENt7ZPv7O3WpM1fiAswirRf
	 Pn/8jgn8uqoGILrvmeVrbsbU78fWYQWw6nUeoHcs49Exj4c9/cGZ3hcj0lmhWndb4AmiT
	 gOKy/aydxUs0unCBwASw7ZEhmX5jTpU9RQb40gbeYExit+LWzw/3RUJ1Mt7dcdy0kVA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=ew.tq-group.com;
	dkim=pass header.d=ew.tq-group.com header.i=@ew.tq-group.com header.a=rsa-sha256 header.s=default2602 header.b="FDI6V/Fs";
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792056117;
	bh=FtxRyTZPFHc+Kxct+9+OoSPzJlw0Cs6nM29DCw6kIEc=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=FsTkzBtWVsXvZW5QqWurGsACJjtL92oC58REar/T+ope5MTMmCmVa7aciUEK57uAM
	 fAbqAl9j5wAHK3tPx5vco0RrkpFG7zjNRBmLz2T37a1t0uEhjrnNZG6UUK+rHKv5nB
	 +JLAOXSU/t09vdzSQvtu4U+lgS9X+WYgKsQTtxDMOh/Po1FdAlVXSg255pLzXf83zp
	 FRI7u89uEwwE9/3JloI5In0zzuU8rUMUfTlQcrbzH/8pOCigXrlNCTmnIDDPPKO0um
	 9LS1Qc/QAM/fP1m3kxx84vb8XiEF+V6iyfAC+YrQwFy2pWAfnR6gaCCa65a8xjVFgM
	 ofhxp0mpPDkTQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 07120404F8;
	Thu, 15 Oct 2026 09:21:57 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 03CAA255
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 09:21:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E66DF404F8
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 09:21:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RB_Qa85JMtrR for <u-boot@lists.u-boot-project.org>;
 Thu, 15 Oct 2026 09:21:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org E8C7540462
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=188.40.3.216
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792056115;
 b=BveSoZTXsSraU9mVJ+azMk27TOUpZj6xMpFyBUQ1lYAy9kdYyDFkwdaZuAuZqUjD3WhS
 GPQb7K0XbALAze1PdqjnSVsLxpwzGX0kSZQIczvuUuX3vArOWGPG1D4DumhnfdOBQyyKX
 46rYi7Dk6W9g6IVD4M8sSHWupc6r9MHJIY69zPV/6IXm9lOESBwqxws5pRbnBwnDLyKDM
 RxabHpflrwUr1X+DPxvEYYATH7jAase3dqstHwCf5ySQZwhS6vqOpLP7YVij9r6cnbQD/
 61tyw7UwQDsDPcZy4oilwVzDfDcJUleBNIKV/D1fmTk3CbatE6w6QbikjZHrX4AUduQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792056115;
 h=X-Greylist:Received-SPF:DKIM-Signature:Received:Received:From:To:Cc:
 Subject:Date:Message-ID:X-Mailer:MIME-Version:
 Content-Transfer-Encoding:X-Virus-Scanned;
 bh=FtxRyTZPFHc+Kxct+9+OoSPzJlw0Cs6nM29DCw6kIEc=;
 b=I2a8LLx+zdt3+MlTZ1yHNiO5PfRcUgKF8tbDnTlehzpyLOymM/6VD/NhQEDyidz7BE7p
 VYlgfT4kxcClFoSqgtYkj3Qz8A1l1Sxp+0RWluxA27aUpq8QyRLtmWVT0v6DJco6Y4cZl
 1oGWXeW9HqRCjPJj5auOvJTPpWbRY5ygoehEQ/NCimQ8ockcGahs70ZGOGQKGnGh0wBal
 nZITQS4DlzsUzi1d0g0d4ueNSDPu89rHal3eLMws0mjHEVUJcjbXcFR8ZtXTIxQ+WUTb+
 UamzSJT1q6jwJzwPwrS4AqflAPnWG7kWZb3mUNf9vWMSQxbSjH1+RWt4UHPwpWVqF4w==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=ew.tq-group.com;
 dkim=pass header.d=ew.tq-group.com header.i=@ew.tq-group.com
 header.a=rsa-sha256 header.s=default2602 header.b="FDI6V/Fs"; 
 arc=none smtp.remote-ip=188.40.3.216
X-Greylist: delayed 1009 seconds by postgrey-1.37 at util1.osuosl.org;
 Thu, 15 Oct 2026 09:21:54 UTC
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com
 header.a=rsa-sha256 header.s=default2602 header.b=FDI6V/Fs
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=188.40.3.216;
 helo=www537.your-server.de; envelope-from=alexander.stein@ew.tq-group.com;
 receiver=<UNKNOWN> 
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E8C7540462
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 09:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Content-Transfer-Encoding:MIME-Version:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References;
 bh=FtxRyTZPFHc+Kxct+9+OoSPzJlw0Cs6nM29DCw6kIEc=; b=FDI6V/Fs2z/b3JpM9J2eToU0Jp
 jwB/rtuvsNX6ffRNgoRBA2L6iZeAKtSsnfCt/3fCPb4kq4gKtRdOxpiuvuXGUftEeapBg90VVL8u6
 M8ugaRGV7RfSDeli+eQAFkW4yT2S0I25r+fOe8M0xs+/xW4zkt/FGtLHJsVWvatnxr9CUOzs5cM+4
 sWoiBbr/tq2HFqEiIT/1ESNchMbWQs1DaUl1Krkmmch6oiGWW9fqthilkSuZJLSPrn5brZYQUvNHB
 VRT/e6TaEXMua9Lul76HB342rsnke3AD4V1Ehw6sZ8+/aEYkpz/C+vvG6hf4yR+LcfGp/Gtky+dBX
 gLQaB6tQ==;
Received: from sslproxy08.your-server.de ([78.47.166.52])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <alexander.stein@ew.tq-group.com>)
 id 1xHHOW-0003a7-1j; Thu, 15 Oct 2026 11:05:00 +0200
Received: from localhost ([127.0.0.1])
 by sslproxy08.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <alexander.stein@ew.tq-group.com>)
 id 1xHHOW-000JMk-0A; Thu, 15 Oct 2026 11:05:00 +0200
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Peng Fan <peng.fan@nxp.com>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
 u-boot@lists.u-boot-project.org,
 Markus Niebel <Markus.Niebel@ew.tq-group.com>
Subject: [PATCH 1/1] imx9: scmi: Add missing UART clocks
Date: Thu, 15 Oct 2026 11:04:56 +0200
Message-ID: <20261015090457.1520827-1-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28154/Thu Oct 15 08:24:22 2026)
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

Only clocks for LPUART1-3 has been added to init_uart_clk().
Add the missing clocks as well.

Signed-off-by: Markus Niebel <Markus.Niebel@ew.tq-group.com>
Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 arch/arm/mach-imx/imx9/scmi/clock.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/mach-imx/imx9/scmi/clock.c b/arch/arm/mach-imx/imx9/scmi/clock.c
index 951d47bd9d7..cdc2d7fda30 100644
--- a/arch/arm/mach-imx/imx9/scmi/clock.c
+++ b/arch/arm/mach-imx/imx9/scmi/clock.c
@@ -33,6 +33,21 @@ void init_uart_clk(u32 index)
 	case 2:
 		clock_id = SCMI_CLK(LPUART3);
 		break;
+	case 3:
+		clock_id = SCMI_CLK(LPUART4);
+		break;
+	case 4:
+		clock_id = SCMI_CLK(LPUART5);
+		break;
+	case 5:
+		clock_id = SCMI_CLK(LPUART6);
+		break;
+	case 6:
+		clock_id = SCMI_CLK(LPUART7);
+		break;
+	case 7:
+		clock_id = SCMI_CLK(LPUART8);
+		break;
 	default:
 		return;
 	}
-- 
2.55.0


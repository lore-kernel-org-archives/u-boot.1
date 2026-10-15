Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B3E9CC6B38
	for <u-boot@archiver.kernel.org>; Thu, 15 Oct 2026 22:42:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E0E2A4094C;
	Thu, 15 Oct 2026 22:42:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 46Draggar3Q6; Thu, 15 Oct 2026 22:42:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 178C24091C
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792104170;
	b=I2j6HhISNGP3ftypL4tCPHyWToRCnLcaHxXkTzCzjyyfMul65Bul66KaMnS3rg4+8D1u
	 LILskH8TYQbEPmDZl9nHIi9EFje8QcOkxsv5388I8zyuNDVZc/j5u2mThU9axK7s9vPif
	 5KWv5HQ85U3JK5KgrcRzDYqI094e48LPgZzyuH9Nt5l0fZN3uWkJ7jPL3NRnDOyRGhKU7
	 XtC5h8/HwOoZAz3eVl/ZclcmVP7FpuH/HhepnLigBEMwxh2DXf6FK+3CR+wKWUxOPFkGv
	 kdj718gXNJBUCi57z7CpEHfxZIUdi8Jh71xTsA0vqJujJHLMtLz9S5uz6HBwnzP4cBQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792104170;
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
	bh=fXNZ3DF0WIO1GZboYDuAdiesUu8VQY21v84iEaF0jDI=;
	b=eYp0PNvVX58miiWS/BzY/A+gUmAWvnbml7Yeyi5PCcQ8HodLoC0IsQ8v64fwsg3bPLuB
	 qkq6KARe0gu6mkwfov4VcDjWEs0v2tn0FOosN3XKG1hxoDzVbQ/qszofo6Jb9A+XXRtDU
	 IKEA15/BuFu/wwuNYnWfoL7AJJpUoGL7M4ibNiqKiTMY/+w6T/icTkn6Bz1HyIceGp7eu
	 PdN8M9wfAjSrq468DCgZBEnKMJFVjJ2rq/iLxLn8j9eZQj8qAa8+nvDnM4ioauA8ZX/XQ
	 K2uAyJhE8MUg0S3UmLdsn7sHVXkRbOR906D1Z1qAkn9tEZTyaSKfuDypmss05B0d3Dg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792104170;
	bh=fXNZ3DF0WIO1GZboYDuAdiesUu8VQY21v84iEaF0jDI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=l0VL2d//c97XdPulaDU+lCFi1mCQBA7TJMu5qYH4hNGajm6vjnev68oCmbA9Kh0F7
	 z38eK4jzxQQEGh81oCb3JNtjFPlkzRd0CbQGyh7mACtYsA5VFGoBv70eU3+cuC59Vw
	 zlvuJY4YrzhQd6M5sabP5oiLkIZa+S5B9cvkKGplp9Abz1ARfNmgA4fEJApPGUJ1kW
	 M86bRIJXFk2nnlC5/Z0fpt4VRVuzvXWp9RkQrEGYpvJKoU5+VDzGvhECF/C51wNlk2
	 C5AYZlIij/IjNwge1kdPoKZp2hjORTpmYyLjUT68hplhHcNfUTNH/Pf/PFf68UwO6k
	 /CXH0E8oAjo0g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 178C24091C;
	Thu, 15 Oct 2026 22:42:50 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 0D44C105
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 22:42:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E7BB560ACA
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 22:42:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0i-a_uwR9vuU for <u-boot@lists.u-boot-project.org>;
 Thu, 15 Oct 2026 22:42:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 2B90260AC5
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=121.127.44.73
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792104167;
 b=f6kwBALDvRRoDkABkQC+JvAj642i4kn5VVpj4cgmd0tseUdTNAeocKEj5FYqJK0tJUPv
 M5aIWzajXMokVOSimita/xxnSNXrvalGlAAT3sF9QOOEPh+ws35rObHC0Mssi5AaeZ1r4
 h4yT1cmoIfCu4kW3LWAuwSDbpSpawiKh5LR1Kn+29xjp8wTAOyVlAkRJcq6I8d0kOw2wO
 fXF34rx8S5RRwI5hEVPPEEYhqPhP5Hc5IHG7YIO03EaKQWjBKmGdW5eT8SsMTh9ghd2E4
 BUriynBBNpZlenRkYWicsJx3PU5NVjzHQp2g10tdwyAJPaoW335qQvwSHYou2qZt8HA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792104167;
 h=Received-SPF:DKIM-Signature:X-Forward-Email-ID:
 X-Forward-Email-Sender:X-Forward-Email-Version:
 X-Forward-Email-Website:X-Complaints-To:X-Report-Abuse:
 X-Report-Abuse-To:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
 bh=fXNZ3DF0WIO1GZboYDuAdiesUu8VQY21v84iEaF0jDI=;
 b=h4VrtiDdmf2kvvvH9bD1km+OlrQYgX5Zh4kd9lwEaYfm6LEIf0ICgqAtl+LBlI/yL9v5
 EGE0HjG37NwN/CKBgmZ5jRRZlD6un8SYpypeagzpXGd8YB9LkddxcV1gv8IlqCIoJ6WGT
 jPjEWhTaa9oAW6ksoKQul/XEMWUo5TpK6cvB+vTd7FlioIz9XWe32RoZSej9ns6W8GTZB
 JFJ/TPuo/QFKHcsDWfG0lh6lAnh8SjPkZWuHS793RskEjqpf3Z0fDYRM81IRnQ8K6Tdom
 4NGfjFppUk5Wg5W/6pIPn3+nB36WiYCWGlZOk8RYxVWAPvw/1aXQhShlPupc1c3UjoA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=kwiboo.se;
 dkim=pass header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b=is45kBVz; 
 arc=none smtp.remote-ip=121.127.44.73
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.73;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=cddb=ig=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=is45kBVz
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2B90260AC5
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 22:42:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1792104166; bh=fXNZ3DF0WIO1GZboYDuAdiesUu8VQY21v84iEaF0jDI=;
 b=is45kBVzcathuc+J+3ZCqmIUD3M6LJ1gSIn0WFEgoKliwOhjpo5Q1KMCN6GnEXKOxoRqLJqE3
 sthUgF8R+wMCynASl7vU6SzKQ8JXJF+52nVt2v8ju2zB2zL9Chb/iDUN0fdGEaoEO7Gq1EEJcWH
 yy8ZRckWQ6ahTxcEcBIQ6OGjBHHeh5SfkSZWq0+NwAWls6SqGKimAyrETkX66f0FHwRSjZ+6jSz
 SKWdLG8UWQGxe7HHua7XjDmWHGi+xwVtkgfl0pkdnidE6Tm/dH83FaCKdjQ1sjv1nrVK+qcOSuw
 9v+DoRIHUP9GVSDiywMEocJf+hxRkiDYgYMR7nkW9Lqg==
X-Forward-Email-ID: 6ad156e232553382725eab8c
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 2.18.6
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>,
 Lukasz Majewski <lukma@nabladev.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org, Jonas Karlman <jonas@kwiboo.se>,
 Alexey Charkov <alchark@flipper.net>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: [PATCH v3 4/5] clk: rockchip: rk3576: Always initialize clocks in SPL
Date: Thu, 15 Oct 2026 22:42:18 +0000
Message-ID: <20261015224222.1582607-5-jonas@kwiboo.se>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261015224222.1582607-1-jonas@kwiboo.se>
References: <20261015224222.1582607-1-jonas@kwiboo.se>
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

The RK3576 clock driver configures the CPU PLLs and CPU clocks when
probed in SPL. However, the driver is only probed on demand, so this
configuration is skipped when no SPL consumer requests a clock, e.g.
when booting from RAM/USB.

Prior to the commit c6bba31dbdd4 ("rockchip: spl-boot-order: Defer probe
of boot device") all boot devices where typically probed, with a side
effect that clock driver likely also where probed, prior to the
boot_from_devices() call.

Flag the clock driver to be probed after bind in SPL to help ensure a
deterministic probe and clock configuration behavior prior to booting
from devices.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Tested-by: Alexey Charkov <alchark@flipper.net>
Reviewed-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
---
Changes in v3:
- Collect r-b tag

Changes in v2:
- Update commit message
- Collect t-b and r-b tags
---
 drivers/clk/rockchip/clk_rk3576.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/clk/rockchip/clk_rk3576.c b/drivers/clk/rockchip/clk_rk3576.c
index 75b705ffba2f..1988f0472dec 100644
--- a/drivers/clk/rockchip/clk_rk3576.c
+++ b/drivers/clk/rockchip/clk_rk3576.c
@@ -2526,6 +2526,10 @@ static int rk3576_clk_bind(struct udevice *dev)
 	struct udevice *sys_child;
 	struct sysreset_reg *priv;
 
+	/* Ensure clocks are initialized after bind in SPL build */
+	if (IS_ENABLED(CONFIG_SPL_BUILD))
+		dev_or_flags(dev, DM_FLAG_PROBE_AFTER_BIND);
+
 	/* The reset driver does not have a device node, so bind it here */
 	ret = device_bind_driver(dev, "rockchip_sysreset", "sysreset",
 				 &sys_child);
-- 
2.55.0


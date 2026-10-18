Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BE95CCF2C9
	for <u-boot@archiver.kernel.org>; Sun, 18 Oct 2026 10:53:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DD329606AA;
	Sun, 18 Oct 2026 10:53:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id McAFOsIVd7Dk; Sun, 18 Oct 2026 10:53:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 3ED2160634
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792320827;
	b=S6dhydjEgnp291cV9VKj8W03H3WhNhjaqbrBYBQlcSBRvYx+0IVnPFVuNqok6QCUv+Er
	 H3I/QAiKFZXOHEAK4mEdzD42m+NLTNLLYuoy8W9CiRvMYOvK0SeANCy1WppXQxZkWUZRi
	 gYVZSLW1Oic8Yo/Bxxp53w0kS00DBZGXLzoo+sMKTFCE2RQs2MC+YTB8YNbRHCbkIrsU2
	 HEL7fdDJ5WEFvTFV9nWLE44pCtRgqZj+KaB7WEAObR/4RVeEbWYxeHZtSA6A3NfNwNjVa
	 tgwZ3Q3Ba9JB57Dpox8G4WUgFy41sAw2u9KSVgP12MOgYQvhSZQhJSq+8DvcnUnNzBA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792320827;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:
	 X-Flowmailer-Platform:Feedback-ID:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=RpRjY31oUyno7a4wQrQvLpnLR49mJV7H0C6YlJcvNHM=;
	b=kEL7VvrDcRKXVby53aKMwbyZjGzzyWh5wF1zXmetD9YOK+rKXS1Y8juDpIjAwyKBAd+m
	 n8NYxd0HYcCd9i/rvza5soCs2tE8dDWJUmMDi2M7CmRKlFKXqjQzaD/gKDV5skj2yh0XS
	 Q8koCinm20MtagDpxCkhC+0n0tT3QUcAGZTDLpUpT8qRWibcOuaBO3EUsqUKngqJcfe4n
	 3Z/oxxLpqtrEkSNjN+QT8GaId8AIAxq5Xve8d86hWDb0kiigOUo/yifmlr3Kk0D1yV8Oq
	 +lOpskfnmr7CYRNqK4SONL/8PLHvoe+kIdEtPrtHmkLFuClC30Opf12U6qYEubJ/fFA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792320827;
	bh=RpRjY31oUyno7a4wQrQvLpnLR49mJV7H0C6YlJcvNHM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=keJHc7qOUg/eToOlRe+LntS0xuLqXFUrRKcKCLvQgmFKfyADg/Z0+cWuSQ5W3054i
	 Ef1Mb8xsD35YGO8t8yPpoX9vnCSKq9RGkfS8QjO9Vxg9xFT17X1PC5+yKGx6EucjbL
	 sOpP951N61ZQWvGFt+yUxIaiep6J4LFpQLdNvoE55WkwET+LXh5HoNp+6pG5Y6GbAO
	 dByKV9vgEUVWa4fwQGUaP/r6USEYSuq88vAVM7ww1q5SQJQUy0yT7PVccVG9UXa+C4
	 TczQJZ9c2GNz/FaJC0oo3V9WIidfeWff1r9UPgaccB0sG2uqUUpsPdJKxnj4ZwXVO6
	 3RtkJAJtDYswQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3ED2160634;
	Sun, 18 Oct 2026 10:53:47 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id C4380255
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 10:53:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C1FE380CA6
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 10:53:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HONDGclJ4FDp for <u-boot@lists.u-boot-project.org>;
 Sun, 18 Oct 2026 10:53:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org EA35380B80
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=185.136.65.226
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792320825;
 b=i7SJG7lzHdsssMcjSzjQ1C/2K6wxF56tgDZfNnM9tu2duKmNqFaBNAilduDqEk6Xld8a
 j+Demc0otzTgJc3Y3YZ953vj3kqIJhvW2pE9H1nO4WjTVWoEAn/rGzXUO0X9Pgy1VDX12
 7W0ylvA+4uiFwqU7F/2WqVd1BxkLvlITO9sEHduruCCVYLE44g35DZnSmPqmqcltUILt0
 qkHeH5gd2pppIcMQedZd/Y2+ZO5Nh2xMXN7nJcdF15wQiT9Q6JZCQWef/tFiFD2ibZ2VX
 uFs0psELUun59ZaEKVPitofh+81e3Q+4qCaR5VfjmIuNBkUtbcImXY63HLpiAUvmV4Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792320825;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Flowmailer-Platform:Feedback-ID;
 bh=RpRjY31oUyno7a4wQrQvLpnLR49mJV7H0C6YlJcvNHM=;
 b=csLXVg0zV/c2tha3ryweYbOyF1VtKPlHHkTbHjnvJ6JXYqficq1KvXOXDRRft0V3lCj1
 1qjmw9W9WP8nocIQiq6GVsJ/ouBjonSa3/tQShVqk1jiH+qrLze1lJbwidf6uPQUBTDMV
 eV3LdoHeO7AGzTS6aSDW8bQzpXM78BtN4YZ/N2BOxPUm8rXGPQk+Y0wWuq8lWg0K1v+lZ
 KNSYBhoflPw+wU0KYk0193aAVhcGaz/Z6bLoAhZU1EPUyzcahBqW3ExZ/DAdIf28dujgT
 NZ53V9S31ETbt0sG8E+Mb+N7sJT/a6cyzkSAdMJ4Ia5l0aWxUrMJJXABPAVs6UGGlFg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=siemens.com;
 dkim=pass header.d=siemens.com header.i=jan.kiszka@siemens.com
 header.a=rsa-sha256 header.s=fm2 header.b=DfenPcRO; 
 arc=none smtp.remote-ip=185.136.65.226
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.136.65.226;
 helo=mta-65-226.siemens.flowmailer.net;
 envelope-from=fm-294854-202610181052399f2dccfc66000207b1-_8mpjy@rts-flowmailer.siemens.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=siemens.com header.i=jan.kiszka@siemens.com
 header.a=rsa-sha256 header.s=fm2 header.b=DfenPcRO
Received: from mta-65-226.siemens.flowmailer.net
 (mta-65-226.siemens.flowmailer.net [185.136.65.226])
 by smtp1.osuosl.org (Postfix) with ESMTPS id EA35380B80
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 10:53:44 +0000 (UTC)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id
 202610181052399f2dccfc66000207b1
 for <u-boot@lists.u-boot-project.org>;
 Sun, 18 Oct 2026 12:52:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=RpRjY31oUyno7a4wQrQvLpnLR49mJV7H0C6YlJcvNHM=;
 b=DfenPcROoL89FfMv2gKPGneZTxkcXV2sw8YG6CIKhYiK20TNfZA1jCk7IOL5BFGdFJA5zv
 IY97B01NOKJPHJsZYIdqBGG1QX76PTg4yE1Jkbvt42zLL3HtGldXR1j4SWsczUaAXtOf4E+R
 2Yl7oDbkDjgLNmWkZyMBWiO7o7gz/rWbHfh6xw2qGsc3Ry0Ah7uZD0iO465Etu7QklGvpbXR
 ej0ZEcYQGscvoNg9rUs66WnXxdCNswZbxHlre/7UBsz3oFvIQ+jML7mqkH/ZrYQ2J3BfGUd2
 dgxVzzY+4MpxXYSzADLAVMmmrMXG7F8x1w3I8ubprl0slMPf8cLcCTKg==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: U-Boot Mailing List <u-boot@lists.u-boot-project.org>
Cc: Stefan Roese <stefan.roese@mailbox.org>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Bin Meng <bmeng.cn@gmail.com>,
 Hung-Chun Tseng <alan.tseng.cs@gmail.com>
Subject: [PATCH v4 2/3] watchdog: add support to call initr_watchdog multiple
 times
Date: Sun, 18 Oct 2026 12:52:35 +0200
Message-ID: <174a18e4f6805299db40fa3504c24e19d79b7776.1792320756.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1792320756.git.jan.kiszka@siemens.com>
References: <cover.1792320756.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
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

From: Jan Kiszka <jan.kiszka@siemens.com>

This allows to invoke it from board init code once more if probe
ordering requires this. In that case, avoid to re-add already activated
watchdog devices.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
Tested-by: Hung-Chun Tseng <alan.tseng.cs@gmail.com> # qemu-riscv64 S-mode
---
 drivers/watchdog/wdt-uclass.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/watchdog/wdt-uclass.c b/drivers/watchdog/wdt-uclass.c
index 88c5cbdf508..338b03f0121 100644
--- a/drivers/watchdog/wdt-uclass.c
+++ b/drivers/watchdog/wdt-uclass.c
@@ -105,6 +105,13 @@ int initr_watchdog(void)
 	}
 
 	uclass_foreach_dev(dev, uc) {
+		/*
+		 * initr_watchdog might be called multiple times to resolve
+		 * for probe ordering issues. Skip already activated devices.
+		 */
+		if (device_active(dev))
+			continue;
+
 		ret = device_probe(dev);
 		if (ret) {
 			log_debug("Error probing %s: %d\n", dev->name, ret);
-- 
2.47.3


Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0CF8CA5FCC
	for <u-boot@archiver.kernel.org>; Thu,  1 Oct 2026 11:56:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E191281291;
	Thu,  1 Oct 2026 11:56:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1ahwdGCEnS8S; Thu,  1 Oct 2026 11:56:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org E279B812FD
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790855810;
	b=SyglgohxSnBKCrs38f9zey8MMBcK2ejHj7xTm40PwFaMOgZKu7VBtLPXkhsk+TvR0Chr
	 myC6bQGaKtz+jJnh+0gKSIC1fqV/vMDjj1C0ONDDQo7Pll+wAglXYdIk7XNwq98lHI28b
	 mltuyxmgw2c6+7dUBBzBCJCjGSq8uDPY4WcjJnkyrqd9wmNuuhrBPhEAY0G5y+VKhJkuQ
	 s0eqtExLVxaGuvvA5jeMssUBca3bPaqJNf0aRYGS0fheqw6UFV0ATXm42jxpb0GsYdkma
	 DpxzYGa6+g2mIfpaI1TSjSAQKgem5T1BKfza5EZUaxHJas0o82gGOKXc/J79dfNw3Bg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790855810;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Rspamd-Queue-Id:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=c7QVUZE4+ONS6lu7xHn+f4jgCULrJW0m00hNjatzVLw=;
	b=HX8vyVcJnb2B5umvVqM3uRSORVAZAsK6fRSmZqihFRJs8i3FeUvqM/6KVOMoXkYO2Fkq
	 DadKdr5o278hx/HKW/4IpYliyWCrdg869i8oC3gVG43CmdHOa0DRyPg/pakz3e6bCEJJ6
	 bCyNsgRa3WjdgKt77GBvJjJ4PxK8hBecrBi1GylRpoa5jWFSC3LS23Z5Ava21fa0Ram11
	 yvm9z/ibWcqmDzlfJtgj86lHtAme1vk6wFwrfLQnqtvsPe2GfzM2ddCirbec0vu8FTeW8
	 nKwEVv+8pZEz/pxBgJZc3GxlcnGTnrnKlZCqHzB249kJJwPGauQFZSdhcc2ORFSpN8g==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790855810;
	bh=c7QVUZE4+ONS6lu7xHn+f4jgCULrJW0m00hNjatzVLw=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ojRl64nFWYgcUeY3r39TrWo2z9UDL4xTMahdIN/RT6PbaYw23wpGaTcopRsEebt/Q
	 NhgAucUE0eOmDsQuzpaG2gVjXDs4hcHWqGKaXi2UGXh+b8+ZKujEpf15Pt6FdO4I+7
	 JFT0ftJ7y81NtfOR9B1CVQ0GT1obEntSkrwBusc1yRX3IJt+xK94qDbquuU+i3VBKu
	 VI1RxBcJpY4MsAKSEPWtOx/5UofsIxACrVj6YDr8QvPUuOoepoP35P2G3sivVSPhCN
	 /rktpuYMDQrRDaWgxNToYSKzT2XYgFpoBrX3SjNXQ65e3WlEakY50FQ30juxGy4yRf
	 SN+w7QnwnnX0g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E279B812FD;
	Thu,  1 Oct 2026 11:56:49 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 43FF433B
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 11:56:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2A288404F8
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 11:56:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DBcRYNqgRj6r for <u-boot@lists.u-boot-project.org>;
 Thu,  1 Oct 2026 11:56:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 2D60340076
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:0:465::101"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790855806;
 b=rCOvADKi2w4czejWVL9C/YRtoqzbPid8a4gSvWbaD91hxiYfJiIeh/7KMa4OJ6YuZHmp
 Z/h+RNpHRGbUFyr/IIgw1SrzPaHLH/xQQzqDvfym2peo2g+P50KkhvTX6Po5P+NyhZgAg
 LqZUA+eiDnmb/wnSyo77Xwg5uS2RryaHJzY7eIaImKGA75TaDyEF7V0C/8l2LMEYf6dqh
 eaG73b51cmUUGV6hjkA2ocvAZKNXPrYgG1FP1P96N+tUIIzCGcx7dAcb2Re+4SgBXhdva
 VopSsCamWGO4mNIjvbApaUyvv75TejlXforG4Z0tnsZE2GrJGlV0g+x6c4w5Me/gDAQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790855806;
 h=X-Greylist:Received-SPF:Received:DKIM-Signature:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 X-B4-Tracking:X-Change-ID:To:Cc:X-Rspamd-Queue-Id;
 bh=c7QVUZE4+ONS6lu7xHn+f4jgCULrJW0m00hNjatzVLw=;
 b=hL1xT6tgfniS9luqM9cWa+xtWShvUPOvKItqfMI2hXoTnmxUrgfyzYZPVRPk8bOvN1gh
 bNgzPWGRANsiF5U82rF49TzDjMNNTKoPFfWFwh8yWHK4YL/VWf86x+4LFgc/frpfnUqnT
 T1dvT3xfpE0B0Ho8+tMujnkbFzutkq0y+KM+2cjJi1uFlK0gB/V3lAMRAZfVfB2u0TypE
 Wsq2IT5P09A7qNOSJPjKns+6D9hj7chihVxI4f5AhtcdvOUnFgm+npQKpIhZmWAFpuzlq
 o5iWpTTZLpwv64zKPVQ6ZGzz5vCfhflvN2s2dIfN9Adolj7cefw0erdsi1yH+eBmJMw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=timmermann.space; 
 dkim=pass header.d=timmermann.space header.i=@timmermann.space
 header.a=rsa-sha256 header.s=MBO0001 header.b="Q3ll/hZK"; 
 arc=none smtp.remote-ip="2001:67c:2050:0:465::101"
X-Greylist: delayed 537 seconds by postgrey-1.37 at util1.osuosl.org;
 Thu, 01 Oct 2026 11:56:45 UTC
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=timmermann.space
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=timmermann.space header.i=@timmermann.space
 header.a=rsa-sha256 header.s=MBO0001 header.b=Q3ll/hZK
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::101; helo=mout-p-101.mailbox.org;
 envelope-from=foss@timmermann.space; receiver=<UNKNOWN> 
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2D60340076
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 11:56:44 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4hwVXH2747z8vD8;
 Thu, 01 Oct 2026 13:47:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=timmermann.space;
 s=MBO0001; t=1790855263;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=c7QVUZE4+ONS6lu7xHn+f4jgCULrJW0m00hNjatzVLw=;
 b=Q3ll/hZK4hPomkGZyO7TSYzXBeyafagTppSWKcbRG5DwyrDHiTmgJ1TK6hvBDcjvzW3uTI
 GnptLozIvW3+pwX5vAIv+7qbM+33ceu26yzhxTJ7cwemQvvQ6wvxxby+lMX7VB2zh4cJo3
 RmrB+dHLPY+iG5BLI+SqCcLcwkzWZBf6NnfUrckF9gkWVMOuzloE1gfHRteD4+V8AhzopN
 tISO1l3b9GDQfxrE7UTBSw86L/uiq14viYt75Tan2T2gRXAwhTugo31f9NGdpCnVE42tRI
 3GZN3VKOgsWhXgsvawzdTsB4i9Hhal1Fc22mRayNpH+iMB0tKlpuIaqYF85j3A==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of foss@timmermann.space designates
 2001:67c:2050:b231:465::202 as permitted sender)
 smtp.mailfrom=foss@timmermann.space
From: Lukas Timmermann <foss@timmermann.space>
Date: Thu, 01 Oct 2026 13:47:37 +0200
Subject: [PATCH] usb: dwc2: Add s3c6400-hsotg compatible
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261001-dwc2-compatible-v1-1-340d7fd43bde@timmermann.space>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQ6CMBBG4auQWdtk2qhRr0JclOFXx0AhLQgJ6
 d2tuPwW722UEBWJbtVGER9NOoQCe6hIXj48YbQtJsfubJmtaRdxRoZ+9JM2HQxOcHy0XvhypVK
 NEQ9d92N9/zvNzRsy/TaU8xeYyZm9cwAAAA==
X-Change-ID: 20261001-dwc2-compatible-e5e2041ac089
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marek.vasut+usb@mailbox.org>, 
 Tom Rini <trini@konsulko.com>, Lukas Timmermann <foss@timmermann.space>
X-Rspamd-Queue-Id: 4hwVXH2747z8vD8
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

Add the compatible string for the samsung,s3c6400-hsotg device.
This compatible string is already present in the upstream Linux kernel.

Tested successfully on an exynos5250-google-manta device using an upstream
device tree, which will also to be upstreamed to U-Boot soon.

Signed-off-by: Lukas Timmermann <foss@timmermann.space>
---
 drivers/usb/host/dwc2.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/host/dwc2.c b/drivers/usb/host/dwc2.c
index 16f21fa9083..1a402e96604 100644
--- a/drivers/usb/host/dwc2.c
+++ b/drivers/usb/host/dwc2.c
@@ -1367,6 +1367,7 @@ struct dm_usb_ops dwc2_usb_ops = {
 static const struct udevice_id dwc2_usb_ids[] = {
 	{ .compatible = "brcm,bcm2835-usb" },
 	{ .compatible = "brcm,bcm2708-usb" },
+	{ .compatible = "samsung,s3c6400-hsotg" },
 	{ .compatible = "snps,dwc2" },
 	{ }
 };

---
base-commit: c92d8c3c431e37a17c3b37918037dbd7ade32d1e
change-id: 20261001-dwc2-compatible-e5e2041ac089

Best regards,
--  
Lukas Timmermann <foss@timmermann.space>


Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06628CA5FAB
	for <u-boot@archiver.kernel.org>; Tue, 29 Sep 2026 00:05:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B0A2D6070E;
	Tue, 29 Sep 2026 00:05:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rSDaS7IKZdd5; Tue, 29 Sep 2026 00:05:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 0605560707
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790640303;
	b=rqcvSQso8yQyC4uRwyFq3W2tEr3lfiYSzz2rVGRvTCjvVmSV0fqRqzhV7ZLCWjpNvmOe
	 89Y0Bmg63W5Jop1AlLzEJt6tdCBIGUbetYK6fvZoiLKpahP5vdACPO4BWtqyvRUJ5/4R/
	 s25UjNyxSEspSNdFNVCxVXiWY4wfhT7AyGicBJm9+lceqPSCrf28ZQ5wV1Krn5nldj7P9
	 xPbTYxodv9HsYBDX2lHmSdaP+s8wb9x6rqatfhz3bca5RLldsCtjyEaDJj6Ha2IGAMa5h
	 czb/qv6dM1jXGF+MB3+05tZxGkzHHPiOlIOaHeLqYxhawCIEiTwd8gOWFaDCyibQHsg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790640303;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:Date:
	 From:To:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Mi3XZ22+tdgXnz9wd2KQk4vT3ASWPrV6ZCTi5ywBxaA=;
	b=JoldrhlcaR4gEYYhcI5OCEyghn2zTWSvD4gW4aGjBsT9EwKjILA67xKqO3YZ8fgZRiiU
	 r65wxYQvHCkZAS+AIs+caEV8KYTZ9HOCVultKpgZylofamY7Fov+/SmQW3oHpvBYFbdWi
	 sUMDFbZEaYajS8y7TxaAbzPnP+EU0GRThqL88IfCyZJa/gvKpt/41xkIXVbK2fcXSSoEC
	 iAtmLwEoXOkwbdQXLG+OiNsxtsOa+4UDl1X9e4fiuj5TZ7fw/jDBp5oboGDCjGNz8ASxT
	 lbr5aTCSLJKDVccZKGQ9Vb1e8PT7tDnKj17kqUr4UnCfhl8v5RAupkB/R3EJs4Sfcuw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790640303;
	bh=Mi3XZ22+tdgXnz9wd2KQk4vT3ASWPrV6ZCTi5ywBxaA=;
	h=Date:From:To:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=g+idmgi4yAXNMxL8tOeuxmBQBLuKy7X7bZtAqP6sV9NIPSFlWxXOZQiZfAo2KSZQB
	 9lx86acXdztkXPnZ1M4boLf2/xnNY745ERo4Ta0IWEwQ/Kx2G8QgY56aFaq8/vFfVe
	 uVQRpfHjDCXFqa04rBmN/DgzPvFAIEmajQ2e/p24rF2XkJC+3iQPzVqCLD2Yens+VB
	 6Cq+VLkexPsv47tmXy78o4iadLtAo1Y5H7/2l/nwxq/To5XTzV1/huUIMXLHFqNmnk
	 UgIasoLEeWBDCDZ3nIpe/IvwEyCnAnp2AV11VoHrqwrj8PZM8KCJPtW9BuE+I78Jc8
	 1jPfZR1/ZHvSQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0605560707;
	Tue, 29 Sep 2026 00:05:03 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 5E9FE3D8
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 00:05:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4D3A180C13
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 00:05:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 005MU958LCbo for <u-boot@lists.u-boot-project.org>;
 Tue, 29 Sep 2026 00:05:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org AB0FC80BD2
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a07:2ec0:3002::65"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790640300;
 b=X8mo2qKf3erZ1uhXYokbStHpKMiAEUJZvqjCOlfDPxjD4AAd0xYM03leJhbpk5XIs8i2
 VyMCeNkUdX6cfoqBHNVAJxrHiIUfbtMeSvn5FBzU6oqpwCS3O/f4gsJ/H60M2f4POm87Y
 W5CGEjV6x4WIjrfJBhw0Rg0sU0jPE4KNcueRJwnfNFFUhGdVzBG2zlygg9RmHXwRItwIZ
 Tj+eC1N65OyivAS+heNpjPmOk4rxS5lLdI/F09BSICji91JOXQF51LKRNZ5ZsR6w1ALsd
 2RwO5vP0KhSjJkEV4wg4isDm/YdGysEvTXEGUDQvybRojzth5vzFbRLIG6rtqEEP/zA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790640300;
 h=Received-SPF:Received:Date:From:To:Subject:Message-ID:References:
 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
 bh=Mi3XZ22+tdgXnz9wd2KQk4vT3ASWPrV6ZCTi5ywBxaA=;
 b=KZvBxNC7UomYqgUcZY6I0+j2e7s8jWsPpWb9u6Cdc21dmKtNwRtfJQiI2eroReB1wPQf
 8Jtp9KgwVMQVS5OJ9fDibww38eeWSt7g5TIZJ4dZXUAGwL8cA0I8izguItGGRSq88fBcr
 rF8pIwz9DevIMJXuXkyLKRdDjfwS+vdiTB6S6sNngrEYu220Zlq1wtSBUf1VsBUGpisqF
 PmWxQfKFl8oelzPDXqgpgFHYm3Pa/zd0ZOhuyD56N8fYafOKcCUuuBlY45oW63zx44dyy
 dI1SfOrDXCQ4eT3ugpl7cUofOlGG2AjLttmgMj5sHhoOuXzmroqiqYfCoWHeHRtL5Yg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=none header.from=makrotopia.org; 
 arc=none smtp.remote-ip="2a07:2ec0:3002::65"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a07:2ec0:3002::65;
 helo=pidgin.makrotopia.org; envelope-from=daniel@makrotopia.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=none (p=none dis=none)
 header.from=makrotopia.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org
 [IPv6:2a07:2ec0:3002::65])
 by smtp1.osuosl.org (Postfix) with ESMTPS id AB0FC80BD2
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 00:05:00 +0000 (UTC)
Received: from local by pidgin.makrotopia.org with esmtpsa
 (TLS1.3:TLS_AES_256_GCM_SHA384:256:X25519MLKEM768) (Exim 4.100)
 (envelope-from <daniel@makrotopia.org>) id 1xBLL7-000000001LC-1Ww2;
 Tue, 29 Sep 2026 00:04:57 +0000
Date: Tue, 29 Sep 2026 01:04:54 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Tom Rini <trini@konsulko.com>, Daniel Golle <daniel@makrotopia.org>,
 Kyungmin Park <kmpark@infradead.org>,
 Heiko Schocher <hs@nabladev.com>, Simon Glass <sjg@chromium.org>,
 Aristo Chen <aristo.chen@canonical.com>, Anton Ivanov <anton@binarly.io>,
 Weijie Gao <weijie.gao@mediatek.com>,
 u-boot@lists.u-boot-project.org, openwrt-devel@lists.openwrt.org
Subject: [PATCH 02/11] cmd: ubi: report a failed UBI block device bind
Message-ID: <1db5bc9548848bfee60b4548a5247935231e8ae3.1790626459.git.daniel@makrotopia.org>
References: <cover.1790626459.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1790626459.git.daniel@makrotopia.org>
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

ubi_blk_bind_once() drops the ubi_bind() return value, so when the bind
fails the attach still reports success and the caller finds no ubi_blk
device with nothing to explain it.

Report the errno. The attach itself is not failed: UBI is available
either way and the block device is an optional view of it, so a UBIFS
user must not lose the partition because the block layer could not be
set up.

Fixes: dec405d1653a ("cmd: ubi: create a ubi_blk device when attaching UBI")
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 cmd/ubi.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/cmd/ubi.c b/cmd/ubi.c
index 91ba21504f4..7cbb3ee8668 100644
--- a/cmd/ubi.c
+++ b/cmd/ubi.c
@@ -676,7 +676,9 @@ int ubi_detach(void)
 #if CONFIG_IS_ENABLED(UBI_BLOCK)
 static void ubi_blk_bind_once(void)
 {
+	struct udevice *parent;
 	struct udevice *dev;
+	int ret;
 
 	/*
 	 * A single ubi_blk device serves all volumes of the attached UBI
@@ -690,7 +692,11 @@ static void ubi_blk_bind_once(void)
 			return;
 	}
 
-	ubi_bind(ubi && ubi->mtd && ubi->mtd->dev ? ubi->mtd->dev : dm_root());
+	parent = ubi && ubi->mtd && ubi->mtd->dev ? ubi->mtd->dev : dm_root();
+
+	ret = ubi_bind(parent);
+	if (ret)
+		printf("Cannot create UBI block device: %d\n", ret);
 }
 #else
 static inline void ubi_blk_bind_once(void) { }
-- 
2.55.0

Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8E62C982D2
	for <u-boot@archiver.kernel.org>; Fri, 18 Sep 2026 02:48:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 61B938100C;
	Fri, 18 Sep 2026 02:48:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DZJzaNbFeRGT; Fri, 18 Sep 2026 02:48:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org B7AE281007
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789699733;
	b=bWu1k2iJZvqjf+cCXOek51rHYpEher3Jo2Ui+pQzWzpBuna1eR5RXxyhGhO1Uo+5PjFD
	 mOQVq1nejBlNdzSZkaoO9sLROsWIa5dONac02JldZEVS2HBiRglhDbJrDKpOePkfu9qxH
	 q5I7mTkSO4hmrm80x28ZN6dT/JO/DQvJxvdVzi/X/z+9ZfRoAMDe3p5/3o6wc3jQUwy52
	 iFWlKkY6EwoD6AIyfe6rZVH9FUkfVR6zYjF9uW47wGQGGZquL6ohpnAzUHkwwdy3L08WE
	 z4b43QM9W824Rc8rfZEnMMEs/cc2ZYPmKRzHvahZJWAzgMrszkBLn/diXm6yWYnfmFg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789699733;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:
	 X-Google-Original-From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=NyQGRwuo7kidvMXVF9ESwGq0Sp69MJ1Q+1iVekhW6xI=;
	b=L7dCls1ZIeJ/nBs4QWqNvJy0F0elk81YbPsnMJM90OE7OEi690qfNxfgApoUUCObCH97
	 7aKBC6O4qw58ecBV8SeHMD5R/zkoHvZyOedXMqBg5J2JgOnZFgt0RG7sXGcOFsf7WIRqv
	 YtmiDmL1YFqboAwOIOp10BRgHh4niku2g1QVf1JlvccPpzeQoIcSYlsfen4cCRzvvv+Wj
	 7YXNQLJCRtanYJ7Vh72MM4zoZIQ4ja33URcKza0QwHeuyoXWkCz22hUaPOStcuFvYhGdr
	 YACp5HDWWwgkXSxTR+ya7b8oZlR1z8S7arNMvqdRj9dl+KCEtxB69xymLbR8gjoouDw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789699733;
	bh=NyQGRwuo7kidvMXVF9ESwGq0Sp69MJ1Q+1iVekhW6xI=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=L98Yrn4vrtHKnilHSxRX5YYbPeD3X8EFYzIAJrackp5dhaeHTNKUAb/UUW0lKYylM
	 DTftWbyz7n0GAKxZl4TZfQBzm/e8q/AouOSVE3HWjebGEBBa+YqGijL0E0vZcS6HCV
	 erpLbaGd/1NmOnEvG3X2XWbweDhUd3GlkvzKbfLMfF77VOAmuCGXBNVlaghJaSCDiR
	 w3FU3n8Lv6wPMq0GCJrc7q+DWJHBh47myNsnmRB6kb5o034jLAyrvYKpnneVgYduQ3
	 ALBoi0dg8pVEP5PuANmv5ens6iz77k1Z5b3yqXIFQwimpuyeArESnOpqJxOwgtfSAj
	 5HiOfmfWKyCNA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B7AE281007;
	Fri, 18 Sep 2026 02:48:53 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 2DE74362
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 02:48:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1443F60BC1
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 02:48:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uukLRlLaB1bw for <u-boot@lists.u-boot-project.org>;
 Fri, 18 Sep 2026 02:48:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 7E23E60BAF
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:39::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789699731;
 b=mPaX8xhOsoMr9XbKHumO9pjLTsm7Irvv+BIi0NFuYnMuvY3ula0R82+tyGMnPUnFDjPe
 X8ZjcJGutOsgBUnUggnglgATe7CtIwJ8MAjEARTcdbLOEp4KYBC+rHrZH7oXIRR2hUy8x
 epwkLfbXLjocJCniN2C8Zpf7sfaohP3zynnitJLl9eCz2KCvGA/fDbEGxClt378/Rtfvu
 P/uzcJ67hcan5nfpOqqzKXoIe4HN48ckFM2z9raIBgAPJqrUYwm+MS5vtrJAanZq1qUhz
 hguIWg+G1j0zxobuDbmjDxxfD4OAXuA/ggWBw1pvB6o4LnE8MpYN+AOfXcuL0CnPWVg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789699731;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:X-Google-Original-From:To:Cc:Subject:Date:Message-Id:X-Mailer:
 MIME-Version:Content-Transfer-Encoding;
 bh=NyQGRwuo7kidvMXVF9ESwGq0Sp69MJ1Q+1iVekhW6xI=;
 b=oovJZpnvBkjM1iDP53n2rv6Sbj7WCtoJltUUnUkjv3JTOSE95VxCewTwxa6D5VCH2Y4g
 j4w14DrpIUhFklzihhC3u99bB460aEoLpV/3TdGucKMQXUw4yY8ucQefCe7sNOA/EL6+z
 OdM0LXnufftDVD1wdmnh+JXywjCT+khZtb3a1q9KUqk5vhZzWJeQvGpeHZqKmqpr2QuSo
 bl8zg0gdIq5H77u8LHI+OtP+5xXU+YhbtEnuuR88yErcQhWDK0cRskokoDBh2+kmz3lqJ
 AHphkyZTynZmrF5wfsLfQK929ttWmQDhwA08pQ5eHDWz2IKoMproU0VvIv6eH6HIorw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=LhxnDOws; 
 arc=none smtp.remote-ip="2607:f8b0:4864:39::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:39::10; helo=mail-pj2-x10.google.com;
 envelope-from=jim.t90615@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=LhxnDOws
Received: from mail-pj2-x10.google.com (mail-pj2-x10.google.com
 [IPv6:2607:f8b0:4864:39::10])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7E23E60BAF
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 02:48:50 +0000 (UTC)
Received: by mail-pj2-x10.google.com with SMTP id
 d9443c01a7336-2d8fbef5018so3334865ad.0
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 19:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789699730; x=1790304530;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=NyQGRwuo7kidvMXVF9ESwGq0Sp69MJ1Q+1iVekhW6xI=;
 b=LhxnDOwsdQEIihHbBBz6kBkfXE8hu3+wuK7kpTtSuAhxoaaLgGmlPWM5v4GYyGj49v
 m3go5NhArZNDO+QUSzLX0S6WBT7E49HXIqGTS3MYZbAuvHeX5CS8yko9pt8QjOLUQIK5
 T/gVtYSmLZDQQIA9Lf+P1ssbNOarqsTDfkvun85MJE9Xj+C9KYB+YwK/0xyPQuUCEqkq
 x5XHxIg9DMROtFDBbhCroJz3mpBunZjkn8q+0KfF+V/jP55k69t9VWdUu3H+qsm+1zgd
 sHvNb4S+L7iKKlwYsu531GoGe9F9PJFO859F01X+gVryNQ0cKaW+XsJ9t0YXCeuXmFLi
 IuoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789699730; x=1790304530;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NyQGRwuo7kidvMXVF9ESwGq0Sp69MJ1Q+1iVekhW6xI=;
 b=WtEU1GlITl1Cdqfxk5Qx/11SyjEwvVXEpwDvWcTXvgjMVKj6bPXqULyKoZbLhrhAPQ
 I4horzAavnRy7IIc4/PPN3HDHEm2OyEZCsF1l0hZuz2gkXOsOQH7UvD0URvrMGKKeVKG
 WsiWbxsoNCB3I1ejSxEZYmRkHy0YIm2UblSEW4zmOIxRWu1bGOrvFcKELhtt1FypKYpM
 0p3R+L4E3H/dyjodL5LlHCBHL1E90K8AsFqt2ZRfl4HbPLxL4NhjMG8sq0p5/BiNKIH5
 AcjLfmM3jCIR7cjUgdstlvXfNnVVLq+lqI4aQ5QPuyXjWfWULxrUuh6ZCSdTLMUTHnxJ
 xg+A==
X-Forwarded-Encrypted: i=1;
 AKwUvByt9HXCTCbbkSUsW9FqPeIy7awXVWxmmKlGei5H9rjsTmqxpQ6CT3cdLR1YLkaUpgNzeV6aZAA=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++nPSWgiKAhomsCr8QbsAgkpg+X1LGRyF8Oc3I6lZxydRWcy7Q53
 xdE0fgzt9X7EWaMmp1zjU7p+/xjBFgbDM2jLloAMxJPHsm/hXutvjpdp
X-Gm-Gg: AYBFou2wSQLi0NGooQzmaVdSH7X2HnR/HGUMDP2Zecv21SBwSkbWHK1/mAF28Fu5Ydz
 8xtK4x7sdhFnjw5VpZ9JR3Q7PXLVc8N7n3iO9/AtHPNSwc5/ImeVT//1kX8gEFUChm6Z+8k3sk+
 sLGUQ5PvA3y/DAH2Li6iYkUUoqdOms9i93vmuTm4yE5kbE9gaGSgd/xkrmKxw2eBAEpa5BIx5yj
 71ai70+Xak0dpms57xTRksvmUmqJYukpSoCLGrXSoEJntwmyMVofpESsb/7Wgu3kusGknN1tw0d
 4TX7Kvc6ofYp/Vy0toPu3L9VqKDBmiQx1o9hYc6asnokT6hcLnu0gy24O0Kw8pI2ptbxvYARjfn
 KDIiIEwywe4jFF869Yzmkh2t7Ziy8pBULWg5tYImeS79x9GMRAQKmtB3YdvKtaE22CSJLFxoeea
 5x+fUm0hQMEKaLkvf2ORLKj9bknpWHcPVQRE9RnlI0zZGF8Mvh6Qbi03f15KKM2OQHPco3gK34Y
 vrgZavzyFbss3A6tlA=
X-Received: by 2002:a17:90b:2f50:b0:39e:14db:437c with SMTP id
 98e67ed59e1d1-39e54cc2a95mr2642937a91.4.1789699730440; 
 Thu, 17 Sep 2026 19:48:50 -0700 (PDT)
Received: from cs20-buildserver.. ([2402:7500:500:6259:4c39:1ad1:29eb:e47f])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-144ce03c682sm1240479c88.10.2026.09.17.19.48.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 19:48:49 -0700 (PDT)
From: Jim Liu <jim.t90615@gmail.com>
X-Google-Original-From: Jim Liu <JJLIU0@nuvoton.com>
To: JJLIU0@nuvoton.com, jim.t90615@gmail.com, trini@konsulko.com,
 vigneshr@ti.com, takahiro.kuwano@infineon.com, dhphadke@microsoft.com
Cc: u-boot@lists.denx.de,
	u-boot@lists.u-boot-project.org
Subject: [PATCH 2/2] mtd: spi-nor-ids: add GigaDevice GD25LB512MF
Date: Fri, 18 Sep 2026 10:48:42 +0800
Message-Id: <20260918024842.1838692-1-JJLIU0@nuvoton.com>
X-Mailer: git-send-email 2.34.1
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

Add the 64MB GD25LB512MF (JEDEC ID 0xc8601a) to the SPI NOR ID table.

Signed-off-by: Jim Liu <JJLIU0@nuvoton.com>
---
 drivers/mtd/spi/spi-nor-ids.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-nor-ids.c
index 3e7096bd419..06794d5507a 100644
--- a/drivers/mtd/spi/spi-nor-ids.c
+++ b/drivers/mtd/spi/spi-nor-ids.c
@@ -187,6 +187,8 @@ const struct flash_info spi_nor_ids[] = {
 	SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK | SPI_NOR_4B_OPCODES)},
 	{INFO("gd25lb512", 0xc8671A, 0, 64 * 1024, 1024,	SECT_4K |
 	SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK | SPI_NOR_4B_OPCODES)},
+	{INFO("gd25lb512mf", 0xc8601A, 0, 64 * 1024, 1024,	SECT_4K |
+	SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK | SPI_NOR_4B_OPCODES)},
 	{INFO("gd55lb01g", 0xc8671B, 0, 64 * 1024, 2048,	SECT_4K |
 	SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK | SPI_NOR_4B_OPCODES)},
 	{INFO("gd55lb02g", 0xc8671C, 0, 64 * 1024, 4096,	SECT_4K |
-- 
2.34.1


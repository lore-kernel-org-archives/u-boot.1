Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 696BBD47CDA
	for <u-boot@archiver.kernel.org>; Fri, 16 Jan 2026 10:56:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A76983935;
	Fri, 16 Jan 2026 11:56:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="igBLch8h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D58668388D; Fri, 16 Jan 2026 11:56:23 +0100 (CET)
Received: from mx-relay50-hz3.antispameurope.com
 (mx-relay50-hz3.antispameurope.com [94.100.134.239])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D770838A5
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 11:56:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=0469552be2=max.merchel@ew.tq-group.com
ARC-Authentication-Results: i=1; mx-gate50-hz3.hornetsecurity.com 1; spf=pass
 reason=mailfrom (ip=94.100.132.6,
 headerfrom=ew.tq-group.com)
 smtp.mailfrom=ew.tq-group.com
 smtp.helo=hmail-p-smtp01-out04-hz1.hornetsecurity.com; dmarc=pass
 header.from=ew.tq-group.com orig.disposition=pass
ARC-Message-Signature: a=rsa-sha256;
 bh=bQP1z9zlt3hCkF1ZTXh0vYvdHu6zpuMigZ58bocTzp0=; c=relaxed/relaxed;
 d=hornetsecurity.com; h=from:to:date:subject:mime-version:; i=1; s=hse1;
 t=1768560980;
 b=OrbHLL4biK8LyEnsFi322SftXj049O2y9uVkL1dRKDIScGVDOSJA5K1TizZT20elkkUm9pOp
 OyP4ZGhk31BaPF3fHmtKxietqv7Jgacr93ZmzoSjsguvMR/ISx6DOtCbGSvp5mEc1go45CkALHZ
 Ls7Zpo00Mtr79WbtkzSRP4hDIIdHpRcfx80szB/Gair9Oi95jHDP+6a9y/5PURxJojjonQQiZMe
 qUgske4HnR7IjQhNGUbwae0f0peG1pTEtmkV9Eyg7CFJ7QXR4nE7tl7N9j9OfjU0YcquqPH7Gin
 kzmyGRNW2cE+2QyCpxEnY6ua82+J/l3U3b624H4wy3x9g==
ARC-Seal: a=rsa-sha256; cv=none; d=hornetsecurity.com; i=1; s=hse1;
 t=1768560980;
 b=SgHrkWHpRDWYIsI2iWqjUuyYgbNDBNZcAfrecA1+Is+rwvT+4wMCsL9zhxHV/VwV5h908tbq
 5IwSBKXhaywWV1Caqozu1KTPaOf/i9EdiHD1gSQGUpKjk3Hr3CJVPuJenmq6jFOCDX2J02Uu5+4
 TbHumRV3C7WvK1Lx/95jgq2T1VGEypAJ5hnzOLVfXd/49lQp8ZqZ3+BhuG/qJ0JfgdK5hlu6/HI
 rPRH87PiID/IYWcSHJDuCqWYEoQGJhwzJOdMQ+ypyBZdjhsXTIeawAYOXX7a3VYQUd1YDlmELbl
 zAfKWVkzfckZR34ITaGk8sAXsWUdJKQg0KZ5nn7Vywfrg==
Received: from he-nlb01-hz1.hornetsecurity.com ([94.100.132.6]) by
 mx-relay50-hz3.antispameurope.com; Fri, 16 Jan 2026 11:56:20 +0100
Received: from merchelm-W2.tq-net.de
 (host-82-135-125-110.customer.m-online.net [82.135.125.110])
 (Authenticated sender: max.merchel@ew.tq-group.com)
 by hmail-p-smtp01-out04-hz1.hornetsecurity.com (Postfix) with ESMTPSA id
 D3A99220CC5; Fri, 16 Jan 2026 11:56:05 +0100 (CET)
From: Max Merchel <Max.Merchel@ew.tq-group.com>
To: Markus Niebel <Markus.Niebel@ew.tq-group.com>,
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>
Cc: Max Merchel <Max.Merchel@ew.tq-group.com>, u-boot@lists.denx.de,
 u-boot@ew.tq-group.com
Subject: [PATCH 4/5] configs: tqma6: activate CONFIG_CMD_NFS
Date: Fri, 16 Jan 2026 11:53:38 +0100
Message-ID: <20260116105351.2934665-5-Max.Merchel@ew.tq-group.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260116105351.2934665-1-Max.Merchel@ew.tq-group.com>
References: <20260116105351.2934665-1-Max.Merchel@ew.tq-group.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-cloud-security-sender: max.merchel@ew.tq-group.com
X-cloud-security-recipient: u-boot@lists.denx.de
X-cloud-security-crypt: load encryption module
X-cloud-security-Mailarchiv: E-Mail archived for: max.merchel@ew.tq-group.com
X-cloud-security-Mailarchivtype: outbound
X-cloud-security-Virusscan: CLEAN
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on
 mx-relay50-hz3.antispameurope.com with 4dsxbp2RC5z2nGHV
X-cloud-security-connect: he-nlb01-hz1.hornetsecurity.com[94.100.132.6], TLS=1,
 IP=94.100.132.6
X-cloud-security-Digest: 64ed132b3630d8fcac95d6d70551db2c
X-cloud-security: scantime:1.930
DKIM-Signature: a=rsa-sha256;
 bh=bQP1z9zlt3hCkF1ZTXh0vYvdHu6zpuMigZ58bocTzp0=; c=relaxed/relaxed;
 d=ew.tq-group.com;
 h=content-type:mime-version:subject:from:to:message-id:date; s=hse1;
 t=1768560979; v=1;
 b=igBLch8hJ64zIp7BVvU+7gYGzzHExBO/SAyAtKAutPz9cx+8jqhjHH67L0eTUv9EcHYDIikq
 9UKEw9F+VVL5U8T89d0a4jNiiGvJBdB7RjcbS1juhlQVcn0ZKzpgQe3cRCkq6Wc8UG0wionNcWC
 YSZRgo9eBrbYavI11rvEaz02AOmDv+lM+KP8wzxoBBY/SwsKlgNCyktJ+NhpP7u9TkfhUMr0xVt
 xU0jdIaJqspv8CfLQ7+B28+qyeEMFVvtLxr3cotXz9ayx9kFJxhxcpBKlf11EkLH1NVQAGZJFDU
 eXy9cGvdRR91G+aob6TNQwXtG95hLPo98Mf0pwqLWJ9Fw==
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

activate CONFIG_CMD_NFS for nfs boot posibility

Signed-off-by: Max Merchel <Max.Merchel@ew.tq-group.com>
---
 configs/tqma6_mba6_common.defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/tqma6_mba6_common.defconfig b/configs/tqma6_mba6_common.defconfig
index 93517474b21..6865d3b2641 100644
--- a/configs/tqma6_mba6_common.defconfig
+++ b/configs/tqma6_mba6_common.defconfig
@@ -27,6 +27,7 @@ CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_SPI=y
 CONFIG_CMD_TEMPERATURE=y
+CONFIG_CMD_NFS=y
 CONFIG_CMD_DHCP=y
 CONFIG_CMD_MII=y
 CONFIG_CMD_PING=y
-- 
2.43.0


Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9545C98302
	for <u-boot@archiver.kernel.org>; Tue, 22 Sep 2026 14:28:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8DCB440B56;
	Tue, 22 Sep 2026 14:28:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PZvUbjRYbxGC; Tue, 22 Sep 2026 14:28:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 255AD407FB
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790087325;
	b=dBtSSm57P3yPcFn2ry3/wur8H86BjmEgbBhm5o10hRxqqoftUJzA7YMXAZKUZPJrXeBU
	 1znyZn/Q8R6/nmdMqC5pHnu1n0h9PBf52d5w6vKVZV0hcnh+dr95phIfw9WGFLi8Lm9Bb
	 zvx4DhAqZbiSY7MaPhREHKoA2RcJd2spIx4DdBmvL4Ljxi8jqutqRe7tPabrbMAIpbl1W
	 6OUfGN7HYrcANBRjFAyZX0N7nsA+OPJXo+qtKXk0By5WSKgxX54F3UbUhWAPG2hE3z4sg
	 igFvyvOK9lzT7a4bylJHmMK/g1z9f+uh7+dehStM1ERThz2ojzhQQ8PjSPn4UHWWf+A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790087325;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:X-QQ-mid:Message-ID:X-QQ-XMAILINFO:
	 X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=WZhNfo9Er9uB1bbaxE011zqm0v5cxHpZTsRg6Im1cb4=;
	b=KR9RR1pe+JPlVxIoCMQ7P1LA2eCFz29pgZQWYaSU5mKd+QoqrKLg3BWKyfVUFms4JsQg
	 RuMGR/M9T6306Ku2gaRP5HFQStWG1P23JGAZFCOXrMQhPVKolSCXu2fJH2rw8MaG9rxik
	 pn9+K4HkZMC464zMlmZIb/ljco+OiG3HSQMT9DYrG61MhHXTAb49Zhh4Jyex2HRekJUZw
	 hRoj5n6AhjEdRtyprIJM5+jXFIT7n0jExLXBmDAwwjlgDySO1ySwctteZwQF8907NGU8G
	 F0YJmPl1eJ7bXKL9H+TjnMHWtN9sbcPpyBg6V4dLZtK/5Yr5H1KNWGj4X1VhDJXE/tA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=pass header.from=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=kHZnyIMF;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790087325;
	bh=WZhNfo9Er9uB1bbaxE011zqm0v5cxHpZTsRg6Im1cb4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=S4CsSXkTMlWQ0Sflbe7ERHDDKxT+g/WzPAaCNb0pbiWSWbkKJPcDPuoU/00Rw7QLp
	 iKfomvQJR75rGjDwL0YndyLk4NQOKhvq9Y83N4HQpiIxeeL9kjdX9Y1epz4+GPbivm
	 I6pXM9E7B47LXiWxs2sAfPZ6xGXmo6JgP9PEp9LIQEJVwfWcFp4UX2ekwPzBFocF22
	 6x2H3cEBu1BHDAacN/5v51kqt/2BeH9zr+RLj/4iFFZGlcqekSF+sPSHa9BZaiZmJn
	 MuySBUg+3DkA1ZOxgAnEYBzFdkw34twiTJ4QU3VP77mZRQO6asti/bqlPx1mnjn9sR
	 AAptwCsQV+LWg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 255AD407FB;
	Tue, 22 Sep 2026 14:28:45 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 799A09CD
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 14:16:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6059A40761
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 14:16:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YEkM7eKdMw3M for <u-boot@lists.u-boot-project.org>;
 Tue, 22 Sep 2026 14:16:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 12E54406E6
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=162.62.57.64
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790086613;
 b=bbHXa/jlnHuLj+IB0eB+OCcvIj1pdZtWSXHw7Fk8b5K9QZAL8HFpmpD3zmBmX4tik9XJ
 A0SPYaR/zh1F2RNOKRZgwUJ+n3Vcs+Yg3iGMoPCuzvr99YuQaZ2MhvYsEucn2DLUmBcZZ
 RgFYQozwh7LwAZQE0rVftf0DL6RNErwj9XGr3eM579q77NfBKw7VSHyEv+0fLB8dEZouc
 1dwSepJa26OcQpX+u/FTe/pmVSm5fL22bYjODnMmZltUT+kYzAurDUmJjecxYJg0vB32Z
 oogmZP//n20ztopl4IXYVbDF1nXPS8d+q8oVwx7lWOq83bDJvATnxRa6VVwcjVdS9QA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790086613;
 h=Received-SPF:DKIM-Signature:Received:X-QQ-mid:Message-ID:
 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
 X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=WZhNfo9Er9uB1bbaxE011zqm0v5cxHpZTsRg6Im1cb4=;
 b=aGXfDAq99Wx6M1HGZc3GQLISHVnY1RDZZrvJBpTsXitwGen43qcL1ZqwmabziU1mBoVd
 Q1dDs75wnEjVcdq7pWLfTU3LIiSJz5rs9C4RmtzmmBK7o4c9ez70YPX67JWN0InEJvQq+
 uG4M2098xJyu2MplzGJXa2UB7uu4dqrNl6TLQJfGNg7AZMP76u9knpS3WvqIVLi1bc7d1
 W6kTStYKvq/+F7HMZ6kWDlDmgGeOiaMTCj+YrNMb2jMSbW8U/He8GPGe6QjwnyHtXM5CQ
 fWbZnu003aSntHUxsU7P2DzKHZQyZI/i1L6mLg9rF4ueAb1hdNcskJJY6V6IbsTgEDg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=qq.com; 
 dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256
 header.s=s201512 header.b=kHZnyIMF; 
 arc=none smtp.remote-ip=162.62.57.64
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=162.62.57.64;
 helo=out162-62-57-64.mail.qq.com; envelope-from=3305708832@qq.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256
 header.s=s201512 header.b=kHZnyIMF
Received: from out162-62-57-64.mail.qq.com (out162-62-57-64.mail.qq.com
 [162.62.57.64])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 12E54406E6
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 14:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1790086606; bh=WZhNfo9Er9uB1bbaxE011zqm0v5cxHpZTsRg6Im1cb4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=kHZnyIMFUn55Abg/PprlEvU27zKAQ/iUqLE915HwC7uB6iMb0NcWB77pBwhlU21c5
 fs65CUzSc8CHh06vQ/qPgGp7/a1hln3YuAYalHNfCIKXl3bpC530hfCEpFuHewTSgt
 rJWccgxXMblxXAycXmxZcLjft3kEm8TicDqhPsVQ=
Received: from kongchen-VMware-Virtual-Platform ([221.238.4.182])
 by newxmesmtplogicsvrsza73-0.qq.com (NewEsmtp) with SMTP
 id 4298ECDB; Tue, 22 Sep 2026 22:16:41 +0800
X-QQ-mid: xmsmtpt1790086604tulh75w00
Message-ID: <tencent_A7A50D32BE3CF584FAA70135E0B84EDEDA09@qq.com>
X-QQ-XMAILINFO: M1JY6XCfJolW6s/eq6lDOg1g1wlY5vDlWimGfi/TOP9ZRL+JduPOP8L2ozzeZz
 LOnmRpHsHDN8AMkdXfew/lEw8hPeoBntxjD6QVsJaXTzg8VwNSMoiYnej8LflOSvPRJ3BErXOA/A
 kLRJnTIjMxEsGkQ8PLby9nYmYHPypkKAWH/+lDSwkbWwzBbmM6XieglrENTTZwyEX+98y9eGw9ZS
 41gLGlXC3sMGPd5YaZJnesDPCFB7UZncU3/jeqkiYZi+y/40V5kTfhO58UEGCydgvt/E0ZhfNGO5
 noRjGFDsCzqXo6PuqF/sViRGITBapltsbtjtZhTnVNmRr8eON9K0CxtEcgWkIlOgnQJ1iC0JoyVm
 KcYOzzC12B2sNdLCGvYN8hq73MZHYwkKhDXTEfUIdQ6I8Fxc1mxwCqsx8IWhuJcsPSe41Knwi4BJ
 c2cvvSS+FlEr/dYJ2aYSAHQkkIv5AKJ9PbQsPDFKiPyl9rnWUP+V+LcVSulceZ4gXVVFrBr3K0rg
 de0nNy0ZRYgJRUuXDl1Ramglxj4cCK/oprGV/UKnV6+dlpi3GeInVal52WzpjvWdFXIrs5GwmPdo
 jzuLLG0VQbt7saQNZrsATTXxMlm4r27Ds/a8Jc+x18olrqlZCrKn2EvLDX1LHekVQSipcjpkcAn1
 /n00Q9+t3Xu++Dwqp1KBTZWT/Ql7mTGTTnZXvM5iDtYJxUtUtin/oPzNpAUaY1rtH8G3DnzcjAUS
 lCDZJp76UqkSgtF4fC9CbPRun/55xBeNlu1wyKkfVVHoZQUAJ9T2sLuxlZNkVS6QJbm3qlYFhn32
 AU7KmuFrrUT1OMlqkUuzMAzy4X2+kAt+xzmApryLUu/W0hmZyBQaxbQOd4VEeb4tKHio7zP1Mml1
 VFTCBhm8rMCCCPrqSJbDXQMhBBILEEHh5bzTCC+vyRR/P7ttEgBVp8B07Pq3D6spY3auTKctleTD
 O/d/T48jUFNmk9ja71mIjRP2VtnZZ/A5fgCvbUmwbj4DMYhjBNHyoQSE5aMSP6N+5Ns8da3m6eW4
 cMjj97GC54qFkar73tBm6dAC9hg47D3IaaisgPjw/D29HvDVom/RtmI92QcIBsXslMmVrb6MbxLN
 lr24ol
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
From: kongchen <3305708832@qq.com>
To: u-boot@lists.u-boot-project.org
Cc: jerome.forissier@arm.com,
	trini@konsulko.com,
	quentin.schulz@cherry.de
Subject: [PATCH 2/2] net: phy: add support for Maxio MAE0621A Ethernet PHYs
Date: Tue, 22 Sep 2026 22:16:41 +0800
X-OQ-MSGID: <20260922141641.8624-3-3305708832@qq.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260922141641.8624-1-3305708832@qq.com>
References: <20260922141641.8624-1-3305708832@qq.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 22 Sep 2026 14:28:39 +0000
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

The Maxio MAE0621A(-Q2C / -Q3C(I)) gigabit PHYs ship in a
non-functional power-on state: the clock-mode register must be
programmed for crystal operation and a set of analog tuning registers
applied before the RGMII interface starts toggling (RXC output
included).  With the generic C22 driver the RX clock never appears,
which surfaces as an EQOS DMA_MODE_SWR timeout on MACs sourcing their
RX clock from the PHY.

Port the init sequence from the vendor out-of-tree Linux driver
(MAXIO_PHY_VER v1.8.1.1): paged register writes selecting crystal
clock mode, the analog tuning sequence, and the ADC self-check loop.

Link status is read straight from BMSR (read twice per the IEEE 802.3
latching rules) instead of waiting on the autoneg-complete bit: this
PHY reports link before aneg-complete settles, which the vendor Linux
driver works around as well.

PHY ID1 has been observed reading 0xffff on a board where the vendor
kernel reads 0x7b74, so match on the low 16 ID bits only: Q2C ends in
0x4411, Q3C(I) in 0x4412.

Signed-off-by: kongchen <3305708832@qq.com>
---
 drivers/net/phy/Kconfig  |   8 ++
 drivers/net/phy/Makefile |   1 +
 drivers/net/phy/maxio.c  | 228 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 237 insertions(+)
 create mode 100644 drivers/net/phy/maxio.c

diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
index ee438524490..02aeb1db977 100644
--- a/drivers/net/phy/Kconfig
+++ b/drivers/net/phy/Kconfig
@@ -238,6 +238,14 @@ config PHY_MOTORCOMM
 	  Enables support for Motorcomm network PHYs.
 	  Currently supports the YT8511 and YT8531 Gigabit Ethernet PHYs.
 
+config PHY_MAXIO
+	bool "Maxio PHYs"
+	help
+	  Enables support for Maxio network PHYs.
+	  Currently supports the MAE0621A/MAE0621B Gigabit Ethernet PHYs,
+	  which require a vendor init sequence (crystal clock mode plus
+	  analog tuning) before their RGMII interface comes up.
+
 config PHY_MSCC
 	depends on !COMPILE_TEST
 	bool "Microsemi Corp Ethernet PHYs support"
diff --git a/drivers/net/phy/Makefile b/drivers/net/phy/Makefile
index 83520de7f1f..bd57fa005b1 100644
--- a/drivers/net/phy/Makefile
+++ b/drivers/net/phy/Makefile
@@ -21,6 +21,7 @@ obj-$(CONFIG_PHY_ET1011C) += et1011c.o
 obj-$(CONFIG_PHY_LXT) += lxt.o
 obj-$(CONFIG_PHY_MARVELL) += marvell.o
 obj-$(CONFIG_PHY_MARVELL_10G) += marvell10g.o
+obj-$(CONFIG_PHY_MAXIO) += maxio.o
 obj-y += mediatek/
 obj-y += airoha/
 obj-$(CONFIG_PHY_MICREL_KSZ8XXX) += micrel_ksz8xxx.o
diff --git a/drivers/net/phy/maxio.c b/drivers/net/phy/maxio.c
new file mode 100644
index 00000000000..c673a342093
--- /dev/null
+++ b/drivers/net/phy/maxio.c
@@ -0,0 +1,228 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Maxio MAE0621A PHY driver, ported from the vendor out-of-tree
+ * Linux driver (MAXIO_PHY_VER "v1.8.1.1").
+ *
+ * The PHY comes up in a non-functional state: the clock-mode register
+ * must be programmed for crystal operation and a set of analog tuning
+ * registers applied before the RGMII interface starts toggling.  The
+ * generic C22 driver leaves the RX clock dead, which makes the MAC's
+ * EQOS_DMA_MODE_SWR reset never complete.
+ */
+
+#include <phy.h>
+#include <linux/bitops.h>
+#include <linux/delay.h>
+
+#define PHY_ID_MAE0621A			0x7b744411
+#define PHY_ID_MAE0621A_Q3C		0x7b744412
+#define PHY_ID_MASK				0x7fffffff
+
+#define MAXIO_PAGE_SELECT		0x1f
+
+/* Vendor status register, page 0xa43 */
+#define MAXIO_PHYSR				0x1a
+#define MAXIO_PHY_LINK			BIT(2)
+#define MAXIO_PHY_DUPLEX		BIT(3)
+#define MAXIO_PHY_SPEED_MASK	GENMASK(5, 4)
+#define MAXIO_PHY_1000M			BIT(5)
+#define MAXIO_PHY_100M			BIT(4)
+
+static int maxio_write_paged(struct phy_device *phydev, int page,
+			     int regnum, u16 val)
+{
+	int ret;
+
+	ret = phy_write(phydev, MDIO_DEVAD_NONE, MAXIO_PAGE_SELECT, page);
+	if (ret < 0)
+		return ret;
+
+	ret = phy_write(phydev, MDIO_DEVAD_NONE, regnum, val);
+
+	phy_write(phydev, MDIO_DEVAD_NONE, MAXIO_PAGE_SELECT, 0);
+
+	return ret;
+}
+
+static int maxio_read_paged(struct phy_device *phydev, int page, int regnum)
+{
+	int ret;
+
+	ret = phy_write(phydev, MDIO_DEVAD_NONE, MAXIO_PAGE_SELECT, page);
+	if (ret < 0)
+		return ret;
+
+	ret = phy_read(phydev, MDIO_DEVAD_NONE, regnum);
+
+	phy_write(phydev, MDIO_DEVAD_NONE, MAXIO_PAGE_SELECT, 0);
+
+	return ret;
+}
+
+static int maxio_adcc_check(struct phy_device *phydev)
+{
+	int adcvalue, regval, i;
+
+	maxio_write_paged(phydev, 0xd96, 0x2, 0x1fff);
+	maxio_write_paged(phydev, 0xd96, 0x2, 0x1000);
+
+	for (i = 0; i < 4; i++) {
+		regval = 0xf908 + i * 0x100;
+		maxio_write_paged(phydev, 0xd8f, 0xb, regval);
+		adcvalue = maxio_read_paged(phydev, 0xd92, 0xb);
+		if (!(adcvalue & 0x1ff))
+			return -1;
+	}
+
+	return 0;
+}
+
+static void maxio_self_check(struct phy_device *phydev, int checknum)
+{
+	int ret, i;
+
+	for (i = 0; i < checknum; i++) {
+		ret = maxio_adcc_check(phydev);
+		if (!ret)
+			break;
+
+		maxio_write_paged(phydev, 0x0, 0x0, 0x1940);
+		phy_write(phydev, MDIO_DEVAD_NONE, MAXIO_PAGE_SELECT, 0x0);
+		mdelay(10);
+		maxio_write_paged(phydev, 0x0, 0x0, 0x1140);
+		maxio_write_paged(phydev, 0x0, 0x0, 0x9140);
+	}
+
+	maxio_write_paged(phydev, 0xd96, 0x2, 0xfff);
+	maxio_write_paged(phydev, 0x0, 0x0, 0x9140);
+	phy_write(phydev, MDIO_DEVAD_NONE, MAXIO_PAGE_SELECT, 0x0);
+}
+
+static int mae0621a_config(struct phy_device *phydev)
+{
+	pr_info("Maxio MAE0621A init (crystal clock mode + analog tuning)\n");
+
+	maxio_write_paged(phydev, 0xd92, 0x2, 0x200a);	/* clock mode: crystal */
+
+	maxio_write_paged(phydev, 0xda0, 0x10, 0xc13);
+	maxio_write_paged(phydev, 0x0, 0xd, 0x7);
+	maxio_write_paged(phydev, 0x0, 0xe, 0x3c);
+	maxio_write_paged(phydev, 0x0, 0xd, 0x4007);
+	maxio_write_paged(phydev, 0x0, 0xe, 0x0);
+	maxio_write_paged(phydev, 0xd96, 0x13, 0x7bc);
+	maxio_write_paged(phydev, 0xd8f, 0x8, 0x2500);
+	maxio_write_paged(phydev, 0xd90, 0x2, 0x1555);
+	maxio_write_paged(phydev, 0xd90, 0x5, 0x2b15);
+	maxio_write_paged(phydev, 0xd92, 0x14, 0xa);
+	maxio_write_paged(phydev, 0xd91, 0x7, 0x5b00);
+	maxio_write_paged(phydev, 0xd8f, 0x0, 0x300);
+	maxio_write_paged(phydev, 0xd92, 0xa, 0x8506);
+	maxio_write_paged(phydev, 0xd91, 0x6, 0x6870);
+	maxio_write_paged(phydev, 0xd91, 0x1, 0x940);
+	maxio_write_paged(phydev, 0xda0, 0x13, 0x1303);
+	maxio_write_paged(phydev, 0xd97, 0xc, 0x177);
+	maxio_write_paged(phydev, 0xd97, 0xb, 0x9a9);
+	maxio_write_paged(phydev, 0xa42, 0x12, 0x28);
+	maxio_write_paged(phydev, 0x0, 0x4, 0xde1);
+	maxio_write_paged(phydev, 0x0, 0x0, 0x9140);
+
+	maxio_self_check(phydev, 50);
+	mdelay(100);
+
+	return 0;
+}
+
+static int mae0621a_q3c_config(struct phy_device *phydev)
+{
+	maxio_write_paged(phydev, 0xa43, 0x19, 0x823);
+
+	maxio_write_paged(phydev, 0xdab, 0x17, 0xc13);
+	maxio_write_paged(phydev, 0xd96, 0x15, 0xc08a);
+	maxio_write_paged(phydev, 0xda4, 0x12, 0x7bc);
+	maxio_write_paged(phydev, 0xd8f, 0x16, 0x2500);
+	maxio_write_paged(phydev, 0xd90, 0x16, 0x1555);
+	maxio_write_paged(phydev, 0xd92, 0x11, 0x2b15);
+	maxio_write_paged(phydev, 0xd96, 0x16, 0x4010);
+	maxio_write_paged(phydev, 0xda5, 0x11, 0x4a12);
+	maxio_write_paged(phydev, 0xda5, 0x12, 0x4a12);
+	maxio_write_paged(phydev, 0xd99, 0x16, 0xa);
+	maxio_write_paged(phydev, 0xd95, 0x13, 0x5b00);
+	maxio_write_paged(phydev, 0xd8f, 0x10, 0x300);
+	maxio_write_paged(phydev, 0xd98, 0x17, 0x8506);
+	maxio_write_paged(phydev, 0xd95, 0x12, 0x6870);
+	maxio_write_paged(phydev, 0xd93, 0x15, 0x940);
+	maxio_write_paged(phydev, 0xdad, 0x12, 0x1303);
+	maxio_write_paged(phydev, 0xda8, 0x11, 0x177);
+	maxio_write_paged(phydev, 0xda8, 0x10, 0x9a9);
+	maxio_write_paged(phydev, 0xa42, 0x12, 0x28);
+	maxio_write_paged(phydev, 0x0, 0x4, 0xde1);
+	maxio_write_paged(phydev, 0x0, 0x0, 0x9140);
+
+	phy_write(phydev, MDIO_DEVAD_NONE, MAXIO_PAGE_SELECT, 0);
+
+	return 0;
+}
+
+static int mae0621a_startup(struct phy_device *phydev)
+{
+	int bmsr, physr;
+
+	/*
+	 * Read link straight from BMSR (twice: the link bit is latched low
+	 * per IEEE 802.3).  Do not wait on the autoneg-complete bit: this
+	 * PHY reports link before aneg-complete settles, which the vendor
+	 * kernel driver also works around.
+	 */
+	bmsr = phy_read(phydev, MDIO_DEVAD_NONE, MII_BMSR);
+	if (bmsr < 0)
+		return bmsr;
+	bmsr = phy_read(phydev, MDIO_DEVAD_NONE, MII_BMSR);
+	if (bmsr < 0)
+		return bmsr;
+
+	phydev->link = !!(bmsr & BMSR_LSTATUS);
+	if (!phydev->link)
+		return 0;
+
+	physr = maxio_read_paged(phydev, 0xa43, MAXIO_PHYSR);
+	if (physr < 0)
+		return physr;
+
+	if ((physr & MAXIO_PHY_SPEED_MASK) == MAXIO_PHY_1000M)
+		phydev->speed = SPEED_1000;
+	else if ((physr & MAXIO_PHY_SPEED_MASK) == MAXIO_PHY_100M)
+		phydev->speed = SPEED_100;
+	else
+		phydev->speed = SPEED_10;
+
+	phydev->duplex = (physr & MAXIO_PHY_DUPLEX) ? DUPLEX_FULL : DUPLEX_HALF;
+
+	return 0;
+}
+
+/*
+ * This PHY has been observed reporting 0xffff for PHY ID1 on this board
+ * (raw, pre-init state) while the vendor kernel reads 0x7b74, so match on
+ * the ID2 low bits only; Q2C ends in 0x4411 and Q3C in 0x4412.
+ */
+#define PHY_ID_MATCH_LOW16		0x0000ffff
+
+U_BOOT_PHY_DRIVER(mae0621a) = {
+	.name		= "Maxio MAE0621A-Q2C Gigabit Ethernet",
+	.uid		= PHY_ID_MAE0621A,
+	.mask		= PHY_ID_MATCH_LOW16,
+	.features	= PHY_GBIT_FEATURES,
+	.config		= &mae0621a_config,
+	.startup	= &mae0621a_startup,
+	.shutdown	= &genphy_shutdown,
+};
+
+U_BOOT_PHY_DRIVER(mae0621a_q3c) = {
+	.name		= "Maxio MAE0621A/B-Q3C(I) Gigabit Ethernet",
+	.uid		= PHY_ID_MAE0621A_Q3C,
+	.mask		= PHY_ID_MATCH_LOW16,
+	.features	= PHY_GBIT_FEATURES,
+	.config		= &mae0621a_q3c_config,
+	.startup	= &mae0621a_startup,
+	.shutdown	= &genphy_shutdown,
+};
-- 
2.55.0


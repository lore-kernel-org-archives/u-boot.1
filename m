Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B426C87FC9
	for <u-boot@archiver.kernel.org>; Wed, 30 Jul 2025 23:54:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EAC018319C;
	Thu, 31 Jul 2025 01:54:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="AO2jPqx9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A464C8319C; Thu, 31 Jul 2025 01:54:01 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6C86F8324C
 for <u-boot@lists.denx.de>; Thu, 31 Jul 2025 01:53:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=5dd1=2M=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1753919637; bh=YnfLwQJT9XunKzGiHFaIqRNDAEHSyDzFwzgUHJrVoL0=;
 b=AO2jPqx93MLmq09U3oROymW5e2+cZJjvZ8SG1iCLF1xEKOesoGR89yfIhbsEWCdh67G6q+WoD
 IKws7aBldRSQf4bEV7Tc0+OpF+VfJKY691zPK5D+m50jy0Vh1BY21t4rIemoXzlZxojd19hoAp6
 +IkJ34okl8SzSeXCH3RrkeY7rsvyq/FkNNjNFvUjcHLSEbhwPOfW2r4u5iIK76r5MQ0N3Xyi1nk
 D0kyyoptm4UNigMCSvfsm03ADUKsg/FqnISmA8UZB0QRx93jBPYW74AzG5WPdpGaztB/HjiLJ1E
 ZxnCA6qIrNxiylXKs5iUZfj7HzPaJnda3Z9dvTihfLtg==
X-Forward-Email-ID: 688ab0661851584377f6208b
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 1.1.8
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Jonas Karlman <jonas@kwiboo.se>
Cc: Yao Zi <ziyao@disroot.org>, Chukun Pan <amadeus@jmu.edu.cn>,
 u-boot@lists.denx.de
Subject: [PATCH 1/8] rockchip: rk3528-generic: Fix boot after dts/upstream
 v6.16-dts merge
Date: Wed, 30 Jul 2025 23:52:42 +0000
Message-ID: <20250730235301.1774089-2-jonas@kwiboo.se>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250730235301.1774089-1-jonas@kwiboo.se>
References: <20250730235301.1774089-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The rk3528-generic target can no longer boot after v6.16-dts was merged
into dts/upstream, and instead end up in a boot loop:

  No serial driver found
  resetting ...

After Linux commit 34d2730fbbdd ("arm64: dts: rockchip: move rk3528
i2c+uart aliases to board files") there is no longer an alias for
serial0 defined for the U-Boot only rk3528-generic device tree.

Add a board specific aliases node that include the missing serial0 alias
to resolve the boot issue and ensure that stdout-path = "serial0:..."
can be resolved by U-Boot.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm/dts/rk3528-generic.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/dts/rk3528-generic.dts b/arch/arm/dts/rk3528-generic.dts
index 3f6f0bed108d..fe9e72c41cd7 100644
--- a/arch/arm/dts/rk3528-generic.dts
+++ b/arch/arm/dts/rk3528-generic.dts
@@ -10,6 +10,11 @@
 	model = "Generic RK3528";
 	compatible = "rockchip,rk3528";
 
+	aliases {
+		mmc0 = &sdhci;
+		serial0 = &uart0;
+	};
+
 	chosen {
 		stdout-path = "serial0:1500000n8";
 	};
-- 
2.50.1


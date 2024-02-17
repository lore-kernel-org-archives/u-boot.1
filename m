Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 653F5C48260
	for <u-boot@archiver.kernel.org>; Sat, 17 Feb 2024 00:40:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 02A1087EAF;
	Sat, 17 Feb 2024 01:27:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="HCF1D3tK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9310687E86; Sat, 17 Feb 2024 01:27:04 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5FD8287E6F
 for <u-boot@lists.denx.de>; Sat, 17 Feb 2024 01:26:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=4c2a=J2=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1708129447; bh=6M6pl2m1kCaEBFxfGsETYSpjUuJw/7PZoN7lGWjge20=;
 b=HCF1D3tKl9djE/EzWYbrVx4cmSydMU+yXg2xve6Y8pdNHWJGHobNmAdZ0NGH/e0MTGGK9QOjg
 IYhOolc17puij6OXsuUKga4uocCa4JlcF+ntKQ2YVB7R2BQSJZaovVnblY7COnSyeu7kyVdFSQj
 DLV5kYZUsl48P1jjykG+khIH+AK4zQfgmmYbXsdkCmL67q4mQYUYWQtymBhvu1cGQKeN2A4SXbV
 6U7FnnU25IuYzJGv/bmd4QZQm28JRIf6N289xea5JqjXEAYWwseS7cMT8Qm9rbvx0yitp8XehHY
 hnf1cKaegUm3pJCe75uOyynXZxLCKkkgaZhkG+KK9N1w==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Dragan Simic <dsimic@manjaro.org>, Tianling Shen <cnsztl@gmail.com>,
 u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v2 12/15] Revert "rockchip: Allow booting from SPI"
Date: Sat, 17 Feb 2024 00:22:38 +0000
Message-ID: <20240217002304.2141064-13-jonas@kwiboo.se>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240217002304.2141064-1-jonas@kwiboo.se>
References: <20240217002304.2141064-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 65cffca5bb96cee8b5411f57
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

This reverts commit 3523c07867b403d5b3b68812aebac8a5afa5be4c.

Booting from SPI was already allowed before this commit was first
introduced. A few lines further down the exact same code already existed
and still does.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
v2:
- No change
---
 arch/arm/mach-rockchip/spl-boot-order.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm/mach-rockchip/spl-boot-order.c b/arch/arm/mach-rockchip/spl-boot-order.c
index 2c39a215c107..79c856d2a0ac 100644
--- a/arch/arm/mach-rockchip/spl-boot-order.c
+++ b/arch/arm/mach-rockchip/spl-boot-order.c
@@ -65,9 +65,6 @@ static int spl_node_to_boot_device(int node)
 		default:
 			return -ENOSYS;
 		}
-	} else if (!uclass_get_device_by_of_offset(UCLASS_SPI_FLASH, node,
-		&parent)) {
-		return BOOT_DEVICE_SPI;
 	}
 
 	/*
-- 
2.43.0


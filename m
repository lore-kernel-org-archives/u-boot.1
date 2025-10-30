Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39F72CCF9F6
	for <u-boot@archiver.kernel.org>; Thu, 30 Oct 2025 06:25:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BBF2F838D5;
	Thu, 30 Oct 2025 07:25:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=freeshell.de header.i=@freeshell.de header.b="XmHm1aNh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A4EC838D7; Thu, 30 Oct 2025 07:25:23 +0100 (CET)
Received: from freeshell.de (freeshell.de [116.202.128.144])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D1F483849
 for <u-boot@lists.denx.de>; Thu, 30 Oct 2025 07:25:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=e@freeshell.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
 s=s2025; t=1761805470;
 bh=nyG7mv+P3R2nf2IPc6B9Z22Ur2ugPTyB+otRUy2TNnE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=XmHm1aNhSxt8UyjHc7f2NkK8zhFknIx7Vjhwv2caQK9x3qo9H3PHnsjCEYR9c0Nw8
 39IMIaZRPbBOJgqAnil5cqQo3AGo5fA7VjCrU/fX92ER3sfRoplDROBDF3GRQ6vgoJ
 aWfyv+IOJNaNK/7F1KAoxYHZ6apQJo0zMQfWvlV3wu26anQbyfBFc/fwk8tGUYt5iY
 B7KFST45PqGf/9EEHO2kKKC5jJHpdGOK3MaiwbHwR6jI/FPNtBOILw6EA9HpzzdUvI
 6M8QuqFsohscmCyGg+kmkMAiJIhdzLOx8LBW8IXrkHqmmuB6tsRD4WiB4K7lUtLnxc
 QGpgnxtZuBAfA==
Received: from hay.lan (unknown [IPv6:2605:59c0:2078:cf00:6ecf:39ff:fe00:8375])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 9F827B220130;
 Thu, 30 Oct 2025 07:24:28 +0100 (CET)
From: E Shattow <e@freeshell.de>
To: Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, Leo Liang <ycliang@andestech.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
	E Shattow <e@freeshell.de>
Subject: [PATCH v1 1/3] ram: starfive: drop references to 16GB memory size
Date: Wed, 29 Oct 2025 23:23:32 -0700
Message-ID: <20251030062354.35413-2-e@freeshell.de>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20251030062354.35413-1-e@freeshell.de>
References: <20251030062354.35413-1-e@freeshell.de>
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

16GB memory size is not addressable on StarFive JH-7110 SoC because the
DRAM uncached alias begins at +8GB offset from start of DRAM. The logic
for 16GB memory size is a fall-through to the default for an unknown size.
Let's drop this unnecessary 16GB memory size and rely on the case default.

Signed-off-by: E Shattow <e@freeshell.de>
---
 drivers/ram/starfive/ddrcsr_boot.c  | 3 ---
 drivers/ram/starfive/ddrphy_start.c | 1 -
 drivers/ram/starfive/starfive_ddr.c | 1 -
 drivers/ram/starfive/starfive_ddr.h | 1 -
 4 files changed, 6 deletions(-)

diff --git a/drivers/ram/starfive/ddrcsr_boot.c b/drivers/ram/starfive/ddrcsr_boot.c
index 6764b3ed5cc..ece6f5aae94 100644
--- a/drivers/ram/starfive/ddrcsr_boot.c
+++ b/drivers/ram/starfive/ddrcsr_boot.c
@@ -231,7 +231,6 @@ void ddrcsr_boot(u32 *csrreg, u32 *secreg, u32 *phyreg, enum ddr_size_t size)
 		mask = REG8G;
 		break;
 
-	case DDR_SIZE_16G:
 	default:
 		return;
 	};
@@ -260,7 +259,6 @@ void ddrcsr_boot(u32 *csrreg, u32 *secreg, u32 *phyreg, enum ddr_size_t size)
 		out_le32(csrreg + REGOFFSET(0x10), 0x3c);
 		break;
 
-	case DDR_SIZE_16G:
 	default:
 		break;
 	};
@@ -286,7 +284,6 @@ void ddrcsr_boot(u32 *csrreg, u32 *secreg, u32 *phyreg, enum ddr_size_t size)
 		break;
 
 	case DDR_SIZE_2G:
-	case DDR_SIZE_16G:
 	default:
 		break;
 	};
diff --git a/drivers/ram/starfive/ddrphy_start.c b/drivers/ram/starfive/ddrphy_start.c
index efe3f8a181a..f26bc9ccaad 100644
--- a/drivers/ram/starfive/ddrphy_start.c
+++ b/drivers/ram/starfive/ddrphy_start.c
@@ -267,7 +267,6 @@ void ddr_phy_start(u32 *phyreg, enum ddr_size_t size)
 		mask = REG8G;
 		break;
 
-	case DDR_SIZE_16G:
 	default:
 		return;
 	};
diff --git a/drivers/ram/starfive/starfive_ddr.c b/drivers/ram/starfive/starfive_ddr.c
index b31ed3bcf61..9e902f03ee9 100644
--- a/drivers/ram/starfive/starfive_ddr.c
+++ b/drivers/ram/starfive/starfive_ddr.c
@@ -47,7 +47,6 @@ static int starfive_ddr_setup(struct udevice *dev, struct starfive_ddr_priv *pri
 		size = DDR_SIZE_8G;
 		break;
 
-	case 0x400000000:
 	default:
 		pr_err("unsupport size %lx\n", priv->info.size);
 		return -EINVAL;
diff --git a/drivers/ram/starfive/starfive_ddr.h b/drivers/ram/starfive/starfive_ddr.h
index c29d26b510c..3ab0b0e8fa6 100644
--- a/drivers/ram/starfive/starfive_ddr.h
+++ b/drivers/ram/starfive/starfive_ddr.h
@@ -48,7 +48,6 @@ enum ddr_size_t {
 	DDR_SIZE_2G,
 	DDR_SIZE_4G,
 	DDR_SIZE_8G,
-	DDR_SIZE_16G,
 };
 
 void ddr_phy_train(u32 *phyreg);
-- 
2.50.0


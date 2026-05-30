Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15AB7CD6E4A
	for <u-boot@archiver.kernel.org>; Sat, 30 May 2026 07:05:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 206B3846E2;
	Sat, 30 May 2026 09:05:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="pecYgL2A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA0D083DA6; Sat, 30 May 2026 07:38:33 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 14245805D7
 for <u-boot@lists.denx.de>; Sat, 30 May 2026 07:38:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rmandrad@gmail.com
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-48fde648a71so95396765e9.0
 for <u-boot@lists.denx.de>; Fri, 29 May 2026 22:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780119511; x=1780724311; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=B82Dwyc8ol/SIhxc8BXDC9xPi4WMccTa0FeBk/KG7dM=;
 b=pecYgL2AxTJ04WilJcsG6Cl1oosN/f9F8bajeFvSmIc9ZQM7KcAjRdpAwAKx6vBqra
 szJak7m+nFspSTUUb04DF3EHTTZTID5Op8lV2S9L4i3LlEiM/IHBpJdzbq/AdbF3D3Ll
 I8UMUTsAq8CVHp1RUozCvqD0jFlZLJTxhuyAzrJByWyNaz9uNJuOu2o59AZ70dlSzMDG
 l4c6x9uF5oTdSYGHQDnvq0atUqxAN8xsenHbPEJxqeUiwkV35obXGHqz9gl8QPUcFSU+
 Jh/jiubY4QHPAGFgOv9nVDix+FG11dOsnW8Dpl9smtuXWKFRkytbUrC1tqKF3xDmg2nh
 vRjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780119511; x=1780724311;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B82Dwyc8ol/SIhxc8BXDC9xPi4WMccTa0FeBk/KG7dM=;
 b=PtSZxfR6Z5N7h2jckhhu+SBCLtTgqIcKSRNw0ow118ejfUevFMn4CKztcBkCbLWsq+
 VooQos9TncTPmx+PFYnEHi2fUBZAiZSENV2MScMjdDwWSvP4g5etoXUiZ4upc69u74ZC
 DK1LJ6bdOy7N+/Hn0Z4ZGoBRu41VTfzP4BqV61plOKcSS8vG49iHC+CBdwa6wNhTNgVr
 S7/urbm5do3WSIBop8WFzKaZyTGekvs1ys0wRft9jPtK/RH2E6h9q+hrE6Gg+rZJ2+IH
 No7S0MNtEQvkT2xSQB0P8lS7NRSovyMizQ0rb4KFdVVdKIeSk9WlRy2eDHB9KeC5XP5I
 n1zQ==
X-Gm-Message-State: AOJu0YzAyCMEkawUPEv5k4dyrdOWV3cOyRhrdiOS4/7t/bD3HprQsBhL
 db5gBcJFeCEVyEEnohU4s+pKNMJQ+097OOdnWqcpAGq5YfSL7j6UY0xKsodUn7w=
X-Gm-Gg: Acq92OHDwSGZh+nBLbt1w+7OYXwXbkc2N/YLjjJmkQe/xR6zqtCywtekq5776VcgCIm
 Rao5YmYrTLHXcFnpGZhreOgMlCqX4wBTnRdWJo9zyuPVfLI9JHrcqCR4QxHEJlNCjNW5l8E7cRs
 TZMwZe+xIAAZoLmM9TPgs3QTNx/2j+AZQ4Ss1Dh+Ee/hh3zPFL46hYa63RpyyGV+OK4V9WNu16t
 LJffH/vM5OQae1oBKXXbmWDwViBWZS4hwD99XJj0hitp7vQUzqttIVT078H9pkYrcRJXemaZiuE
 DKtawIfuNbKgMyMJ8ErezTh3/wAb/FOEBFJ5hPa4RhphIVXRGbAOI4jeNgdaL/5eeLHUlSTdRa1
 gwqzM9wMfgvGM30QREbojTAqj3krNETEumyvcsOxZo6WB5fp9BujO/q/9BKXRPyaRETA1w3uwpu
 UNW5/L4r6kMCdMoL8MKn581If2mIKMSPxFA58604L6blCL5oGNl0s3rvWy5yfSQA5o/eu3+Cjyf
 WhAhT/o
X-Received: by 2002:a05:600c:45c9:b0:490:8b0b:d3b1 with SMTP id
 5b1f17b1804b1-490a2a4bac0mr27329685e9.12.1780119511391; 
 Fri, 29 May 2026 22:38:31 -0700 (PDT)
Received: from nuclin (cpc112753-pert6-2-0-cust678.16-4.cable.virginm.net.
 [86.18.22.167]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4909cab0e79sm163458445e9.13.2026.05.29.22.38.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 22:38:30 -0700 (PDT)
From: Rudy Andram <rmandrad@gmail.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, ryder.lee@mediatek.com, weijie.gao@mediatek.com,
 chunfeng.yun@mediatek.com, igor.belwon@mentallysanemainliners.org,
 dlechner@baylibre.com, jstephan@baylibre.com,
 GSS_MTK_Uboot_upstream@mediatek.com, emanuele.ghidoli@toradex.com,
 Rudy Andram <rmandrad@gmail.com>
Subject: [PATCH] arm: mediatek: mt7988: restore full DRAM bank reporting
Date: Sat, 30 May 2026 06:37:05 +0100
Message-ID: <20260530053705.2140146-1-rmandrad@gmail.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 30 May 2026 09:05:21 +0200
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

MT7988 detects the full installed DRAM in dram_init(), but after
commit bddd6bbef3dc ("arm: mediatek: mt7988: drop dram_init_banksize()")
it fell back to the generic dram_init_banksize() implementation.

That generic path populates bd->bi_dram[0].size with
get_effective_memsize(), which is capped by CFG_MAX_MEM_MAPPED. On
MT7988 this limits the exported DRAM bank to 3 GiB even when 8 GiB is
installed.

As a result, U-Boot reports the full DRAM in gd->ram_size but exposes
only the low 3 GiB through bd->bi_dram[]. This truncated map can then
propagate to later stages through memory handoff and DT fixups.

On a Banana Pi R4 Pro 8G (MT7988), bdinfo shows:

Before:
  DRAM bank   = 0x000000000
  -> start    = 0x0000000040000000
  -> size     = 0x00000000c0000000

After:
  DRAM bank   = 0x000000000
  -> start    = 0x0000000040000000
  -> size     = 0x0000000200000000

Restore the MT7988-specific dram_init_banksize() implementation so
bd->bi_dram[0] publishes gd->ram_base and gd->ram_size again.

Version tested
U-Boot 2026.07-rc2-bpi-g6a1580973a11-dirty (May 27 2026 - 14:39:18 +0000)

Fixes: bddd6bbef3dc ("arm: mediatek: mt7988: drop dram_init_banksize()")
Tested-by: Rudy Andram <rmandrad@gmail.com>
Signed-off-by: Rudy Andram <rmandrad@gmail.com>
---
 arch/arm/mach-mediatek/mt7988/init.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/mach-mediatek/mt7988/init.c b/arch/arm/mach-mediatek/mt7988/init.c
index 7f4d934bfe9..08eb73d42b1 100644
--- a/arch/arm/mach-mediatek/mt7988/init.c
+++ b/arch/arm/mach-mediatek/mt7988/init.c
@@ -26,6 +26,15 @@ int dram_init(void)
 	return 0;
 }
 
+int dram_init_banksize(void)
+{
+	/* Report the full detected DRAM size to later stages. */
+	gd->bd->bi_dram[0].start = gd->ram_base;
+	gd->bd->bi_dram[0].size = gd->ram_size;
+
+	return 0;
+}
+
 void reset_cpu(ulong addr)
 {
 	psci_system_reset();
-- 
2.54.0


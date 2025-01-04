Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 214B5E77197
	for <u-boot@archiver.kernel.org>; Sat,  4 Jan 2025 13:18:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 14317805CB;
	Sat,  4 Jan 2025 14:18:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=pigmoral.tech
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech header.b="HRspeOhu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 03FF58036D; Sat,  4 Jan 2025 04:38:36 +0100 (CET)
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com
 [136.143.188.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 37CEB8034E
 for <u-boot@lists.denx.de>; Sat,  4 Jan 2025 04:38:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=pigmoral.tech
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=junhui.liu@pigmoral.tech
ARC-Seal: i=1; a=rsa-sha256; t=1735961909; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=BothmaJ5fMTLFX4RqtszSxAPnBc9nEVOQwTgvF31Tvojbsoy+JgH0dxT97bDJOFbIc/K0FhzcmDuN7TMwFS5lfligxvWEtPDkw1ziEhzRl3sEPncaYh2JtD6eO8xOiVUnvOia7Txn/QW/AtOF4N0BOKWMpQGqISBpdxP0O65K68=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1735961909;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=M2qUjkNGdiQ7Jb4ePwgogq5TiGq0FmIR0s1w5WH1qIk=; 
 b=d+huaBBZ5BhEjmwqiEFaV2UIY1tl3iQSJ5H+7KdvF3HhxSE+S/PnY+9p7PNfHZWCFXyj0Cyq27rO6WvUc4mDZoO0GPxfX20IVCdIDUlWALZ5uW9i6tdLWLymOKSBgtB3G2YzVNS7KJZOrkJtTNGjxNbIks0Ap/+9zvqufGgeQFo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=pigmoral.tech;
 spf=pass  smtp.mailfrom=junhui.liu@pigmoral.tech;
 dmarc=pass header.from=<junhui.liu@pigmoral.tech>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1735961909; 
 s=zmail; d=pigmoral.tech; i=junhui.liu@pigmoral.tech;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=M2qUjkNGdiQ7Jb4ePwgogq5TiGq0FmIR0s1w5WH1qIk=;
 b=HRspeOhuQHT5Xkpx8j5MzD8Rlc2geJx4UrF9CF9kkepeQsOC8zsMtYC0HyLolvvd
 oueS7OqBsdJ57oO4T7DfLzov6Lbi8orUtoH8XcCmEp8LDEJhhbVyBJhrldTTSbWdkJi
 dFUFCKSWpy+WAONu3ICZJFCcBXkRyFb6NQ2wwM7Q=
Received: by mx.zohomail.com with SMTPS id 1735961907426423.31442272804077;
 Fri, 3 Jan 2025 19:38:27 -0800 (PST)
From: Junhui Liu <junhui.liu@pigmoral.tech>
Date: Sat, 04 Jan 2025 11:37:17 +0800
Subject: [PATCH v3 3/8] USB: dwc2: Fix HBstLen setting for external DMA
 mode
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250104-dwc2-dev-v3-3-d4b2bc1996e4@pigmoral.tech>
References: <20250104-dwc2-dev-v3-0-d4b2bc1996e4@pigmoral.tech>
In-Reply-To: <20250104-dwc2-dev-v3-0-d4b2bc1996e4@pigmoral.tech>
To: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>, 
 Lukasz Majewski <lukma@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: u-boot@lists.denx.de, seashell11234455@gmail.com, pbrobinson@gmail.com, 
 junhui.liu@pigmoral.tech
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1735961880; l=1674;
 i=junhui.liu@pigmoral.tech; s=20250103; h=from:subject:message-id;
 bh=SGlPTaXHUA51si9g2IW1G+Vt5XMeXRJqIM3omvcoRK4=;
 b=sv6C+3HbT6qfARRdxuhqyHxP24m1BhLTtrpNZmN3gJ6z9zig7at8kidcIxpiTSKo7fSklSsuj
 wbhSDBWq1u3A7wT2dATQmH/HuVJnpfRTeUcRtCdiwfjqanp+SdkKO40
X-Developer-Key: i=junhui.liu@pigmoral.tech; a=ed25519;
 pk=wBBo5nYsVNm/3oBEpRGTEbyW0tknGZANOEVccmcXtOw=
X-ZohoMailClient: External
X-Mailman-Approved-At: Sat, 04 Jan 2025 14:18:05 +0100
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

From: Kongyang Liu <seashell11234455@gmail.com>

The loop used to calculate HBstLen for extern DMA mode does not produce
the correct result according to the datasheet [1]. Replacing that loop
with a direct calculation using LOG2 to correctly assign the burst length
in the GAHBCFG register for external DMA mode.

[1] https://rockchip.fr/RK312X%20TRM/chapter-26-usb-otg-2-0.pdf#page=24

Signed-off-by: Kongyang Liu <seashell11234455@gmail.com>
Reviewed-by: Marek Vasut <marex@denx.de>
Tested-by: Peter Robinson <pbrobinson@gmail.com>
Signed-off-by: Junhui Liu <junhui.liu@pigmoral.tech>

---
Additionally, the boards I have only use internal DMA mode, and it’s
unclear which chips employ external DMA. The testing was performed by
comparing against the datasheet, and the results are shown in [2].

[2] https://gist.github.com/Judehahh/34530da390b58728102778406e602cb1
---
 drivers/usb/host/dwc2.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/host/dwc2.c b/drivers/usb/host/dwc2.c
index 609de18faa3abc5f4ecb0c23cf3590966bad7992..954650d856a4f2e95d74e1b5716c0ebe83fa9ba8 100644
--- a/drivers/usb/host/dwc2.c
+++ b/drivers/usb/host/dwc2.c
@@ -448,11 +448,8 @@ static void dwc_otg_core_init(struct udevice *dev)
 	case DWC2_HWCFG2_ARCHITECTURE_SLAVE_ONLY:
 		break;
 	case DWC2_HWCFG2_ARCHITECTURE_EXT_DMA:
-		while (brst_sz > 1) {
-			ahbcfg |= ahbcfg + (1 << DWC2_GAHBCFG_HBURSTLEN_OFFSET);
-			ahbcfg &= DWC2_GAHBCFG_HBURSTLEN_MASK;
-			brst_sz >>= 1;
-		}
+		ahbcfg |= (LOG2(brst_sz >> 1) << DWC2_GAHBCFG_HBURSTLEN_OFFSET) &
+			  DWC2_GAHBCFG_HBURSTLEN_MASK;
 
 #ifdef DWC2_DMA_ENABLE
 		ahbcfg |= DWC2_GAHBCFG_DMAENABLE;

-- 
2.47.1


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B61E5C3DA6D
	for <u-boot@archiver.kernel.org>; Tue, 20 May 2025 15:07:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B955582D09;
	Tue, 20 May 2025 17:07:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="MbPLsKqC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C633182CD9; Tue, 20 May 2025 17:07:20 +0200 (CEST)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B68F182A8D
 for <u-boot@lists.denx.de>; Tue, 20 May 2025 17:07:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3a3758b122cso1189611f8f.1
 for <u-boot@lists.denx.de>; Tue, 20 May 2025 08:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1747753638; x=1748358438;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z2SHLuXUtUONEHdkUdNUrN/1xixwOf0CzCCShw+/2IE=;
 b=MbPLsKqCke83vaohAskYf5ePTZafeHf2tg5U7NIxuzVn4kDmDRgzNpOilzS6fiAINF
 DEeyVA6/8MoQrWxpeCZK36rgtd81hA6wNiUW44C2Vyf5gG0LPOYuHe6vgQNCLfAz2Gdb
 V/3SawOnQ+50klxKVvwGioITlmOdT9VfYJfEo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747753638; x=1748358438;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z2SHLuXUtUONEHdkUdNUrN/1xixwOf0CzCCShw+/2IE=;
 b=WNOyZp41YLMPXWig8dNN09E1nkufn0O7rOAoSJ9FAu1PNgJV7n3ioCTd8JTHhWoUIS
 TbUQKvaptwGcHkPx8oCxmlSJd2AJ5xqRC60O35rZkWfkVMurZAbIrNYHpaYmKGoaz8SC
 8IE3w45sOx14BTbZvV+G4K7OaAfNBymqeeBYAdsrWJdFB1lkgBXaOraq3cXAb6NWLfWc
 HCBqprSjalduEUR7Vql7zA034LGUMa26D+z7CFqLNcY8UserE+nHCDT0QJdBC60N93iP
 REbwuelyQwrH20hDfMevXAXV7pHpMeY44z9AOv3YHB+E7d3vQrrY+yLy31CsFirEUayx
 1ZTw==
X-Gm-Message-State: AOJu0Yzl0y3iSmPAz/usn+vjsDUInVs1l/nTrkfYCa7HEP//QUMaXRDf
 H5lK9ldp66kN2t6JXkPUSjBoQDWJ4bAzCTIWXvKrJ7eT//T4Q2JBMdCGzEJN4JrEdgtxGO7IwPp
 utLdW
X-Gm-Gg: ASbGncthhLHcexzSiJjJDdQvqztPVLbDrvaISoPXlGCqXd9UBg2CTRo7vAnDa6gBBkd
 lH5zb6g3L4hJEHPyPmXHB+9lHfAnTtJjO9FIQqdqRTc7Dq2NYcT4321FoZmtSrYDbNxICpSq3Le
 BtfrmhrfIQd+8OIcmVTq+fYAJTiie57VtEhh4L0wj5sqmkuGX+nzxgwUL1euwosMI4GWsOOyoIp
 GfHJHntat4OnlPtlnMK+BcC7ZXcLrfSJ4IxjRd1L+SvmfhVq8Q7b1q+Q74jg13+haoCMzAePHzs
 SBiT1HRVb0Ih7hJHUnDKfx7G611j64UVhsTQAJfsHgyZBgQdxV/Y/DXj2mrjF1+kaiB8q0RdjSA
 KNIaO3/nGlt19qASwWOf+hIqPzimSr4cWqyIkF/SCrMtMAoqhvKs=
X-Google-Smtp-Source: AGHT+IGPDhPJ9OOSzHVrTFlSQ51dO9p9k/R0i4bB5oDa2WnG0lPwa56MmRx6ZoQ0K2ZiCYPNWMO0JQ==
X-Received: by 2002:a05:6000:2dc7:b0:3a3:762f:cbbb with SMTP id
 ffacd0b85a97d-3a3762fccc4mr5324935f8f.17.1747753637946; 
 Tue, 20 May 2025 08:07:17 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.amarulasolutions.com ([2.196.40.47])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a35e49262fsm16179766f8f.44.2025.05.20.08.07.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 May 2025 08:07:17 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: Michael Bode <michael.bode@bshg.com>, linux-amarula@amarulasolutions.com,
 Simon Holesch <simon.holesch@bshg.com>, michael@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>, Wolfgang Birkner <wolfgang.birkner@bshg.com>
Subject: [PATCH v2 4/4] board: bsh: imx6ulz_smm_m2: Add delay between DRAM
 read access
Date: Tue, 20 May 2025 17:07:02 +0200
Message-ID: <20250520150709.988904-4-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250520150709.988904-1-dario.binacchi@amarulasolutions.com>
References: <20250520150709.988904-1-dario.binacchi@amarulasolutions.com>
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

From: Michael Bode <michael.bode@bshg.com>

A small delay between DRAM read access with wrong parameters and
reconfiguration is necessary.
Without a delay between DRAM read access and a following reconfiguration
this reconfiguration fails for certain DRAM chips (Nanya).

Signed-off-by: Michael Bode <michael.bode@bshg.com>
Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

Changes in v2:
- Add 'static struct' globally in the module where the definitions
  can mabe static.
- Use standard C comment style
- Remove unnecessary variable initializations

 board/bsh/imx6ulz_smm_m2/spl.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/board/bsh/imx6ulz_smm_m2/spl.c b/board/bsh/imx6ulz_smm_m2/spl.c
index e8255b6d2a62..c330e4d6d39d 100644
--- a/board/bsh/imx6ulz_smm_m2/spl.c
+++ b/board/bsh/imx6ulz_smm_m2/spl.c
@@ -13,6 +13,7 @@
 #include <asm/gpio.h>
 #include <asm/mach-imx/iomux-v3.h>
 #include <asm/mach-imx/boot_mode.h>
+#include <linux/delay.h>
 #include <linux/libfdt.h>
 #include <spl.h>
 #include <asm/arch/mx6-ddr.h>
@@ -65,10 +66,12 @@ static void spl_dram_init(void)
 		/* Already configured, nothing to do */
 		break;
 	case SZ_256M:
+		udelay(1);
 		ddr_cfg_write(&bsh_dram_timing_256mb);
 		break;
 	case SZ_128M:
 	default:
+		udelay(1);
 		ddr_cfg_write(&bsh_dram_timing_128mb);
 		break;
 	}
-- 
2.43.0

base-commit: eeb5ff1a468b2303efa9deb2483b5edbebb568c6
branch: bsh-202505-RAM

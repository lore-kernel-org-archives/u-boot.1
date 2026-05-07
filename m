Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2803CD343F
	for <u-boot@archiver.kernel.org>; Thu,  7 May 2026 19:58:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5747284BD5;
	Thu,  7 May 2026 21:58:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="VXRsXfwL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 359DC84BE0; Thu,  7 May 2026 21:58:24 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C787C84B58
 for <u-boot@lists.denx.de>; Thu,  7 May 2026 21:58:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-488ab2db91aso14467115e9.3
 for <u-boot@lists.denx.de>; Thu, 07 May 2026 12:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778183901; x=1778788701; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=vbXXh8eBtehDOpVMl4qbfJUCSpJjwwmzBGbTiyl8plA=;
 b=VXRsXfwL0PPDvcJUNtXVjdpF7+t+hvEKITAmL5nskH4h+5s78ToylOeKHYopEnD3Yl
 ANkN9c20OcyTKZTug3glJSFz6M3KdwC+DL968LOd4sdH1GjncH7kSfflfBUJ9yKgF78F
 RxCFY0tfcR41attZEAdcBZKtwGd/1KkMBXaFpZbfG9PougZL/C8roDdBp+8Gf774lQha
 tkrxOw4D8OrSZwJYehanQ10gTpzSknXFzxD208AHRmztmrFA5BQ3cBmXLicjW8HJJurR
 2/Owop9iCy85Kno/LCiYzfj9dtdq/xZus8BCpCrZl+Dn5ogkHoeN1vQFgLmP9UY0FFw1
 7c9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778183901; x=1778788701;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vbXXh8eBtehDOpVMl4qbfJUCSpJjwwmzBGbTiyl8plA=;
 b=ZpDEAWR6WPWU4Q7zytWOQR6FNBCgeDD3ppaU2je/fGv9fmn8MwbXYBM3V3p+f/qvOE
 Ia2C82iLfnPBVEhTTQ6YpRoaZnNB7QTU1AiJKbWtPzWef/EWna9Aa4kuXgSvapTYt73v
 /ED0HkrmRVKWPeiiVxPt9QyXyc45N11W7j+dV/C7JNmFdjQ0AsBsxupS5ff4XezSBBp9
 FSbBQB4Gc6SpiZoVRrt5hA60WDpeloYGddKf7HwLq7DQY8wFivfyJZfvQ7+OsF5aK8u/
 XlHhrypHXVZSTTzfnPRTTKQNwRhPD2zvSa/t7vAkaVuXFiQpNFeWIe6NPZix1Z4/8Jmo
 HaMA==
X-Gm-Message-State: AOJu0YyubJlaTFnT216zxtmLo1wpL+xlCo6XUjh4nHbfXvcJh3XIfM2x
 5owRV55h5n+D19qfDb9RQMJ+DZpQ26qG9HEMlfo7yeG3QAlvx1/1MZRbKxSaWjBIDR0=
X-Gm-Gg: AeBDiesEfg6xMRcARpeRuYqTRfcmVNpUygTJb7ow1zutCFTopEOojVubYJHshGrmmnN
 ATvcXHaCN9a7Vbofo1Sq+hDK4CpCVlCx/wziQrGOlyOdAHCK7YdHTWhbbdKkEXjzpmOSZLAWBLE
 0Pj5HPCiZz3qyfhw52I6X06KGWlnu9Vt3J6EZIpx1DiZThmQVSr67+wY37r9PmJN/VjF/MrLl5d
 aGlpNja614NKEOTgF478kdkSxxE2p+VlPSdsNKyWd1DZlPCkVqyjoLNepQWMOzOf1jub+AV+sPG
 0FVEAjkYLFC3DZLFUClyWbdoikRBVcqA24BW1ZfK0DajU/iLvlfO4kImkmSnrAje7nc/b8ZA+rO
 XkrFs/brtyrgeK1gkGYFDMKGMHPu9ooVmFvn21hgriYqisqZX2a40qiknQ+D1xlrXd7EJ9tvfjI
 0SisDMZ6zwgya15vYkesJzckMf5WTvqLqC1K8ZEmVClgqOcxi3C5RFzu/vMhaL2ktrGOUH
X-Received: by 2002:a05:600c:34c8:b0:486:fba7:b150 with SMTP id
 5b1f17b1804b1-48e51f2ed22mr170514475e9.15.1778183901201; 
 Thu, 07 May 2026 12:58:21 -0700 (PDT)
Received: from lion.localdomain (p4fc3dd86.dip0.t-ipconnect.de.
 [79.195.221.134]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e538d2878sm235344265e9.15.2026.05.07.12.58.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 12:58:20 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Subject: [PATCH v3 0/4] armv8: mmu: fix region unmapping and optimise
 set_one_region()
Date: Thu, 07 May 2026 21:58:07 +0200
Message-Id: <20260507-b4-mmu-unmap-fixes-v3-0-aac7726d87d5@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQqDMBCF4avIrB1IY6rgVYoLTSbtCEklY0QQ7
 25qlx+P/x0glJgE+uqARBsLf2NBU1dgP2N8E7IrBq10q56qw8lgCBlzDOOCnncSfPiOlLatNc5
 DCZdE91C61/C35Gkmu/6e4Dwv6BXOQXYAAAA=
X-Change-ID: 20260507-b4-mmu-unmap-fixes-1f7e02c6c4df
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Anshul Dalal <anshuld@ti.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Dhruva Gole <d-gole@ti.com>, 
 Mark Kettenis <kettenis@openbsd.org>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Sumit Garg <sumit.garg@kernel.org>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1639;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=iGFZVImLC/ZOZuR56tXJdvPIBIAUJWQ4EZma5v33BN4=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhsw/727PipljNJP/o/MJH2G7Gu37rNKb4gIubfPmXXDul
 /PvpSLOHaUsDIIcDLJiiiziJ5ZZNq29bK+xfcEFmDmsTCBDGLg4BWAi714w/BWZO2W2ANv83fMT
 766Uf3O/eErfsjOzV+dE5u1M3lLBeVKbkWGdvIVz759Pu6Y4vIpmFI74KOSsJ9SesLvO4uWP9gN
 bRAoB
X-Developer-Key: i=casey.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

Currently trying to unmap a region results in slow and largely broken
behaviour as we unnecessarily split blocks and manually set thousands of
individual 4k pages instead of higher level blocks.

This series fixes the behaviour of set_one_region() so that it works properly when called to unmap regions. See patch 4 for details.

Patches 1 & 2 improve the existing debug functionality, the pagetable
dumper will now print most explicitly unmapped regions (since they still
have their PA intact), as well as adding a new function which does a
very basic software TLB lookup to help with debugging.

Patch 3 de-duplicates some code by moving the loop that always surrounds
set_one_region() calls into its own function, this also helps with
readability in the calling functions.

Changes in v3:
- Reworked entirely to be correct, v2 would cause unrelated pages to
  get updated too if the region was inside a block.
- Added additional patches with debugging improvements and code cleanup
- V2: https://lore.kernel.org/u-boot/20260504183721.646712-1-casey.connolly@linaro.org/

---
Casey Connolly (4):
      armv8: mmu: add a function to help debug TLB lookups
      armv8: mmu: teach the pagetable dumper to show explicit FAULT maps
      armv8: mmu: commonize the set_one_region() loop
      armv8: mmu: fix and optimise explicitly unmapping regions

 arch/arm/cpu/armv8/cache_v8.c    | 172 +++++++++++++++++++++++----------------
 arch/arm/include/asm/armv8/mmu.h |   7 ++
 2 files changed, 107 insertions(+), 72 deletions(-)
---
base-commit: bb0f3eebb3c196d9b6efbbd1e5aa9b16abbb9ad6

// Casey (she/they)


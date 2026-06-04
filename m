Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2918CD6E4A
	for <u-boot@archiver.kernel.org>; Thu,  4 Jun 2026 07:38:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2756F848DF;
	Thu,  4 Jun 2026 09:37:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="jQDuFujf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA51F83314; Thu,  4 Jun 2026 09:37:43 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C8C22848BF
 for <u-boot@lists.denx.de>; Thu,  4 Jun 2026 09:37:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-490b4a8e28bso3128235e9.1
 for <u-boot@lists.denx.de>; Thu, 04 Jun 2026 00:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780558661; x=1781163461; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WWLedIjw4tuRixBJDmShJFvgz7ch4sd0E2sHEukc2D0=;
 b=jQDuFujfu3UTkfzwuuq85bX9wUdOmxbRfrZ0+h5Pv62Vm0Rh1KJ2I8RgmV2Qj6noDh
 uMacwVkWkZQitOWrkhFtNUwLt5UnvWezsk4VCAEJiJzM2n8tgNzlfARL/jh3csXvc2XW
 HTJuQraUVwDkmay8ldU+h+sQixeOlEjNfB4/BYhu2s0iUPvA6nE5RblIDimUB+72Zg6s
 odQHIJhkyg20eA5FNjjPfsQ0tWU5118FvAzDptCRdkqp2M2nOtegmKvKLNo+D5YdrEit
 qhQRr6mKrMjjTQ/C+Uqh/0qqA1MSpH/3VVwqVC5hjQ8mZxav+MnR6Krt3K8vFs981+jN
 kAyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780558661; x=1781163461;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WWLedIjw4tuRixBJDmShJFvgz7ch4sd0E2sHEukc2D0=;
 b=Pw8T2I8G+l38tl9j+eCa9nQ3ZPqPXPzagEa5hSOTTa4R42ayYJRb0wWMVNgOB4uIE8
 FIrrPxDq8/cnyNZojppO37rlSpfI18tBzb92Yxk3oWgIVnX/FQvtCO6WN46fR7XXBHi/
 T8VD5gw0/4x7EmFU0GsWhJMhq9x525yG/1oN0CK2olalmAE9devMD+GbDT7lYLvOTyWQ
 QG7wXJJlv9NhJ83LS52Ecb+nJk0vH5YLbeLH7ePaUFvkLNGD7RkZna6xj4izinx97GN3
 rFksdXIzau1+LZQxw2QPswZDHzHuIOU6x5AtI/KzNz/XI5X8LapXhBOTROOhANbjZIZt
 cW3g==
X-Forwarded-Encrypted: i=1;
 AFNElJ++77dmnpFVHTCid0MKcfqjJ2EZlOiws+7kayJFz06w3IuKDlTPwn3VwKMVnl1QN9eKzhAkY+Q=@lists.denx.de
X-Gm-Message-State: AOJu0YyYDxzuv4IAxiPQdIIW6opdi7WZuGzgfJXzUQgSFxyLFA3yzHgw
 0KOyppM3bpY8EVbITgTDfeP6YJCEWqxdey+Yica6mnZSP6/txNJWXWW0LLAj/Shc1yc=
X-Gm-Gg: Acq92OF9c9FEZ8F8EwSrhBGOig0O4pIT761IWHXLauGRh3u2ro+mk5kGARba4+AUt56
 V+YXVTGjRzDWKOrk3dZcj+dU+09pXme31EN0tmU6bcl+zm9p6ABLtFd06y3ihsd3l3KFgLO48iy
 ZFxRqdyyEzqvIKxFqNF6kL+VVunFXcVTauGZ0bhdeX8N+PJBt4LjxNqll1ZU1hxjjx4Eno4Sgkv
 xUjvA3ivt6xjs+Jg8oxyHuMjSCjp/Nt/MNc6Z1SBQ44x/OQspgZd0DtOQ0BIvVrl2mswt5Z+oQA
 gFwUPi0+E5xJRNcxwVHG/MXTpUDNaRmafxWVWgIO6LEnFLxRlTOFiFsSxIWy/kWs1wYdor9w9oC
 kRX8fmvOvSJpx7wfp5t1hbt6OxRBx9gvTrw4eS2lYG4z+XGNpBYeoTZUycIQzSt/XkUCeRbhAIE
 QzPCSPMGpv7KIXbgHholIV9b5aGvbm6Fm1YjuiJ5paUp7S91af/+E89ycvAyF/8ThDzgD3AaS4/
 U7Ol7NWKdLNr0Q3xRxG+iUjqgt+xoxTgqhLec83NFfBgeNFCUtYzwGDKDAG5akfFRODuU0CzfRf
 oYToYQaHbGqLuoWda20LM+WAX8GvCUWBlsAO0Ul4JgEysTayCDXBprY7Y78dXC2rty5qDbVBcUd
 sNNtoIIWMFntsJ13Uf4WxPfgFV1Cif68QTsj4HYDgJhQHoLR0h2Yu3hAFC2mD7Opyl4qxaGLhsN
 gSi2qtTDQMVRCwBGt+1JvNkmGx1aH/gQdQykG5cyFPjl9gdN32JcAY0lFjRWRMzi34hyfxRu/hT
 Ob55SKWD14rIAtxsGMw+Z1qOqSrAdp8Uztv
X-Received: by 2002:a05:600c:45d2:b0:490:bada:6b15 with SMTP id
 5b1f17b1804b1-490bada6c90mr75566885e9.17.1780558661250; 
 Thu, 04 Jun 2026 00:37:41 -0700 (PDT)
Received: from hera ([94.131.143.12]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490bc3918d7sm46436675e9.2.2026.06.04.00.37.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2026 00:37:40 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: trini@konsulko.com
Cc: marek.vasut+renesas@mailbox.org, jonas@kwiboo.se, anshuld@ti.com,
 sjg@chromium.org, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.denx.de
Subject: [PATCH v5 4/7] rpi: Add a local get_effective_memsize()
Date: Thu,  4 Jun 2026 10:37:09 +0300
Message-ID: <20260604073719.48723-5-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260604073719.48723-1-ilias.apalodimas@linaro.org>
References: <20260604073719.48723-1-ilias.apalodimas@linaro.org>
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

We are about to change the place we call dram_init_banksize().
The goal is to have all the information we need to pick a proper
relocation address in gd->dram[].

However, the RPI boards, and specifically the tested rpi4, seems
to hang if we relocate anywhere above the address returned from
bcm2835_mbox_call_prop().
So store that address and return it on get_effective_memsize()
which is used to calculate ram_top.

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 board/raspberrypi/rpi/rpi.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/board/raspberrypi/rpi/rpi.c b/board/raspberrypi/rpi/rpi.c
index 885c660a289b..1da5df92351c 100644
--- a/board/raspberrypi/rpi/rpi.c
+++ b/board/raspberrypi/rpi/rpi.c
@@ -39,6 +39,8 @@ DECLARE_GLOBAL_DATA_PTR;
  */
 unsigned long __section(".data") fw_dtb_pointer;
 
+static phys_addr_t discovered_ram_size;
+
 /* TODO(sjg@chromium.org): Move these to the msg.c file */
 struct msg_get_arm_mem {
 	struct bcm2835_mbox_hdr hdr;
@@ -335,10 +337,16 @@ int dram_init(void)
 	 * the u-boot's memory setup.
 	 */
 	gd->ram_size &= ~MMU_SECTION_SIZE;
+	discovered_ram_size = gd->ram_size;
 
 	return 0;
 }
 
+phys_size_t get_effective_memsize(void)
+{
+	return discovered_ram_size;
+}
+
 #ifdef CONFIG_OF_BOARD
 int dram_init_banksize(void)
 {
-- 
2.53.0


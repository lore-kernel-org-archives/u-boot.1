Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52752D41C01
	for <u-boot@archiver.kernel.org>; Thu, 11 Dec 2025 08:07:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 679AA83D2E;
	Thu, 11 Dec 2025 09:06:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PIMpssEL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 526E783D2E; Thu, 11 Dec 2025 09:06:09 +0100 (CET)
Received: from mail-yx1-xb135.google.com (mail-yx1-xb135.google.com
 [IPv6:2607:f8b0:4864:20::b135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BEE7B83D5D
 for <u-boot@lists.denx.de>; Thu, 11 Dec 2025 09:06:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=malysagreg@gmail.com
Received: by mail-yx1-xb135.google.com with SMTP id
 956f58d0204a3-64472ea7d18so615515d50.2
 for <u-boot@lists.denx.de>; Thu, 11 Dec 2025 00:06:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1765440364; x=1766045164; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=faLHO7THFq9m/ZffKsVkbx6l65Vy7R4vGYJBjJFUj4o=;
 b=PIMpssELEqyZgVmtYNA9LfCwCYFgNUVUAy5iU8B3PGdliO0/F5RJAEQUnZ49ld5EDy
 s6r6D6YDiqKYQ3kLM3C7j8NsiNjuWR8UOwXKco4UrDRt9oo577z3wEQ0mCylbtLI1wNv
 M/kfeuMQ3U5gM5cVlru3aYszK2vLwdadq1bMOe1SR5ljck5M8Cs5YC9Mg91uiUTe6Y7N
 UjaK9r/LkOoZTHeKrO5cAqwlpJFQ7fg7m7TRtjzn3EyK8uwR20dZwZaa+x8+ax9gxVio
 yNbyTj+GfKnKln/zIRKw0QnLaJqFVfwVT0p7Q8AvrsGV1Lc38/R0d+NIHKRECeRKLSss
 srAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765440364; x=1766045164;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=faLHO7THFq9m/ZffKsVkbx6l65Vy7R4vGYJBjJFUj4o=;
 b=OGcckYz3qhoIMvWjSJP8ZP88vEUdnBEq56QjYCKnvTYA2R8dCGKAxyIvYpzOjBm4vS
 nWJ6/VfJ+I4erF492WD7uVzNIwpN0y9SjRedofo4+uo6OrfmkRoivje9vRV8uw6JXkUV
 Oi2PWESAyz62SXueeEzCt+Ji1lQj/MrYn9d7CumpZ9hHviNHJzpumMcZBIQzrcfVLxD2
 4B/N3YDNu46H8ZZ2qtnrx/cUm24hP6JB82J3C7+SrpeuF745H5egdBqRqOn1FlSQ2iaL
 hn2jQ5vz/I8eOIPx3oM9hVyx4ZtnqeNSo5iShch3fINNEnen3PEiRVh+aP/s+krQA8mQ
 q9eA==
X-Gm-Message-State: AOJu0Yx4xQ1bbC+B/nwemVMX06IlhAa405vsBKOLkRvEpbO1MCxx+3tM
 0OBwJM9sdAo0n+e2T580d49Sv2Wijo1ZLbGKKZyAuU42v44pUNFSwPMcxcW1
X-Gm-Gg: AY/fxX6YYOsVao1vZgprVU+ULTAzHakYjm0N83GlwIQmdMiYWLpb+CLrgM64a9vnpsv
 Z0qEIjK1YhA2WRiyXmud0QDB15ncbzTyZ7TMpfq2mxzouU19dRmSylA9mbWTabBIIxU+950t/As
 8Mi1i0Q44hRRIbdp4f9I8MyARHGgKBxUKN29XDMseHxm70MmEa9k93D+VkN4HWrDED7M40PutEk
 U0jitsP2IJ30IUdyOWoPVeFgTRdxvQ0x4DqiL7HuJyZuLbxRzi6OYWeUP+ihq02r1dvLjYOLfBV
 hrZjxYUwlDmI9+K6YDJZGx7exZxmjikqslsCDEDw8NHwPcsiQLeKCKY5kRU74A6/N6VeWzZsp0C
 ILzZ7iqo0dJN5q1HBGNRICzueLFAKf9Xh3XFn3HTL3ICBhwP6VinpDvmH88fPO2bBdaMzvk4Uu1
 IBNM6pIgqq4v4BkQ1uu45BgEUBTQ==
X-Google-Smtp-Source: AGHT+IEjtlMRefHCP1ul0jJAVfW6ierbJHPZd/2qUOJOkh1ZboZfoUet20xwpF6S3QtWGD1IHvw8Rw==
X-Received: by 2002:a05:690e:782:b0:644:60d9:7527 with SMTP id
 956f58d0204a3-6446ec69542mr3390740d50.89.1765440364112; 
 Thu, 11 Dec 2025 00:06:04 -0800 (PST)
Received: from executor.attlocal.net ([2600:1700:5eb5:1ba0:dc1f:cff:fef9:435b])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-78d69d83a85sm7256657b3.28.2025.12.11.00.06.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Dec 2025 00:06:03 -0800 (PST)
From: Greg Malysa <malysagreg@gmail.com>
To: u-boot@lists.denx.de
Cc: adsp-linux@analog.com, Greg Malysa <malysagreg@gmail.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Heiko Schocher <hs@nabladev.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>, Peng Fan <peng.fan@nxp.com>,
 Simon Glass <sjg@chromium.org>, Stefan Roese <stefan.roese@mailbox.org>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>, Yao Zi <me@ziyao.cc>
Subject: [PATCH 12/12] MAINTAINERS: Update ADI entries for new boards
Date: Thu, 11 Dec 2025 03:04:03 -0500
Message-ID: <20251211080414.5363-13-malysagreg@gmail.com>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <20251211080414.5363-1-malysagreg@gmail.com>
References: <20251211080414.5363-1-malysagreg@gmail.com>
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

This adds missing maintainers entries for the ADI SC5xx defconfigs and
for a device tree binding file that was previously missed.

Signed-off-by: Greg Malysa <malysagreg@gmail.com>

---

(no changes since v2)

Changes in v2:
 - Possible files relating to ADI were identified using a shell
   command like so:
   $ find ./ | xargs grep -i --color=none "Analog Devices" 2>/dev/null | awk '{ print $1 }' | tr -d ":#" | sort | uniq > maybe_adi.txt
   This file was reviewed and entries unrelated to ADI that merely
   mentioned the company name were pruned, leaving 111 files.
   Then, maintainer information was retrieved with:
   $ cat maybe_adi.txt | xargs -L1 -t ./scripts/get_maintainer.pl --separator , -f
   and each line was reviewed to ensure it matched ARM SC5XX. This
   identified one extra file that was missed previously.

 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6ce0bbce13d..61b3d8506a1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -637,6 +637,7 @@ F:	arch/arm/dts/sc5*
 F:	arch/arm/include/asm/arch-adi/
 F:	arch/arm/mach-sc5xx/
 F:	board/adi/
+F:	configs/sc5*
 F:	doc/device-tree-bindings/arm/adi/adi,sc5xx.yaml
 F:	doc/device-tree-bindings/clock/adi,sc5xx-clocks.yaml
 F:	doc/device-tree-bindings/pinctrl/adi,adsp-pinctrl.yaml
@@ -656,6 +657,7 @@ F:	drivers/timer/adi_sc5xx_timer.c
 F:	drivers/usb/musb-new/sc5xx.c
 F:	drivers/watchdog/adi_wdt.c
 F:	include/configs/sc5*
+F:	include/dt-bindings/clock/adi-sc5xx-clock.h
 F:	include/dt-bindings/pinctrl/adi-adsp.h
 F:	include/env/adi/
 
-- 
2.49.1


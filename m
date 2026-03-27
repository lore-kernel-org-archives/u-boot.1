Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19C3510F284A
	for <u-boot@archiver.kernel.org>; Fri, 27 Mar 2026 16:26:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 79E0484120;
	Fri, 27 Mar 2026 17:24:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="D4eDhFtC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D8CCC8394E; Fri, 27 Mar 2026 14:52:07 +0100 (CET)
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com
 [IPv6:2607:f8b0:4864:20::743])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 34A9183DA7
 for <u-boot@lists.denx.de>; Fri, 27 Mar 2026 14:52:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jcethrid@gmail.com
Received: by mail-qk1-x743.google.com with SMTP id
 af79cd13be357-8cfc497a604so300862685a.3
 for <u-boot@lists.denx.de>; Fri, 27 Mar 2026 06:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774619523; x=1775224323; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JsjTy7cRHDndrAewYYF0LNLaDrqH/ZdA6PUys84+QJI=;
 b=D4eDhFtCdK+ztrGY0YnTuemAYzIdpiM+RVzdL3RZnmVYA2QdZU34xdMdGEIX/2Hagh
 wJF6GgkrjBWHey3+STXKpTFzsv8dYGJ2qUu2ugkJI4KPv3eXrdhRwJ0U9E+5+71Qf2Ra
 BJ9l31MGuihOgFk7UMlMzCosQulQAHtoiB7mrYrzOzbI3W1F/Ww/b2YjSKOzC7J6dDyZ
 HM4Zf5vUTKzqQCVI/jDFL1ykAdFBHfSvXDhb6dmkdsovMEsVrWumuxMYk/magLZnqFJD
 v/p0fm/KvWkVSU4vmFimPgwL3DtvmX+mPCbPg7udmdU49yv4UwkP3RgES/mWVPNQ/kr/
 ELPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774619523; x=1775224323;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JsjTy7cRHDndrAewYYF0LNLaDrqH/ZdA6PUys84+QJI=;
 b=GsNpENIqkbIYGX6fxW4KbvoomWyX4tiTdF7bqK7SH8GBwopCPpYknwW0zXQS19w/Tn
 8dPJoQaa55Y4cuhpVZqkUVEirF8tL2LGcZvk1vf6eGje/JSSHvQ1/AFROsCAyL965b+S
 ixZ6noXb9qjI7dUV4YXw6/wNLpRIoEMJaOLa1m2kZTpjB+aqRSbwuBHEa5jrNq9Ufkg/
 xGbk9tbkQeBwAEM5BvloFqRKtpc0uK1p7gAo/ODiIbqOwpDNDP7R6xSZPv0jiTFIVVRm
 RJ786xiA7OIb8wFq5RWXiQ0ylT9KmN/MONK1XHd32lQLNZIQKHspj7z09lZZo4Ju+Fnh
 Eq6A==
X-Gm-Message-State: AOJu0YyhrlEbmywOhd2xMqAqVqzMF2XCCH0SHkXBJyiB2L23ECHXFchM
 +RvSxPXOpmE3jP/+pkMAVJxZVqmmRVMSvXsaLwpSVPZYHV9XDViw0nHCIlt9jE8Y
X-Gm-Gg: ATEYQzw0FCGZyA8rFTQTvNaN2EtkwIFzvOTKt8eYICR+u1rx+EfSHWzVw6wVdR5ayO9
 XxSudDE3OSY6u4FTGFLzIh+odpzpROu1PVO8kpkL8P/jKGA/2KCOB+Czh3Mh1SpP9RE9sx0QhIZ
 CqsfbFNSHld+2GGN6nMBxx0Zes/BMiPOkVdq2pVRRzLJNrsH6IxvACQAnpcvRQsHqft1ZEsw42g
 aHjO9b164KB46A7F8+cztYyZSBClF6fclzccFDiQo2ZaxqHGe6i1JSf5mZI/doUl7Ez1j6FGY3E
 mROnNPoNSxMgu+Y/SCZDpVHuARK/o0ptvnBN1H4spkG56a/VIysTOf9vbayLfJIXmkH3WpXqWxP
 GEUNn9pJGRkF2X/kn4MkDY5aGuObWRTq1Ld2VuUyZI8loAj3LcR84tjTezmwupkOaH4/ix3DO/h
 NfUqjQnlI/GMj4APm+tHD2DaFkyuvMb63r5vdccidPnpjT
X-Received: by 2002:a05:620a:4552:b0:8cf:eb1c:57c4 with SMTP id
 af79cd13be357-8d01c7a3811mr337151285a.45.1774619522876; 
 Fri, 27 Mar 2026 06:52:02 -0700 (PDT)
Received: from cethr-l01.localdomain ([136.56.120.109])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-89cd588969dsm48691356d6.12.2026.03.27.06.52.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2026 06:52:02 -0700 (PDT)
From: Caleb Ethridge <jcethrid@gmail.com>
To: u-boot@lists.denx.de
Cc: malysagreg@gmail.com, trini@konsulko.com, linux@analog.com,
 philip@philipmolloy.com, Ozan Durgut <ozndrgt@gmail.com>,
 Ozan Durgut <ozan.durgut@analog.com>
Subject: [PATCH v2 13/13] arm: sc5xx: add missing boot env selectors
Date: Fri, 27 Mar 2026 09:49:28 -0400
Message-Id: <9ed3534fb76b161bb03dce4400c86335c0d36145.1774618658.git.jcethrid@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1774618658.git.jcethrid@gmail.com>
References: <cover.1774618658.git.jcethrid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 27 Mar 2026 17:24:39 +0100
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

From: Ozan Durgut <ozndrgt@gmail.com>

Define the boot options for SC598 SOM EZ-LITE so the shared ADI boot
environment includes the expected boot commands for this board.

SC598 SOM EZ-LITE board environment utilizes the shared ADI boot
environment, but it does not define any of the USE_* boot mode selectors.
Without those selectors, the shared env does not generate the board boot
commands such as `spiboot`. This leaves the default `bootcmd=run spiboot`
without a matching environment command and breaks autoboot.

Fixes: c9e893d ("board: adi: Add support for SC598")
Signed-off-by: Ozan Durgut <ozan.durgut@analog.com>
---
 board/adi/sc598-som-ezlite/sc598-som-ezlite.env | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/board/adi/sc598-som-ezlite/sc598-som-ezlite.env b/board/adi/sc598-som-ezlite/sc598-som-ezlite.env
index 0955229a49f..942978e5571 100644
--- a/board/adi/sc598-som-ezlite/sc598-som-ezlite.env
+++ b/board/adi/sc598-som-ezlite/sc598-som-ezlite.env
@@ -4,4 +4,10 @@
  * (C) Copyright 2024 - Analog Devices, Inc.
  */
 
+#define USE_NFS
+#define USE_SPI
+#define USE_RAM
+#define USE_MMC
+#define USE_USB
+
 #include <env/adi/adi_boot.env>
-- 
2.34.1


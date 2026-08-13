Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7CCEC5CFEB
	for <u-boot@archiver.kernel.org>; Thu, 13 Aug 2026 15:07:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 46804409AF;
	Thu, 13 Aug 2026 15:07:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lFQ1_8MFyKIf; Thu, 13 Aug 2026 15:07:34 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 62F8D409A8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786633654;
	bh=ojUTqulNr2d1oWks+BQUNBuZ0Pczubc64g5oWbcrzqU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Xtp0wDsBiNDrc2ZVueDP/Bz5CaMVWcrn0LXXUI94mf/wXgQ0KWjUsZ5XKEby8Xxcx
	 RqQZ1uhJpmRtjW9BNkoapbyoTKXDsWDUG86bv730F/dxShTeOuwOYbOOFzQJg8mm8N
	 iEFvN3UMkcXRZjTfTPcppDAu6Hdumpz+REdLkkAPuXHleGnZe4hxrge4KzI/QJUVnj
	 7mWodb/tyieh6GQwSL5pSu1XdberScwUZqQkda6yi2v9pY4v/AqFej4SShW94+et0c
	 yEUCGE0b3vo1fy5TiNX11SHvu9H/8deozRQ1kVJ7qos23pC7MR5gqA2cOOqlqi70NJ
	 23q+E4oGOsDDA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 62F8D409A8;
	Thu, 13 Aug 2026 15:07:34 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id D50BF388
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 15:07:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BBB54607F0
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 15:07:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id niJEl3z_5fvK for <u-boot@lists.u-boot-project.org>;
 Thu, 13 Aug 2026 15:07:31 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32f; helo=mail-wm1-x32f.google.com;
 envelope-from=mehmet.fide@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org B918960684
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B918960684
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B918960684
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 15:07:30 +0000 (UTC)
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-49557167508so204995e9.1
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 08:07:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786633648; x=1787238448;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ojUTqulNr2d1oWks+BQUNBuZ0Pczubc64g5oWbcrzqU=;
 b=rTNh7Z5m3uwJ2g82/zdkQnZvbQizRgZHCOrLqbfHqCU2TBfG/zcQz+ddUI2HYrCxEM
 monVyxsbl/bxGWquc8k8VNOgYqcomL4hnsv81JZBw0L9JbcOTAUHlSrWc2lHK0WUMU+8
 nzh2Raf6TFzwQTAo+zaq90weMFd4Vkr3OyKnE7tm80OQhTknLFOM0qR9jX7DNEjSrgjn
 P1Z/KuWLu+7Ugv/+3NtSMeVEsya5ISe7Xc6GY3KAqVv3uQOK+A3s8z+1VP6Rc1LDsBZf
 016ouSsrTu3BM0jlJDhjG4o2Bc6aq8u5YvG75wRXbDH2IPMQBa3E6fRQjg/h4D9jPdcd
 ke9Q==
X-Gm-Message-State: AOJu0YxpZeqIe4GnOeU5uungR7DpR5zy4I4oB1mKzf7h+CTBJhomxAFI
 9YMezgC8GwKEMt2AHYiPWx3FBDwKJTwGd3n7ZP/g4y/6rdUzUfuSRI5LhtbSpugu
X-Gm-Gg: AR+sD12NCp9iyCnLaDxwDWeGw66rsZBIsVxk3B5BddQMsUIrTT2KdutOCd4gej517Ic
 FoYJJhwCwNDNV4/zr+jYrHDhVoorbvZSbv7/XAE+yy0zzdllmlDr52VFVRvET/gu0uOnSR8391D
 IqMhMty2tPDoHUsVR8ZRDdV5bf2x5B6XaN3n35I/PJXhJ6hGdSSrYBgiKmo0SSkMEntor3cDuxK
 WHLYG4dJg6LzS9pZOlePNoiqCx4Gyx/iV6bmXkb9YqftW3bRusvLYmPUj5rPxVPTfKFSWgIg8PX
 Xt/5++7O2cBVojxl2ptUehy/rVdzEltQikzN4Lry1XuIecBmlqWJhKXV9PWUsGDjiCgLIqS3+fu
 nkHAOGoWt4BS98tuWJGEV5V7nnYNnNwe9G/EE/aPXxzlgYvk+HHdh2dKTDrx6gbwWbDaSjj+ShQ
 DKSfzj4mVqQrNyOFp9AKV4FUN1u2lJX21GnIGaUu+sAny5D6X8N6a979jaFg8YSahMvw==
X-Received: by 2002:a05:600c:1d0e:b0:499:51b8:d649 with SMTP id
 5b1f17b1804b1-499821c3232mr63825865e9.3.1786633648347; 
 Thu, 13 Aug 2026 08:07:28 -0700 (PDT)
Received: from deb05.proceq.com ([213.160.61.66])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49981b03cd0sm76265185e9.1.2026.08.13.08.07.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2026 08:07:27 -0700 (PDT)
From: Mehmet Fide <mehmet.fide@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Francesco Dolcini <francesco@dolcini.it>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 Franz Schnyder <franz.schnyder@toradex.com>,
 Stefan Agner <stefan@agner.ch>,
 Mehmet Fide <mehmet.fide@screeningeagle.com>
Subject: [PATCH 1/2] colibri_vf: restore the pre-2017 text base,
 the BootROM refuses the low one
Date: Thu, 13 Aug 2026 17:07:25 +0200
Message-ID: <20260813150726.2184452-2-mehmet.fide@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260813150726.2184452-1-mehmet.fide@gmail.com>
References: <20260813150726.2184452-1-mehmet.fide@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786633648; x=1787238448;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ojUTqulNr2d1oWks+BQUNBuZ0Pczubc64g5oWbcrzqU=;
 b=GUM7c5+HgW5cyAWRa6a+PfGo/UqfAmhLkLQ4R0iEb9ZeWdW1zgDauR29ygvLLdpLV0
 h2MIkR19/gTxgyIp0fCci6zpl5HbZiZU/+HoOZrXKaQpwMOlXFDQ773+z21n1EHRKkjl
 K7JIkcpoMb5/nF28ulzLgJLob6HuISLc1OoOYjgrgo2BMVWKVv2LpMxK1hp+//htrjZj
 udCSVuVrMonC3ZjnbujGZnoBh9Z2ag2BiNiZioPc2y88ipL2ZxRbo8RYHgSoBeadUcwt
 lvsiQ8euU+gHpFkqzMApv7S68hv/vqzvyIFn8N+cjUxowFq5DHPSb+jSLirMEdP7+ET6
 VzXQ==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=GUM7c5+H
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

From: Mehmet Fide <mehmet.fide@screeningeagle.com>

Since commit c0f432c37780 ("configs: vf610: increase maximum size and
enforce correct limit") U-Boot for the Vybrid boards links at 0x3f401000, right
at the start of the OCRAM gfxRAM area. On a Colibri VF50 the BootROM
does not start such an image from NAND at all: the module drops into
the serial downloader, verified by the 0x23454523 UART association
pattern echoing back. The WinCE-era Toradex loader dies the same way
when handed such an image with its flashloader command. Relinking the
same tree at 0x3f408000, the value used before that commit and by the
vendor fork since, boots through both paths.

The low 28 KiB of the gfxRAM area are evidently not usable as a load
address for the ROM, so give them back and correct the size limit to
match (0x3f480000 - 0x3f408000).

Tested on a Colibri VF50 128MB IT V1.2B on an Iris carrier: cold boot
from NAND, both text bases, one build apart.

Fixes: c0f432c37780 ("configs: vf610: increase maximum size and enforce correct limit")
Signed-off-by: Mehmet Fide <mehmet.fide@screeningeagle.com>
---
 configs/colibri_vf_defconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/configs/colibri_vf_defconfig b/configs/colibri_vf_defconfig
index 5145e947e88..beb64189d5c 100644
--- a/configs/colibri_vf_defconfig
+++ b/configs/colibri_vf_defconfig
@@ -2,7 +2,7 @@ CONFIG_ARM=y
 CONFIG_SKIP_LOWLEVEL_INIT=y
 CONFIG_SYS_THUMB_BUILD=y
 CONFIG_ARCH_VF610=y
-CONFIG_TEXT_BASE=0x3f401000
+CONFIG_TEXT_BASE=0x3f408000
 CONFIG_SYS_MALLOC_LEN=0x0220000
 CONFIG_NR_DRAM_BANKS=1
 CONFIG_ENV_SIZE=0x20000
@@ -16,7 +16,7 @@ CONFIG_SYS_MEMTEST_START=0x80010000
 CONFIG_SYS_MEMTEST_END=0x87c00000
 CONFIG_ENV_VARS_UBOOT_CONFIG=y
 CONFIG_HAS_BOARD_SIZE_LIMIT=y
-CONFIG_BOARD_SIZE_LIMIT=520192
+CONFIG_BOARD_SIZE_LIMIT=491520
 # CONFIG_EFI_LOADER is not set
 CONFIG_BOOTDELAY=1
 CONFIG_FDT_FIXUP_PARTITIONS=y
-- 
2.54.0


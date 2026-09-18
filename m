Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41362C982D2
	for <u-boot@archiver.kernel.org>; Fri, 18 Sep 2026 06:36:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 087CD60BEA;
	Fri, 18 Sep 2026 06:36:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id f_A2bZ4y2asU; Fri, 18 Sep 2026 06:36:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 3DDB460BE9
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789713400;
	b=V4uHLnE2kbaRbcY+AL0CV3Oo7YD6QiZMIbKZj2LVGLJEPQd8dKMUHJVBwVbNx1vleQCR
	 jL0hSKv9N3QmAFzAekEovBDjR/lZypbRkBerfv8txiYHbJ/yh8WEQuvqLLCnP90LcnVAA
	 ja/7x2d8uveHCovaSdPAIwh2iTHv1aCcqbfSdrG1Gj3rvGo3YVtN5hZMz2An+xk+mTHrB
	 lvNv2uT8vYX9iGE6vP91wxcOe/cK6cB85klvA8hCgectTSG0kCIhYOm4q0kwiaCjf+2/H
	 5SvEC9lg/AB8QaC1nL+LA2M+hzik5JEUFq1cVeU28XNuGM2O1jZEfEHaLb2Zu9quajw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789713400;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=ei1SV68xRWIKULmm2/ZQOllA/lzLVHloytD+WFp9BLs=;
	b=gkxdMtdrjYfV/ZlQrQqfJmEF2ypnUYV1Ueq4zuq6V13NeoFsimJwcl9wNrY3rofyy6Dl
	 +feORFQ8pfsb3vJx700c3ftx5m+z1mYxphbTOcye2jOZ+PVnuxpkD4LnplyqNlJHgwIBr
	 XV8Ug0HAiGDzAFCf8j3L3O7+eS4nxpMECdXJ2IR/va80f7tQsP7WeO4pLVnXVb+j80Pc8
	 e2ZrAZ3HTRExqOcMtHPhhpnMuszX+badP0XqkBo6w00UnU8ogjmyH+tgEBqnV3htw52MW
	 0/iNanfB0RY1NC2qzCTHAefMKJ3KM3eTHjsM4X56U7w7mK/jAe536w3/qMkMbEcQlGg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789713400;
	bh=ei1SV68xRWIKULmm2/ZQOllA/lzLVHloytD+WFp9BLs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mAaA3eV5p68ty+a+8W71V/9a+Lm8qXVqUMizwDk6VHDhzdXtS0YRFdyRoJzX1SyOE
	 HQ24LCvm9jQCLffMr6//32W1Y6t5p7KpstFfR/4o7eaWtq2dKG9QfzwiEhIDBe+WrR
	 jGLYlOloPGQDayYruYp5lfgJPwIBhnVCsouElNxiaTSFSrQCUe3ACEHJnK+k7lkJtn
	 OvXO59m/E/1rJ+SkrH4wYYl877GiWx0QzeB2LhJf6OuzZ1O4z37wTe2Cw1TodpFQKV
	 F9UwqmDctUIBwCTO6FL+0XUQYlV1jx2kSr7f7f60/lo+iYbh5P0n04Rf7XBm+ldFEm
	 kVBVXUkXy6rZQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3DDB460BE9;
	Fri, 18 Sep 2026 06:36:40 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 848E129B
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 06:36:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 69DD540AF8
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 06:36:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jonxNxhoN9Yl for <u-boot@lists.u-boot-project.org>;
 Fri, 18 Sep 2026 06:36:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 71A0140AED
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789713397;
 b=ReYUC7JyYI4YPIJH60xkeIkKMnL0o6k1xl9sSBUglBVxwb5fcLNqimGYU0NbwiBlCXm+
 aEbNnKRb8OOSo8SUOMTMGIQXTNQwE3HHL49QnUtlQvx5yFYxkjNK1b6SeG0l798SZUvgc
 Q8KU/JQk/MoWGJ+iFedBDZ6ZNCHFmjgF0/SsCBPJf18RANcBas+MAhCVNz0W0aGBoHy9J
 n5loKBX+qY91tfrB8i+cZBCU3ngr4UhDKoFuyXHd2mXAcbqvBh25LbdRXDwq0cK/CNFaH
 ChPn6yHUqkRTKJSls59FD4btuGXMb3uoAhr/484N/BML7Lut6AF3hUR+cjFju/l59Jg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789713397;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=ei1SV68xRWIKULmm2/ZQOllA/lzLVHloytD+WFp9BLs=;
 b=MabL/PGgq8VFNOyMUWcjqa7YNNERp2mjEUIMVh4x9V8F/08DiqPFBSNibLOHzmIuaRVv
 Vi9xzqqvYn8lBFth2ZKzKy0bZFmdKzavKGEBpMnpW1bAi9weco1TJ5dPBW164NRHUDk7k
 Ucl279mkvWQWVfudnqrJSgNhkLtG7g8thu+6gAFlVhGc/64hSpAH8llS7hiadeDuxkbH1
 BV4sbHWyKrzQsJGkTNvR7mU1MfwfjcYE8KrG2+LJLM7AUlA3rnyJ0qtho2wBUtvnK3Ltb
 dCrlZ9k1wmd14xpXpCQ/o8V/PliQfBB8cx2fYlo4grd9plH39IzKAPLjt4e1Qt6Mqig==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=flipper.net; 
 dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=RzPZgg7I; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::11; helo=mail-wm2-x11.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net
 header.a=rsa-sha256 header.s=google header.b=RzPZgg7I
Received: from mail-wm2-x11.google.com (mail-wm2-x11.google.com
 [IPv6:2a00:1450:4864:31::11])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 71A0140AED
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 06:36:37 +0000 (UTC)
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49e6c0fce17so1733865e9.1
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 23:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1789713395; x=1790318195;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ei1SV68xRWIKULmm2/ZQOllA/lzLVHloytD+WFp9BLs=;
 b=RzPZgg7IGTG9VAG4lYUaMFThBqmMhg6rz9OqoDdp2iTsR4x46H9t2RQzn1JQOH/Ywi
 rcRCUwwGXrXIfK2Lg4mYFCHHsWrnhJmD8YIbrjiG1IwkF8yrNUxYgaVayuKr/Cc2P7zg
 DPtWHwYA7/GIdu2aJRFmFto9Ek5K+QHw/7FtQGGiQDsKwZtENAzJk0/orrPGeBN3WqK6
 ZapqkTxC1DSucxsKzf3Hm7TTmjK2nQr1XW+I3piIPG32JxDQbtS8rMfgF1GcRWHIC2S7
 7yAOYXgHqnju6W8uaypVK8rHdfO/xi6vOJKiQMBMCDo7GqXz2lCyayJeSEWBUo9qwJ1a
 bFTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789713395; x=1790318195;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ei1SV68xRWIKULmm2/ZQOllA/lzLVHloytD+WFp9BLs=;
 b=ua82BjFZPKLJKiaBHeUZZGzNQLzGq8JPXKA2aTTVSyUEgw9MXnHcB4Ld/bq29OjQYH
 k0KhcjSkWHj07iPLPtRff6yuMFFhEERFGytbRiWoS6HbokGtlCLOGvPd24swQS4taUne
 6X4ZyPHLLAvXFPU3Ckp6oTWeUADtXlaSbBS6NL7SX9/I951+2fL7ZouO6lItJWnHZX73
 X5K9uHUzUlnsRyRg+sm/X2D2lSXNuB/27pDOv7PC2q4c2TGLZi7Vyxa0UWN88zKR1nST
 uADqpThBAtLIvDrJ1AVJt2WgwPYg3CQb0ayR88HPBQ0mbMuvPZxo+ln0TwZOf/5wiTJ+
 ZFOg==
X-Gm-Message-State: AFuF++kdMSg64/VRYbizAehUwE3UOoyrvCu3yY7iHlSMSGXFHrMT3qzc
 F2C8+S7x950S5OwCsJYZPrm6ePxSbJHG3XW/rXPj7hR2kRLJR63MdYH8jAEPvSdxe7k=
X-Gm-Gg: AYBFou22NBNyFAEHeXAzj1pwcCkRUn8lPLsdXV3OnTIdqWMCLwHmMlTDH6t6GBNojfU
 i4DCgouoyNq+BZHx4Vh9tDjNtzbvVA1RS7iWtAqpZuxphOQIw69wHW5lYc6ptMzKLMoKy19p57B
 2vmVVbSvEL7UrQ+DCWSpBq3wmIDHoLRpBgf3SJcIU5sAAfxGo7obROClOoTaXMIVrC46cmvTaif
 gk4Rs74wWTDFqnBLbcUPtm+tAl9kOHK5XaRhgZcYMDcrZUPkHIFtYufIgpKRXTU8SP6K5FbYkqR
 GncO0Xh0+D85ZulIXe/6ULRW5qQ/EYOhAsCs+mJWwgz1booSuo1uaWxoh00ufGgmXhXF2euMdSN
 RYiU7pNo+qHjUAr+tReqAlO4T2z/j3R3F2V4hTRJ4Y1iSmfBAH0xvW5r7d8w01yDpZblcvW7RP4
 EUMaYNCk2+6aBSLSq6ozl2j/bYXWvM6l8GbgVmzmP25zTL8GFeAZxf98xTxMMBzUZmdnxi3nIJC
 aNFGu9rlzqsG9t+3T5+Pp5eMRjDKjnH0eGglhwSqB4DOJLILjU=
X-Received: by 2002:a05:600c:3f18:b0:49e:6c47:1433 with SMTP id
 5b1f17b1804b1-49fc5868a9cmr14390105e9.33.1789713395263; 
 Thu, 17 Sep 2026 23:36:35 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-2-51-220-108.alshamil.net.ae.
 [2.51.220.108]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fc7cba562sm17725845e9.2.2026.09.17.23.36.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 23:36:34 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Fri, 18 Sep 2026 10:35:51 +0400
Subject: [PATCH v2 10/10] spl: ufs: allow loading U-Boot from the boot
 logical unit
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260918-ufs-spl-boot-wlu-v2-10-8a63e372bb6e@flipper.net>
References: <20260918-ufs-spl-boot-wlu-v2-0-8a63e372bb6e@flipper.net>
In-Reply-To: <20260918-ufs-spl-boot-wlu-v2-0-8a63e372bb6e@flipper.net>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, 
 David Lechner <dlechner@baylibre.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Julien Stephan <jstephan@baylibre.com>, Simon Glass <sjg@chromium.org>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Richard Genoud <richard.genoud@bootlin.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Johan Jonker <jbx6244@gmail.com>, Alexey Charkov <alchark@flipper.net>, 
 Denis Mukhin <dmukhin@ford.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3553; i=alchark@flipper.net;
 h=from:subject:message-id; bh=ZluLZT5yso11KYYqV9C6T9XUWfU+ibZBHy+1wnf73kU=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWStuX1pWVDhHdWSL9MFJlw+83Cua9yRjQmBnZuntp1fr
 NB9Pvfu3o6JLAxiXAyWYoosc78tsZ1qxDdrl4fHV5g5rEwgQ6RFGhiAgIWBLzcxr9RIx0jPVNtQ
 z9BIx1jHiIGLUwCm2ruQ4Z+tWoni0cxeJnbZdKZohhli/lOMWQP2yArucanWnSjHt4SRYckPnmf
 2FwM9I81LNX3/5Ia17ed2X/jN4/rpRfsO5yr+4AcA
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
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

Naming a fixed SCSI device number cannot express "use the currently
activated boot LU". Offer the boot W-LU as an alternative source, so
that flipping bBootLunEn between boot LU A and boot LU B moves U-Boot
along with it and the SPL needs no reconfiguration.

Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 common/spl/Kconfig   | 30 +++++++++++++++++++++++++++++-
 common/spl/spl_ufs.c | 18 ++++++++++++++----
 2 files changed, 43 insertions(+), 5 deletions(-)

diff --git a/common/spl/Kconfig b/common/spl/Kconfig
index d1e3c365ac9a..093bf55e6017 100644
--- a/common/spl/Kconfig
+++ b/common/spl/Kconfig
@@ -1634,9 +1634,37 @@ config SPL_UFS_SUPPORT
 	  use of UFS devices such as hard drives and flash drivers for
 	  loading U-Boot.
 
+choice
+	prompt "Source of the U-Boot image on UFS"
+	depends on SPL_UFS_SUPPORT
+	default SPL_UFS_RAW_U_BOOT_USE_DEVNUM
+	help
+	  Pick how the SPL decides which UFS logical unit holds U-Boot. Either
+	  name a logical unit outright, or let the device point at one of its
+	  boot logical units through the boot well known logical unit.
+
+config SPL_UFS_RAW_U_BOOT_USE_DEVNUM
+	bool "A fixed SCSI device number"
+	help
+	  Load U-Boot from the logical unit that shows up at a known SCSI device
+	  number once the SPL has scanned the bus.
+
+config SPL_UFS_RAW_U_BOOT_USE_BOOT_WLUN
+	bool "The UFS boot well known logical unit"
+	help
+	  Load U-Boot through the boot W-LU, which the device maps onto whichever
+	  logical unit bBootLunEn currently selects (boot LU A or boot LU B). This
+	  follows an A/B switch made by the device itself, so the SPL does not have
+	  to know which of the two is active.
+
+	  Booting has to be enabled on the device (bBootLunEn is not 0), otherwise
+	  the boot W-LU does not answer and the SPL will not find it.
+
+endchoice
+
 config SPL_UFS_RAW_U_BOOT_DEVNUM
 	int "SCSI device number of the UFS device to load U-Boot from"
-	depends on SPL_UFS_SUPPORT
+	depends on SPL_UFS_RAW_U_BOOT_USE_DEVNUM
 	default 0
 	help
 	  UFS devices are usually configured with multiple LUNs, which present
diff --git a/common/spl/spl_ufs.c b/common/spl/spl_ufs.c
index cef1843f40f3..393736c7dc7c 100644
--- a/common/spl/spl_ufs.c
+++ b/common/spl/spl_ufs.c
@@ -8,6 +8,7 @@
 #include <scsi.h>
 #include <errno.h>
 #include <image.h>
+#include <ufs.h>
 #include <linux/compiler.h>
 #include <log.h>
 
@@ -24,16 +25,25 @@ static int spl_ufs_load_image(struct spl_image_info *spl_image,
 			      struct spl_boot_device *bootdev)
 {
 	unsigned long sector = CONFIG_SPL_UFS_RAW_U_BOOT_SECTOR;
-	int devnum = CONFIG_SPL_UFS_RAW_U_BOOT_DEVNUM;
+	int devnum = config_opt_enabled(CONFIG_SPL_UFS_RAW_U_BOOT_USE_DEVNUM,
+					CONFIG_SPL_UFS_RAW_U_BOOT_DEVNUM, -1);
 	struct spl_load_info load;
 	struct blk_desc *bd;
 	int err;
 
 	/* try to recognize storage devices immediately */
 	scsi_scan(false);
-	bd = blk_get_devnum_by_uclass_id(UCLASS_SCSI, devnum);
-	if (!bd)
-		return -ENODEV;
+	if (CONFIG_IS_ENABLED(UFS_RAW_U_BOOT_USE_BOOT_WLUN)) {
+		/* A UFS controller only ever has a single target */
+		if (scsi_get_blk_by_lun(0, UFS_UPIU_BOOT_WLUN, &bd)) {
+			puts("spl_ufs_load_image: UFS boot LU not found\n");
+			return -ENODEV;
+		}
+	} else {
+		bd = blk_get_devnum_by_uclass_id(UCLASS_SCSI, devnum);
+		if (!bd)
+			return -ENODEV;
+	}
 
 	spl_load_init(&load, spl_ufs_load_read, bd, bd->blksz);
 	err = spl_load(spl_image, bootdev, &load, 0, sector << bd->log2blksz);

-- 
2.55.0


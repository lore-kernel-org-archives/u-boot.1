Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E48C6C3ABBC
	for <u-boot@archiver.kernel.org>; Tue,  6 May 2025 02:59:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4BB1C820F6;
	Tue,  6 May 2025 04:59:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ChW4CRFL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8DC2D820E8; Tue,  6 May 2025 04:59:56 +0200 (CEST)
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com
 [IPv6:2607:f8b0:4864:20::1035])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B3F4D800D7
 for <u-boot@lists.denx.de>; Tue,  6 May 2025 04:59:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mibodhi@gmail.com
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-30384072398so3888002a91.0
 for <u-boot@lists.denx.de>; Mon, 05 May 2025 19:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746500391; x=1747105191; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3teI0t7+PwiZOSIYm5U/EWgDQF755rmnaq2/To+tDoo=;
 b=ChW4CRFLj7JRuHiqSUg5OZaGTkvo8c/XuK+8TUnxaT8293RNdPnejymD2cXVEOLAib
 ttIcf5ILgGk1UC24bpxqWbzRjnDObY2ULf+dnvZMUIFDUDwpGe5XWsJN0IqEhOBPu92d
 r8G+ZyAQl809D0IWiaO21fhKvqkPTBWCaFysFZmXORJKu1En9BjfLQ6zwqqeX2JJdKhE
 VQleG6eykm2mcP9KJv2fTTlessjyQZUaeK7FmqCn3eqL9vuqKRHONF+xhuJlTol7qvAq
 DYUKpJFZs+4nqRvC8yrs1LReEVlWwmrd+3BWCXQxRA0eWjNN+Ty38gPU/Maq+ddke5am
 mGFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746500391; x=1747105191;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3teI0t7+PwiZOSIYm5U/EWgDQF755rmnaq2/To+tDoo=;
 b=nAzsW4L95drSTd5wRPuSEpMQQissG+uiEeCXncrrh2HjOTzCpr6JBU8VkIfBA69qd6
 DbFOv8zbZm/qEae/o/dahhGCAvtlqhaOf062jLMz305tJn8Xq3SoihHBBuDwIr/QhdCX
 wXYPSi7jn/MykCfzQhW7lcZYMFW3YnrVAqBRt8JnHnPmK1DDzAH+GJvhfHpfhabggLWB
 3smh0IRhjs+z5b+z+nwiz+DuP+bhOB+S/ORiBMXxLnQ39YkVWQviSuB8c4R9DE+a5m99
 Pl4v7rmQztMjrep0OKXIbmMzkxOSbvBBdEoUcaCAC9jksfJJNoYkbwO92pfM2N4JQZy4
 79vA==
X-Gm-Message-State: AOJu0Yz3oSsdkbxoRGK0Gtfu4QaFEBapEWIYbhuwpGUzw1brDCyLv3Sk
 f0MzQ3Q/wCh8Mg0o2OoInV95xoeNTTnPbpxkfcfadZNxK6JivT6z
X-Gm-Gg: ASbGncsNaBx6YfNY8SxFEx9Cm3yUYp30e/1KrYtLdFitPVnhCi4pqknD1JCLOMlDkma
 Hfz+3BVBLhdlKX4t9+5t2TBeZ5e4GTRFvPAHdTWMbnsnXkdDEMObwM4KV+o+OMfWzHnYLHwWOVv
 TiamvoZWVIPElcLJoYVq0SdMCizvy4MmZ4+4Y5oQnih1UzLX5Owzb79lC4GuYs4dHx1hNYFJ9hK
 DXs1VICDiYkaN69o/W3nGQPniNBq+/mZ0BgMZMr/Z8kQrZogpOeqDAQRz6pYo/FiD5J+iQdoPqB
 UYd4O+4G9hXMymBzki2L3kMsuN6NJ+UHy57lPZiuGD0xw89CkGm6dNRJOONV5I5HfHGdXO4a9CA
 z+5nfIxixa/t6THCPF81ra5UKxXBW
X-Google-Smtp-Source: AGHT+IG15KgQdRCHckIAw4gi8YIVf7e+Kgaawk74vprlDrYP0tgpARm3D+v457LkL1IspTcHYDwtnA==
X-Received: by 2002:a17:90b:3e44:b0:2ee:90a1:5d42 with SMTP id
 98e67ed59e1d1-30a7d8c949amr2031440a91.0.1746500391073; 
 Mon, 05 May 2025 19:59:51 -0700 (PDT)
Received: from localhost.localdomain
 (76-229-100-169.lightspeed.irvnca.sbcglobal.net. [76.229.100.169])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e1521fa63sm63019285ad.123.2025.05.05.19.59.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 May 2025 19:59:50 -0700 (PDT)
From: Tony Dinh <mibodhi@gmail.com>
To: Stefan Roese <sr@denx.de>,
	Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tony Dinh <mibodhi@gmail.com>,
 Walter Schweizer <swwa@users.sourceforge.net>
Subject: [PATCH 1/2] arm: kirkwood: Convert to DM_SERIAL for Synology DS109
 board
Date: Mon,  5 May 2025 19:58:42 -0700
Message-Id: <20250506025843.11019-2-mibodhi@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250506025843.11019-1-mibodhi@gmail.com>
References: <20250506025843.11019-1-mibodhi@gmail.com>
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

Enable DM_SERIAL for Marvell Kirkwood Synology DS109.

Note that this patch depends on:
https://patchwork.ozlabs.org/project/uboot/patch/20250505220853.23679-1-mibodhi@gmail.com/

Signed-off-by: Tony Dinh <mibodhi@gmail.com>
---

 arch/arm/mach-kirkwood/Kconfig | 1 +
 configs/ds109_defconfig        | 2 --
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/mach-kirkwood/Kconfig b/arch/arm/mach-kirkwood/Kconfig
index 26fcd3732d1..f1ccedba5d7 100644
--- a/arch/arm/mach-kirkwood/Kconfig
+++ b/arch/arm/mach-kirkwood/Kconfig
@@ -50,6 +50,7 @@ config TARGET_DS109
 	bool "Synology DS109"
 	select KW88F6281
 	select SHEEVA_88SV131
+	select KIRKWOOD_COMMON
 
 config TARGET_GURUPLUG
 	bool "GuruPlug Board"
diff --git a/configs/ds109_defconfig b/configs/ds109_defconfig
index ef805eca562..1dafef3529b 100644
--- a/configs/ds109_defconfig
+++ b/configs/ds109_defconfig
@@ -54,8 +54,6 @@ CONFIG_MVGBE=y
 CONFIG_MII=y
 CONFIG_DM_RTC=y
 CONFIG_RTC_MV=y
-CONFIG_SYS_NS16550_SERIAL=y
-CONFIG_SYS_NS16550_REG_SIZE=-4
 CONFIG_SPI=y
 CONFIG_DM_SPI=y
 CONFIG_KIRKWOOD_SPI=y
-- 
2.39.5


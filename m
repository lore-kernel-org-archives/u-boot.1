Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6645DF5A8BB
	for <u-boot@archiver.kernel.org>; Mon, 20 Apr 2026 20:34:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F223A84431;
	Mon, 20 Apr 2026 22:33:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="bNVZ9Syc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 61BB98421A; Mon, 20 Apr 2026 16:56:02 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 057BA84258
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 16:56:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aristo.chen@canonical.com
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id AAD9C3F610
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 14:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1776696959;
 bh=TTL0s3Z9+EBgfKQOVqLB+z9nz9IgTR/W3NuU9/NQIf4=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=bNVZ9SycdZZliHVciHHUyse73YV3nnvK2so535BdKtSIaMXxA4vcVLJH1xVOD2EJi
 0Qmp+iaddHipvlEvhVtMpS8+vuibP+I9F9JWyFb0389yml/5e7GW/bYZUbRSkPtrqA
 U3wMdKXb/Uv9p+9Qhe8W3sRohww9zRziacszNQRqNYlYJTPDP0DLFwKtkPz+AxfLfH
 hcsLgms5b6VG7jzSDy4Zz+WCCrTVC7Md8XVctOsd2Q8uoP2CAFrzlm5a1coHdyXvqO
 1XpNT/n2clA5k9d/RCzVEKqLjyM8duE+SNfQloR7XjpVCgwfMr2oNE7f5wyDTj1wcz
 A1p9hu8wdktszGOd8EtMXEl/gfrUtx8up0nKcoenHXiotNG5ISbYj7l5QIzeQnTwX4
 uw6S0Avhk2zXWGZrzjtqqH2litxgKDif6cGtUSdNCuzYEgTgmDwqychrcAxPRCd0HD
 k0VPquRPlyEk4h+cOT7XJ3Oov/LF3iddN/UHlbhBIBdi7k/1qV+ubzRdt5JxD98AAQ
 wQvcYOjJft9Zlv34Yy8zfPvbiEVJeWDm5X3iS16xoW9R1xDNIkpMuk3C6GIa9/91jZ
 6+jco4SDYpn0MlSj06TqXJPwDZjWZhGfCaSax1N8veKVSqHnZrki7rQPCz/Hd2cVq6
 zi2u5pz2bQTZhKpMQSoRrz3I=
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-c7965975ed0so1097789a12.2
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 07:55:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776696957; x=1777301757;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TTL0s3Z9+EBgfKQOVqLB+z9nz9IgTR/W3NuU9/NQIf4=;
 b=ho7H3+ZtK5Y+PnCy63alaiVNwt5w4jpLFtD+MZQ8V2/6nxXp5qei/79ggTOaK7zHf6
 BESHR3mcIhClhfZilXqIEaEPwNVL4UsAGfCUM+2yZfsgyRMH1CGX/0ich9A4Sa9fI9Ub
 lG5JdJH/hwgwgKaEsyg1DQayAUBFLNwvv4I1UpPW4UlHNkcBR31vZw+rEyJy8v60h8rH
 oQwYXyrxVeVHYrfCdbCeKas4z96yvm7OJOc6+S7f2gsVG7/QW3DZ4zDoYNFEDiHq9yN2
 beIUV0K8VSBc6gVNdMso4ItJ0aQYo6O2ytKA6Whlym5FP6XxlWCB6lKIMR9pBqo23+uF
 q7vw==
X-Gm-Message-State: AOJu0YwlwSY4F0DkxX3ANnlZcxKrEsYmwIIE+ZCBVsImv0zrtuhoun+d
 +opvqMXl8so4H1FxHqhjZuGWtikPMg54ddsb2Lg+Dpc317BFDOIiPj6hs+9RPk2FzYGx1Z9Cewv
 Jg25lYzIR2Sx1w8RyToP38t7cYac+TsQWXxHLJhgKdj1ERsTgis54AKvn0AxRgHxO4GqtnrWVZP
 MD1Cx67Q==
X-Gm-Gg: AeBDieupkHzBrlcWsTaI3Tc6d+1dHZ/eUyD7i9wauHLvB9vIpkNkHO/0lgby9crhl34
 pmO4VlbCApJ7MfbCaknFKm6UkYxrncmUghh6MU5gBzI+le5sUhHuf/oF99TCUGbNIvD+AfYY93u
 c8x6nbFXoTxxtw2yUklnD7eoREMHN/pEfNHXw76+LEktAW1uPaBYegXyIXMK2I3gY3dru4i/HEq
 rstWpubiQSJlykPOrZus+okOShJHOYXWuJbQEV6w7mECX35kC7CdZrBCgoJB+UY9s4Jhw3z32Z5
 XvXxjy7svyTwZjEFvADtl0uuEb53nit4+nfnkr8ryDS7eP35UchvoG581mevpMGgNTjEPnovD4f
 DzmhVTmnRlTomSt9XbeIBIFxHwZtGFxyLr8SM02+hpQ/ozUCqR/c3QqnxWahqfeg7ZonBF0kVrC
 kEDqizZlA=
X-Received: by 2002:a17:902:d592:b0:2b0:ccad:de1a with SMTP id
 d9443c01a7336-2b5f9f3aa58mr134083355ad.30.1776696957609; 
 Mon, 20 Apr 2026 07:55:57 -0700 (PDT)
X-Received: by 2002:a17:902:d592:b0:2b0:ccad:de1a with SMTP id
 d9443c01a7336-2b5f9f3aa58mr134083095ad.30.1776696957166; 
 Mon, 20 Apr 2026 07:55:57 -0700 (PDT)
Received: from noble-uboot.lxd (124-218-37-86.cm.dynamic.apol.com.tw.
 [124.218.37.86]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5fa9ff918sm113118845ad.13.2026.04.20.07.55.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Apr 2026 07:55:56 -0700 (PDT)
From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.denx.de
Cc: ggiordano@phytec.com, w.egorov@phytec.de, trini@konsulko.com,
 marek.vasut+renesas@mailbox.org, iwamatsu@nigauri.org, bb@ti.com,
 afd@ti.com, d.schultz@phytec.de, peng.fan@nxp.com,
 patrice.chotard@foss.st.com, hai.pham.ud@renesas.com, michal.simek@amd.com,
 Aristo Chen <aristo.chen@canonical.com>
Subject: [PATCH v1 2/3] configs: phycore_am62ax_r5_ethboot: Drop duplicate
 CONFIG_SPL_MMC
Date: Mon, 20 Apr 2026 14:53:39 +0000
Message-ID: <20260420145353.3923395-2-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260420145353.3923395-1-aristo.chen@canonical.com>
References: <20260420145353.3923395-1-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 20 Apr 2026 22:33:40 +0200
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

CONFIG_SPL_MMC=n is listed twice in the defconfig. Remove the redundant
occurrence so each option appears only once.

Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
---
 configs/phycore_am62ax_r5_ethboot_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/configs/phycore_am62ax_r5_ethboot_defconfig b/configs/phycore_am62ax_r5_ethboot_defconfig
index d597e9d92d9..db04706c739 100644
--- a/configs/phycore_am62ax_r5_ethboot_defconfig
+++ b/configs/phycore_am62ax_r5_ethboot_defconfig
@@ -24,7 +24,6 @@ CONFIG_PHY_TI_DP83867=y
 CONFIG_TI_AM65_CPSW_NUSS=y
 CONFIG_SPL_MMC=n
 CONFIG_SPL_DM_SPI=n
-CONFIG_SPL_MMC=n
 CONFIG_SPL_SPI_FLASH_SUPPORT=n
 CONFIG_SPL_SPI=n
 CONFIG_SPL_SPI_FLASH_SFDP_SUPPORT=n
-- 
2.43.0


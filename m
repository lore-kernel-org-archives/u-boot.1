Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE1EFF8FA6A
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 12:38:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 72EE98431C;
	Tue, 21 Apr 2026 14:37:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="iDjdKQx3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 416A884347; Tue, 21 Apr 2026 09:46:07 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 48FD280077
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 09:46:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aristo.chen@canonical.com
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id E0F5F3F9B4
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 07:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1776757563;
 bh=zz59E4w06lYZtzurs03kSANHL3hlxhb94txewbVgWVQ=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=iDjdKQx377Fw6JY1Cql6LrutlGCWEmqbnCmBuxxEAla+k2aw/9CNj0FlTeK9x9pdL
 MrDtGXrZfrwDVr2dMwtZcgBBeRFbN492V9o0T71Nj8+b6I36GjOSnhqamoG2VAfQ9d
 W7p8QPnrnLjnVkVY3ClbylFVyHCJqONd3RBBt0UFKGCM2aVX/4vtGjyl+V517DIDOL
 4KdXUxFuos4WHv+3ld0Y/ssT4wjjjPu7bou+A+AWPN/NCmAENIxWCCUZ3E1Cxy/W40
 jeoDNsI0Uh1zhQIW2DDYRd+Gdp56u5avAwOOMvOeWog5ku35W+TQpps3JRVhHPA0uv
 qKJ4qdoq6E2vJXKskBH6Fk70Tytdg8NzzS3A+gjOyWfGGNlMh6xhMlH8fw031m5p1X
 YDI6Ec8pcqxTbpbgZEnnHh0IEpGJQfN6uwGPci1cH6Hce4ha/TlSJhgMITJJlbfayo
 hMBNX9xOSWgSeTCEeuImWWyD/8GUkVFsFDGos5zkb5yxqGenIlCqJyw6dExTtJxYWs
 g+Ds3CXaNVUBaN8wBLJB+VWR/ZPwOqNceeVQLhcOYczMUdzbKJCJIRY8VZaIeHezX3
 9VYCgAoOi5rwAhbRCMdc+aSlPDgGYYR9pQ07A1UfE8oSHE+HjRWQR6+UBuo63krlhO
 D9cGTgFDXIjgm3Dn9g/q7slI=
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2b2eba42b8dso36361085ad.0
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 00:46:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776757562; x=1777362362;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zz59E4w06lYZtzurs03kSANHL3hlxhb94txewbVgWVQ=;
 b=IXvrtVtoFfAis2SCTHPgqweOyi+pQHZoQVc4N5rZ7Olyv4Tz5uynBStUCIoPcJiY9i
 AvDaHsZk4zyCgG3P146lgkZjjfhnlajFMoT5NY1bkpJ9Q3Axt/vEKSMpYdYcgI+eDOFq
 Agv3TOEKpcchcB1n1PxVJY/hkAtN9SVflzGF8SwYMHs6dnKkCqzzoLGyd2VNs/XCyHRc
 yG96R7zf46IsL97MDfYJZmYZIgQ0VkgQbaxK4QKYu2k5WHlMe99kU5ZEcWhgDtX0sy+h
 Xb4M336/U4/eWie/7meL8pOqOUmF773Z1fG7g06FaRAhpoXjdYbD8i2ktwPFybnkzPrU
 4KIw==
X-Gm-Message-State: AOJu0YyBE2se8I4Nk3Rjs5p1AwzPPt6W6RmvBi/W1xYmoyfDWKBkT/vo
 8SGwqTPilcTKI3g857oluBweAmZuGt0hE3X2VbHqqB6hHjnKWIFFs6o91lTZfsFCjeDDpaupo/s
 U7FA+YI0jvkAnVU3OcLRYLhZNiU2KSp/ma34LTnW1i3S/qD2V+Gm3O95Zm/9uQ4bUFgaBxYD6XS
 hfxsocKA==
X-Gm-Gg: AeBDievIVUPvTYF74EZ8Jwp7r/Gr5b+VA+0gBbktx3JM4eljGsxulj/WmsUjqWXbmtj
 L2tIslH0aoYpj08nZ7+83rPSXVp1wchYRCkbBEHV2eP+n+h7MPD3nSbaNsW2tQ3mw4U3O7UhnIo
 vTi8uzIczupVESJ2sle51sRKasWJpdszbRmNTpOAnoutZx4FcmOiP1Bl+buRw6ws1QFI8OAvrO7
 ylQ8TwVCHC4lhubw60xnpP9P2Sx8C+jg6emV3NJw/V23u/S4oI/uyKvcfU1wHxFAH1pUs2oTjCa
 Vc+jEhCQvmOiiswnFsS6Ap572lBOq6XqzqD91wYI1lPPAQ7pwW8sCiTvhgM6wiwB0GVhxBQ1gdP
 Eqi0hlE+94RGC6Hv0ELzkY+Tz5NZgNauQUB4xLv1auaou2RbRiXjluSX/l4h7ZY8O1I/qgs5HqO
 cNMiQGyrc=
X-Received: by 2002:a17:902:e54c:b0:2b2:ece2:bc1b with SMTP id
 d9443c01a7336-2b5f9f63726mr183148405ad.26.1776757562117; 
 Tue, 21 Apr 2026 00:46:02 -0700 (PDT)
X-Received: by 2002:a17:902:e54c:b0:2b2:ece2:bc1b with SMTP id
 d9443c01a7336-2b5f9f63726mr183148005ad.26.1776757561737; 
 Tue, 21 Apr 2026 00:46:01 -0700 (PDT)
Received: from noble-uboot.lxd (124-218-37-86.cm.dynamic.apol.com.tw.
 [124.218.37.86]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5fab297c8sm118729345ad.67.2026.04.21.00.45.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2026 00:46:01 -0700 (PDT)
From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.denx.de
Cc: ggiordano@phytec.com, w.egorov@phytec.de, trini@konsulko.com,
 marek.vasut+renesas@mailbox.org, iwamatsu@nigauri.org, bb@ti.com,
 afd@ti.com, d.schultz@phytec.de, peng.fan@nxp.com,
 patrice.chotard@foss.st.com, hai.pham.ud@renesas.com, michal.simek@amd.com,
 Aristo Chen <aristo.chen@canonical.com>
Subject: [PATCH v2 3/3] configs: phycore_am62x_r5_ethboot: Drop duplicate
 CONFIG entries
Date: Tue, 21 Apr 2026 07:44:40 +0000
Message-ID: <20260421074523.4930-3-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260421074523.4930-1-aristo.chen@canonical.com>
References: <20260420145353.3923395-1-aristo.chen@canonical.com>
 <20260421074523.4930-1-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 21 Apr 2026 14:37:42 +0200
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

CONFIG_SPL_MMC=n and CONFIG_SPL_DM_SPI=n are each listed twice in the
defconfig. Remove the redundant occurrences so each option appears only
once.

Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
---
 configs/phycore_am62x_r5_ethboot_defconfig | 2 --
 1 file changed, 2 deletions(-)

diff --git a/configs/phycore_am62x_r5_ethboot_defconfig b/configs/phycore_am62x_r5_ethboot_defconfig
index a4434388ff8..02343c08629 100644
--- a/configs/phycore_am62x_r5_ethboot_defconfig
+++ b/configs/phycore_am62x_r5_ethboot_defconfig
@@ -21,7 +21,6 @@ CONFIG_DM_I2C=y
 CONFIG_SYS_I2C_OMAP24XX=y
 CONFIG_PHY_TI_DP83867=y
 CONFIG_TI_AM65_CPSW_NUSS=y
-CONFIG_SPL_MMC=n
 CONFIG_SPL_DM_SPI=n
 CONFIG_SPL_MMC=n
 CONFIG_SPL_SPI_FLASH_SUPPORT=n
@@ -38,4 +37,3 @@ CONFIG_SPI_FLASH_MT35XU=n
 CONFIG_SPI=n
 CONFIG_DM_SPI=n
 CONFIG_CADENCE_QSPI=n
-CONFIG_SPL_DM_SPI=n
-- 
2.43.0


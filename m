Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E27D1C35FFC
	for <u-boot@archiver.kernel.org>; Sat, 22 Mar 2025 18:38:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E797981C64;
	Sat, 22 Mar 2025 19:38:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HOyfEx0I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 89AB781BC0; Sat, 22 Mar 2025 19:38:36 +0100 (CET)
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com
 [IPv6:2607:f8b0:4864:20::729])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5724B810FE
 for <u-boot@lists.denx.de>; Sat, 22 Mar 2025 19:38:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aford173@gmail.com
Received: by mail-qk1-x729.google.com with SMTP id
 af79cd13be357-7c55500d08cso305429185a.0
 for <u-boot@lists.denx.de>; Sat, 22 Mar 2025 11:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742668712; x=1743273512; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GqaTMnhpC7O0Qxjh+9lA4E17zCk14IMJECx3LfqMZJc=;
 b=HOyfEx0I4DNJtb92p+pDMtqrBp7jGUKGRp33QaWgR+eqYYzPKA73XHpt5ErYCTSpU2
 VfZOcqkQSHqVMXQoFryDa4VaQhUsZH4SLYMJkd1W1xjD2+iymMJ6swnEmKzX+zEp1nvh
 sqbCp9WxY8mAzy7E6qS5Ym++XZlWrA/oIsZF/i5X4zbdj+venf7rSPk2gsApE7rzcDXH
 jTdPvMSwbLVuZvdLIGwpAxP7Tz/2UnRuY95J5kgHXnstNf6LQpZcH28uPjOmzczpa6j4
 rcqo9mVrPuzw+yipS8aSZquo/WywulXESH7BaBYAsbZ87MTTvir/VkCLsWBrRhQV3TIW
 HkzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742668712; x=1743273512;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GqaTMnhpC7O0Qxjh+9lA4E17zCk14IMJECx3LfqMZJc=;
 b=v9vpnJUcT/cgBbV9IwSXhZM7X3kwNqiEtbMXM8YH1dUeD1aEnVYHE5ZjWjqAk01eXo
 CMuxKmwj2YwgZhQHufHt7JEXb927tTC3brpPmda4iYdczHEWfoh8Sq8XTWnFAIkwmO4P
 5YhFUecVE2qANg9lpOePJGt8iBgQPyLoaTzg4a09x567hpPKmNE03xB9YvUz+QqIySCI
 SRLrKiahfgtvz2vJRms9rBRayrrZoeGbDNsS74xb32qusN6Gd/6SeTjEGaePnazPr6+4
 buz3TP0hSFPHOynQYM1GRv+d5NQisg/vgJwk/7qa7pvnvN67uIZXm5e0cKWdrULAJVUA
 F2/g==
X-Gm-Message-State: AOJu0Yy8nKaz1ugFwdXGAunOF5Gp6dZQUvfF4bSu/rtuQqtnSOIvitMh
 Lte+A4jeQIauhLcy5bcFrmXhYc7HAtc9b0Qi28cLDDosJli5qOlXzHycgQ==
X-Gm-Gg: ASbGncul8Om9Ri1R126qYnYL/nKall7ZVFpMDFw2b15KbWGu9dH1FAEUHKjud14D1ao
 2j894VVvpoezhOwkvex9f3OKVwJIlefudE6F/bsHq4/dKuKkoK3JPN8QxmlKAAf3Y4GNGfXk4sC
 c6GzNKOfBuI4qdQ4XlrWaV9JGyQxljPJ4Rc8KOmIBbpLwVZx40a1QjhqIyohVGwF6DZtx7+D5M7
 djc21NB8VEKEIQ1mi3EAl7Bek/+P4Fwbd76rVkQ/Aq0bgtA10xqZf9ghQAffcw4wMmZe3g99X1H
 bX+GvX/rAQW6616BuqTwQkNfFeqlMvsJ4556uJyL3aZvUS6BrCNSWiF6VZSqXXzPf+ZTfc+s3aw
 IY6ATBYIgN9QNRz0FSK8=
X-Google-Smtp-Source: AGHT+IGwhNxoMcXGKsrCPlkk+fTCNrvmqAlAyFP/ivFlwokARk1wCAtldDfEjncD7kWXRuIAW9Q7qw==
X-Received: by 2002:a05:620a:4508:b0:7c5:562d:ccf8 with SMTP id
 af79cd13be357-7c5ba15a9ddmr1195010985a.8.1742668712589; 
 Sat, 22 Mar 2025 11:38:32 -0700 (PDT)
Received: from aford-System-Version.. (c-75-72-162-184.hsd1.mn.comcast.net.
 [75.72.162.184]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c5b92ec648sm278126185a.61.2025.03.22.11.38.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 22 Mar 2025 11:38:31 -0700 (PDT)
From: Adam Ford <aford173@gmail.com>
To: u-boot@lists.denx.de
Cc: aford@beaconembedded.com, marek.vasut@mailbox.org, festevam@gmail.com,
 Adam Ford <aford173@gmail.com>, Stefano Babic <sbabic@denx.de>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>,
 Heiko Schocher <hs@denx.de>, Enrico Leto <enrico.leto@siemens.com>,
 Peng Fan <peng.fan@nxp.com>, Yannic Moog <y.moog@phytec.de>,
 Sumit Garg <sumit.garg@kernel.org>, Gilles Talis <gilles.talis@gmail.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, Ye Li <ye.li@nxp.com>,
 Wadim Egorov <w.egorov@phytec.de>,
 Christoph Stoidner <c.stoidner@phytec.de>,
 Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
Subject: [PATCH V3 1/6] imx: imx9: Imply IMX_TMU
Date: Sat, 22 Mar 2025 13:38:03 -0500
Message-ID: <20250322183812.784676-2-aford173@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250322183812.784676-1-aford173@gmail.com>
References: <20250322183812.784676-1-aford173@gmail.com>
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

If the CPU Information is displayed from imx8_cpu, it displays
the cpu temperature grade and operating temperature if
CONFIG_IMX9 is defined. This behavior is similar to what
happens arch/arm/mach-imx/cpu.c except that the latter
checks for CONFIG_IMX_THERMAL or CONFIG_IMX_TMU.
In preparation to make imx8_cpu act like the previous
implementation for any CPU, make IMX9 imply IMX_TMU, so
it will be always displayed unless a user decides to
disable it.

Signed-off-by: Adam Ford <aford173@gmail.com>
---
 arch/arm/mach-imx/imx9/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-imx/imx9/Kconfig b/arch/arm/mach-imx/imx9/Kconfig
index 49220c0955e..c3e758e103a 100644
--- a/arch/arm/mach-imx/imx9/Kconfig
+++ b/arch/arm/mach-imx/imx9/Kconfig
@@ -10,6 +10,7 @@ config IMX9
 	select BINMAN
 	select HAS_CAAM
 	select ROM_UNIFIED_SECTIONS
+	imply IMX_TMU
 
 config IMX93
 	bool
-- 
2.45.2


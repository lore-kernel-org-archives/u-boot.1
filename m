Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0820FE7E0D2
	for <u-boot@archiver.kernel.org>; Mon,  9 Feb 2026 18:32:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D0D9483C29;
	Mon,  9 Feb 2026 19:32:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="R1zb2gbH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B78883CB5; Mon,  9 Feb 2026 19:32:30 +0100 (CET)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com
 [IPv6:2a00:1450:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F2F283BF4
 for <u-boot@lists.denx.de>; Mon,  9 Feb 2026 19:32:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-59dd22b9895so6395119e87.0
 for <u-boot@lists.denx.de>; Mon, 09 Feb 2026 10:32:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770661948; x=1771266748; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zz7JFVBmUIdsAfAm4/s7BXmQXrks63fZhgw7IhrBNMI=;
 b=R1zb2gbHRhUgtEHvEDLfhZmtyUvFqTHX1y8CahKKHbTgee8LN1S1HDfADE9fjB4j+n
 QgwUvpztavzTywXnxq2EIIUk6PxtJMR2a0Ug00x56FiAzhca/HMYDCWteSXDMrERGgSd
 KTbKg8or1t7o32tuVKf5PfedFg7bUaoCxEXnMVnCNxOdcQER2QPZSQETqGkwbAA7B1nh
 rNsVQmw5DDbe5qyuMqdN7AozBe1POYYz7XOTQXj1R1LB0q5oxETW+BnwN9DbPfbc4QoW
 jeWyst40BbKDwJud4sYRFoQVq5V9McANYCGgImfisLrT39QBaSJto8UyOV5sIZqvnVjn
 YgzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770661948; x=1771266748;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zz7JFVBmUIdsAfAm4/s7BXmQXrks63fZhgw7IhrBNMI=;
 b=hs/lR5M2vLiksnITjpBi5At7SdSWM/KnlYz5TT2C1qJfNiODCOyObQJ4QIc18yP4QP
 WlJnaIAxWt4E3bpviQ7DiPyzjdOc3JZH8NcE2cAxZKn2NxMS5uwk25jIlnhvAODp29fi
 GMRJK5duyMC+QeDh3LnqRA5edp8IO4auEq5txtG8Hr2zcy5NVx2Nok0TmCcF9472toBI
 qNgBagyutKpnMXkHBN+PtWLK8Yl97bz3PGlBpehXuPaIc/pnpw6m2lySInwMAzCubTVm
 5HDEGEKvObze+vtjvQxNZeQqufmJvtXCeEEnJnn3P3E6cEF0XwqCqdDxY7Soul3vj5Sb
 GzZA==
X-Gm-Message-State: AOJu0YzLGg3ZiFUka1+M39rN2WJeKEFGtfZTDmTPD8AGUGf7i70C8VC0
 pIXqrjfhZ5z8HvozmnGGgxy6vTWqn/22+KluEanumANw1fnnHNpBIe/L
X-Gm-Gg: AZuq6aKMWcxjNvvjn2ltD0m1L2HwORlqBQl/qzI4Rl4YBtge0oL0p0KJvtLPkL0lUdp
 9gEIlJJKD77pc7yy4TOwmYGW5+/0+hy2IakBW/eg/HL4JH7o88UovRJU91AUESE3RSRCG2NvH00
 FpA+3A11Le5QNtjQP0JfnWHeKJeYXC1IGWkOJXe8f1KPS2j0I3vP+WYrFQZfeh5AXziEWc/Uzdt
 qJ/5NE3itLcigBUwRGdi+keM6H22k1PVOsUdkHVLmZf9Dbynk6b/aMTWUf36LJYZBYUosCMssxx
 JYcGIokMhQBLoTcgiHOVPL4bLcZdJey2ZCsVhOxcXZMLaylH58RkURwA1Ah2I4m/vUjieCSJhbQ
 ak7w3N5At+svpFJ7evsSFxJacLdkh/YVdWAkLvbOU7VxFe5tlaymA9kRnO/kfGpalYqaoprMQ7k
 TX
X-Received: by 2002:a05:6512:1243:b0:59e:4994:6874 with SMTP id
 2adb3069b0e04-59e54377533mr99615e87.16.1770661947648; 
 Mon, 09 Feb 2026 10:32:27 -0800 (PST)
Received: from xeon ([188.163.112.51]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-59e44d299ffsm2815391e87.55.2026.02.09.10.32.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Feb 2026 10:32:27 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Tom Rini <trini@konsulko.com>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
 Ion Agorria <ion@agorria.com>, Peter Robinson <pbrobinson@gmail.com>,
 Peter Geis <pgwipeout@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 2/6] ARM: tegra: surface2: fix panel supply
Date: Mon,  9 Feb 2026 20:32:15 +0200
Message-ID: <20260209183219.34250-3-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260209183219.34250-1-clamor95@gmail.com>
References: <20260209183219.34250-1-clamor95@gmail.com>
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

Rename vdd-supply to power-supply according to the latest schema.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 arch/arm/dts/tegra114-microsoft-surface-2-common.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/dts/tegra114-microsoft-surface-2-common.dtsi b/arch/arm/dts/tegra114-microsoft-surface-2-common.dtsi
index f8f71262538..79369753a17 100644
--- a/arch/arm/dts/tegra114-microsoft-surface-2-common.dtsi
+++ b/arch/arm/dts/tegra114-microsoft-surface-2-common.dtsi
@@ -35,7 +35,7 @@
 				compatible = "samsung,ltl106hl02-001";
 				reg = <0>;
 
-				vdd-supply = <&tps65090_fet4>;
+				power-supply = <&tps65090_fet4>;
 
 				backlight = <&backlight>;
 			};
-- 
2.51.0


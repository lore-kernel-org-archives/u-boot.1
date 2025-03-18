Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFC58C28B28
	for <u-boot@archiver.kernel.org>; Tue, 18 Mar 2025 12:47:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C8E381A0E;
	Tue, 18 Mar 2025 13:47:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DvpfGtRR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 099F080548; Tue, 18 Mar 2025 09:31:45 +0100 (CET)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 12CD6811B2
 for <u-boot@lists.denx.de>; Tue, 18 Mar 2025 09:31:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=arturkow2000@gmail.com
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-abbb12bea54so1108826866b.0
 for <u-boot@lists.denx.de>; Tue, 18 Mar 2025 01:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742286702; x=1742891502; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W1zPRCG8xFlYxk5ZHjJEToIpvCZMIaGzX8Ya/UGbhEg=;
 b=DvpfGtRRMoD2cFQuYTQJ3PWPRLDpXEGlGI23WFwyGnBTFdaVXgf7rIqqjc1hK9Ogp4
 czWpOpAMgpRFPHOXOOphSCKW5cG+WBj82SvX6LEh1qhqKjmJAeYnqR1qp0/sv0sPYdoz
 nKUUX2On0irA97vT3YfSR01k1KrEKoPhWkA/s2aEN6NUMxvdXXJ3EZBVVVH0UzJd6jxC
 JOS1FiHzL5MGJ0OPfIE5EqpF1N7kxE4p47jnr7R8t704OA7/vARBnQnpvh+uVB14G6sr
 WNvQDrOD9GhHjM2IPwgpb46HbJ8ZcBw4ezlsumWjTyNuJ3eOoYA9LZUtMFio4y4je1LM
 DBrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742286702; x=1742891502;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W1zPRCG8xFlYxk5ZHjJEToIpvCZMIaGzX8Ya/UGbhEg=;
 b=PwKg5Q5xAgvX4QoGqdKG5DrEvc0a81DaTc63lB4BnB71d0jc3Tu5f9Oh6z8brafL5A
 Tvbi2+HemSWtL1e2f+AB2emI+axwmShnrgB8+uVnUQMK2LLYI9vxHm9NZ6wbEuVgy54A
 yMWju0Y14FzXCLuOoVPxgIAuNnqwKHCRChIo0HAQKMBxVQDkwfLPmw5D1PtDIWBprKW8
 hFW4YzrJcXOmrJt2ifF3hFRTfs2NiDFpNtFCS5wBShXNqLQWKo+yUqoaA87lWXjtRkqy
 KLhJ6ev/10oi2qgpGgBX+3svG06kySMdN0RRIKFUtCEKF+0burIImwITd5ByRct2R3Oc
 D4LA==
X-Gm-Message-State: AOJu0YxNEgfxACjaGiMXKAEjJQhG0YIXfy+7HcXxze0lenfjFt7L9ePq
 zzPPjrC7X9oimjx3wD89RZXZi8smr56x4oC7LuDXVm0HAgLC5C+jmaK1Ufv3
X-Gm-Gg: ASbGncst3AL1qFZFHfCRSt4fMQyebetfkBfSUevMCeJaaalSjqQgD2pVm3WeFmuV6e2
 1v04jGmojC4agfvuca4qUnnae3ZBwyfqzXZ1y2UoBrKAljlxbjwyzKciMwNVdfPhIPJmMtApjve
 PWm+bBs7guYQPicv8UHXoFWA0cZGsUzetcL0ItxAX6m7ZeA+caczbW+60Ugbl2/5jtFajVlKxSy
 hxNLX9hM+CgoH7lch7rtQ/Pv0sO1SH36MSn3Gw6pd8XqqTSnqJwakmtKRRqezlyqwMVTXyrvRMB
 FbxRnU1hGIvQZT4Z2it2fQYeJQHG5lUBS4NGmaHrrOR/0DC3abPZkBEhaYDsHLc=
X-Google-Smtp-Source: AGHT+IFI5zwUFZMzm5wdCuL3Z+K/jwPBTYNGQsHSMefyjG5m6ErjGTDSYu6rGjOlZo2WieB3zJXr7w==
X-Received: by 2002:a17:907:2ce2:b0:abf:51b7:6071 with SMTP id
 a640c23a62f3a-ac3301768d7mr1583550566b.13.1742286701807; 
 Tue, 18 Mar 2025 01:31:41 -0700 (PDT)
Received: from eta.play.pl ([2a02:a312:c49b:a180:4e11:d045:a94e:c696])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac314a3e0acsm816189366b.142.2025.03.18.01.31.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Mar 2025 01:31:41 -0700 (PDT)
From: Artur Kowalski <arturkow2000@gmail.com>
To: u-boot@lists.denx.de
Cc: Artur Kowalski <arturkow2000@gmail.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Thierry Reding <treding@nvidia.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 4/4] board: asus: transformer: add DTSI file for enabling UART
 over uSD slot
Date: Tue, 18 Mar 2025 09:30:47 +0100
Message-ID: <20250318083103.63250-5-arturkow2000@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250318083103.63250-1-arturkow2000@gmail.com>
References: <20250318083103.63250-1-arturkow2000@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 18 Mar 2025 13:47:17 +0100
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

It is required to set

CONFIG_DEVICE_TREE_INCLUDES="tegra20-asus-transformer-uart-usd.dtsi"

if CONFIG_TEGRA_ENABLE_UARTA (and only if) is enabled for U-Boot to
boot properly, otherwise only SPL will work, but U-Boot when trying
to use UART that wasn't enabled by SPL.

Signed-off-by: Artur Kowalski <arturkow2000@gmail.com>
---

 .../tegra20-asus-transformer-uart-usd.dtsi    | 31 +++++++++++++++++++
 1 file changed, 31 insertions(+)
 create mode 100644 arch/arm/dts/tegra20-asus-transformer-uart-usd.dtsi

diff --git a/arch/arm/dts/tegra20-asus-transformer-uart-usd.dtsi b/arch/arm/dts/tegra20-asus-transformer-uart-usd.dtsi
new file mode 100644
index 00000000000..accb086774c
--- /dev/null
+++ b/arch/arm/dts/tegra20-asus-transformer-uart-usd.dtsi
@@ -0,0 +1,31 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR BSD-3-Clause
+
+/ {
+	chosen {
+		stdout-path = &uarta;
+	};
+
+	serial@70006300 {
+		status = "disabled";
+	};
+
+	serial@70006000 {
+		status = "okay";
+		clock-frequency = <216000000>;
+	};
+
+	sdhci@c8000400 {
+		status = "disabled";
+	};
+
+	pinmux@70000014 {
+		pinmux {
+			/delete-node/ sdb;
+
+			dbguart {
+				nvidia,pins = "sdb", "sdd";
+				nvidia,function = "uarta";
+			};
+		};
+	};
+};
-- 
2.48.1


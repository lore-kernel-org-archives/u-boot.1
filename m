Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CCCAC4332F
	for <u-boot@archiver.kernel.org>; Fri, 10 Nov 2023 23:59:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BDF48871F8;
	Sat, 11 Nov 2023 00:59:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=shantur-com.20230601.gappssmtp.com header.i=@shantur-com.20230601.gappssmtp.com header.b="EtTQO/Ox";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E95798761C; Sat, 11 Nov 2023 00:59:27 +0100 (CET)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 126CD871E6
 for <u-boot@lists.denx.de>; Sat, 11 Nov 2023 00:59:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=i@shantur.com
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4094301d505so18891385e9.2
 for <u-boot@lists.denx.de>; Fri, 10 Nov 2023 15:59:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=shantur-com.20230601.gappssmtp.com; s=20230601; t=1699660765; x=1700265565;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=cRc0MkceLeU4jLV0jIb/L9HT3lCLMoKNwByrZAkhxGU=;
 b=EtTQO/OxQ2DJ957155+kDWHQDGQSIYhi0BaobC9d0tSJRW65wuH8zxo4pFTcpzQepb
 XTFWw9N4OzORfcqhfc/BFpKKkMqXZSvIs91st8is+OVW2vEEs0tQKicxoTaCMPhzHe9x
 Gd7VkWJQkU4iJoLpeyuqh3yO1c1gZ8JhITi+m/fZ7OEltj5kSig8cpzNaMlljQEVKOEo
 zMs4DigXrT3w1wcWjsJQ4uxh2AEU/nmLfkyEzaN2I/Hm4IGfBa+W8cWn8PfrHUutUGT8
 o6xGC6heuSNeFH/iQaS8Rmd/FGmLavbYIj3uIY5MR7/6wT1xdcOGgdebRjUJnEgQ6aPV
 KSiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699660765; x=1700265565;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cRc0MkceLeU4jLV0jIb/L9HT3lCLMoKNwByrZAkhxGU=;
 b=BUz+EGBsxsxzMdA5w2pMTjWyxW+7UCWqiXODUIM8AmH9LGqcKUS5lIc4nPYtOOOg3n
 z5gkpXQK92k3inDb+lqZRyA4hOM/HXDAs8pkd/SxjuxgCeFHn9VyMQx/ccOSjYKmYLuI
 ZOMZvy3uQjZDzM3Yjv9Zvze5OIXv8DvLdKhyqjOp4oLNFUd3qnUojGO8afVFkFMR+dLO
 VYLXxU4OyzvzHVBN0WCk2FMcaP+HbYjgvfOcpiMRT/70WfBiboUVOVktUFPTU6mM+VJb
 tGYDo4MDeAvon4Qs5RMaKq6yLSyhyX9EJfBX6pXKAS3TGHF+1PJ0p2pvJqymJsDAPUOx
 JX9Q==
X-Gm-Message-State: AOJu0YxImhcIwGlyb2knRVNuWIp5wuVnoa9h9tQIwJArxMiBzr6IIdqL
 Lr93v8WI99Iv6/px/MaEW4fpTB9p2ArdP2wDMiSRnSOh
X-Google-Smtp-Source: AGHT+IFSSDpbHCOfwJvvsY99TpxkWNv07xxQmC7OX8LU6JtKlBplNUj0Y9N/cLd7Obh7uKFUyL2dAA==
X-Received: by 2002:a05:600c:2d0b:b0:408:3c10:ad47 with SMTP id
 x11-20020a05600c2d0b00b004083c10ad47mr581630wmf.40.1699660765027; 
 Fri, 10 Nov 2023 15:59:25 -0800 (PST)
Received: from localhost.localdomain (host-212-159-138-247.static.as13285.net.
 [212.159.138.247]) by smtp.gmail.com with ESMTPSA id
 20-20020a05600c025400b004065e235417sm6402857wmj.21.2023.11.10.15.59.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Nov 2023 15:59:24 -0800 (PST)
From: Shantur Rathore <i@shantur.com>
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu, kever.yang@rock-chips.com,
 Shantur Rathore <i@shantur.com>
Subject: [PATCH] arm: dts: rockpro64: Add RockPro64 smbios
Date: Fri, 10 Nov 2023 23:58:06 +0000
Message-Id: <20231110235806.525529-1-i@shantur.com>
X-Mailer: git-send-email 2.40.1
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

---
 arch/arm/dts/rk3399-rockpro64.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/dts/rk3399-rockpro64.dtsi b/arch/arm/dts/rk3399-rockpro64.dtsi
index 6bff8db7d3..cf850a69e6 100644
--- a/arch/arm/dts/rk3399-rockpro64.dtsi
+++ b/arch/arm/dts/rk3399-rockpro64.dtsi
@@ -20,6 +20,26 @@
 		stdout-path = "serial2:1500000n8";
 	};
 
+	smbios {
+		compatible = "u-boot,sysinfo-smbios";
+		smbios {
+			system {
+				manufacturer = "PINE64";
+				product = "RockPro64";
+			};
+
+			baseboard {
+				manufacturer = "PINE64";
+				product = "RockPro64";
+			};
+
+			chassis {
+				manufacturer = "PINE64";
+				product = "RockPro64";
+			};
+		};
+	};
+
 	clkin_gmac: external-gmac-clock {
 		compatible = "fixed-clock";
 		clock-frequency = <125000000>;
-- 
2.40.1


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B16B5C35FFF
	for <u-boot@archiver.kernel.org>; Thu, 20 Mar 2025 12:52:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 42FDB803CC;
	Thu, 20 Mar 2025 13:52:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="RNmyx0ru";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6EA468141E; Thu, 20 Mar 2025 13:52:09 +0100 (CET)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1584880540
 for <u-boot@lists.denx.de>; Thu, 20 Mar 2025 13:52:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-aaeec07b705so124370666b.2
 for <u-boot@lists.denx.de>; Thu, 20 Mar 2025 05:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1742475126; x=1743079926; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rdkNWU2tW65WejyaUDiiyRrCxdRlFjOHXvPOKRWKRTo=;
 b=RNmyx0ruGAJ3T8AOk63vkoIJ/Xh6+ysbosuj8/1N8eLP8n6nWA83qXEEG0/vyyfhIZ
 WTQIWoHPT6oGilDeDPtNlINDBgUaKnnKJAi/HjCpvTRXef69zFrgki8l8KN811cT+YUY
 uzgh5gG92FV06C8SS4j28NjZAL+kkFW8RJpig9nFK7uSylBshcZvM7Q7Y9WnvrDpaNR+
 /nodw1BKmNP4itYGw6k6yiNbnqNcFsFx57uSutgLsWQvBIQwObHhzdMyQHSNfPhor9tC
 lSAqlIEZDYHxCuQwX0B9z59u1aA4XEnmfIxLokeQDQtocO6kOGAPVglVaU8BLOetdMkQ
 IUwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742475126; x=1743079926;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rdkNWU2tW65WejyaUDiiyRrCxdRlFjOHXvPOKRWKRTo=;
 b=P2q7dfMilymooMmFahb3Y3PxdDvjHHGRBM0WT0I6rYDMrI5GTDM4QoU+nLof5Y4tA9
 IMj7N6ok/pbHndPQjJr7enZ06Zzqk70Ds8s4wQU42fuf0yBS+xX2ZMLrLQrYuQ5XpJY9
 T+lOIfzqUdfR0KZQEEprx3CR64BSnF6ygf2FYyTYvx+nTddI97Qigi2ZRhSQgZdmBFS2
 WvL5tMudfzS32ci6cXYcDtnwyLRZNlrwq7x+cS0ZZrozgWMzUUaaWX6CjL+nsPWNOrED
 Ud9HD+qNS8w4+gryESGCWRaB1YceTj5AEqi4Ncui/um168hBi5q18136KZIjwtkj2Jtc
 7eDw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVooxBlcyBWDPcsuigl0K1tbYdUIPCZ3dICfAU9rpa2+HfARcCJzbRMEx72sjB25udBHuN0/T4=@lists.denx.de
X-Gm-Message-State: AOJu0YyfHLHP4tFqj2EXHQML8A/ZuEyODpz/NRVM7AFMpmXy5GNdq/YT
 Ll6AlFzmhqjWUt/uWujUGWgroYFQfShZGmME4aa5n9DFbVsa0WjWLcM798LeqPA=
X-Gm-Gg: ASbGncsw1F9hkrUnT6dNSpEMukB2TBZOdeJbjyMZC870mTJ3sKpRPBKFbLdbjN58w76
 do4QIQHXCE0UDS6PnknwVH57+rtBlyXD1MES5QJSeyDiWUK3UbVlp00NVtawN0HdZ1f00e+p58p
 hyUIxUVDUUSODiVGrYYL/VOnWunzzJvb+tnTlOezP6KIrViEvgP+dG1LRIzhY2xdz+8w7plARVa
 ZgSPDgLJ3J6HJGC/0v8BhA8m3MRWAxEH0AIg2vjdT1JPRoNGX69d19N7X230444FEvASPWXm+aq
 KSUHVbodKSNwes2rjfRLCTsAEMhV91ANRrvLWco2apbZo491zUNse6pTBuL2nhbt8ewrQZHX3BP
 NI4kOIbccVDoFTnr84z/kLjETkV3GGgSZiH2u8JrROtQ=
X-Google-Smtp-Source: AGHT+IHjvByMTj6zzIeabOZbSCyfekodhJ89tM17KaCI2a6mKESFq9um6TSepGQnRhNPX1Rp1R7Vdg==
X-Received: by 2002:a17:907:60ce:b0:ac2:6913:7cc6 with SMTP id
 a640c23a62f3a-ac3b7d7f6d9mr700385766b.31.1742475126253; 
 Thu, 20 Mar 2025 05:52:06 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac314a462basm1162284666b.133.2025.03.20.05.52.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Mar 2025 05:52:05 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: Tom Rini <trini@konsulko.com>
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
	u-boot@lists.denx.de
Subject: [PATCH 2/3] emulation: qemu-sbsa: Move ITS node into GICv3 node
Date: Thu, 20 Mar 2025 13:51:57 +0100
Message-ID: <20250320125201.27459-2-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250320125201.27459-1-patrick.rudolph@9elements.com>
References: <20250320125201.27459-1-patrick.rudolph@9elements.com>
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

According to the binding [1] the ITS node should be a subnode of the
GICv3 node. Thus move it now that the driver binds subnodes as well.

1: https://www.kernel.org/doc/Documentation/devicetree/bindings/interrupt-controller/arm%2Cgic-v3.txt

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
---
 arch/arm/dts/qemu-sbsa.dts            | 10 ++++++----
 board/emulation/qemu-sbsa/qemu-sbsa.c |  2 +-
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/arch/arm/dts/qemu-sbsa.dts b/arch/arm/dts/qemu-sbsa.dts
index ed00e501366..099b51b927f 100644
--- a/arch/arm/dts/qemu-sbsa.dts
+++ b/arch/arm/dts/qemu-sbsa.dts
@@ -97,11 +97,13 @@
 		      /bits/ 64 <0 0>,
 		      /bits/ 64 <SBSA_GIC_HBASE_ADDR SBSA_GIC_HBASE_LENGTH>,
 		      /bits/ 64 <SBSA_GIC_VBASE_ADDR SBSA_GIC_VBASE_LENGTH>;
-	};
 
-	its {
-		compatible = "arm,gic-v3-its";
-		status = "disabled";
+		its: msi-controller {
+			compatible = "arm,gic-v3-its";
+			msi-controller;
+			#msi-cells = <1>;
+			status = "disabled";
+		};
 	};
 };
 
diff --git a/board/emulation/qemu-sbsa/qemu-sbsa.c b/board/emulation/qemu-sbsa/qemu-sbsa.c
index 3943c924320..cf1d5acf5cb 100644
--- a/board/emulation/qemu-sbsa/qemu-sbsa.c
+++ b/board/emulation/qemu-sbsa/qemu-sbsa.c
@@ -202,7 +202,7 @@ static int fdtdec_fix_gic(void *fdt)
 	smc_get_gic_its_base(&gic_its_base);
 
 	if (gic_its_base != 0) {
-		offs = fdt_path_offset(fdt, "/its");
+		offs = fdt_path_offset(fdt, "/interrupt-controller/msi-controller");
 		if (offs < 0)
 			return offs;
 
-- 
2.48.1


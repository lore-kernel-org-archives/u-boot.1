Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29D27C28B2E
	for <u-boot@archiver.kernel.org>; Tue, 11 Mar 2025 13:15:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E73FE81951;
	Tue, 11 Mar 2025 14:13:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="sw6b4a1S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A0443817D8; Tue, 11 Mar 2025 11:33:15 +0100 (CET)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BD7CC814B6
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 11:33:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-ac29fd22163so347244566b.3
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 03:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1741689184; x=1742293984;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=pB1J2MeRTHZAIiyD3LZDGYL24tE5mL89PjlCxwqX9Mk=;
 b=sw6b4a1S5AGea60yh80NWpldYMudF9G1FelAam1mfNX2e5ME/JGr7oaEZFYzxYjf9f
 9zozr6A28C1lanuoR0Q/rv+vzX2AXAKVAoyO7m8razx2GydXz91oRN1O0dP6+NbHFdxp
 hODPR1Fkctzcaidir5JIEXXWcF8sGCCeXngoaEuifbeSk6cAvgf8AK0YO8wYVa3sX8Wp
 MZWWoroYfq+BYSlQEcpa28CajwFVnjgcT6pWfzMn2CKFeyNr16zPP+Ea1/bkmpCIj72T
 N8AtiqfNrqbyqXfF9Qk/uhj24nUepUCqVUP89n4PW6qN5RSbWmf5GYTa9g6iOkbRFx3d
 9MSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741689184; x=1742293984;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pB1J2MeRTHZAIiyD3LZDGYL24tE5mL89PjlCxwqX9Mk=;
 b=KFQaZilTL/mAjXiUIw+RcFUddedQ2ED90k2rNlaTXzSR9jIkGJB5W84GGSllrU+fwx
 qTQdiE4kTKOhfdESfj9D0jJqSGN/xfecBdyaEUVzo6k+wijAWh492ccaG81vR19cTKKB
 tVb8KQbAhHDjzl/ibCaKwUaswT6kGcA8Wg5L+qjUT9v7R27fp7ZlEij1ioTxRk92vXQs
 q2AMnq1ZvfUMESvKJsENIDL77QARTJ1yKxysT9GUroYrv/Qqk1lid43TbTMfY4IVxKAQ
 HM9X+WRbPz/g8ft+cEmFZRKspJZP25q18T0enS+3yQ2c/Kqzqqo422eBjQrJXFrUyrh4
 rY5g==
X-Gm-Message-State: AOJu0YxrPcPEhzmxL3FBgleHh1Yz2+1PCG39t1vzN/J4eQnoa0JsQNwa
 4zgc9sG3Udfx0VKnIRLJWE+0A8+hMB0aWxHBpQQ2FHSb+9ruYZOcIJimoBYtZgMJfEkNfpqCsFC
 S
X-Gm-Gg: ASbGncuqb29TTutgu5PvVYmi7GUc0J61O9mFsim4LC6KeYkQFQv9w/gDzN5WGoNdGI9
 CDgL26j6nZzsACpI3ZsDz1L6pyISM/wUb9burRE4HUtYyQVq0M1xm66+ZZrt8V+A3ZgHQDPIwOq
 1orO4by7wroA9xCo8gr7kVRIxaJX4gp+Ld34D62IUCP/I6IkriBKkCsCPPnEl/jrpLR3AE/sTnD
 gDT0KkWXSF8MFFzde/rcxu9HlAhPuPvXatyL2ri+Dl18m69l7IILtMP4aOZYet1Jj3h6GXEODQ+
 7PCQ7l+6AdNsDGyHFJwCyxAODemiwSdcfmDUPI8L
X-Google-Smtp-Source: AGHT+IGkCR6iLVVD2xSyHNklmsEPDJqBisEF3Pt0TePf9KUn0Ca9b9kceT+0JWgcPhU1LB7MTlmnqQ==
X-Received: by 2002:a17:907:6d08:b0:abf:742e:1fd7 with SMTP id
 a640c23a62f3a-ac253096a6amr2177626966b.57.1741689184088; 
 Tue, 11 Mar 2025 03:33:04 -0700 (PDT)
Received: from localhost ([2001:4090:a247:83e0:938:b3cb:2c1b:889c])
 by smtp.gmail.com with UTF8SMTPSA id
 a640c23a62f3a-ac29363d604sm391503566b.76.2025.03.11.03.33.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Mar 2025 03:33:03 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
Date: Tue, 11 Mar 2025 11:30:55 +0100
Subject: [PATCH 16/19] arm: dts: k3-am62a: Add r5 device nodes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250311-topic-am62-ioddr-v2025-04-rc1-v1-16-666de9c105cb@baylibre.com>
References: <20250311-topic-am62-ioddr-v2025-04-rc1-v1-0-666de9c105cb@baylibre.com>
In-Reply-To: <20250311-topic-am62-ioddr-v2025-04-rc1-v1-0-666de9c105cb@baylibre.com>
To: Tom Rini <trini@konsulko.com>, Sumit Garg <sumit.garg@linaro.org>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>
Cc: u-boot@lists.denx.de, Vishal Mahaveer <vishalm@ti.com>, 
 Kevin Hilman <khilman@baylibre.com>, Dhruva Gole <d-gole@ti.com>, 
 Sebin Francis <sebin.francis@ti.com>, Kendall Willis <k-willis@ti.com>, 
 Akashdeep Kaur <a-kaur@ti.com>, 
 Markus Schneider-Pargmann <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=932; i=msp@baylibre.com;
 h=from:subject:message-id; bh=jZQfqCc8S68dfzQYXneZp1zfMMK4Pey9hMM3BxvEpeY=;
 b=owGbwMvMwCGm0rPl0RXRdfaMp9WSGNIvCFqvkW7wSNteYLP1QXv6UvvAbVvjX9zerPFFqXTlt
 oOthfmXOkpZGMQ4GGTFFFnuflj4rk7u+oKIdY8cYeawMoEMYeDiFICJ2LMxMkyxfFKReVFhodXJ
 8v23NZW2n/n1aUKR49SCNXE2CZ8SiqMZGeac9JROfez1YobEt+/5N48cvDiP+f0Rk+bK5akPv+T
 E3ucFAA==
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-Mailman-Approved-At: Tue, 11 Mar 2025 14:13:18 +0100
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

These are needed in SPL to be able to resume from DDR immediately after
booting from IO+DDR.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 arch/arm/dts/k3-am62a7-sk-u-boot.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/dts/k3-am62a7-sk-u-boot.dtsi b/arch/arm/dts/k3-am62a7-sk-u-boot.dtsi
index 7dfbeb10c323bbe1f935a50e3efc87b3276f044e..31cd27670e61ae662ba718daea5307217a143ce8 100644
--- a/arch/arm/dts/k3-am62a7-sk-u-boot.dtsi
+++ b/arch/arm/dts/k3-am62a7-sk-u-boot.dtsi
@@ -14,6 +14,14 @@
 	memory@80000000 {
 		bootph-all;
 	};
+
+	reserved-memory {
+		bootph-pre-ram;
+	};
+};
+
+&wkup_r5fss0_core0_memory_region {
+	bootph-pre-ram;
 };
 
 &cbass_main {
@@ -68,6 +76,14 @@
 	bootph-all;
 };
 
+&wkup_r5fss0 {
+	bootph-pre-ram;
+};
+
+&wkup_r5fss0_core0 {
+	bootph-pre-ram;
+};
+
 &cbass_wakeup {
 	bootph-all;
 };

-- 
2.47.2


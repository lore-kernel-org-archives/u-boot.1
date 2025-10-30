Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2907DCCF9F0
	for <u-boot@archiver.kernel.org>; Thu, 30 Oct 2025 13:03:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF8B883946;
	Thu, 30 Oct 2025 14:00:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="FPNevthw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 69F5883893; Thu, 30 Oct 2025 11:01:46 +0100 (CET)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F1CF8352B
 for <u-boot@lists.denx.de>; Thu, 30 Oct 2025 11:01:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-475dc6029b6so9208165e9.0
 for <u-boot@lists.denx.de>; Thu, 30 Oct 2025 03:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1761818504; x=1762423304;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=QkgLO7HDgHpvm5lOry3irodjYEiH+w/mT5BHZ742H9k=;
 b=FPNevthwW9Z9EA2tG60dG+3SZj1o2x+f5wY8cw6dJ9UyGDvXEceBf17ZogfE+LTBN2
 uU/v40aCyhklfj5aYlrVQnsmeHJ8pRQB5Qfi50kd1QlkXaw20MyxEDyu45w80diO+k38
 C2eLP8IRGreJdRkgHvull6cuK7hlRblUNbdLfWR5RW0Ks9xFpDdhqW0EKNTbYVGNKsmX
 R9KvlclRVeJ6TP9IQW28tGiiPKfc/mhn8SARfHErdEMH1nTtqYH0a1jA5dhovsYm1hN3
 pSy4IojlIL9saGQE2M+HI0p+LphbZm4mG4ddUAHBpCTZNP5D7dm0S0/W/Iq9ek5iRRrB
 m3Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761818504; x=1762423304;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QkgLO7HDgHpvm5lOry3irodjYEiH+w/mT5BHZ742H9k=;
 b=uzbpb9Oby/Ou9IyWMJMmOdyfT0Vk5wn8g3XfD18/Ey3TtYfixFD1k6O4YSs2QD7u4E
 kzdxnF+H6fh/n0bYub2XEy4SG2r5TlUZg7IkwWUeHOpIGIymVtWXaosjGFCP3z0B4dHW
 kNg0gCTj8k9hK8MUtWxyXmWG+/7FR76KGNp0saI6SjZwbD9RbMXk79j0OO/IVbZ+TRAj
 DgDugECgARtLeH/+q5FQUm6oqZp2IrScAHfWtS10t9W/AT8yK0wkgXgvTF0a+rGhqYlh
 NArq2tZnMmI494lJA81p+AO6aJvrBZhyyN5hLIAnKgI3RMN+LyFlCBZM2HZsJlHJGjiU
 EfhA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXIT+/8VOhgfvXDyC6Qw76kgZ+ipJpUE2h6o5wOlj/QLxXX5bLgpSIjL3cVXKvzWueZTUBcwUE=@lists.denx.de
X-Gm-Message-State: AOJu0YzZcXzQZKQQw49hND30JeCarAfR70JXmN5skzduVwaIL3fMYgX5
 kW7ZEZ1BbVlIEHMQbu3yOIaq+ZA+vFYMjOKbpEDnKqIxKNJKtn3o3ZOJX0FPGOGu8L8=
X-Gm-Gg: ASbGncuX64Ax7A1kYab2/Ht7xBl+EV//r69oioMsDih6N5x6Df1CbxXA2gtwAGbLc/2
 gLMMjZb/z2XQuO7Duh06E96sQkUJVqw36kozxMzbDlSFe9gEiH28RDs/mmI1EH8uWd82jQ83122
 z9csGlzdWuLGM+ifWMN+EXS3PseTxxvSuS9WgL2EY1FDMYNezLmBw6K7B3dnDFZOZXXn9jPgRhG
 cGw2NEnKFmoWKvga+oqgOYSFf89nmU6CQC9ff2RteGc9nKHm7KHKhooClbTkvnPpy+jxy9SGsS3
 h4jdbQxjvBeLhKwCdrREk6KeQf5Wf5+SSHzZXW0Kec+JKmVnsoeE0BW6ud9lJUXSgZEY8S1zeAk
 30H0REYhauhV4rMLIw/zfnKA1Ckb/TpOgotGDNSYwkQovMB9dDWW3ejl/AD34L0Pjc/nHdHPQkG
 9tmkgiGYKT
X-Google-Smtp-Source: AGHT+IH8eaNQMeNX7+amRb6YQhBAefNdYgXyd86opsc4jeUvBju7hEokTRYVYGCluRFYIzaZVTHDaw==
X-Received: by 2002:a05:600d:4342:b0:470:fe41:a93d with SMTP id
 5b1f17b1804b1-4771fb4546fmr31034205e9.4.1761818503696; 
 Thu, 30 Oct 2025 03:01:43 -0700 (PDT)
Received: from localhost ([2001:4090:a245:8496:49da:2c07:5e9a:7fb9])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-47718ffa42bsm64509815e9.4.2025.10.30.03.01.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Oct 2025 03:01:43 -0700 (PDT)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Date: Thu, 30 Oct 2025 10:59:29 +0100
Subject: [PATCH v4 11/13] arm: dts: k3-am62p: Add r5 device nodes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251030-topic-am62-ioddr-v2025-04-rc1-v4-11-4cef18af0226@baylibre.com>
References: <20251030-topic-am62-ioddr-v2025-04-rc1-v4-0-4cef18af0226@baylibre.com>
In-Reply-To: <20251030-topic-am62-ioddr-v2025-04-rc1-v4-0-4cef18af0226@baylibre.com>
To: Tom Rini <trini@konsulko.com>, Sumit Garg <sumit.garg@kernel.org>, 
 Nishanth Menon <nm@ti.com>, Robert Nelson <robertcnelson@gmail.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>
Cc: Vishal Mahaveer <vishalm@ti.com>, Kevin Hilman <khilman@baylibre.com>, 
 Dhruva Gole <d-gole@ti.com>, Sebin Francis <sebin.francis@ti.com>, 
 Kendall Willis <k-willis@ti.com>, Akashdeep Kaur <a-kaur@ti.com>, 
 u-boot@lists.denx.de, Anshul Dalal <anshuld@ti.com>, 
 Moteen Shah <m-shah@ti.com>, Santhosh Kumar K <s-k6@ti.com>, 
 Nathan Morrisson <nmorrisson@phytec.com>, 
 Garrett Giordano <ggiordano@phytec.com>, Judith Mendez <jm@ti.com>, 
 Aparna Patra <a-patra@ti.com>, Jayesh Choudhary <j-choudhary@ti.com>, 
 Chintan Vankar <c-vankar@ti.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Neha Malcom Francis <n-francis@ti.com>, 
 Prasanth Babu Mantena <p-mantena@ti.com>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, Beleswar Padhi <b-padhi@ti.com>, 
 Manorit Chawdhry <m-chawdhry@ti.com>, Andrew Davis <afd@ti.com>, 
 Wadim Egorov <w.egorov@phytec.de>, Udit Kumar <u-kumar1@ti.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, E Shattow <e@freeshell.de>, 
 Devarsh Thakkar <devarsht@ti.com>, Peng Fan <peng.fan@nxp.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Andre Przywara <andre.przywara@arm.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=959; i=msp@baylibre.com;
 h=from:subject:message-id; bh=/zqBD26sQ5+GFH4CKZkEWhThfwE8BU+tQUSEtX6ZxHY=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhkxm8xjnSQpCegeSlstM2NR/NWRbdvbvTX3mSVcvW17+0
 S7B5Xeoo5SFQYyLQVZMkaUzMTTtv/zOY8mLlm2GmcPKBDKEgYtTACby9TvDX5lJixm2PW1sci4/
 vEuX6VK4qf8JJ8eLPfc1Sy9M285wdi4jw8kp9x9wddnJ7I29uqeTK9ql/m7HRe+D7b8YivrKSo9
 6MAMA
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-Mailman-Approved-At: Thu, 30 Oct 2025 14:00:47 +0100
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

Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
---
 arch/arm/dts/k3-am62p5-sk-u-boot.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/dts/k3-am62p5-sk-u-boot.dtsi b/arch/arm/dts/k3-am62p5-sk-u-boot.dtsi
index cf087c6e343a8af6f4bb2093bb6c3f28395a2686..8c2b198dede03fd77f16786f8743313a34902e46 100644
--- a/arch/arm/dts/k3-am62p5-sk-u-boot.dtsi
+++ b/arch/arm/dts/k3-am62p5-sk-u-boot.dtsi
@@ -11,8 +11,28 @@
 		stdout-path = "serial2:115200n8";
 		tick-timer = &main_timer0;
 	};
+
+	reserved-memory {
+		bootph-pre-ram;
+	};
+};
+
+&wkup_r5fss0_core0_memory_region {
+	bootph-pre-ram;
+};
+
+&cbass_wakeup {
+	bootph-pre-ram;
 };
 
 &dmsc {
 	bootph-pre-ram;
 };
+
+&wkup_r5fss0 {
+	bootph-pre-ram;
+};
+
+&wkup_r5fss0_core0 {
+	bootph-pre-ram;
+};

-- 
2.51.0


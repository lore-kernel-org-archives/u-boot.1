Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0F00D1F9DE
	for <u-boot@archiver.kernel.org>; Thu,  4 Dec 2025 12:55:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A11C840B1;
	Thu,  4 Dec 2025 13:52:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="y7gQXPGB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD00F8402E; Thu,  4 Dec 2025 11:26:45 +0100 (CET)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C6B2683FE9
 for <u-boot@lists.denx.de>; Thu,  4 Dec 2025 11:26:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-64162c04f90so1331805a12.0
 for <u-boot@lists.denx.de>; Thu, 04 Dec 2025 02:26:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1764843998; x=1765448798;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=aqRhQ6IT07IwRp3j8ieCS+5dDI7dJIchyZcTdaT0VBg=;
 b=y7gQXPGBgCtk2ii2Cti4ZnGjePKLJCXGPgaSHuDEufDtgr7wP2prw5rzXhtiMyavJT
 9OFMcKZmA8u3uBJw0mqnjSe6JNZtQxi/b2gBlTY0vxB8Wxc7U0GJzjWrK9w1yMAN5DsT
 bVchI3VlDPYC4ZndU6uc6z8BAm/zy0JQiW7degDp/gMcEbWp+N3w2uREaAZE6yGGdoHs
 MRI3oFzfCxuB/Y7va7JtIGWs7JJNDHKZGB5n5Zm8JEOp63UyLTroWODzlpJmqc7vKBop
 plSHsNsR1fJO60OXw1zeNpu+mnsZDEsxxhTtUDleVdOzne0UFyK/V20UWH2LWEftHszf
 by/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764843998; x=1765448798;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=aqRhQ6IT07IwRp3j8ieCS+5dDI7dJIchyZcTdaT0VBg=;
 b=QGx81mFHe1qmaUzqItaQ83tuYzEVWTv1MK9ad5vLFyEWLWT0jJWXPqg4uQ6vXI+H58
 qDrMFHsFGRO4QOiYxrJFrwioGygdvlZtC7lrSPOuHyzWdpSCPawj/Tz76nNEv8CftD/C
 h9Blp3gvTriJvcex8fztqWzV+EjLFvy/GapRwUifmCKWLKhbyMvPU/36itdfSOlmrVP0
 DvL5MXPhf3GMoAYjK5Rrj98DXyKwHuzwCWw5ZqJIZ6QAt5qcK/jBsrNqmiZiPEyR2h+u
 4ZNy9pgM1rAVqCd6Y/4TrI1b8YzT8j/N8y22A8W9GnJ5d20XSuY952agiq3YmsBK1FnG
 65GQ==
X-Gm-Message-State: AOJu0YwB+94xWfzNxEzHdLk8sJp3uddRTe9AhLZOTHpXZ0uaotpqs3E3
 XzM1JkYg+ShBhhSHij287IvrMqecrLom65U0QxoDBQMDFvPrFgZYm1EiiXwpVdk7yfM=
X-Gm-Gg: ASbGncu68F3nfE9HD+2PMyiPkJaVPZkLbG93Lee0qk6L1DkV7NGk7M8P/36ZLhBlk5K
 OPRYsgzQue+62LxiaB1eWDRSxOpNGwjH1tyk83iOjccwOYggvTWJZ1Vzgg2E5Z7EpfFkWK43B1r
 qBnuGZiyscHdkzQNJEuakIEPfMIlMz7JmIbgEjv491geIZM6x5DD934Evld3plXYJecN5gRAM+T
 K9A6k87f8tcXRy9SLxdjegwOf3yLj9Dn2gIPwAHiTg4nbcsRXxEAsO8oowT91jBUXVFJxDwOCCU
 DueW+bWZp4lF1onpTkGBWlrNBlsoUPNb7SWomCcJksY2eD2cAQ/JxEX3B92MtbRlLX6i3/3zq2N
 MSg6R0cPO+raCIjm26oLlCCQZW4TE/I6DT8It3/Oj5vElwU26eN+OTSaueV+nKPR3Lqi/oKkYwN
 /O7mnIMzc=
X-Google-Smtp-Source: AGHT+IGO0PSDXEPV3VU8nrIJ1pCNBHdKiKDLeE2kD+3odMlEOa5AtJp18ALsIMB2vCJkdz1nPssnFw==
X-Received: by 2002:a17:907:3d87:b0:b73:6f8c:612b with SMTP id
 a640c23a62f3a-b79dbea6b40mr576416566b.16.1764843998184; 
 Thu, 04 Dec 2025 02:26:38 -0800 (PST)
Received: from localhost ([2001:4090:a247:809c:875a:7c11:12fc:ed9])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b79f49d24a6sm90489866b.54.2025.12.04.02.26.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Dec 2025 02:26:37 -0800 (PST)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Date: Thu, 04 Dec 2025 11:25:41 +0100
Subject: [PATCH v3 5/9] am33xx: Avoid hard failure on USB probe issue
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251204-topic-am33-evm-oftree-v2026-01-v3-5-3d1566ce4dc7@baylibre.com>
References: <20251204-topic-am33-evm-oftree-v2026-01-v3-0-3d1566ce4dc7@baylibre.com>
In-Reply-To: <20251204-topic-am33-evm-oftree-v2026-01-v3-0-3d1566ce4dc7@baylibre.com>
To: u-boot@lists.denx.de, Marc Murphy <marc.murphy@sancloud.com>
Cc: Tom Rini <trini@konsulko.com>, Rasmus Villemoes <ravi@prevas.dk>, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Romain Gantois <romain.gantois@bootlin.com>, 
 Parvathi Pudi <parvathi@couthit.com>, 
 Basharath Hussain Khaja <basharath@couthit.com>, 
 Paul Barker <paul.barker@sancloud.com>, "Andrew F. Davis" <afd@ti.com>, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1160; i=msp@baylibre.com;
 h=from:subject:message-id; bh=zuobKnXYYi/Fzs28jBJx2oOJLSMSd/p7qGGBAXD3ouw=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhkzDxH0T1twuZTFQW599q7y8vFNrZd2n/U4pX1X2T5z8J
 Sn5bklSRykLgxgXg6yYIktnYmjaf/mdx5IXLdsMM4eVCWQIAxenAExEcx0jQ/+KXm3Ja1cNAowf
 tb71O7vEJ58lvfSUNlt6EWt8rPGmawz/Q3X2/dNYxTgxcvOtcpe3HzojQ4RrGs++Tmvu59wzqZW
 XCwA=
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-Mailman-Approved-At: Thu, 04 Dec 2025 13:52:18 +0100
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

Currently if USB fails to probe, U-Boot does not reach the console.

This patch does not fail if USB fails to probe making it easier to debug
in case of issues.

Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
---
 arch/arm/mach-omap2/am33xx/board.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/am33xx/board.c b/arch/arm/mach-omap2/am33xx/board.c
index 4e9ad8935e3b5020c4ed1d022ae4846a2dc9486f..90b341303c7309dc21b34cc01020db997f53c8f3 100644
--- a/arch/arm/mach-omap2/am33xx/board.c
+++ b/arch/arm/mach-omap2/am33xx/board.c
@@ -266,12 +266,17 @@ int arch_misc_init(void)
 	struct udevice *dev;
 	int ret;
 
+	/*
+	 * Trigger probe of the UCLASS_MISC device which is a USB wrapper driver
+	 * ti-musb-wrapper that handles all usb host and gadget devices.
+	 */
 	ret = uclass_first_device_err(UCLASS_MISC, &dev);
 	if (ret)
-		return ret;
+		printf("Failed probing USB %d, continue without USB\n", ret);
 
 #if defined(CONFIG_DM_ETH) && defined(CONFIG_USB_ETHER)
-	usb_ether_init();
+	if (!ret)
+		usb_ether_init();
 #endif
 
 	return 0;

-- 
2.51.0


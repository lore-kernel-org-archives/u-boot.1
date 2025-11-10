Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D85E8CCF9E3
	for <u-boot@archiver.kernel.org>; Mon, 10 Nov 2025 20:15:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9BF9383F5D;
	Mon, 10 Nov 2025 21:13:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="zF2xlMmU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7885183A98; Mon, 10 Nov 2025 21:11:57 +0100 (CET)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 910B483AA1
 for <u-boot@lists.denx.de>; Mon, 10 Nov 2025 21:11:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-b3e7cc84b82so649660766b.0
 for <u-boot@lists.denx.de>; Mon, 10 Nov 2025 12:11:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1762805515; x=1763410315;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=TPlhNJYJ2bp34zf3iWtlyd49cNmFUmc7Y7jbQrgWnC0=;
 b=zF2xlMmUR7WogwhAc9f1wHz/GssyKtEd/iC+/7+Pkhwpim8/y9fHd97XpsA4RgIR77
 C8e80KlxeAjXdx99Fjl4EIyq7Okuo7I7pn3WdUSf9O9ictWjPpwWYgg9xGkqZfRhjnZk
 5UCV8acRkRg1I2NnCwA8JcN2/C4E8EAxRYZw0kjSitpqcfLVZ6nKxBlwCjp345NeGY1b
 3GSoXRhrwigMgib3SIq6E7WIWfT0vBUri2jzZ3lVgm2hSstuaHuX6/2Vk9KJKjb/mwMK
 Ys3mKB72HUF0fZC6HCV+K9p0pOeihXuzH/kvKizYfBbuJKp8QiPJhDrynTDWDzDSpOUz
 4VWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762805515; x=1763410315;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=TPlhNJYJ2bp34zf3iWtlyd49cNmFUmc7Y7jbQrgWnC0=;
 b=xGuyfDDyEZwKlo1/unWFbBbBlUxEmIksSYkvmtSznku/jZMHKujNUTu2PonxG2pKh0
 LBYcCSwYhB2LPUZLYpDk8Fcm2vtnzdQGxt/K05NDoHRyBawd/103Jbh/gHDT4ZrIutGT
 bYjWdasAB2eZLJ9U6rz8i/GObck+U0lTGRgddN+KesU83pehW5OJT6hBSTKjt7lPcj+L
 U9dbjMkPVJqY0w6HQoBZgBM0NnoG7wIJlY1nZD4KG3FdnRcfHSPqSP26FHZEvz2Dre/K
 rPC2mlqtyD1OGbJSCQaQ0IbVfjZjCzZb+nARzc6WQ0eSAk1RxxP5BJtJjkkQ4iRutHp2
 CTqw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVFbOoFVy9gdnhzrWf+liS3nDDbIzpKk+v89qgim3lUq1q2z/6aAMgytteKjM/j7xtnuHSFwJk=@lists.denx.de
X-Gm-Message-State: AOJu0Yy8Ze2GQyu3ErD0GWWpkmyy/6Onm8MynVfH13bVi/bzK+m/+KkE
 3LPZ+9drRpcvzvTJpuT+HAPO8B96CdYLGbtkvt9wgGetWmq49GtlcPjhCSJ07CGYGg8=
X-Gm-Gg: ASbGncuKHSwpq/RgKgCYSY4JtZS+by5dx1HWoYa17CvDFi+uYW1kGGc4C7Ui01JUaQ+
 c3omCBJhuDf0/xFuuCxAxVKLFLAw74gSGKP5KX5WN2j5c9wHLBz7iGjgxeyB3z178SLSMvNtFXU
 5tAUW3MHCnWR1nboRQuSupIqHiiP+MrbGxyBBwSsL/7FhM2hZtBn35W1wHAQi3H/6LfGCcVhNdA
 uHLQxVtCKOQdit1Pc+UmYd94/R0EHTBk1ndBdcBSf9/czdbWpfFX4HxZHxWS+i0F9VSrWSgBRMP
 uz/Y646YnJwKMmz1SnBmEozhbXvsZQY1NJniyrWFWciZDHKIttVPo0Adbwv3WI8Wd/kteIJbJfi
 pPr3u5JD8gsCNzYsWCEyhAwXVisDdb22k5YQO1rqgutpnX8Vl1vbQhI9epYFkA8AYc18JZsQ=
X-Google-Smtp-Source: AGHT+IEZ43tSexj4VvJ/88fu/FXPQ7dDd+sxqJvPPb8vD3/AcV6c8sD2XiXHWtj2p+rTgih9NX10QA==
X-Received: by 2002:a17:906:ef04:b0:b70:ac7a:2a8b with SMTP id
 a640c23a62f3a-b72e040f8b2mr936558966b.19.1762805514972; 
 Mon, 10 Nov 2025 12:11:54 -0800 (PST)
Received: from localhost ([2001:4090:a247:830a:fe22:a8:f29a:a5c3])
 by smtp.gmail.com with UTF8SMTPSA id
 a640c23a62f3a-b72bfa0f37csm1163752266b.64.2025.11.10.12.11.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Nov 2025 12:11:54 -0800 (PST)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Date: Mon, 10 Nov 2025 21:10:37 +0100
Subject: [PATCH v5 13/13] configs: am62p_evm_r5_defconfig: Enable IODDR
 resume support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251110-topic-am62-ioddr-v2025-04-rc1-v5-13-980ee0036c26@baylibre.com>
References: <20251110-topic-am62-ioddr-v2025-04-rc1-v5-0-980ee0036c26@baylibre.com>
In-Reply-To: <20251110-topic-am62-ioddr-v2025-04-rc1-v5-0-980ee0036c26@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=675; i=msp@baylibre.com;
 h=from:subject:message-id; bh=xE312MwWJYB3Y+TfxMO9glPGHryfuKbJAtBHWFon+ww=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhkwhty9ab1ao5J5m/5mWv13PvbXp3j2VzXtnKLi3K0e8+
 588P/NcRykLgxgXg6yYIktnYmjaf/mdx5IXLdsMM4eVCWQIAxenAExElpvhN3uB7cUFPJNeWs7e
 7dP+afH1I8YHps4q5BV4+rOjvejnkzSGv8KttpuM6soUV5/dcJlZ9/vuWEvPZqPvJzIfbyn/cf9
 qBBMA
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-Mailman-Approved-At: Mon, 10 Nov 2025 21:13:08 +0100
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

Enable K3_IODDR to enable support to resume from DDR after exiting
IO+DDR.

Tested-by: Anshul Dalal <anshuld@ti.com>
Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
---
 configs/am62px_evm_r5_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/am62px_evm_r5_defconfig b/configs/am62px_evm_r5_defconfig
index c9592d7b6c4cc037a886fe81385791269a825aa3..39e8093597352e6ed3fb67ac59e0494239a51352 100644
--- a/configs/am62px_evm_r5_defconfig
+++ b/configs/am62px_evm_r5_defconfig
@@ -123,3 +123,4 @@ CONFIG_SPL_TIMER=y
 CONFIG_OMAP_TIMER=y
 CONFIG_LIB_RATIONAL=y
 CONFIG_SPL_LIB_RATIONAL=y
+CONFIG_K3_IODDR=y

-- 
2.51.0


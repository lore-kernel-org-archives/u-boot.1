Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5431CCFA13
	for <u-boot@archiver.kernel.org>; Mon, 10 Nov 2025 20:14:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5BBCD83F58;
	Mon, 10 Nov 2025 21:13:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="U5ecwvFF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6749483A98; Mon, 10 Nov 2025 21:11:56 +0100 (CET)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7AA2C83AA9
 for <u-boot@lists.denx.de>; Mon, 10 Nov 2025 21:11:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-640b4a52950so5225834a12.1
 for <u-boot@lists.denx.de>; Mon, 10 Nov 2025 12:11:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1762805514; x=1763410314;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=V8NgsF056yXiTjf5DcFupAioiQt6PkMA8vi3f+0C/ks=;
 b=U5ecwvFFx5oW9KjtLrDijBarvT6tT+JzFykzUn/RVd6g1X03w2ONsoyiwSDNMqReKQ
 Am2uen6AEK1hl/t69YT7o0V32PmFSOPbEKaM8lAOjPplgP4k441t8M27+1wkJTZPTqI2
 VIzzvqsaCWSoVH9R+G2XlDmRishOeXJVvcA4iaR6vQ18RhBmhSxgLTMCZ+0oJ3WdNd4h
 Sgf61EcJNoJdedfoQERfibl7nGiXDaaWUDkCBzobOi6jT+FnEkWZJ54ewS1lkKcAS+op
 EAR4Z3WYYhgVoTNI01VCIBfeHXEIFW5H3T8gMSHLJYMUkLLyZ6pT+kF9qcVldB/83RxS
 /naQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762805514; x=1763410314;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=V8NgsF056yXiTjf5DcFupAioiQt6PkMA8vi3f+0C/ks=;
 b=kd8SWnupUVfQrefJ8RSm+7C/v8qNE7FnRTc74fQt0D8wt8RzTrcIxuYXmomLa4jRZc
 MxchsqGaNRcsX9ZKOlBIhhQpi5DlPahYT+8RjlVfVlbCHOsIEJDNKOhuGDRwbK9Zz1o8
 ibZlptfrOnKm/1LUWm7Z6ACads4s039kNFO5Oqujj6+vN5yTQ3IPbBj/1XQoKsKxcDTL
 OtgCUjoaUNV7yJr6Ogn7Vj5EunZMqokHpmNgIl353lh7eb7Bw2W/1Xh/5E4fYRgUt5kg
 JGP4dxgpggMOaWrjQTkafo3EYD9G9P1xx4eyJgMWZ4XjMSFcWX07jGUH26wOxkPmPcJD
 6k4g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUTp7zfy9RW5qD3CIKTN8BIvG9ScnNwlHmX9BgE0ttXUqSselXBv2zlzzcklcz1IoufgrvOT1Q=@lists.denx.de
X-Gm-Message-State: AOJu0YzKenQW+CRYDuGkSnARpluf81XxPSqlrT2YCcmeK4mL1C9UQ25J
 MeWOnX/Czksg/awAP4fzBziaLRz6rRJS+9tQ503f7r4citFEekA2VsWVtbw38rSRvZw=
X-Gm-Gg: ASbGncsXpe8aze6J0rj1kmr5KpHwFn2vGJOV7DS4rxc88Mk5XpxZENFc861qRVPEYG8
 P7xbt1JYJhF08xBhs4gq0eVRUgxhEpAJwlt+ThaKI6vmsIB1M4NZ9aAgwIXN9ul1duJb2vmudiA
 4glEdUEvK5ECKhgbaMSonrpq+S1FFYyybiVjuyy3JCJdVedqnI+EFc6p25HlcvbHmvRSt7ISxIH
 t/x34XtpLIS0W3kXDic7BWrd/HsJNot2NDp/AMFoz90TFJivXQEYgcEccw/IJa+90s/uVChCkS/
 dETWqfeRvpn8WqWQqYkW/2EVciJe769jWP0Wx0jsKw5zIwZelMqCee9HigCW8gZUbZMlUAwR4WQ
 vghRLzQd3LL1dp8Gj3eFCh7Ark8q04wAPwd0x5FyArMtT8ILSVAwMRHsQ9cVh4y3iRioirPFX88
 d9GIiJ8g==
X-Google-Smtp-Source: AGHT+IEfhrlhkE5K40eQfhTn6csQ4z+Hwx2Q6iJkUvMj2Wg127gIlDIwkaODRriMxIOPXwiNoYxRpw==
X-Received: by 2002:a17:906:6a09:b0:b3d:200a:bd6e with SMTP id
 a640c23a62f3a-b72e0492f89mr857712766b.47.1762805513874; 
 Mon, 10 Nov 2025 12:11:53 -0800 (PST)
Received: from localhost ([2001:4090:a247:830a:fe22:a8:f29a:a5c3])
 by smtp.gmail.com with UTF8SMTPSA id
 a640c23a62f3a-b72bf97d456sm1199360066b.39.2025.11.10.12.11.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Nov 2025 12:11:53 -0800 (PST)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Date: Mon, 10 Nov 2025 21:10:36 +0100
Subject: [PATCH v5 12/13] configs: am62ax_evm_r5: Enable IODDR resume support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251110-topic-am62-ioddr-v2025-04-rc1-v5-12-980ee0036c26@baylibre.com>
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
 h=from:subject:message-id; bh=AGImpFbVBJuRtcp9Ub7WW+ozUrt8YcqQdnWEa9NLxFQ=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhkwht/cSUWn5r/MfLbO/qiqQUWD/4ITX0op9G38uTU9xN
 jdoOXKxo5SFQYyLQVZMkaUzMTTtv/zOY8mLlm2GmcPKBDKEgYtTACayw5+RYb6HuJ9Rm+07S5H2
 DIPXD4rcDkmoCu5YaPtYyVQ1yn4ZDyPDK1ZejbSwieaZvEJLTXbYHK2fJPQtu4qfb9ap24uYjr1
 jAwA=
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
 configs/am62ax_evm_r5_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/am62ax_evm_r5_defconfig b/configs/am62ax_evm_r5_defconfig
index 64886986c4264a5d9272228e468f7057c195593a..3a9f382193532dc3b712a1bd3fa16a9c0de3fedb 100644
--- a/configs/am62ax_evm_r5_defconfig
+++ b/configs/am62ax_evm_r5_defconfig
@@ -106,3 +106,4 @@ CONFIG_SPL_TIMER=y
 CONFIG_OMAP_TIMER=y
 CONFIG_LIB_RATIONAL=y
 CONFIG_SPL_LIB_RATIONAL=y
+CONFIG_K3_IODDR=y

-- 
2.51.0


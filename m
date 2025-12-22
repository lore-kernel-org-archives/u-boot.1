Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFF6EE69160
	for <u-boot@archiver.kernel.org>; Mon, 22 Dec 2025 20:06:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 94CD08412A;
	Mon, 22 Dec 2025 21:04:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="QJqbiyGL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4941783EC0; Mon, 22 Dec 2025 21:03:06 +0100 (CET)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 478ED83B99
 for <u-boot@lists.denx.de>; Mon, 22 Dec 2025 21:03:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-wm1-x343.google.com with SMTP id
 5b1f17b1804b1-4779ce2a624so32360655e9.2
 for <u-boot@lists.denx.de>; Mon, 22 Dec 2025 12:03:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1766433784; x=1767038584;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=AwLU3YUkEos43VqpyHz3sA1hNnWziyeOM5Ldk8d7XBs=;
 b=QJqbiyGLr3BqdlsNrVtSEuIk52tweTCRs1E7zf2xfml3UKPrtTQ/EBEcKKQpyfDOYE
 qyoIW78lxxMM7Wcq8jkX2mL5JGkwnMSMSHqFmy9n5g6VA28WHazTshXmDwEpxQvYzOIy
 Eq4LQn+V3jZJu4FtA8DrA6Nyhq9Sc2YJRhK+IiU0uLCgKnw/kCCC8ddIlHVDBdMVGJYj
 OciYsTB1bQliDruRIM8pWAL8PAIFhubUO7XQtEsCjDV8L1nv8j+ifr3zJci7wdEtIJam
 5q+1xQ2b+q61dvg0SMXi3zUvb7BwxEUUH3wc8QZAPZ+M8EJPhsBtos5/8EI0F2MHMhjL
 B3+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766433784; x=1767038584;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=AwLU3YUkEos43VqpyHz3sA1hNnWziyeOM5Ldk8d7XBs=;
 b=bnHVvsgs7EZpQLhr4HoXcC/f0gVnpjr9M1TF5V2zh5guai8o96Q0OSYg4rCE+r+WCc
 q7Ak4fcDFcGmdmtgWsOWUeU1SuvjTpTUud0tsYvbwA42iuiAOBaJw5sHupPdt2aEHq6/
 Seaelo9nOADqGGsahUrwy7k+Hokr7oU+nMH0n5stdChxFiQ7pzxKzsTo0JhRKix+1hnV
 gL8bK0KrGfUFcNtm7yNi9m3t3dr6q8TPpJVXoDhQ2/kZ6zvucCa4VEkYUcHpwuvEtZPO
 y75pbaENHmV1/rdyyvXVE74fZirTUjN4lqz1VVnmUh7Ov9bVZSQvQpdSLu1ruYMORRTt
 WNyA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW9SWdYNJpfwiJB1rDXtyV2ts6tr/FanjVv2GxYnc9JT7G+USmO8QWM6K6ixYBWqPIzhiIu7vA=@lists.denx.de
X-Gm-Message-State: AOJu0YwNEnH9IYMG5KFBmcrZnwm44awqlfMsRXuxPVd9TnQT6GGjv66+
 xUljuXR+6MDE7SPj+iiOrdsj1oOiBMPV0DwwJfvYvSmErUsqP5YwuCKDkinnE2lKVYA=
X-Gm-Gg: AY/fxX5Q2Aq30enYCd18QSVCd8rSiVpWzuWM3hF84J2v06V+718EGIUYS8RGtPnKytW
 u0fLARD/Xv4Apaht5VkQs4L2nizbZKexxLJGlGsdEXguCSi29DphdNwTvq0LmDmrOEvmQqGndHC
 cTWV5kdsNhNvk+NFNomFf/BswPRWskpWTk7nTrGRUIDF9bb4yfdoyXibARSB555ww7L2vbMIfsQ
 yWc+eXoVztj2BTspg2F9JTgYSt49kI3oyI9fp8DbpjgbglsaQTnkn3XQf3lCofR/j2vM4XCglaO
 3/zUxq8e05IQfK8cYDX7EKaFLwCZAmt+QreXEtLRlLhwn9d0V7bxyc6p950hZQM27ESYExseW+r
 K3zcvCCr43rIQCJyUZKV66zFRmusMq3+63FJEDk5ruWddGc0hCn9j8dgkbeO3W8CSulLaKSlpcS
 opUoYA6M3C
X-Google-Smtp-Source: AGHT+IEX52Wj9c9t8S7MhoTMnJR8/NdTjcpP0JrJNq75WVH4ioftTkaceF199Z2gZEeMaRkRklf2uw==
X-Received: by 2002:a05:6000:186a:b0:430:f301:3e6c with SMTP id
 ffacd0b85a97d-4324e4fdcd8mr12122828f8f.34.1766433783615; 
 Mon, 22 Dec 2025 12:03:03 -0800 (PST)
Received: from localhost ([2001:4091:a246:82fd:4350:c3d9:84a3:70dd])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324ea830fesm23992967f8f.20.2025.12.22.12.03.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Dec 2025 12:03:03 -0800 (PST)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Date: Mon, 22 Dec 2025 21:01:33 +0100
Subject: [PATCH v8 12/13] configs: am62ax_evm_r5: Enable IODDR resume support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251222-topic-am62-ioddr-v2025-04-rc1-v8-12-e70fed16b166@baylibre.com>
References: <20251222-topic-am62-ioddr-v2025-04-rc1-v8-0-e70fed16b166@baylibre.com>
In-Reply-To: <20251222-topic-am62-ioddr-v2025-04-rc1-v8-0-e70fed16b166@baylibre.com>
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
 Prasanth Babu Mantena <p-mantena@ti.com>, Beleswar Padhi <b-padhi@ti.com>, 
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=723; i=msp@baylibre.com;
 h=from:subject:message-id; bh=JkFmmLrvgUAC6JGhHpGA9eAAYn1Yn+JaFiZUvH0W7C0=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhkzPxdeqmGTPVO+t3vLF6txlkQfL3VQ2b2Wd93hSbFP8N
 6+NndJJHaUsDGJcDLJiiiydiaFp/+V3HktetGwzzBxWJpAhDFycAjCR6OmMDHs2JFzd4uDDsPKd
 rmzRQkdpVVfv+V+DVMM0p4Se4V9fpsPwPzl52RWpi2enNpbN3s9y4meYv2D19XdP+luuXK0LuK3
 3lRUA
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-Mailman-Approved-At: Mon, 22 Dec 2025 21:04:36 +0100
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

Reviewed-by: Kendall Willis <k-willis@ti.com>
Reviewed-by: Udit Kumar <u-kumar1@ti.com>
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


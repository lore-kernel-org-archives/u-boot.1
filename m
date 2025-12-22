Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5653DE69166
	for <u-boot@archiver.kernel.org>; Mon, 22 Dec 2025 20:06:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2100A84144;
	Mon, 22 Dec 2025 21:04:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="SQfq3Jyk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3F42A83EE4; Mon, 22 Dec 2025 21:03:07 +0100 (CET)
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4AA2B83B95
 for <u-boot@lists.denx.de>; Mon, 22 Dec 2025 21:03:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-wm1-x344.google.com with SMTP id
 5b1f17b1804b1-47789cd2083so22983105e9.2
 for <u-boot@lists.denx.de>; Mon, 22 Dec 2025 12:03:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1766433785; x=1767038585;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=yCGdigPB5vuELbG1a6JnnhxhYWjgn3jQ96olBFom4R0=;
 b=SQfq3JykhBd9XnU+NBZx8F5tZ5CBP+z9B2ZCfya813RvoEOOvkgs1PKgYknzpmaKv6
 5GOTjm5RXGS2XNvdKOW9YScn1tZVNNIor+Ob3sTH8hRAz4SS4LXCgLxksv6tsa7x0nAl
 1vAxn07Kks5oGzjReqJXEaN3ORDJPat9Dvms8oHEgN78cAdQe+UjDs4ohAWsUPrlRdtQ
 cltL5t/gc1cbmCZyXaRT7emFcZwZkfM+86MgSocgq0G+qB/jfcNHW0IlrdBVLO6shvDy
 jaI9pKTqV0qLuLUiNGBB4/IYgij8Myd2QEVTUPw+NFxy+JbrH7CSEVVgZEjd2eqkTPUn
 6Nww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766433785; x=1767038585;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=yCGdigPB5vuELbG1a6JnnhxhYWjgn3jQ96olBFom4R0=;
 b=NNuVc6AWCAfsaB74JMtdn0koiu1O/k5PER4inPrSCUR4GAXvQnDc2TlFJsjfb0GD03
 bYs5XEi2NuOnd6nqJUpL9nqia6V6biLFY+SyjDofKqdzj/naQeNmtPfPemBOj5HZyLtw
 7bFs3NahzzNEeBMmRafdl3OtrNf8Z+o6O8nJc0LF1+HrTM+tQIEroPxmHADkzQgVpwvg
 tLzQuY6duagR3+VsIjo0ukh0egDb//TE7X2A2/Qky2Y1v3nv+ia2r1taalTiQT2XnhAZ
 Gv47FjqzcFF5c4SPmMRr3RyX8MRMK24emyRi4JN/sH9XFvb+qbpAux+kjiw2lyFStbyc
 5SQw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXaIvGcYz70flUwg9kSMjCqM9lv+tu/aD5b5GxuKaf2XEIjGz17ZotLqkZ0z9rk6b+uBrQpaUI=@lists.denx.de
X-Gm-Message-State: AOJu0Yxh9oN8mbZmb3i47W/nvGGy67AmqenYbKaDmMOoa94NUh5cj0vj
 hfDty/IGA01pOqqhgDrhY/Pgl9fni3aSzkD32BEjnyUIV1aCAWt+gZpHWlp6tgFScz8=
X-Gm-Gg: AY/fxX7dwmGj7Q2Zit9e5BxjRpXlvL2v2N+o+osJWiVtp0x/it5n5eNaF3Jk61dB/7w
 HQ3areQ/m8qevIoTVo8GcEHQHIFceK3h7lgFRMaQ+254gpuVx6mTHTs1hcA5d3w/UoTUMTOdqnb
 Mxn2Jcl8jG9JY9ZTGNXYnwy5R6jw+j4vpkWbD82Z5PFGYDfhJxlhJvDi/Cx4doi0FzJSrVrtfTE
 CKlmdt2Azcxrvq3+eWmzJgaLzYyUQLFAd7bBc7SWzQ+v5ag7ORf5YThOLLtYD7jO35SbVCR/ccr
 Um7Z1yr60ZoUT1JscHU+YVqZ/6HYU9GuKJX1vXLbIkIk1qHT4tGGugu8MKGuwABnLU3lpUJDsik
 Wf7YBy10Ru+Lq+KD0FdYdMij2uCJFQknV4Qln/GIJ56JDFB6ZSa1KEElxRVYa5hWo90sKWdgvEm
 LTY90se0sga+TPAOvyLVA=
X-Google-Smtp-Source: AGHT+IGQ9ExHk9cQx0SSs9mSOP6w/H5Dcr5nT8wNASSQO3Tp6XiosezNCmtwNkbJw855K2djPHlZ4Q==
X-Received: by 2002:a05:600c:4706:b0:477:9b35:3e49 with SMTP id
 5b1f17b1804b1-47d195495e1mr120884145e9.3.1766433784734; 
 Mon, 22 Dec 2025 12:03:04 -0800 (PST)
Received: from localhost ([2001:4091:a246:82fd:4350:c3d9:84a3:70dd])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d193d4e91sm203104755e9.13.2025.12.22.12.03.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Dec 2025 12:03:04 -0800 (PST)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Date: Mon, 22 Dec 2025 21:01:34 +0100
Subject: [PATCH v8 13/13] configs: am62p_evm_r5_defconfig: Enable IODDR
 resume support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251222-topic-am62-ioddr-v2025-04-rc1-v8-13-e70fed16b166@baylibre.com>
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
 h=from:subject:message-id; bh=q6M81uy73R66xDd9tX31KJ47wNghiY/g1bKkQepNwcY=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhkzPxbfvhD45nbIv8uuk2UIrsyzqXWXCzZasOizPV/c75
 80quaaSjlIWBjEuBlkxRZbOxNC0//I7jyUvWrYZZg4rE8gQBi5OAZhIgRzD//j5spxHsqbe9L5Q
 +Y7rcqdgNee3D3GBAn3sXlMsdobZX2b476h5tXOjgXLzo99Zux4fM17pPrXG5ObWj7OW/L2nsd6
 whgMA
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


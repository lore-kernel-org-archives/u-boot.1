Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB114CCF9FC
	for <u-boot@archiver.kernel.org>; Thu, 30 Oct 2025 13:04:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F624839C6;
	Thu, 30 Oct 2025 14:00:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="zTUK1FEa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3FF8D800B1; Thu, 30 Oct 2025 11:01:49 +0100 (CET)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 581EF832AD
 for <u-boot@lists.denx.de>; Thu, 30 Oct 2025 11:01:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3ece0e4c5faso841361f8f.1
 for <u-boot@lists.denx.de>; Thu, 30 Oct 2025 03:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1761818507; x=1762423307;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=BJLqWRejbqGGWB2ClRyBmoFJla4Vp2XGf46a/xI7PrA=;
 b=zTUK1FEaw4IfWIai2CcPJ75EDPfsxxms57eZ1glBeopfwSugqWm9FPY7BKnxrQz1pm
 Ttu8Nmjqk8nSkuRJQc2XDCUKJreoF5sThzha3eMj27dw4OQFtsDx6Cj2JKuDE/PMefe0
 KzQReQiP0icRlnlOEtrMeayHTm4Mllru/jnwveDX6eeonjHsxXfhAIa7U3PPzDeIiZK+
 jV9NfXh5MwHyK4n1CQLjkrEw586LofCbXhEvHisZLtEWItbwc6n5+tBQrQJ8KRfTSIEq
 u5ti7HDcR45tMPUQjUvZetHRiXPOxtJD6/fMy32z1zCD5EqfC4QG9yYMKjcrUSlaYynP
 dqpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761818507; x=1762423307;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BJLqWRejbqGGWB2ClRyBmoFJla4Vp2XGf46a/xI7PrA=;
 b=I0FFOwR9Yp2zeaKpVt0qQj1hooR39O8oLlmfLBJO4oruunOC4xPnyA3GK3gMTpqxTv
 aclxvCGq9+VJpnTud6YkV24Y//rOwS/p1qVn0WZcTqjHx6LRABMjivhs5wkQ7+uGbHfq
 oyY/3AQ9ilUJq9L04mqUFTcbqRE35TB6UBc/JOnBGPi7De3tlmFEr1axMuim8VCixHUr
 9rSdB81SntTVTWSNnPsSeJ0D4ZcbdVM3hZFDpRJNISJhINl4JWSOOVqUWMNgvm+JnYjj
 23s7zzKl+nGzP2hIgieH+U29NL0sn2H10XmaPYbwlanse1/zQu9X0ZKXOi00v3Jho4uo
 IIRQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXTRktHMbNazf5sSmr2LC+/JChgBHTp+ZQFjClbtK44OlVjNwcCnt+9EIuPuW7iCIvgS9FfAJo=@lists.denx.de
X-Gm-Message-State: AOJu0Yww205E58L7R3HcSYf9bM9EdVz4swj+X3pSd4PJZNZjk4QTRIR7
 dyS0jEhmNcj4vEr5v0CMozsAWQ2As2NDT/oJId/rcm0H8AzH96TuHUFeRwq92Fwk/pk=
X-Gm-Gg: ASbGncvycarebcpVTN3sCyjzhnk5jN+sHW5Ai9ceg1uWdn9KXiGx8PsFJAaljd5Cp5m
 27D6Y6LfWcuSWKZangY3tm7IifkVjbaL2s47i9LyTQQCEHKk/8janOqcDYeAS09yizSP630Ly5p
 tBbbcoM8Mm27UiyhEL680hdh/JwBdRnwKpJ+lsvIbnEMo3ilzAdJ37MhEQ0Ckf7tHOEJN4tHEXy
 urkAW5dGfZy6iC1+gUWr4gF9FxbF1InzABMRZf9Hjesq/No1cXzwKRI53aS+a6TzFh1Pd3cbzu2
 PBIrNLuOlsE+qMSlmT0fikPy8dlKVJbIAbC8vkWgv3x5ggVTNVm2bgXSv5UW5WKqBwsxg8EO9Gk
 gJCn/jE4tyEUp1bUKCXYKJl9fDd7JfBwvWPjtGq60z3EepVyOhsGqbgRanBzSiJS98M+3v8kBvk
 /sO2NYs+iHh9KSi0AaY6E=
X-Google-Smtp-Source: AGHT+IHUbzZfI1l3fru0fJ6o6dgd6MR689pzm+I9nklaSTSIY1wkeRUfY9C370JY97TQgqeiLuHg4g==
X-Received: by 2002:a05:6000:4a1a:b0:429:b9bc:e825 with SMTP id
 ffacd0b85a97d-429b9bce91dmr1040858f8f.46.1761818506775; 
 Thu, 30 Oct 2025 03:01:46 -0700 (PDT)
Received: from localhost ([2001:4090:a245:8496:49da:2c07:5e9a:7fb9])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-429952da645sm29797819f8f.30.2025.10.30.03.01.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Oct 2025 03:01:46 -0700 (PDT)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Date: Thu, 30 Oct 2025 10:59:31 +0100
Subject: [PATCH v4 13/13] configs: am62p_evm_r5_defconfig: Enable IODDR
 resume support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251030-topic-am62-ioddr-v2025-04-rc1-v4-13-4cef18af0226@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=633; i=msp@baylibre.com;
 h=from:subject:message-id; bh=8q3WU1UttF57TPGTLBQNZggAFoDrgWAZidX35YOBHDI=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhkxm89ywX3vSor7oiVg8np+5m7eraWPm6iPeXNuEvnPZV
 nl8qwzpKGVhEONikBVTZOlMDE37L7/zWPKiZZth5rAygQxh4OIUgIloOTP8Zo9UOS7hn8bX5p7+
 TPncZpPdZlOOZTt0JEdd/HR56ye30wz/zB9/uTxF50xowM3Zx3+0lnmfny7jGbrrScmvA3Nsvju
 xcwMA
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

Enable K3_IODDR to enable support to resume from DDR after exiting
IO+DDR.

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


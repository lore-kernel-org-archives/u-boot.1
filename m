Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2605ECF2562
	for <u-boot@archiver.kernel.org>; Tue, 18 Nov 2025 23:21:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A11D583D07;
	Wed, 19 Nov 2025 00:21:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="hfzQzq/O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7B9A081D6A; Wed, 19 Nov 2025 00:21:24 +0100 (CET)
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com
 [IPv6:2607:f8b0:4864:20::c35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5FDD583B95
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 00:21:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-6574de1cda1so1423330eaf.3
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 15:21:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763508081; x=1764112881; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VNIWTyP6bIMXFk7RSaoUOMlHDvuGmkY4yIfZ0V6DGFw=;
 b=hfzQzq/OiYFN7RHLvjcwuX0vkg+VurBQFhklyh7HWp/LnIEBzIAvyBEYL/ljcgxuZP
 DVY9Yntfgvq/eSb0OkGjSkRNjDMw7sJVfa+Y5k19p3d3/XE3dFcdHKHMh4H/BmBvO4F+
 lJfyk2AV8/MVonqzCpHmMtVgw8kj2DMvq+sTOLoiG1/frzYKrj1S84LqpBralHo/Ie9O
 GwLlPildGX8hiyhjZUyoMAurNuSYXOwSRsPUP/Av/1QIQhvHxdeDHw1irwAdYYLWkIbS
 h8SE7AKRK8jKhaI8+PO3UrBC68jJ5I9pyk89484P15SHS2lqCLpJuVNDgzXKJvn+Cogg
 8qFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763508081; x=1764112881;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VNIWTyP6bIMXFk7RSaoUOMlHDvuGmkY4yIfZ0V6DGFw=;
 b=jmtRuTGTOw3G9foEVrBnHYugadMeZ0QRJeFmFKSeX2/IRtRmtwTS7oVo4yZKRRdExY
 PX7mPal4Hj/p2yv+Uce3a9MAtL5nhcQiutpVj26X599bLZ3tngKCsigj6U8a9wDiI4ku
 ZAdxZyfZOsXCimZQ3WTXx8XFpz4vvObhE6k1YuUeI0vTSY+N4Z2qlxy3J+ci9xiVBD9+
 vjzRbjLi35YUrArkH123zreAseMR+sEj/Zrcnjh3Omhb+vSxjHB0ClREgzvVTOhOKrnL
 3tylaTQ7E/ggKN1Xt61UwkkrDrrrZOjktto9YRjnzo9vbxZhpct0cEIWv4a3HC4kRrgp
 5KXA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQMUg2dYuPmCE7lxe6OszrSNsq3LKuQ3yC0vamAWbqvgqZAUqILLNpQkskCuvweAEt/FiQ80I=@lists.denx.de
X-Gm-Message-State: AOJu0YzYGxgHl281IWxMjBBi1YS9s8MK2a53zqriwCZXMokSzlsbf72r
 05eHFbGGj7iCtSmTa8RH3+bxZzji1jn+B2dxDD3cslII/fqRISdEhjYAUwOvKEb9b+c=
X-Gm-Gg: ASbGncscvvLJvNt9kxl+bfssS5CbfmA1MnbHGKIyYtJYbw+4Y+wW+VJvStMK/f0Lz/J
 8pkn5pQKWkZT6UArfwkI7ZXnQACGYjxxe9em3EKMmVQZqa5mON5AY5BiBofG3OtyUIG0AoXeHnk
 OYbobwHshza9BwsHuwLXhO1vxRABzJ7GOJNEUA0KflJD5HmhUOzkTn5znCH3073gIxaJNbxl8ER
 KD4e7nZipgUuGjPcqJqmRvqtWFDx8rfgZj/oGP8XWeS+9rmOqsFEcWNDffscTCUKvwYfNUEQY0H
 85ZmOIMzXukxwxfpN29MWyksdH9+GJVA0OFlqWYSVnH6f4V8raRFBdn5ZJCrXDXEG7OGaZiwTQf
 rDzfrRTJLHU2A2kvlynPobjZxfbGyOm70qUo+Di1QJCIFzxgQLyd+vl6CGMLDMZj1ndny2+R+sJ
 n2bZsKxCpj3Qa6xvn4AKvWIQMVdZ2k6tg=
X-Google-Smtp-Source: AGHT+IGv+u8nbUcHa0xcmB9Hxb4E1l1Uo9eVtkzk0z6OiL1lc6i6xnF8KUMnyMiRSikt1QNt/GQRfw==
X-Received: by 2002:a05:6870:214:b0:3ec:4956:23ae with SMTP id
 586e51a60fabf-3ec4956379fmr3255038fac.12.1763508081062; 
 Tue, 18 Nov 2025 15:21:21 -0800 (PST)
Received: from localhost ([2605:a601:81da:7100:264b:feff:fe59:d7f7])
 by smtp.gmail.com with UTF8SMTPSA id
 586e51a60fabf-3e8522ae6e2sm7413805fac.16.2025.11.18.15.21.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Nov 2025 15:21:20 -0800 (PST)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Tom Rini <trini@konsulko.com>,
	Minkyu Kang <mk7.kang@samsung.com>
Cc: Minkyu Kang <promsoft@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 u-boot@lists.denx.de
Subject: [PATCH v3 1/6] board: samsung: e850-96: Keep public functions together
Date: Tue, 18 Nov 2025 17:21:14 -0600
Message-ID: <20251118232119.17928-2-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251118232119.17928-1-semen.protsenko@linaro.org>
References: <20251118232119.17928-1-semen.protsenko@linaro.org>
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

Move DRAM init functions close to other public functions, to make things
visually distinct and improve the readability.

No functional change.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
Changes in v3:
  - (none)

Changes in v2:
  - (none)

 board/samsung/e850-96/e850-96.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/board/samsung/e850-96/e850-96.c b/board/samsung/e850-96/e850-96.c
index 3df241edde2a..34e01914032c 100644
--- a/board/samsung/e850-96/e850-96.c
+++ b/board/samsung/e850-96/e850-96.c
@@ -77,16 +77,6 @@ static struct acpm acpm = {
 	.ipc_ch		= EXYNOS850_IPC_AP_I3C,
 };
 
-int dram_init(void)
-{
-	return fdtdec_setup_mem_size_base();
-}
-
-int dram_init_banksize(void)
-{
-	return fdtdec_setup_memory_banksize();
-}
-
 /* Read the unique SoC ID from OTP registers */
 static u64 get_chip_id(void)
 {
@@ -166,6 +156,16 @@ void load_firmware(void)
 		printf("ERROR: LDFW loading failed (%d)\n", err);
 }
 
+int dram_init(void)
+{
+	return fdtdec_setup_mem_size_base();
+}
+
+int dram_init_banksize(void)
+{
+	return fdtdec_setup_memory_banksize();
+}
+
 int board_late_init(void)
 {
 	setup_serial();
-- 
2.47.3


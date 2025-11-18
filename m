Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33547CEDD86
	for <u-boot@archiver.kernel.org>; Tue, 18 Nov 2025 13:15:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D5A2C83D39;
	Tue, 18 Nov 2025 14:14:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="lfHLZ+cx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 25A9F83C96; Tue, 18 Nov 2025 11:42:17 +0100 (CET)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 33BEA83CB9
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 11:42:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-640b0639dabso9362922a12.3
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 02:42:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1763462535; x=1764067335;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=bd+prGUi9MraR6ExXKVGptwr2sTx//T5Yhktd0n47Eg=;
 b=lfHLZ+cx3HEWfDqm9h9nf8a4sCDtKdh4wr7Dt3ShTcPWfBCeUGg+yzQkB3SRGG1P0v
 akkOwHRmxzZW9Mq5lGAhRJJO7Z5zhMPZ5WsnzPtYroFwYLhbFBPcm0vlX/c8HxK9k+v0
 KMGqe+Z9aCMbldB31r2AIFF6IImjeHwE5wEoJ6fAr6Mkzgg6BG/6MyGeSSzey2ou07zW
 0aAUi2k2W6jjDk4otNSisbb1nLnhEofZaoUhYajorz0UYLHx2XqRrGXdyPOMwkMeJXav
 SlhSLnJQG5Iiwnlj/m9pjT9zU09RAu2HbOfk8Z1tntLdWZY1JHIlZaHSGaLh3V/Tm7CN
 i/cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763462535; x=1764067335;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=bd+prGUi9MraR6ExXKVGptwr2sTx//T5Yhktd0n47Eg=;
 b=HOmi7jY2n+YDtwvxSlau02j7hj/EghuPvqGXKzia8B1k6hnrsoBpMCoihiM+PsH1qW
 ouby0WpfKF7mQ+mMyNJDsE/+sarMZ7ZNesFC/qOaheUdB1+wAn0TuulQologJRWL4t+k
 JA7AOwUaKjuYvK7umaPDkzsixr2IWYrSgVEuE10VBPMJVhTslTZ3mpUAIvFyl5IKd88w
 dTuBSsf4WTWfNabrGDgZa/4Nt7xd9hcYNJqYSWWKyHNEiVuqaYpl/kCHBTrWynOej5+Q
 sYmAFUYV3V5ma7cx7EgyYAEup4kptOwNhe60jgjOBvDrfLhQ933DibJpc1hHpjoE34Em
 CSoQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVK0kGk42Zh1qtgmQUa3QNl2wZ3I5j2/8Rj0/U+rEoxU8SWe+nXSdoAwe9H9KFp/yj0Z1fs8zE=@lists.denx.de
X-Gm-Message-State: AOJu0Yz9KqKigsKhtEOG0qV8aI9qTH3pMHzV4es3EFB+Ecs9CZS4sEDv
 TsXKx2AlYG4L5ykcYZ0yWxwCFlrtypXqOULHWIGX6tb6GCYrnyedUG4KxUAg2p0LIZg=
X-Gm-Gg: ASbGncuXH1o2Q/ZI7lF++cUNdopa2HLy9m7bFKEh2K01ObEg3fDCZQ9F+DGPJN5XzOj
 02yXYa5L59hcD2pulb96yF1sKQ5N+8MYrNminYBoeAVrGFfO8qc4Exc6mcyCHQOqK3tPhFqAicC
 Rty1deixiX2J7v6dUybfsV7gVqYRkXuAi7GdF+LGWgDv/pR7RMJHU1fsy3XoYpA0qJBsRyYcDvS
 mMGl80k9RiVl7ENWe+skwiZ8ErNlXR8RjXKpRcpkIl316u9rhv+uAMhVTxB8XZdCP3cmPwctL0K
 1NeVWQ0FxMeL+fEktxtdI/LbdHDrwq+VGNxoPnYr872EfcA50Pr1CYYy/empZS3bQIznzUiU1ym
 y5M/32ngOk37X1zeMj2y796uePOMU1ft+TbOMg35QhwQPLUePsIpV2BGlYTpn54bCr5xQp6Yd
X-Google-Smtp-Source: AGHT+IGQoI6NVyi+vr+4tMml/MNLojn1Zv8xzicYI0FusTzeU6hzWwhcf0ekQCeH0MOj4nKMmU8xwg==
X-Received: by 2002:a17:907:d92:b0:b74:9834:1f07 with SMTP id
 a640c23a62f3a-b749834266dmr420847266b.5.1763462534630; 
 Tue, 18 Nov 2025 02:42:14 -0800 (PST)
Received: from localhost ([2001:4090:a247:809c:875a:7c11:12fc:ed9])
 by smtp.gmail.com with UTF8SMTPSA id
 a640c23a62f3a-b734fed80f0sm1322047766b.66.2025.11.18.02.42.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Nov 2025 02:42:13 -0800 (PST)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Date: Tue, 18 Nov 2025 11:40:21 +0100
Subject: [PATCH 01/15] board: ti: am335x: Fix DM_TPS65910 condition
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251118-topic-am33-evm-oftree-v2026-01-v1-1-91ce13c661e2@baylibre.com>
References: <20251118-topic-am33-evm-oftree-v2026-01-v1-0-91ce13c661e2@baylibre.com>
In-Reply-To: <20251118-topic-am33-evm-oftree-v2026-01-v1-0-91ce13c661e2@baylibre.com>
To: Maarten Brock <Maarten.Brock@sttls.nl>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Kory Maincent <kory.maincent@bootlin.com>, 
 Rasmus Villemoes <ravi@prevas.dk>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Tien Fong Chee <tien.fong.chee@altera.com>, 
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Tingting Meng <tingting.meng@altera.com>, Peng Fan <peng.fan@nxp.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 =?utf-8?q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>, 
 Liya Huang <1425075683@qq.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Romain Gantois <romain.gantois@bootlin.com>, Simon Glass <sjg@chromium.org>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, Marek Vasut <marex@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Sukrut Bellary <sbellary@baylibre.com>, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=840; i=msp@baylibre.com;
 h=from:subject:message-id; bh=4ORskK5QH3mvXGus5wFM5pJqmC9d5EzcPDRfV0XET+A=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhkwZX9N/i07a9pe6aNexyhTGOmpZOs+sOS7y0bbvVfSFb
 S6XvDZ2lLIwiHExyIopsnQmhqb9l995LHnRss0wc1iZQIYwcHEKwERcljP8905Wusx7V/U3e72l
 wbofL1zfVZ2fwZNYclk4ptNV673DG4a/wvcVrC6E57zR3XCod+2Dgr+z1jMWduh3eoWZXP3IoVb
 NBAA=
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-Mailman-Approved-At: Tue, 18 Nov 2025 14:14:53 +0100
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

scale_vcores_generic() calls functions implemented in tps65910.c, not
tps65910_dm.c. Change guard from CONFIG_DM_PMIC_TPS65910 to
CONFIG_SPL_POWER_TPS65910.

Fixes: 0b9ff0851592 ("board: ti: am335x: Do not call disabled PMIC functions")
Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
---
 board/ti/am335x/board.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/board/ti/am335x/board.c b/board/ti/am335x/board.c
index 712818ec23562fad85febf6616aea3cea1a3a9ea..90e37a8d91330365bb5f27c371be7b9749de9fde 100644
--- a/board/ti/am335x/board.c
+++ b/board/ti/am335x/board.c
@@ -429,7 +429,7 @@ void scale_vcores_generic(int freq)
 {
 	int sil_rev, mpu_vdd;
 
-	if (!IS_ENABLED(CONFIG_DM_PMIC_TPS65910))
+	if (!IS_ENABLED(CONFIG_SPL_POWER_TPS65910))
 		return;
 
 	/*

-- 
2.51.0


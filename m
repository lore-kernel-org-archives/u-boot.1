Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C72D3C3DA5D
	for <u-boot@archiver.kernel.org>; Thu, 25 Jul 2024 20:45:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E9BF883A4;
	Thu, 25 Jul 2024 22:45:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ZZtJxiKU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D3BF88385; Thu, 25 Jul 2024 22:45:26 +0200 (CEST)
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com
 [IPv6:2001:4860:4864:20::32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7171988363
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 22:45:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-2610623f445so466467fac.1
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 13:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721940322; x=1722545122; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zje1NFV9nziFyD0oks5YEJm/m5MnJAqw0VsMOyG/zQQ=;
 b=ZZtJxiKUzSdfGOh+JnszPaLw6yLn1YrNABGpbzgGgH+/rOUQnv/wbgsbY0Qof55sOo
 A12Mcw4bFkkofiOT2oAMaLhNh/0roDtiWwMG1izQvqhTxRvGBhEQf61gUhSyvESdyYJw
 59nS+f+COmGQjQck6pglpBwh5xDyg6VUZ+WfRjYufLrqMheDB4CGnScVJ0JRU8rwne/3
 YqxOBbLWspEvwmXUderzGnaOAB/ZdCHIvPRzJy5FFW1+sGhJdhjapuv2S7Z4vzcu9YIs
 2xOHTXW+FLZK+Ji6Nz2+TCLIU4cmULb15jhmPYuXzB6iW3sxyRkqlJDeAFaBJqfCi+OK
 cXoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721940322; x=1722545122;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zje1NFV9nziFyD0oks5YEJm/m5MnJAqw0VsMOyG/zQQ=;
 b=FU8tgmaraAi3gibIgQSbe7fT0VE2k2ilFSHAgZ7PvctvCCU32rCELOXi+8mEdXJsTZ
 PAYwAh+P5uFY0cV4ZdAbYw2/sNFaCQ6Iylq1STm0s7FqeDbDEPq1FASJgh+eEvrWTsM1
 /toLVGhaii+Y5suhz05jSIP0dOgEGmPPSmAJrAw34KAFLqgzQVkNHywbjoM3tNtbtLfn
 7l5l8JIAEFWWIdRIdo2aFp2RCl5plQ4gUQiSgUWvvH0m3fs4yC+ATdB4RPZJGB/0dARV
 eI2Mi1dP5Hx9MLktgo2z8gkqwYnf025skVT34HRDke7Vxm26S2mTLIcBgVmlLdhngV1u
 UASA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXOeomP9bvJU/WbUICc03Y4QHkGYvhIHg+02itqSitLkGhtC1YkcKcNQLbqg295bP2EZxfQHwcaM21SRA2SiU6V4Kogsw==
X-Gm-Message-State: AOJu0YzKxIp1l5p9dwzGYfe3ag1gjHBWodWsY7df/s9tp7TukJyZeofj
 06vdeLyMmUC1SEBDdYqbWWqhcfzMM3t9MRcdanDlRfRP8VrvAECiXzp1xrFEZrs=
X-Google-Smtp-Source: AGHT+IFa7OsOGjUXM/at64+pwx7ERbd06MXhAJHtdU5dbWRtHmxh2ow8CRc6VA5FiCWWhCiYuCXl8A==
X-Received: by 2002:a05:6871:813:b0:260:eb3a:1bc with SMTP id
 586e51a60fabf-266ede1179amr4183243fac.41.1721940322088; 
 Thu, 25 Jul 2024 13:45:22 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2653e7c8aa6sm417228fac.32.2024.07.25.13.45.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 13:45:21 -0700 (PDT)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Minkyu Kang <mk7.kang@samsung.com>, Minkyu Kang <promsoft@gmail.com>,
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Simon Glass <sjg@chromium.org>, Quentin Schulz <quentin.schulz@cherry.de>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Peter Robinson <pbrobinson@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Yang Xiwen <forbidden405@outlook.com>,
 Ferass El Hafidi <vitali64pmemail@protonmail.com>,
 Sean Anderson <seanga2@gmail.com>, u-boot@lists.denx.de,
 uboot-snps-arc@synopsys.com
Subject: [PATCH v4 01/38] mmc: dw_mmc: Remove unused version field from struct
 dwmci_host
Date: Thu, 25 Jul 2024 15:44:43 -0500
Message-Id: <20240725204520.18134-2-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240725204520.18134-1-semen.protsenko@linaro.org>
References: <20240725204520.18134-1-semen.protsenko@linaro.org>
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

Nobody seems to use it, so just remove it.

No functional change.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
---
Changes in v4:
  - (none)

Changes in v3:
  - (none)

Changes in v2:
  - Added R-b tag from Quentin

 include/dwmmc.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/dwmmc.h b/include/dwmmc.h
index 136a95b8cdb6..39024fb38aaa 100644
--- a/include/dwmmc.h
+++ b/include/dwmmc.h
@@ -163,7 +163,6 @@ struct dwmci_host {
 	void *ioaddr;
 	unsigned int quirks;
 	unsigned int caps;
-	unsigned int version;
 	unsigned int clock;
 	unsigned int bus_hz;
 	unsigned int div;
-- 
2.39.2


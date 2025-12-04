Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 821D8D216B2
	for <u-boot@archiver.kernel.org>; Thu,  4 Dec 2025 16:42:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB6C584135;
	Thu,  4 Dec 2025 17:41:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ULoGURDu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB37D84171; Thu,  4 Dec 2025 17:41:57 +0100 (CET)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3770C840FB
 for <u-boot@lists.denx.de>; Thu,  4 Dec 2025 17:41:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=max.oss.09@gmail.com
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-6418738efa0so2036307a12.1
 for <u-boot@lists.denx.de>; Thu, 04 Dec 2025 08:41:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764866514; x=1765471314; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k/2lZ4CB80V1ciuXV8AAw2YzEObj7eCobfCKpT32SiM=;
 b=ULoGURDu6huMNYKUxP/Lh/CslCf4NoQlYf+0foT0RQZBdphu9FZcVmPB2HD6au8jX6
 fuaVfXJdIL2tUI4lqh3uqWwSndWOUoEgrZYQ5eOjnThDpW9kUaBsTcei9x4ZarbExVnn
 N69MN8IY421tTyKL4IIPXijdwHk6u/MkVVFOH5yPUvyEG9IFZDwlnp5m9sYd7/S9zoSy
 pcOZeulmBLuQpBrvL8UxypkyWRj4a52CRBKPMewc9hKvZCzoBg8mw+oNQ3SQ/Dj9p43q
 hdd4mQNjSvh5shH7Ns1sgQpBIETiTxBAO3kuitShXUIsbGHz79h5bBqEZYD2TAFWOz+U
 Svyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764866514; x=1765471314;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=k/2lZ4CB80V1ciuXV8AAw2YzEObj7eCobfCKpT32SiM=;
 b=OE6hw7sjPcLjjf8SFaOINAwQzc10LBvckQ4wRkuinso0LbhgNeUchndDDuBzeSDEej
 HCdGu8xb73rPmEcC9lRax7OqpiIGFzv20ih46GTZIrKR3OvMmHV2lRB7NclqTGKBqjSZ
 hpdRqpUkAX20lE2EUaHJlkAF6kHKTM1CjlF1op4QfELzHdTDL4HuwgAHuDDi405MVgML
 h9/8CX4xuI7aUsh/qtjDK88vL+n9H8i2amkMdTBJ2K4lWkQ2jdQjvfOEM2j6KH4H3omQ
 YXS3T7LozQvC/iyUUeUI4LzbKq4UGS+DyiW3Pz8zG1ecJLBS810j70eXaZEyqNyRa4xZ
 B5QQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWFTsfzR2M38O08g/uyY6Pjz2+52cWX4JPcvMtZ4rJkiFIx2nQLmUDA4s10kzGRG9pcQbKxPV4=@lists.denx.de
X-Gm-Message-State: AOJu0YzPv4wgnhtFcpAOsBGvOxXGR/uMxNo2vSOoXlNrntL9B4ufZp+5
 fVnNMmVZFpICuPb4NiNBCbGXednpCWdlpOlW2YAFzP2i1HRTCZS/L0n2
X-Gm-Gg: ASbGncusb+ZzRaOadnEn4ZpxNgSR4lEL9+u0SeyCl88tF/QuWFxXSUVstAIwliH3GIr
 iyiUbgBQsBTy85lkXL0uBixnAtD9LggRZ7m06cJYCDPz8OOB1KONjBFDMt4S9yoVeR1qLq/fJY9
 lumttjjsujPLV41gFmg+JZpKBc0Rq/pilfXWOsDVW0Z24+hC1DKlwsnbUF1D2KFwVvz+e7NGdXI
 jS8QBUvYaP9gVp3REpPhtpBNCo7caSN58II2upjMuL07AWpu2YdKw8BVg7k0N/fHT/eMPBfKJHB
 g8kj+loD18en86NhdC6oxJIiafz6m7ggRG2OlODg0GmEEis+9odFdMjnbmnxT22hTu1XKNJ8y6S
 aQ79/KkLlasQ4gO4Mq9M0XI7ijOF3De4/nmJ2tv9CMqSN4vlFkFFUWiazys6bGgagSfK5/9n1e3
 /XIOcMrzHAbMVqCes9nfSKQ3jKiVeZ903jzDD9AMprjuk7djrvA4MCRRe0ilY62ceIQWaxZ6OQR
 Y6nzR2Qj1y7DkMr
X-Google-Smtp-Source: AGHT+IHkh8rZbq3T137yw3ecEneUe67l7UvlKQ3/3+ra3bLEfDZ9UUBI2q/lkeG7NaPDhnq8ncj+SQ==
X-Received: by 2002:a05:6402:1e92:b0:640:ae02:d7cc with SMTP id
 4fb4d7f45d1cf-6479c4431c0mr6206690a12.3.1764866512756; 
 Thu, 04 Dec 2025 08:41:52 -0800 (PST)
Received: from toolbox.int.toradex.com
 (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch. [83.173.201.248])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-647b2ec300esm1750465a12.1.2025.12.04.08.41.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Dec 2025 08:41:52 -0800 (PST)
From: max.oss.09@gmail.com
To: Max Krummenacher <max.krummenacher@toradex.com>
Cc: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Subject: [PATCH 2/2] configs: colibri-imx8x: use default for SYS_MALLOC_F_LEN
Date: Thu,  4 Dec 2025 17:41:29 +0100
Message-ID: <20251204164133.1677471-3-max.oss.09@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20251204164133.1677471-1-max.oss.09@gmail.com>
References: <20251204164133.1677471-1-max.oss.09@gmail.com>
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

From: Max Krummenacher <max.krummenacher@toradex.com>

Drop setting an explicit value for SYS_MALLOC_F_LEN. This increases
the available space to 0x10000.

Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>

---

 configs/colibri-imx8x_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/configs/colibri-imx8x_defconfig b/configs/colibri-imx8x_defconfig
index d90bce3ebb6d..fdd4a51a70af 100644
--- a/configs/colibri-imx8x_defconfig
+++ b/configs/colibri-imx8x_defconfig
@@ -2,7 +2,6 @@ CONFIG_ARM=y
 CONFIG_ARCH_IMX8=y
 CONFIG_TEXT_BASE=0x80020000
 CONFIG_SYS_MALLOC_LEN=0x2800000
-CONFIG_SYS_MALLOC_F_LEN=0x4000
 CONFIG_NR_DRAM_BANKS=3
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x80200000
-- 
2.42.0


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9268C3064D
	for <u-boot@archiver.kernel.org>; Tue,  2 Jul 2024 13:00:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E5A92885E4;
	Tue,  2 Jul 2024 15:00:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LWZsg80o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 56653874AC; Tue,  2 Jul 2024 08:54:28 +0200 (CEST)
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com
 [IPv6:2a00:1450:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9099487D33
 for <u-boot@lists.denx.de>; Tue,  2 Jul 2024 08:54:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=l.rubusch@gmail.com
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2ee794ec014so207991fa.0
 for <u-boot@lists.denx.de>; Mon, 01 Jul 2024 23:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719903265; x=1720508065; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MaQFIOJs6pBFcMOfXzsz2pqh/c5Mak4kmjpmRnoBu8Y=;
 b=LWZsg80oFLv8Z6aLoQkX7pVHoQu/gjEC1f9CF2BrfE/c4U4FdKn4P/H5MfjTmSs82H
 MOxbw2bRdP17QPd7ifnfgZF2JJzdJuXwCePQxAnK+4R8nYk1niqu5SouADt+kmYI1TXf
 i9z8Lmz5SMdq5NvRYqaNF79F/jUstU07veH2dhYcGiOAI3EBDNKQvwqNEgNTB+/HKsEf
 mZbwZ07RdeoLOjv4k5MF+fuO76Xx2luRYPaozns4W+r4AsKh3WbIAb+E9mdF3m52gBKj
 qrbY3iTJBy8K4AzVwrRaVilENtcG5ZTIXGSz3Pj+z6DCT6qSIZoV+HNn98gkt+Gsnxlg
 +q8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719903265; x=1720508065;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MaQFIOJs6pBFcMOfXzsz2pqh/c5Mak4kmjpmRnoBu8Y=;
 b=ZrjByLQ6AWSjQtxeLYPukP3eSImp0fcMOM2QN8xAT2yOI7eaPONmWpRwCKy65PfFsj
 d0dpRYDlwyR2Y873ypNOvHA0PG7+2jYxfJYk1740q0nDFojxuuwQ9epYyIg4661tDP1t
 36ruLlBKZuENSTNdzIjN+WDekHvmNcFRsM6W8i+PALrwPJQX/01q1OXSmpBvqHf0s7jY
 5T+as+vDd6LQpWsrcvHld5f2f25+Y3/MJ3dRyEbyiP4+HLvzKj1JMd9COh3cTrUlpWEd
 LJqreR2xuMW/QA5kl5KT8ErvN7hxJyMCSeiaRbGgMP6nWKtYmEiBnKty6OXG4HYNslFt
 QQ5g==
X-Gm-Message-State: AOJu0YyYe08A/LEZZBh3+Klyx6eoLx1LLcLhVUge6j+uXwPIIlTEOj9K
 aB9mImGpG0shP1OBB81tpqVTj3Ji6jNiDOM1BoErxaEk0VgG1GsM
X-Google-Smtp-Source: AGHT+IH2DUPb8tsvh5c7TFf/LtEUDpFxwunTnRj/ER4W7hpgVpMfW25PbheztDdLHmIw24mgqMYuug==
X-Received: by 2002:a2e:a984:0:b0:2ec:53ad:464 with SMTP id
 38308e7fff4ca-2ee5e6cd723mr61638381fa.34.1719903264542; 
 Mon, 01 Jul 2024 23:54:24 -0700 (PDT)
Received: from 9a2819e34573.v.cablecom.net (84-72-156-211.dclient.hispeed.ch.
 [84.72.156.211]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-58613815e1csm5320954a12.44.2024.07.01.23.54.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jul 2024 23:54:24 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: marex@denx.de, simon.k.r.goldschmidt@gmail.com, tien.fong.chee@intel.com,
 trini@konsulko.com, sjg@chromium.org, ilias.apalodimas@linaro.org,
 xypron.glpk@gmx.de
Cc: u-boot@lists.denx.de,
	l.rubusch@gmail.com
Subject: [PATCH] ARM: socfpga: show broken function call for arria10
Date: Tue,  2 Jul 2024 06:53:51 +0000
Message-Id: <20240702065351.289968-2-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240702065351.289968-1-l.rubusch@gmail.com>
References: <20240702065351.289968-1-l.rubusch@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 02 Jul 2024 15:00:15 +0200
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

This patch only shows the problem on an existing platform. Turning on
the cadence QSPI flash breaks the build for arria10. Can you reproduce?

  make socfpga_arria10_defconfig
  make

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
NB: Don't apply this config/patch permanently! The Cadence QSPI
flash can be tricky due to a write reset register instruction which can
brick the board if interrupted. We experienced this situation.
So, that's why I removed the config option in my boards (to be upstreamed
soon). Hence, my boards won't show the above problem anymore.

Anyway, I think the code section in misc_arria10.c have a bug. So, I
presented the before patch.
---
 configs/socfpga_arria10_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/socfpga_arria10_defconfig b/configs/socfpga_arria10_defconfig
index 6d27deeb..c7321bab 100644
--- a/configs/socfpga_arria10_defconfig
+++ b/configs/socfpga_arria10_defconfig
@@ -61,6 +61,7 @@ CONFIG_ETH_DESIGNWARE=y
 CONFIG_MII=y
 CONFIG_SYS_NS16550_MEM32=y
 CONFIG_SPI=y
+CONFIG_CADENCE_QSPI=y
 CONFIG_TIMER=y
 CONFIG_SPL_TIMER=y
 CONFIG_DESIGNWARE_APB_TIMER=y
-- 
2.25.1


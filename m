Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77B13CEBF92
	for <u-boot@archiver.kernel.org>; Tue, 18 Nov 2025 08:32:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2DAE483DEB;
	Tue, 18 Nov 2025 09:30:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="kYc7rILB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E93983C72; Tue, 18 Nov 2025 09:28:26 +0100 (CET)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 944F783CD3
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 09:28:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4779ce2a624so22749025e9.2
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 00:28:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763454503; x=1764059303; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=lpjdtNLUSa5Nf+Kcn+8HYzrzuL7NL/okw9MxRgAme94=;
 b=kYc7rILBDZpM7ZBB57OTWQ06vw59+RiQyuaSxi3W2Zc0xHDBuRdiWsRGwl6ydaC5PE
 XiaM+IMLUM8/+qoeWBRWBoTQD86NEErLjiMJny9k6WVtLCYZ/lbkixXCucZooF1vsbMK
 LL9ATe6L095qGcrP1xlHrD4nL4QgbmBq4Wp/DUtpUf3vz1c1Z5ogLxA4wXfCwhkHe8Df
 geoLU7jW2IVOtjv23zcWTPQUNylgudREwR/e9UmvavV/BqmbnSldUhsoxMlPk6FNVIZN
 xWcXc6kBbqpZpl1iU86XMfkFCJfAW0eK5aqIR/hL9nQF+YSSWhtFXAhh3tnzy7Q/HdK5
 dswg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763454503; x=1764059303;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=lpjdtNLUSa5Nf+Kcn+8HYzrzuL7NL/okw9MxRgAme94=;
 b=FlTdgvWsMwxhXxE9PH6CyHUrvvq25y8X4o+S+m546w/PGqlVJOmZtnQJ2y18UkzEzQ
 TGCPBqnGdwcl8VWdZeLtemprjIlEHv+D4QLDIXFsXg/YM0j0HCuq1l7nOE4yLS8jPHNp
 vn5tBHGKzFCwJMhFoYn447pMi7Lqa0n8wLOejHo85J03ODrdOTstJD6LkXEt+VFOims3
 yih4dmHJBjmH6GzvYYrFmc560YzvSBtRofdxkx4EHVyEaPo8oFc3+RGG7b5R5zVDdsm2
 WLS52+xBkfVgWKg8ODNUwCuoDHESPilwfFDxb/+Kb4ijGELZNcT8R/vwCUV4Y/W2Gq6F
 3wcA==
X-Gm-Message-State: AOJu0YxjD29m9BEAg8xqOLCHNFLUqhURXhPTMpRGpuA3NiucmmsnV7R6
 DfFbimEutGxL1foGC7ehUQ64EQ/PYtlh6C+eO/GoQlkc4tBKs1Z+CAWSzXZekzok0M8=
X-Gm-Gg: ASbGnctLuvGUkR3uitfSmkOAbZuLDy7//7emGob72urov7KnJth9Au3zm31r77MUNgA
 APASrj91fzE7gTNK8Xxy7w/d2WTUoDbjg9KcYs6idRIjqUfjWhdsCkAswrU57yemEydcK58aV7r
 JO0DHwhQNlV6LStDF29zPCnGKuV1VxMHOBf1QqAyqJLC3TBMkbPANZs+eyBhFi97Q4mdqoyGiVR
 +Pod80JkA1FDA0Hg//ijNlXx3qoWeJjL1cd5SuoQVe/ZWPRft2bASN34b6KGYMK/tCZH0UOsXEk
 /8AU2gc4/gVKezaLLKQkfZYKCrq3+mVhjXKFjc1rXrOVfnqe1BGSSgKil4Y6ooKnIeUrDsW0N6Z
 qOtECS3txD548Cm4pwFOAh9PTN1AciEv0wIaDpA2GekkFE23+K5fmokboLr7HCDzHnLUrcdpdQP
 LsePyV51DwBGvp20UvwydBr4uKWa/HjslZNtWXEcTlfg==
X-Google-Smtp-Source: AGHT+IHIynsATMKGeO1nDCBLv72LaZpkUJ4p17c1odLWRbpKNbaNU1Q+mKwCZTzTg/YQeKsKTtsCvg==
X-Received: by 2002:a05:600c:138d:b0:46e:7e22:ff6a with SMTP id
 5b1f17b1804b1-4778fe58e48mr134017285e9.15.1763454502952; 
 Tue, 18 Nov 2025 00:28:22 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477a7cb24dfsm72698875e9.14.2025.11.18.00.28.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Nov 2025 00:28:22 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Tue, 18 Nov 2025 09:28:13 +0100
Subject: [PATCH v4 3/7] MAINTAINERS: add myself as Maintainer of the
 Generic System Interconnect Subsystem
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251118-topic-interconnect-next-v4-3-9c00d6b19add@linaro.org>
References: <20251118-topic-interconnect-next-v4-0-9c00d6b19add@linaro.org>
In-Reply-To: <20251118-topic-interconnect-next-v4-0-9c00d6b19add@linaro.org>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Casey Connolly <casey.connolly@linaro.org>
Cc: u-boot-qcom@groups.io, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Hrushikesh Salunke <h-salunke@ti.com>, Anurag Dutta <a-dutta@ti.com>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, Ion Agorria <ion@agorria.com>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>, 
 Mario Six <mario.six@gdsys.cc>, Christian Marangi <ansuelsmth@gmail.com>, 
 Heiko Schocher <hs@nabladev.com>, 
 Guillaume La Roque <glaroque@baylibre.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, Peng Fan <peng.fan@nxp.com>, 
 Michal Simek <michal.simek@amd.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Pieter Van Trappen <pieter.van.trappen@cern.ch>, 
 Alexander Graf <agraf@csgraf.de>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Rasmus Villemoes <ravi@prevas.dk>, Greg Malysa <malysagreg@gmail.com>, 
 Arturs Artamonovs <arturs.artamonovs@analog.com>, 
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>, 
 Utsav Agarwal <utsav.agarwal@analog.com>, 
 Ian Roberts <ian.roberts@timesys.com>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>, 
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>, 
 Stefan Roese <stefan.roese@mailbox.org>, Sumit Garg <sumit.garg@kernel.org>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Varadarajan Narayanan <quic_varada@quicinc.com>, Sam Day <me@samcday.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=779;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=1RdedE6XE26avL82nV+Uo3NgmI80qP79UxBANUrPB6U=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBpHC4ejjGCmuZ1hfPX5W+23agJPn+bfGGEUL8nWaUz
 w+vhT4SJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCaRwuHgAKCRB33NvayMhJ0dr5D/
 9h13ZbOipD8eFj7h2YX/igZjjothEyG+ZwkwZLGbnTfa67QYS0t0MlJALK7AF4bvy3nINE1w1BStSd
 Rw1YHmn1VPxMCtgy+EOyzgyDiN1VBKIgi7FB5lWgF4WyHYhhEbyvBnHrXoHE6mpNk9W4bY87eenrLr
 NxTVmADfqNdC/SGmHrXmL2dcijfPj72ZVsk3xZt4maNrVhN9r2ce887ZHD3G/w4PrUO90XW+salCkZ
 t21oCzGZ6gQlFTYPotmgKjrwUoHCJzRbJWhuf+WgMdxowbk1o5dewhr3PsGfhzqFqZ5fruB4/NArjS
 hr2FGr3k4WDNxQCigwBVRoLWQN511Dr/wsG26SbRA/M/JlxEx6vziwdm8UKL/a+dSiAlIZl84OiPQn
 UUEkN7XCfCMi+hGxe4xFB3yADyQrAdnAz6x6IawEKFQEl8AuoJFQZCqpfUoqKrMPo2rnDFpxLUMCPk
 jIcTeUaXi8JtQXkdfRUiaVWBDblnHMkpl7aDSpRUJXD+jbKnCaEBM1y45+COlT6WcvQhNH35DBPMYP
 wvxLdgq8J+s4NBMtQ6f+DbsPhqzAKtd+NK5w8XD28O+t5OrKy7zYGNbbDJstxMdTlG+q92TZ7M87tx
 KCQNzdnAap5d2BkKrBdfOrDEjToD8kcMy5q6D/USw8/KSheSVoH3YTA7RRuA==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Mailman-Approved-At: Tue, 18 Nov 2025 09:30:32 +0100
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

I'll maintain the Interconnect subsystem.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 MAINTAINERS | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 60772a494a3..c0c5717f45d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1259,6 +1259,17 @@ S:	Maintained
 F:	drivers/misc/gsc.c
 F:	include/gsc.h
 
+INTERCONNECT:
+M:	Neil Armstrong <neil.armstrong@linaro.org>
+S:	Maintained
+T:	git https://source.denx.de/u-boot/u-boot.git
+F:	arch/sandbox/include/asm/interconnect.h
+F:	doc/api/interconnect.rst
+F:	drivers/interconnect/
+F:	include/interconnect-uclass.h
+F:	include/interconnect.h
+F:	test/dm/interconnect.c
+
 I2C
 M:	Heiko Schocher <hs@nabladev.com>
 S:	Maintained

-- 
2.34.1


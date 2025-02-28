Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37651C282C6
	for <u-boot@archiver.kernel.org>; Fri, 28 Feb 2025 18:31:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 987CF80FF2;
	Fri, 28 Feb 2025 19:31:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QWpo4j9b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C6EB3810ED; Fri, 28 Feb 2025 19:31:21 +0100 (CET)
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com
 [IPv6:2607:f8b0:4864:20::b30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5350980AE1
 for <u-boot@lists.denx.de>; Fri, 28 Feb 2025 19:31:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=malysagreg@gmail.com
Received: by mail-yb1-xb30.google.com with SMTP id
 3f1490d57ef6-e3983426f80so2016101276.1
 for <u-boot@lists.denx.de>; Fri, 28 Feb 2025 10:31:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740767477; x=1741372277; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=qzgLRrw1gv6vDhqgdEBGyjJUWPVgI2+0CM5MUet6yq0=;
 b=QWpo4j9bJ5TQVJIVq1dxG7cpM3g7Jaq7wtmQQDlRG17BOl+lU+1wBkHFTt6Npc3hr4
 I6nU09ts3nXiN8C+hDF3zsAUoeW/EjOqFYgFgrSU/o+EcWe/LnBQOdc3VcWgQhG0cE16
 0i4DJIwfCYeVZRn7Bo2BVIoO/B9cWx4ac4yffC0oQCsvHLyupfRvEnKcGXOmkMy+a/rV
 5rUCuJ7iWT6W9DT+8gEY06rpveJ3li+u9hvvlUpgvU4slnqy2rW4tq6xZz+NRXsH6fkH
 2a3hdaPiv77oTwcwqDV4mj5hoj/5YIheJAN5d3adt5xTki4OhVNXNGf8nQ+bY2BRWkIO
 ejJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740767477; x=1741372277;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qzgLRrw1gv6vDhqgdEBGyjJUWPVgI2+0CM5MUet6yq0=;
 b=ZnlitK/bKc6s25YNCLcPdl028mVmFemBsonugF3kizu/U2CvWyG7LTw85s1VTB2EER
 anZIEIf9nbV4wetLEALtcasB7yW79hS62ERx7JnpjYinCctBqnXENdSzUwV6dqyRYrmx
 lbuQeN+rFpGzKbJLTy/WGU+BkKhnCW7jbFIvfBr2vm5FoIDLSus+ThZs0uP8rXhSrciv
 rxEWsq/TgYcn3jhxFudvM5fjUCvU7p+/tiiB2vwqPqUG9dSnEgdYGHWK9j1SKwKUdsuh
 D7JJBYVNIZiusKWrElnDBtulqp5+ldb2KpxqxqDFS08E9uTT22TrNfmCXnvlEQU/+eyH
 qLIg==
X-Gm-Message-State: AOJu0Yxa20v95o9Rg7EcLz6MQw5RU4t1YTqY8ps2C23YvcKX0pfsNUIG
 mtTyNWHiMUvasfAnqj3O3L40rfbOMBdJI5X2osOO6yZyGlo7ZdMqcW4O
X-Gm-Gg: ASbGncsdT07IGWUSrq0+2KoW4QdgdvtZD4LOcd0vX9GPkNLnqK8nzRkTvOGEYEzgvXh
 cMilhG8lABjdvsv+AWSGiBckU7biIfufX1EWJaNZdnZBwfpJjtSTWGKD67+9vx/Iv2FNYgjIw/A
 Dxudxdk2oUfvYCMHiJ0V0FLbTA0Bq4N28SkWEquDTHanKKQnWT0bgLuieEEB+wmrFWB56XTvrlG
 2MBHID5fk0DbSsHvA4J4iG+AhbAiyXBUQTBLsrkPojpKXu1vT34gjzcLzf6EHlEY5RES70CmWF7
 osx+a5LhE/hw2Zdy5hgwtE3hNARWFncueI5QVN+4og==
X-Google-Smtp-Source: AGHT+IEcl/vyTRSvnKrKupC5AK2HFtQXTqOtN3+HbYKXYNuZWM5xPOrudBJWyU7cHL/WwTfosQe6dA==
X-Received: by 2002:a05:6902:15cc:b0:e59:dbac:d993 with SMTP id
 3f1490d57ef6-e60b2e9dbe4mr4951656276.17.1740767477242; 
 Fri, 28 Feb 2025 10:31:17 -0800 (PST)
Received: from executor.attlocal.net ([2600:1700:5eb5:1ba0:dc1f:cff:fef9:435b])
 by smtp.gmail.com with ESMTPSA id
 3f1490d57ef6-e60a3aa52edsm1247349276.43.2025.02.28.10.31.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2025 10:31:16 -0800 (PST)
From: Greg Malysa <malysagreg@gmail.com>
To: u-boot@lists.denx.de
Cc: Greg Malysa <malysagreg@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Christopher Obbard <christopher.obbard@linaro.org>,
 Eugen Hristev <eugen.hristev@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Michal Simek <michal.simek@amd.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Padmarao Begari <padmarao.begari@amd.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Robert Marko <robert.marko@sartura.hr>,
 Sam Protsenko <semen.protsenko@linaro.org>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH] MAINTAINERS: Update contact information for Greg Malysa
Date: Fri, 28 Feb 2025 13:29:50 -0500
Message-ID: <20250228183009.22823-1-malysagreg@gmail.com>
X-Mailer: git-send-email 2.45.2
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

My previous address is no longer accessible, but I will continue to be
involved in maintaining the ADI sc5xx platforms. This updates my contact
information to avoid bouncing emails from other developers.

Signed-off-by: Greg Malysa <malysagreg@gmail.com>

---

 .mailmap    | 1 +
 MAINTAINERS | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/.mailmap b/.mailmap
index dc11775d4e7..b2c98757a71 100644
--- a/.mailmap
+++ b/.mailmap
@@ -42,6 +42,7 @@ Durga Challa <durga.challa@amd.com> <vnsl.durga.challa@xilinx.com>
 Eugen Hristev <eugen.hristev@linaro.org> <eugen.hristev@microchip.com>
 Eugen Hristev <eugen.hristev@linaro.org> <eugen.hristev@collabora.com>
 Fabio Estevam <fabio.estevam@nxp.com>
+Greg Malysa <malysagreg@gmail.com> <greg.malysa@timesys.com>
 Harini Katakam <harini.katakam@amd.com> <harini.katakam@xilinx.com>
 Harsha <harsha.harsha@amd.com> <harsha.harsha@xilinx.com>
 Heiko Stuebner <heiko.stuebner@cherry.de> <heiko.stuebner@theobroma-systems.com>
diff --git a/MAINTAINERS b/MAINTAINERS
index c1851280e6e..0be13b95727 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -615,7 +615,7 @@ F:	arch/arm/dts/am335x-sancloud*
 
 ARM SC5XX
 M:	Nathan Barrett-Morrison <nathan.morrison@timesys.com>
-M:	Greg Malysa <greg.malysa@timesys.com>
+M:	Greg Malysa <malysagreg@gmail.com
 M:	Ian Roberts <ian.roberts@timesys.com>
 M:	Vasileios Bimpikas <vasileios.bimpikas@analog.com>
 M:	Utsav Agarwal <utsav.agarwal@analog.com>
-- 
2.45.2


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 351A1C282C6
	for <u-boot@archiver.kernel.org>; Fri, 28 Feb 2025 19:30:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 77BE1810EB;
	Fri, 28 Feb 2025 20:30:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="W7pbuVHu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 18A8E810ED; Fri, 28 Feb 2025 20:30:31 +0100 (CET)
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com
 [IPv6:2607:f8b0:4864:20::112c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C9B9D809A5
 for <u-boot@lists.denx.de>; Fri, 28 Feb 2025 20:30:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=malysagreg@gmail.com
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-6f77b9e0a34so19765027b3.2
 for <u-boot@lists.denx.de>; Fri, 28 Feb 2025 11:30:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740770975; x=1741375775; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=svHNW4hmwfc76ZCe77PNKR0Z7oNNqcMnU0cBHLZ785c=;
 b=W7pbuVHuG0TTVFK+KdK0U6r1xxEhwO7D80lznLwrJsgJuQn7OI9d3d5uPp9qjE3BhO
 a891qJ7xgedx0lxz8D/1iplaN5Ri7LdhP97/IP+uXPV+E49cOmcZZNlIIiiqOnhERmn/
 wWgxXh4RnJjKEpP8LJM642+PphDsV6RAxDPcIZMO3Z+sRLXAb13/hLhcPW7JMDsDggVl
 g4ZaLL5Z+Vi7MQIqoXyPB6/Ly8BYn+RHdWB5bVn49qL2JQeeWD5WI01IF9c5oYthyINF
 0qpj0sfwXM62AcF7X8xUo8lEc8pIG9meAZfRCKWie8y74PaBLUG9DLvY/7aEWwmvmW5X
 Z4Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740770975; x=1741375775;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=svHNW4hmwfc76ZCe77PNKR0Z7oNNqcMnU0cBHLZ785c=;
 b=qSTOleiMS5WhM1Eu1NcHUnlmoclIuQ/hGyUH47OgRqsplaT+SxXNMpzdoFIaddrmzH
 dDLF4kwK83lCgtx0KmvyVnoiO9tKAhklZcLrFW1Wfnvp8KWRNW2AJeoxIGUZzcpUGAEr
 8ZNIVcy6FE64sjh3Ihb2oOpwerhKb7TQJnMOW2yZqt4BUG6tb0OwJ9O+Nv7yekwBnDG8
 dkZJI80XQXdUxCRgoxKHG/77v239GL1Sbg+jUYHawFj0yOH95TEmwuWhLpPQvfeCbzUR
 7FTuWGp8ADg4YsysDJI47FIc4hWgKv7M8H+7XTy5kV3wfPmzFYyQiTSzDmu0irDvIi5j
 Nsbw==
X-Gm-Message-State: AOJu0YzfeVYi43jwe0FRifFnTAz+I2utbgRA6PLV5mVKLB755cX083VX
 +AjW4JtQzNzClURVLgaRSTDwYyCJekiKscvYN+SrDZGrqD6qpog5esZd
X-Gm-Gg: ASbGncuEP7e7oLimdS6R3zafmmXosqBizpuohWPA08Snznn52e0vwKop7T7WD2jUntu
 BQXAjL9sl8DRgVH8EnTNWjaIG76+Ra468k0G2RcNjcDOh0AAW2E0KEvOpAY10LoiuxKeDpSwqVV
 SlqElKJec+XJ4Sayj6m441HRIRMkoEIeHgDDXivE9aBAX0H4b3TqM5dqqRed9exV8h2FHxvs6Nq
 RcvmMeCx2tUWiDZkc9ETcXlvQy9t3/I6tHNC/Iqk0pBgTg/04B/7ifgj2UVGDiMYNCgOXfLciNJ
 LNpKKa4VErs7g7w2tZg7/4SUgCxCKFm2tgFkiYQzFQ==
X-Google-Smtp-Source: AGHT+IF3ElE7FF2NvdOC0uBlegW4kvctptm1nKo3pfUnj8Ozq/Co6/HDSwb4rH0rOmZG+jq7x/gbTg==
X-Received: by 2002:a05:690c:360d:b0:6e2:1527:446b with SMTP id
 00721157ae682-6fd4a08e916mr60810397b3.3.1740770975277; 
 Fri, 28 Feb 2025 11:29:35 -0800 (PST)
Received: from executor.attlocal.net ([2600:1700:5eb5:1ba0:dc1f:cff:fef9:435b])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-6fd3ca41d89sm8628487b3.31.2025.02.28.11.29.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2025 11:29:34 -0800 (PST)
From: Greg Malysa <malysagreg@gmail.com>
To: u-boot@lists.denx.de
Cc: Greg Malysa <malysagreg@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Christopher Obbard <christopher.obbard@linaro.org>,
 Eugen Hristev <eugen.hristev@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Padmarao Begari <padmarao.begari@amd.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Robert Marko <robert.marko@sartura.hr>,
 Sam Protsenko <semen.protsenko@linaro.org>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2] MAINTAINERS: Update contact information for Greg Malysa
Date: Fri, 28 Feb 2025 14:28:27 -0500
Message-ID: <20250228192830.27585-1-malysagreg@gmail.com>
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
information and hopefully avoids bouncing emails from other developers.

Signed-off-by: Greg Malysa <malysagreg@gmail.com>

---

Changes in v2:
- Fix missing > at the end of my new email; patman still "worked" with
  a warning so I missed this mistake earlier and my CI machine was tied
  up with another series

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
index c1851280e6e..4e90a888b94 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -615,7 +615,7 @@ F:	arch/arm/dts/am335x-sancloud*
 
 ARM SC5XX
 M:	Nathan Barrett-Morrison <nathan.morrison@timesys.com>
-M:	Greg Malysa <greg.malysa@timesys.com>
+M:	Greg Malysa <malysagreg@gmail.com>
 M:	Ian Roberts <ian.roberts@timesys.com>
 M:	Vasileios Bimpikas <vasileios.bimpikas@analog.com>
 M:	Utsav Agarwal <utsav.agarwal@analog.com>
-- 
2.45.2


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 455B1D19503
	for <u-boot@archiver.kernel.org>; Mon, 26 Jan 2026 16:15:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 24B5383C6C;
	Mon, 26 Jan 2026 17:15:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MtgooJNE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F35B283C04; Mon, 26 Jan 2026 17:15:14 +0100 (CET)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B8A483C04
 for <u-boot@lists.denx.de>; Mon, 26 Jan 2026 17:15:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ozndrgt@gmail.com
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4801d1daf53so51332855e9.2
 for <u-boot@lists.denx.de>; Mon, 26 Jan 2026 08:15:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769444112; x=1770048912; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4JPsHvLYr+bBjqEZJ+jwVEuGyEzCxMTS3wLZRu6S1vk=;
 b=MtgooJNErryT6ysz0kPAhtCEqSkRuAqgMOIAziYKwuDCXzkpNFfX/IoTOoIgDSI7Nr
 6HJ5SgjxIc44FlzLloNOYy7EjTmX2Axq9YVhiuGTgn0nYCUvYZuueLcP1mMplRg3OJBf
 O2ruqAzBXEQBZBGzFTNog2H6FTRAcGxMkD1zYtkCkP1hI1mC4HsHIo8/gjvZxrBTiB6E
 w/1BQ27E9oJO3wi9MQgBZarWsYs+7lVfJzpWISIZ3OMs9aDhVsF6QFc7xTRl+4cnSZSF
 T/p1ZulujCW0blhV/uxMnqt/6DgIJKq1/cIwcrVY5+hg0jecm1NEBwATlxbNW87VIh/z
 lJnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769444112; x=1770048912;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4JPsHvLYr+bBjqEZJ+jwVEuGyEzCxMTS3wLZRu6S1vk=;
 b=UPqDXmLXpP0yreA12O2W5dKdK/6/igULVrJTgVOrW1OOlF0I0qeF8mT9fqaT9op3V6
 GGwNq8LXCzha3eKM8m/4erFUncn3BN8Lci8gJlnckI1cPqnE2sq7XQ4gFRwvmDt6yBYY
 KPz5ufUmEMzd7AkWUmn0A9OMPXIvKaImTZjqBdKOTCTPoxjOGerlqeAhul7tIIaF2jCy
 ggzILH5Lthwx9hDf4ygXL8Ndho7xMB18kHYHToaEyaUNmOoAYbO8askcTcFQcCPVneo+
 BAC9EAfBng0CNB/3AxG7W0XlqhzvBfVzuQdZoxkCBnKKtJ070qLG1SE/bjhF0RXz3dtA
 98GA==
X-Gm-Message-State: AOJu0YzKFqCVMpGU+8MtDuKVu0imACNOmuk1CA75m54tVCYpkwmiZM/v
 Oy8MYw4WTE/ruG7xrIPSfLldbScdzedk6aZVxYnEQXbbKClyStyihu3lz+Z9mA==
X-Gm-Gg: AZuq6aLT8Oh3WYKDZ4nLlrtN4hBvNHn8Eoap0+aOgCEo7LuegS0469hH/QjfAwnptyn
 /4FEpgQZzqWvLI++1J8vggPt23rVxKIjfOCnN0P5jfwTWvNiMuaKjFTjP8r6ZTQnqBOyamPoWJm
 DvpPWzg70ModfGLOZnzbQW/aebla1ITStkWlFsGVlW68a66VpfF64KLYtE6ZJFvPiddXjyLmUAp
 zuKjSs2ExSq7wfGNZiVcT966iT/qvmSDIrqj7niBSk4EIEcx80o573pBnnfL9QfEAVs73g6kFDT
 t/ubRSeSN4Ix4vmJqSSB3NKXLModcOZODONfOpupIYjVA5nne6MT/64s61YUrmVjJw/WcTpZLud
 Cr/VEn66uG3WV3GLlbsr9b/n7HHjGJZ6G0z7OLFC2eeh2d6qBPvtv1YQztFtp0VD+ORAjqSDsAm
 Tas/p3GvtUi4ISth9+ceqkOAQ=
X-Received: by 2002:a05:600c:4693:b0:477:af07:dd1c with SMTP id
 5b1f17b1804b1-4805d066303mr104271295e9.35.1769444112005; 
 Mon, 26 Jan 2026 08:15:12 -0800 (PST)
Received: from odurgut-Precision-5570..
 ([2a00:20:c361:3985:cfa:b5c2:f360:f511])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4804d5ffe12sm107368615e9.3.2026.01.26.08.15.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jan 2026 08:15:11 -0800 (PST)
From: ozndrgt@gmail.com
To: u-boot@lists.denx.de
Cc: linux@analog.com, malysagreg@gmail.com,
 Ozan Durgut <ozan.durgut@analog.com>
Subject: [PATCH 1/5] configs: sc598-ezkit: enable additional commands
Date: Mon, 26 Jan 2026 17:15:01 +0100
Message-ID: <1f8bbe390897cd96bccd17536625e3ceecb270ce.1769439596.git.ozan.durgut@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1769439596.git.ozan.durgut@analog.com>
References: <cover.1769439596.git.ozan.durgut@analog.com>
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

From: Ozan Durgut <ozan.durgut@analog.com>

Enable FAT and GPT support, as well as mtd and wget commands

Signed-off-by: Ozan Durgut <ozan.durgut@analog.com>
---
 configs/sc598-som-ezkit-spl_defconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/configs/sc598-som-ezkit-spl_defconfig b/configs/sc598-som-ezkit-spl_defconfig
index 567faadefa9..498af6d2052 100644
--- a/configs/sc598-som-ezkit-spl_defconfig
+++ b/configs/sc598-som-ezkit-spl_defconfig
@@ -109,3 +109,7 @@ CONFIG_USB_DWC2=y
 CONFIG_USB_STORAGE=y
 # CONFIG_SPL_CRC8 is not set
 # CONFIG_TOOLS_MKEFICAPSULE is not set
+CONFIG_CMD_FAT=y
+CONFIG_CMD_GPT=y
+CONFIG_CMD_MTD=y
+CONFIG_CMD_WGET=y
-- 
2.43.0


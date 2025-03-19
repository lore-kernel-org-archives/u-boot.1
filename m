Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82A10C282EC
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 01:43:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 14C1B81BC0;
	Wed, 19 Mar 2025 02:43:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UTs1V3AB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ED36181951; Wed, 19 Mar 2025 02:43:17 +0100 (CET)
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com
 [IPv6:2607:f8b0:4864:20::72e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D0DE7805C3
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 02:43:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aford173@gmail.com
Received: by mail-qk1-x72e.google.com with SMTP id
 af79cd13be357-7c546334bdeso485019885a.2
 for <u-boot@lists.denx.de>; Tue, 18 Mar 2025 18:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742348594; x=1742953394; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vIzPgYB323doA2toryPTq9Bwd32zAl6KMF2yCLCOfbk=;
 b=UTs1V3ABy1L5uzAFucQGmMTNymjknqblh7A/nKkPhpG4UyX/eTypsSGvulcMhLAce8
 Qa8iLxzNVkUfqCli5oQoP4kVZ65x101LC5hAnovn6+lfbGJIycDJDwvLTYEq4Nc64PKm
 MRmduFce+CXGeCqWU6Sak4XmdIZlojRUllcx9YtpoyC+QwIplfhY7PR4Pee4vb5kMRrJ
 0X08EtidwQPOqWl/aKJIMUTpW1tKAi1NJ06Obe/i1ia3NEBxpLn4waQeF4a758wmtH73
 NEQVFyDC1+FURfRVqAJGO3sAdAcbSom44EFyJfdhaA+FFJWyBUXtVXqkS608fnmS+wQH
 Fl3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742348594; x=1742953394;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vIzPgYB323doA2toryPTq9Bwd32zAl6KMF2yCLCOfbk=;
 b=IpJTR8aYb8f604wDCh3qqvhGaULeqpRyjSFs9ofQbIka5FfBiAKSIFqdPQYCPDN34x
 tjOOsM6LIGdq8LGyNKKiiPu9ge4nG2KJByMU7qRcbhCDOAi2QHrVyRAd7m0DHayqJGXN
 /+OJfPkO/Y4mYO3CFghXfka6GPwj5xPiHufLR9kJIVLlNjsfncHjl5zXXC4xkk/MYSKp
 vajFQkKYVtDuk6yBXZ/+sApboFHwHBz0OTha8/GQSXntwOkiunA7E2lJMlJC9hfORyzC
 pnSAwdBhUnl4v7q55ghX0jOgJrPdnpFzZqEgGgxPMQnBCh7kDWdytNKDaQcT73rzCBIT
 02Yg==
X-Gm-Message-State: AOJu0Yx0kB2L7I4olMS/21PXQMIp9M4KmvGXsnYTcZewjkgbyllauz0x
 +6wZSRL7//s85Eg3uadXXehsb5lXypZ9OF5kDVcETOanpLlAmVLFS0J0yg==
X-Gm-Gg: ASbGncveHV6XRNaRFHfuVsITK2D/8cTP1LsY3NeSR0tOETrh/TLuuWuFkb4P+tlHoaZ
 l9THfUBotDrXf8mY+5iZn1Pz6kq5bV+cu2ujKEx8K/z+hgdzkQr1zyf+AaWPaGJv9Kdv0W0vD2f
 feondJqWsC+uDm2pUGWRiKM9Rof8fDMKlHcjcjfYCqjXN62N3bK6RDMQtD+BPZ3P6uOSeBsTl+8
 CSnMFVIBy+PvSAGicDDX4mmr2H/MFFgVkdg1I9BZXhVjTdUCr1SngwiDMh/AMFuI9ScHcXCer+N
 k/Hb/S3CRC8zeUilDDIgvcjb+HMB2VVhcrRw8qe7b/ii7rEoB8BDLJU9yt4Eujv5oQdOyFkI9K2
 TVwxhLOlj1A0VVPWJQxw=
X-Google-Smtp-Source: AGHT+IGJMZaZxwNgZuJvG0HP7eNEV2QKW9p/8frUuKnKuAyVcCiOLEWti5bFyFsfH7jgL8wbkOmQ0A==
X-Received: by 2002:a05:620a:2950:b0:7c5:59a6:bae2 with SMTP id
 af79cd13be357-7c5a827be12mr150707185a.4.1742348594131; 
 Tue, 18 Mar 2025 18:43:14 -0700 (PDT)
Received: from aford-System-Version.. (c-75-72-162-184.hsd1.mn.comcast.net.
 [75.72.162.184]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c573c4e6a1sm795871185a.18.2025.03.18.18.43.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Mar 2025 18:43:13 -0700 (PDT)
From: Adam Ford <aford173@gmail.com>
To: u-boot@lists.denx.de
Cc: aford@beaconembedded.com, festevam@gmail.com,
 Adam Ford <aford173@gmail.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Sean Anderson <seanga2@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Sumit Garg <sumit.garg@kernel.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Peng Fan <peng.fan@nxp.com>,
 Hou Zhiqiang <Zhiqiang.Hou@nxp.com>, Ye Li <ye.li@nxp.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
Subject: [PATCH 3/4] arm64: imx: imx8mn-beacon: Enable CPU_IMX
Date: Tue, 18 Mar 2025 20:42:36 -0500
Message-ID: <20250319014240.592189-3-aford173@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250319014240.592189-1-aford173@gmail.com>
References: <20250319014240.592189-1-aford173@gmail.com>
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

Enable CPU_IMX to register the ARM core and identify the
speed and temperature information using the driver model.

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/configs/imx8mn_beacon_defconfig b/configs/imx8mn_beacon_defconfig
index 69af7cee092..93b32155aa9 100644
--- a/configs/imx8mn_beacon_defconfig
+++ b/configs/imx8mn_beacon_defconfig
@@ -93,6 +93,8 @@ CONFIG_REGMAP=y
 CONFIG_SYSCON=y
 CONFIG_SPL_CLK_IMX8MN=y
 CONFIG_CLK_IMX8MN=y
+CONFIG_CPU=y
+CONFIG_CPU_IMX=y
 CONFIG_USB_FUNCTION_FASTBOOT=y
 CONFIG_FASTBOOT_BUF_ADDR=0x42800000
 CONFIG_FASTBOOT_BUF_SIZE=0x40000000
-- 
2.45.2


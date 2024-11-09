Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9258FD5E380
	for <u-boot@archiver.kernel.org>; Sat,  9 Nov 2024 20:06:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BFEC5892FB;
	Sat,  9 Nov 2024 21:06:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mslgB3QB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A09F688E96; Sat,  9 Nov 2024 21:06:20 +0100 (CET)
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com
 [IPv6:2607:f8b0:4864:20::82f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 99650892E5
 for <u-boot@lists.denx.de>; Sat,  9 Nov 2024 21:06:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aford173@gmail.com
Received: by mail-qt1-x82f.google.com with SMTP id
 d75a77b69052e-460e6d331d6so20976021cf.2
 for <u-boot@lists.denx.de>; Sat, 09 Nov 2024 12:06:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731182777; x=1731787577; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=B3fhL6EnFHx9RPeRVd5KqyiXutmNWQS+C3H8iCDKsz4=;
 b=mslgB3QBEaDpxZbBIoQ1YFPfN0T0Kg1feOTfAaqMw4F6iNyzEt2R6twqYk5byKQ7J9
 HTEsgyYmLPJ/iE0UOreb0sX/d/jDxPIyk+k8gTVD2WBfyiIru151G+FpcneKMwxLNtc3
 Wm+L0Zy+j4y1/ogGK3YL/sb1dVX0UufPwdOihEFW49Vnjq0HvDSD6U4uEKzySeF1794T
 B1XV6FZPuzjM2azmVgq+yjCTrnu93OUCzGYj/Cp5I1JvBHh0nyQqRdEugfcMtrPpD7SY
 FJ/Ui8om8NZysZUDGsPCN2RHVRs28ycL2afRquUYO6ZEhoj3ldaMebSyQtNmWytwrPy1
 fErg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731182777; x=1731787577;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=B3fhL6EnFHx9RPeRVd5KqyiXutmNWQS+C3H8iCDKsz4=;
 b=F74zc+CTgy6OF6bZ5yCAdQ7OMrCPsRBxA0Zt0IyOX9P9rKZ/g2Z6i0MCUlLj5LgQ/1
 N0h/BaIQOfHsh5eo1K5RySXhgyGq3tQXZs5USZKGhRmzaMs11/TARdrMbm1rpR6pWtiz
 8Uer53dLDXvrb+AkboefD2HRpjHVROnyGpG+UX81J2sKr1zyVRIe9BYJqOf17OlYfCCl
 9wYEaeXtOWbmRtFpzT7ngzD3rkDYR9ZwKoX/bY4Z6/99Q+8/EC6cx6Xf06SStPO/QcYP
 U1xrTxkYUUGWW+Dedg9jE/3FN8DwESJNqKEC/33sv9lLz5B4zHb6DxZlFJy0Pp65yzcs
 YVxQ==
X-Gm-Message-State: AOJu0YzZJhmiXz/WyG6bBdhh4tXJftyfBOUg7bkbD5oxPv+wTBaxRi0F
 bj64ZyEvTd4qlsJTCM9bX0lU34bInlUIGI2RG7kROyQQWJbJzFP5iqFVwA==
X-Google-Smtp-Source: AGHT+IF0tMgbpR49GToV+RWBv90cybxKeus6vr1QXnRUeKGyQRKpUlZS9vZ8SvPIi9KsZHGTaq6Nzw==
X-Received: by 2002:ac8:6690:0:b0:463:1561:a0e3 with SMTP id
 d75a77b69052e-4631561a1d2mr52449551cf.19.1731182776934; 
 Sat, 09 Nov 2024 12:06:16 -0800 (PST)
Received: from aford-System-Version.. (c-75-72-162-184.hsd1.mn.comcast.net.
 [75.72.162.184]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-462ff5d678asm36525341cf.85.2024.11.09.12.06.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 Nov 2024 12:06:15 -0800 (PST)
From: Adam Ford <aford173@gmail.com>
To: u-boot@lists.denx.de
Cc: aford@beaconembedded.com, lukma@denx.de, Adam Ford <aford173@gmail.com>,
 Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marex@denx.de>, Tim Harvey <tharvey@gateworks.com>,
 Peng Fan <peng.fan@nxp.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>
Subject: [PATCH 0/4] Fix FSPI booting on i.MX8M Mini and Nano
Date: Sat,  9 Nov 2024 14:06:01 -0600
Message-ID: <20241109200610.1615430-1-aford173@gmail.com>
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

When the binman tools was upgraded to use imx8mimage, it appears to
have changed how the code and/or boot ROM search the blob for the objects
within the binary blob which broke bootin from FSPI on Mini and Nano.

Instead of reverting the use of imx8mimage, create two files where the
first one lacks the flexspi configuration table, and a second file which
contains the flexspi configuration table plus the contents of flash.bin.
Keeping this information from imx8mimage appears to work since the code
reading from the FSPI seems to already compensate for the adjusted offsets.

On the Nano, the flash.bin file is identical between the fspi mode and the
sd mode, so this series allows us to remove an extra defconfig file since
the objects built are virtually the same between SD and FSPI because the
boot ROM is a little newer than Mini.

Adam Ford (4):
  arm64: dts: imx8mn: Fix FSPI booting
  configs: imx8mn_beacon: Enable FSPI_CONF_HEADER
  configs: imx8mn_beacon: Remove imx8mn_beacon_fspi_defconfig
  arm64: dts: imx8mm: Fix FSPI booting

 arch/arm/dts/imx8mm-u-boot.dtsi      | 259 +++++++++++++-------------
 arch/arm/dts/imx8mn-u-boot.dtsi      | 266 ++++++++++++++-------------
 configs/imx8mn_beacon_defconfig      |   2 +
 configs/imx8mn_beacon_fspi_defconfig | 152 ---------------
 4 files changed, 275 insertions(+), 404 deletions(-)
 delete mode 100644 configs/imx8mn_beacon_fspi_defconfig

-- 
2.45.2


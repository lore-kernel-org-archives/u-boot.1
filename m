Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4A50E784A7
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 01:35:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 20A2287241;
	Mon,  2 Oct 2023 03:18:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DcjISb+T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1559B8745C; Mon,  2 Oct 2023 03:18:26 +0200 (CEST)
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com
 [IPv6:2607:f8b0:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A3E628725C
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 03:17:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x129.google.com with SMTP id
 e9e14a558f8ab-351435e9fd4so36757565ab.1
 for <u-boot@lists.denx.de>; Sun, 01 Oct 2023 18:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696209390; x=1696814190; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Yn1Hl9v6iOY0Bf7grMkijoKyMllmQKxXpVhCiPWJkXg=;
 b=DcjISb+THmrZ5CXokBwVHF4ZtoPwJoKxxk4fhpHdPwTpBpDBqhYpHdYh6nK31TjRd8
 tz1/rvMNl6wOhuB62bnIA+ugyn7ZinmPyzAKsAxFi86HBPv8FIun/btpRQhoiIMndYkQ
 jqBe0asGbXVKUvvVF/INmC/srFzpnPORUcbsg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696209390; x=1696814190;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Yn1Hl9v6iOY0Bf7grMkijoKyMllmQKxXpVhCiPWJkXg=;
 b=lV4QWpHw5qo2FkIdRFtTJKt+eC+DxQpFkhBenHfemPQpSiGW4B/LFDCSRrSCz57gT8
 OSYCaxJBN2Nv0ZWWFjAThWgy9zoMmCdm88LXBU2ra9V1W73ElvcmsN6/Vcz6E7pplP2v
 5gXrL6EsYCpYw8CGoXiByau5chFoX3/Sz8kLLnBcCXtQAkLvmyGGc/u8O60eFkN72kki
 yQXQYZTOykLV49LyLqJt0EofmNE+mkArLccwr5XLIh+Gv6OyqUPu5LPo6W7ttXtXx3SO
 3PQwB8/mNh7ii1A6ZVcBV+NMBYHv5GsfmidQmogHiWg3gEVwgX/z2ve91DsG0gZ0Cw0Y
 oXwg==
X-Gm-Message-State: AOJu0YyqcFTWjQaBbSBopWNRU/UYwr0STu1oN3oClnP/eZphi//M55Sa
 g/+RXGPOGldBJ65uZH/+OIduVgQbv3adyOjaZm8=
X-Google-Smtp-Source: AGHT+IFUpGwhRwuIz8Sw9dB2Ir7OsihIlwtOwIozcww26G8QVkpX8bqnmp14Z9Ym68XfRgm69CfiQQ==
X-Received: by 2002:a05:6e02:118d:b0:351:526a:499 with SMTP id
 y13-20020a056e02118d00b00351526a0499mr9685748ili.20.1696209389922; 
 Sun, 01 Oct 2023 18:16:29 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 l26-20020a02a89a000000b0041d859c5721sm6819619jam.64.2023.10.01.18.16.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Oct 2023 18:16:29 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Tom Rini <trini@konsulko.com>, Anatolij Gustschin <agust@denx.de>
Subject: [PATCH 27/34] x86: coreboot: Enable unit tests
Date: Sun,  1 Oct 2023 19:15:37 -0600
Message-ID: <20231002011553.463514-28-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
In-Reply-To: <20231002011553.463514-1-sjg@chromium.org>
References: <20231002011553.463514-1-sjg@chromium.org>
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

Enable unit tests so we can run command-line tests in coreboot. Enable
console recording, with enough space for the 'cbsysinfo' command. Add
to the pre-relocation malloc() space to make room for this.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 configs/coreboot_defconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/configs/coreboot_defconfig b/configs/coreboot_defconfig
index 7d744e9962ae..5433a5ae0c2d 100644
--- a/configs/coreboot_defconfig
+++ b/configs/coreboot_defconfig
@@ -1,6 +1,7 @@
 CONFIG_X86=y
 CONFIG_TEXT_BASE=0x1110000
 CONFIG_SYS_MALLOC_LEN=0x2000000
+CONFIG_SYS_MALLOC_F_LEN=0x1000
 CONFIG_NR_DRAM_BANKS=8
 CONFIG_ENV_SIZE=0x1000
 CONFIG_DEFAULT_DEVICE_TREE="coreboot"
@@ -16,6 +17,8 @@ CONFIG_SHOW_BOOT_PROGRESS=y
 CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="root=/dev/sdb3 init=/sbin/init rootwait ro"
 CONFIG_BOOTCOMMAND="bootflow scan -l; if bootflow menu; then cls; bootflow boot; fi"
+CONFIG_CONSOLE_RECORD=y
+CONFIG_CONSOLE_RECORD_OUT_SIZE=0x1000
 CONFIG_PRE_CONSOLE_BUFFER=y
 CONFIG_SYS_CONSOLE_INFO_QUIET=y
 CONFIG_LOG=y
@@ -60,3 +63,4 @@ CONFIG_CONSOLE_SCROLL_LINES=5
 CONFIG_CMD_DHRYSTONE=y
 # CONFIG_GZIP is not set
 CONFIG_SMBIOS_PARSER=y
+CONFIG_UNIT_TEST=y
-- 
2.42.0.582.g8ccd20d70d-goog


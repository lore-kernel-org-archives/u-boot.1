Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 968F2E784A6
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 01:36:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1481A8723F;
	Mon,  2 Oct 2023 03:18:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="UMBqvEO7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 00A17871A4; Mon,  2 Oct 2023 03:18:48 +0200 (CEST)
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com
 [IPv6:2607:f8b0:4864:20::d32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DCEE987288
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 03:18:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd32.google.com with SMTP id
 ca18e2360f4ac-7a26fbfcf8eso90126839f.2
 for <u-boot@lists.denx.de>; Sun, 01 Oct 2023 18:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696209397; x=1696814197; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JLYEiPejhXznmzYRrJ1pqI6+La8HHBtZLoM/W9cvp2g=;
 b=UMBqvEO7Ocl2tGztzvb+IchwzLsMR9KVRX5GhgRx79lGPf1WLroaLyaBQoCDJFHhmC
 lKykA6ODHDMfTLrzxLfZBnD/+VmgF8nGdcn/14jv4hIyeYjeh+p6EZpF5DP+5WJNRL66
 bNUFv+5adjtlVF79kTMu06r844ScO0xUCPGvM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696209397; x=1696814197;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JLYEiPejhXznmzYRrJ1pqI6+La8HHBtZLoM/W9cvp2g=;
 b=HbBvgmptRsy/pfCHHubW8y4e+Wy1d95PNcjU3o8f5Uzm8mEoH5W85F0OUzXzoQW1gD
 kh075dzaXPbqZgQTcR7T/ZOHYIkLK1Vy0fVUmMNNfKl6wApUK8Xxu/tC8mi7N3Xyzjp1
 +YTYO+D1ICCkQ8MR/TcTAEckpaCccz0KR7zIdQpegIYgilxK5dlNfBQ7+mL1dw1JCSh/
 sLR75u6O/UnTTPYakFwskC48YqtF0SYk+ZY71HUl82AVYIPWiYg56KZkFoUpQoDKt0hE
 LTYF9WeRdfLIJFUxGZM0LRrPIlih4+oZWE3mfU4iUms+VEVHfGOsZSLaRtVxLpWl8Wvx
 D5KA==
X-Gm-Message-State: AOJu0YxP4doPvHJcKvAV8Bk4sJ2MofaUo4n4svwIBf2UrrOL40PEMUXy
 Dj5IE/su51TjeE+sXC6bsmZyBRXoCvAw6Y3awvA=
X-Google-Smtp-Source: AGHT+IFI7254PSqKpoi9eEexbFkQX+t1nCvLYEHQoM/vYBzjMxlX9+QLUny0WyGFOeK0oo0qeJ+SKA==
X-Received: by 2002:a05:6e02:1646:b0:34b:ad80:61c1 with SMTP id
 v6-20020a056e02164600b0034bad8061c1mr14288345ilu.26.1696209397253; 
 Sun, 01 Oct 2023 18:16:37 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 l26-20020a02a89a000000b0041d859c5721sm6819619jam.64.2023.10.01.18.16.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Oct 2023 18:16:36 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Tom Rini <trini@konsulko.com>, Anatolij Gustschin <agust@denx.de>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Ramon Fried <rfried.dev@gmail.com>, Sean Edmond <seanedmond@microsoft.com>,
 Tobias Waldekranz <tobias@waldekranz.com>
Subject: [PATCH 34/34] x86: Enable RTC command by default
Date: Sun,  1 Oct 2023 19:15:44 -0600
Message-ID: <20231002011553.463514-35-sjg@chromium.org>
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

The real-time clock is needed for most X86 systems and it is useful to
be able to read from it. Enable the rtc command by default.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 cmd/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index e6977dc91bb2..080e104f9d76 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -2164,6 +2164,7 @@ config CMD_DATE
 config CMD_RTC
 	bool "rtc"
 	depends on DM_RTC
+	default y if X86
 	help
 	  Enable the 'rtc' command for low-level access to RTC devices.
 
-- 
2.42.0.582.g8ccd20d70d-goog


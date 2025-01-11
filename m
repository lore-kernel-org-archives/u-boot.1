Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40735E77188
	for <u-boot@archiver.kernel.org>; Sat, 11 Jan 2025 00:03:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 810288061B;
	Sat, 11 Jan 2025 01:01:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="L1zHR+Hj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DFFAB8067D; Sat, 11 Jan 2025 01:01:36 +0100 (CET)
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com
 [IPv6:2607:f8b0:4864:20::d2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4114A8071F
 for <u-boot@lists.denx.de>; Sat, 11 Jan 2025 01:01:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2c.google.com with SMTP id
 ca18e2360f4ac-844e1eb50e2so85578339f.0
 for <u-boot@lists.denx.de>; Fri, 10 Jan 2025 16:01:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736553692; x=1737158492; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=05oDa3rd73Sd61y5ErCw2hDVIcuFxQvmkw6lTP0K32k=;
 b=L1zHR+Hjrke4ESb6XcenT7WCHWQS09X4bshmKX3klDlnSAEaxXGvqLVYZZ39iIprV0
 mngeeGS80fo0C90J2tBaloWGq7GhPZdSxn10acP8FIeuZavckHurjhf7znihRe2cQJPf
 oTQ2uji2sYErHqQBH540tvBnIIGL9WdRHLFyo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736553692; x=1737158492;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=05oDa3rd73Sd61y5ErCw2hDVIcuFxQvmkw6lTP0K32k=;
 b=OXZ5qbk22jZmPMHqYfu98O290w/vQfC0H/zDDPQFCj+bA2DH7gmOrn2mDDsekl83rG
 bRb8/TEk4fSvcFEMd+hwiecR74A3W57BHbBsIuDr2Yubc0EL2ysrS4rkg7YEjXrrg9iA
 F2echF0O70nrJJlp/5w+Lw9GCArImZUUgWUnGod8SdROhe/PMXxp5Y6cnIzbmerEG5J2
 0RcAH5UldKqmcCiammcFdLGEh7AomwLoHcShBJk0A1YYlR+wlKH/1Q8A94uRuHiCzTDP
 Xs2PWvYUj+Gvl8PL8WQDE4ShBLQhkAycez9IHrxb6MrNajEgGib2i23y3D+8G5s8VGcZ
 rztg==
X-Gm-Message-State: AOJu0Yzmx2/VRu7BILGEXyCzhNIStH3RFDNDoiTpWc5YxNpc9s5RSeqn
 qF0GK9NU9uwKozwtjFTjzgdABc0nq7bjV0h+Fmtlexozomaeig/bviw8+wxpo+xcnlKjmIp5Dtc
 =
X-Gm-Gg: ASbGncvdZohaTsMfJHnbmbE5kFh2J3oxu785IoylpT3DQfsZW1lzjgHWzV+C8XEhC8U
 pftcyJvIWi7EROTIJHgLMblIcRrIjaSZq+eagegvqYhaudTeD8y0yt0ATwNZcwlqtlIuM/OR5Br
 M4SLv9sqnBFrtY1vl0dclYkrIT8gEAXJUPnsfrQ7G9SO97e0/TrR39CN36gLBaDdmBb0oWD71BQ
 EgHMvVjkY21UNXPTgK4rOOEwr11X5Hq7pJFaaO8dM/B6BBO9rNhQZPQwBCMoxBmpC3Ud9vZTUBk
 omVdNmvpFpIsPzWqJA==
X-Google-Smtp-Source: AGHT+IEfJLjSJj2nlrAhG8Q13U7rolZ0FH5Rcrk1o1bd8Mhmbbqql2oCU/sgKt9rPoJaDa3/tKe6bQ==
X-Received: by 2002:a05:6602:4010:b0:807:f0fb:1192 with SMTP id
 ca18e2360f4ac-84ce0048b10mr1129811839f.1.1736553692489; 
 Fri, 10 Jan 2025 16:01:32 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ea1b5f93desm1171884173.14.2025.01.10.16.01.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jan 2025 16:01:31 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 19/30] x86: Create more space for SPL with qemu-x86_64
Date: Fri, 10 Jan 2025 17:00:18 -0700
Message-Id: <20250111000029.245022-20-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250111000029.245022-1-sjg@chromium.org>
References: <20250111000029.245022-1-sjg@chromium.org>
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

The space here is quite tight and there is plenty of room in the ROM.
Move SPL earlier to allow for expansion.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 configs/qemu-x86_64_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configs/qemu-x86_64_defconfig b/configs/qemu-x86_64_defconfig
index 3c0fc7a34fe..39375c76227 100644
--- a/configs/qemu-x86_64_defconfig
+++ b/configs/qemu-x86_64_defconfig
@@ -7,7 +7,7 @@ CONFIG_MAX_CPUS=2
 CONFIG_SPL_DM_SPI=y
 CONFIG_DEFAULT_DEVICE_TREE="qemu-x86_i440fx"
 CONFIG_SPL_SYS_MALLOC_F_LEN=0x2000
-CONFIG_SPL_TEXT_BASE=0xfffd4000
+CONFIG_SPL_TEXT_BASE=0xfffd0000
 CONFIG_DEBUG_UART_BASE=0x3f8
 CONFIG_DEBUG_UART_CLOCK=1843200
 CONFIG_X86_RUN_64BIT=y
-- 
2.34.1


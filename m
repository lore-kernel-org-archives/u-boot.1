Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E221AC02181
	for <u-boot@archiver.kernel.org>; Sun, 26 Jan 2025 18:44:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D14880F84;
	Sun, 26 Jan 2025 19:43:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="g4vOKPrm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B983480FA1; Sun, 26 Jan 2025 19:43:50 +0100 (CET)
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com
 [IPv6:2607:f8b0:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 93E1980F85
 for <u-boot@lists.denx.de>; Sun, 26 Jan 2025 19:43:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x131.google.com with SMTP id
 e9e14a558f8ab-3cf8e017abcso11288825ab.1
 for <u-boot@lists.denx.de>; Sun, 26 Jan 2025 10:43:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1737917027; x=1738521827; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uNqt0R4By1I/7ns2wue8MsHlxHf/r//P5uiFmlzsvtM=;
 b=g4vOKPrm+VreUKVfiei7ZDexDHfojvTObTXXIHLBNeilLhwoi7+NzQ5ZDpwW1GIMOU
 OHqunUAYmeLnfNWY0noeRdDPxk1pga7Ez1HMFKac7xOL0zjvlKMKklCVLr2JB8422Z7D
 G2cs/yjBIUXvbxXnrJoBFd88bjK6aBt0OHF0A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737917027; x=1738521827;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uNqt0R4By1I/7ns2wue8MsHlxHf/r//P5uiFmlzsvtM=;
 b=d1VFs1wbmrqgnw7WMG3BgLH+SXGZ2Y5tLcQnerngzmPLJtMMsgaIQ9RTXKCl/F8Sfo
 YN29ME1tWseESq4AkagG2dQHFTSCTnP+upERRXLG2dHkSvJm3wu+3cnVpwCwPtsSDzi7
 56goVC7ZT1w90KmbHU0kuanhwKgHmUnuSyeApMNy9Vmwj8VjE3xHngzv7gtvlGr344Vd
 2SCMrCCbznmklhH1rL1EV4Y5iqBWuqtiuvOCm0KLQsCjmkNTcCnQF4ZXWz7JGGtqX/md
 mUk9LIym1V2BzkQpdjm1wn/iyvSnrY8ARS8OoeKQsBzqYeOOy4PRffaCvW99jY5RRNdH
 ED6Q==
X-Gm-Message-State: AOJu0Yy/IU8svosRe656CgFgHCXVoNtGMQp8QkTd6B4LFMwF52iI2iwI
 aVD+74rG7r+DSXHFsjA+GBf54P8WWMHa0t6FAZtxxg2ykQuakiOWKOVMbzFYzZcJjBgXspfwOa0
 =
X-Gm-Gg: ASbGnctzAHfbVtROnrA0DFwhmq8LK+L8D+nSoTXC84tL83PXE1BxNRDKngD1FcPfAGR
 +3fCwFfl+ysV0wD7Lwp/6ngEWzjvnM2AGxDCDTH0ACxqmt9nPSJgX3b93KToMJClMGOtI5xf6CB
 qBgs1LGKFIyM1m6lsM0ixnEm/oK1n81DyjXB1ZE1zTmx9NuCvOYetVGB6+RshxRinNOpU0BMkMZ
 q9ixPkdFzcDPtauXCpyaRgZHTrG+EdblO4SB0xTO3/pPCIahiTmvoGxxixFCx936exQOQ0wdJwr
 ZGb4viyF6aS7i7+5B/Vs13n933T+fqDZOI1Y2OXoOw==
X-Google-Smtp-Source: AGHT+IGEFwcOGAqDMj+SHushBC4Ivp59N03UR7eWqH8NFWS2Mvr4hHc04q5oJZwfZpbnnU+mXByQnA==
X-Received: by 2002:a05:6e02:fc4:b0:3cf:c27e:4fa6 with SMTP id
 e9e14a558f8ab-3cfc27e51a3mr73054815ab.10.1737917026832; 
 Sun, 26 Jan 2025 10:43:46 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ec1da317fesm2160641173.42.2025.01.26.10.43.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Jan 2025 10:43:46 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 02/19] sandbox: Update sandbox_vpl to select sha1 and sha256
Date: Sun, 26 Jan 2025 11:43:12 -0700
Message-ID: <20250126184333.4058848-3-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250126184333.4058848-1-sjg@chromium.org>
References: <20250126184333.4058848-1-sjg@chromium.org>
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

These algorithms are used in VPL, so enable them.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 configs/sandbox_vpl_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configs/sandbox_vpl_defconfig b/configs/sandbox_vpl_defconfig
index 46329395ba5..f0315f6ab33 100644
--- a/configs/sandbox_vpl_defconfig
+++ b/configs/sandbox_vpl_defconfig
@@ -252,6 +252,8 @@ CONFIG_FS_CBFS=y
 CONFIG_FS_CRAMFS=y
 # CONFIG_SPL_USE_TINY_PRINTF is not set
 CONFIG_CMD_DHRYSTONE=y
+CONFIG_VPL_SHA1_LEGACY=y
+CONFIG_VPL_SHA256_LEGACY=y
 CONFIG_RSA_VERIFY_WITH_PKEY=y
 CONFIG_TPM=y
 CONFIG_ZSTD=y
-- 
2.43.0


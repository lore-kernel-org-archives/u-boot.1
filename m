Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36B4CFEE4F7
	for <u-boot@archiver.kernel.org>; Sat, 28 Feb 2026 20:21:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 898E483F37;
	Sat, 28 Feb 2026 21:20:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Y5EVB+di";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A2BB483EC6; Sat, 28 Feb 2026 21:20:37 +0100 (CET)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 92E1083F37
 for <u-boot@lists.denx.de>; Sat, 28 Feb 2026 21:20:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-7d596a96475so1297573a34.3
 for <u-boot@lists.denx.de>; Sat, 28 Feb 2026 12:20:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1772310033; x=1772914833; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0C5ahpHfXp68zDYONpniP6r1smUudkhUaHBPQMDhUCk=;
 b=Y5EVB+dihOCGzWIpCoEbBTT9wRIOKy30a9ftxV3nFZQPWPrrc/0oH09qneItHbOO8i
 AA3Kc5v78ssbVagj+awCigXe8wEcM1im6rsECyWFHiepc5qVi5GG1KouA9wVB9Fb/GKh
 fTm8CnjCfPpYNRPIJTYzM6EEqTOh6sanWbe9w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772310033; x=1772914833;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0C5ahpHfXp68zDYONpniP6r1smUudkhUaHBPQMDhUCk=;
 b=LUNsh/xQhJ6Duy7roJSG1OAUOSGb4nPqwd/pMRgvFd1Xn7GprL+nKYxvM7Nneq0iel
 BU8sOkMey1S57XKRbDgsReAyvnTOJgCOaHiXj5stg8c8YmBwS/66SkZ9a4u3RI7rvPwU
 8yKKPz6EYp6L642rgiUmjC6lA3Si6SZC0GcifKWWvEgJydj6e6pXZ6B0O1Xs5sLhVPH9
 67ET9BaZcCu0BC06N+o3gmY9l+AVOlvWq2Adf8T5/28kG0oqmJeqY8KYtT+mmcezt6Wv
 9gwxA2FCUKeRjj+l0J6qV18jP5D8fNVyDZCnZWr5Kw2Q3rxWxAYuQZkptN4OE5oFCtvT
 qaEw==
X-Gm-Message-State: AOJu0YyO5HwR8OfG3Sii3hHWj2ks8tl8DuxLRmZrp0g098/BDM/YJMle
 7/wB516OLhox/143WGdUrcqO77+i+NzaMDulrzZkMAAVbf5RmivRFbnZ8dBt1YBQxdIDXVK+IDI
 xksU=
X-Gm-Gg: ATEYQzyebZz/GSafKkNGfTxQRxjAghIAnAkfGLgm9GSuEInTVP9mwzUF5krWvfH27zO
 QGHek4a1PG/a3OtXE/Vn5uXJ4WPFePf8wvZ6oCPbUDTjgT2xIbgpjoV22CAx8M2pzPUGLPVNJdf
 nu3tPFsTUlLryry+Dw0slDEWX85zR64LU9qtVNi4BW6vefnN13tyALmVBPnBnWZY6aG+QIH3Ec9
 J1QTkQNoAw5daAl+HDVXwYZACZLnQWogUKnlpTEx/nvl6SESGxkFafCUOmvPhFjKSIncyFIEBeV
 FG/lsKiPx6fhR3QcjJXbkL7y4dW8KRkRMWHt2ZHloyQQDKs6ml6N0nnh2dWX4QLKun5TNvb+Hs9
 yKqy3mHf2TS8XWC7fFvBXOey23LaHWauU6SIUfSontFJ1hT9gdU+qly2ohP2Wff/qafFJFw2Vmr
 ZJsrr4TmUR/rQByOkKKA==
X-Received: by 2002:a05:6830:82aa:b0:7d1:569d:ce7b with SMTP id
 46e09a7af769-7d591c0aa89mr3558589a34.29.1772310033278; 
 Sat, 28 Feb 2026 12:20:33 -0800 (PST)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d58644edfbsm6978361a34.6.2026.02.28.12.20.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Feb 2026 12:20:32 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <simon.glass@canonical.com>,
 Aristo Chen <jj251510319013@gmail.com>, Benjamin ROBIN <dev@benjarobin.fr>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>,
 =?UTF-8?q?=E7=89=9B=20=E5=BF=97=E5=AE=8F?= <Zone.Niuzh@hotmail.com>
Subject: [PATCH v3 07/17] bootm: Stash bootstage data in bootm_final()
Date: Sat, 28 Feb 2026 13:19:55 -0700
Message-ID: <20260228202011.1834493-8-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260228202011.1834493-1-sjg@chromium.org>
References: <20260228202011.1834493-1-sjg@chromium.org>
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

From: Simon Glass <simon.glass@canonical.com>

ARM stashes bootstage data to a known memory location before booting,
so the kernel can pick it up. Add this to bootm_final() so all
architectures benefit from it.

The bootstage_stash_default() function is a no-op when bootstage or
stashing is disabled.

Signed-off-by: Simon Glass <simon.glass@canonical.com>

---

Changes in v3:
- Add new patch for bootstage stashing, needed for ARM conversion

 boot/bootm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/boot/bootm.c b/boot/bootm.c
index ac521094db7..b9b9f5ea82f 100644
--- a/boot/bootm.c
+++ b/boot/bootm.c
@@ -1203,6 +1203,7 @@ void bootm_final(enum bootm_final_t flags)
 
 	if (IS_ENABLED(CONFIG_BOOTSTAGE_FDT) && IS_ENABLED(CONFIG_CMD_FDT))
 		bootstage_fdt_add_report();
+	bootstage_stash_default();
 	if (IS_ENABLED(CONFIG_BOOTSTAGE_REPORT))
 		bootstage_report();
 
-- 
2.43.0


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0F80C36002
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 14:55:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7ABE781F6B;
	Wed, 19 Mar 2025 15:55:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="aleTUdX5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 181C981E60; Wed, 19 Mar 2025 15:55:33 +0100 (CET)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0830281E60
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 15:55:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4394a0c65fcso42231335e9.1
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 07:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1742396130; x=1743000930; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Xywt3qt3t3Y6cWqQZU8izDQAM5nS6dWhB7h7EWCb32Q=;
 b=aleTUdX5UuoykUsHoCoSdqiyeePpZ3EP2mWAu8uJ5iiwRnPKu1Xe1ecMc8xzaHI+9W
 9+NKCkF7+XLjQ+IY75YCZEbAiQU8XKEA2UehabIfQR6vWp5Of84KfM+t+6Bdr9F1nQMd
 RXM5ZnA/eSrcMLIeIWgWZx6URsRo4/ctf/yuI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742396130; x=1743000930;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Xywt3qt3t3Y6cWqQZU8izDQAM5nS6dWhB7h7EWCb32Q=;
 b=w/meTgmDpfabsbmynx+0sBfkL/+XwajG0dK2jkFzjMdUZJP6NpH1X64pMgTQNFgbeX
 m4HIA6K+spoeg3Fz2n7r+Ljm9IOYDXw8DJITGTJ8vuUqP3RuLlXlUnKcWaSPg1dKfTiV
 K9WnQ+LtCMBQRrcVOucgUfm+B2VvUjuwkN40GfZSPfC2Oe+9Bky5aLV5OHRM/GvevYRs
 Ve6HwS1IeqFtMufKL5NYyi4cRv6qqVM3leM0k4hi0GaVSZjvEvBwaz0YhoSS+zZzkQ3I
 zZQ4zt5+r/grsy83uvIc0JM2KvvhQee3o/TFE1U5i0gdkb7wsEFsTrRMZ+k3uAbdYPPM
 tzoA==
X-Gm-Message-State: AOJu0YzF0n0zevp92UM7c1Xh5IPrEs3xGjO+shvY/NowSvno2DTLOt9b
 kFrQs2eB/UIofRh0B6QXxpKhd0RQ06OP+BqUZDQlQIhHHTm18jSAc9fksNsVHtxXrlncpmNNMDA
 =
X-Gm-Gg: ASbGncug+Zy/d2Jar5pfj8rEAQrqwBmZNTgBPM4SQWR13D2l0yEaD+9LietHJkZgCRV
 0hZ/LTZqyvp28hJEqRkEDALDdU5/zwMvh1cQ5b8XXVczPF3MSQmVnJL37vfbBkApnKdroDg8xcd
 B9rqO+eT7Aaurl5GnYIK6GknGcsIK7iMTl7GW0356zxDC2CNJ5ahc/CKB2gdp/nyyEf8rkCWiRy
 PqHdX9siFyp+OWXT88d5Lsf8+aO8nuLfDR3/RVvvkeufeLAhZEl6Dv0vyOpti9BiN7q7+pafTZr
 SpxU5QGswUBrXcAAZhybwl8yxU4BckgwwxZXq4jMno9k4VQAs/K6
X-Google-Smtp-Source: AGHT+IFFCoLqeoxvM/GWo5yE4KCPRvjWN9bIDVchj+U73ehs1lsRRKKlprSqFM8reAGTBnvcr3B8Ew==
X-Received: by 2002:a05:600c:a54:b0:43c:fa52:7d2d with SMTP id
 5b1f17b1804b1-43d43855435mr27131865e9.20.1742396129880; 
 Wed, 19 Mar 2025 07:55:29 -0700 (PDT)
Received: from chromium.org ([169.155.233.10])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d440ed786sm20891315e9.38.2025.03.19.07.55.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Mar 2025 07:55:29 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Caleb Connolly <caleb.connolly@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 02/52] sandbox: Select white-on-black
Date: Wed, 19 Mar 2025 15:54:07 +0100
Message-ID: <20250319145512.2391122-3-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250319145512.2391122-1-sjg@chromium.org>
References: <20250319145512.2391122-1-sjg@chromium.org>
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

Use white on black for the expo menu as it is easier on the eyes.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 arch/sandbox/dts/test.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/sandbox/dts/test.dts b/arch/sandbox/dts/test.dts
index caec8c8fd01..2087c91285c 100644
--- a/arch/sandbox/dts/test.dts
+++ b/arch/sandbox/dts/test.dts
@@ -130,6 +130,7 @@
 			font-size = <30>;
 			menu-inset = <3>;
 			menuitem-gap-y = <1>;
+			white-on-black;
 		};
 
 		cedit-theme {
-- 
2.43.0


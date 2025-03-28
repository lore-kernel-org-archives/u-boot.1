Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 996C9C28B20
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 13:07:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7DA1681E6C;
	Fri, 28 Mar 2025 14:07:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jVDh9mmF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DDD6C81E5A; Fri, 28 Mar 2025 14:07:27 +0100 (CET)
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com
 [IPv6:2607:f8b0:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 79D2C81DCC
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 14:07:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12b.google.com with SMTP id
 e9e14a558f8ab-3d57143ee39so18655845ab.1
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 06:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743167243; x=1743772043; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YoOVsigCLlaoRTBOde1EyGWEv51cbWXlW0oyV9m1/sM=;
 b=jVDh9mmFjipzpmuHuy/8ZgFhr7XKPGhx6N0x0LJCQIuuTyNqxbNT2rccUwoKFtqYFd
 gnmp1xBPJUu/QJYeOxZ79Y57as9FR3vmV/RJJOBGRqrgTfIOdLcoTFyHGPKSoTYgDPsR
 8sBebPUp82YI+1t2nzlSW9q2i0nfFW2WRTP+Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743167243; x=1743772043;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YoOVsigCLlaoRTBOde1EyGWEv51cbWXlW0oyV9m1/sM=;
 b=UcDmm9cG2vRj4Aw9Pm4YuimPKgkTCcBXFJTlK3K765e+UEAy6wfKfwBO87jHpIjx1M
 PN75wNogVd+bW4dkFgTtjXojPwDWGd65S3WqRfbIccez4ZiAxr6crsYO645Hkr1iiyxs
 w3k+tsh2GZhuQa9ovdaCD9oKGnX0DdcSy8Cygzc2KXguIWbpb1vyJPdowywgjcx/K+qp
 fpFQAo/8huYsQn4UHUCq2Fgf1CEcwfJzSxmgB6PGTe8CtYxHOSONfe/0OoUoEcw55SQp
 3ASlH4jQWqfpMlNNFzewdTcnKxLqrHiVeTQ1BjZj6p+5mfWPPgFEqSJLafSPZYdJSDlx
 NNqA==
X-Gm-Message-State: AOJu0Yzss6BDGCk53SMyDeYZxCts1/og1rMv2rIeBjzBeGALotfkTe+G
 Fh9RVR7SFm9BUATn6rC/ABn8nedZ6DUDHbrhV3B0pXJVG9N4iywsBUIdaaltfoUa4xeYifec89M
 =
X-Gm-Gg: ASbGncuAXpHNEdVNAIoCq3FSjN5ts5zLCjA8BgB/dBXp1JMxsSVDWEDZIBoAZ+LKW9K
 yY7rpVirxqVf3Oahm27CIiTjx5OR0qrWLhsfvi2LONn0Gl/f2cNF7YpUWGNvxyIPe2lGQTkocZF
 1zVaZE9MbrtBeDNN3Kj27GA3SwCBpnqUE2GHRaIGApELUk1+S1lGe6DQB0QoEOACYMAYdulqTuE
 4qn/9+cTN30e5qviwJL7NmB3m6nhNmApd9vD9yx7IbTCdITcdfDYwSfMADrtQDfKaL6DqtXx0B9
 CUS/bsE9Xw73IL+KssxMrBPU0udHytIzZgvNvmbl9tjzdOacPGg9+Fo0N3oohcWMlcbj43gVqtX
 1vJ7IdA==
X-Google-Smtp-Source: AGHT+IEMyhfTnXpSC6sx2LVIDHyCA6QWzV3u1UcVF/F0CwxAHz3LHDDAK/O5ATF9UOh9yZAGX0FCZA==
X-Received: by 2002:a05:6e02:1a43:b0:3d4:3aba:e5ce with SMTP id
 e9e14a558f8ab-3d5cce2bb5cmr90725305ab.20.1743167243560; 
 Fri, 28 Mar 2025 06:07:23 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f46477dd4dsm430526173.69.2025.03.28.06.07.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Mar 2025 06:07:22 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Caleb Connolly <caleb.connolly@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 02/56] sandbox: Select white-on-black
Date: Fri, 28 Mar 2025 07:05:49 -0600
Message-ID: <20250328130713.2612648-3-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250328130713.2612648-1-sjg@chromium.org>
References: <20250328130713.2612648-1-sjg@chromium.org>
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

(no changes since v1)

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


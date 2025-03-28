Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B9DCC36011
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 15:37:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 88B9981F95;
	Fri, 28 Mar 2025 16:36:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ddcZXt8v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 45D6C809A5; Fri, 28 Mar 2025 16:36:13 +0100 (CET)
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com
 [IPv6:2607:f8b0:4864:20::d2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F22B82012
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 16:36:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-85b4277d0fbso73556639f.0
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 08:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743176169; x=1743780969; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FIlANLzxMQZqyBZhIOqVA4mz4ACxUMJ9VJOYM7xnB+w=;
 b=ddcZXt8vlakD8BDPgWL+xz4b6JZkZ7ZpMe8ttTDBasc5R7r0aTku7hYHywP3aaUB2x
 0aKJZpwHviUInWcZOspUm78SKyXdlbZuH0gndaZKr1KC7so41NbmEmRHR30khCMI1Y+m
 m6hzzoza00Hz0jY4jJSPFeOAQxeLec6j4QfUk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743176169; x=1743780969;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FIlANLzxMQZqyBZhIOqVA4mz4ACxUMJ9VJOYM7xnB+w=;
 b=RrYzlwW8+82YlqvAs6ZhLG0eMohmsXur5NenqqrfVhPfinhtb7uTxpfT/M6FDIYNEU
 y31P5A+utwdguMftkHHb26HScfLyGVn2m6TrAxBm2RT9s61cm1OIRmkX1l3mGaZ2Xxag
 7WukWF1E/PATUPeB36BqaFMS3ynkCXVtmXGKU34LjKxqcU65T3MzUXr6GRHADA0bgEfK
 Gj+RNWJbSgJKWrjTjIpxhDT7Ln+J6+7qp77wPLJgtAWxMRR3M6cMSrh31K36a0W7PWUP
 Vnb5I8mgxdVf13Y7xYRM9yq8fJvFeTG8Gqs6Ef0Mu8PkDDVT1ACle5DxsgID4LUliuxe
 d0/w==
X-Gm-Message-State: AOJu0YwqolHoZcp5L0YnU59Fu3iInvHpgU0Perf6aM9CzyFms+T8tE1d
 GINRVsIrgLIAxcnmmzS3aFaXgUKeBGisRTrlCwCaZDB0kvYzMVpWlp2SHEBSCX5NZDdo/F6yQwg
 =
X-Gm-Gg: ASbGncv8Y9Qv7pDTguJ1eAMc3YAWpI90sWPbqjzKKEOjMQPEQaXvyxW39s7APtLH8s4
 WqemIyzeI9ZEre0BuAiGtIlQSVtQozF5RTuBy/N1dSWN6s+0eJS7D0Qo28oq+Ie9cP3mHTFDuCw
 o0MwT1UB9QB/hkiMs94g6hT1XSmeDfH3//jX3ASC+dA954jdYyi72PsPf0ysUyvDYIMbHbN+erh
 3+kW01jZHeotXTV3L8uQAQVVyH7NaELpSmDbYSTHbqA9L8X/AKw8TQrrZ1B8v628Molgc9J1ts7
 Keq1E+hKQ1Ux7WCr3LfasK8u75YZPet3n5AJ6dVx52u9r3ccWECLHFU1ysPFgb4yYOLRxI1taPw
 hdUuF1Q==
X-Google-Smtp-Source: AGHT+IHUH99YtOCfEP5b5+I0AF8jXcha+3ruwso7JqUauk/mBbdg5rMKkN/YBeIsfQGp7LRQG0/p8A==
X-Received: by 2002:a05:6602:3e89:b0:85b:4319:2a2a with SMTP id
 ca18e2360f4ac-85e8205cda4mr888895539f.6.1743176168584; 
 Fri, 28 Mar 2025 08:36:08 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f4648714b4sm484922173.87.2025.03.28.08.36.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Mar 2025 08:36:07 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Jonas Karlman <jonas@kwiboo.se>,
 Jeffy Chen <jeffy.chen@rock-chips.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 huang lin <hl@rock-chips.com>
Subject: [PATCH v3 14/31] rockchip: Include a compatible string in each
 configuration
Date: Fri, 28 Mar 2025 09:34:54 -0600
Message-ID: <20250328153522.3555472-15-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250328153522.3555472-1-sjg@chromium.org>
References: <20250328153522.3555472-1-sjg@chromium.org>
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

Provide a compatible string so that U-Boot can decide which
configuration to use.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Jonas Karlman <jonas@kwiboo.se>
---

(no changes since v1)

 arch/arm/dts/rockchip-u-boot.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/dts/rockchip-u-boot.dtsi b/arch/arm/dts/rockchip-u-boot.dtsi
index 85a89e3a596..ef1f24fe29c 100644
--- a/arch/arm/dts/rockchip-u-boot.dtsi
+++ b/arch/arm/dts/rockchip-u-boot.dtsi
@@ -149,6 +149,7 @@
 				fit,firmware = "op-tee", "u-boot";
 #endif
 				fit,loadables;
+				fit,compatible;
 			};
 		};
 	};
-- 
2.43.0


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E646C02196
	for <u-boot@archiver.kernel.org>; Wed,  5 Feb 2025 02:00:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E406A807EE;
	Wed,  5 Feb 2025 02:58:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Komij5zj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3542180AE1; Wed,  5 Feb 2025 02:57:56 +0100 (CET)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6C9D38070F
 for <u-boot@lists.denx.de>; Wed,  5 Feb 2025 02:57:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-71e15d9629bso1801928a34.1
 for <u-boot@lists.denx.de>; Tue, 04 Feb 2025 17:57:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1738720670; x=1739325470; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7NqFlYX6AXv/hailO8O2jPAWQiUMJ4tDzV8lHJKLwWQ=;
 b=Komij5zjp2T9/Unw1fW1RLS+L8lFzDywAI1v7P+tL+QFa6KG9tykLjtTV0ZI7DT9nS
 RW9218Hqy/25g2LtFwp6Pk2XMK4WeAZ1m9s79O1HVRw1r9utVOaDwiXpoHq/Ya01NGDh
 R0LWR6lHK2TRLbG2lPESVKBZ/+xbAmrF9IpTo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738720670; x=1739325470;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7NqFlYX6AXv/hailO8O2jPAWQiUMJ4tDzV8lHJKLwWQ=;
 b=FUP3AO51X1oL6EcKyXG/7AjkqAWYKv94+Qo3YFFzkLXdOUQTqrfRSU6N5I/IXoK6/F
 8TN1PRAS/abk5f2cGl4WRKqEb4RvdZOk1RrEZLOE7rv0wC6Ah6HyHlhUOddTEHyi4R0U
 ZfkmPJgXbi3So8zoTAHtUquLUS9vnWZVR5inmISNBoOumKMsWovHvsK/A39f6SzMf3mG
 LlzC/AzFAtAl0kz1H7YCkGI+YDbZDPR/f8NewiYFbbiA/VIwpQ4M8Uze+3pBk4OIFBE3
 0BgwejJoNM2bI2PKpd1/Ipz02wnjaey/iumEycrtUANc3pXb47BqQJZkrto5/3sYUpeJ
 PVrg==
X-Gm-Message-State: AOJu0Yxwp83hy4N/w4sg2VgMQmt4VfT4Z+vFV397OCNvg3/Z4PR1OTLa
 cNs7LqMsaJIU+rzi3W5ZoJoG4o9m71juSSs0YLV3N1oLhfhiepHZliVED0xoNY/5aCfV8TH9yZ0
 =
X-Gm-Gg: ASbGncujhP95bqXh2S9YyHHLOdHEwbIq59RG3ddTwlUUSLExPVAsXmWCFXXOVaYjKfw
 dckfZ3PkyB8GwB6ptl7UI6XcshfQrRhmubL21E+siTULgVe98MFwWuJfY4mESlv+wB4poNkU8lk
 Kp1VXNZXFf5oe0MVSPAAOSSUW/zs3J4KKOC1k6Xdw1CVdDe9pPCVu3KyxZtIFs/GMHOHH3/LipQ
 NowT+3VKLGRCkwwQWg2ZhZogMiosAtDJurav6Pk7fq6r3jpi/yn7WFY+ek2xDPigYeIPbKllRj+
 2arpKGs4itsw4qBzbKNSUA7V89qYiDnR93Nfr5IPA/vam8dZGnbZ
X-Google-Smtp-Source: AGHT+IFgyPsuerq7A/3sy2zUqmpodihGSABE4fuKX9Ta/wsZSPYdcfO9+iiCqcpPCIQu7SkcSXi7Aw==
X-Received: by 2002:a05:6830:6303:b0:71e:57b5:2251 with SMTP id
 46e09a7af769-726a4174bfdmr871233a34.11.1738720670702; 
 Tue, 04 Feb 2025 17:57:50 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5fc104c2e7asm3543676eaf.12.2025.02.04.17.57.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Feb 2025 17:57:49 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH 27/29] gitlab: Add an VBE board to the sjg lab
Date: Tue,  4 Feb 2025 18:55:17 -0700
Message-ID: <20250205015606.2686149-28-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250205015606.2686149-1-sjg@chromium.org>
References: <20250205015606.2686149-1-sjg@chromium.org>
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

Add a rockchip rk3399 board which runs Verified Boot for Embedded.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 .gitlab-ci.yml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 3487ad7e579..813db4df98c 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -740,3 +740,9 @@ rpi5:
   variables:
     ROLE: rpi5
   <<: *lab_dfn
+
+# Firefly-RK3399 board running the rk3399-generic build
+vbe:
+  variables:
+    ROLE: vbe
+  <<: *lab_dfn
-- 
2.43.0


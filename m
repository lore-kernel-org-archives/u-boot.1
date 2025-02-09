Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AC51C0219B
	for <u-boot@archiver.kernel.org>; Sun,  9 Feb 2025 21:17:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C10CE80D1C;
	Sun,  9 Feb 2025 22:16:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fMHQnFMe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B416380CB0; Sun,  9 Feb 2025 22:16:10 +0100 (CET)
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com
 [IPv6:2607:f8b0:4864:20::d34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9118180EB5
 for <u-boot@lists.denx.de>; Sun,  9 Feb 2025 22:16:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd34.google.com with SMTP id
 ca18e2360f4ac-844dfe4b136so91175939f.3
 for <u-boot@lists.denx.de>; Sun, 09 Feb 2025 13:16:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739135767; x=1739740567; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R3kTS64BF0g06j9HlaVZX3pHvOCwxNqQOjtATLkP+/Q=;
 b=fMHQnFMe35+9U96W1/T7WlPH+xSALvjv7Vh+AcunDEDkL6PaiPlKIhyyH0t0NsFWje
 /y46OWLBXf0ws2vwO5Q7Huhr+WdTR/8eegBqrYSRXqpYQ4Z8jqZQ0OO0ZvdlBTiC2Spz
 G3qCzCasvK1VE2YODHEhD/mQe9aVjFfRujlsE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739135767; x=1739740567;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R3kTS64BF0g06j9HlaVZX3pHvOCwxNqQOjtATLkP+/Q=;
 b=iCKp8IMGGO70kBT4QiyzmjYuhlWsi4ifDAd9YLdxSpQ1Klo1rhy1+NiBLmHRveqIuW
 UT5Q8yifTRUfBeSHoc4bQztxtydVzo6l/DN1DhcWNSP3CVdShG806cFQIshCvf5XCQQx
 fup9v4Eax1kh5CgoxiYDaI4P7uZ2kJ7BihnMsbAXl5WUSDtgr9YovK7+d6J21D8MKORR
 q/Z2VOuKOlXdzCcq6v/B9IvdBJec3X6XaFzMdezsZfp7cGLRGxnep2h+eeyjCtDfSFyF
 WHlN2KN0vB2LUT6OtcX5gLZqtPElaQiFrYEvVQ/WkIoENyT6c7+3R47xul1jQkS8qTnu
 6eHQ==
X-Gm-Message-State: AOJu0Yzp9lnbMnQKZZd4yFvZr0VO2BIm5gQEGXsVttdJsEW2Z6JF3wIg
 rtwVfz/qril6vEdanU9BwfqRBTnwGpUuGnwWKzLGkWAcA0qBHuy162nbbnmDZ7BGTa2ArWO+MiY
 =
X-Gm-Gg: ASbGncsRt4KkB4oaPz+zI8v0NXQgEhN05rWW9xhSub/Va6lgquXAc9YUiaBKP/0RYIw
 /0WAg149Clx6US1Rt2hb9N3vDlkSmoWgfZ7uIkzmt/ukbFxTtfP9e6wD0z+3sSmbM0ZRPOV/liv
 TEjxQNK/3rcvIvlQqgF3O7bGEfrSA4yNxRO/fqARpGujdWtdSfyDQPSNKJUjrAVDQzhimEKZLuo
 vtObmwlxlJvDjpW0iOPgZ8z/fEH8BO0odt4LwBPYh5xLf36UDI4OcFgnH8wr9vUxPiNdPYxZAfw
 Y+AwasGNTcN+KHtYZAH5tXiobvrwcOrUCP+iTxUv6uaPyuphgaOR
X-Google-Smtp-Source: AGHT+IGRuhv2CpSNpc3UAvE1t5OmHMRC5BIhwse9VeMc+TtiwvgdBB7pQbjFxqzWrobPRkLymjngmQ==
X-Received: by 2002:a92:cd8c:0:b0:3cf:f844:68eb with SMTP id
 e9e14a558f8ab-3d13dd2c3f7mr86454225ab.4.1739135766825; 
 Sun, 09 Feb 2025 13:16:06 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3d05e96f245sm18978655ab.51.2025.02.09.13.16.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Feb 2025 13:16:06 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Jeffy Chen <jeffy.chen@rock-chips.com>,
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 huang lin <hl@rock-chips.com>
Subject: [PATCH v2 18/35] rockchip: Include a compatible string in each
 configuration
Date: Sun,  9 Feb 2025 14:14:39 -0700
Message-ID: <20250209211502.2299245-19-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250209211502.2299245-1-sjg@chromium.org>
References: <20250209211502.2299245-1-sjg@chromium.org>
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
---

(no changes since v1)

 arch/arm/dts/rockchip-u-boot.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/dts/rockchip-u-boot.dtsi b/arch/arm/dts/rockchip-u-boot.dtsi
index 10563e273a9..c2a795957fb 100644
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


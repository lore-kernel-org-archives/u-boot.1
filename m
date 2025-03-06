Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CA31C19F32
	for <u-boot@archiver.kernel.org>; Thu,  6 Mar 2025 00:32:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 432918197D;
	Thu,  6 Mar 2025 01:28:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="YWario++";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 868BE81974; Thu,  6 Mar 2025 01:28:24 +0100 (CET)
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com
 [IPv6:2607:f8b0:4864:20::d33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DDAB9819A2
 for <u-boot@lists.denx.de>; Thu,  6 Mar 2025 01:28:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd33.google.com with SMTP id
 ca18e2360f4ac-85adbdf335aso2991739f.2
 for <u-boot@lists.denx.de>; Wed, 05 Mar 2025 16:28:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1741220862; x=1741825662; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o9IDHyqaTFlPa27Vg0eg0XQEPBZnpUbpGDSuKwvL+7E=;
 b=YWario++ceQlUpQUg8qdgF9IW1zlsw5BEtZ6NGgUzIrYpcBDCOQKu8647IAkWM/JUW
 ZvK79rVqq2NPuVeCQWSCngZc2idjETRWbguph9mQJHegP3XZaXU1ZWzArV/Penzetuni
 BNbZZXQAkfm7dE+1etyYKN5Wzn/P38fk2U4iY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741220862; x=1741825662;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=o9IDHyqaTFlPa27Vg0eg0XQEPBZnpUbpGDSuKwvL+7E=;
 b=XPuGgkWzoRUL+xJxA5dYhnXJCl6ugP0Np4kHRYXjnGBiMxyQS6AJk2GDVP4Bm73cD5
 p1eSTriZ6JOaj+VmoU20Ry9X53622scYdyc6gB8jLctvNBXAlWyRA8uGR1/QDNRns/vh
 FbZ8eaY7Eeb478G91v2wYY7V4vES2Vvx608relRo4jUZUFW7DoHfu9PTuX3lkCjorwuX
 3rtXnFaR29bmRXGI9jbVP0QP9NcNYya3ATap5dVw+VTLLHWWVvZA2R1yg7UffU5oips/
 xIRZLymJmJ8jbxPowu3vGNgixwbzDGVUIA6/odozPXwZPN8obynKAcFJK3uAodWceooN
 NcjA==
X-Gm-Message-State: AOJu0Yw/XQgOnUahZ+MHHJHLbTBGsf+LbYIGvybJ1CZoGq4dkoyPlJkx
 +3NEy7WVoHhNE2526ErRMSwB3dT9qs8sbrEIlGHc6sw1NLij2lgtIQD9ebzxaXzPRj7dWTDTWc0
 =
X-Gm-Gg: ASbGncsx/A62fC7taAmCI3T/uEaO0uud8yYWAWzAU7wA+t4Bvojl/r+V85PoT6YLGmO
 w8Fa1EJcQwgDo0s0oWcSwonIN7iGPjpSd+HhLUwtWN/RP2m9+kUzMspVgYjC4r/kcZMllcF0vpi
 TuvQtH6NvlNMjj+qLd5i5dHoGZYG0g+scpX7csNlkI9QRTjyVvraNNk3xrbPrM76HbN5dZrCFCe
 xh3R7sEuuiRoeK5PWFYswx+LLmZ/YWd7WhMiQqyz3fcFFDsPzuuztYOBRz5rsuyMpY2mse6FwOz
 EMKRrVUISEE2Z6lEjpPJQ9/fj+HKLRL/dMJP4UEIyChjNXDOBa+NrjdnhwQS3JEX2kLMGGXzLA2
 ZAucx2w==
X-Google-Smtp-Source: AGHT+IH6XdOJ69/qFrSiZ33w3fuT6xjDKZs3aknt6RyoV1vJx45pezbn+juQB/sNKlyyYIVX8OAwXQ==
X-Received: by 2002:a05:6602:3687:b0:85a:eefe:42 with SMTP id
 ca18e2360f4ac-85aff877adamr682604939f.3.1741220861861; 
 Wed, 05 Mar 2025 16:27:41 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-85b11986869sm1106239f.1.2025.03.05.16.27.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Mar 2025 16:27:40 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH v5 28/29] net: Drop #ifdef in parse_args()
Date: Wed,  5 Mar 2025 17:25:22 -0700
Message-ID: <20250306002533.2380866-29-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250306002533.2380866-1-sjg@chromium.org>
References: <20250306002533.2380866-1-sjg@chromium.org>
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

Use IS_ENABLED() to avoid an extra build path.

Signed-off-by: Simon Glass <sjg@chromium.org>
Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---

(no changes since v1)

 cmd/net.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/cmd/net.c b/cmd/net.c
index f980448e0ef..6d1c6374f76 100644
--- a/cmd/net.c
+++ b/cmd/net.c
@@ -368,13 +368,13 @@ static int parse_args(enum proto_t proto, int argc, char *const argv[],
 		}
 		break;
 
-#ifdef CONFIG_CMD_TFTPPUT
 	case 4:
-		if (parse_addr_size(argv, addrp, sizep))
-			return 1;
-		*fnamep = argv[3];
-		break;
-#endif
+		if (IS_ENABLED(CONFIG_CMD_TFTPPUT)) {
+			if (parse_addr_size(argv, addrp, sizep))
+				return 1;
+			*fnamep = argv[3];
+			break;
+		}
 	default:
 		return 1;
 	}
-- 
2.43.0


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63D54C54F30
	for <u-boot@archiver.kernel.org>; Sat, 24 May 2025 15:41:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F3B283043;
	Sat, 24 May 2025 17:41:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="U2eWyW40";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 20C7C835C7; Sat, 24 May 2025 17:41:31 +0200 (CEST)
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com
 [IPv6:2607:f8b0:4864:20::d42])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F0B5683595
 for <u-boot@lists.denx.de>; Sat, 24 May 2025 17:41:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd42.google.com with SMTP id
 ca18e2360f4ac-85e1b1f08a5so18555139f.2
 for <u-boot@lists.denx.de>; Sat, 24 May 2025 08:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748101287; x=1748706087; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iriQ4MbN7o/oX4vmRp4DYhni7FkxkaodQEoxBU2NNtk=;
 b=U2eWyW40QAO2BXF1d7LzIIP1CYQqqHTEtgkT/pfTM61+q9lKwsECqV249Bff2B2NzB
 TgX/cSGP7nV4azk58PiCAbl2tz9HzgU1kh7/lJkoayYtnDEqnMPQnIGqvhMxCi7qZBFF
 lb3Vdg++WxKKYYH/aROTUSooJGObd1pBPaQ3w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748101287; x=1748706087;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iriQ4MbN7o/oX4vmRp4DYhni7FkxkaodQEoxBU2NNtk=;
 b=wCaJ48xr3UdxJPj01odCCBtnoNO0EagU4+N+j2WknVj02ntzP17kH2D7TZnzIgF/3e
 VLWqPyel2tL9a1TaLD80Svb4FFKE7Ffdck1/rTTej8ut9e32H/BRmzk4jLjdlB02moPo
 Brgo19zyYeR2dmDdhDEg08wY1pQZfWVq4XG0VbqG1q9fIO75CKP3WIz25doOJdtcksBC
 3/xCWrmVQtyVlJrIq00l15jU8sqTRUp67jHGQ2rGPjn/aRYoK0ELZoUL0l+McvnPxRG4
 +mn8NoWQOBJFyhiRVzPWA6mnkKs3/xj7yuVX1ZZ66OCeY/u3ufJh25fBTvx5IiGJtE2G
 r7DQ==
X-Gm-Message-State: AOJu0YzSeLkzmmolvfumlkEaUdmv9qetbpbbIbF/23OLm3IMZu2S5UPf
 oD0kibiNH/rDtdQl0/dvuEeFT9gvANJMuPTtmCxVB4Sl8s6gCqO4qK/1w1rUJNBDMMAoxK8kUkp
 fnUVnch5bgns=
X-Gm-Gg: ASbGncvHqv8/Px57jsEx2jPUGOsNVqnY5/3rIa0JLnIS2dGxY9LzwliaHdEHB2Gk7BW
 dNBgAQJCkWOTDZqP1JoU7NijXlSy5NED8laynTpdHODIPgoxFISwPYOmFManZnH745SZqhQJeOk
 DKRZ19nbopFV/hzimoKWRwyZtzyfDxZUsgw9DMaCj++qxtFkoAMooDFLvmbj1NfiJoLDSIbqD8R
 F4aWDp8Ah7C0AsCoMBDohy3YpD4jXoj45BYGbHdr91bNpy03VwSB+aH94Qt0rIQOBxi9y+Gygdl
 RR8vUOsxWoUmb7aDcuYEaPP6zC+hG7S6OLzJmHmPpJBJ0oJmY6nmfSUAqByG396Bz6Gl9Vd0IIa
 XBM49YY3QIKkD
X-Google-Smtp-Source: AGHT+IFmf9YRW0LFw7OsCpIhmzFNs66Jf/XuxRhDnYs9fudFNTShgsfKRefOIFTHEJNA4NN+x8H0bQ==
X-Received: by 2002:a05:6602:6a95:b0:861:7d39:d4d3 with SMTP id
 ca18e2360f4ac-86cbb7b2859mr336289239f.3.1748101287161; 
 Sat, 24 May 2025 08:41:27 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4fbcc4b1543sm4040779173.121.2025.05.24.08.41.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 May 2025 08:41:25 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Guillaume La Roque <glaroque@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Julien Masson <jmasson@baylibre.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 3/6] bootstd: Indicate refresh need with bootflow_menu_poll()
Date: Sat, 24 May 2025 09:41:09 -0600
Message-ID: <20250524154117.1217190-3-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250524154117.1217190-1-sjg@chromium.org>
References: <20250524154117.1217190-1-sjg@chromium.org>
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

When the user presses 'up' when on the top menu item, it is a waste of
time to refresh since nothing has changed.

Add a new return code from this function to indicate that the UI must be
refreshed.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/bootflow_menu.c | 2 ++
 cmd/bootflow.c       | 2 +-
 include/bootflow.h   | 4 +++-
 3 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/boot/bootflow_menu.c b/boot/bootflow_menu.c
index 1966e38a6d6..2f08fa54081 100644
--- a/boot/bootflow_menu.c
+++ b/boot/bootflow_menu.c
@@ -310,6 +310,8 @@ int bootflow_menu_poll(struct expo *exp, int *seqp)
 		ret = scene_menu_select_item(scn, OBJ_MENU, act.select.id);
 		if (ret)
 			return log_msg_ret("bmp", ret);
+		if (act.select.changed)
+			return -EREMCHG;
 		return -ERESTART;
 	}
 	case EXPOACT_QUIT:
diff --git a/cmd/bootflow.c b/cmd/bootflow.c
index 9d449f430c9..3bdebd96bda 100644
--- a/cmd/bootflow.c
+++ b/cmd/bootflow.c
@@ -126,7 +126,7 @@ __maybe_unused static int bootflow_handle_menu(struct bootstd_priv *std,
 				return log_msg_ret("bhr", ret);
 		}
 		ret = bootflow_menu_poll(exp, &seq);
-	} while (ret == -EAGAIN || ret == -ERESTART);
+	} while (ret == -EAGAIN || ret == -ERESTART || ret == -EREMCHG);
 
 	if (ret == -EPIPE) {
 		printf("Nothing chosen\n");
diff --git a/include/bootflow.h b/include/bootflow.h
index c0e19feb9cc..18bfa1fe8b1 100644
--- a/include/bootflow.h
+++ b/include/bootflow.h
@@ -688,7 +688,9 @@ int bootflow_menu_start(struct bootstd_priv *std, bool text_mode,
  * @exp: Expo to poll
  * @seqp: Returns the bootflow chosen or currently pointed to (numbered from 0)
  * Return: 0 if a bootflow was chosen, -EAGAIN if nothing is chosen yet, -EPIPE
- *	if the user quit, -ERESTART if the expo needs refreshing
+ *	if the user quit, -EREMCHG if the expo needs refreshing, -ERESTART if
+ *	the user tried to move to a new selection but was unable (e.g. already
+ *	at the top and tried to move up)
  */
 int bootflow_menu_poll(struct expo *exp, int *seqp);
 
-- 
2.43.0

base-commit: e3ced530e543c9f24cbc66430abc6109ce8df015
branch: expa

Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCF86C0219E
	for <u-boot@archiver.kernel.org>; Sun,  9 Feb 2025 15:23:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D14278091A;
	Sun,  9 Feb 2025 16:23:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="rmks8GwW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9FADD80141; Sun,  9 Feb 2025 16:23:42 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD00D80141
 for <u-boot@lists.denx.de>; Sun,  9 Feb 2025 16:23:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 25BC73FE7C
 for <u-boot@lists.denx.de>; Sun,  9 Feb 2025 15:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1739114620;
 bh=B0LUOKP3OQ6stNlDp82KUDF4neSw6RPQWk4YI9/7/PU=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=rmks8GwWy8HXgKYVSyBE9BmiyeanfIGgRQwSjyoptRaXEutNFx78CnWDwF/B/g/cF
 wdsrjoWsHAG+a92NeInzVAVYeMBcg6FydW67nuTXwM5MujWawQvwS7KqxJii8OiJz0
 8/W1PO2q4WfQredAak7lWPjDuOMq0E8Kfl750iKb56SgMunvj6P+hKHZxm7mVFgJej
 URGX7z6kOrzM2IFYBm3K6/m+2wkrxQFsBXk6qMTRPGFPa2q5gbMHlb5q7KLSniNrws
 poBx9FqEJxjl8AP3QeGofPqOGLqzz10NrXsdUa+i/9S9/u6Lr0SeGUz+C3Us397yN7
 FGhBEJKDoWY0w==
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-38dd6edef72so445576f8f.0
 for <u-boot@lists.denx.de>; Sun, 09 Feb 2025 07:23:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739114619; x=1739719419;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B0LUOKP3OQ6stNlDp82KUDF4neSw6RPQWk4YI9/7/PU=;
 b=IqfD0Qrn4e7+gPfBRsjGm/aHrhupy6LAtDIccv50j61HPNrpsQ8RVbE5Fw/ZVtrKte
 yb3QF+ss4DkYv+rQO2BeRggApP8GZExSLL8jByM6+uHOroVWwxg+pQJRblmD498300BQ
 u5vkwrjLN8wNsVlREP/8YRVRXBisDnYt8wPIdcN9/iyoP3V8tofd0jFkjX2MD64/2x7B
 NgMTTW2Ai4O5I0na0nQ/xWg/Kv1fe0+GaMCJSyeazN/+OYZautPLVT3GzikIVaYUnw1H
 X/B2buUlCJMG8KTru3Ctq3U2bsm7Tiafg5R+7Wtg23LC4tHfWC6Z3dipxtXusadMRepE
 mb+Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWOuciGRrzwwbJUHu21rQbSvWP+E8N0+mKO4+jPzy/zFMoQT4cOvYT+kBYRTUgosnU/THjmdkA=@lists.denx.de
X-Gm-Message-State: AOJu0YwyVkwW8NBFyn9hqI8/NVxSHBKfau9uQLR8xvfE1Bpi1rH5PgAP
 AfV9TvJPi2Wt7a3wjd1x9z65cJa4LrMmb5cYrAoWUNOO8VTTwPMMJy7QqNqJIWag7J+X3vOz648
 GJXw1zj+X28PZwdRpGMeBBfBAlNcn60aQObTzGWVPi0H9oybOoCqzLZ1VtHBnpvtI1/U=
X-Gm-Gg: ASbGncuoDcwYUd90IdMyMYeDOzwC8TA7pcLO2eyf4G7I0dLgeifGZ71kt2uUnHjrXYc
 l/WmHSp76ufDYkvEzXVy6LyFuHETD5Hh0MZmlpfCXXhaSmLyzKE/8/ilazrnw8PshoQ6/d4rZ4h
 PHq74Naaq0f1+0vOCam0HOqPxHUWIDpaeAMC9W39c8ckDh/QFjJsMofj1zS2IVxHzkGKXERTlvv
 TmTDg4KK4alwnOtW60LqmfslGltq95RF3wW+oivpoI1D1KFboxBVRPtyijUG8+AS+sAfHzYOYJ6
 2abkV/zad8UHbD8FgB18LUXS24tMHV4MH+I6Zu7x/Mw3NS87bgUFR802+ldsZC9R6VesLQsyiQ0
 fbhf5Yg8=
X-Received: by 2002:a05:6000:1a88:b0:38a:8b34:76b0 with SMTP id
 ffacd0b85a97d-38dbb306601mr10458995f8f.27.1739114618891; 
 Sun, 09 Feb 2025 07:23:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFH0Im7pyIn4KGUMpRYBV0QZUhXsBoTJ8lUiZte5F5Gvrc+qu+tI4gGmqZgNI8V58UqtWzYQw==
X-Received: by 2002:a05:6000:1a88:b0:38a:8b34:76b0 with SMTP id
 ffacd0b85a97d-38dbb306601mr10458983f8f.27.1739114618577; 
 Sun, 09 Feb 2025 07:23:38 -0800 (PST)
Received: from localhost.localdomain
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dd016496esm5912663f8f.19.2025.02.09.07.23.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Feb 2025 07:23:38 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>
Cc: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Simon Glass <sjg@chromium.org>, Yu-Chien Peter Lin <peter.lin@sifive.com>,
 E Shattow <e@freeshell.de>, "E . Shattow" <lucent@gmail.com>,
 Sumit Garg <sumit.garg@linaro.org>,
 "Leon M . Busch-George" <leon@georgemail.eu>,
 H Bell <dmoo_dv@protonmail.com>, Lukas Funke <lukas.funke@weidmueller.com>,
 Andreas Schwab <schwab@suse.de>, Nam Cao <namcao@linutronix.de>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 2/4] board: starfive: spl: strip off 'starfive/' prefix
Date: Sun,  9 Feb 2025 16:23:27 +0100
Message-ID: <20250209152329.187194-3-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250209152329.187194-1-heinrich.schuchardt@canonical.com>
References: <20250209152329.187194-1-heinrich.schuchardt@canonical.com>
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

The configuration descriptions generated by binman contain the vendor
device-tree directory. Instead of adding it to all match strings just strip
it off.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 board/starfive/visionfive2/spl.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/board/starfive/visionfive2/spl.c b/board/starfive/visionfive2/spl.c
index 22afd76c6b9..d63eb1abe6a 100644
--- a/board/starfive/visionfive2/spl.c
+++ b/board/starfive/visionfive2/spl.c
@@ -118,6 +118,10 @@ int board_fit_config_name_match(const char *name)
 
 	product_id = get_product_id_from_eeprom();
 
+	/* Strip off prefix */
+	if (strncmp(name, "starfive/", 9))
+		return -EINVAL;
+	name += 9;
 	if (!strncmp(product_id, "VF7110", 6)) {
 		version = get_pcb_revision_from_eeprom();
 		if ((version == 'b' || version == 'B') &&
-- 
2.47.1


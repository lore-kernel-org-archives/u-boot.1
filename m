Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA047C19F32
	for <u-boot@archiver.kernel.org>; Thu,  6 Mar 2025 00:28:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 52A7481253;
	Thu,  6 Mar 2025 01:26:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="a6GjWABZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 29DE38141E; Thu,  6 Mar 2025 01:26:53 +0100 (CET)
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com
 [IPv6:2607:f8b0:4864:20::d2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 79C1D81433
 for <u-boot@lists.denx.de>; Thu,  6 Mar 2025 01:26:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2f.google.com with SMTP id
 ca18e2360f4ac-85ae33109f6so7521339f.2
 for <u-boot@lists.denx.de>; Wed, 05 Mar 2025 16:26:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1741220807; x=1741825607; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ReV0O+ZlcVkn78BwFhlw9VfpH4t6tsDdDBmZiedkmMY=;
 b=a6GjWABZLoCC5nf8lisVzO8dihsqBkCmauJzjYjFGdEi5/BI6I75g1Kr2gpBEKhNcp
 oGH/Zh0pLWE8rxubTuPndvOu526NOFy+7K8rsfkA453ifXM0WpVOFTyV4Kaqg3CTjz3g
 XDIgSFtzIyYo9nkrHUn1G7uZBX3Gfzb1K/yFA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741220807; x=1741825607;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ReV0O+ZlcVkn78BwFhlw9VfpH4t6tsDdDBmZiedkmMY=;
 b=FBY1IhY/RlIUWwiTyb1M5o2I9KzMjF+kBLi7U6FMdDMygRVb1+BA6mL/nI2GP+0d2s
 jvWAqQpG8NyL2wlF/qZNh51EBkNxxl/x7rh5O5NtFUO3R/ZURK0/NhkddWjd8r9hVIqH
 xz0vciHxBxxrKgeTGz4guzDCGVD02uTp0BBmkPPXxafehhkIUQvQ1N5/cpxiFPMImuWy
 o7MoOA0pbMOrxWLrXT7VKN6RVM+X53nDf8FEUS9wIfjuE5ADkIt1El4Vyw5CKIgsSeBW
 DIWlQ1aUeqOR25j7oDlOStlOC5mPd8yFi7+rf6v4nVg1YzuvzxnjXupQn9vqsPc8ooV+
 Ax6w==
X-Gm-Message-State: AOJu0YwYTK17HeL8JKUtn8m+xfc4lXgK90YosevVEvUM3htKQMvlpgrp
 ofNOzYmlz2S9bA4KramMQLpGc4vMosSbCG38QUa6hunL7WuJ9fFYD8EEzp+TN3CxmAnQVUK86WU
 =
X-Gm-Gg: ASbGncu8hXi84C5gIsK7Rx1VXerN95nyJFgTJVuRY/iVxiuWWFQKeKP6otTqmRRNMMO
 x0s5ppAyE1KR7jGnOZep/Q59Vmbt26BbI6BgbVL9naiwgGCNlZMUndxpg0WNT6v05Kq4anwpCjn
 K+0m5CwRkZvYzMQHVV9JAFe8PEMtQnW7qw2YnDciCDpycU7JRmvrDSAXw9eUwnu3hwUoDcXkUjh
 Pwm5Kn+qzRN1rBW+UYVcAs/4ZeyqJxaQwsVNZXmDJrd+ykMK9d+mEcocOg4K/P8IjSxV4p03Vc+
 SjuLbJRO0DOsGQrY6J56dem9g8JzSCIqKkAq5Iees/ARSL09Qy8ZSroDY7glOeFpx4cEKDcXpSY
 jSCJZtg==
X-Google-Smtp-Source: AGHT+IEPequsOeScxHpMDBcT6ES+Fg0m3xhqpMZaQMk69BSO0aS2pzSdzW4M/ZjAL19wPmNOI8PDVg==
X-Received: by 2002:a05:6602:b82:b0:85a:eff8:4cdf with SMTP id
 ca18e2360f4ac-85aff880d9cmr675291939f.1.1741220807228; 
 Wed, 05 Mar 2025 16:26:47 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-85b11986869sm1106239f.1.2025.03.05.16.26.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Mar 2025 16:26:45 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martyn Welch <martyn.welch@collabora.com>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: [PATCH v5 09/29] boot: Use strlcpy() in label_boot()
Date: Wed,  5 Mar 2025 17:25:03 -0700
Message-ID: <20250306002533.2380866-10-sjg@chromium.org>
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

This function is recommended instead of strncpy() since it always
terminates the string.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v2)

Changes in v2:
- Split out strlcpy() change into new patch

 boot/pxe_utils.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/boot/pxe_utils.c b/boot/pxe_utils.c
index 82f217aaf86..e96935896a9 100644
--- a/boot/pxe_utils.c
+++ b/boot/pxe_utils.c
@@ -558,7 +558,7 @@ static int label_boot(struct pxe_context *ctx, struct pxe_label *label)
 		}
 
 		if (label->append)
-			strncpy(bootargs, label->append, sizeof(bootargs));
+			strlcpy(bootargs, label->append, sizeof(bootargs));
 
 		strcat(bootargs, ip_str);
 		strcat(bootargs, mac_str);
-- 
2.43.0


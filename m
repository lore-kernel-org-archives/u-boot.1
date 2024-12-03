Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 981A3E77166
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 23:47:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8859E89699;
	Wed,  4 Dec 2024 00:46:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="P+vaC7CO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A041A896AA; Wed,  4 Dec 2024 00:46:39 +0100 (CET)
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com
 [IPv6:2607:f8b0:4864:20::d35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B9A488F55
 for <u-boot@lists.denx.de>; Wed,  4 Dec 2024 00:46:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd35.google.com with SMTP id
 ca18e2360f4ac-8419f5baedcso196055539f.2
 for <u-boot@lists.denx.de>; Tue, 03 Dec 2024 15:46:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733269596; x=1733874396; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ifh/tpFRvldGsje/58VhW9Zr9k1neJI62ypRcHjUnQ8=;
 b=P+vaC7COxKaBdguIKXOEHxX/TSOZ2z7aev4PnG+Ju3ehVOUUTU1JqzKC432cCwcSfv
 t5ESUA4TH82hzqq0N08G3DcHSMtBnMDlW2GLcEPM3VG+KPQ4Pl09aLoSNjWv+/ZLwZXP
 /8536X5QiWJKNZ/TkQhAiQMdWk9tEBwx4mNbI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733269596; x=1733874396;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ifh/tpFRvldGsje/58VhW9Zr9k1neJI62ypRcHjUnQ8=;
 b=MY6ee3OFZvgfsKTUPkX0X/HquX8IAigQKUvhNw2VtlzH/VNRhsCp8/CWnSbhYQmmYk
 sqdsSuaboK0RaPbebjZkycP1QJH6Xze2EzVoPDrAtlwmvMiXNZg/e0RoNbcigA+2BI+B
 jD6Ko3Ko8CfDxvql1zN82cIFojA1YAsQemvYSF8R4CxhJtGiuXnR0vBge/v2ftiMUmqN
 DXZ0DlvSa3wqtQrVoCI+gefy4F7NI3EJge/CxLJT9lJ/ab9+eL+ZQ4Hxm/0GRqHFp9tr
 b0IPCj2UJCqNsRzqVY+NJ/6s7DclbOon1a4lB1TPLvexNwlpPjfCjN6CBLpdKvKi8jCI
 Z36w==
X-Gm-Message-State: AOJu0YyKGm6QxbYozKtDDB2r89QCqYcqH3bRmA4ReZL1nvu4bxH2RWpD
 0JinscA2B1E6Qvlc8gbGbnM7t/4J+xsKn3kCfmci4TmP888LXNMDrYpJ4wbxhzl8lMd+EU+FrSo
 =
X-Gm-Gg: ASbGnctSvt1Ro8S2i+CN31PBFLXiyObEh7sfXUB6OeoCOzwdnmAeiyW8lIijPEuh6NP
 SpoJZm196Kbj4GrsRZFJBfqmsH5vMlwePjNNAeOIZFuSVxa5RiUpaRzKBHBY2bbAGmkt247E+pW
 bQ1c9ocoVunAGUdT6T+SnbUzqKoeP9M6LIDObBx01iGKV+eSKz69QaibLGi0IhFCcdrJlKtfB9v
 L9JcBKttQyvYbxgpR4n7+ZQjGxd19P4fL9IO832TbiNB6pmGUNepyETsK+t7c7DjsFIcQtzU2tQ
 GPJc9T5YHZ4=
X-Google-Smtp-Source: AGHT+IE5+t+8Uv3LfHOrPV2aAnsI6ANn83sA+KNvGAZDRbnbaP9/sO98FmVXCZe8qqMtutgLJuKlLQ==
X-Received: by 2002:a05:6602:6b19:b0:842:ff2d:c3bb with SMTP id
 ca18e2360f4ac-8445b55af5fmr539196739f.6.1733269595764; 
 Tue, 03 Dec 2024 15:46:35 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-84405faf14fsm282349939f.42.2024.12.03.15.46.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Dec 2024 15:46:34 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martyn Welch <martyn.welch@collabora.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: [PATCH v2 09/41] boot: Use strlcpy() in label_boot()
Date: Tue,  3 Dec 2024 16:45:27 -0700
Message-Id: <20241203234559.2938192-10-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241203234559.2938192-1-sjg@chromium.org>
References: <20241203234559.2938192-1-sjg@chromium.org>
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
2.34.1


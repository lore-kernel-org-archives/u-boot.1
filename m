Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 107A9E77166
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 23:49:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B80389692;
	Wed,  4 Dec 2024 00:47:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="BTGv8hiE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C8C888F55; Wed,  4 Dec 2024 00:47:23 +0100 (CET)
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com
 [IPv6:2607:f8b0:4864:20::d31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EEA77896E9
 for <u-boot@lists.denx.de>; Wed,  4 Dec 2024 00:47:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd31.google.com with SMTP id
 ca18e2360f4ac-841acc8151aso216494639f.1
 for <u-boot@lists.denx.de>; Tue, 03 Dec 2024 15:47:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733269639; x=1733874439; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=95iUHcKaIvde41hMaQPreEKC3EfpLOe5YPuaL6m3KN8=;
 b=BTGv8hiEnOOd81eLSzurYqrsOrOPZHJuAWurLbidDTTOcWtliBk5iPAW/r7S31rf5h
 pN0Kl59yuDpqqZNbVk/NeAmNDYKq9ZefAdU7kqFdt6Lznl6NIghVlGKy7q32fJK/xu+q
 vW99YlFk9pXxBgBMw5HQUUUrI9WztJlEEypcU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733269639; x=1733874439;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=95iUHcKaIvde41hMaQPreEKC3EfpLOe5YPuaL6m3KN8=;
 b=YLjGUB+Y1H0V5aIH/YPIIjrOvS67R0qczjg472BWtQPbqE2S7zHKggQC0LdmbrVdzX
 qKVA+N1opHXbeQhjiHbKdNKS44w/Y2NoEO5vBRJ9mp5FgOyFumFlJ3nKHWXlepPOeBVh
 o940HCgQACySBE3CneLWbZZFvFtRlLIBM7uhjQ+zdhVTxyA7a8DNP8opdr8tO37g8OSP
 5r4QTS+VMbIAbFlkofLO6vTAqijwZDweUz8eDKemJ5xEl4fFf46yl1/ZQT22XwC6QEWc
 E765+JTig4+epHhJ2tLaYl8FaYsx78Tczg+5tRQPIQEbH/InEWFME2IF5298+Hpp+ri/
 Wf9Q==
X-Gm-Message-State: AOJu0YzCxxnuB4addoDHnxsi5bw7OOyIpS1fU3ewt+fuVyRanISUPRD5
 kVURsjryXGsaLTVc8lYxR0uxbMUW5s4yx0VJ8gCv/KwGo9XA1PnGMd9ONWYzC7llsf59cZl0WhY
 =
X-Gm-Gg: ASbGncun7KQc1Zu/l/iruvnjUmVcLu6L6R3xtQWvGqyempnM+MdlabPtmBxZZ8kn6Pi
 ukUH3n3XDOnP06ZiHfKkg013DNcZAECZLfoDBKDoL/DA+zyHZEQOwMgzKPUpWgKAHK8R5gztYAB
 eliQ9Cogrz7uPYRQ1VLL0NJjZY9BbEifofaKukkVMUr8gLQbcAT7ZFJWURsDvnEXkpkRSWoGMQX
 d/pE4KCyHM777YG4d6YB2nf4mYy+Ini0stQfbTDSdDm/zUEyfRilPB0CD09GDIRK2vJUQkb7x3t
 BJ1+5P8OLus=
X-Google-Smtp-Source: AGHT+IGFLq1UpuQonFZpqlQjaOoqz8oZM3WhUSgORxAH1T16y12Lm8sBEH6IYfA1srhGyMa4yi1pgA==
X-Received: by 2002:a05:6602:29c8:b0:841:95b5:8944 with SMTP id
 ca18e2360f4ac-8445b5e2776mr559172239f.15.1733269639254; 
 Tue, 03 Dec 2024 15:47:19 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-84405faf14fsm282349939f.42.2024.12.03.15.47.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Dec 2024 15:47:17 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH v2 24/41] net: Drop #ifdef in parse_args()
Date: Tue,  3 Dec 2024 16:45:42 -0700
Message-Id: <20241203234559.2938192-25-sjg@chromium.org>
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
2.34.1


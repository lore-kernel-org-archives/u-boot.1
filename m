Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE825E77166
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 23:48:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 433DC89688;
	Wed,  4 Dec 2024 00:47:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DNkTHj95";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5CFE7896D4; Wed,  4 Dec 2024 00:47:04 +0100 (CET)
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com
 [IPv6:2607:f8b0:4864:20::d31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E3BD8896DD
 for <u-boot@lists.denx.de>; Wed,  4 Dec 2024 00:47:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd31.google.com with SMTP id
 ca18e2360f4ac-8419ef7c2d8so203488939f.2
 for <u-boot@lists.denx.de>; Tue, 03 Dec 2024 15:47:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733269619; x=1733874419; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EnFaitV/n0GPg6YYhPB8/MET0vxlWv6+/wH9w65GJCY=;
 b=DNkTHj95F8n6oOQd7ZP8B/fio4gYVofPlo2Z6m91/u9+4eGJb7UH4h0RArv9YKn+4z
 aDaXejgb4+zBfObjgZ0I3TMHIUD16qVaYs2fXu7uvcT4Jdn1cppj1sGoSQfohH+h8erq
 4VLdglK40Hr3I4iYaZdBpngWH3pgdSJYOLxyY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733269619; x=1733874419;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EnFaitV/n0GPg6YYhPB8/MET0vxlWv6+/wH9w65GJCY=;
 b=Bei8t1W078yRJwPXxmIlWqRZDFqiQXo+XoEfk9wB07zFkxy5bPy6nSNiHmspQ7U1yL
 UR4uZ/qv/cTBIj8yls/A0zAPivG7HjXJdL5K+v4yo3DozLuJFdFqaigKGio3FQwgaKyg
 3feEiocNx/IEapcLlDREjXKxdFqQNBiYwStiuRcFBg2APyRMlvg+SqF8E4VYMc18S3rf
 DQoAMUootGGrc6ffaRfnNZrKJpTgOoTi5WDLL2+EHOyNWFdssIOpMZ7rrj53iDKgKIge
 wSkpFWDl1HxjZQGiFbwVmmoPPEZKvfJ7/KU+py7qcaO3Z9nfBmIgBQWV+VwH+6xkUz93
 b4Eg==
X-Gm-Message-State: AOJu0YzllvHAP3BCesHadPkZLVnXqiYJ4k/ZCUSpd9wPMhrGOR1E/szo
 Y7//WiKrb+Nmd+6qFcd45TwCvnLIfdQe7ltW9eRQVXkrEj4iucE1w/yXO64+fkXcAZ+9ltv8AM8
 =
X-Gm-Gg: ASbGnctqvrBOJeaiLWmiCZ5rOJy07MgjahaQja+XcXtAx/0wOgjOrRY5DmeWyGE6kMm
 SLBBqPls4buQjp9zL3Tp/ZNrRFCcFJAvVSaQF204PHM1yqY3223T0+TW19uJF4iOR+0ZsKddO+d
 xemB4D4pSTKXn7VU1FHqOvEFk0JrD7o4/sTFpxGm4RinBV+m49k5na1B8O6QudSDZIfQCuD+ANH
 Em0QZhjNavwWZLARKi+/8oRU+vlFOZkvSrzR/OCQqU25Hykve8+qQo5VezVtORnBtJE6lkm7Qnu
 +eEHg/IKjYI=
X-Google-Smtp-Source: AGHT+IFWuwpv8Y8l/GRTtPLmMq754EX7jzx8Ek9VYACi1F1goErR4kFZBTkj6WxzBXJAH7tk3N2SgA==
X-Received: by 2002:a05:6602:27c9:b0:843:eb5b:5293 with SMTP id
 ca18e2360f4ac-8445b54344amr659928439f.2.1733269619173; 
 Tue, 03 Dec 2024 15:46:59 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-84405faf14fsm282349939f.42.2024.12.03.15.46.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Dec 2024 15:46:57 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Adriano Cordova <adrianox@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH v2 17/41] net: Keep the bootstage functions together
Date: Tue,  3 Dec 2024 16:45:35 -0700
Message-Id: <20241203234559.2938192-18-sjg@chromium.org>
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

Move the bootstage_mark() function just before net_loop(), so that the
IPv6 code is not in the way.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 cmd/net.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/cmd/net.c b/cmd/net.c
index 79525f73a51..deebd5b710f 100644
--- a/cmd/net.c
+++ b/cmd/net.c
@@ -413,8 +413,6 @@ static int netboot_common(enum proto_t proto, struct cmd_tbl *cmdtp, int argc,
 		return CMD_RET_USAGE;
 	}
 
-	bootstage_mark(BOOTSTAGE_ID_NET_START);
-
 	if (IS_ENABLED(CONFIG_IPV6) && !use_ip6) {
 		char *s, *e;
 		size_t len;
@@ -428,6 +426,8 @@ static int netboot_common(enum proto_t proto, struct cmd_tbl *cmdtp, int argc,
 		}
 	}
 
+	bootstage_mark(BOOTSTAGE_ID_NET_START);
+
 	size = net_loop(proto);
 	if (size < 0) {
 		bootstage_error(BOOTSTAGE_ID_NET_NETLOOP_OK);
-- 
2.34.1


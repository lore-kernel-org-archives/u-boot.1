Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36671C3ABAC
	for <u-boot@archiver.kernel.org>; Fri,  2 May 2025 14:50:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 86F8282A33;
	Fri,  2 May 2025 16:48:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jMpWplMP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC3A182A76; Fri,  2 May 2025 16:48:05 +0200 (CEST)
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com
 [IPv6:2607:f8b0:4864:20::d2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B149C82A33
 for <u-boot@lists.denx.de>; Fri,  2 May 2025 16:48:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2e.google.com with SMTP id
 ca18e2360f4ac-85b3f92c8dfso71294139f.2
 for <u-boot@lists.denx.de>; Fri, 02 May 2025 07:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746197282; x=1746802082; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4ypoRIDd8JyfcfOWXR2uwl6yHuinv0JUpedZx2EP4Po=;
 b=jMpWplMP3jhjsEkp6HUXN6QN2U/13M4p2Oo0tmLUzToVN/0Gzq3A1gCLTzZH04zUrf
 iNnsf96JXH8zBRGl0vOb741nWHVN/RCRqwggwNI6Nr0p0lHnZdBJVqe2n6H3YT6h+eOr
 7aIArRHRloCTICu4JHp8Vymhf4YuyiiCot2tY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746197282; x=1746802082;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4ypoRIDd8JyfcfOWXR2uwl6yHuinv0JUpedZx2EP4Po=;
 b=AQuHJDZHBYqjbRUukfY9gRabCLu/C/kgfb7jqeikScHWnSHs/FoVss8SF+AEwfHxfd
 4dROM2GXquq/5YldFzWnSz6oiIrIogyzLz7eHKJCijsdUCpSvEXs0nqwywfWmIEu+wDP
 UPves3pA6D236lrT7wzKEVyIkgCA0qhP9rlSIeKUIAtSIjDA1JuRel8uo9SDVcim2Vji
 NKC7SGQNU/BVqG+EilTNcxAIJ/Qp6Nt4ihUUYKbXgzgh+JsjMFAab2WriuvduKi+ULJR
 LH+n48Yh+DTAzFiPyUbn+dVGi76vjNw9DP5J1sgsAO3yA8HbM/qikwL1Ksq7pPn5jc6C
 AszQ==
X-Gm-Message-State: AOJu0YxFFO901JnQggxqyzo87Vso55Ij91Acx19ZCRZDh+otSrG1RATQ
 82eDee9stzq+K0abUxswgauWawkl7HevmbFuywR6vEMPrkLcGz88k/yVzqZGPJcYpVBd+GfmDLY
 =
X-Gm-Gg: ASbGnct5pO13BtDhlPQT8eSOFpqF7kzdFzNadBQEreae5uCWO+zAZG9JM3nc6JuiEJB
 kPTHF6fZBCsnDmSpC2nOgU/B6Y/tgW1eTuq4RBBbMkHjL3GdwDAmfC5mMyRngmYtfx7rNUmNNCY
 xjeqITKJz8p0xgnybgESjllGFOKkXNgJ6hkZYA4RT1KfHSRv2NOyMNtKYkEXAiUDi51PsmAPksF
 fbB/xrWYhW4nKwkZekQIbUPY1E9sRlTOiEQSUQ3oycVICrK0Cmjas0GGnOxIm4rwgVQvpIgxhXN
 V5+x4EiMz/kDCtO/udUt4NgHlN71ueAxyxyDDIi7BUis5kVX2Zrn0QaRHYHMi3RT/hEbQZIPB24
 GdA==
X-Google-Smtp-Source: AGHT+IGBFtBeZy7F5KXPX9dkmwl3TlUEmMWx8kw6CEwR4JACO1gZv6a41gJ7XQgcf4r7tg9R90gdcQ==
X-Received: by 2002:a05:6602:7285:b0:861:c759:61fa with SMTP id
 ca18e2360f4ac-8669f9af20cmr514253639f.4.1746197281949; 
 Fri, 02 May 2025 07:48:01 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-864aa2bb423sm57011739f.4.2025.05.02.07.48.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 May 2025 07:48:01 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Alexander Graf <agraf@csgraf.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Anatolij Gustschin <agust@denx.de>, Peter Robinson <pbrobinson@gmail.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 20/60] vidconsole: Avoid kerning against an unrelated
 character
Date: Fri,  2 May 2025 08:46:18 -0600
Message-ID: <20250502144718.313633-21-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250502144718.313633-1-sjg@chromium.org>
References: <20250502144718.313633-1-sjg@chromium.org>
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

When the cursor position changes, kerning should not be used for the
next character, since it can make the first displayed character shuffle
left or right a bit.

Clear the kern character when setting the position.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 drivers/video/console_truetype.c  | 2 ++
 drivers/video/vidconsole-uclass.c | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/drivers/video/console_truetype.c b/drivers/video/console_truetype.c
index 2e3e6f07112..6d2c2c2e177 100644
--- a/drivers/video/console_truetype.c
+++ b/drivers/video/console_truetype.c
@@ -490,10 +490,12 @@ static int console_truetype_backspace(struct udevice *dev)
 
 static int console_truetype_entry_start(struct udevice *dev)
 {
+	struct vidconsole_priv *vc_priv = dev_get_uclass_priv(dev);
 	struct console_tt_priv *priv = dev_get_priv(dev);
 
 	/* A new input line has start, so clear our history */
 	priv->pos_ptr = 0;
+	vc_priv->last_ch = 0;
 
 	return 0;
 }
diff --git a/drivers/video/vidconsole-uclass.c b/drivers/video/vidconsole-uclass.c
index 6ba62ec348e..f1b2d61bd8f 100644
--- a/drivers/video/vidconsole-uclass.c
+++ b/drivers/video/vidconsole-uclass.c
@@ -127,6 +127,9 @@ void vidconsole_set_cursor_pos(struct udevice *dev, int x, int y)
 	priv->xcur_frac = VID_TO_POS(x);
 	priv->xstart_frac = priv->xcur_frac;
 	priv->ycur = y;
+
+	/* make sure not to kern against the previous character */
+	priv->last_ch = 0;
 	vidconsole_entry_start(dev);
 }
 
-- 
2.43.0


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E974DCE79A8
	for <u-boot@archiver.kernel.org>; Tue, 19 Sep 2023 18:14:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD4B986C1D;
	Tue, 19 Sep 2023 20:09:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="EgpQFYsu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E48686BE6; Tue, 19 Sep 2023 20:09:55 +0200 (CEST)
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com
 [IPv6:2607:f8b0:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5809D86C58
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 20:09:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12e.google.com with SMTP id
 e9e14a558f8ab-34ff2ee8f8eso7066575ab.3
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 11:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695146992; x=1695751792; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BBrH2MiYXqCZlktV/iu1uqjF1I8Qcfvq+C68RTRW+8s=;
 b=EgpQFYsuhYUwxI/DmU2zCr9DzPvcUq5RUwlVkB43d6/VHfkWRM12cNGh5K4i//rtQc
 CDKLSNr6JGYzrH6O6JMfYTRPgqepl/M8W6zP5DvWHbZBdKA7/By4OJNo7Qoj56zqEkcd
 TwlHI4Rrd6RN/OPDZV4oPSgIhV5rhatGxmzWA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695146992; x=1695751792;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BBrH2MiYXqCZlktV/iu1uqjF1I8Qcfvq+C68RTRW+8s=;
 b=sFWI1pat6N+x093HdUO5wfhhpzl+wB91DEmDAD8G/xzhxagu2cgODM69i0PtT2KEt8
 365M5ZzXGJrkOcUrJYia4XGDacuoNzEQxCYHKSSXCTeOvxb+nTeCZCmpeV9TI1x5MxVm
 aNwDNteXPHWuHd4bynODoOkTwO+tGpR63pQgWZZDhytEMloZ6jNh+hIuxhUvjBxtAXNC
 2uJvBdKD8nxXXLvtVfzOXUMcKxzGHQsSmxiA0rm2Yu/Ex22mW9bTnDeqIu5C5B72PHuL
 8OLt3ILaRgX5NXACyX0ilgrs2AXyEM/c5voMtCp22SY4HHGccDwcIaj5Dd8ulbceNT5H
 t43w==
X-Gm-Message-State: AOJu0Yz6EeIjXdo1b/dHwO/cJppPgGb3dqGxCKE81WGmNNv8QzChtZgS
 66GMLQU70h7iF8iY+pruN03ALOI9GDBH6TIfNnU=
X-Google-Smtp-Source: AGHT+IGNLzkG95GttdASHEJbxVcidAoAzEYaF/RitF3ULefIIQoO8IIDcrRwyXu6xJufONdYWD6U9Q==
X-Received: by 2002:a05:6e02:20c2:b0:34f:cff6:5e2f with SMTP id
 2-20020a056e0220c200b0034fcff65e2fmr679930ilq.30.1695146991994; 
 Tue, 19 Sep 2023 11:09:51 -0700 (PDT)
Received: from kea.bld.corp.google.com ([2620:15c:183:200:5337:a30a:1478:27f0])
 by smtp.gmail.com with ESMTPSA id
 b9-20020a056e020c8900b0034e1092bccfsm3885352ile.80.2023.09.19.11.09.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Sep 2023 11:09:51 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Anatolij Gustschin <agust@denx.de>
Subject: [PATCH 31/36] video: Mark truetype_measure() static
Date: Tue, 19 Sep 2023 12:09:01 -0600
Message-ID: <20230919180918.2904313-32-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
In-Reply-To: <20230919180918.2904313-1-sjg@chromium.org>
References: <20230919180918.2904313-1-sjg@chromium.org>
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

This function is not used outside this file, so mark it static.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 drivers/video/console_truetype.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/console_truetype.c b/drivers/video/console_truetype.c
index 242b8b71342..14fb81e9563 100644
--- a/drivers/video/console_truetype.c
+++ b/drivers/video/console_truetype.c
@@ -718,8 +718,8 @@ static int truetype_select_font(struct udevice *dev, const char *name,
 	return 0;
 }
 
-int truetype_measure(struct udevice *dev, const char *name, uint size,
-		     const char *text, struct vidconsole_bbox *bbox)
+static int truetype_measure(struct udevice *dev, const char *name, uint size,
+			    const char *text, struct vidconsole_bbox *bbox)
 {
 	struct console_tt_metrics *met;
 	stbtt_fontinfo *font;
-- 
2.42.0.459.ge4e396fd5e-goog


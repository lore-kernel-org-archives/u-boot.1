Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03725D3C919
	for <u-boot@archiver.kernel.org>; Sat, 19 Oct 2024 15:27:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 08B22892FA;
	Sat, 19 Oct 2024 17:23:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Eb8mNPAI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E58FD8932C; Sat, 19 Oct 2024 17:23:09 +0200 (CEST)
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com
 [IPv6:2607:f8b0:4864:20::d34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BDF0A8932E
 for <u-boot@lists.denx.de>; Sat, 19 Oct 2024 17:23:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd34.google.com with SMTP id
 ca18e2360f4ac-83ab6cbd8b1so97104739f.1
 for <u-boot@lists.denx.de>; Sat, 19 Oct 2024 08:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729351378; x=1729956178; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v6qy0ZPJ1yxTPk4w2vvSNIi9Evzc3FPsb9bKgXonLtA=;
 b=Eb8mNPAIzCpaa8KXJzpq+G4RYhzel/RjMiPSCOn/haiS82bxTDp5L7aL3nxPjV3Eb6
 gpdGQrGTzHEEzCgzJ8zffmFm53a+sEFFru8KelBnEW14CTq0HtbuSr9YbsZ9z4XTFK0a
 gCPMp9S/iMovIjZ+rKzIq+u09OeEk666tCu3Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729351378; x=1729956178;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=v6qy0ZPJ1yxTPk4w2vvSNIi9Evzc3FPsb9bKgXonLtA=;
 b=sAPGDNrXncHdYq52aUPOvO/Wct1R3cCyyeRMssONqm+8025wCFtDWjMe+kmCmxcyuN
 SgPyF49B22rmp2cZd9G0jR8vUY20ESUiYlSXYnHo+JYytkd2BV8RSaNL/wfJLqtcucWr
 Y/KZf5w5uVrCQyKeR5OvUzcU4TK1a2JlbyVMsr8DB3VsccUdvT5kWI4/e1CDUolWq9RC
 ppkF2d/y6gMKj1v59JylQIhVJxgUuTCn4n0SGlgAOPJpEcbROIYUFeP1blElBZSiMu4g
 cKktBHE2FJDuGu6uoLFDzP3dpHUgLG1QGnsVXSbHoT3F3x73hL0+zxfOinNjzc3MeMlS
 icTw==
X-Gm-Message-State: AOJu0YxqFUnrwEg3b8GRv/gvWehsOjwZ69/WOU2lWtp8/7VJvAA+cs+5
 PWvU0g8AUXijOQV1phrjfIKay9/hqizhVNdldjhtugm0yA8jtARoM77dec+zZjzu56Cl5/R4S+U
 =
X-Google-Smtp-Source: AGHT+IF7nOJhM5biNH80Hon1hwd80AkES4TNNzE+ewWkVkhlU9prliCbujrq63nk1mchwQPww3j4ew==
X-Received: by 2002:a92:190d:0:b0:3a0:915d:a4a7 with SMTP id
 e9e14a558f8ab-3a3f4050120mr44767985ab.2.1729351378161; 
 Sat, 19 Oct 2024 08:22:58 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4dc10b83faasm1006111173.52.2024.10.19.08.22.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Oct 2024 08:22:57 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Shantur Rathore <i@shantur.com>
Subject: [PATCH v2 25/31] bootmeth_efi: Check the filename-allocation in the
 network path
Date: Sat, 19 Oct 2024 09:22:05 -0600
Message-Id: <20241019152211.1014896-26-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241019152211.1014896-1-sjg@chromium.org>
References: <20241019152211.1014896-1-sjg@chromium.org>
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

If the filename cannot be set we should give up. Add the missing error
check.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Change the tag to bootmeth_efi

 boot/bootmeth_efi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/boot/bootmeth_efi.c b/boot/bootmeth_efi.c
index e8109e19bcb..1ff8788ebeb 100644
--- a/boot/bootmeth_efi.c
+++ b/boot/bootmeth_efi.c
@@ -269,6 +269,8 @@ static int distro_efi_read_bootflow_net(struct bootflow *bflow)
 	if (!bootfile_name)
 		return log_msg_ret("bootfile_name", ret);
 	bflow->fname = strdup(bootfile_name);
+	if (!bflow->fname)
+		return log_msg_ret("fi0", -ENOMEM);
 
 	/* do the hideous EFI hack */
 	efi_set_bootdev("Net", "", bflow->fname, map_sysmem(addr, 0),
-- 
2.34.1


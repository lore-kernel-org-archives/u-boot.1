Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BE31C3DA4B
	for <u-boot@archiver.kernel.org>; Wed, 17 Jul 2024 08:33:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 62B7B88A78;
	Wed, 17 Jul 2024 10:31:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XJMjLwVT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 40805885B6; Wed, 17 Jul 2024 10:31:27 +0200 (CEST)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A14D88A58
 for <u-boot@lists.denx.de>; Wed, 17 Jul 2024 10:31:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-367990aaef3so3795869f8f.0
 for <u-boot@lists.denx.de>; Wed, 17 Jul 2024 01:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721205084; x=1721809884; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BYkWJTtYel3Xf02UbDWHsAxLqoMYEGdMYaR/V9Zh8Yw=;
 b=XJMjLwVT6N3Rbu+r7ZUOM8ShY9fX4ddFCaVikXtN7zYoxHG0PyveYjUqAh7WGaT+gT
 6Ow5iso1M/+4DMHvhwGFVahwP+wyVVET+v5XezPuMqg14WGUP+XjlPjFolb2DD8fWbnM
 G75GUcxzPMOAJaNvPa9mAm4dWbIsTmniYb6jg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721205084; x=1721809884;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BYkWJTtYel3Xf02UbDWHsAxLqoMYEGdMYaR/V9Zh8Yw=;
 b=Vbjh1XLCGr6kLBV716fqsn6pKlN1W1pFeAEp0KTmYHTgkBtonce+ZhKdmpGSJVGeFG
 5LnfqZ3xl9+WErcVLHSlfAA6yV80kthe6KdgktDiORIUlsKhoumfxQpT5WUkAPnkbqtY
 CJpqP48sFfa97PZBN54Y6svz8b7jSyjCxv8KOsXYmhrYGSnNDay180ukEr6ZfwheFnNl
 wxzu+RRfqUvsz4YbvV1us+dv+O+NpEfu+8h/J4teIu5QqnUrRkNYQ5EF7g9W8PL7+L/X
 l7TwkLzJKx2dyh/wrcG3jJKpN9UAaHQ0qO1mFncbJsHmH3HjsXMVeQ4uBVywGd+rBdGL
 5KiQ==
X-Gm-Message-State: AOJu0Yw9tMDqD8FJGBzAHf1HyoiJjPYQceK70amj9tQumGBM8vVKWkZB
 bGlXLk93W0+ckpNPYxVS6oorGrONGWLacZ9g47+tNgkUBSg/Ed+2NK/bba2r4sMb7TVZ0rwPLOQ
 =
X-Google-Smtp-Source: AGHT+IFJUwz4RspE2Gwgw+X5+CNi77E8IeA+52pGdDoxqI9z2JcvR5Qz7jpyXV+WlxQ6X0Q/ITkmhg==
X-Received: by 2002:a05:6000:184a:b0:367:987a:2d3c with SMTP id
 ffacd0b85a97d-36831653536mr944791f8f.29.1721205084746; 
 Wed, 17 Jul 2024 01:31:24 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3680dafbb5bsm11069930f8f.80.2024.07.17.01.31.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jul 2024 01:31:24 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glkp@gmx.de>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: [PATCH v3 13/14] boot: Correct indentation in efi bootmeth
Date: Wed, 17 Jul 2024 09:31:03 +0100
Message-Id: <20240717083104.1963431-14-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240717083104.1963431-1-sjg@chromium.org>
References: <20240717083104.1963431-1-sjg@chromium.org>
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

Fix a minor indentation / whitespace problem in a comment.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Heinrich Schuchardt <xypron.glkp@gmx.de>
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
---

(no changes since v1)

 boot/bootmeth_efi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/boot/bootmeth_efi.c b/boot/bootmeth_efi.c
index 56a6e47f5b2..39232eb2e25 100644
--- a/boot/bootmeth_efi.c
+++ b/boot/bootmeth_efi.c
@@ -265,7 +265,7 @@ static int distro_efi_read_bootflow_net(struct bootflow *bflow)
 		return log_msg_ret("sz", -EINVAL);
 	bflow->size = size;
 
-    /* bootfile should be setup by dhcp*/
+	/* bootfile should be setup by dhcp */
 	bootfile_name = env_get("bootfile");
 	if (!bootfile_name)
 		return log_msg_ret("bootfile_name", ret);
-- 
2.34.1


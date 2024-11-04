Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D02CD1BDD0
	for <u-boot@archiver.kernel.org>; Mon,  4 Nov 2024 17:53:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF74989099;
	Mon,  4 Nov 2024 18:51:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="L9vSw0mw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E631D8903C; Mon,  4 Nov 2024 18:51:41 +0100 (CET)
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com
 [IPv6:2607:f8b0:4864:20::d29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D0D9188F68
 for <u-boot@lists.denx.de>; Mon,  4 Nov 2024 18:51:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd29.google.com with SMTP id
 ca18e2360f4ac-83ac817aac3so175807739f.0
 for <u-boot@lists.denx.de>; Mon, 04 Nov 2024 09:51:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730742698; x=1731347498; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XcqduuKLurrEY0pxUHsLkciBeSyZkcn4X60OLfcBICc=;
 b=L9vSw0mwVjuctKsnJQzjRmCL1aG0vm8dDXXTh+APIEttPd9lfdKPwB/rm9CFSuKbGW
 G2l6/T8XYakzEV9E3c3AFDglXLApKONeP4tUqm9QJ1izJUbqBY73/KiTSZNjjEPqXrWP
 RFpZVfgR8dhQct8HG2NMZTwe5Za/77yLNCZjE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730742698; x=1731347498;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XcqduuKLurrEY0pxUHsLkciBeSyZkcn4X60OLfcBICc=;
 b=ZjJ+PhTw92CP7IvdBKUevLPBGsvHuw3B1VAoY/n23CJCwt6NyydDar62SI+3nNGd39
 BjxboLJDwcrE9LkjkeSkCT/cAew9P9Ier1YLTzgfGOagdALfhtUObn/1Misr2K/0styF
 dKI68qffi0fzwfb61F6HfRC0vcenCEUbDjVAQRNAtLqWPHTIDiEYiVC9sccdz6Y6f1cn
 HFx1rfS4j89rKr1abCN1FW7RSzfAKT/QbdmlcJZx6G2x08ASO6S7PxT+W8t1FyhomWTE
 JDJutumG6F3Db3/mmeP3ySv1MYb8u65oBbLhKFSU/oaxbUeWVlnmPu7BVDyR2klArLfw
 ZlEA==
X-Gm-Message-State: AOJu0Yy2gc2kIBd9CQYPbPUXtkvav47SXxfMBBUp4bcqItmtOh2vs9fj
 XHL1zLoPwaCpiWRfqg7FAcNmKNM1tzyXt+qh2abE3onlBKgHaEnM/F+gL5IRBvECUxuhzWuuVDc
 =
X-Google-Smtp-Source: AGHT+IFRmJy4LLLwoc9xursZaSSkVSyUDqoS1LqGhHx38CBPjkRpgA5yCMno+nwr6Ja4XhSQvasl3w==
X-Received: by 2002:a05:6602:2cc8:b0:83a:f447:f0b9 with SMTP id
 ca18e2360f4ac-83b56712446mr2351611239f.9.1730742698058; 
 Mon, 04 Nov 2024 09:51:38 -0800 (PST)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4de04977b30sm2005288173.116.2024.11.04.09.51.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 09:51:36 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Martyn Welch <martyn.welch@collabora.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
Subject: [PATCH v3 13/19] boot: Update pxe bootmeth to record images
Date: Mon,  4 Nov 2024 10:51:04 -0700
Message-Id: <20241104175110.1048449-14-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241104175110.1048449-1-sjg@chromium.org>
References: <20241104175110.1048449-1-sjg@chromium.org>
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

Record images loaded by this bootmeth.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v3:
- Use the helper function

 boot/bootmeth_pxe.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/boot/bootmeth_pxe.c b/boot/bootmeth_pxe.c
index b2873075ba5..b91e61bcbc4 100644
--- a/boot/bootmeth_pxe.c
+++ b/boot/bootmeth_pxe.c
@@ -135,6 +135,9 @@ static int extlinux_pxe_read_file(struct udevice *dev, struct bootflow *bflow,
 		return log_msg_ret("spc", -ENOSPC);
 	*sizep = size;
 
+	if (!bootflow_img_add(bflow, file_path, type, addr, size))
+		return log_msg_ret("pxi", -ENOMEM);
+
 	return 0;
 }
 
-- 
2.34.1


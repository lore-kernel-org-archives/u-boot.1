Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B876FD3C533
	for <u-boot@archiver.kernel.org>; Thu, 17 Oct 2024 23:29:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 216FB89289;
	Fri, 18 Oct 2024 01:25:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fe+uDLwH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E89689119; Fri, 18 Oct 2024 01:25:13 +0200 (CEST)
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com
 [IPv6:2607:f8b0:4864:20::d2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3F64189083
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 01:25:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-83aacecc8efso55091039f.0
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 16:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729207510; x=1729812310; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VEtbGzRTxRvQQj5x/dRYctjpDEXpWlygAmoIE1OujlE=;
 b=fe+uDLwH2sWxNQgNyjQ8xiijRNGV70AfOBsbNfd7IdM/aBllLwcWW0hENoEvNO1HBZ
 /PhYyjdMPoy5ZHcb5YcnVgYlMh3w8g75Q570aSZ1GvfUpaT2Rp65oaDK1E7hBk5zgm80
 6MSm6xkL7fsLQkUuKbQ1cTlwr13Yo8rY9aDug=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729207510; x=1729812310;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VEtbGzRTxRvQQj5x/dRYctjpDEXpWlygAmoIE1OujlE=;
 b=XnhyqNoNj22unrysmfZ8fIuMSzyXFCbGyAkqRJ0Im5vlu9NOvjkgnwpN23PLozatuQ
 ZjIDjdURe7hdWSMvu/cGXHAtyFz84AU/09LeJJkXMOpWWNwQdQvkJlCIAevg4Qw4OXdt
 rvQKgj+xr5/lLQGjYUSPFk6duc88suwZwcFt9IdAtKwTPJuopRul8n1KOsDq1MWwPJp4
 kTl1gCc+lPfBgiFPCWqdJc7JGUPX+E3Gcs86jiqq3/ilLStV89AxzS6x8ebqvH8/aOoZ
 KBeHKUgmWAGAG8QKbYgK91qpjcxWy+2oR31GsKOYBE4cwk7AqSnyb6IB7CXAObbPBJge
 b9Mg==
X-Gm-Message-State: AOJu0YyDYRKMyaZ2QiecjQrPY3lrB42JlaIbWYOagbD8sheULaRGX7Qx
 Et8ux3Kqn7R9nf8/j4DHaU2WvK15WkzVCzy9By9KaLWIuvgK8MV6kM1FMuC3ZNcKxEwwXxDp8N8
 =
X-Google-Smtp-Source: AGHT+IFVEnTrU+ZzM7Q0MRj9rnF9m6OoSbth9LXS6jGq+bef0+gS7Wiv+jUp9otkIYKSpjlcIu/S4Q==
X-Received: by 2002:a05:6e02:b49:b0:3a0:abd0:122 with SMTP id
 e9e14a558f8ab-3a3e5306a8emr33874495ab.8.1729207509904; 
 Thu, 17 Oct 2024 16:25:09 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4dc10ba3454sm117117173.79.2024.10.17.16.25.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2024 16:25:09 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Shantur Rathore <i@shantur.com>
Subject: [PATCH 28/34] efi: Check the filename-allocation in the network path
Date: Thu, 17 Oct 2024 17:24:07 -0600
Message-Id: <20241017232413.724808-29-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241017232413.724808-1-sjg@chromium.org>
References: <20241017232413.724808-1-sjg@chromium.org>
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

 boot/bootmeth_efi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/boot/bootmeth_efi.c b/boot/bootmeth_efi.c
index e1e378481b9..548d5f71b2a 100644
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


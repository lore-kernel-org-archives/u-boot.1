Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75CBBD68BDC
	for <u-boot@archiver.kernel.org>; Fri, 15 Nov 2024 23:21:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E4B089705;
	Sat, 16 Nov 2024 00:20:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="BC35xNsh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6490F896FC; Sat, 16 Nov 2024 00:20:10 +0100 (CET)
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com
 [IPv6:2607:f8b0:4864:20::d35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F3CB089701
 for <u-boot@lists.denx.de>; Sat, 16 Nov 2024 00:20:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd35.google.com with SMTP id
 ca18e2360f4ac-83aae6aba1aso3496639f.2
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 15:20:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1731712804; x=1732317604; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CxbzLq1G1CK899RbJpo4VM+FvMqMwqgAtbgk2jnSh7U=;
 b=BC35xNshrJzVus5UJaeT1mzFHLZ6rGvYA1RKbVNe8DGWaTMc3PrwkKymbqmWBY5bVy
 VqbW1Ih3LjDSWsble9KNSdCYhLhTi1SMDLYOYr4/t+JIG6usHwSrRvMac/jTMS0i6oL5
 V3y6cegvC77/ZapXGe8UJhjMRB8SL6d//qXB8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731712804; x=1732317604;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CxbzLq1G1CK899RbJpo4VM+FvMqMwqgAtbgk2jnSh7U=;
 b=IallkwlEM4kHLC2JGOxwSCawjiVTMlp33oeEfouNax2+GTahw1PfM+SjBV6uArrXB2
 KBu0mvrajk7ub0mQiczyape45TZagXpDiVZS1D99VED1NrUafYVCOJ9x3U60LuoZzELe
 uhHY18M2SEzxLlkm+A8QD6o7x94U3ShF8yeTnVcJ8Rqh3qJikBMBnpPzIYRRPX5hQQO1
 GjpvJJIRkjru8VJscfUWJ55JxiQPRZDBk7PJ4vrEamhIgc5iPnEmQv9VpJVLuaurudsI
 V41nz018aLB8HHCtkpfIT2G6AdfRyQMxelm9N6Cv3CiMGoNAInHpO2NGtcfKg+mTjn8H
 AvZw==
X-Gm-Message-State: AOJu0Yz5zZCCH0BpcBd4c+x2kWvzdCXzrF3R7B/oQ0SDE0GwAxiMW9ky
 SrJxQkAMGsZsOjn9H3pk+OHJBI9Uq/+NA2Mi8R7SaO53ejEf1cfsAlLQQ9ZsqGD4QhzzVddsYX0
 =
X-Google-Smtp-Source: AGHT+IGY8HmS5f66s5pOnhpy7UlEPB6SMSXZPB/yPwy24fLmVkE86dgZkGUKOwZSsRbF7zypBgjWwg==
X-Received: by 2002:a05:6602:15c5:b0:83a:a305:d9f3 with SMTP id
 ca18e2360f4ac-83e6c17fffcmr625231939f.12.1731712804378; 
 Fri, 15 Nov 2024 15:20:04 -0800 (PST)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e0756def0dsm582798173.142.2024.11.15.15.20.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Nov 2024 15:20:03 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Shantur Rathore <i@shantur.com>
Subject: [PATCH v4 11/19] bootmeth_efi: Check the filename-allocation in the
 network path
Date: Fri, 15 Nov 2024 16:19:18 -0700
Message-Id: <20241115231926.211999-12-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241115231926.211999-1-sjg@chromium.org>
References: <20241115231926.211999-1-sjg@chromium.org>
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

(no changes since v2)

Changes in v2:
- Change the tag to bootmeth_efi

 boot/bootmeth_efi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/boot/bootmeth_efi.c b/boot/bootmeth_efi.c
index f711b9d0598..a2998452666 100644
--- a/boot/bootmeth_efi.c
+++ b/boot/bootmeth_efi.c
@@ -252,6 +252,8 @@ static int distro_efi_read_bootflow_net(struct bootflow *bflow)
 	if (!bootfile_name)
 		return log_msg_ret("bootfile_name", ret);
 	bflow->fname = strdup(bootfile_name);
+	if (!bflow->fname)
+		return log_msg_ret("fi0", -ENOMEM);
 
 	/* do the hideous EFI hack */
 	efi_set_bootdev("Net", "", bflow->fname, map_sysmem(addr, 0),
-- 
2.34.1


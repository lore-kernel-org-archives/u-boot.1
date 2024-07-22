Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FE17C3DA5D
	for <u-boot@archiver.kernel.org>; Mon, 22 Jul 2024 17:55:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C54D688005;
	Mon, 22 Jul 2024 19:55:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="K4HTNL4Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA30C88214; Mon, 22 Jul 2024 19:55:39 +0200 (CEST)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com
 [IPv6:2a00:1450:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E261E87919
 for <u-boot@lists.denx.de>; Mon, 22 Jul 2024 19:55:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-52efdf02d13so2749203e87.2
 for <u-boot@lists.denx.de>; Mon, 22 Jul 2024 10:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721670937; x=1722275737; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=gbxiNAe9ge9vMpxvRzNb2XHKnB94hP5RvzTnLVeCG74=;
 b=K4HTNL4YGTfbpCTt6btNMGnbfGJcsJ8TfDE+iMMvRP/nqEnwn8C9mGe+vBuBcTWjcA
 uIfexO5aD/FSMXwrTbHcgjy73cnSqnl0atk7QhSZR1wXl0aLe1XDqJ4Tqh26D6K8GKaq
 E932IfOTlIYMOtiUDMQ1uKz9H7DoFoSun5/ivfVQvVOYL3ybuawbNgEch9UnLRIRcyjh
 dQ5y5dNbzNorhe6HH0b/Bge8973Ex7n+ONBZ0X2AbjA+aiVZdPRx6Y+js5VloL2qTxU4
 1AqmvLktsUwUOqCskU7rtfNJ5fSEXMWrUzkYQqYqGM8h5bux4BLGCe0rajADouqnlUVy
 K+Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721670937; x=1722275737;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gbxiNAe9ge9vMpxvRzNb2XHKnB94hP5RvzTnLVeCG74=;
 b=ClBlXjrdGMQ+wxmo8vjq/Tx4BgIGPYbXFD4rEas4lOBVV2hsT0P0sssQkCi8irRIBJ
 zHVxREZc7806MBTOPhswIiG3SgXKhqcR4NV/kr2RECRQ8/tzvHJUPyiE8pzWpIUHaIW1
 HtjGfUzHW45tICq2+SGgmHT4lCYJa8WSwbiZzi0rwkWarVB2l8VnK+Of2yllJNSKwAgw
 32LTdlEongBmlCQ1D0QcK34w9Zxgx2CYg11o3wgKRM7dubRCCU2yI9R5E9/9y4aSvyQb
 yyEeVa9oFyt+kGbfwl/EH+pHwTCkCN/WEkquNsycx0dbtjiM11OT6yvpSWZQ2PzqPBQg
 WJPA==
X-Gm-Message-State: AOJu0YxpwH6bIoJ5MKS1Klm/Njnqp6UwzQq2iTxmnjoeQEcFDirYhq6K
 +rCRc8Er7m3VBU+8NklMQXKb4V9CYPELOjiGnq/YS8AE/En8zJKisqT7zkOsMaA=
X-Google-Smtp-Source: AGHT+IGmOj9g2qUriGQDgF/TAef3bAvVQ/FKA1GR+UePTIhxSSgJXFmdo7847iFyd86eJJZp0XIGZQ==
X-Received: by 2002:a05:6512:32c5:b0:52e:936e:a237 with SMTP id
 2adb3069b0e04-52efb53bd95mr6206465e87.16.1721670937135; 
 Mon, 22 Jul 2024 10:55:37 -0700 (PDT)
Received: from cymric.caleb.rex.connolly.tech ([90.187.152.45])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7a3c91db91sm449880466b.152.2024.07.22.10.55.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jul 2024 10:55:36 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
To: Caleb Connolly <caleb.connolly@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH] efi_loader: add /dtbs search path
Date: Mon, 22 Jul 2024 19:55:23 +0200
Message-ID: <20240722175532.184842-1-caleb.connolly@linaro.org>
X-Mailer: git-send-email 2.45.2
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

Add an additional search path /dtbs, this is where dtbs are installed on
postmarketOS and potentially other distros.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 lib/efi_loader/efi_fdt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/efi_loader/efi_fdt.c b/lib/efi_loader/efi_fdt.c
index 86ba00c2bdd9..4777943b80df 100644
--- a/lib/efi_loader/efi_fdt.c
+++ b/lib/efi_loader/efi_fdt.c
@@ -42,8 +42,11 @@ int efi_get_distro_fdt_name(char *fname, int size, int seq)
 		break;
 	case 2:
 		prefix = "/dtb/current";
 		break;
+	case 3:
+		prefix = "/dtbs";
+		break;
 	default:
 		return log_msg_ret("pref", -EINVAL);
 	}
 
-- 
2.45.2


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8828D68BDA
	for <u-boot@archiver.kernel.org>; Fri, 15 Nov 2024 23:21:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9520489720;
	Sat, 16 Nov 2024 00:20:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="n7NU5Jke";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E8F78970F; Sat, 16 Nov 2024 00:20:14 +0100 (CET)
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com
 [IPv6:2607:f8b0:4864:20::d33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 750A3891A5
 for <u-boot@lists.denx.de>; Sat, 16 Nov 2024 00:20:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd33.google.com with SMTP id
 ca18e2360f4ac-83a9cd37a11so81831339f.3
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 15:20:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1731712809; x=1732317609; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=29+X5zFfVkx1e0/vmcjmG3TVfesIH1Ka6qom6ccy0Jo=;
 b=n7NU5JkeIo62UAB9M7KbexbfUO5UaXqDUInWLM3p9BPGXIS9/zXK2DVsrMFkUDxJ1+
 /wpGCxUlf1MLDNvQfecmi6CP07JNMgKrsKBQcH4SH3afM7bvfODz9tHhaJo1cSRV+3CF
 A/H1kY4wCTMHD9eLgkWl+99cXuVQC38iZMSB0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731712809; x=1732317609;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=29+X5zFfVkx1e0/vmcjmG3TVfesIH1Ka6qom6ccy0Jo=;
 b=o8zuF9S8G3eMtHpwQ0pS6PKqYcNHQ9uLaboFk1jQn4PXsfXEEJA8K4CCeCFKgux0Lv
 n57rWU4QBemcqy0h/UeN66d4HlX9AKpHUhdFnFOoozpTVrFv3mfh6oQfe6HYMUeZRf+U
 F1XYLwKNvZuZO3BqK+vJzYVcxAMUEqnVFA7ECeCuA0KDl9ZbK6bs+HKYpExnLigTqIFo
 qZudjiLQlzzKVgERoNfqqjqWQk0LPnol0/57608RKXY58nVQxfs+k23AtbXujQJDyL6R
 X1jbasf7B9Ep04XGrgA+ssoBrWEvt1HGF21gIVuBNbIpLsLGfmVSf68Uk+fGjEXC7Fg0
 x+8w==
X-Gm-Message-State: AOJu0Yyj7IW8ox+U9uNGBmQjeUnL5dItd3e3zvoq0a9hAynu4ua108R5
 if1QOYhcTX3krJO9S90tDr02xwKURulwI5f9N7ZF7pnIAJ05xAHhvLfn+GZErP+kPPBLC77ycEo
 =
X-Google-Smtp-Source: AGHT+IHfm3731qsnWp5vvuqhldkZWT0wSvL678Gvnkf3waxFbdl6in39+jUnbgyuVEQPIrS4vzu0rg==
X-Received: by 2002:a05:6602:6c1a:b0:83a:acba:887a with SMTP id
 ca18e2360f4ac-83e6c1e2669mr525753939f.0.1731712809447; 
 Fri, 15 Nov 2024 15:20:09 -0800 (PST)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e0756def0dsm582798173.142.2024.11.15.15.20.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Nov 2024 15:20:08 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Martyn Welch <martyn.welch@collabora.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
Subject: [PATCH v4 13/19] boot: Update pxe bootmeth to record images
Date: Fri, 15 Nov 2024 16:19:20 -0700
Message-Id: <20241115231926.211999-14-sjg@chromium.org>
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

Record images loaded by this bootmeth.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v3)

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


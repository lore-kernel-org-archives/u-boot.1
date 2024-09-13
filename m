Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBBB3FA3737
	for <u-boot@archiver.kernel.org>; Fri, 13 Sep 2024 10:00:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2925A88965;
	Fri, 13 Sep 2024 11:57:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="RCUDPHWG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 08CF488D16; Fri, 13 Sep 2024 11:57:35 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C97AC88CC8
 for <u-boot@lists.denx.de>; Fri, 13 Sep 2024 11:57:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a8a7cdfdd80so106791966b.0
 for <u-boot@lists.denx.de>; Fri, 13 Sep 2024 02:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1726221445; x=1726826245;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=md9mav7G8ivFcb3vIm88GhY4xo0dNUxOtAaZPAgiaTw=;
 b=RCUDPHWGs26TuIENRwX38kZlyUcZZgYoeQU0WOpPkBqbpYfNHJLuerNpqok144JkFz
 pDE+AsTFa62mJVzubhvT3KrjZe1Gqy9wsCPWKjynpPPLv1nnnu4+T0fJzwynllbyJJ4e
 x5wN0VWGH+ZFBrt2B5k7JA+O6P/eQ1Vb2vCb8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726221445; x=1726826245;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=md9mav7G8ivFcb3vIm88GhY4xo0dNUxOtAaZPAgiaTw=;
 b=rFeVcLBU98n+c2V+FaA0cK1G5XNzilNyEz/t6Xgo4+iP+WAlzxYgrUaYkCPJiXJl0z
 Os+CRgckkrEPAMkWkF+vZt7RaCNNi+s5xSbwRt5RuXBXmRjJqonrv6ieB6SJf4uv0h72
 VUlzfGSf5i8Uy4OQfkXFU6SYETcUXFrFWfGx8cfsWpZHg2POQVnyWkwUCxU6xNjGGqh8
 cFvFPJb5Szkx9kGIWvEpMyYTN4ytibubvidqfSagNmutaXcOUCucrtNG6B0YUe0deYgj
 OSOEjAHOZ3NtzY0zUW9jy607z84oTKHzlFmXu5dEcIR/Zi4ORuTJW1+MNp9va9UMnRW+
 kuDw==
X-Gm-Message-State: AOJu0YzZfIoUfz1MWng6zN0T+PxQt/Xb1V9mh4ktaQqx0lCXdkasvozc
 Ymt9wbZmKgcL2orXIsi5/rYjORKjaymUwJV3OEsIr0HnUTcqz+cdQfvSbUqaG/dht1Ffon7Iun8
 fquk=
X-Google-Smtp-Source: AGHT+IHs+KCyP3FE1/0r9HxWeTN7sbkTynqJianAtD2X0EUNDJ9pJy7FwVMAjXNGDfEL/ddKZ8WeZg==
X-Received: by 2002:a17:907:6e8b:b0:a89:f1b9:d391 with SMTP id
 a640c23a62f3a-a9047c9c504mr149174166b.14.1726221444987; 
 Fri, 13 Sep 2024 02:57:24 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it
 (host-87-4-102-18.retail.telecomitalia.it. [87.4.102.18])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d25cee72bsm863224766b.173.2024.09.13.02.57.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Sep 2024 02:57:24 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: Fabio Estevam <festevam@denx.de>, linux-amarula@amarulasolutions.com,
 michael@amarulasolutions.com, Miquel Raynal <miquel.raynal@bootlin.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Devarsh Thakkar <devarsht@ti.com>, Nikhil M Jain <n-jain1@ti.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 21/26] boot: fdt_simplefb: add a debug message
Date: Fri, 13 Sep 2024 11:56:03 +0200
Message-ID: <20240913095622.72377-22-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240913095622.72377-1-dario.binacchi@amarulasolutions.com>
References: <20240913095622.72377-1-dario.binacchi@amarulasolutions.com>
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

The printed information is useful when adding support for the simple
frame buffer to a board.

Co-developed-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

 boot/fdt_simplefb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/boot/fdt_simplefb.c b/boot/fdt_simplefb.c
index 53415548459a..22aaad9d5c5b 100644
--- a/boot/fdt_simplefb.c
+++ b/boot/fdt_simplefb.c
@@ -61,6 +61,8 @@ static int fdt_simplefb_configure_node(void *blob, int off)
 		return -EINVAL;
 	}
 
+	debug("Simple frame buffer at 0x%lx, pixels %dx%d, format %s\n",
+	      fb_base, xsize, ysize, name);
 	return fdt_setup_simplefb_node(blob, off, fb_base, xsize, ysize,
 				       xsize * (1 << bpix) / 8, name);
 }
-- 
2.43.0


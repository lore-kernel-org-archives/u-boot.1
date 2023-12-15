Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61F68C41535
	for <u-boot@archiver.kernel.org>; Fri, 15 Dec 2023 23:54:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B14FE87B90;
	Sat, 16 Dec 2023 00:54:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="dcO7ZdQr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3EA5887B9A; Sat, 16 Dec 2023 00:54:49 +0100 (CET)
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com
 [IPv6:2607:f8b0:4864:20::834])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BD08F87B7D
 for <u-boot@lists.denx.de>; Sat, 16 Dec 2023 00:54:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qt1-x834.google.com with SMTP id
 d75a77b69052e-4259a275fa9so10085331cf.2
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 15:54:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702684485; x=1703289285; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=SpkgVoRbflbi/KNiv5wNO8mtTc80JwBBnu1JK4Rf1X8=;
 b=dcO7ZdQrhh3szlLjevBh8A5wCBSbDhXpqFUEB/SvWBacL/JCRaOaHND47doxvHrlhs
 +a1fm6aH8zvwGYmVHjvWSxTgBxcdNvl8cbuUM0InRrPgiO392O7Yqi1oFj2Rt7qrREBs
 f0W0dq+5FO0d7gLZQKngQKnU1aCuiqYR2rcaI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702684485; x=1703289285;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SpkgVoRbflbi/KNiv5wNO8mtTc80JwBBnu1JK4Rf1X8=;
 b=KC4drHutqjU/YH/6TSXMesbV/XAQHirQDem0aQH+3/BNkbvz4LDpusInS3lSOv+uld
 M9iPNAPh+zXNDU3VrKXOZ4PqwA6ILwkqHfMQnqn7+h2csO18IiC35OsczNRvtu+/HWii
 wEi9BsgKjoJU4olG87P7MReg52W2Re7wotTz8A4pT6NHYVGJg0y8CtmwTu8dQXf+/NRi
 xIdpNULmSPmX79af8EU4zJuS/aiNxZaZFcBROKLOwGbuahLb2AJ0DQ6+iFZVKp6p3nnP
 RC9F6x5OdTRqSt0LceOIrY2kKkYcWtvNO4Dl8YS+JihAAotyydxcNP7GLoQIvnrJQGwQ
 GO+A==
X-Gm-Message-State: AOJu0YzDm9ETBVNaI+3uVefhL6IXzxgUq8eOnhXqyqvTs2Yiu4cljt59
 UFdbBojZAREaWcbIs2ElFnMPigrDk7gC//Wlsek=
X-Google-Smtp-Source: AGHT+IFgIkw2BKeYrEJetNLVAjt/oP8+YpqhDejvwyHMbGQeaHRcC19W0RllOelruZJqi14McSORrg==
X-Received: by 2002:a05:622a:1903:b0:425:4043:41d0 with SMTP id
 w3-20020a05622a190300b00425404341d0mr19522530qtc.124.1702684485326; 
 Fri, 15 Dec 2023 15:54:45 -0800 (PST)
Received: from kea.bld.corp.google.com ([100.107.108.219])
 by smtp.gmail.com with ESMTPSA id
 bq12-20020a05622a1c0c00b00419732075b4sm2414261qtb.84.2023.12.15.15.54.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Dec 2023 15:54:45 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: dianders@chromium.org, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, Eddie James <eajames@linux.ibm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Safae Ouajih <souajih@baylibre.com>
Subject: [PATCH] boot: Support decompressing non-kernel OS images
Date: Fri, 15 Dec 2023 16:54:16 -0700
Message-ID: <20231215165415.1.If0fab868c705be493705cf2609f17e3c85b1cefa@changeid>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
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

Sometimes the kernel is built as an EFI application rather than a
binary. We still want to support compression for this case.

For arm64 the entry point is set later in the bootm_load_os() function,
since these images are typically relocated due to the 2MB-alignment
requirement of arm64 images. But since the EFI image is not in the same
format, we need to update the entry point earlier.

Set the entry point always, for kernel_noload to resolve this problem.
It should be harmless to do this always.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/bootm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/boot/bootm.c b/boot/bootm.c
index 301cfded05c..75a94d97643 100644
--- a/boot/bootm.c
+++ b/boot/bootm.c
@@ -643,6 +643,7 @@ static int bootm_load_os(struct bootm_headers *images, int boot_progress)
 		if (!load)
 			return 1;
 		os.load = load;
+		images->ep = load;
 		debug("Allocated %lx bytes at %lx for kernel (size %lx) decompression\n",
 		      req_size, load, image_len);
 	}
-- 
2.43.0.472.g3155946c3a-goog


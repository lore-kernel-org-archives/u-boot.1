Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E75BDC4332F
	for <u-boot@archiver.kernel.org>; Tue,  7 Nov 2023 14:49:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 33B9C87438;
	Tue,  7 Nov 2023 15:49:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="IZCdQoCK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EBE1887257; Tue,  7 Nov 2023 15:49:28 +0100 (CET)
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com
 [IPv6:2607:f8b0:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E02CC86470
 for <u-boot@lists.denx.de>; Tue,  7 Nov 2023 15:49:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12d.google.com with SMTP id
 e9e14a558f8ab-35961c61febso16687965ab.1
 for <u-boot@lists.denx.de>; Tue, 07 Nov 2023 06:49:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699368565; x=1699973365; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PaV9Hs3+cyYm1Gr06GB3mxSuR25FjGRVsz8hlTL4IWg=;
 b=IZCdQoCKvvv1XEEqu79mJnYVUAS2YIG5ARlNjNY1HG+aS8DHHegFFsm4/z7uIWY+0N
 Hf+2bayCCE0xBj3OuEkXKPDo6hP5BOSiHhSyep6CMgn6dHuCalTk+BOp9OFdAyRv4JVh
 C76GoLXRPVYUUzmJ5tTusafkXuzZR5i2DvZ7c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699368565; x=1699973365;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PaV9Hs3+cyYm1Gr06GB3mxSuR25FjGRVsz8hlTL4IWg=;
 b=tX11f+2FcUj+206esdK+tgjpl9LmktuKEBIaXzdeuHzpN+WMuBt10FMqlWJGlp1rhV
 PgcSKpJMnXyJMYeHJFSlxNI/4bi9pQEdRwpkrvlXnzXVWZtuk1gFGb3WKXTIx8LTWBdd
 7/zsPQSXi8hnps77iGROilPtGjvm7h46jcL25Awk8F95ehI6M2caBCuyfU8OkDSgrJog
 4zgHG0Txn8HQmTtetz/x7HWRjXWDdCuIgJDsoYoJNd7ahiQSCWfSXN0ZN+4ZgHQL8k3Y
 y+NAr6XT30CwhVVMGqCvptJXUB3VIIygnJsBaxlnVKtuZ5uL4z2PX5g/ZtqkQEbiueBI
 KH+Q==
X-Gm-Message-State: AOJu0YwzadtOuCN5boIyuAb1kAUrBAhdiWnK4RIH4Tt+98KYcwiCgBQV
 V7aPIR2HmUXxz1CezImHkA4RDQ==
X-Google-Smtp-Source: AGHT+IGnmEGYuVlxI7gvheK7jw/EXDkfYArur1P02yryv5K8v6LTdN1/sV0kFS+mgJRZO7Pv54ming==
X-Received: by 2002:a05:6e02:1c0e:b0:350:ef09:ff82 with SMTP id
 l14-20020a056e021c0e00b00350ef09ff82mr3481236ilh.24.1699368565654; 
 Tue, 07 Nov 2023 06:49:25 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 b16-20020a05663801b000b0045a66a26208sm2815200jaq.128.2023.11.07.06.49.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 06:49:24 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: linux-arm-kernel@lists.infradead.org
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>,
 Masahiro Yamada <masahiroy@kernel.org>, Simon Glass <sjg@chromium.org>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>,
 Nicolas Schier <nicolas@fjasle.eu>, linux-kbuild@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/3] arm: boot: Move the single quotes for image name
Date: Tue,  7 Nov 2023 07:48:50 -0700
Message-ID: <20231107144917.48304-3-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
In-Reply-To: <20231107144917.48304-1-sjg@chromium.org>
References: <20231107144917.48304-1-sjg@chromium.org>
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

Add quotes where UIMAGE_NAME is used, rather than where it is defined.
This allows the UIMAGE_NAME variable to be set by the user.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v4:
- Add a patch to move the single quotes for image name

 scripts/Makefile.lib | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 68d0134bdbf9..1a965fe68e01 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -487,14 +487,14 @@ UIMAGE_OPTS-y ?=
 UIMAGE_TYPE ?= kernel
 UIMAGE_LOADADDR ?= arch_must_set_this
 UIMAGE_ENTRYADDR ?= $(UIMAGE_LOADADDR)
-UIMAGE_NAME ?= 'Linux-$(KERNELRELEASE)'
+UIMAGE_NAME ?= Linux-$(KERNELRELEASE)
 
 quiet_cmd_uimage = UIMAGE  $@
       cmd_uimage = $(BASH) $(MKIMAGE) -A $(UIMAGE_ARCH) -O linux \
 			-C $(UIMAGE_COMPRESSION) $(UIMAGE_OPTS-y) \
 			-T $(UIMAGE_TYPE) \
 			-a $(UIMAGE_LOADADDR) -e $(UIMAGE_ENTRYADDR) \
-			-n $(UIMAGE_NAME) -d $< $@
+			-n '$(UIMAGE_NAME)' -d $< $@
 
 # XZ
 # ---------------------------------------------------------------------------
-- 
2.42.0.869.gea05f2083d-goog


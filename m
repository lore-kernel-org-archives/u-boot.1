Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7322BE6F06C
	for <u-boot@archiver.kernel.org>; Fri,  1 Nov 2024 15:27:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8CD8B89308;
	Fri,  1 Nov 2024 16:26:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="iN6jckzZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 62FE5892CF; Fri,  1 Nov 2024 16:26:37 +0100 (CET)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8103089305
 for <u-boot@lists.denx.de>; Fri,  1 Nov 2024 16:26:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5cec831fcafso166931a12.0
 for <u-boot@lists.denx.de>; Fri, 01 Nov 2024 08:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730474794; x=1731079594; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nBfnH7LRa1wmXlnGKLPlGvt83UHs5xbCaYXMlmnt34g=;
 b=iN6jckzZ40zdmPoAVvtrd4SEzpIutYbtRCA8juJeLJGyZeZ21lFe29DPtKm48smtUj
 VbYk4ZMl45CLF3HeG2K+azQFNuG0ELL17B5l8wLVVViYiT0eUhMSCEPczdmTPma9v10h
 pR7B9poDeVFcuhf2Nvmf6P58tvPIkKnETVK94=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730474794; x=1731079594;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nBfnH7LRa1wmXlnGKLPlGvt83UHs5xbCaYXMlmnt34g=;
 b=FiCIKSWP6GsAUm0S8EdbRwfjiSn2CjCK7TONdI65pD/wqlVUtuTaFsVHE0b6xdfx8a
 iiOLwmZn1DmQZ8iPvVFVmTV3lVHvLE9/HrtONMGO5Tr1oVxNf+0DSnG1ZNC+qQeDj7U1
 xMAyABegI0OZqosj1ZamII8LdTk6gSfuuyuWCmLLQ1uR5NT/KVpCAd9sutScN9bpqwyE
 GXopNf1OynGNEZv5diVPGU3ZhVzw83enDMhn1tNZZEHS7Ti3JhzTC0s+QWfwBjEuymwq
 RnoRSgg/w1KNNQAVRDxxZRMhBozBoKPXz8cCC8Hgw9hdtcEvQhfNHyp6L4X8HlMSeBce
 KzKg==
X-Gm-Message-State: AOJu0YyDJmOPvOj5HTjHcs6faHX13uBC61OM01RAwHazvSF1bRstThwU
 X9El/amOJz/TYUaMOpLa0+d46Rp48hpJWdC/v0bBsXCAKEf9eTW0PuHtPhWje4pjK663yTKi/FF
 vxLmB
X-Google-Smtp-Source: AGHT+IEZYqBVH8gAbTY3tTTI+qbVrG1yvKw6jeb5XdjRs5mtjObn/M5ZDmzCc6YwtXt6n+J4oJ5WEg==
X-Received: by 2002:a17:907:3d90:b0:a9a:26dd:16bc with SMTP id
 a640c23a62f3a-a9de5c91003mr2506834766b.5.1730474793814; 
 Fri, 01 Nov 2024 08:26:33 -0700 (PDT)
Received: from chromium.org ([87.215.50.114]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9e5649454csm190269466b.8.2024.11.01.08.26.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Nov 2024 08:26:33 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Mark Kettenis <kettenis@openbsd.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH v9 08/11] efi_loader: Drop sandbox PXE architecture
Date: Fri,  1 Nov 2024 16:26:06 +0100
Message-ID: <20241101152614.238747-9-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241101152614.238747-1-sjg@chromium.org>
References: <20241101152614.238747-1-sjg@chromium.org>
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

Rather than returning 0, just return an error, since sandbox is not used
with PXE at present.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v9)

Changes in v9:
- Add new patch to drop sandbox PXE architecture

 lib/efi_loader/efi_helper.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/lib/efi_loader/efi_helper.c b/lib/efi_loader/efi_helper.c
index ab5678eb66c..bf96f61d3d0 100644
--- a/lib/efi_loader/efi_helper.c
+++ b/lib/efi_loader/efi_helper.c
@@ -91,8 +91,6 @@ int efi_get_pxe_arch(void)
 		return 0x19;
 	else if (IS_ENABLED(CONFIG_ARCH_RV64I))
 		return 0x1b;
-	else if (IS_ENABLED(CONFIG_SANDBOX))
-		return 0;	/* not used */
 
 	return -EINVAL;
 }
-- 
2.43.0


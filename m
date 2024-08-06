Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73AE3C3DA64
	for <u-boot@archiver.kernel.org>; Tue,  6 Aug 2024 13:03:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E24388A8C;
	Tue,  6 Aug 2024 14:59:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="QX1m3k8N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 08EB888AAD; Tue,  6 Aug 2024 14:59:46 +0200 (CEST)
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com
 [IPv6:2607:f8b0:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1E03488A64
 for <u-boot@lists.denx.de>; Tue,  6 Aug 2024 14:59:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12e.google.com with SMTP id
 e9e14a558f8ab-39b27935379so2106375ab.1
 for <u-boot@lists.denx.de>; Tue, 06 Aug 2024 05:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722949177; x=1723553977; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mcqdspIV1KAozzkZjC7tuKFIxWl7n8Tsb2c0EWujuyo=;
 b=QX1m3k8NcyW01KR29LRtJ25nJfMnfE1Tq72P5GF1AE2aP/xw6ZDbiIGoawe2kgaCw5
 u+HJnLfcmKR6Rrk/hOPm3t5qsK5iYlQlz9LXeNv1P5sjNfawqCW9Xn+YM7yrT+QbIJtP
 O0+3Yb7RruD7SfTBi6KeaI3Xs+etrSCZm4bCE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722949177; x=1723553977;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mcqdspIV1KAozzkZjC7tuKFIxWl7n8Tsb2c0EWujuyo=;
 b=e3EoPyBvxrsTekgVngpqm1+oUc4wXIUTfIW2x9CZ8u81Y69pLlgpRFBpX9iOyJ6ZjZ
 iFXRZdDbvH67sO9ktUIevxBUDmvPfC0RuUhW7Np/c5XYVLGmkqSfVc+H66VUb0/QnnOq
 virUj7aBBmr12CjledmFiisgV8iDIDM2XnZ2HSnuiH+t2zfDXdS25J1krEt0V+HlzyHZ
 5rzWKHEmV2dzpbwe7NL/sNejQERlnHSf5HqzucPdB6ssWgoU2i3bLo3dpVWNnUKHN5ZN
 3IUPIwBfgDJ6PDhIz8zb4zaSazaf/4GHCbIA1eiXaIX2TNPfJetKf1VEhvl7vNj+6kpa
 D8XQ==
X-Gm-Message-State: AOJu0YzbQ2KOf4lF/+eefkRdafWsJSWWY1Otsj/GkFvMGHIZvUbFvjPC
 GLys6QhjEl8KM+cfYlCHtMk53r39W56GT6AcSscHqJqHeuURB84Tak9gIKxr64vFee3Cx4rGOIM
 =
X-Google-Smtp-Source: AGHT+IFjWFDs4Z12R4jGCvcwi2j1+O4fVvfm56sbMLD12J5wHpm1aM7dLSOwQqzdaT3XYe3UI95rdg==
X-Received: by 2002:a05:6e02:ed4:b0:39b:3327:7c08 with SMTP id
 e9e14a558f8ab-39b33277c48mr101680135ab.8.1722949177028; 
 Tue, 06 Aug 2024 05:59:37 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39b20ab5ccdsm36871565ab.40.2024.08.06.05.59.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Aug 2024 05:59:36 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Caleb Connolly <caleb.connolly@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, Alexander Gendin <agendin@matrox.com>
Subject: [PATCH v2 21/39] test: mbr: Unmap the buffers after use
Date: Tue,  6 Aug 2024 06:58:32 -0600
Message-Id: <20240806125850.2316956-22-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240806125850.2316956-1-sjg@chromium.org>
References: <20240806125850.2316956-1-sjg@chromium.org>
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

This tests maps some local variables into sandbox's address space. Make
sure to unmap them afterwards.

Note that the normal approach with sandbox is to use a fixed memory
address in the RAM, to avoid needing to create a map for transient local
variables.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 test/cmd/mbr.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/test/cmd/mbr.c b/test/cmd/mbr.c
index 1a35ba3351c..8a4d61b2928 100644
--- a/test/cmd/mbr.c
+++ b/test/cmd/mbr.c
@@ -461,6 +461,9 @@ static int mbr_test_run(struct unit_test_state *uts)
 			"5P EBR+0x%04X: expected %#02X, actual: %#02X\n",
 			ebr_cmp_start + i, ebr_parts_ref_p5[i], rbuf[ebr_cmp_start + i]);
 	}
+	unmap_sysmem(mbr_wbuf);
+	unmap_sysmem(ebr_wbuf);
+	unmap_sysmem(rbuf);
 
 	return 0;
 }
-- 
2.34.1


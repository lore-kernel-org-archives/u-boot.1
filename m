Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91CBCC35274
	for <u-boot@archiver.kernel.org>; Mon, 18 Dec 2023 18:20:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 30B3A874F3;
	Mon, 18 Dec 2023 19:19:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="xEhexXOW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 55781874D9; Mon, 18 Dec 2023 19:19:51 +0100 (CET)
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com
 [IPv6:2607:f8b0:4864:20::f2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A64F870D5
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 19:19:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qv1-xf2e.google.com with SMTP id
 6a1803df08f44-67ab16c38caso28662106d6.1
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 10:19:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702923588; x=1703528388; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w0y7/FM8kxorN6EOJRQuzupPhG42wMtgQYbRCNlFYkw=;
 b=xEhexXOWgsesbeg47Nje4aK1mVScOT1Y1mT1tNfb7DND2Y4OwXtmzvC1RAoDDU+QUS
 6l3RTMpyoDmbHLU/38p3ygzkohjpFZri5vh4hK8/fuxT04Mhyc09PCPvoLfrnMCjJ5bM
 0xr45EXAujuW+cd5+wE2MT7rUzuGBEeaOUyEB/OD2qbdlcfvWhCAb4YDz1VgiMvmKSYr
 aprXLa4cFloS2frZJbBV9eiWyhBsnQWkeqibutiSpC9752ydlrpBjlYQ3pCuhlS7HVIq
 kug0KVjI3//9L0TnQdmjJ4YD1sUNei221Vqb4XAtMsR6HST9UPc4jnmd7tFF8KK0uSk2
 wIRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702923588; x=1703528388;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w0y7/FM8kxorN6EOJRQuzupPhG42wMtgQYbRCNlFYkw=;
 b=js8XrqIomoYtWeEIMrFl94pnaZLas/xdk1MEsMj0Bt08kwLLOjoygYol1938+MSQBR
 E+ftWuPwQlNblCLe95UlGpOocu45SKYsW2laURb05J/9uxmdbhJzcAKxSk0Pwqwv+SU6
 m6Sela6CgyFGw37SEzeDaxPFEvUTS+XeZEN6QDuJpxclklESD5CrMW63+mfinve24tbd
 gXItKuer8/C4GwKzXo0TGGVVh2+f7ji2/WTSo5FwTgeod9UzcQNtOR2X9YEsqlz+oulc
 T/VdoHWN4AlrTytTCKD6+XSSOG+AivYhAck42Lb9QODumSs9Sb6VDwUQVllEDUTLrewn
 ipbA==
X-Gm-Message-State: AOJu0YyaRDnCKew45NdnTeiRqAm/1WIAjfev/MRCpQZtB0KcbvXowcWG
 A0uFFQwLXuQ/m+xuq7rYzuio9K9taPuyGUZuNgk=
X-Google-Smtp-Source: AGHT+IG+URN8zEuctdewL3sEWPhoKNbEfHt9yTfuvEpTQsy/+223n/F7ZqeuXzGMlQ0v4+Km1mQYzA==
X-Received: by 2002:ad4:43ec:0:b0:67e:e816:8ef9 with SMTP id
 f12-20020ad443ec000000b0067ee8168ef9mr12099815qvu.85.1702923587937; 
 Mon, 18 Dec 2023 10:19:47 -0800 (PST)
Received: from ubuntu.localdomain
 (cpe688f2e182063-cm688f2e182060.sdns.net.rogers.com. [174.115.4.214])
 by smtp.gmail.com with ESMTPSA id
 dy7-20020ad44e87000000b0067f213933bdsm3046136qvb.2.2023.12.18.10.19.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Dec 2023 10:19:47 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de, ilias.apalodimas@linaro.org, sjg@chromium.org,
 jwerner@chromium.org
Cc: Raymond Mao <raymond.mao@linaro.org>, Bin Meng <bmeng.cn@gmail.com>,
 Nikhil M Jain <n-jain1@ti.com>
Subject: [PATCH v3 03/14] bloblist: Change the magic value
Date: Mon, 18 Dec 2023 10:18:48 -0800
Message-Id: <20231218181901.337515-4-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231218181901.337515-1-raymond.mao@linaro.org>
References: <20231218181901.337515-1-raymond.mao@linaro.org>
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

From: Simon Glass <sjg@chromium.org>

This uses a new value with spec v0.9 so change it.

Signed-off-by: Simon Glass <sjg@chromium.org>
Co-developed-by: Raymond Mao <raymond.mao@linaro.org>
Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
Changes in v2
- Update the bloblist magic to align to FW handoff spec v0.9.
Changes in v3
- Update the bloblist magic to align to FW handoff spec up to commit 3592349.

 include/bloblist.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/bloblist.h b/include/bloblist.h
index 5ad1337d1f..72c785411d 100644
--- a/include/bloblist.h
+++ b/include/bloblist.h
@@ -75,7 +75,7 @@
 
 enum {
 	BLOBLIST_VERSION	= 0,
-	BLOBLIST_MAGIC		= 0xb00757a3,
+	BLOBLIST_MAGIC		= 0x4a0fb10b,
 
 	BLOBLIST_ALIGN_LOG2	= 3,
 	BLOBLIST_ALIGN		= 1 << BLOBLIST_ALIGN_LOG2,
-- 
2.25.1


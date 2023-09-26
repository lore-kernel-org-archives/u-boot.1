Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 425E4E7E63C
	for <u-boot@archiver.kernel.org>; Tue, 26 Sep 2023 14:22:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E443F86EA6;
	Tue, 26 Sep 2023 16:16:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="IQyJbr3E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E40986D4F; Tue, 26 Sep 2023 16:16:13 +0200 (CEST)
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com
 [IPv6:2607:f8b0:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C893886D87
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 16:16:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x129.google.com with SMTP id
 e9e14a558f8ab-34961362f67so27308645ab.0
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 07:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695737761; x=1696342561; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VHOAyHuCW26KRtotUWTCFY+jQZxhUrdfeEtd5yt/BgM=;
 b=IQyJbr3Esmh9/A+ASDnrRIFvsd3j32zpL8Czzb4mNzkXzXaouq6huHfe85n1P2o7cy
 g+X19R95N1ZVTZZD3zKQD5WH6OPTXQlcGqOhdh98nm8cFnrf2biWBXGABWSl8yZ/oiKP
 khZpAJ419qW+RmVN5ivaDf0aPGgx4/4A67PcI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695737761; x=1696342561;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VHOAyHuCW26KRtotUWTCFY+jQZxhUrdfeEtd5yt/BgM=;
 b=iUliapjxCRnXn4eb8rXf9DbIAzqotJ2AkaTPAQZrGHNiCCmKjTIjId+FblwWT0fo4/
 qKheTCilFS5ypXcvTP4V/7E5j0xv+bTohcJPsyUeRejYLVD3cD4W1d94Li2198B0EtFA
 OkHgLGBg8ynIJz+yO7snZUEaVXhNmfQ5OL12q5qVs8mpUj0sbD592Vr/PqE9KvxU1ErM
 uj3A8oLlik7cXqk0DyJ2czbLXa3B6whvUVXAmmrCq7A0OosmbqZSwRpF6Gmx0kdIv8XA
 lYml4j+qmIYu+W64uxMUKK2Eu4L2EDWmBORYCRc7EebYXlgxFqDiu7lO8LgO0Z7gSssy
 rXRQ==
X-Gm-Message-State: AOJu0YzKiWBZOn0M38Ci8dTaS0gjkeJkAutc6f5sn4N9LaO75HfIP8FQ
 Z9eBkMuT5a/IK13fUTIVM7o6RrJb1/dgJ23uQ8I=
X-Google-Smtp-Source: AGHT+IEd2658zpaCOfne58cmarD2ewItpg2OeNmCge0pcF20Cluo5MSTxvaDKJKTq4+DDgjgNs4BAw==
X-Received: by 2002:a05:6e02:b47:b0:351:e7e:bf8 with SMTP id
 f7-20020a056e020b4700b003510e7e0bf8mr2350602ilu.7.1695737761456; 
 Tue, 26 Sep 2023 07:16:01 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 dp1-20020a0566381c8100b0043193e32c78sm3256764jab.152.2023.09.26.07.16.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Sep 2023 07:16:01 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v4 38/44] bloblist: Add missing name
Date: Tue, 26 Sep 2023 08:14:52 -0600
Message-ID: <20230926141514.2101787-39-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
In-Reply-To: <20230926141514.2101787-1-sjg@chromium.org>
References: <20230926141514.2101787-1-sjg@chromium.org>
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

Add a missing bloblist name.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v4:
- Split all new bloblist names into a separate patch

 common/bloblist.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/common/bloblist.c b/common/bloblist.c
index 6f2a4577708d..a22f6c12b0c7 100644
--- a/common/bloblist.c
+++ b/common/bloblist.c
@@ -51,6 +51,7 @@ static struct tag_name {
 
 	/* BLOBLISTT_PROJECT_AREA */
 	{ BLOBLISTT_U_BOOT_SPL_HANDOFF, "SPL hand-off" },
+	{ BLOBLISTT_VBE, "VBE" },
 	{ BLOBLISTT_U_BOOT_VIDEO, "SPL video handoff" },
 
 	/* BLOBLISTT_VENDOR_AREA */
-- 
2.42.0.515.g380fc7ccd1-goog


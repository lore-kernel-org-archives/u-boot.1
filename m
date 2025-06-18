Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39CD9C7115A
	for <u-boot@archiver.kernel.org>; Wed, 18 Jun 2025 15:00:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9AB2082E36;
	Wed, 18 Jun 2025 16:59:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="jkSHH4P8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A072B82E67; Wed, 18 Jun 2025 16:59:55 +0200 (CEST)
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com
 [IPv6:2607:f8b0:4864:20::72c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F1CB82E2D
 for <u-boot@lists.denx.de>; Wed, 18 Jun 2025 16:59:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qk1-x72c.google.com with SMTP id
 af79cd13be357-7d3862646eeso428556785a.2
 for <u-boot@lists.denx.de>; Wed, 18 Jun 2025 07:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750258787; x=1750863587; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yv3/4BQLsxo8aFuq43xSe6adtJfgT1hQTd1sARjonOw=;
 b=jkSHH4P8pHQO+NW/utSHGZyYb/vIiNcEsNH8QvfSuJ3gqx9Ex2RFNquDkGJGPJyE/C
 kCCpdz6i6E+iAVjhSmUGtwyz5fJeTOdnvPLKj3IZRTDOAMAcsrqaRaGHPwQ/eNdGQTkD
 G3IsGxSe4mUoeO1M9gHxLXclDaQwBXDf3VmcPN4AOVoQzO5AccMWZedohBGXP6971aZn
 e0QccbvmXdC1aMXEk68dPoDO1zWy6//AvN2qvQkQXwIsVgA0zu4GVsH0Uk0RxycPPX/G
 aBgcvuN7A5otkFSAqTU7S2l0v+zyvQhG4xwW45GgtaUolh24EbCqjYLD98A4NLJXNC+U
 hgiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750258787; x=1750863587;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yv3/4BQLsxo8aFuq43xSe6adtJfgT1hQTd1sARjonOw=;
 b=iRyYi35SVfX9883amQaOEAozYlE2GDXVkhny9lYnklGv5v8BPFWNwyn60jGRT87eBS
 qeimQV5NpF2jUAIh1Fev4f0bM1/hf4RprMSsRI2o40Ba3D9aORKCH/3P0whfvYb5g1T7
 x5JO3/hCOdVZNST0hJTL78VRJDDQDthUqm4MfYa1sw0xvKBu+Rd06TNhVIiIOQfp6A/I
 9BLybpxgkgPJV2/v+9B0x94qaK69PE1SWicq+XZcSbFPixKTfntLa6Bn9a49r7vmg2Yj
 94M4psTdfHsoHL3NJ/An+I/C/faZn/fQwY/FV/sFLQGmk289M7PbhTWsUwWOej98o7Eq
 Kg8w==
X-Gm-Message-State: AOJu0Yynqx5f+mcui7CQvteF9QwTlp+hfxTKwV7N1Oc0ayL/rv1uQlfh
 Q1Un+tGQ1mWwzimCpXcFH2tcTGdVFOzPno7dZ2fHWQKluUKd3IFq3Apq9A1b3z8byj/1Pm49yKG
 0RkhN
X-Gm-Gg: ASbGnctR5qIxI5G4FL+rIyUidT8bcaOImHXeAXeWkrJutI16t6OnVzX9MCGHli+yrhu
 QIC0JNHkN46zgaN61Bwkv7nOsbhHnQUhGD6HlYwBL6SHk0fw9NdmgNZNHkjofQSI8iYqpxMSqjC
 0gg6ZorHC51QHSINyRxz2/O/MI3Tbs8pOQWk5/jXcHSW19QTagSiUpSJGgnEpdvr7zcZmRhW9um
 /UiMMi6brDhNHZjrw+46ngrHHzkVlaIlLKr+3W+tTj0h7Df0kYwlId/x1juw4LGR+/kVPcvG1D4
 O8ELGJRagXyw7DRILAlbJQyTJmGX9IF7uXapIJbbWZgYcD6fRLmMxwYSaY327sL4W7iGLZ6DWhf
 NWxZmkOEaZirvol2zot+t+ixLxqr7tbaQwPCSLcVVJuq+35I=
X-Google-Smtp-Source: AGHT+IFWlK+4zMYTxf5BGjJQg254ac9PNYJgCvrO3oc2Lujp4w+nJvaX0/wzT0kVyNCczVYmp1L+qA==
X-Received: by 2002:ad4:5ca7:0:b0:6fa:c8c7:82f7 with SMTP id
 6a1803df08f44-6fb4776e790mr293973926d6.20.1750258787059; 
 Wed, 18 Jun 2025 07:59:47 -0700 (PDT)
Received: from ubuntu.localdomain (173-206-114-64.cpe.distributel.net.
 [173.206.114.64]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6fb4d627a14sm44736416d6.68.2025.06.18.07.59.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Jun 2025 07:59:46 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: michal.simek@amd.com, venkatesh.abbarapu@amd.com,
 Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Dan Carpenter <dan.carpenter@linaro.org>, Levi Yun <yeoreum.yun@arm.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Harrison Mutai <harrison.mutai@arm.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Matthias Brugger <mbrugger@suse.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 2/6] bloblist: add helper functions
Date: Wed, 18 Jun 2025 07:59:24 -0700
Message-Id: <20250618145930.2652304-3-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250618145930.2652304-1-raymond.mao@linaro.org>
References: <20250618145930.2652304-1-raymond.mao@linaro.org>
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

Add two helper functions for:
1. marking a blob void
2. getting blob record from a given blob data pointer.

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
 common/bloblist.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/common/bloblist.c b/common/bloblist.c
index 1c690f58b56..488908f605e 100644
--- a/common/bloblist.c
+++ b/common/bloblist.c
@@ -97,6 +97,19 @@ static inline uint rec_tag(struct bloblist_rec *rec)
 		BLOBLISTR_TAG_SHIFT;
 }
 
+static inline void void_blob(struct bloblist_rec *rec)
+{
+	if (rec_tag(rec) == BLOBLISTT_VOID)
+		return;
+	rec->tag_and_hdr_size = BLOBLISTT_VOID |
+				sizeof(*rec) << BLOBLISTR_HDR_SIZE_SHIFT;
+}
+
+static inline struct bloblist_rec *rec_from_blob(void *blob)
+{
+	return (blob - sizeof(struct bloblist_rec));
+}
+
 static ulong bloblist_blob_end_ofs(struct bloblist_hdr *hdr,
 				   struct bloblist_rec *rec)
 {
-- 
2.25.1


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69886C021B8
	for <u-boot@archiver.kernel.org>; Wed, 26 Feb 2025 16:26:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6DE7681111;
	Wed, 26 Feb 2025 17:26:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Llm1jMCA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AC88081249; Wed, 26 Feb 2025 17:26:46 +0100 (CET)
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com
 [IPv6:2607:f8b0:4864:20::d2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C1E2A812BC
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 17:26:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2d.google.com with SMTP id
 ca18e2360f4ac-855a5aa9604so189521739f.2
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 08:26:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1740587201; x=1741192001; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XPondJzoQj/zgnhu+uNtYGAsT9jZQSb8jZ8lYwhMMR0=;
 b=Llm1jMCAZYYQlloMWCtjaeRbYCKKz1U+P1OFBh7MnbA9gW4b57jEmyQrppw32KhXox
 fAax1UBfz6axGpd88h/3fVzp+pdRZ+3bLyrqc5rGrwMZvM525T03sF/zO86fGQLpTgzc
 GCxsGl6bhDp8A+eUWlZWDPu47wVxGzeSyyGYM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740587201; x=1741192001;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XPondJzoQj/zgnhu+uNtYGAsT9jZQSb8jZ8lYwhMMR0=;
 b=fLV/h8IVwqsfvybXjby32RP5q7s9fIRvrlh93jMpsajeSr1hRthzae3hwrg9S9ZTkP
 Rg06+N1VIWIkyw0uZc23E7xsKR2/5izU3GFofv50G3YoQIi+NdL7bGS1FluX277Qudj4
 H43MmcWpf32Z19QRyqLFpDkzrIoifJXIEmrEGal5Uv29iESAvlu7B7YGb8spSwEImCcQ
 OOmuxNpRyBBMVfcRmoSsnc0PDhjT68jxJJa54+AFmEPaIbyt7d3RmZLjCIgFeldx5Mwe
 32g55XPL+8EG0M+qZLjSZX2HvTAxTO07Yhw2qoGog7Ab9GNWk12ExDJ6tmpe5h+GeuQC
 IOtw==
X-Gm-Message-State: AOJu0YzEGEcRkA14uZ+Q/BiTlVgUEokvIHgqF5GyuWR/4Ot7zPUT5gX2
 MiSgSui8ZSKQgEiAyS3xMCQNetEiLmmbnmS6qC74toUkH/67zUqDSI/ogr4DWz1cBJS/holtqBk
 =
X-Gm-Gg: ASbGnct/12l5wd7N9agoE5EZPQtA/nHnMR5KWX/G6u4PB4UFgODaCHM8PEnbvhTn+Sr
 OBp4eYo2oYJMbC832hJ0U48nhiL0cf7YhZDbUqJLgvL0T2NsowclSX2GLK4oNhwkM+kH/JW0CiV
 b7s0o1pJpKnqzECNIImnqRridY+wLDd0zjjuoPxaqNqRshZBGWeXntC3GVVc38AVHlEk2FeUbu8
 IK0ObC299QdUO/YnV9aYAAR2dh1GKO7RdYng9a2h+amMdmPoPai/KAr2tIIspC0/qAbc3fqf5mg
 N+zVjE9p1TUg9n67tqVXvEB5hV9zFzGh8BbMVs13VXg3W2Mkzgy6BQA0zlDdK30=
X-Google-Smtp-Source: AGHT+IGgaYbC+z2C66po0b2jS1RhECZo/aCDsrQeyGEQ1w3J6No7XidP/3Go4x9e4431zcggDwESHA==
X-Received: by 2002:a05:6602:6426:b0:855:c476:8b8a with SMTP id
 ca18e2360f4ac-855daac1293mr2495412939f.0.1740587201134; 
 Wed, 26 Feb 2025 08:26:41 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-85620a2f9c6sm77857539f.21.2025.02.26.08.26.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2025 08:26:39 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Jaehoon Chung <jh80.chung@samsung.com>,
 Minkyu Kang <mk7.kang@samsung.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 2/5] samsung: snow: Use BLOBLIST_FIXED
Date: Wed, 26 Feb 2025 09:26:15 -0700
Message-ID: <20250226162621.2681677-3-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250226162621.2681677-1-sjg@chromium.org>
References: <20250226162621.2681677-1-sjg@chromium.org>
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

Snow requires a fixed bloblist to operate, so re-enable this option.

Signed-off-by: Simon Glass <sjg@chromium.org>
Fixes: 864106f3c47 ("bloblist: Make BLOBLIST_ALLOC the default")
---

(no changes since v1)

 configs/snow_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configs/snow_defconfig b/configs/snow_defconfig
index 7a1dc80b1cc..f9fd76daa67 100644
--- a/configs/snow_defconfig
+++ b/configs/snow_defconfig
@@ -33,7 +33,9 @@ CONFIG_DISTRO_DEFAULTS=y
 CONFIG_SYS_PBSIZE=1024
 CONFIG_SILENT_CONSOLE=y
 CONFIG_BLOBLIST=y
+CONFIG_BLOBLIST_FIXED=y
 # CONFIG_SPL_BLOBLIST is not set
+CONFIG_BLOBLIST_ADDR=0x43d00000
 # CONFIG_SPL_FRAMEWORK is not set
 CONFIG_SPL_FOOTPRINT_LIMIT=y
 CONFIG_SPL_MAX_FOOTPRINT=0x3800
-- 
2.43.0


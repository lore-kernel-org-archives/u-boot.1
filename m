Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5222C3ABAC
	for <u-boot@archiver.kernel.org>; Sun,  4 May 2025 13:26:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7480182A9E;
	Sun,  4 May 2025 15:24:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Q9PyRDBn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5456182AB2; Sun,  4 May 2025 15:24:33 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4192982A80
 for <u-boot@lists.denx.de>; Sun,  4 May 2025 15:24:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-acb2faa9f55so462555166b.3
 for <u-boot@lists.denx.de>; Sun, 04 May 2025 06:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746365070; x=1746969870; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hSBwBJC5koONfxvwDXR2z7j91/feey4CwVDdT1liTKA=;
 b=Q9PyRDBneE5MluiS757LBs8/ccm5gTff1ru/ZFoUH4Ai6i/NPlX6Z6svUw14y1mg6F
 bILLuvjwb7/blQJC0jVKCaJ6iqSNz3WCIBy+4RVTCEkidWxPk/wSIF6OQttEnV4+nodi
 cKqxFkM5OPa9M6ICwQ0cvvJJZAj4GHnd41YoA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746365070; x=1746969870;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hSBwBJC5koONfxvwDXR2z7j91/feey4CwVDdT1liTKA=;
 b=mQtd6z1/O9mFT/ufS2HK3MwbACVUytlq7ypj5yXPHzF8IfldYdth1m7VBU5AMIM/RT
 XEiVhhdBbNTse+ElF+GLR5yPtXMFAxlT3BgRIBpYlPq6aBBIsASYxOPDguJ/Z5f3g+ao
 D+VT2s55fVlGtDDarJ3AFw9K2pgc7ueMqiJEqkCISbuzptu5X5ToRgDNyHzHn3fU/tix
 gdqdSJWD9fO+dsvQBp5ykakNDpefzEOb1Vss65jdpYOI4dTIyJMu90V9Yubgpsrraq53
 CRQFLgHp41/qzRzP8xYTnxvg7TS7oDOnShz9I90oivn21IeVYurZZwSu9vVcTRvMQst+
 aFcQ==
X-Gm-Message-State: AOJu0YxBWcQZC9YhdI9ADgUFXuJTvRNU2/+z8wp5ooXaBSRfrzXeRtLB
 fa4G0MCNvdR4xXNTcEWqOg+UM+21vTEZwUX0clqwUvBU6pyb1N37xi4DsSLM8PuHjF1HQk+6THH
 Fw5UtWE0=
X-Gm-Gg: ASbGncvDYFxC+KX3glqICJwkiiW+tkvGG6eIFeM3NgvL4OEa1uuriovCOuzdFx1+iuU
 vphitq80yV57vDN3fffteuKbHmmVXbx0CAhft/VP1kPO9p+8qAmlJL1Gx+zu5L9lUqte+WwyoS1
 Oke97PZ2HIUzCu6Tithl8EL4EAnauMqgPKPQoaM0BcZUVPZa0dCpJ53vaYPOmRpjKm0AaGn6I1P
 TV4VHWGX+JMN1vyJsMxOGr0WoAzUW8nAW+CdVFIMw2P9SAPSxbOpKUHSraN366KbZN6EU9OipQW
 8pk4LLgauDtVtFNgRTElAjBY7dcBuH54KML79/MWAZLfENU=
X-Google-Smtp-Source: AGHT+IFYiykrY8e/a2pruHCzXWti1Vf9oq9IiGiS4Lc+rQMDDnPQ3PTeDsvfAlEO1HkitFVQdQcJJw==
X-Received: by 2002:a17:907:7f8d:b0:ace:d994:3cc3 with SMTP id
 a640c23a62f3a-ad1a4b1f930mr327372466b.51.1746365070219; 
 Sun, 04 May 2025 06:24:30 -0700 (PDT)
Received: from chromium.org ([213.157.19.135])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad1891f508asm328655666b.85.2025.05.04.06.24.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 May 2025 06:24:28 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 15/30] patman: Add aiohttp to requirements
Date: Sun,  4 May 2025 15:23:31 +0200
Message-ID: <20250504132356.2317305-16-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250504132356.2317305-1-sjg@chromium.org>
References: <20250504132356.2317305-1-sjg@chromium.org>
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

This module will be used for accessing Patchwork, so add it to the
requirements.txt file.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Rework commit message since this only updates requirements.txt now

 tools/patman/requirements.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/patman/requirements.txt b/tools/patman/requirements.txt
index e8cbc6cf0c3..57a284d23f2 100644
--- a/tools/patman/requirements.txt
+++ b/tools/patman/requirements.txt
@@ -1,3 +1,4 @@
+aiohttp==3.9.1
 ConfigParser==7.1.0
 importlib_resources==6.5.2
 pygit2==1.13.3
-- 
2.43.0


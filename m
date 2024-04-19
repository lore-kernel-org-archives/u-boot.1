Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27B4CC4345F
	for <u-boot@archiver.kernel.org>; Fri, 19 Apr 2024 11:38:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 81214880D8;
	Fri, 19 Apr 2024 13:38:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="wK1oOt7L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4AA3688742; Fri, 19 Apr 2024 13:38:02 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 51324880E4
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 13:38:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 02E573F36F
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 11:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1713526680;
 bh=6k8a+ZR6Yn75gsXyKaw5+Pxa71g8O5ANPVn7SeFY2Ak=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=wK1oOt7LOtxG1XWqYATuHnZbDg1XUXHn7fet4tqUcjmqUe1cHGXEody/RJnKYSfZ4
 GtgGHfp/fe1CHIiQnp835Db3OcVxwh0z4GelKhq7AakvD8MvPyskRVp9oQPt+L5WSZ
 i3JAMpKbRNG98ZpDt8EbslJ0F8clwd7XK9ebCKWrB3Obrk8LQi1Kp5nIikGsL4cTch
 4ORaMxMQqTuoqgkq43E6xZG6BF3azBGPUGx5LAtsmftFfxoHhVa3yEWpthGh+qwfeF
 Z+KBbFvTEwzz12MWKY3ug7HpGxiXu1fu9NNoAyOR79tORqiCYve8/uk6TzXd6uEawe
 u8UI6AA8P3JhA==
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4183909fec8so16135785e9.0
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 04:38:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713526679; x=1714131479;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6k8a+ZR6Yn75gsXyKaw5+Pxa71g8O5ANPVn7SeFY2Ak=;
 b=hpkee2yyM+brjedtWljmc209apSXPMaxHIghS2SgSXW5EwIFfszRNeMiEPSwCXBJ2i
 DxaQeHzjVwT8TI3PXIVTMxNZPMWvIHpPSf/zjL7I7jHBJegPNBGmZ/RF5ctXMVhEnI77
 Rh9SbRL7rsOosT6EioqscMJq4bACok7ouu+eJaEpzTVwZVCDcFde/lLEI6KNZ9Nporxl
 VR6g32khfNG10Mb0j4xfNt3U7UUIAk2HmGLkzao7RfNAC/+jK7buSCR52vkzh0HIzeRD
 /U4YEb//9W6AWEGOPHN2YPZV49eInOKeEozuJbe/7NfRl1UWzYZ3y/297vmm6cman53o
 0Viw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUKeEDXH8nlMW238NVHGh51pInUdrNiXglOLDbeEzSgopIclpyjMhUP6/CKw82KmxxThOBbESWUXWXEAdFEoPdUf9J2tQ==
X-Gm-Message-State: AOJu0YwY14PDZtBCFRE93UczjpcjzDNP3F/YUmsHgk1+IIVT+gh3Ed1f
 kScNwsG82hGPtcyTKlCzb5AT2c7GE93QArvxqJS3FlrgRJkg2wuacDY678lkyKAxyQyv6qfYvQf
 xFHu/SRWIbnGNHFVs3cvLnj7z0mLrPkMU2o1bQ+Q1QHdnDCTzYT8A0TJIVc32M5HkjCI=
X-Received: by 2002:a05:600c:470e:b0:418:4aac:a576 with SMTP id
 v14-20020a05600c470e00b004184aaca576mr1569878wmo.39.1713526679518; 
 Fri, 19 Apr 2024 04:37:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHYI9CerzIXk/j+Zc+TGXvGefLgFBuiESrMMIxt9f2nqP2CWvasdPfUiq6/QC+flktGUpQchw==
X-Received: by 2002:a05:600c:470e:b0:418:4aac:a576 with SMTP id
 v14-20020a05600c470e00b004184aaca576mr1569856wmo.39.1713526679119; 
 Fri, 19 Apr 2024 04:37:59 -0700 (PDT)
Received: from workstation5.fritz.box
 (ip-062-143-245-032.um16.pools.vodafone-ip.de. [62.143.245.32])
 by smtp.gmail.com with ESMTPSA id
 f11-20020a05600c4e8b00b00417ee886977sm10060458wmq.4.2024.04.19.04.37.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Apr 2024 04:37:58 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 2/2] tools: type arguemnts
Date: Fri, 19 Apr 2024 13:37:46 +0200
Message-ID: <20240419113746.73110-2-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240419113746.73110-1-heinrich.schuchardt@canonical.com>
References: <20240419113746.73110-1-heinrich.schuchardt@canonical.com>
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

%s/arguemnts/arguemnts/

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 tools/buildman/test.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/buildman/test.py b/tools/buildman/test.py
index bdd3d84158a..f92add7a7c5 100644
--- a/tools/buildman/test.py
+++ b/tools/buildman/test.py
@@ -195,7 +195,7 @@ class TestBuild(unittest.TestCase):
         Args:
             echo_lines: True to echo lines to the terminal to aid test
                 development
-            kwdisplay_args: Dict of arguemnts to pass to
+            kwdisplay_args: Dict of arguments to pass to
                 Builder.SetDisplayOptions()
 
         Returns:
-- 
2.43.0


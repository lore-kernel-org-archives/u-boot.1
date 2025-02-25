Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACC69C021B2
	for <u-boot@archiver.kernel.org>; Tue, 25 Feb 2025 20:07:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7541F80FF0;
	Tue, 25 Feb 2025 21:07:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Vqrzso7w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6B0BA80FEC; Tue, 25 Feb 2025 21:07:00 +0100 (CET)
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com
 [IPv6:2607:f8b0:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B2E880FB6
 for <u-boot@lists.denx.de>; Tue, 25 Feb 2025 21:06:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12b.google.com with SMTP id
 e9e14a558f8ab-3d2b3c0b3fbso47125095ab.3
 for <u-boot@lists.denx.de>; Tue, 25 Feb 2025 12:06:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1740514016; x=1741118816; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Pjoi7WzezIcTPfjmihLdxy+uWLQGHRUBcHuy9zd8k0w=;
 b=Vqrzso7w1/R8rbeaSJ6dXTCdwluDE5+8slzEAMn8pT9wrjUPfJYdfI+mwF+haEz/b6
 yJ+P6w4OpqOaGXLBJa/GCCjDW9Zigl/ajSIU8M0CUWI95p/VFxRH/148eUnheuwOFJmI
 nWPgbC8bG1vihQPGBlf1yL0nA23Im/6a1ASng=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740514016; x=1741118816;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Pjoi7WzezIcTPfjmihLdxy+uWLQGHRUBcHuy9zd8k0w=;
 b=Cs5YGAAcsIIkyb+CSW+sXlVlao6Y19/8wOsifkNHE+/J6v2Mx0Y8vhKJozHDhdDLXz
 5JIwNgGdwAwAc+m1TUFviB++FRz9fS/Sx3tJTeC5DU1QdzFwiSqRPpR3KWCJY7o+JbRc
 eBKxrkZF0H2JcP9xHpTwFhv8Zx3iWp8S3vWeO4agvIY1huBCzJ1Y0r3bIEJLogckHANM
 ZqxEGKNRm6mx8W2fkqZLykiitYRi8dQf663ahf3cSEZfpGIEMgKndZxu3HRzmfEhR+wb
 PQzLmP7k2E6txfHX74GGYxM6l6THHWN43Joep5pxgJ1xtbtR06DmBC7fAOPBZaq+NRcJ
 DH6A==
X-Gm-Message-State: AOJu0Yy+VtWi/Y4dbJcV7qAQy32Ak4QhIgjvVJomm/gMl8OpZ8q20U9x
 ZF1TqyKGf3wr6C5u4iyaAoqWv/bhdkmlNVyJM7EvG+JKMhIiBiS5N1EGkfI0m++BEZCgFPUJwMk
 =
X-Gm-Gg: ASbGncuxN04tDdltINI1TH4LUuglkBbm0pDIK83Q1/mSIyBZ+E+ZEPN9ilCYyuQF55K
 U0hX1cHlIIMqcGiYlsfEbulkjbim9KsonBq/17xbW/PX5GRXqupkEs4fLbHZwNHYFbHWdTc8sXy
 d3z3AKVfR0XBmXImzqV9jq4LfXSoUjy92vVGrESlUXa/3MCmgd0stpR0EWwueLFjNazKnyfYFk1
 I9jqqz1wjZBVLPcRoFT6010nHhT+UOCpXkheouO2xJ24GHZiwwSgXRZ2dq6fdzw+Urq4WbxbkNX
 dk8LIe1zxMwg9fzbWtGhxq0njF6Ve1WL9kwsPHOpm8fg7UUk9s+j/hdQ14aYJPs=
X-Google-Smtp-Source: AGHT+IGiD20u9ARU6qqskKWGhfV68K+U2tvwG9/+Hl0z3XiAP6aO64as0dUE3jtO8+gKaF1qP3PRnA==
X-Received: by 2002:a92:c247:0:b0:3d3:d28e:eafd with SMTP id
 e9e14a558f8ab-3d3d28eed2bmr3248655ab.14.1740514016323; 
 Tue, 25 Feb 2025 12:06:56 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3d361ca210bsm4653305ab.55.2025.02.25.12.06.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2025 12:06:55 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 4/7] binman: Drop algo check in CheckSetHashValue()
Date: Tue, 25 Feb 2025 13:06:29 -0700
Message-ID: <20250225200635.3781149-5-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250225200635.3781149-1-sjg@chromium.org>
References: <20250225200635.3781149-1-sjg@chromium.org>
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

The CheckAddHashValue() function is always called before this one, so
the algorithm check is never used. Replace it with an assert to avoid a
coverage error.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/binman/state.py | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/binman/state.py b/tools/binman/state.py
index 6772d3678fe..f4d885c772a 100644
--- a/tools/binman/state.py
+++ b/tools/binman/state.py
@@ -411,8 +411,7 @@ def CheckSetHashValue(node, get_data_func):
             m = hashlib.sha256()
             m.update(get_data_func())
             data = m.digest()
-        if data is None:
-            raise ValueError(f"Node '{node.path}': Unknown hash algorithm '{algo}'")
+        assert data
         for n in GetUpdateNodes(hash_node):
             n.SetData('value', data)
 
-- 
2.43.0


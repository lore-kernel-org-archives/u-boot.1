Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEA41C3DA7F
	for <u-boot@archiver.kernel.org>; Sat, 10 Aug 2024 20:52:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2082788871;
	Sat, 10 Aug 2024 22:52:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="OoptjNXV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE72D8887E; Sat, 10 Aug 2024 22:52:23 +0200 (CEST)
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com
 [IPv6:2607:f8b0:4864:20::d33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 98A0A88876
 for <u-boot@lists.denx.de>; Sat, 10 Aug 2024 22:52:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd33.google.com with SMTP id
 ca18e2360f4ac-81fd520fee5so118753439f.2
 for <u-boot@lists.denx.de>; Sat, 10 Aug 2024 13:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723323140; x=1723927940; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NuN0o51TRcnq2PQgnqRHoRn0yTbdRIM/Z8H3V3wBRV0=;
 b=OoptjNXVEDlFnXTIxPRhtodOYGGBpDmZG9vzaVjYHEZydvGMGMB45qV3CpsC/X/oJC
 21/xDj32XgVaXTrKUQZi8ZZuYS4gLsQ1AjWbqNoGByzs2p5zS1HImYKVbvNi2upWKpo5
 O4vy5RczFsP05HHk08tIFomNbX1DFhE1xTX9U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723323140; x=1723927940;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NuN0o51TRcnq2PQgnqRHoRn0yTbdRIM/Z8H3V3wBRV0=;
 b=p2xTx3YI2ySrxicjAfJJt/OuHHmDQNEDOEnKuU245u1JLQz1N0XGQFr9eNldSZosgb
 ocpSVJaguCKzn/pMvQDN6TzQgX5T+I7vBiJKjtIUxiwokxiBJZnP8ivNgMZwhEXnzpE8
 m+GLzoEkGNGa94vKiLMFTwX+9izmSiWfxLqtwWct+2na5/Ou26FDQX8KbWQ0+nMfp3OD
 QTA3kD1OHO4C9m5rDjcutS080ZiMVkik0QXkNkUNjxp19fIK8Hofv69uCNb0kAzVnsfK
 wA73IqN9XGxHM8q/3VsauvYQ2hK2w7d1NYfvShYGdOULLTQv+MB7EcmRt7HkCisT9yzq
 QaFg==
X-Gm-Message-State: AOJu0YysD34m0qM7E36RUxHFeXYS+ZXq0kawsrE5smL+IBfSF09BMQh6
 Wryzi9ZNYvJleUilFBBW8VK6IKHGcotTSW41dj1kSE/ClCS7AHqWJBzOlFEPmGvMag6AhWnif0Y
 =
X-Google-Smtp-Source: AGHT+IFJYL0DzIxNeLCg0/QpLAgWXiNm3Jxb9QkbGsrLkxvkiD7OgNMck3ahMo2QhnYArbvezN/lbA==
X-Received: by 2002:a5d:9b96:0:b0:817:49a2:fcf7 with SMTP id
 ca18e2360f4ac-8225eedb13cmr665786039f.17.1723323140143; 
 Sat, 10 Aug 2024 13:52:20 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-82266f56333sm82893139f.0.2024.08.10.13.52.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 Aug 2024 13:52:19 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Brandon Maier <brandon.maier@collins.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH 01/21] buildman: Make test_process_limit handle
 time.monotonic()
Date: Sat, 10 Aug 2024 14:51:45 -0600
Message-Id: <20240810205205.3403177-2-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240810205205.3403177-1-sjg@chromium.org>
References: <20240810205205.3403177-1-sjg@chromium.org>
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

Newer versions of filelock use time.monotonic() instead of time.time().
Update the test the handle this.

It would be better if filelock had support for writing unit tests which
use locking.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/buildman/test.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/buildman/test.py b/tools/buildman/test.py
index bfad3093030..e9d2c7e41b0 100644
--- a/tools/buildman/test.py
+++ b/tools/buildman/test.py
@@ -779,6 +779,7 @@ class TestBuild(unittest.TestCase):
         tmpdir = self.base_dir
 
         with (patch('time.time', side_effect=self.get_time),
+              patch('time.monotonic', side_effect=self.get_time),
               patch('time.sleep', side_effect=self.inc_time),
               patch('os.kill', side_effect=self.kill)):
             # Grab the process. Since there is no other profcess, this should
-- 
2.34.1


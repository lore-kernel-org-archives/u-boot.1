Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92FCCC5320E
	for <u-boot@archiver.kernel.org>; Thu, 22 Aug 2024 13:58:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB1F188965;
	Thu, 22 Aug 2024 15:58:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="c4p3oH3Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B34488A02; Thu, 22 Aug 2024 15:58:18 +0200 (CEST)
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com
 [IPv6:2607:f8b0:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB88488113
 for <u-boot@lists.denx.de>; Thu, 22 Aug 2024 15:58:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x131.google.com with SMTP id
 e9e14a558f8ab-39b0826298cso2799835ab.2
 for <u-boot@lists.denx.de>; Thu, 22 Aug 2024 06:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724335094; x=1724939894; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mYONfZH36nGzxyVHUbILTE7iu3O7aCZzCvo+qoOTSUw=;
 b=c4p3oH3Yb2B2K/jrt/MfFg/wR7xDP27ztyEU3XINIn+wAVxzaBgLVudlIzPa2zQTqo
 sMpcz3sscsBde8hv+ExK3WfiaqFOb7lhNp9axgNemsXsHGRE5DXR/1OrFVfMBLmhmNbC
 NI9zHdjjszN6Nek2mCh5Yr286cGJAi1h6VY2g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724335094; x=1724939894;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mYONfZH36nGzxyVHUbILTE7iu3O7aCZzCvo+qoOTSUw=;
 b=LYGqwm99fv6LFzZXKKYzvHS3B872nz14RTxtaWVuEfdRru4+SLkpUbMani3SKh4VAf
 oImGGz+PzE4MzH+Z2eobj/SJsyrmNJ8LXeD/Yal91cnt1Sgk7Tr+PlnBTZQKtRYXxm5R
 pc/Dys/skK5xTZeZLSEEYxGwrdNML8De6xd83vC7sAdaPJddHoRm+UJHW+TsBiCaXqn6
 YXX9JSW8IqAfyPc8MD7CRgMxFqodEc8lDVXJJ5AV477kuMkhzBKRpZ0VebMptJpH14id
 KYpb8daCkNiXY7cVWxxfJNGZFVacSfNAxSuEGz59kfqta/4X9oYnca66HCAJG1ZTw9V/
 2oKw==
X-Gm-Message-State: AOJu0YzJ3mvQiUYLNG1blJiWmueda3QwMsLGRbir8AKXPNoovdIaY09n
 p/klAASkXtJHIo8E4vOI6tfa3VCzKXbxt5oMF6muG4BoHX57/oESQadLcYyWEO0MtrDyoiDl8ec
 =
X-Google-Smtp-Source: AGHT+IFfPaPjNCEGC+SlxtMuckFHi8mJd5jEMAe7+zmJfyoyWCCaSZCgdht+bE5cdZq0kYOwSlgT5w==
X-Received: by 2002:a05:6e02:148c:b0:39d:24db:d50d with SMTP id
 e9e14a558f8ab-39d74b53cc8mr22195725ab.1.1724335094641; 
 Thu, 22 Aug 2024 06:58:14 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39d73e747eesm6793275ab.29.2024.08.22.06.58.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Aug 2024 06:58:14 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 01/19] buildman: Make test_process_limit handle
 time.monotonic()
Date: Thu, 22 Aug 2024 07:57:46 -0600
Message-Id: <20240822135804.2375959-2-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240822135804.2375959-1-sjg@chromium.org>
References: <20240822135804.2375959-1-sjg@chromium.org>
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

(no changes since v1)

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


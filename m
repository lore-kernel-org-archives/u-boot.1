Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87352C27C4F
	for <u-boot@archiver.kernel.org>; Fri, 21 Jun 2024 19:54:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 903A188577;
	Fri, 21 Jun 2024 21:52:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="SAbpTPNu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DCD9287D10; Fri, 21 Jun 2024 21:52:20 +0200 (CEST)
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com
 [IPv6:2607:f8b0:4864:20::d2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C5BF288569
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 21:52:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2f.google.com with SMTP id
 ca18e2360f4ac-7eb5dd9f994so85877839f.2
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 12:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718999537; x=1719604337; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yEIyFClr1N2iZpbhFlJ046p2FxvzCXNHilvLmZrk4Mg=;
 b=SAbpTPNu3ikggNDhR8YOyIXSxQ2KdkntMBLnQAaQiFG+Or8bvqmryYbOkoTnW3YRk2
 2s9SDKuaz20nMyQxhPP1p6nMA777UpXXgldMoFUvt4tsrsgbGaSBzRRt4MvGxYJQ+jtK
 JNo069IACWFeys6YQBd70VdHu3NY+OKjLtTo4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718999537; x=1719604337;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yEIyFClr1N2iZpbhFlJ046p2FxvzCXNHilvLmZrk4Mg=;
 b=TruazX8coqpFSW0FbPn7C0Efz+dUzas1/Fs0eMV66j3iZavsqN/TOTWVWUfqfRxnvo
 b/3qwHDT7bRrY7dwX880WweU8CwMz9YX5Jhhbzom9sNafklUDKnMMPstrGdq0zM4L+wt
 AU2UolitLlG/ht7o+smHPNsyOwiygMgqyEBSixJ8lDw89taTdWwgYwrhSjYJ32QAEtOw
 ioR0xPGctyGSydL3Isz/Kzgtpw1PMFu+uDQPCHrwpmuxGWZVvyxkifNVett7fBeumsjE
 NhELV6Q5vr+XnMkpQE1aZ+jjF98vUrhFVcBj2HCm/QRPSVEfhN+iRdYYdo8VgP6Hb0Gs
 D3NA==
X-Gm-Message-State: AOJu0YysvbZJSX64IZbkMLSbtRhqozIUR52Q6vio5BhXs2GvyNlMh2M2
 93f242Qelqfiop0Td3/rAwJBssJItz+g0gBoAJCKoZZiCJHgr7GdVbpG39Mu+o66JHGVOmk4PnE
 jpA==
X-Google-Smtp-Source: AGHT+IHLh9TNrCpuYxf2PNY5qqKnQH2EPHthOuUXT27diDr7zN+iTgwRgeLojTxs/5B9J2Q6qqb7OQ==
X-Received: by 2002:a05:6602:15c9:b0:7eb:906e:e3ee with SMTP id
 ca18e2360f4ac-7f13ee5c07dmr1090172239f.12.1718999537360; 
 Fri, 21 Jun 2024 12:52:17 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-7f39203deb7sm48801139f.47.2024.06.21.12.52.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Jun 2024 12:52:17 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 09/43] buildman: Avoid rebuilding when --mrproper is used
Date: Fri, 21 Jun 2024 13:51:30 -0600
Message-Id: <20240621195204.2675252-10-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240621195204.2675252-1-sjg@chromium.org>
References: <20240621195204.2675252-1-sjg@chromium.org>
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

When this flag is enabled, 'make mrproper' is always used when
reconfiguring, so there is no point in doing it again.

Update this.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 tools/buildman/builderthread.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/buildman/builderthread.py b/tools/buildman/builderthread.py
index 0a7ff2e083e..c0b1067e3f7 100644
--- a/tools/buildman/builderthread.py
+++ b/tools/buildman/builderthread.py
@@ -700,7 +700,7 @@ class BuilderThread(threading.Thread):
                         job.work_in_output, job.adjust_cfg)
                 failed = result.return_code or result.stderr
                 did_config = do_config
-                if failed and not do_config:
+                if failed and not do_config and not self.mrproper:
                     # If our incremental build failed, try building again
                     # with a reconfig.
                     if self.builder.force_config_on_failure:
-- 
2.34.1


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C249EC072A2
	for <u-boot@archiver.kernel.org>; Sun, 19 Nov 2023 15:37:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F77B87124;
	Sun, 19 Nov 2023 16:36:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="knK9S2vA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B892487208; Sun, 19 Nov 2023 16:36:31 +0100 (CET)
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com
 [IPv6:2607:f8b0:4864:20::d2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4FB2D87135
 for <u-boot@lists.denx.de>; Sun, 19 Nov 2023 16:36:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-7a94c550cc8so128876239f.0
 for <u-boot@lists.denx.de>; Sun, 19 Nov 2023 07:36:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700408176; x=1701012976; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/hBabRYtO/bDmhzrflCCPiFhH90ydGsEZSA/cPg/xKQ=;
 b=knK9S2vABxuGD7cuymMXzw3uRZ887h2poJAlCIXTuZSw2/kazHiEKOUZ7cdOR9u48u
 nk1HO/P3cSpwArvCOYFyQuN8wjJR5o7H6vUqa6aaCmYWDU9KoJkN3TFdlOYYeNtqwyI0
 zhc3mCuwL3NhpZZB/fl7p2FQZ6P7ilpE13vfI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700408176; x=1701012976;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/hBabRYtO/bDmhzrflCCPiFhH90ydGsEZSA/cPg/xKQ=;
 b=TM2UrDR+5/+gTercDft0KkDcffVYAX39NDQP85YP4IeqDxaI5ozVAUQPdVrUV9HyKW
 7KW6JLayl1yUIHZVMhKXCtBbCuFUl7cWe7dRO7NrENPldlDvV9PqPwryYY9r+aQUrjp+
 h+7OV2R4NKC+8rpauCEE6iY14KD8+ShIx6+UL97BsCzjG9AIG6tVPd08y48SSyoucUXT
 D2A84HX3fXNlwtOa2ZRV88awWlarpQ29iQGzTKgEDTxJDAZe4sL2GF4KBoQfseSqdmri
 PmrR2yx05C8dK4RD9163J7F6AnFk9+snuI1lTZhVVGXyQnxf0OT95UUskyGyJjTyaVhW
 7TvA==
X-Gm-Message-State: AOJu0Yx40Z/D4dzbwmtNX4ml+nLHIwuacZYt95H0MRLqd6ltIavflTR8
 P0/xXKU9mF9+9ok4+cpzypUXxAdUgpwV6HLyn0Y5ZA==
X-Google-Smtp-Source: AGHT+IFEAdDJqTpRFW3B0WPD8EYjJ7iHh7flnW7rTAQK+EvCuXub+6LKZPG3YUIel/9viEp9AiYDeg==
X-Received: by 2002:a5e:8b0d:0:b0:7b0:3:6ac7 with SMTP id
 g13-20020a5e8b0d000000b007b000036ac7mr4952188iok.16.1700408175906; 
 Sun, 19 Nov 2023 07:36:15 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 19-20020a0566380a5300b0046456924383sm1466712jap.73.2023.11.19.07.36.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Nov 2023 07:36:15 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Maxim Cournoyer <maxim.cournoyer@gmail.com>
Subject: [PATCH 4/7] u_boot_pylib: Correct files used for pip release
Date: Sun, 19 Nov 2023 08:36:03 -0700
Message-ID: <20231119153611.639252-5-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0.rc0.421.g78406f8d94-goog
In-Reply-To: <20231119153611.639252-1-sjg@chromium.org>
References: <20231119153611.639252-1-sjg@chromium.org>
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

The files list is incorrect and dates from a time when the script was
run from a different directory. Update it to match all the other tools.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/u_boot_pylib/pyproject.toml | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/tools/u_boot_pylib/pyproject.toml b/tools/u_boot_pylib/pyproject.toml
index 1984bd370089..a7a91e5cfa56 100644
--- a/tools/u_boot_pylib/pyproject.toml
+++ b/tools/u_boot_pylib/pyproject.toml
@@ -21,6 +21,5 @@ classifiers = [
 "Homepage" = "https://docs.u-boot.org"
 "Bug Tracker" = "https://source.denx.de/groups/u-boot/-/issues"
 
-[tool.setuptools.packages.find]
-where = [".."]
-include = ["u_boot_pylib*"]
+[tool.setuptools.package-data]
+u_boot_pylib = ["*.rst"]
-- 
2.43.0.rc0.421.g78406f8d94-goog


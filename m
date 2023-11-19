Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABCCAC072A2
	for <u-boot@archiver.kernel.org>; Sun, 19 Nov 2023 15:39:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DB2FD87263;
	Sun, 19 Nov 2023 16:36:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="mcWtJSla";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8665086EF6; Sun, 19 Nov 2023 16:36:45 +0100 (CET)
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com
 [IPv6:2607:f8b0:4864:20::d2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ECAAE8715C
 for <u-boot@lists.denx.de>; Sun, 19 Nov 2023 16:36:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-7ad1236c419so116419539f.0
 for <u-boot@lists.denx.de>; Sun, 19 Nov 2023 07:36:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700408177; x=1701012977; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TLApM8TQQHMvH6Da+aOAKPfrsCRGs1+fTJqPHPjv4I4=;
 b=mcWtJSlawXyGBi7OJ6UzuG8xlvctAVgJL6USBVY83UICJ94qPrAZ1TDicQQxz6SSYq
 +N3Ed2AnDX+wLv6JBgO3t1IpWt2nu45CBZIYJ6YPRhmx18l9eW6OuyaijwXcoLM2Mq7s
 EMOUvAhszHYaLHSl5UpCHhQanYucoK4SNLgLo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700408177; x=1701012977;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TLApM8TQQHMvH6Da+aOAKPfrsCRGs1+fTJqPHPjv4I4=;
 b=JoX59igk7rvcCs0yuzz49t7Bekg1o+MnO/iAOvYplxh375hzCQy9+WSnhIcICaPAdD
 /11E+Xe4vzvxugr+ODvsKKp7ZpKnRNTKgyhWDADeb49duHVeCAB6C0jIFiJtZl6tt7y9
 wEAhARGpIu4VT7C4HcBBXtoCLV/lxib37U01DJu2Itg18SB8uDLwXffuN4ah4Tz9rqsM
 somRYAkAuRC0RWm0GqgJ3abOeoFHmr3ulsg58Y6Y271Ll6kYY/EHRoC1oxoylf5Hxdjo
 5ceUnx+uVQOlyExB6JF7v1cfO4cGIenp3JwdfiKV6PlAbvHJL4mplEViER3d5vAnOisi
 wfBA==
X-Gm-Message-State: AOJu0YzC+C5QfpIiszdRFAGEmhwNM00ofx6PEq6Eu3CMi3sGTmptL32D
 hZfQMW90/YmFwK2MNPCLB7lHLFleqqllyULCm2ih0Q==
X-Google-Smtp-Source: AGHT+IFrRxYLIgaXRRk+hCwuk6fKdNh44hYIXGgIb7TXlMtjwiCEPiqN2H37xzpn53OhRH96SKcGrQ==
X-Received: by 2002:a5d:9948:0:b0:79f:a25b:51c with SMTP id
 v8-20020a5d9948000000b0079fa25b051cmr6192009ios.11.1700408177550; 
 Sun, 19 Nov 2023 07:36:17 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 19-20020a0566380a5300b0046456924383sm1466712jap.73.2023.11.19.07.36.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Nov 2023 07:36:17 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>
Subject: [PATCH 6/7] patman: Update the run script
Date: Sun, 19 Nov 2023 08:36:05 -0700
Message-ID: <20231119153611.639252-7-sjg@chromium.org>
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

Patman now has its main program in a function, so update the toml file
to match.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/patman/pyproject.toml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/patman/pyproject.toml b/tools/patman/pyproject.toml
index f29516acefad..56131947c794 100644
--- a/tools/patman/pyproject.toml
+++ b/tools/patman/pyproject.toml
@@ -23,7 +23,7 @@ classifiers = [
 "Bug Tracker" = "https://source.denx.de/groups/u-boot/-/issues"
 
 [project.scripts]
-patman = "patman.__main__"
+patman = "patman.__main__:run_patman"
 
 [tool.setuptools.package-data]
 patman = ["*.rst"]
-- 
2.43.0.rc0.421.g78406f8d94-goog


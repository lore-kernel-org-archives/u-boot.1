Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE782C5AD4C
	for <u-boot@archiver.kernel.org>; Thu, 23 Nov 2023 13:10:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CECEC87655;
	Thu, 23 Nov 2023 14:10:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="eBDPiZlK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CFC95875BE; Thu, 23 Nov 2023 14:10:28 +0100 (CET)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CEE4B87657
 for <u-boot@lists.denx.de>; Thu, 23 Nov 2023 14:10:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-548f0b7ab11so1228563a12.1
 for <u-boot@lists.denx.de>; Thu, 23 Nov 2023 05:10:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1700745025; x=1701349825;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=wvkzb/DCwAAAjuaCpVTB6kwtyJQ6jBqnXfhXHnQ/kKk=;
 b=eBDPiZlKR1DbrY8KDY2Xnlt73kJa0V/wlCbEaOevkVmk385boh4GS+MiVvmalTY7Nj
 C8/7SJVeCHbOXFQiANwAO425MpprfnSUWbdxWDzTXMRT/itCX7tAEhHZO1HqVtz4m9Tw
 9eZa+hzi+Bi8dt7yvr7G5w8N51ORX8gUVmoAQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700745025; x=1701349825;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wvkzb/DCwAAAjuaCpVTB6kwtyJQ6jBqnXfhXHnQ/kKk=;
 b=k0lXCCufyybUFvbyTpXoLmiROpPnuonwnurk5gRXuUztt7BTFBH8Gucs9pi0Omrab3
 QXT8OQW4b8abCy7x9Gxlyo6bve4cflMNqNk5tW3CBn/J9U50eUKDf0TaWdcfr8vkyqgq
 aE9o9+Oiym1rxbnuz0TVxYxIut0S4YbSaNPeOv7/wr15JdgZPWL+q4RMZrE9v/iXAxgq
 XsL9GelzI6+xpIvX5u4r4A0ZUoBjkX1qX05fNCpFK8LjMFcqlRFvNRsn7JlIBinQtzPy
 Ug79jKkeGZ7EVdak9sy3qDMDs48ocYtJVpvegytpZEF4WqpIBkCPIixllqa9eYOLixi2
 Ondw==
X-Gm-Message-State: AOJu0YwN1ix7Vd5gab4dy8I93gVaxMoK4Dm4hZ/vClQ+g/jItY1hsuNA
 Q/cjor/CMWbXiLht0MyYoS2ojUk4xW/9Z7CctjLt1w==
X-Google-Smtp-Source: AGHT+IHyFHJX63efNV5rd/uOTsncazou3+XSo8bMmkPLHxc39ljfa4su0DBrdyE/nrjhy16nXnZHsw==
X-Received: by 2002:a17:906:3793:b0:9fc:93e1:c6bc with SMTP id
 n19-20020a170906379300b009fc93e1c6bcmr2848043ejc.33.1700745025142; 
 Thu, 23 Nov 2023 05:10:25 -0800 (PST)
Received: from localhost.localdomain ([2001:b07:6474:ebbf:a27e:f878:7504:438])
 by smtp.gmail.com with ESMTPSA id
 t17-20020a170906a11100b00a015eac52dcsm760786ejy.108.2023.11.23.05.10.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Nov 2023 05:10:08 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Simon Glass <sjg@chromium.org>
Subject: [PATCH] binman: doc: fix typo
Date: Thu, 23 Nov 2023 14:10:00 +0100
Message-ID: <20231123131003.238105-1-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.42.0
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

s/use set/set/

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

 tools/binman/binman.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/binman/binman.rst b/tools/binman/binman.rst
index 020988d955f0..230e055667f3 100644
--- a/tools/binman/binman.rst
+++ b/tools/binman/binman.rst
@@ -2060,7 +2060,7 @@ don't have access to the blobs.
 If the blobs are in a different directory, you can specify this with the `-I`
 option.
 
-For U-Boot, you can use set the BINMAN_INDIRS environment variable to provide a
+For U-Boot, you can set the BINMAN_INDIRS environment variable to provide a
 space-separated list of directories to search for binary blobs::
 
    BINMAN_INDIRS="odroid-c4/fip/g12a \
-- 
2.42.0


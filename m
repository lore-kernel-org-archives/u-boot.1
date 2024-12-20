Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A77AE77188
	for <u-boot@archiver.kernel.org>; Fri, 20 Dec 2024 04:01:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B3AC18021D;
	Fri, 20 Dec 2024 05:01:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="igqsBBAb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9054F8021D; Fri, 20 Dec 2024 05:01:34 +0100 (CET)
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com
 [IPv6:2607:f8b0:4864:20::d30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 60DDF80087
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 05:01:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd30.google.com with SMTP id
 ca18e2360f4ac-844e394395aso52780039f.3
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 20:01:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734667290; x=1735272090; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=kg74sU7Ok5mjuxVjTBjadd2vX7MeeWHVEWc459avXWM=;
 b=igqsBBAb4BaQVEud5T714VEvQccVA3v1GcU1n6sM95DfaSJqRyr1gE3jMHple/uW8V
 z9PN7CJHF5Qwc96TGorjpecB6dRCuX3jI1p4yhDynvYsqoO+e9l51LHijeGoTz81zcXL
 DM/51AhDuey3OmHu+qUMzktJ/Ghbuv7Qy9ZNw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734667290; x=1735272090;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kg74sU7Ok5mjuxVjTBjadd2vX7MeeWHVEWc459avXWM=;
 b=VXNo9tB9bNjIqVleeXClZDhahyLhwqf+K8lUeIveqDnLCVASwvSGIfOaY/Kzicc43+
 TPcOX3n69/1yqy9E+2jPfHPeb9AnM/vN6lTp7rpUmzyahRnm6/eHNumksS/F2n1PdAuH
 rH2OqOwfCTvhvaR626OcICP0aZZuId0vMCrUGCzmtfAnIFjShi/91FAi7xOnpP40XL/4
 RjNkbkPAEjDwC55l41/COXRd4xXp9zJ9WDF6mAdnD2KKtXzHw3kfEwdoZBGtF7wixBMe
 g0tDYgRpipoLO3jEizBJ4XG0N6TB3zM5WjBSpKJygkj8X5kbsB3ie00HA8TWBbJkkGbK
 rSzg==
X-Gm-Message-State: AOJu0Yy/VkA50FQihVIKMtQ2pmdeF8QTLHX5AYcVvgCx6k4xZyUuGEur
 nf9EIXrQ3dKNLIpQ7Isjh+VUuy9uZi8a5Tx7B6/HxNXGPW/1aDZkEgZ5PwPC3NVt9jtCrpVdcCw
 =
X-Gm-Gg: ASbGnctga5OPtVhtC+RQXFgoVvBMbGNsb4d6Octfw/yB3uwLtGQYs6aJzrIEbwORs/B
 cHSx2aYjaMXbpNnC6ZZCGGxoVj8y6xAgPTnhpbARcDh5w0S53M4/9Fa/angJSEdLf+9hr08chFI
 kp3DaMB5/LerwYe1vT/faWJrkrZX499pUX2EZZ+H7xtefoT0CvC2jeY8p9uSJc0oUN4TqsvkhDO
 DaL2wlqG+MqPupPpsjjZNJG4kgOJXwJ8LlEwECe+1xU5qys/vo1l9uWTxrRd9wdU8jsa0JZj5Ko
 T1zK9lsIGfdamNaAQA==
X-Google-Smtp-Source: AGHT+IGEV4e4HQ0BHVQPqs85Fta/ssUQwhptslSqLUtKYRVXgjY9764RGZbOAKQ91ZlFmjQBHMX9Mw==
X-Received: by 2002:a05:6e02:b29:b0:3a7:9736:501e with SMTP id
 e9e14a558f8ab-3c2d2881756mr13651745ab.14.1734667290157; 
 Thu, 19 Dec 2024 20:01:30 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e68c22213asm594723173.155.2024.12.19.20.01.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 20:01:28 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Caleb Connolly <caleb.connolly@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Julien Masson <jmasson@baylibre.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martyn Welch <martyn.welch@collabora.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Richard Weinberger <richard@nod.at>, Stephen Warren <swarren@nvidia.com>,
 Stephen Warren <swarren@wwwdotorg.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 0/5] pxe: Support an automatic localboot
Date: Thu, 19 Dec 2024 21:01:15 -0700
Message-Id: <20241220040120.3245610-1-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
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

It seems that extlinux expects that boards know how to boot a local OS
from attached media. U-Boot currently assumes that boards define a
"localcmd" environment variable to support this. None does.

Provide an automatic means to find a kernel and ramdisk, using common
filenames. This addresses booting on MAAS, at least.


Simon Glass (5):
  test/py: Refactor extlinux-image creation into a function
  test: bootflow: Avoid a confusing error condition
  pxe_utils: Allow the FDT to be missing
  pxe_utils: Support a backup for localboot
  pxe_utils: Support the SAY command

 arch/sandbox/dts/test.dts |  8 ++++
 boot/Kconfig              |  9 +++++
 boot/pxe_utils.c          | 50 ++++++++++++++++++++---
 test/boot/bootflow.c      | 56 +++++++++++++++++++++++++-
 test/py/tests/test_ut.py  | 85 ++++++++++++++++++++++++++-------------
 5 files changed, 173 insertions(+), 35 deletions(-)

-- 
2.34.1


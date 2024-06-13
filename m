Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACD70C27C53
	for <u-boot@archiver.kernel.org>; Thu, 13 Jun 2024 01:15:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 98BCC88872;
	Thu, 13 Jun 2024 03:15:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="EYpxcdT/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E49798887D; Thu, 13 Jun 2024 03:15:18 +0200 (CEST)
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com
 [IPv6:2607:f8b0:4864:20::141])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 651CC88702
 for <u-boot@lists.denx.de>; Thu, 13 Jun 2024 03:15:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x141.google.com with SMTP id
 e9e14a558f8ab-3737b47c0acso1797695ab.3
 for <u-boot@lists.denx.de>; Wed, 12 Jun 2024 18:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718241315; x=1718846115; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=7DFydm232/adh7AjImdNLviULr3pwKwDqqWjZiTTgmU=;
 b=EYpxcdT/cP/aF3MXkJugKu0931QBjPxyyUq+n0d7aU+ewPXiRXS4UxdEz4CXtsxfGy
 HE+lQ04VlPPUcGT6X8z7oEEW5pvU+4p/SO6enmSNNBwNSCJaG/rG05TMMBK19khF3NRI
 +7uRgLEBcVv+801XV4/IyHEDPf3IEYYOjtpd4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718241315; x=1718846115;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7DFydm232/adh7AjImdNLviULr3pwKwDqqWjZiTTgmU=;
 b=GxIeUZvk8W5d7u8COi++T4KRLOLxPSP92K456CalkHdEWnx3+S30bVRi9/JffNn6SG
 h/mxdQXBhRGWv1otwcL3ba6qEMQrprJZaHqiT+dUS0vRGHmUVcm58rkVr8UxRsw+dRUE
 oMiHVgm2LjgTC+yJZVkoNsOxaz4zqIBUTaesovYiahzGkk6K38Eh7RbJAbAlRRFGecmZ
 B3pHnzPdj3Dh0csG9J7VtYouuQVaAYBdYFYMrirQVH9fl6fmDTDV8HJJD+bOOWlrt+Sk
 1bEQM5+aNXpRM34Pflu6BSadeXNpPJ8dhU0FlRErqIxidULVoOO79uTopQ07NQGlDjyV
 oa/w==
X-Gm-Message-State: AOJu0YwNWVeyLahqQCTqaSyjV/q2j8/4dKh5a1qlMYx0qj7VexK3q5O+
 fhXazs4dQBTFuRj9uRatN+Ua8vsFvTN/TRr72zmKqtPCBnzaCMydR3qP26ggr4rbOTBvWj1TC7n
 OF/m7
X-Google-Smtp-Source: AGHT+IEKBJ6K+1xWsT2knVJh+606X1L/O2qlB669bBX44g1zeUxtn+nwrB5dDj5YZS4kNM1gCnnZpQ==
X-Received: by 2002:a05:6e02:1a67:b0:374:ad98:2a2 with SMTP id
 e9e14a558f8ab-375cd12d3b1mr38982705ab.4.1718241314628; 
 Wed, 12 Jun 2024 18:15:14 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-375d8b45208sm416445ab.81.2024.06.12.18.15.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Jun 2024 18:15:14 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [u-boot-test-hooks PATCH v2 0/2] Add support for Labgrid
Date: Wed, 12 Jun 2024 19:15:10 -0600
Message-Id: <20240613011512.2476324-1-sjg@chromium.org>
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

This adds hooks for use with Labgrid. The only existing hook that really
does anything now is the 'console' one. There is also a new 'getrole'
hook which looks up a role to find various things about it, such as the
U-Boot board name.

Changes in v2:
- Make use of the common script (only) to set bin_dir
- Make use of the common script (only) to set bin_dir

Simon Glass (2):
  Create a common file for test scripts
  Provide some basic scripts for Labgrid integration

 README.md                    | 33 ++++++++++++++++++++++++++++
 bin/console.labgrid          | 42 ++++++++++++++++++++++++++++++++++++
 bin/ellesmere/common-labgrid | 31 ++++++++++++++++++++++++++
 bin/ellesmere/conf.all       | 24 +++++++++++++++++++++
 bin/getrole.labgrid          | 25 +++++++++++++++++++++
 bin/release.labgrid          | 22 +++++++++++++++++++
 bin/release.none             | 22 +++++++++++++++++++
 bin/u-boot-test-common       | 35 ++++++++++++++++++++++++++++++
 bin/u-boot-test-console      |  8 +------
 bin/u-boot-test-flash        |  8 +------
 bin/u-boot-test-getrole      | 38 ++++++++++++++++++++++++++++++++
 bin/u-boot-test-power-off    |  8 +------
 bin/u-boot-test-power-on     |  8 +------
 bin/u-boot-test-release      | 26 ++++++++++++++++++++++
 bin/u-boot-test-reset        |  8 +------
 15 files changed, 303 insertions(+), 35 deletions(-)
 create mode 100644 bin/console.labgrid
 create mode 100755 bin/ellesmere/common-labgrid
 create mode 100644 bin/ellesmere/conf.all
 create mode 100644 bin/getrole.labgrid
 create mode 100644 bin/release.labgrid
 create mode 100644 bin/release.none
 create mode 100755 bin/u-boot-test-common
 create mode 100755 bin/u-boot-test-getrole
 create mode 100755 bin/u-boot-test-release

-- 
2.34.1


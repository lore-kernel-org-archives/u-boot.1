Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B954EEA8125
	for <u-boot@archiver.kernel.org>; Wed, 11 Feb 2026 10:05:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B70482BF2;
	Wed, 11 Feb 2026 11:05:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="n47JIRGi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 48E98831AC; Wed, 11 Feb 2026 11:05:31 +0100 (CET)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DAABF80FA1
 for <u-boot@lists.denx.de>; Wed, 11 Feb 2026 11:05:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-480706554beso54468905e9.1
 for <u-boot@lists.denx.de>; Wed, 11 Feb 2026 02:05:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770804327; x=1771409127; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ZBVuDKbepp3JxlBBSpekSxOwHXTFdjK+VqATUCE+ULk=;
 b=n47JIRGijDLekaLByIwT2DULVi4uqej1/7HQhcpTMMHZKNrgZzS9dokINoTE9jCCbR
 cvCVsDbhFrLt1oH8QETuVN0T0vvKmtxpUgY6Jb5ld7dmjj3A97FzMaRT5gccV4iAvDDn
 /PQLN1WlCnnPH2uYHzVBMtzyWxGMmrYWGetCBDbysWb4CTEP5+uBmFoL20PQXEK0gBnd
 9p4bIdhTynnm7HgQkTZp+4NAl/nPIvm2+wVq43mXN1jbKtmEsa40V1fvsF0rbCaPHAOd
 S6rhWVA9BT/XmWH1gNr9U0rDEgeml+BasnEREeg2IX0WAlI09+S8kk5o0Dq8Flv2lL5E
 CZwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770804327; x=1771409127;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZBVuDKbepp3JxlBBSpekSxOwHXTFdjK+VqATUCE+ULk=;
 b=ARmrbRLpk2jcP0HOY3wfw4+1woYmOBplKigBfpYT1LjRc5KxA1ea6aPJ2YBnoWIevD
 eLJ3lTF+CzEmomX4NsWUBasbo+YUP4TJRvu4bs643fQk9g36Rk/3KNFYc5OIOcRzlMke
 UkFCCPMxqEjKfeTzUeCUBBVx3S99rvRDfK12DwrQfTw3Q3o0rwel/bA7JRNNVfRTaMaj
 TPZXmJee7w2Xh5105caRcThzRfbTH4F2L/UtZasIA56cd04x5HOs6ovrY8vTtYGRkS3S
 a1JEmCrvzM/asNrc3Bi+DK0+uFHiRBJ47bgZXhVLJYMGvgxEQY+0RKbkrRMhv6eTmhQi
 KaOg==
X-Gm-Message-State: AOJu0YyP1m3o9T0WsGbSAkfrycFzOPir1buQWtVxR38BlrdT/IQ53GXi
 CemxZJ5FYwn5+g530pye2YAC5KbQaJfYcXBTmkOL4I9L1mTSmYr3gnE8+Q+r5RRbvfuV9af6vAs
 fHHMcmfs=
X-Gm-Gg: AZuq6aIl7WP8rfPXIrOJlCcPNFetYeznUL3L3YisdabzV4lHYx4GCu6ZzsULC8WM1DP
 yEoUqh3xARsJVdK8504fPUGiZKoKBgL049sNKJV9tV/0C5dxGF2YhKfmbFk+JqK9kSMpgzUtoeV
 JdJnitKgxuathyvVqBhBgYwbnH/wW+HqzQzq27P2KwUsD4dDl+9n4WNTXfd9PC1YBcdVByYFcF4
 /Z+/70FXVrAYQIL41yo3WudDbK1gP536NwM9TuvA74XUVH3STvoYcHUJBl6HtV5yhSENBKw7xlz
 d7YexTaRGI2TwjxpygIqdIEdDhepbf9Me2iUtU4swLl3nZJCSKw9gr+CRlTmOCOWZosdezjMmxS
 DnW8JdaWIPPbBYerTdy14UqQOU27y62Z6wdh7sXH5cs9JAcZHF4QEsSmMapI+HnRHHm9HfCp2J3
 Z6199E0U+h2SG5d6PI4DDAV5h7zwXpWrpL5MVoOqokqEqHY8JOfLo0d5ZULbWOlw/KUHw5Z82BK
 PbhtAQlv0wUTCzs1ottGTuV7DJy5WmjrHcuXpPhj8L0O1NUoMIPpF6S4vHdXCSadhel2e9mgzKG
 WPsZ7VfPha3zTYm3MvrkM6m48TLK47ndyH3uzT7fz2ooTXrOTJn0ywPz3FuIrGDYBL6AaAaD2gv
 8fuPPTSxQcWDwCweUu0irNXNomS5zsKxSqigTgZ4dn1++OgtijU7dOI9lrXPdCqP3IUoFxqBp8M
 IPCcqpdCUBwP2gVUXgsl78FIMN6Ptgyw7Wf5rDSJJF9r16Swq8TLiOIcr+dpXo
X-Received: by 2002:a05:600c:820a:b0:47d:264e:b35a with SMTP id
 5b1f17b1804b1-4835b90c74cmr30514665e9.13.1770804327092; 
 Wed, 11 Feb 2026 02:05:27 -0800 (PST)
Received: from hera ([94.131.143.12]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4834d5ebd34sm128153865e9.7.2026.02.11.02.05.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Feb 2026 02:05:26 -0800 (PST)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: u-boot@lists.denx.de,
	trini@konsulko.com
Cc: ilias.apalodimas@linaro.org,
	hs@nabladev.com
Subject: Pull request for tpm-master-11022026
Date: Wed, 11 Feb 2026 12:05:16 +0200
Message-ID: <20260211100516.63099-1-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.51.0
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

Hi Tom,

A small update from Heiko on SM3 support. We want this in -master

The following changes since commit 712765339a5c6576fdd5683748f97a1215868d5d:

  Merge patch series "Update DDR Configurations" (2026-02-10 12:57:02 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-tpm/ tags/tpm-master-11022026

for you to fetch changes up to 1e79d9c763cf666e146f30ebd45cb486c913122d:

  doc: cmd: add documentation for sm3sum (2026-02-11 11:13:47 +0200)

The CI https://source.denx.de/u-boot/custodians/u-boot-tpm/-/pipelines/29250
seems fine

Please pull
/Ilias

----------------------------------------------------------------
A coverity fix and documentation update from Heiko on SM3 support

----------------------------------------------------------------
Heiko Schocher (2):
      lib: sm3: fix coverity error
      doc: cmd: add documentation for sm3sum

 doc/usage/cmd/sm3sum.rst | 112 +++++++++++++++++++++++++++++++++++++++++++++++
 lib/sm3.c                |   2 +-
 2 files changed, 113 insertions(+), 1 deletion(-)
 create mode 100644 doc/usage/cmd/sm3sum.rst

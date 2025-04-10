Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6F40C369A2
	for <u-boot@archiver.kernel.org>; Thu, 10 Apr 2025 15:16:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2EB1683D2E;
	Thu, 10 Apr 2025 17:16:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="KoJs35of";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF6FA83D3D; Thu, 10 Apr 2025 17:16:16 +0200 (CEST)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3606083B8F
 for <u-boot@lists.denx.de>; Thu, 10 Apr 2025 17:16:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-39ac9aea656so868972f8f.3
 for <u-boot@lists.denx.de>; Thu, 10 Apr 2025 08:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744298173; x=1744902973; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=dpBVgM+BmozE7pt5BcxPi5KLq2WzONKbbONruSns3ig=;
 b=KoJs35ofifl5cN/UeHzhzs6fNERTT6x3eDFAhIth0v28hTFmmh9vqRJJAxW5khnmKp
 LTAzv5pX2VrkF0A1KWNL97UUjQflJLwft1BZ+phwv0xg8jaSdeVOsEtvDEWeujfg/ZnV
 orUVKKbn+kf5CaFfjuyZc5R0DYDj8cdADnI36puSJox8x+o8RDpEl42RIe47pgZNojcD
 c9CqoA3S5oBEUZSJWXF5dhrO1vPDn6TiG0Jg/RHFC5IrEzKQM6TSET7h4bUnfDB1Bafm
 sHUhJEsPFjPuCQGApghjJcXKYaQR2yFWb5VWEcYJL7+nu/dxEPKairGEll7e6SYP7Dhb
 7hyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744298173; x=1744902973;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dpBVgM+BmozE7pt5BcxPi5KLq2WzONKbbONruSns3ig=;
 b=Glldm0pVq0r9ReaxmiFiyRHOevZNHZteE450vzFNSsEengW7Ti9I5Q4HqHTMnlmtxF
 I77VjK3REsbKPEIo8s8tzU3HGJs0xiFLT8ZuubFkrCgx6nQUU/YvZROCLp+wru5RuTny
 NMq2Dv6r2y+IEFruUs7ME3hAC3cXo6rWrW22XaJCkfLSgecieOKwSDu80Gu/gNRZEeZD
 qvcqjVkT0F7X9ksquo8V8OxZLrShA2j5E+zLX/FCulCUoO1chb95VuOL9yPD7+mer14j
 ervUAEgDBQjPRyndfaLTMLUHADajwlcow4dvUS9lhO20cy51SznYuWRqsCd1LKkrxOqq
 cHdw==
X-Gm-Message-State: AOJu0YyR8Tn53TI1IWn3aTfy+PWIMIlWJZbFKyUFigRwu8Myb6EUhuht
 DyOrpqGpvjOwCc0Slr4hfCbzHknuW0qNGayCBMSliCmz4eaGyjNQj+fBY2QmFGDlylB78PTNn/P
 HU/M=
X-Gm-Gg: ASbGnctn3BzD8neWyZrhc9nL+bN7KabcbexHvOVxAbrJPNhuEdRKvjco/rrBnsS9Gvp
 ezyyCevHW4n7TICYIGjYAPSjiRNHP+f2PO7BjHlHrdVwb5wOKgWp5Z6bepME/uHLxrt7lFdMTl7
 Bg5ksQjQctx80dx2dqGns6Y5eFoudRbgHsaGWEUZaZIhTI5kxMYCaJkyOqPcOrByaWPsEAKPSnj
 lOmkd7k+uXYjNQciJpp5X3vbRJ6u/5EgJo/4U955hkqVVSSNaODA5w25IYs7NJwi6TCb3Jdgqjr
 KekhclhDf6w8CMzeDoNfeIGxDa1rhHe0FhpWckuwVVs3tYa+QA==
X-Google-Smtp-Source: AGHT+IGyG2p5ijZ9P9JFAuvA0D05EiloaB3Arz2GJ0s/539jiK/MaY0zrOfbD4tuJrV0++dkFWcY7Q==
X-Received: by 2002:a05:6000:40c9:b0:391:4559:876a with SMTP id
 ffacd0b85a97d-39d8fd8a19bmr2295319f8f.46.1744298173404; 
 Thu, 10 Apr 2025 08:16:13 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:7edb:df05:a425:37cd])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43f233c824bsm54873225e9.24.2025.04.10.08.16.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Apr 2025 08:16:13 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: U-Boot mailing list <u-boot@lists.denx.de>
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 0/3] NET_LWIP LMB fixes
Date: Thu, 10 Apr 2025 17:14:51 +0200
Message-ID: <20250410151600.3370247-1-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
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

Two small patches fixing issues with tftp and wget when the network
stack is NET_LWIP and LMB is enabled.

Changes in v3:
- New patch: net-lwip: wget_do_request(): do not print anything to the
  console
- store_block() [wget]: add Sphinx-like documentation
- store_block() [wget]: do not print to the console if ctx->silent
- store_block() [tftp]: add Sphinx-like documentation

Changes in v2:
- httpc_recv_cb(): add a call to altcp_abort(). Otherwise the transfer
continues and we try to write later blocks which makes no sense if one
has been rejected already. Thanks Sughosh G. for testing and reporting.

Jerome Forissier (3):
  net-lwip: wget_do_request(): do not print anything to the console
  net-lwip: wget: add LMB and buffer checks
  net-lwip: tftp: add LMB and buffer checks

 net/lwip/tftp.c | 56 +++++++++++++++++++++++------
 net/lwip/wget.c | 96 ++++++++++++++++++++++++++++++++++++++-----------
 2 files changed, 120 insertions(+), 32 deletions(-)

-- 
2.43.0


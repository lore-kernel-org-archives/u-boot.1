Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8C08E7717D
	for <u-boot@archiver.kernel.org>; Mon,  9 Dec 2024 15:32:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 36EEF889E9;
	Mon,  9 Dec 2024 16:32:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="P5XX9pbD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 75C33896EA; Mon,  9 Dec 2024 16:32:35 +0100 (CET)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1364A896AA
 for <u-boot@lists.denx.de>; Mon,  9 Dec 2024 16:32:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-434f094c636so10875985e9.2
 for <u-boot@lists.denx.de>; Mon, 09 Dec 2024 07:32:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733758352; x=1734363152; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=6lhMIjzGZfjv6vFZSARisZ7zANQtYsSTw8f3Z0lIWOg=;
 b=P5XX9pbDEvWqTqKDKRWH/b57gzc0mV997OA/2fwJQkmY0fB8IKM0y+9S6h0WrtKMhW
 RRHb8niXQWEyRtHAYcGfROqXTSBydY55IKLwAE7wic1Jlt/y7FxfTUDqQ4B5+QqzQKLc
 LyyekQL5ZVq3yD+Tp6xLf6HERY+6rs38FOQsmHpSgydXMZGtvklizhxf2QCRJNBIVZpZ
 1QA8vtLp4iuLK/J7ZhtlFbgFg1hBwVOxulqTTmaG2T3oT8pxiwc/q8EhBBdXU7cFzhFS
 SoKB3qQEMhzi4mnqrG6RxrxrqhzOEMecekwWlUxkpQ21gRAgvUluzTRr4aDHQMnOcfBM
 4RgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733758352; x=1734363152;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6lhMIjzGZfjv6vFZSARisZ7zANQtYsSTw8f3Z0lIWOg=;
 b=cpn+Zehtw8fum+ipNf72xnBQ7Mtk7PZYpOYrc8i4Wuk1tYBvgsqhhYZvrR40NoxFgy
 2rpqJYwZM+1ASwcO5L0/0y6SoV0idOqTw1RitITYlSEVKEcGt3oEB+QY1r0P7d8idKrl
 SwJsRSUo9Mr56JC4508PAG8ai+crCl7rOUEOgZh3lrKRwWJTTMGwtMfVZxSKx2e7c/iF
 XQkzVO9Ez65f9oPKI9qRTpvgaCRbzyWxHjbB2kkISDNql5ICrfF+OqEpdWupZpbDK+Jp
 g/DPjHtyh/re38Qp/8mkiF50erBTA/2HZqVAJLDov/FKTbB1o5M+fD5wvCzqSqH+UrQm
 vIbg==
X-Gm-Message-State: AOJu0YyuYfLEked9u9D8N6mdAnqDMROMbyxsQyPoR84zl4PRB92urIwU
 H7g4wruNo5bQE9lXJ8g6+bScDHVkG6Bm0ZdxY+HLY1N2Y0lmbLs1h1V9yk1pM408oGIbvMdwnqy
 COtc=
X-Gm-Gg: ASbGncuhmQHFhDqpFvfs+DQThXGUjIL3KSoIUBiaj2xdOU/3gwxzOmPHgZiIv69BBJS
 D6218atcmw7h4iaxl3a4OEi1+oxNlw+YRt3I07GjhGd5Aza2NV/WkvttouFr6Cr+JDQUPLJoLU1
 36UhPIW8jgKuTjy+X4OLS7zdBCta7lE3SqjUkJI5akfT87DpSqsQ2S0I68c6NEyR3Jr6w1lBnIv
 NeCtjQJdI9DKdbbCWbnASsoHHD5wq5h8ZeJnYRablBDZMePnFIwnP+UQqg=
X-Google-Smtp-Source: AGHT+IFINczrkVjIbOZ/imT7cVI0ufUrrr9RYo7Rx2UhmHCKnPvpRc4ilc+j97bEPw7WCs6EBhLssQ==
X-Received: by 2002:a05:600c:1e0c:b0:434:f3a1:b214 with SMTP id
 5b1f17b1804b1-434f3a1b5b5mr34454515e9.28.1733758352359; 
 Mon, 09 Dec 2024 07:32:32 -0800 (PST)
Received: from builder.. ([2a01:e0a:3cb:7bb0:144b:1fbf:fd90:f158])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434f55733d2sm53000415e9.40.2024.12.09.07.32.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Dec 2024 07:32:32 -0800 (PST)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Jerome Forissier <jerome.forissier@linaro.org>
Subject: [PATCH 0/2] Add "trace clear"
Date: Mon,  9 Dec 2024 16:32:12 +0100
Message-ID: <cover.1733757864.git.jerome.forissier@linaro.org>
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

This short series implements the "trace clear" command. Originally sent
as a single patch [1] but here with a sandbox test added.

Jerome Forissier (2):
  trace: add support for "trace clear"
  test: test_trace.py: test "trace clear" command

 cmd/trace.c                 | 13 +++++++++-
 include/trace.h             |  2 ++
 lib/trace.c                 | 47 ++++++++++++++++++++++++++-----------
 test/py/tests/test_trace.py | 30 +++++++++++++++++++++++
 4 files changed, 77 insertions(+), 15 deletions(-)

v2:
- Added patch: 'test: test_trace.py: test "trace clear" command'

v1:
- Sent as a single patch:
https://lists.denx.de/pipermail/u-boot/2024-December/574148.html

-- 
2.43.0


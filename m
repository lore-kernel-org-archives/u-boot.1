Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFDE3C36002
	for <u-boot@archiver.kernel.org>; Wed,  9 Apr 2025 17:17:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA4D483900;
	Wed,  9 Apr 2025 19:17:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="cpxY9Ndn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 22931838D4; Wed,  9 Apr 2025 19:17:39 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BFCE381CF0
 for <u-boot@lists.denx.de>; Wed,  9 Apr 2025 19:17:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-43cfdc2c8c9so41261035e9.2
 for <u-boot@lists.denx.de>; Wed, 09 Apr 2025 10:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744219056; x=1744823856; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=b7HNhv6JIRBU1mQAGx+DKh6JC4FUWK1xQm3tLpVpK2k=;
 b=cpxY9NdnZL6I9TTu0QSirUrAtvBW/V00s85mTuJVG+0YiU3y5GLYuSGfAIex4okW0a
 BrkDTWug6cBeU64NBnd+eNnPbjaOtpQT/FAdaX4kQBA1FA6xVH/8vsWLPd+jwFj4J596
 ZzDanbB5Op0O1PO7OP9cQRMkd2p0jCl7Ez3zXHTnp5zb4dF6qGiLJJKJO2QSMH0+PGrv
 Yqeubr7UJ6P1KSLbe09aQp9ob1irVy96GthEj5wvVYFjS8ikElb0D74ZeP7+EYe4S783
 lxCMzdhZdvmSTbYkKDAkXWWVsMg4tBeAlQisC6u1DTF9yniwoyl7mRZDSVVaJ1ZoIqeW
 kFLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744219056; x=1744823856;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=b7HNhv6JIRBU1mQAGx+DKh6JC4FUWK1xQm3tLpVpK2k=;
 b=tGP4qYARTt6QST+IpJVv6ohGklSPFkhBDQ90YeBQkwFkF/tUlK3utia86Wkqi+hX8q
 QVlZ+6Rkk1hlipg3rUhfsWvjB+1IqZVrfxuYxL+1fRmoyOkgFlpEGoJG3xoqmsmq3jQC
 15mLtu2JAW1nhKnFehWgvY1z+YKiWYPnUJhkQnm5E0bq/qgD7ATjpekLi9QtPrGDmHvx
 Eum+8rwZKWRSvYmZsIx0NDPmMdl/8Kku08lSae7GpKKZEHB7oOH+3YxtOYvber/S1Wr4
 qykxZ2feEAvJdLoJXvWT1Zpa8K5qk4tbr5XkAaZTtpE1nSqDmpIc+aQ0tFNXjfKHvTUO
 vN0A==
X-Gm-Message-State: AOJu0YxYBcrWN9/8uPHZcQG1aepfrYZptvBOo5SPp0HU3UwR4mIOi4P5
 /rj/k+vICLk0Hcmj/RdAlKmRVCkqvquXfpz6dnXXOykYdUxBwcWbF7n2FcocVIHIys33gLuksmn
 4F98=
X-Gm-Gg: ASbGnctKdIoVvWZ3VAyn23cZe/jXLDUFUVcxHVUOSynIsVfrS3EoXUtPpkdFVC/M7WA
 nRC5Icr1zNrMpjHtOqVycwntlc6+ISZY2G6s1FwZ9O1mv2nZWxzFODIYyTcaMqovgpQso4AqSI2
 u46JjfBovsZljbkzkKwSRjseLprSBkwD/+YWH2NozQwpP6ltJsWtnXVxGKmy9KwEVkhfqY7KUYK
 r7mDG1POnkPlgZryH1JYzYehAXoa7lcyBFLOQtTVZsln7fM6c+db5tSzZIpMmBEoPmslhwjvv4W
 WSHOc6NvUqw0Sv5r4ZK4KNXBbP94yQiUDmzE/YpGfEu2R8s4wkxt98cbj981PEAc0ZhD+smwl4L
 SXAVvYKyttQfvPivD
X-Google-Smtp-Source: AGHT+IErKRityXARLGWVsiihfPtV5nbZ4rRQ4MirBM1fIwiwk+NDusd8uRF8NUlf1qdvOeelWEG9Rw==
X-Received: by 2002:a05:600c:5396:b0:43c:eea9:f438 with SMTP id
 5b1f17b1804b1-43f1ecc5237mr43939655e9.15.1744219055793; 
 Wed, 09 Apr 2025 10:17:35 -0700 (PDT)
Received: from toyger.tail248178.ts.net (i5E863B08.versanet.de. [94.134.59.8])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43f233c817dsm21916455e9.23.2025.04.09.10.17.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Apr 2025 10:17:34 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Subject: [PATCH 0/6] Qualcomm: cleanup OF_LIVE fixup and fix RB1/2
Date: Wed, 09 Apr 2025 19:17:23 +0200
Message-Id: <20250409-livetree-fixup-v1-0-76dfea80b07f@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKOr9mcC/x2MQQqAIBAAvxJ7bmFNJeor0UFsq4Ww0IpA+nvSc
 RhmMiSOwgn6KkPkW5LsoYCqK/CrCwujTIWhocaSoQ43ufmMzDjLcx1IU2us8l67WUOJjshF/MN
 hfN8PGijjNmAAAAA=
X-Change-ID: 20250409-livetree-fixup-0d7451cc3af3
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1827;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=3Fn1fnpnJYmDV8nR05qPzJcewTTQZI635YC0oyr1eXY=;
 b=owEBbQKS/ZANAwAKAQWDMSsZX2S2AcsmYgBn9qutJLbG14QOqz3hbFXDmyFUDRzjJ7KTK5VRQ
 XnLDbsnEiGJAjMEAAEKAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZ/arrQAKCRAFgzErGV9k
 tuYnD/9Q2eUJahTwCp+/m9HDa7iREFYRq9UMlEBYZmFbH1yyfBKtJ4rx4DZuEv64fSzMT0Sipxw
 xFwy/Qpfucg2Dn8McxBV7cBhiTbfOGfFy52TKjgoVNX9iDkupSxEPhWg+t0M00ckL9jz6M3SKnR
 ID8vqo3bD/inF1Xyjnh2puhAJSfl9RO0n0AL5ogmjzofSBcuJe1k73ZnnxScLyjRUyvLEW3PPwF
 qpVgS134kj8BT0BOl14Rvn+0t0hiqiMhWEYwPRGmJezYv+yix4PGONVyXezYBRx1eCFUuuyk5kl
 PaVzmzGl+8dkHjdxz9cFARho8sH+i9uuUFY/IpFiBDEjOaNKgZ+emzXlHuVo+NWYv2/miHfFR44
 /sS/J4wmrIZoVFlgcF8QLv8ctcqiXpedhzssu9OXfULBpYLZCEL7D39THo3NKjdpuOrctUob/PQ
 kfpNHFIUndWsI324Iu7w7TPLRcS28t+e9pIGbNkzTvEecpCsEftbIAVnTSOibyzsmX8glItHsix
 7hG4Epk9DhY1PXEpp0XQrK/MbhwoxlDp7rVZFlkfBmTnPq8DYNNvbu1+EIW8BIrUZgRm465qoQJ
 YSq9tflJDfZTgLiIuO/QCniy8/2WU1wsVZCt0pQ/TG94ZSdrCAdwlilYevqINgDD4Sw9pV638vn
 vX6s8523OSehFKg==
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

Introduce a new event to signal that the live tree has been built,
allowing boards to perform fixups on the tree before devices are bound.
Crucially this allows for devices to be enabled or disabled, but also
allows for properties that are parsed during the bind stage to be
modified (such as dr_mode for dwc3).

With this in place, mach-snapdragon is switched over to use the event
and some hacky U-Boot specific DT overrides (which had to be undone
prior to booting an image) are removed in favour of fixing up the
livetree (which is not passed on to further boot stages).

Finally, some minor fixes are made for the QCM2290 RB1 board, the sdcard
is enabled and it now uses USB host mode in U-Boot like it's bigger
sibling the RB2.

---
Caleb Connolly (6):
      event: signal when livetree has been built
      mach-snapdragon: use EVT_OF_LIVE_INIT to apply DT fixups
      mach-snapdragon: of_fixup: skip disabled USB nodes
      clk/qcom: qcm2290: show clock name in set_rate()
      mach-snapdragon: of_fixup: set dr_mode for RB1/2 boards
      pinctrl: qcom: qcm2290: fix off by 1 in pin_count

 arch/arm/dts/qrb4210-rb2-u-boot.dtsi   |  6 -----
 arch/arm/mach-snapdragon/board.c       |  1 -
 arch/arm/mach-snapdragon/of_fixup.c    | 41 ++++++++++++++++++++--------------
 arch/arm/mach-snapdragon/qcom-priv.h   | 14 ------------
 common/event.c                         |  3 +++
 drivers/clk/qcom/clock-qcm2290.c       |  2 +-
 drivers/pinctrl/qcom/pinctrl-qcm2290.c |  2 +-
 include/event.h                        |  9 ++++++++
 lib/of_live.c                          |  3 +++
 9 files changed, 41 insertions(+), 40 deletions(-)
---
base-commit: e4ffc6a323586d700d88c73c319c25c740aedb49
change-id: 20250409-livetree-fixup-0d7451cc3af3

Caleb Connolly <caleb.connolly@linaro.org>


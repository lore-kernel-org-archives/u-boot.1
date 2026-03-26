Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7907710A3D80
	for <u-boot@archiver.kernel.org>; Thu, 26 Mar 2026 12:08:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E7D3F83CD3;
	Thu, 26 Mar 2026 13:08:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Iy8F+x8O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 18F8183CF5; Thu, 26 Mar 2026 13:08:22 +0100 (CET)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E2EB9838BB
 for <u-boot@lists.denx.de>; Thu, 26 Mar 2026 13:08:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dan.carpenter@linaro.org
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-486fb14227cso11091255e9.3
 for <u-boot@lists.denx.de>; Thu, 26 Mar 2026 05:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774526899; x=1775131699; darn=lists.denx.de;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=t4cjfZg4F2PiXHof9rE5/dVu2fe6fRlZdwfljw54iWY=;
 b=Iy8F+x8OUyGvEmEcghcucEeHvEGK1AjoNLoldA6Tk2a2dzS04TNUgtB2S1LmBOZAbw
 4awIrPnSe4vCDqlAIas4tFqREXQg0LVjSflA/URN+sYALC9g2/S5mT6y0MRu+YThvGe4
 SvLk4PIBaGLY7EZM+PD2S3IvamocfXKA/HdtGTqw5+tqRgl2tBS9vtoN4Ai8qSrCVGIN
 CbrFOu8bHhB20OOr0PczzjsbqB1RQqqNIWIIu85wRC280JsLS10bWncqZiUIZXOUStyV
 OH1rOF/7TSamndedyBqaSPxc/gqnyStGTKnauO+yMBfdD1U0ieccmG+bIk5HsReWH1Eo
 2CYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774526899; x=1775131699;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=t4cjfZg4F2PiXHof9rE5/dVu2fe6fRlZdwfljw54iWY=;
 b=LSrYa4F88g97rfSwDX8+jcWJ8Z5aosA7L7kwRSHVCHsTzgoRsJSbbWg4ymC8CXhIJw
 Y4E6tOI8/4zhWzYI2fK9O9euSGchHzBEvJmD2pq4QpooplYy2DqGAxX1l4EWCNKP7g0v
 p1us5ZkWzwnv2oSBIe8QPc7flleoKHc224zu3OsyOPtaMHIwxQ3vL7WclpJJCT9HzPvN
 AHoZPLhiWGRLF2cDGAPbFt9bOUDeHoyHJhyOTe76yiMiqi8nP3MTL99O+BV5xjDBIQkq
 QJ8y1d5UR/uK32o9Vi0+2g3ZsQFW6wY+iEwsy9mMGwwYvwnpb7B2ZRVAXCLAlIvZ6GMA
 G/JA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUFcO4PDFGWhXHEH0jTB0OUfW45GtNTKcgQhtCrOWU6219ttvYY724Zld6gdoxG7pYQlEed3Yo=@lists.denx.de
X-Gm-Message-State: AOJu0YwTQEZuxeO2uaStlTacuOoTaIzGGxDmLH+fiHXlJU93AHdrIlX1
 4GH1KCzdfSI5IqmqDGimByN75TWu/nZ372riMGv3gYbHUvX+jv9VjPJh+XbTUktq4Cw=
X-Gm-Gg: ATEYQzx/e4YgySTXgk79iuzTL9YFd4B7dYv9KgKNzQ7SxzWksRT9JM2tnkrjoQIeTM3
 PpVZIBg3PGixW1Q6VDiH2/DZPtNXD7rOUAEovckMR6hZI+LsdTL1b94774wFDCcHooEbE8lX+M+
 sFzWewBClNn435CT1kDYppXZd54vghcvy6myr5TKEhEDF9vRShTSXcOIXkw308GN/0l4s7E2RDm
 f2ukcKfnOBeNRoFqZolA57kXg+4o0kkcuVTwXs49Ob0q9g9JPsX66qh1QEqecalKH9QpFiUQg37
 cfUfKzS9cEgAmePgIsi3pCLGvg1qIPcr8NHbrRQ1ID6irkBYxhUW7eUlOH3EM7YIV0csIEcGbDt
 pElKwCdOQPjFog8D+ucWa/MoRxECgciAMXXexZPwOtWRbXfUTyvPJRrQr0GVqG2fjcrLqaoBdY1
 HgYJwZt72houO3GBavrK4ufmUWNF6E
X-Received: by 2002:a05:600c:3592:b0:485:3bb5:92cf with SMTP id
 5b1f17b1804b1-48715fea715mr118494995e9.12.1774526899232; 
 Thu, 26 Mar 2026 05:08:19 -0700 (PDT)
Received: from localhost ([196.207.164.177]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48722d236a9sm61097315e9.11.2026.03.26.05.08.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 05:08:18 -0700 (PDT)
Date: Thu, 26 Mar 2026 15:08:12 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de, Vincent Guittot <vincent.guittot@linaro.org>,
 Michal Simek <michal.simek@amd.com>, arm-scmi@vger.kernel.org,
 Linus Walleij <linusw@kernel.org>
Subject: [PATCH 0/2] u-boot: pinctrl: scmi: Use standard pin muxing format
Message-ID: <cover.1774526652.git.dan.carpenter@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

In my original code I created a custom format for pin muxing but it's
better to use the standard format.  I also found a bug trying to use
set the function.  (That code wasn't used previously).

My GPIO driver is not affected by this change:
https://lore.kernel.org/all/ff0756d9a26c95540fb65a35765e9a43949a5814.1774350851.git.dan.carpenter@linaro.org/

Dan Carpenter (2):
  firmware: scmi: Fix setting the function
  pinctrl: scmi: Use standard device tree pin muxing format

 drivers/firmware/scmi/pinctrl.c |   2 +
 drivers/pinctrl/pinctrl-scmi.c  | 151 ++++++++++++--------------------
 2 files changed, 56 insertions(+), 97 deletions(-)

-- 
2.53.0


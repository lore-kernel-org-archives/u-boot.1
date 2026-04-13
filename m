Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3CFAEBFD38
	for <u-boot@archiver.kernel.org>; Mon, 13 Apr 2026 11:06:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D208839DF;
	Mon, 13 Apr 2026 13:06:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="SkNL0/Fh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 90CA484119; Mon, 13 Apr 2026 13:06:20 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1E02D839D5
 for <u-boot@lists.denx.de>; Mon, 13 Apr 2026 13:06:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-488a4bc360bso23140185e9.0
 for <u-boot@lists.denx.de>; Mon, 13 Apr 2026 04:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776078376; x=1776683176; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ASfmMggwx3RfaBtCf6C/rAG48PrpV0v/xrLa7+Mcotk=;
 b=SkNL0/Fhlw61McdzNFJCDd1s/SeEHwXqmuEA+LCTh/0+2G74HXEFXClddGPm4tb/Q2
 efV1CadsMctm21fFqMk1P+2urVtilBYlo1a5QM2F7ySueWzbUY41oRfd76p5hdGaPvGv
 RAildKWYcmSzkMSGF28WIDCsdCW1mKeVX0Zd8EL0hLRMsBtNY7YCtQPmuEIb4gL8rIbR
 5pc84NmmSh2sV5uiFEKHHW8NeM2DW1v2XgLJZjmfrAFsjU5Te/EEbL4qGGkQRtzxCi+U
 WBen96ZN7UZfXz7zSM0/yduE7CRbojwtES8+HKjq6YgSGlq+rbqcHYVAIedsZtWVFvPA
 X7tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776078376; x=1776683176;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ASfmMggwx3RfaBtCf6C/rAG48PrpV0v/xrLa7+Mcotk=;
 b=ijICjdAEhrqMTTP7C+Pz3GKsQnpOyzGKsD+RcsVpQOFm5v9w1GgvUvI8HXYTF7IVu2
 EOJACz7ii/kSn3CYvsDGIztGQHwunqBvBOiRSkc+RB/VVLCo3QdHqzvxERDEigeLmh0g
 vPppPlQ2WFNe9EpHQQlp2oYVv9W9jndpAjsmw/1Jch0sc7kXOzBGem+fnPWNmm+fOiC7
 Pt4wAORmKR4D//92kmE3w9N/d7jqaiUxBtZTGx0JjMyFkPkXZONUAKbXbHkF28GFL5Z8
 0DHZnGciVg2wE/aSnBFePFn1dmGBxggvRVmr/nMItKP2n+3ASa7YN7L9wK+pZKmE+SVd
 Y4IA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/7XqrqBZJeBpH8ghPLzzzVER/JRP0aQxb/hbgQjyQ1EN0mFUU1lF7/jt7Zz2QCrfqfiuPM9jM=@lists.denx.de
X-Gm-Message-State: AOJu0YxvE08XYNer1qJaUNMLt9J1jRm2Y4yZymlWHrb3amRJ/lCylK2Y
 Kb5thbn+yzSJcvzX/rIegEvp0Ay9ACs9KdYgbv/+0jXqUL4NSmMpkp/er6RCYiZycBCMEcScKE9
 OjSVOiT4=
X-Gm-Gg: AeBDiet+XWj7NXGye1SvJlIzyNf1zocc5zICadpWRa2EiHxLmY3islWKwHZfwhH0opj
 zkqXGKro07HMfaHXaVh+MZofiNFH7TzU5KzR4kiywE1iTojkSRxY4QfybqMcAinX0eE9iqyHmyJ
 IJL1+AS/LtU9mg1VWwKWI011KHOOqa5nG32EtSsOt8mT2x3Z98Ucz/nSF2L5dK4xsa8Z8dHr5Nk
 Z//Kcqfg6/FNrnDjS1/k4FmYdfFvpby/kkByhdNDKEwcKlL9D1vBnbXkriOKx1e/xxr18xnrCgp
 kFyI97blrfVjvyoa/+j4WQA8mzXPpq+i3STLPHyGeMNmAtanUhz54NLyHI1bRGfcQxPyJlXWOiC
 ZRZyOfHqqd1aP/6J60IvHJsFssAWY89mBA1ju+ICEQtpBd6RMrTS45OQ+kwg9xGGUHKdQBiKrJ8
 wh5DNuLmwpMhX5/jiR4E23nBrW1aKgkWVus4YIxZV4z+VUw1S8RcwAGXcDOJrulVVe9IH6
X-Received: by 2002:a05:600c:46cb:b0:488:c51f:e04e with SMTP id
 5b1f17b1804b1-488d67f3a0fmr177495285e9.13.1776078376189; 
 Mon, 13 Apr 2026 04:06:16 -0700 (PDT)
Received: from lion.localdomain (p4fc3dd86.dip0.t-ipconnect.de.
 [79.195.221.134]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488d5347ea5sm327284945e9.8.2026.04.13.04.06.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Apr 2026 04:06:15 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Subject: [PATCH 0/3] Qualcomm: rpmh and regulator fixes
Date: Mon, 13 Apr 2026 13:06:13 +0200
Message-Id: <20260413-casey-qcom-geni-rpmh-fixes-v1-0-2a83a67ac0f1@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACXO3GkC/yXMwQ6CMBCE4Vche3aTdqEefBXjAeoAa0LBrhoN4
 d2pevwymX8lQ1YYnaqVMl5qOqcCf6gojm0awHotJnFydI2vObaGD9/jPPGApJyXaeRe3zBGL3X
 nggQfhEpgyfgN5X++/G3P7ob4+BZp23acIwXHfgAAAA==
X-Change-ID: 20260413-casey-qcom-geni-rpmh-fixes-ef23b0525152
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io, 
 u-boot@lists.denx.de
Cc: Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=1662;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=Q3EbBCadEa70aJ01r9FuIeJkhjaBbaPpB/ksgFzKd+A=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhsw759Qe7t/S3PT4llJXnXM+c4ar4AFBliliYt+PLJ/er
 Vbit3ZaRykLgyAHg6yYIov4iWWWTWsv22tsX3ABZg4rE8gQBi5OAZjIS02G/z63DJkeuybXTjNb
 fWrTdBbXC9Jn7O/xGR9cbbVM9/HN6e8YGRaE5YvIPbud8/in0MeplVxufz53nj0VNF/p6wyrnmm
 nRE4DAA==
X-Developer-Key: i=casey.connolly@linaro.org; a=openpgp;
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

The RPMh API is frustratingly complicated and lacks public
documentation. With the Linux drivers being the only available sources
but are highly asynchronous and thus hard to translate to U-Boot.

The main issue seems to relate to sending multiple commands in a single
TCS request, currently this is only done by the interconnect driver and
while this may not be the underlying cause it seems to be safer to avoid
this for now.

Adjust the bcm-voter driver to avoid sending multiple commands per
write, and additionally adjust how we send RPMh requests as well as
improve the cleanup we do prior to booting the OS.

Lastly, add a missing piece to the rpmh regulator driver to ensure
that when a supply gets enabled we also propagate a vote to its parent
supply. This seems to have been missed from the original port (perhaps
because the Linux regulator core handles this automatically?) but it is
necessary for some peripherals on some boards to work (e.g. to ensure
that the spms supplier for an LDO gets enabled).

---
Casey Connolly (3):
      soc/qcom: rpmh: properly fix synchronous requests
      soc/qcom: rpmh: only allow rpmh writes of a single command
      power: regulator: qcom-rpmh: propagate votes to parent supplies

 drivers/interconnect/qcom/bcm-voter.c         | 16 +++---
 drivers/power/regulator/qcom-rpmh-regulator.c | 35 +++++++++++++-
 drivers/soc/qcom/rpmh-rsc.c                   | 70 ++++++++++++++++++++-------
 drivers/soc/qcom/rpmh.c                       |  6 +++
 4 files changed, 102 insertions(+), 25 deletions(-)
---
base-commit: c704af3c8b0f37929bce8c2a4bba27d6e89919c7

// Casey (she/they)


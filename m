Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E983D1D493
	for <u-boot@archiver.kernel.org>; Thu,  8 Jan 2026 20:29:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD40D8415E;
	Thu,  8 Jan 2026 21:29:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="kF5hm9W5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9876B842CD; Thu,  8 Jan 2026 21:28:59 +0100 (CET)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 746FE84158
 for <u-boot@lists.denx.de>; Thu,  8 Jan 2026 21:28:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-b7eff205947so496611766b.1
 for <u-boot@lists.denx.de>; Thu, 08 Jan 2026 12:28:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767904137; x=1768508937; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=XVrO/tA9lOtQUnXiu6Iyn5cCn0wN+PfpjVE1TM2XE78=;
 b=kF5hm9W5EhsBDtc/IGl0Sr1ZRAqUDgfcd6H/L9q+hcHPVA+Q88zysgP+NndYDsY6RW
 sP0SDERiHR0RtQqVyi+tzLg1xIyQVSeX8cM9SsJKlimY2CD6hw9nBHpICugZUPHPaxjU
 2k+mYJb12x3p/YQ7wbsumZ+aI7UzBw/TMsFsXbLS/QwucCK6i7ERsjqtWpsgOoO7zNLh
 9zIK9OMyE6LCnJj17tKiJzNz0dkpv/UCi4kw8olFYN7HCeH24o3yOoPkcAMaVHjxUV89
 xbipg8PKm2Yb6Rqz+VUhQyuKUoMIsaFxm4WzhOP7xABOYnCK335H4V0cvVDL+g0JMyTG
 6vTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767904137; x=1768508937;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XVrO/tA9lOtQUnXiu6Iyn5cCn0wN+PfpjVE1TM2XE78=;
 b=RyVEZ6OD4JlzLCs1xPdjX8ByvezhkWsGIrDzLrgbUJ30l1JM30jTkCbPMBBN336NeJ
 3uxKUx4IDhsJrD7JMsHE0dl/g2Y6sw60QxOzstZvM0zN5fQML6LNpbMhnccsXaapRZdE
 EjSpRv6pct/BeswuINya8yUg7O3aaAIPk2hCC7dF4lKOJ7zEHN6TaxS9jq++dytkmkYZ
 /w7DAF0/CfFxpfNfdfM/W5R7Isc5mz66ZF7OUMHYrtn6cHavxND6CIpoDXyGwXrSQ7Ep
 jd/4w+Uh8Huh/blORIV/vnh4IhxDCz9WfGgE8gmO/YVgloGOyFxRPFWdXJ0nbBhP0vDl
 a4QQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUYIYHU+xxLzkhV4jwVD+ktEuoAvhtMtYnm8P2fAJmfts1wwvHrpzTBGHCklV7VMNaBH0gIRXU=@lists.denx.de
X-Gm-Message-State: AOJu0YzWb87t7hr4Saq0kCDdAk/Qe0SHyr38tupberNNsZukXOtNZ4N+
 UpOGd7aHEVkpC5kmvM7zDhPA5U/NjTwhRpl4PQDd72J8TJw3VGAJM2EXWjL+LEO/eck=
X-Gm-Gg: AY/fxX7mAlHvMoawQvFY0ZOXezvgZzfr029G/Qtuq2bwesZZvzgEFMCyNk51MlQY8wO
 //kutqi1JqJKQc7bhhQA5Ck/A0bCNsWwUcpma7AjBnE9sY95WWVIozn4Glg4a4DROowckGlM4uc
 XDaNctI9EI5Q6LIkX/r7Nz8NLRJ5x2g1AtlWEd5U3asrtZJ2X/I+nsqvOPWBV1yL+kQkyTs6/Xj
 MTjj/cMMChX7GFBAoERzq4kBNKT3uEL3sTIl73i0RuinR8njZDOUtOmkNt1mldVWmOUcN8BQLQw
 j8oNoOOFbJk2vbTorObIQRUdcGFJxQZvhYCNaKAfHlY3TUS1B8a1dNTCq3EN/omuJohUILBJyVe
 vies9vDhlPr+b9B9D5ewRTMo79LfGo0L4n4YRZY78SOHKOuKWuzLn9fpFd9w1O33qbQ6kjHQbWD
 5PxrJFjTemxB1UhdHUnt6D/8pAnRj945rLpLsj3qrCSbU4+pYr2IKEpf4EtdwRo/7R
X-Google-Smtp-Source: AGHT+IFrC+6nHlKF1AvLPPexuz2ydWMbmHmh5xsy+OfI/r+pe+XzpmexSkSqk8LASUrH4vme/XeJyQ==
X-Received: by 2002:a17:907:6d1a:b0:b7a:6c39:8e73 with SMTP id
 a640c23a62f3a-b8444cced16mr698130166b.23.1767904136827; 
 Thu, 08 Jan 2026 12:28:56 -0800 (PST)
Received: from lion.localdomain (p5b29e30b.dip0.t-ipconnect.de. [91.41.227.11])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b842a564e05sm930264366b.65.2026.01.08.12.28.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 12:28:56 -0800 (PST)
From: Casey Connolly <casey.connolly@linaro.org>
Subject: [PATCH 0/6] qcom: rpmh read support and regulator fixes
Date: Thu, 08 Jan 2026 21:28:42 +0100
Message-Id: <20260108-rpmh-regulator-fixes-v1-0-d1b5b300b665@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHoTYGkC/x3LSwqAMAwA0atI1gZSoSpeRVyITduAP1IVQby7x
 eVjmAcSq3CCrnhA+ZIk25phygKmOK6BUVw2VFTVZKhF3ZeIyuGcx2NT9HJzQmqN9dY756iBvO7
 Kf8hnP7zvB7eD7eNmAAAA
X-Change-ID: 20260108-rpmh-regulator-fixes-0815f5fddd07
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io, 
 u-boot@lists.denx.de
Cc: Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Varadarajan Narayanan <quic_varada@quicinc.com>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.15-dev-52d38
X-Developer-Signature: v=1; a=openpgp-sha256; l=1193;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=Cj5X43RtDcqUp4SGdfZ9XEEKdWvk8rYSyRXhHKH8giY=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhswE4faQ31MPTm94vyBtW9dSv6/aTava3SvMQ9Jj1z50N
 K2UYm3tKGVhEORgkBVTZBE/scyyae1le43tCy7AzGFlAhnCwMUpABO5+42RYcJnX/VCnmnmm3tV
 rLm4jF98mmtwb5PUo3q1MNvK01NLXzP84RKTLjTuVypjOHP6nMpRb5vJ4uZvX0QXzb77ec+Pq2s
 sLgMA
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

Fix some significant issues where we leave the rpmh core in a broken
state and don't correctly poll resulting in bugs and Linux crashes,
implement support for RPMh read and use it to populate the regulator
driver state.

Lastly, fix an oversight in the regulator driver that resulted in PMIC
modes being set completely incorrectly.

---
Casey Connolly (5):
      soc/qcom: rpmh: document rsc registers
      soc/qcom: rpmh: correctly wait for TCS flush
      soc/qcom: rpmh: add RPMh read
      power: regulator: qcom-rpmh: read votes from rpmh
      power: regulator: qcom-rpmh: correctly map pmic mode

Neil Armstrong (1):
      soc: qcom: rpmh-rsc: reclaim the TCS to avoid spurious irq in Linux

 drivers/power/regulator/qcom-rpmh-regulator.c | 90 ++++++++++++++++++++++++++-
 drivers/soc/qcom/rpmh-rsc.c                   | 89 ++++++++++++++++++--------
 drivers/soc/qcom/rpmh.c                       | 38 ++++++++++-
 include/soc/qcom/rpmh.h                       |  4 +-
 include/soc/qcom/tcs.h                        |  1 +
 5 files changed, 189 insertions(+), 33 deletions(-)
---
base-commit: 81f887ab1a06be17ef81b0a905203cc385c3d4aa

// Casey (she/they)


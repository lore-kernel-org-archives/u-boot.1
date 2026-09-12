Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 801E9C88E53
	for <u-boot@archiver.kernel.org>; Sat, 12 Sep 2026 13:27:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 285EA407CF;
	Sat, 12 Sep 2026 13:27:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IqZJGbV-Bdv8; Sat, 12 Sep 2026 13:27:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 116424072C
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789219638;
	b=KjrKc2YI4BVr5Bp2wBFwEpt1AVgycX2sqbzcsOOymPM/qlSGWuM3V0IVF+RY8ojmn3IC
	 CzGjRZuYdrnD8AxFNOGdOcKxxyQ6YY5P7HzwmD0Zjzden9Wq4kTjUPf2G1xWK6JxV4Nu+
	 DspUu7C2gnAv+vJ6mu27qHFAF4W1w1dn2kxDRY4CZrwEt1rm6nSeLnIPPBWIWLHvyQabg
	 Ez+6JzQklJGP/oVbFJhBitNJkNIG1dIaxKgb92MSX9oshS01ck61sbZhgkEpSENVMwZf1
	 zyCgMO8vy3UiN+5CRrkuctSlHuISyiwdjR/6JprSeeBlbBu5FL8YgRSG5FSVj/DIByw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789219638;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=xR9mRS8ZZceISomyWsVWo6EazfAuxhlwrnNsxr3DUdM=;
	b=mAby6bFKI9QePEbjxm3bw2r/qM3kyF4FwjHhupHCSyn/dEbzMR+WQy2AeRNPTdyqS3wT
	 zIPZG3w4SbtwgWlr4cGenns4rf92fGl4ye7dPM1QJlR5taJSJCwcGqG1bm4i+bLVQ9acg
	 7rCd3lpiU1MstJKuRSFuOPZo+3SOQju3M1AcdUt7uTkwi2sNEIzMUsSqaklxMTBSY0RhI
	 XW/QjUpC6mFAD2ozqJ70EWBgtR1BdhUsGbrIt/WebpTtw6YwyCkOoKqiflf4Y9Xlk317g
	 gReTM7hraxoWP5C0qzqEac8fhe8akeOZBWTNdF6vwX1HdTtmNZTaF4kOHNSbyCkrccQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789219638;
	bh=xR9mRS8ZZceISomyWsVWo6EazfAuxhlwrnNsxr3DUdM=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=yGDWPIyYwgUrFJj0/HDdt6ZC4zmIkYzsvMeO/usU2Cpv5wwmzL16esE4ykp4J5T+d
	 xucluQf6t/ROJnV0LZzYB518m9ovgYwUtwTD1MQCxPWwq2VkORE+uaBwF5Qv2tdvIG
	 sHVlFGudrAdtaX5tdQDQdUneUP71GtpamZJiokYi4BIpN9UI6KJzJwwNFDY9gCndMU
	 4OXs/Wx1KWif/EoMjPjIMK9gSTVYuRCAkasLSnsLOACnHuk7dc4CmPLdzZqzd/aOsC
	 dHsRY6Q8eWlQQSps55htVFYuyn/JM/WNsTcuvyAK8e07oBH7s/TRPqReJfiiirsvGs
	 QO4EqzVLjAGfg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 116424072C;
	Sat, 12 Sep 2026 13:27:18 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 4F2BCEB
 for <u-boot@lists.u-boot-project.org>; Sat, 12 Sep 2026 07:27:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 351C1400E4
 for <u-boot@lists.u-boot-project.org>; Sat, 12 Sep 2026 07:27:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7-j4Pmx2s-Ig for <u-boot@lists.u-boot-project.org>;
 Sat, 12 Sep 2026 07:27:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 509E340076
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:39::11"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789198050;
 b=R+JI4Q0XxErqEzdzt3hShArfq65QrNuApovZy4GIbCAIaJ8yUTr2SEPAFYqLJBFuWgzK
 dKJD0iVYRhK14mu/6552TJtHm44ZFl6YJe+b3SevPiH3YpKYedIhBv7alxq8ohaV7Qx8x
 sNB1hrtP4c/yH175UwKslcjbsauIT+4u2NU9DXIVH2TihzvwaK5U4VW1C2buYbK+eBs4k
 QQcDWU16IWuGUYoQlPAIftslBSB0Hc7r4Az9pj2e/fhki8DububH04AWBtgAjCwbLzp4F
 EwXFwwp26p5s+EivY9OgYDp1J7zbIefkb1m9d3tdNL27o+OwWFMfV04fK6xu1ps05kg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789198050;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=xR9mRS8ZZceISomyWsVWo6EazfAuxhlwrnNsxr3DUdM=;
 b=DORmWn5XfSROK5/6pqSbd5L0TsmPsjh0HtugzrX8FEFDHzSCzZhYMf1zaogWiWVyQu62
 ClJbblPGhn0eLOYw8iH0Ol9A7rEI2PtwlU4OfpJ5rfmR6eSaKDKqedEduT4WmWTXaRQsz
 2D5H8EIu8F4RUKJohX7SGIeDDVY1w2qIRs0Sgyr3ly/tPLghAM0Bn2Rj7idekstiTOeeV
 dOsEKEZmtxgUKBtZau03LvvmG8viMZvwxMSUcWvU9PWOpPFeKTKEqTYH9LTEIL1tby7so
 +WCHl/BIBksa7UksNmWTmS17PfNH2OTApZ7qDuj5H0GBipTTFMT3dBjG0MiXGy6uCSA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=SYpAnl+4; 
 arc=none smtp.remote-ip="2607:f8b0:4864:39::11"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:39::11; helo=mail-pj2-x11.google.com;
 envelope-from=imkyufie@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=SYpAnl+4
Received: from mail-pj2-x11.google.com (mail-pj2-x11.google.com
 [IPv6:2607:f8b0:4864:39::11])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 509E340076
 for <u-boot@lists.u-boot-project.org>; Sat, 12 Sep 2026 07:27:29 +0000 (UTC)
Received: by mail-pj2-x11.google.com with SMTP id
 d9443c01a7336-2dd4b678f3aso2831515ad.0
 for <u-boot@lists.u-boot-project.org>; Sat, 12 Sep 2026 00:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789198049; x=1789802849;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=xR9mRS8ZZceISomyWsVWo6EazfAuxhlwrnNsxr3DUdM=;
 b=SYpAnl+4yS8ost64zhtRRlMSGV98USbz+5C7+1gKbEGdR8KsARLZ6tsCjD/ZxOIWvz
 Ft8g+hS9YE1f2Cr6fll7nE6U1kWanT5Pusj1bY6XFj7D+fjVH8LsfuBRXZJVskgCsSA/
 yTxHUKbnT7mOOnLLqHRQAchDDedypZfOClAsiUkAi6xd9sFdSRTKRh56MkaK4VM6tLqB
 hF60Zb6GpB4RnaSx4+LIcqMTrH4bWcw/WDLEWv9O3bDkwle6JKVQp0INUkB0D8dJWayv
 11T6McqJMX2MW1x1s5PijXmOpV4PgmXykKM+YAtcUxYSTMrY5G9MaMHgqnHd94R1RCQT
 Gz5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789198049; x=1789802849;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xR9mRS8ZZceISomyWsVWo6EazfAuxhlwrnNsxr3DUdM=;
 b=XLBy9EHViqKPs7Nu18qCBMp89HnalZxNVmyyyqEe/CLUpoV2KuqjdjPIhDSKGdfooq
 ex5e9c1hWNvwFrmwUwYOM0yJak1t4pbUuxAY8Gle4+mbR+olj1xxK8B9ZHpztVirDbZF
 Xz7yqIFGBGtOKrdEIvXaUNjhZOJ8r54xcLO98Lejfo0c9oG7U3UJ2eJgeK5+dcIlnlvM
 MtKDrnT3zKBdl7P1x/rKcRGWBwmEpfehgFoMtwTjMTNiYViUjj7i9CIr1FlyTGHVb9Eh
 +y1yPRkAfdtpi/fvml7HnFIZ/tUT6jAZRjxRUh5eWVIu19IKaphjilXC96RINGuKcbQd
 0iKg==
X-Gm-Message-State: AFuF++nLBMrBG1uwolUpkMQt6IdWd0JpVQbzRdcvYJGFizBKBhkJaeY7
 RkNeK3H7TgN1s8ud6FMxpDFhoRuK0azeDd4dkerMlj71n2RQpMbcVl21UjaS8A==
X-Gm-Gg: AYBFou30Idp8ypwV3O2WxRdGUrhChvNEbQFesb89Ts4DlTpdQ+nKeZxV35WpyfUhJer
 DQuuI11MN2Di7jvO21G6Oq3nyroFxaHyKkEb+RQeyQ3emS1A4TnjEf22pFoBR7ttpacARo6jYS+
 PLCZsETPHZNXvzgS+uprFo5ZSiNt39cIm+TIdsQRpGNmUJ0QQTy5UsqWrQnpt/gWq5MOozVHEMT
 AvdXaJ0QMO4JBn+0weNs9p3+3drEDrCFFqPhAsFwHdWNEoPphCMucPOmfQzVxo3DIGSos3jnQIA
 4rTEeopFH1N5Nru8382IPDwStbQu3CSHDeP68rV2EqOeNf8VSHe3sB5ITwyChUOxuKBaSHeyJyt
 MVpVgtuHlAUBVussiBPB9y2J5NwNUpRYbQ6VJDD6z1sVeICy7nat1eiMtmJmNk3EcShW8HjHRJb
 8cdQ/6XrS0CxCSLuVi8/yO7CLYAejW3CS++95z/hS97dHT7xtPwOtOsflSqm3PUQ==
X-Received: by 2002:a17:902:e80c:b0:2d8:d4d0:792c with SMTP id
 d9443c01a7336-2dd4bda1a6dmr29660735ad.16.1789198049041; 
 Sat, 12 Sep 2026 00:27:29 -0700 (PDT)
Received: from thefoxflat ([2404:c0:701d:4e35:a09e:399b:32ec:61ae])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2dd2cfd719dsm21469235ad.59.2026.09.12.00.27.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 00:27:28 -0700 (PDT)
From: Reza Kurniawan <imkyufie@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Reza Kurniawan <imkyufie@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Lukasz Majewski <lukma@denx.de>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>,
 u-boot-qcom@groups.io
Subject: [PATCH v2 0/4] Add preliminary support for MSM8917
Date: Sat, 12 Sep 2026 07:23:04 +0000
Message-ID: <20260912072619.244101-2-imkyufie@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 12 Sep 2026 13:27:13 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

This patch series adds preliminary support for booting MSM8917. It adds two
new drivers (GCC and pinctrl driver). A change is also done to the core
qcom clock code to account for the poll register offset difference between
this platform and the existing ones.

Changes in v2:
- Change license to GPL-2.0-only
- Mention the source of the ported code
- Add error check for out-of-range pin selector
- Use macros for RCGR address constants

v1: https://lore.kernel.org/u-boot/20260910095339.110427-1-imkyufie@gmail.com

Reza Kurniawan (4):
  mach-snapdragon: Carve out reserved memory at init for MSM8917
  pinctrl: qcom: Add pinctrl driver for MSM8917
  clk: qcom: Add an option to poll for GDSCR GDSC_POWER_ON bit
  clk: qcom: Add Global Clock Controller (GCC) driver for MSM8917

 arch/arm/mach-snapdragon/mem_map.c     |   3 +-
 configs/qcom_defconfig                 |   1 +
 drivers/clk/qcom/Kconfig               |   8 +
 drivers/clk/qcom/Makefile              |   1 +
 drivers/clk/qcom/clock-msm8917.c       | 210 ++++++++
 drivers/clk/qcom/clock-qcom.c          |  24 +-
 drivers/clk/qcom/clock-qcom.h          |   1 +
 drivers/pinctrl/qcom/Kconfig           |   8 +
 drivers/pinctrl/qcom/Makefile          |   1 +
 drivers/pinctrl/qcom/pinctrl-msm8917.c | 645 +++++++++++++++++++++++++
 10 files changed, 890 insertions(+), 12 deletions(-)
 create mode 100644 drivers/clk/qcom/clock-msm8917.c
 create mode 100644 drivers/pinctrl/qcom/pinctrl-msm8917.c

-- 
2.55.0

base-commit: d4152edb50356338af994d1c0483f65b717b4c15
branch: msm8917-2

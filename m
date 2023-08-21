Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CA49EE49AA
	for <u-boot@archiver.kernel.org>; Mon, 21 Aug 2023 11:20:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2404B86F7A;
	Mon, 21 Aug 2023 13:20:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="B1AtQT1F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2559C87051; Mon, 21 Aug 2023 13:20:20 +0200 (CEST)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9879786BF8
 for <u-boot@lists.denx.de>; Mon, 21 Aug 2023 13:20:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-522bd411679so3925842a12.0
 for <u-boot@lists.denx.de>; Mon, 21 Aug 2023 04:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692616817; x=1693221617;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=XXMFY8mVz2NBYXKVxfyRv9SQEjwF7c6TEoBwZalD50U=;
 b=B1AtQT1FHwv9Goi9w3Xj+2LgSeDVfZLpStoQoWtH5GJQEGOUAZhsDVsdfH6W4Cr9z3
 9TdFpJicYVxicWq/eBghCyFlXu5piJAJDZx+Lb4ZLb337bqyNPO4rm7RYbSzOb8E4Jkn
 YdkJqEh2t/W0bnYVqFCZz5BvJ8NNgXR9rCsXiHIe1+BMMYXn2f77mEA/2n17WfI+CwBu
 Y23pRb2XOZByL5tdnvmTj6OIKC+BsCnD6ne80qNf0FekGVJBknvosBosp1erfQJ5QP1W
 M5i3s/jYrhEXuFBCzDNI1zBafXmTRoyQ0h1b8sfMlRGCkNDG8sLYEr2PEkPJsqMtDmRl
 LPog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692616817; x=1693221617;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XXMFY8mVz2NBYXKVxfyRv9SQEjwF7c6TEoBwZalD50U=;
 b=dyhRO3y+Gsf28bczlexUTF9Cm/ZFGvOg6S1l1d+07AQQZNzzebCmzc/ph0hKgtKwhL
 Dce6WqUNUjOKt/5K0VbF4o2oz4kPune2Orz1Ai0lIRJIYHdU6kABGYPUMsWPsZLvrwry
 0yvNzsMb9MYtvHpgA+f8kHEAuWvBerWCVbw3ro6sr+ILqEyfBjmmxQ0IhgZQRZ9qTpv5
 LLpnLMqChtkJbyud/RIcsfaleoWqRppqeyO0y1Nb6G2rcKiatq+7FyAA8tVhnhuKzBal
 cRZD6uJ2s7v22v0moPdKJH6WyCE9fFk2G3YWAdyS74rRIDcmqt6TFSCc5LPsdGk5niV3
 02PQ==
X-Gm-Message-State: AOJu0Ywtr5GHMwYCxh2SCID88NS+ghJz/SXT1uCvymy6div6bElithhw
 xvMkwGUKFg+66baDmIWWVgI=
X-Google-Smtp-Source: AGHT+IGQy65rZQTcUakoGIRqqoMJgKC0mShvGaR8K1zTw4HujUa4j+cc7loAgEozOYBXBfx6o1dcEw==
X-Received: by 2002:a17:906:1d9:b0:991:b554:e64b with SMTP id
 25-20020a17090601d900b00991b554e64bmr5352807ejj.54.1692616816828; 
 Mon, 21 Aug 2023 04:20:16 -0700 (PDT)
Received: from xeon.. ([188.163.112.52]) by smtp.gmail.com with ESMTPSA id
 rv6-20020a17090710c600b0099cc3c7ace2sm6461698ejb.140.2023.08.21.04.20.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Aug 2023 04:20:16 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Marek Vasut <marex@denx.de>, Simon Glass <sjg@chromium.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v2 0/1] tegra-usb: support dts based xcvr setup
Date: Mon, 21 Aug 2023 14:19:52 +0300
Message-Id: <20230821111953.5919-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.39.2
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

This patch makes tegra usb drivers a bit more flexible by passing
xcvr setup values from device tree.

By default on tegra xcvr setup of usb phy is performed with values
taken form controller fuses. So by default nvidia,xcvr-setup-use-fuses
dts flag is set and hw is set accordingly.

In most cases default setup of USB works perfectly fine, but for some
devices (like ASUS TF201) standard xcvr fuse values do not fit which
causes some usb lines (in TF201 case dock USB port) to break. To fix
this xcvr-setup value can be passed from device tree.

---
Change from v1
- removed xcvr-setup if nvidia,xcvr-setup-use-fuses is enabled
---

Svyatoslav Ryhel (1):
  usb: host: tegra: implement dts based xcvr setup

 drivers/usb/host/ehci-tegra.c | 48 +++++++++++++++++++++++++++++++----
 1 file changed, 43 insertions(+), 5 deletions(-)

-- 
2.39.2


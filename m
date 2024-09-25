Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42138CCF9E7
	for <u-boot@archiver.kernel.org>; Wed, 25 Sep 2024 17:25:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A205A88BBF;
	Wed, 25 Sep 2024 19:25:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="AVXw3LiX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CCDF788BBF; Wed, 25 Sep 2024 19:25:53 +0200 (CEST)
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com
 [IPv6:2607:f8b0:4864:20::731])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6C81188216
 for <u-boot@lists.denx.de>; Wed, 25 Sep 2024 19:25:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x731.google.com with SMTP id
 af79cd13be357-7a9ae8fc076so7947885a.2
 for <u-boot@lists.denx.de>; Wed, 25 Sep 2024 10:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1727285142; x=1727889942; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/DDRzAOQmfam3St40wivnrS/da9+ocK7ZtUHUnBS8Wk=;
 b=AVXw3LiXVrFGFTzMozUNT5VtYBXThG40OJFOUku03KeV1DpIe7Gq/oNyLaawvYKCQg
 G2cjuvK4HzBCPZZZK1vsybE0p++PqPSXCyTBbKGKOfLRTYstNnTA1ZS5+Tof/oXYNN+o
 bRGOD6uJRjStLSoeq3oE/ahytL08jjR2exgpQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727285142; x=1727889942;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/DDRzAOQmfam3St40wivnrS/da9+ocK7ZtUHUnBS8Wk=;
 b=Pse8TitTcNo24cpFUsdVFTnPmfYxpnOPjErUcs4+Ei2d6AvclN2BgvY2l6E0vYSPyj
 FgJNL20GK3T953yUzJaBDXazol4WzPoj9VYjUSFCtZn0GppDBDQeQOEJYUko4A2CeNuW
 3ycpxyrJbCi+xJkiYRnpnrBeJtz7hxnkW7ZDVDEwTZPqsMeq7ReGPsT19hmXqX7dunXj
 5CchEXwLoSLTdM01zv7s2zhBJf8ckO2kd9JXYUu9SUG9lOmVhcBDBnt2XM05S3MFJ57i
 laCAdP58rvqOAeXfjec/DgwKKT0D3cgV8V7Sd4Mz+i4hRhlK3T5W936HuMVST0MNNwlT
 CcKg==
X-Gm-Message-State: AOJu0YyfzSOWXLMmtR27JrEN80OdO6zchQh2Nno+11ADuw6HWcpUKBLd
 hBngkFozYsW61E8w2OjRet3wOIjGfg2OU4DqKRSsQo2MLay/5VdpusM/i4aO5gXLws1rshCJM4j
 6F4k=
X-Google-Smtp-Source: AGHT+IFSxMDl9zlWY0kY9Y5DVDMSPjs5mGzT5GeslBABHAlqXbVWhrANIUabuVUHUT4LMCJVaDUH8g==
X-Received: by 2002:a05:620a:4543:b0:79f:197d:fe6e with SMTP id
 af79cd13be357-7ace744d1demr545772085a.45.1727285142230; 
 Wed, 25 Sep 2024 10:25:42 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.65.244]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7acde5cc8a7sm190320985a.75.2024.09.25.10.25.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Sep 2024 10:25:41 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Jaehoon Chung <jh80.chung@samsung.com>, Jonas Karlman <jonas@kwiboo.se>
Cc: u-boot@lists.denx.de
In-Reply-To: <20240724224713.2963301-1-jonas@kwiboo.se>
References: <20240724224713.2963301-1-jonas@kwiboo.se>
Subject: Re: [PATCH 1/2] power: regulator: Do not call set_suspend_value
 with -ENODATA
Message-Id: <172728514096.256765.14707845672734611541.b4-ty@konsulko.com>
Date: Wed, 25 Sep 2024 11:25:40 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
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

On Wed, 24 Jul 2024 22:47:10 +0000, Jonas Karlman wrote:

> On some boards a PMIC regulator is flagged with regulator-on-in-suspend
> and does not define any suspend or max microvolt, e.g. on Radxa ROCK 3A:
> 
>   vcc_ddr: DCDC_REG3 {
> 	regulator-name = "vcc_ddr";
> 	regulator-always-on;
> 	regulator-boot-on;
> 	regulator-initial-mode = <0x2>;
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom



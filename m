Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49B59C07548
	for <u-boot@archiver.kernel.org>; Wed, 15 Nov 2023 13:18:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 344A886366;
	Wed, 15 Nov 2023 14:17:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HO0v9Mxp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F377387285; Wed, 15 Nov 2023 14:17:06 +0100 (CET)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 11CC48721C
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 14:17:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-9ae2cc4d17eso1007872666b.1
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 05:17:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700054222; x=1700659022; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=gq8oj1rN6IbIyz8TZf9vepMHmrL+tpC4uA0Zbuq3UOc=;
 b=HO0v9MxpowlhbbHxg4S1NWU23uNWIWkNlSjzaqR+40+y24lMiYfUGdW1PabyQyfVnK
 WslcfEAL/bJFlkvGiU7655nGcdNOTyeVLW6eMWT7uzYNFSJzkY8DzE6a/VFoWrzevm5u
 jCR5mTBvaaFwdpniYijyhr0WLE9oDjf+yjqQk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700054222; x=1700659022;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gq8oj1rN6IbIyz8TZf9vepMHmrL+tpC4uA0Zbuq3UOc=;
 b=T/8qS1Jozkb3QnnolFCx3nJG0u7iRS8gSU3P8f+Ns5eV1VhhHB9/hjqwHeI99MPcmp
 XMaDRODMPAMxK3zS1QhxFG9RlyymdYwKHox+nnZdrzC+SxyeYznUdsv7QmSxG1RoZSfn
 8oc6M3zah3Q3nv5AkWmbPWKdq77jH6NAjnA98sqwkmsxEIVeyyKHwoz+NMsS21N2UOHc
 giFDlkSOm0c9IlZem1+5uIuiiQiB/zXif3P8a9rzXvC4EXP3U3dUS0Dh39wv08vusU+y
 fJ0eG8+EekdOG0t6GqlOvlLxeS/apxQcU7tydJ8YjsZxFuO2EKf650jZ9k/x6GsXCFv8
 eCyA==
X-Gm-Message-State: AOJu0YxrhgKwSIZK/vxB1XXybBUYqELtmanpUk6Wcty1tAFJhCDJ/vuv
 y40CAAAhFGGRO9SGSAH/3CoOrKonu8vB9t4qeghhgP6N5Zz8dE6P9QA=
X-Google-Smtp-Source: AGHT+IHDUvMSiGPariyyho14PC4Y1OqKZSqh6D67OxEJIgul+ukvbo2HhyVlRoqK/CgHnEdLR74WxFDJUqTwqn/b3L4=
X-Received: by 2002:a17:906:d292:b0:9dd:f5ba:856d with SMTP id
 ay18-20020a170906d29200b009ddf5ba856dmr10796248ejb.62.1700054222345; Wed, 15
 Nov 2023 05:17:02 -0800 (PST)
Received: from 480794996271 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 15 Nov 2023 05:17:00 -0800
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20231104162527.1736401-2-sjg@chromium.org>
References: <20231104162527.1736401-2-sjg@chromium.org>
 <20231104162527.1736401-1-sjg@chromium.org>
Date: Wed, 15 Nov 2023 05:17:00 -0800
X-Google-Sender-Auth: _v1it1OAwMQ5RMc-KhYFtEWoBbg
Message-ID: <CAPnjgZ0vDrrQS+Qzq-ueXtxtAsAgStJ27OKkMDu_G0OpwR2+Yg@mail.gmail.com>
Subject: Re: [PATCH 2/5] patman: Move the main program into a function
To: Simon Glass <sjg@chromium.org>
Cc: Nishanth Menon <nm@ti.com>, U-Boot Mailing List <u-boot@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
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

Add a new run_patman() function to hold the main logic.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/patman/__main__.py | 127 +++++++++++++++++++++------------------
 1 file changed, 67 insertions(+), 60 deletions(-)

Applied to u-boot-dm, thanks!

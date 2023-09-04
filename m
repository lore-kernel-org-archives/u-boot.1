Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7806BC88CB2
	for <u-boot@archiver.kernel.org>; Mon,  4 Sep 2023 15:05:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B320386954;
	Mon,  4 Sep 2023 17:05:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QHfGUPSm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ED9BF8698D; Mon,  4 Sep 2023 17:05:22 +0200 (CEST)
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com
 [IPv6:2607:f8b0:4864:20::112b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 44EBE863DC
 for <u-boot@lists.denx.de>; Mon,  4 Sep 2023 17:05:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=massimo.pegorer@gmail.com
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-592976e5b6dso14837517b3.2
 for <u-boot@lists.denx.de>; Mon, 04 Sep 2023 08:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693839919; x=1694444719; darn=lists.denx.de;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=Tm1UU4KtT+0LCOvVv+xHmTrW4q9V5qJvwHFlUacWR4c=;
 b=QHfGUPSmcmzNbdZxdnomp+QRxVsfX6gBaS8Zv+phLVLvwg5af04Osm6CatoAA8vpAm
 uYU8VQT2P8JO2quIwd50QTAtCcoXrAqwVXLcRa9wZ+zwOA0ez+2X3XqBV1BUETFXK974
 QvZ5uw3jVJfkLUDVAm7ASTymDyadd1B11p5knA1Q+AGSutFKC7kJU984CXkOysTE+6Xt
 OEaYdEi/JC8/CxSXb/Zm2UzAyuU2ykyYOGzChnlS1MsO4y2hLT9Dl/HjS0YvdbDi6IlQ
 kHCVUtkE8B2w4VbwzJCuj5M0/9rowJDy35t1b009RKTUIAjTm/2cr4N/dExGGYbFajkG
 F0kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693839919; x=1694444719;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Tm1UU4KtT+0LCOvVv+xHmTrW4q9V5qJvwHFlUacWR4c=;
 b=PW7HdPhorOQUhatscyPdocv6FqpRXPtNJbtYKRW2kSp01BYDo23qtp9ob5XpDAM/A2
 4dkfD3xrryScUjqU8oDSy8PblL7xrEv5W7xH831Q2pAd4IqHRtwMFEC1zKkcpo3/usS5
 tpE6POk+w8O5JW7rBNnfYJWEVhYgxwZCvUkRS9xweA29ntolcm60YE3YOZUDdQgqpaGL
 wHb/0Sm5TBLX2qXQts//kuj8PUjs+IphzgIsO4slrxmJAfRm6mwvMfNdrPk709rxbqrb
 qMevxmrtANoMpYvgGHnUB0ohWhj9Y80O9fZj+Es2DhxV3K/gF4gcM/PZCF9oPye0F1PC
 oycw==
X-Gm-Message-State: AOJu0YwVfojTEUQ7O4biNPcSJRF84lyt0pGsR1T43JUUl7HBNuQ5pjV5
 LuYmIvunilOUNWvRPStsWu1sufywlSy9TTJeU1x1ONx+CYQ=
X-Google-Smtp-Source: AGHT+IFyqIpTtLtIk6OVZ1HqM+eDwD42SLEF6O5eJPrdTqEWmdX8WQifD6Ln+TysDfVZfSu4lIwleDE2FqXmMbcRDBc=
X-Received: by 2002:a81:6cd0:0:b0:595:7fc9:4ca3 with SMTP id
 h199-20020a816cd0000000b005957fc94ca3mr10174585ywc.0.1693839919028; Mon, 04
 Sep 2023 08:05:19 -0700 (PDT)
MIME-Version: 1.0
From: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Date: Mon, 4 Sep 2023 17:05:08 +0200
Message-ID: <CAC928HYMtd=RZnZYW9CNc5wPjzGk11X0+RpcuwHMFEuUpv0C4w@mail.gmail.com>
Subject: Binman how to build using Rockchip BL32 binary as OP-TEE
To: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>, 
 Kever Yang <kever.yang@rock-chips.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>
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

Hi,

Is there any way for binman to package FIT with U-Boot TF-A and
OP-TEE, using bl32 binary provided by Rockchip as TEE?

I've tried with TEE=/path/to/rkbin/bin/rk33/xxx_bl32_vX.YZ.bin, but
binman failed.

In my poor understanding of Python code, it seems binman accepts only
ELF format or a binary format starting with optee_v1_header, but
binaries provided by Rockchip in rkbin repository do not have this
header.

Thanks in advance for any hints!

Massimo

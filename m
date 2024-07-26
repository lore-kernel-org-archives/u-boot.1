Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F91AC3DA70
	for <u-boot@archiver.kernel.org>; Fri, 26 Jul 2024 13:02:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3988688714;
	Fri, 26 Jul 2024 14:59:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="V/fisrCZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 18CB488717; Fri, 26 Jul 2024 14:59:21 +0200 (CEST)
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com
 [IPv6:2607:f8b0:4864:20::f33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1528B88570
 for <u-boot@lists.denx.de>; Fri, 26 Jul 2024 14:59:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf33.google.com with SMTP id
 6a1803df08f44-6b5f46191b5so3164746d6.3
 for <u-boot@lists.denx.de>; Fri, 26 Jul 2024 05:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721998758; x=1722603558; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=PnV1tGQgZ5oQxg710wDHRYSDjVWiQbcFMLSUwtsdHKI=;
 b=V/fisrCZdWM1EBpKabenKzSlM/wNRZZwk4zL37c99Vsf5RPj8ChB856J77QMNYp3K4
 Z2NHJ0A5UUI7v7ICivpyfM2GAYehkDoup5m5zIyuGqh+daTMn+tuqbpSRndG6SKeAC1D
 zTw+iqweHz5hMt2dq8cazENcD0MbmXNAe4GqE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721998758; x=1722603558;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PnV1tGQgZ5oQxg710wDHRYSDjVWiQbcFMLSUwtsdHKI=;
 b=gR+oU4stY7+N3wTzMft+s+/+UxUfacTTULJ4lUNj7oXh05UZFwOTgy5KJ3cWY4SOsX
 JBXKA24kiZOOtKRtQaqi1BhFwrWepYCayMdL3SDlcStTQLO1VvJCDknrRZSBILnPIujY
 1VgE91tsFrdiM/ZNqX3PyWIWbJkKBSPihRYvOTJVRe6zj7RnkY3gRJo6vW0/TPPfFheE
 jN8MvxbnJn3EppzQEBegO6sSdwbOnroEDDz5qqh94VeCmQsoxBFAj9QpwGjgmmqb/COY
 l/fWek309ytiAFpjsM8SgNVSuq7qV1x1IdZAhT1wqbiQ9TH8qfWXeZ+e5e3BoULj3gof
 eNCg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX3wGv/Ip466uoYLIfjPelWkxd+Df9qQwM8MoM5brEpGCl1TvqWRp46NrKQmnbKKr7EL+4/HcpZ1NYXZqyom4Y/RH6aDg==
X-Gm-Message-State: AOJu0Yw7QZXHKjXcENgI/hQkOd3iiJHUeGk8Bsxu36ANrkPYjJhupUNm
 G2cnGrDx0ekuTxviX+0ALWZlaTdvRcaJGSZ48Z41vFb63DKWcn74vs0R7VrP3T5FUs5JvkucJrJ
 ZmVa1fFdZTcnmJCcDPXYFOCTlxi5o8VfztoWP
X-Google-Smtp-Source: AGHT+IEai7Nr7jqPNlNi6E5iH6UBQM2AM5uRZoiB108UOKiFXCKpHRIMIAF8D6KfPsdNtGI3nweSSFgQjmNooHPKj5w=
X-Received: by 2002:a05:6214:411:b0:6b7:b441:8fdf with SMTP id
 6a1803df08f44-6bb3cb3146bmr68922436d6.56.1721998757985; Fri, 26 Jul 2024
 05:59:17 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 26 Jul 2024 05:59:16 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20240717155712.2913651-4-sjg@chromium.org>
References: <20240717155712.2913651-4-sjg@chromium.org>
 <20240717155712.2913651-1-sjg@chromium.org>
Date: Fri, 26 Jul 2024 05:59:16 -0700
X-Google-Sender-Auth: j2mHjxijIXQd_IfdGyOU9qmr-40
Message-ID: <CAFLszThYbi=S2=An0ArAxhOOK8-wFiS9qyu1HMKcYPXTbqnd0g@mail.gmail.com>
Subject: Re: [PATCH 03/24] qconfig: Make KconfigScanner a function
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
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

This doesn't have any methods so is not good as a class. Make it a
function instead, to keep pylint happy.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/qconfig.py | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

Applied to u-boot-dm, thanks!

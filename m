Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B05A7E7C4E7
	for <u-boot@archiver.kernel.org>; Wed,  4 Oct 2023 18:00:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 573F587625;
	Wed,  4 Oct 2023 19:58:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cr7Y5x5s";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ADD1B875E8; Wed,  4 Oct 2023 19:58:32 +0200 (CEST)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C657D875ED
 for <u-boot@lists.denx.de>; Wed,  4 Oct 2023 19:58:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5384975e34cso93387a12.0
 for <u-boot@lists.denx.de>; Wed, 04 Oct 2023 10:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696442309; x=1697047109; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=SEYsAFK9rOK2NEzcks2sFAt+8A1YLSVE+Z7cmx08MVA=;
 b=cr7Y5x5scFNYu0UOZOQJ4FKkVLvlndKRPOU9Ln4GqmtZL3cIA6fTJPq4wFBgKSDKjN
 /B98LKyiedmkfJ5bmg/pWZ+aqr0N20qnqifa3C4EnERGWKTh1oTNi+LkrU+niGx+neDY
 YMkuPySbnUlXoCXv0oSf2jvCdmzqgZVH7iG2U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696442309; x=1697047109;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SEYsAFK9rOK2NEzcks2sFAt+8A1YLSVE+Z7cmx08MVA=;
 b=BJRlk0aph+ZO8qJKd2nN/w1VqZBWknom3lzD7ZrasAQxvJ1cdKk+N+kgSjMwRCWECQ
 R+iV2By6922ZBhhBbJr0jAnx0Udqiu9lIxAP4SfawEwLHrGPVcjRi8KuRlEXK7NeL3N4
 Tuf/u/YyDVr1Hw+A4tr4XvfUMKEm6zGLNDRWNP5cFcu8AgcepdPQlEaAV7XYldXtxLDJ
 ZNOJgV2acEqvCLdp3GHYbFMdyHutVRPKJsDU8y0oOHhgYDi9lIYHR+GmV2Unkkm2XgTJ
 frwrV09XSzyovcv5JhMiyLnmv0xq8LHzXe136Cml0cxPnFGNkV5XnZApHT9Mt+w2aeW0
 SV2w==
X-Gm-Message-State: AOJu0YxOiOhXSLFadEihlvjs6ajs6yDBDqJL93a0sKV5GxtHSrLmFtTO
 kzoS9XhfQ0hFpgQePtr2hAa6SBcdbXTwm90qfsi29Vz4gFrB5EIE9co=
X-Google-Smtp-Source: AGHT+IEOGKZABGn+XZQf0vCeCRMqhj+ctj+ky03li72ZB7yp+kYVi366XI4Bt1FVXCd8NIFBViMdRrEzubUKlJJmpZ4=
X-Received: by 2002:a17:907:760f:b0:9ad:78b7:29ea with SMTP id
 jx15-20020a170907760f00b009ad78b729eamr2874167ejc.44.1696442309306; Wed, 04
 Oct 2023 10:58:29 -0700 (PDT)
Received: from 480794996271 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 4 Oct 2023 10:58:28 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20230923194424.1739224-20-sjg@chromium.org>
References: <20230923194424.1739224-20-sjg@chromium.org>
 <20230923194424.1739224-1-sjg@chromium.org>
Date: Wed, 4 Oct 2023 10:58:28 -0700
X-Google-Sender-Auth: 5guIujnuhMTBUrSiotUgbi5-mzs
Message-ID: <CAPnjgZ06X95fLOa6xqc1STTVB18QH2hzZn-wbiruCjp9h4z1NA@mail.gmail.com>
Subject: Re: [PATCH v3 19/27] moveconfig: Avoid showing progress at the end
To: Simon Glass <sjg@chromium.org>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Tom Rini <trini@konsulko.com>, 
 U-Boot Mailing List <u-boot@lists.denx.de>
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

When the process is finished, moveconfig leaves a line saying that all
boards were processed (for better or worse). Drop this, since it is
unncessary.

Future work will provide a summary at the end instead.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 tools/moveconfig.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

Applied to u-boot-dm, thanks!

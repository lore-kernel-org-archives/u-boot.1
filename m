Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF708C4451C
	for <u-boot@archiver.kernel.org>; Fri, 17 Jul 2026 13:44:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 50BA584E09;
	Fri, 17 Jul 2026 15:44:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="GssikVpN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B653A84E09; Fri, 17 Jul 2026 15:44:06 +0200 (CEST)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 66F0D84DAA
 for <u-boot@lists.denx.de>; Fri, 17 Jul 2026 15:44:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-698bf053053so7452642a12.3
 for <u-boot@lists.denx.de>; Fri, 17 Jul 2026 06:44:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784295844; cv=none;
 d=google.com; s=arc-20260327;
 b=X7eEKdC/5tsj9QXBVlh55qdOz2hUX7zk8QNIxJdCdHQWKGCvwW7LdPGwERThj0BxTL
 cxFkihzNIk9mJyC8vQbcenPuLvSRg3jSsfG7/8J/X4P/ef0h2wqOAMKpxeWCgDzzy+QB
 e4yNadSfIwGCFAtpM2ehje1ZGx4YDCO22rdROW2yPYx60vWj09rCrQ56GKIH5QvE33q3
 2HbzPqcUaQC4+7Yx6+Xagg+NFoRYJGbIvnVeuWQDUrgsIRC7a5qQ7UHiK3uA7hujDtWw
 B4LrXCf9agXFpdcYm6gCGeyD3OcFMOxuesqsA80yTTqpOIXpSdzvg8ZHczFns4oU+i6z
 tr8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=7e5vAsDnLKWRQ/hGe0Y4a2HrCfQXFBlAeRsg9jSVEVI=;
 fh=ZmyGKcvtXaxLYX0kvQkd9TsXXdPw2UWfjcPEgE71ltg=;
 b=RpdG6tECNlQEcZp8+NhxUYtdov++seY/U2xVmxrMfQjL2IfVwrsEz9ym3uDbnLy9ZK
 VxPBI0C5AI/9t91HLOGhIKEQS2LiWyiJrDu8fgrNG8bJLrWcExUfh2aOgKYvdxgs4Kw+
 ZuaS/HHq6PIMxeo3w8LsnI34nyCTuEi4XK8137HF6oN+FHcSm7fZMrNTw9uhgrH9M9MQ
 Rhwp+2P6r6j6t6wJWnJi0wIVEkBkUEiYz/jxYEjs4fIZBkWlmqB2SbmLEodDiYIlXMku
 6mIa0i9AdESpJE36UTC/9NxGGqf6OGAuUuRPbjiYIppmuB4rqDc9b/U05dPvfF5TULVE
 uF4A==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1784295844; x=1784900644; darn=lists.denx.de;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=7e5vAsDnLKWRQ/hGe0Y4a2HrCfQXFBlAeRsg9jSVEVI=;
 b=GssikVpNcSLnCXNVO4Vg3EVfjynVsqty3HFDpDaUG7yosJ+cC7dDLybZpPpAlo/PqE
 3lx+JEWc5ObznhBkZC0fbfUcjJ6H2kjpN+syVRLDWCarRg/+Zn4iWM2D6/EN4lm/UIw3
 ek/uZ5UszLEmnEx9tpULcViDPYBYIuZJvDS+s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784295844; x=1784900644;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=7e5vAsDnLKWRQ/hGe0Y4a2HrCfQXFBlAeRsg9jSVEVI=;
 b=Ozfxbsi7TcrhQ2wGO2IvE3goimTh4a+rpC+rsvleNGEo9izak9WlNpwrOq6yjZ3ARh
 48SgYbj9NQy74LO5/sCZaYILxvEeAUJ+UI6YHeNnIcDVPOJ1+Ap7ez5Hem1T5nML2nae
 xnqsIfm9XeGSxD0daaCR8tN6q1WRgKpzSOYtiG0q0kNlPeb8dZXtj76JW2pU04+arZgq
 /mnO0HfVZzU5wGiDnAh38YTpjV6DHdd7XOXueHOZTvXefyKKaM+oITQV0bTcin9cwBxC
 51qg+odyDHvC99y2xpLUcfAgcV/XcB6HU0YHGsEuAvDdq7cIsEwNEzzOV8U9SxXBoZSu
 CV3w==
X-Forwarded-Encrypted: i=1;
 AHgh+RqaQLxC0zo+/ZvgN2nL8MJmy+L0i1c8d7t/x4+PCkXRIAt1zDXINMRsxNBUoSxOgPB2clWqzNk=@lists.denx.de
X-Gm-Message-State: AOJu0YxOqY08ue6w/Pu5rKx1+v4zUTQtuVeGUDeB5ZXM/aRVsvhmjO2K
 fwSkRUNavfvGWiSRMiQRDZILSNu6ovAlp24cvn0IOssttHLDAQT49hc53oMsN6T5gscpqq2Kxfu
 7LS/STwxf4WVFRlqokmzxKtrTPHpLNj9x5ioEhYWE
X-Gm-Gg: AfdE7cm4vUqy5Nzvr9itR4R62fnyyMvYrHhkbAMNx9k6J3Gw383OCLk4JvcjlG20HzS
 U9BvdjQjNXDMxA/1mYeCCMbaAEIn9HtSrXECCZtvFBwwHu0A0UwgHvBKdXJpPBFzBv1tOyXgCFT
 2b+EiS8PEIcXFommtT20ZXnbJtjaodwYTraaGba0vSu3LH3nvcWV5rJ6xZm09iYdCU5BoTDeumY
 /87gii3kKnHONGepIV2JdC6qMbT5ifekG7KEcbgXduyRceFjsprgw6Q8/uw
X-Received: by 2002:a05:6402:2b8a:b0:698:c0d8:e40a with SMTP id
 4fb4d7f45d1cf-69e6534165dmr1039938a12.38.1784295843708; Fri, 17 Jul 2026
 06:44:03 -0700 (PDT)
MIME-Version: 1.0
References: <20260711160808.2022242-1-jonas@kwiboo.se>
 <20260711160808.2022242-3-jonas@kwiboo.se>
In-Reply-To: <20260711160808.2022242-3-jonas@kwiboo.se>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 17 Jul 2026 07:43:48 -0600
X-Gm-Features: AUfX_mzzPUFd534BFOlR64nOCavElPKc6a0FgzQQ2tl4SZJW3ScJsoxBRkrRyZI
Message-ID: <CAFLszTjyAyfbHbAHv9OHMeh_V-z+A6k1GF=trmQGtbT0u0nThw@mail.gmail.com>
Subject: Re: [PATCH 2/8] usb: Import USB_INTERFACE_INFO() macro from Linux
To: jonas@kwiboo.se
Cc: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
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

On 2026-07-11T16:07:58, Jonas Karlman <jonas@kwiboo.se> wrote:
> usb: Import USB_INTERFACE_INFO() macro from Linux
>
> Import the USB_INTERFACE_INFO() macro from Linux to make it less verbose
> to describe a class of USB interfaces.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>
> include/usb.h | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>

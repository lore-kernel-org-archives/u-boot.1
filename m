Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B021C47074
	for <u-boot@archiver.kernel.org>; Wed, 15 Nov 2023 13:17:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A9C78721C;
	Wed, 15 Nov 2023 14:17:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="WqnBXLc0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 849838720A; Wed, 15 Nov 2023 14:17:02 +0100 (CET)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7EA308615A
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 14:17:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-9becde9ea7bso172400566b.0
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 05:17:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700054220; x=1700659020; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=VJFST0rtx5UqPqJHLIyQU2gK1+Vby7WAXpkQNQOZEs0=;
 b=WqnBXLc09aUMcXvyFuv5vSp4J/aIwEXDrJLMH909Hfpm8uiXf24SDe1JQXwxpQMnw5
 4cdaRH6/SR5WMN8x70NDdOD8znM4I4JTosj4y92JDp8WLLhethval1wcGHPE2wWMYPwm
 x8rkBzK0QfSdIev68pebUtO+QV6GWQuvgLumw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700054220; x=1700659020;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VJFST0rtx5UqPqJHLIyQU2gK1+Vby7WAXpkQNQOZEs0=;
 b=WZq3HJc7F5q0DC+QpP2qF2hkORsvXZkcFTEMlzgit60hoNuSAU1+NWeCSOlnLODZSe
 E3/Z3BCQEWDDm8dtKTcbahPo+xC1AkPocdVvCn2ySX0U3ql2qsO96BX1qjNO0sBM1V9G
 DtXn/M/4JcqUtq1NxsFPqUQxPMy9lAxsZr5FXKoiS8/HkAYsFpSA3Pz4zBHKf8VOutzz
 8PxYyaV6cBOa48JS2JpRne76InfPh1KaRTl+0Q8Q+jFoq1f8M+DIe+7nct2xbAXPOq7p
 Hm6SWnqe2DO3t+dMwc+fmiaCnNZwZsdeewF9sX/eY2FdYOO3g/9ACFwwP085cO83BOHm
 cFrw==
X-Gm-Message-State: AOJu0YwCASgwZOT0tMlzh+o168t+ovxpIWCR+TEh9dcctTZzELTTqzow
 2f+gkn/jqtfjcS3JPIhhaeJNmYWy5eFmb4exnkAxvg==
X-Google-Smtp-Source: AGHT+IHzp1be227hL+YhmN2BTlj6e8OMwQ/+Dlq9Eo7NDYh87XTvO0TrMzKEuTBSWzRGQfSIDvy1o7OOalsqTVM7F2o=
X-Received: by 2002:a17:906:3013:b0:9ae:50ec:bd81 with SMTP id
 19-20020a170906301300b009ae50ecbd81mr4938649ejz.21.1700054219952; Wed, 15 Nov
 2023 05:16:59 -0800 (PST)
Received: from 480794996271 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 15 Nov 2023 05:16:59 -0800
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20231104162527.1736401-4-sjg@chromium.org>
References: <20231104162527.1736401-4-sjg@chromium.org>
 <20231104162527.1736401-1-sjg@chromium.org>
Date: Wed, 15 Nov 2023 05:16:59 -0800
X-Google-Sender-Auth: lggoXu3RqoBHZTsyatCrAP1sTLI
Message-ID: <CAPnjgZ3=OOeOuJikO+jTFoJrkq4yvn_imi37nmP4xwKfdGBveA@mail.gmail.com>
Subject: Re: [PATCH 4/5] patman: Avoid using func_test at top level
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

Import this only when it is needed, since it is not present when
installed via 'pip install'.

Signed-off-by: Simon Glass <sjg@chromium.org>
Fixes: https://source.denx.de/u-boot/u-boot/-/issues/26
---

 tools/patman/__main__.py | 1 -
 1 file changed, 1 deletion(-)

Applied to u-boot-dm, thanks!

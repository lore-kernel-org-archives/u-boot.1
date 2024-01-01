Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22E63C47073
	for <u-boot@archiver.kernel.org>; Mon,  1 Jan 2024 16:49:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA7A4877A1;
	Mon,  1 Jan 2024 17:49:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="O4G3/wKT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D5CF87076; Mon,  1 Jan 2024 17:49:25 +0100 (CET)
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com
 [IPv6:2607:f8b0:4864:20::f2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B41E486FFD
 for <u-boot@lists.denx.de>; Mon,  1 Jan 2024 17:49:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2c.google.com with SMTP id
 6a1803df08f44-680b1956ca4so8338526d6.3
 for <u-boot@lists.denx.de>; Mon, 01 Jan 2024 08:49:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1704127761; x=1704732561; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=lW+AanX8PCO5LWLsOavsEE4z4d7xTq7FlkHIoqqHlSw=;
 b=O4G3/wKTTGQGBPWZtBgkQftoDv+2LcFR8p6HBo8DZiBqkbo+tFD2LK0MvycLRzQ0KQ
 FG4Ay1WuE7iLRYle7Kz020FbA9ijnTMNW0LCpzI1vTzs8THohcWjXn/8iqFNqVpiLhyX
 TtIhK9ID8DEKpYMAkx8HSEAiMozUuQwfr3Md8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704127761; x=1704732561;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lW+AanX8PCO5LWLsOavsEE4z4d7xTq7FlkHIoqqHlSw=;
 b=kZMzfy9KYqcS48x4yiSNLWrar3iobRxw6K/geTW2iZ23yNmajC+ljrT8kgWLHCE4Wy
 cr+D1XBWc5EvSd8g9Ho5/gKq8BGgrpZ3cz/gPenr5aNZCMABc8lq6quEFuNRp7E/sit6
 q0F6GkUvDR9XH8JjAu7/TNI2qUHk5tIpqGxTojsrYNztI2XPeTWmCfpcvEMszZ2Dk/pd
 B7OrUn7mIar2NiOGkeXFa6hjnuRJiPbjK48UENo27OTMdcuUggKHyL/kAlqACy+RKq6c
 XEUX63A7zOia2j0hFk85gXk2eYXoa84CCsixCiOTR1wSNP8ij1hxqDaHXm2Pn4F47Tiy
 830A==
X-Gm-Message-State: AOJu0YxzgBGd1TgVKQzzoITPT6mh0PdiaRsQTUHTQVBKff2cCDoCEEP0
 PO2zfGeYpMQtMOpxIzTt5DP0uPK5T72iPrbUa9FvZT+3A+o9
X-Google-Smtp-Source: AGHT+IGBgOf9meArayDUNxXJjDj6senr8uN2GsVPIOnlyqEvIyIDKPf69VxYn4294G1vJvdNMxmKZpJOoAVH4E6gECQ=
X-Received: by 2002:a05:6214:300b:b0:680:b3b9:66e3 with SMTP id
 ke11-20020a056214300b00b00680b3b966e3mr2261373qvb.78.1704127761473; Mon, 01
 Jan 2024 08:49:21 -0800 (PST)
Received: from 798914943136 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 1 Jan 2024 11:49:20 -0500
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20231219174528.GW2513409@bill-the-cat>
References: <20231219174528.GW2513409@bill-the-cat>
 <20231219142128.2388562-11-sjg@chromium.org>
Date: Mon, 1 Jan 2024 11:49:20 -0500
X-Google-Sender-Auth: Rf78bTNHf5LInql93vjWEx6wmzs
Message-ID: <CAFLszTieUe0QodqjA7Eby4WPorrhS2vODTbQkQ12sfJ73Qhq=Q@mail.gmail.com>
Subject: Re: [PATCH v2 10/10] Makefile: Use the fdtgrep -u flag
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Masahiro Yamada <masahiroy@kernel.org>,
 Masahisa Kojima <masahisa.kojima@linaro.org>, 
 Michal Simek <michal.simek@amd.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, Simon Glass <sjg@chromium.org>
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

On Tue, Dec 19, 2023 at 07:21:25AM -0700, Simon Glass wrote:

> Use this flag so that the bootph binding is obeyed correctly.
>
> Add a comment about what is going on.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Fixes: https://source.denx.de/u-boot/custodians/u-boot-dm/-/issues/12

Reviewed-by: Tom Rini <trini@konsulko.com>

-- 
Tom

Applied to u-boot-dm/next, thanks!

Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E742E7718A
	for <u-boot@archiver.kernel.org>; Fri, 20 Dec 2024 04:07:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4CE1280462;
	Fri, 20 Dec 2024 05:05:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cGdhY+Ek";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 75B9180087; Fri, 20 Dec 2024 05:05:44 +0100 (CET)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7EEF18037B
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 05:05:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a9a977d6cc7so212196866b.3
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 20:05:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734667542; x=1735272342; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3R3+8YabWFjl28ISkOUm+EAK0SatnO3yrW7ONv1vNvE=;
 b=cGdhY+EkQ6AyG8U511xlJxrZ0lC2JTnMSQ+fakTO+iPbz4D1o4oblXk4jG++y1HYlX
 9nSKiWTXNyFxBFQBn/eW9jxYJl4Vx8+yz5rH43yzG1cA6q+48GELg1XuRsqjVdzPbUfd
 mlN1Kt+IDCFnK2er0CRdqhTZXjWel410QAgDM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734667542; x=1735272342;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3R3+8YabWFjl28ISkOUm+EAK0SatnO3yrW7ONv1vNvE=;
 b=TTgUx2Vcin+aZ9adw8J67hgh9/podYUzQKKj7I2mLk/isDLPd75n55t6YaX1ItI3gH
 ONKylKDpWpqFK2h0Ux+onxDaBdnjZ+kDn3xCbYxkc6vNxtsD2QS3clVxcv8ErKfkvjut
 QNuuh82egQn2iIbfx9MAQGMkdOqTG5ZTk2XFOuK99yLnZntnNyKb2a7GAmxhGj3rQdVd
 IRQwqTManWczRl19nDwadhyJESJhtuefEFdLDCCiAWVJKeYS2BQtTivaLHaucd8nRtBq
 kCQjPGZIr+OvqdUYoz+vSNt6xNPFWdOASWqIbBgYqpRcFhsvwDCRzMKUn5+dXaGksucy
 j8SA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWjLcn/GsOp4RTve3YsVuvq5SLed31HrYibB0PwW1bFqrwsjQMj76Sn23MF0qebJmlPWWXHIx0=@lists.denx.de
X-Gm-Message-State: AOJu0YyTbvRLfN3/9VEqApe/djAydidu1wDW+XOrWALe0GDsdgHkDY7f
 pwXhdlEnx0jtitxFDZJE9VZI4V1YiacNXDCnehoqAZgoozEvzb6HAfzV0EQkX2730/Ut+XN6e5a
 wKmIzdDOhhB61/EMNUDuTnzHepLlHRSa2tdPk
X-Gm-Gg: ASbGncswRB7hkloFIVLktSK7yKl61Oq4W06najkTTmP6KARHqC01DiMEobccOUbpzVK
 rBEGER1LgOgqvCrp88ujMdQwMuvoK6d0kTugq4B4=
X-Google-Smtp-Source: AGHT+IGt3tgjCMZJ2jH7pz9MpELo1LXiltzSIhVEDnY1BS5dyViKYrWPTDLtu+7Yd7XWWFWNE7CH54KPL7Hox8WKjcY=
X-Received: by 2002:a05:6402:5291:b0:5d2:7396:b0ed with SMTP id
 4fb4d7f45d1cf-5d81ddb3ae6mr2333619a12.14.1734667541963; Thu, 19 Dec 2024
 20:05:41 -0800 (PST)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 20 Dec 2024 04:05:39 +0000
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20241206023626.2456858-30-sjg@chromium.org>
References: <20241206023626.2456858-30-sjg@chromium.org>
 <20241206023626.2456858-1-sjg@chromium.org>
Date: Fri, 20 Dec 2024 04:05:39 +0000
X-Google-Sender-Auth: wQyTTIHsYQnd95-a2_NSi6-gA2s
Message-ID: <CAFLszTjkrLeCbfbUuUDZpqAFB9su3JfPuphJApAfQYgcyVfx3g@mail.gmail.com>
Subject: Re: [PATCH v3 29/46] net: Provide a function to run network operations
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Adriano Cordova <adrianox@gmail.com>, 
 Christian Marangi <ansuelsmth@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ramon Fried <rfried.dev@gmail.com>, 
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

Add a new netboot_run() function which can be used for simple network
operations, such as loading a file. Put the implementation in an
internal function, used by the existing code.

Place this function into the net/ code, so that it does not need the
command line to be available.

Document which network operations are supported, i.e. a limited subset,
for now.

For the one board which uses lwip, it is not quite clear how to avoid
using the cmdline interface. This will need some discussion.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 cmd/net.c            | 40 +---------------------------------------
 include/net-common.h | 30 ++++++++++++++++++++++++++++++
 net/net.c            | 44 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 75 insertions(+), 39 deletions(-)

Applied to sjg/master, thanks!

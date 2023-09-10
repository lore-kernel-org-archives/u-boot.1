Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6145C71153
	for <u-boot@archiver.kernel.org>; Sun, 10 Sep 2023 19:14:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E91586D0F;
	Sun, 10 Sep 2023 21:14:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JWtbvasa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F123786D0D; Sun, 10 Sep 2023 21:14:44 +0200 (CEST)
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com
 [IPv6:2607:f8b0:4864:20::b30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4539186CF5
 for <u-boot@lists.denx.de>; Sun, 10 Sep 2023 21:14:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb30.google.com with SMTP id
 3f1490d57ef6-d8032efa2bfso2967132276.1
 for <u-boot@lists.denx.de>; Sun, 10 Sep 2023 12:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1694373281; x=1694978081; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=teJcVRg3KjruafBW/QX8QPM7K3qA6F1UibjqKnYdyp4=;
 b=JWtbvasaxkuwBgqajyYV39NP/nKcBIZgH40x2yKkOV3wi6RrYIpp2hvpjTCgfR4yIb
 jsIBWbW0VSTPl8bwtSlImvRv6Men70hJW0++e6a2t3MkJWYyNc46siwiv4spMa1jwmDh
 RgiV24Fk8IheOb+w0R1xHMSslj/mxcgYdsj7M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694373281; x=1694978081;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=teJcVRg3KjruafBW/QX8QPM7K3qA6F1UibjqKnYdyp4=;
 b=t6WbHLoArrwzLemNqICVl9UUvcMulFJHFHR/ehe69xsJWSFar2blwT/FeAPLcW0ry9
 GFL5a0zmdwzEg1ul1kpDw70kWPer1wPciVjUkfME71qFw3W57M//j+qBT0CxOVmSYZ//
 TYBkX1EqAG2cfiYbdagnBKCWmQbrua6euAlAerA1hIXXvq8WZdizZICFIWlps5pd6qNQ
 PgpSOEPMnKRFVFfjlH1s+5lDB57L/Ut746XUui4pwMzupm7zfTzwZ+Fi2jSqUKuXZza3
 VtLezfS9n0GnUCXjwcLET6bURbuucC7saVQKYwMQ35420kVWT+Tp4mZci0OMHdPg/r7Q
 ineA==
X-Gm-Message-State: AOJu0YyQLjX6uq0BAC44XDwyQwWXUGUySQZa9cusCsWpv6vPXehQet3x
 31owXJpg1fpLOT7IHsA4DoO0OebPZN8Dgqe0Dz8NYxVunK9j/cXSaRM=
X-Google-Smtp-Source: AGHT+IHB0eRaeiWvYbYsDFTsI2ZMAAEzZNsauYncqP/yjJ+i+n6mJARQC9upnLNm4PBAnKj77S/Ycrw/W1/Kj8dFkCk=
X-Received: by 2002:a25:2601:0:b0:d71:6f6f:73da with SMTP id
 m1-20020a252601000000b00d716f6f73damr12315661ybm.6.1694373280778; Sun, 10 Sep
 2023 12:14:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230907164317.378832-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20230907164317.378832-1-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 10 Sep 2023 13:13:23 -0600
Message-ID: <CAPnjgZ0ET2cajfgX_buRw8-kr4doXOVfbH6gTH61C8U5EY7StA@mail.gmail.com>
Subject: Re: [PATCH 1/1] test: build dependency for event unit tests
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: u-boot@lists.denx.de
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

On Thu, 7 Sept 2023 at 10:45, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> The test_event_base and test_event_probe unit tests use function
> event_register() which depends on CONFIG_EVENT_DYNAMIC=y.
>
> Fixes: 7d02645fe4c0 ("event: Add a simple test")
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  test/common/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>

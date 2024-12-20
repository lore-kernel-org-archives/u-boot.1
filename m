Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5542E77188
	for <u-boot@archiver.kernel.org>; Fri, 20 Dec 2024 04:09:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9626880586;
	Fri, 20 Dec 2024 05:06:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="iY8Zh/qr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 620AE80381; Fri, 20 Dec 2024 05:06:23 +0100 (CET)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 581028036F
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 05:06:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-aa66c1345caso134753766b.3
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 20:06:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734667581; x=1735272381; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Fyi9d+lo1HJ4M9KiX+s3eFPvC8AUQJawnt4yqlNW8MM=;
 b=iY8Zh/qrLrLIyuWIfR2NxBQc5HVNNwbyzxBYFy1Ck79bNJe5JvkQzCEwuOTkKWvw+R
 iS/+y5ctxMaycV2C/4LjRXxTaqBMllrICKEa10ZlM1uS1+YkRg1JmQbKA/hAmnr9SxkU
 t4abN2lTM1HGEdR04EEyJJ19PNtWmPJl0VaL0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734667581; x=1735272381;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Fyi9d+lo1HJ4M9KiX+s3eFPvC8AUQJawnt4yqlNW8MM=;
 b=eucizeAhHrSbDJs/m0hJZQ75vRmyv/pU1iXHTsOLEdSEtLKXXGE4hqFBBl0rYh1OfC
 +floz9rTYVwqfu1wfW+GN+08h+2atyWGpQTVKRDqk8G54GzO9Xh8XOXx/FWLY+gQYGyC
 gvmFZt+2g75v8I16baxkl2zA6MY/haf4nMGWEtLDe0exc5B73CdVYntVNPlQZe06Nqdk
 kb+FDoJu+E2lBYIh3FRFN6zSgGeqI9UeW4cyhUPYqSm9s5rrPjVjDr+HqxUJvs9opr2n
 47vCLcq6s9VbllfOXS/y7Ny/8tmJFn5apjogsRnvYynnO22iq6QK2NUIWSjJzp0kYZXp
 JccQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUSX78s2+ozxFEVf+VqEQOXUZA+AH35UkFYhi2gJFGP/t2yvO1EvgdJEU4i14RGJgDGMaq6H3k=@lists.denx.de
X-Gm-Message-State: AOJu0YwJMfOyunl/Bo77KwI2AFXnEy6ZhRAtgh3zgt90HvBYRrt8uSY8
 Y5VYr/yPqMfYaxXfEk9URqxIIeF2Q9bxKb1VIwL7Pbp7PpxHwTk8Gp5aXIQZ/CZrQ4rx46mAGaJ
 yYJ7GXR6UYCPJWGHSAR8CYID7YvkTGQ/DGW5c
X-Gm-Gg: ASbGncsXf5b1gAKJ51dzZs7NSRH9jxIIc8k1TULCh9vZoKZ9Dt8wA3+3pWZHT2WFDBI
 Twacm3H7KYbt/wh/4Ootkzk+nVIfFE1EBVMKK6KY=
X-Google-Smtp-Source: AGHT+IHsXv/wTW/Qe4aGt0fSltNVBdrv+mFP68Su9juYr50B8fcGIc6NbH9BgV68qsNoLenp8kWZLjFIGJYrSk4EEtc=
X-Received: by 2002:a17:906:7310:b0:aa6:7165:5044 with SMTP id
 a640c23a62f3a-aac3444c2eemr86217466b.44.1734667580785; Thu, 19 Dec 2024
 20:06:20 -0800 (PST)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 19 Dec 2024 22:06:19 -0600
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20241206023626.2456858-17-sjg@chromium.org>
References: <20241206023626.2456858-17-sjg@chromium.org>
 <20241206023626.2456858-1-sjg@chromium.org>
Date: Thu, 19 Dec 2024 22:06:19 -0600
X-Google-Sender-Auth: 09KQaEGdPfhG6R3CEO5eX97JEes
Message-ID: <CAFLszThxttyy1pFr_0DKUMRNEPhswg0=UusRXZgYdBd293jQhA@mail.gmail.com>
Subject: Re: [PATCH v3 16/46] boot: Support booti format in bootm
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Julien Masson <jmasson@baylibre.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>,
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

At present the booti format is handled separately, in its own command.
Provide a way to boot uncompressed booti images within the bootm code,
so that eventually we can boot these images without CONFIG_CMDLINE

Update bootm_init() to attach the images for all formats which use them.

Add some debugging while we are here.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v3:
- Add new patch to support booti format in bootm

 boot/bootm.c    | 42 +++++++++++++++++++++++++++++++++++++++++-
 include/image.h |  2 +-
 2 files changed, 42 insertions(+), 2 deletions(-)

Applied to sjg/master, thanks!

Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3838D10F2B
	for <u-boot@archiver.kernel.org>; Sun, 17 Nov 2024 19:49:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 82643893A1;
	Sun, 17 Nov 2024 20:49:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="L/qIVuMX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 463D1893A6; Sun, 17 Nov 2024 20:49:53 +0100 (CET)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5BF05891CF
 for <u-boot@lists.denx.de>; Sun, 17 Nov 2024 20:49:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-aa20944ce8cso639026166b.0
 for <u-boot@lists.denx.de>; Sun, 17 Nov 2024 11:49:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1731872991; x=1732477791; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=tpIxGiggI1gcBzEBdHHNazJOTU5PJ9BikqE4HMO6cSc=;
 b=L/qIVuMXCgDx9ZP8V1D2bd0S9smzPEu9jhmRggIaTtdSjkMXYn0CkvL82BYB/Z8sZu
 MzP62gKT2hOzW9c7aR38fV5WgTLg0ophApbzut6BYk4cGHnmseQU52TItoJPMntrfhaU
 emrFmwaTNO8jBa00IiOdgd97kVx7iUwyvH/Oo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731872991; x=1732477791;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tpIxGiggI1gcBzEBdHHNazJOTU5PJ9BikqE4HMO6cSc=;
 b=svhs0as7Ssg7JxsJnUjMLDOmcLIdp5Lr+5eKXANOxQCebWtUqDLZ8Rcw4HI+Ux9z8Y
 AiC2Ul/4m5vf7IJkIrsdTIv3Am5ddbykH+RcF310LQlX5rGhEqLL+QzmUY/rLY4V8PYv
 4kDRKkT+MssRGkA6XicG2NDSD4z2ziVw2YEjf+CWLqR/P0JeBg4Sa9yYCCFfg0sVKcwF
 5RGM8N6Uzg+yXEfPlJYhc+gFa52EgNwhpdHpNfO7B2vNZ6mH8R6R1v/iuphsySGXVfrc
 jFqNB/36tpJWngvKRKzgY+ZGAGhHbIOMu8zYTNkl9lYqpJrzfdhh1wWQUyVSWdb8QZ5B
 B6iQ==
X-Gm-Message-State: AOJu0YwRNo0FmhupXUKWbXKdpbr5mVT6pMTfsPysYSIQnBi8bx+8NWrd
 p+F87w9vpqdcUzfuSI+YNebnXC5BsRCL5E/dKLZXcaWvHiNXLkqiA5xIzjRG4naB4H3/oYnP85o
 2HsA6lpgVHi6k03TtJFuKv/VXzcJZ+82uo//7
X-Google-Smtp-Source: AGHT+IGtJdnTAwT/7EOyDoK4r2MDPZzs34uGvO5X1yE8BBNeOHPqyfh5XwKDL4iRBqDFbllr08B28gtSwwyWJeIAJZc=
X-Received: by 2002:a17:907:7e97:b0:a9a:6c41:50a8 with SMTP id
 a640c23a62f3a-aa2076eb6f0mr1342313866b.17.1731872990896; Sun, 17 Nov 2024
 11:49:50 -0800 (PST)
MIME-Version: 1.0
References: <20241117162606.3212279-1-trini@konsulko.com>
In-Reply-To: <20241117162606.3212279-1-trini@konsulko.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 17 Nov 2024 12:49:38 -0700
Message-ID: <CAFLszTgK+cguJ8CKjGXmaya=FmJTFVBHLP+fZeJqHcvAria7fA@mail.gmail.com>
Subject: Re: [PATCH] Azure: Do not run "udelay" test on sandbox
To: Tom Rini <trini@konsulko.com>
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

On Sun, 17 Nov 2024 at 09:26, Tom Rini <trini@konsulko.com> wrote:
>
> With the changes in commit 88db4fc5fec2 ("test: Update time tests to use
> unit-test asserts") we now frequently exceed the limit on the udelay
> test, leading to false failures in CI. Skip this test.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Cc: Simon Glass <sjg@chromium.org>
> ---
>  .azure-pipelines.yml | 5 +++++
>  1 file changed, 5 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>

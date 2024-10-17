Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59C66D3C533
	for <u-boot@archiver.kernel.org>; Thu, 17 Oct 2024 23:16:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F16589187;
	Fri, 18 Oct 2024 01:12:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CxMQqec1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E06389068; Fri, 18 Oct 2024 01:12:05 +0200 (CEST)
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com
 [IPv6:2607:f8b0:4864:20::72d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DBBB5890F4
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 01:12:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qk1-x72d.google.com with SMTP id
 af79cd13be357-7b15467f383so54614685a.3
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 16:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729206721; x=1729811521; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FDcmhaFfInQMThZFluRRTPDnMJZM+InHMqUOmP1FIvc=;
 b=CxMQqec1+DLkSkj2lkHzzkoUG7L3yrTsVPoig0S2TYH89Xz4YMgiPbwuPzRjNNvcu7
 eA2aSKPM1Xa2eSNvucHCx9/0WvQuwiulpAi+V9k9d98c9ug83By2+XvBPtY9VKZvm4o1
 vjBcv33ZZBtEY78+EKsDy6xy5GMyCqJMZ5SY8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729206721; x=1729811521;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FDcmhaFfInQMThZFluRRTPDnMJZM+InHMqUOmP1FIvc=;
 b=OimkToxDm0wf6wntQGMRdAS0hwLMp1dcRV4u1nWyyl7cUZpK2dKVP5z9GpkCSwXeQ1
 qgO7LWwwoe2O1iCZZYdi6Cc8SKWDBgRkzrsNxyELTnqOmGSZ+pTlFQCo+iPD56toFcjY
 2A5H+N6uk9I/o06c5XM+VUwgHF8XcxhBjjsf5YVIPr3HkQC0E0j1DDwMfAv6u6YN0KRF
 0R5LRZMf2I9p/XHbEQw9ATUL44mSCqYVVGfzLUrh19EgBIERZzuJ9fmlG831aCfjPz9K
 aScFNzy1yO9r1eyIqfRVY2dRaw97+9iCPkqhWIEARAVmpV0rXi0qbOJrt/jKchYUsucc
 806Q==
X-Gm-Message-State: AOJu0Yw7i+uywsFqbLHjTXxObaOsl8acT7G0HgFtTpEskljbkZvuRBvC
 tcBcGKGTJvW49ag3DN9bAjLqY+/w+1ZLN9tF2CWTqrtXjujABipS3Vv3fExPaLkJ/SqRjsFkhPy
 WgHowBRaifI1XAEiyFE2UGtNfYck2Nh62vIWO
X-Google-Smtp-Source: AGHT+IEHgcnBWZdbh1oCqBDIZ5vdhxfawHOw7KiBi737+LHyrx2M4Nnv7Hn8FEa5S4mpX8U/QaMkQonDcK/TUlkhSnw=
X-Received: by 2002:a05:6214:3991:b0:6cb:9636:8f78 with SMTP id
 6a1803df08f44-6cde14b847dmr5612346d6.8.1729206721500; Thu, 17 Oct 2024
 16:12:01 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 17 Oct 2024 16:12:01 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <CAFLszTjxq7MfUKjW4VETkt-SpZs+seK8F71EwG5hfOe9DsUKWg@mail.gmail.com>
References: <CAFLszTjxq7MfUKjW4VETkt-SpZs+seK8F71EwG5hfOe9DsUKWg@mail.gmail.com>
 <20240916082446.32082-1-al.kochet@gmail.com>
 <20240916082446.32082-3-al.kochet@gmail.com>
Date: Thu, 17 Oct 2024 16:12:01 -0700
X-Google-Sender-Auth: 6raEINS-ACbs7BUdNpihY46wKg0
Message-ID: <CAFLszTie5sgD9cgmbjK8o1w_NcjjTYkcbAcFVsEwmEOafGsseg@mail.gmail.com>
Subject: Re: [PATCH 2/3] image-host: fix 'unknown error' error message
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Alexander Kochetkov <al.kochet@gmail.com>
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

On Mon, 16 Sept 2024 at 02:25, <al.kochet@gmail.com> wrote:
>
> From: Alexander Kochetkov <al.kochet@gmail.com>
>
> Fix error message like this:
> Can't add verification data for node 'fdt-1' (<unknown error>)
>
> We get unknown error because we decode error as fdt error
> but actually it is system error.
>
> Signed-off-by: Alexander Kochetkov <al.kochet@gmail.com>
> ---
>  tools/image-host.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>


>
Applied to u-boot-dm, thanks!

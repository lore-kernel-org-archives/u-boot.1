Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B00BFC05052
	for <u-boot@archiver.kernel.org>; Fri, 18 Aug 2023 03:10:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5B67E86C65;
	Fri, 18 Aug 2023 05:10:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="T4IYFUXZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7AEA286C6F; Fri, 18 Aug 2023 05:10:15 +0200 (CEST)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F286986C62
 for <u-boot@lists.denx.de>; Fri, 18 Aug 2023 05:10:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-52256241c50so518187a12.3
 for <u-boot@lists.denx.de>; Thu, 17 Aug 2023 20:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692328212; x=1692933012;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Brw/stxHjkk/04IkJOQNI+OpD42GRj/jEDtv3X61Eao=;
 b=T4IYFUXZHqwnR8llwTsYlLiSeYCatNBPUqar5nQZQpL8oxX5iwKXvr0W40SIIDBr7J
 l61uvwrqTftEnBg+4fAo/qcyk6rhNd5bCuHgLDUIHm3rLFd/V3vetVNiJQP6x5vav4on
 7ZMVIa3mw6Vo2dpvyLhiQdOK12q/uR0MFXHXo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692328212; x=1692933012;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Brw/stxHjkk/04IkJOQNI+OpD42GRj/jEDtv3X61Eao=;
 b=GI2VejCEsIB+NTmW7z5HaRGKLQpasF99ho72khzYk7x3hIpQntatibghm11GoYDoy7
 CqWh/P77jJQKBIxzizRqPQHDjDFi6kXQtJV2nvlt7t3VOspbi/MMD9L/hXCCFqVoP19t
 loCf6OxWbyU9ZdvR9xX3LHoG7XEsDSf3UWmeNlrYKN1J5LWF/USe5JufYnFqkw6TUcbR
 /7s0OjafjF5qiMF3Cr/EtOZgptHexmjEv67fv2I0ZZClb+4MoY0/eA5/bgoW77Uq7GTr
 KTz0Co1An11S6e02y3a6VPRSjHGwFFMzwjGh+mPoxL3qGteH67OjBJ9tcCbtBULYlHi9
 0cyA==
X-Gm-Message-State: AOJu0Yz4Xk/FBOnOZkYeTxivKi4ojc/Ar1Q2JE7hEN/UyjQGzksLTMlo
 HM55K3blL8ijGSdteHMVSnQtS8MFEaRi6haMUvntGA==
X-Google-Smtp-Source: AGHT+IEHT33b8sElufCl0vWRXtac5lUaQXoBNqJr3ax2h+fgfIdPgRfkC68Bf5f/x7Z/cRuzRWG5ljKu2XPptkt2b8c=
X-Received: by 2002:aa7:cb8b:0:b0:523:69bf:2bd3 with SMTP id
 r11-20020aa7cb8b000000b0052369bf2bd3mr1207024edt.13.1692328212417; Thu, 17
 Aug 2023 20:10:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230817153612.30544-1-oleksandr.suvorov@foundries.io>
In-Reply-To: <20230817153612.30544-1-oleksandr.suvorov@foundries.io>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 17 Aug 2023 21:10:03 -0600
Message-ID: <CAPnjgZ0dv5iVhG_PfaMFc=d=AvKuP9gSy1dP74tfYRFn0Q=mfA@mail.gmail.com>
Subject: Re: [PATCH] tools: image-host: print error messages to stderr
To: Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Sean Anderson <sean.anderson@seco.com>, 
 Steven Lawrance <steven.lawrance@softathome.com>
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

On Thu, 17 Aug 2023 at 09:36, Oleksandr Suvorov <
oleksandr.suvorov@foundries.io> wrote:
>
> The make by default cuts off the stdout output from external tools,
> so all error messages from the image-host are not shown in a make
> output. Besides that, it is a common approach to use stderr stream
> for error messages.
> Use stderr for all error messages in image-host.
>
> Signed-off-by: Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
> ---
>
>  tools/image-host.c | 202 ++++++++++++++++++++++++---------------------
>  1 file changed, 107 insertions(+), 95 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>

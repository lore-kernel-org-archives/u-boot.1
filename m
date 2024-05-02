Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43884C4345F
	for <u-boot@archiver.kernel.org>; Thu,  2 May 2024 13:25:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F9CB88451;
	Thu,  2 May 2024 15:25:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BDarv+0e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4253F88B18; Thu,  2 May 2024 15:25:15 +0200 (CEST)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com
 [IPv6:2607:f8b0:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C556F88BE2
 for <u-boot@lists.denx.de>; Thu,  2 May 2024 15:25:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1ecd8f9fb2dso418955ad.0
 for <u-boot@lists.denx.de>; Thu, 02 May 2024 06:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714656311; x=1715261111; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CFUAgXTRj0ZlqGZE64qkSis1yYuOtqFYGSnO5s0XjdI=;
 b=BDarv+0eN1FOeS3gyf9dVDmoN6iB+5F3V/ek8/BkjOx2BO6dFxySRbr28TI7fnoxNp
 R19jssZdDblbHU5dw2mtOGggFHcp58vVFT9k4+qvUCbS+wHjkg6INcWFuIC8/moZpS7e
 oASS2gdSOE83lMFvfgRBa0h3ck63z1FCgyR2MbhvEhEBKdAU2kZT8YBNB/ziXiZmb8hR
 3ZU7WcNeZ0B+2re1a+wy2UZHDw2d26lGNY6rY0iwGc73oqpqd9wiQXsVUVeQIFrdiffQ
 7O6jen15vVw7eBZqgg3doZtJPSVuct++/ms77NxuJM4pkdtiRA2ox9IfiaDlQbZMGMV5
 OEYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714656311; x=1715261111;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CFUAgXTRj0ZlqGZE64qkSis1yYuOtqFYGSnO5s0XjdI=;
 b=gz7hVCbLGtDHsVqsXUTkHQ1zdLU+8sjjYajD6XTmxcbTgtqCTzF1AmDGKJrileP/Ds
 vLvmQdR2F+pT9bSsxZUi4p8An5H9RpRfHy/SflWhRJ6WLLIroIka/9sfQHcNvn+A/5cJ
 6LWtW/Yz1RxzvLucVbny6OkhEeZsftGhk9Zh7XQOsDPOtEjElRnpgzyWxDnT2QfRiB1F
 h8xWVTAa51ERgBc/oWkAxgvwWUbX2wDH6zuQY46r5El3kpjENHoq6BrOj7yBkxvgkvRR
 bOVcFDMiznRKlFcatM4qPsUy3gUMCg8jJuHRpji6bhA9ihsfj3feuWyUHzaJ9HE3YJu0
 lfFQ==
X-Gm-Message-State: AOJu0YxUve+e6oq4pv0TEWavcuvflBs+ufGh8BpReHmY/toMv300l/tM
 FuuAgPAwYTnzcH2o3wRJbAfZgN6COEggGVJGTo97VONq3BmjnC1vZDoOvONgxBvzUCZHab7iXxW
 hBh8iYUIa1UfqzIvmR4CkM30iySsKW5pE
X-Google-Smtp-Source: AGHT+IGiQM3jbDcprOdaqoXfnwezWJhfUgw9YLrBzVIQ2lP4yOgH/o4lG+GKuCUqM8wRP7WHgME4Lh4Cwr/eHicwXLA=
X-Received: by 2002:a17:90a:fe86:b0:2b2:760d:9507 with SMTP id
 co6-20020a17090afe8600b002b2760d9507mr5824163pjb.0.1714656311151; Thu, 02 May
 2024 06:25:11 -0700 (PDT)
MIME-Version: 1.0
References: <GVAP278MB0456BCDA64C66C434932AF388C182@GVAP278MB0456.CHEP278.PROD.OUTLOOK.COM>
In-Reply-To: <GVAP278MB0456BCDA64C66C434932AF388C182@GVAP278MB0456.CHEP278.PROD.OUTLOOK.COM>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 2 May 2024 10:24:58 -0300
Message-ID: <CAOMZO5C2nzr+PUcVWaqEB46OFFwBBGNs_bid84eqfQQ4Xewd5g@mail.gmail.com>
Subject: Re: Use header file from external library in u-boot
To: Johannes Kirchmair - SKIDATA <Johannes.Kirchmair@skidata.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Johannes,

On Thu, May 2, 2024 at 10:18=E2=80=AFAM Johannes Kirchmair - SKIDATA
<Johannes.Kirchmair@skidata.com> wrote:
>
> Dear u-boot folks,
>
> we are trying to share some information between u-boot and a Linux user s=
pace tool. For this we place some information in a FRAM. This information i=
s just some numeric values, indicating some wanted behaviour. I thought of =
using a header file to keep these values aligned between the user space too=
l and u-boot. This header is provided by a library.  Including it into the =
user space tool is straight forward, but into u-boot does seem complicated,=
 as the build system is not meant to include external libraries. Is there a=
 preferred way to do this kind of alignment or a suggestion on how to handl=
e this?

Would libubootenv work for you?
https://github.com/sbabic/libubootenv

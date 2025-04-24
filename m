Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 574D6C369C2
	for <u-boot@archiver.kernel.org>; Thu, 24 Apr 2025 17:50:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9404980F9C;
	Thu, 24 Apr 2025 19:49:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mkKv+9y3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E661C80FDA; Thu, 24 Apr 2025 19:49:56 +0200 (CEST)
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com
 [IPv6:2a00:1450:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 993F28056A
 for <u-boot@lists.denx.de>; Thu, 24 Apr 2025 19:49:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=heiko.thiery@gmail.com
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-30c416cdcc0so13466481fa.2
 for <u-boot@lists.denx.de>; Thu, 24 Apr 2025 10:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745516994; x=1746121794; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=n3Xd1DD9QQEwtZ5hWLSJE4PLjr0+TVyvwCh9HQBymlM=;
 b=mkKv+9y3MHfS/9jgUwyKYaTucdH9PIvSZCR6h9o2/PD1ixpFaoi5yxsfO8MmyOqLpu
 1wCMwW4xes68R8hcbffIbLMSw0/gRS3ikJeV84ItcLReGRUO70PzxOmbFs912YT3AYbG
 qTg150sz4RHXTWAFKh6A6LUJh3RTzBGJ3/2H7tIJZB6K7sB+n/hScJHsLPUsXskn+53E
 zJrwflKQoj6l2rgUhebaR6ehXaDZUzOtXKYSAkLPTlluSfhG/AoGpba8ZlYPsT3frZvJ
 2UIGCGWRilq/51MXDtjfP0aSpS85m0VlWEACn6d4Gt7mC1JT4LXvFIDGV3mmMzMO/NlH
 dD1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745516994; x=1746121794;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=n3Xd1DD9QQEwtZ5hWLSJE4PLjr0+TVyvwCh9HQBymlM=;
 b=twbCzwSy5cuCTNs5qlg3RKR76QX1tNG17vVTNYGc+W+YLPeQX79/FzY0PnInlo0R7d
 8QhYmu2LahAHGDnju4UDy+Jk8CZ+Ua5VKHmrOsDb60jJGFEzufuEVN8JHQmrfXA3iRKX
 Q8CeJxhOMWPcbtLq/rX0JcRWgDe4/R+x5jGQuJhcgEZ52KJZ/VW3QWdOYPxHC093MCiY
 5fw+vSluswE/jWIpYPTyMUTvn4iY8eTMvxf0hII+hlMx2i0smacb3k/BDxrYYkNjCBRM
 xwW7PLM5qo2m3Cw0hH2ZLIyrN3jISJdA6WAO7zFve+gk1xEnNrRpqPa3YNRgCNw7HpMo
 nNbw==
X-Gm-Message-State: AOJu0Yz0sgrku6V2CfDmqD3Lk7V3vUEgijqofoTq9XpQ23ei2bMbspqB
 ivPRz3CA/rw6tSnTIAw2pA+Lls49l++XiEnLnNxD691TReRot+EiBhnC/oSVrlaa+0OqVAV9CQS
 0jhp99guRyTMV5sBWraWmEt3VPaFMyg==
X-Gm-Gg: ASbGncve7ixs7GFmF24euRcBa1FtQ2LtVhtOOPHQyh4HWcQtRbs3iMb/aKoETqYxhtz
 9EcSJigMKGTuhF7fVLQwAw7iGuw0yusyQv3y5h0j42SDIuqZgmrEk7yRYR4G1fww3X05Ns3VCq/
 OFAzExBML7qiae685IUhmB4WSwX0ublM/KCDw+PsNxkJ5xs/5D5XryKHR5A8oqVxAMIUI=
X-Google-Smtp-Source: AGHT+IFvTCzmkM4wA0J3hrCvm2ipxGmR4OGbeS6WcC1RtIzTsrL0Y8Ra2Vbs4/gh33Ons02zOSA/i26ChlLOl37QnC8=
X-Received: by 2002:a05:651c:30c7:b0:30b:bdb0:f09d with SMTP id
 38308e7fff4ca-318a9290baemr2069921fa.32.1745516993617; Thu, 24 Apr 2025
 10:49:53 -0700 (PDT)
MIME-Version: 1.0
References: <CAEyMn7b90ybqMOgb4ViAaQVqvTuma-HyYkwEvSVHfowfvEd3tA@mail.gmail.com>
 <20250424174539.GL5495@bill-the-cat>
In-Reply-To: <20250424174539.GL5495@bill-the-cat>
From: Heiko Thiery <heiko.thiery@gmail.com>
Date: Thu, 24 Apr 2025 19:49:41 +0200
X-Gm-Features: ATxdqUE8n1zZ5aB3LFSJWv6sVeoNxNccn8GGEhy0ScUcd633VCTYUVS7Ja2IvLQ
Message-ID: <CAEyMn7asyKz8MnXUBZqtuFehR4Vk8j_5ysRCq5=H3EqiL36aMw@mail.gmail.com>
Subject: Re: bootflow: extlinux and menu
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Simon Glass <sjg@chromium.org>
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

Hi,

Am Do., 24. Apr. 2025 um 19:45 Uhr schrieb Tom Rini <trini@konsulko.com>:
>
> On Thu, Apr 24, 2025 at 07:36:06PM +0200, Heiko Thiery wrote:
>
> > Hi,
> >
> > I tried bootflow for the first time and wanted to test my extlinux
> > configuration with separate menu entries. But I don't see that the
> > menu is shown. The default value is always selected. Am I right in
> > thinking that this is not supported with extlinux?
>
> I suspect Simon also found this recently and fixed it as part of another
> series. It's likely in:
> https://patchwork.ozlabs.org/project/uboot/list/?series=449177&state=*
> It wasn't based on master or next:
> https://patchwork.ozlabs.org/project/uboot/cover/20250319143820.2385092-1-sjg@chromium.org/
> And some of the tidying up lead to size growth in a number of platforms:
> https://patchwork.ozlabs.org/project/uboot/patch/20250319143820.2385092-2-sjg@chromium.org/
> Along with needing to document some of the user visible changes:
> https://patchwork.ozlabs.org/project/uboot/patch/20250319143820.2385092-7-sjg@chromium.org/
>
> You might want to see if just patches 7 / 8 / 9 resolve the issue you
> see and if so we can get just those merged in.

Sounds promising. I will try to test this in the next days (when I'm
back in office) and give you a feedback.

Thanks in advance.

BR
Heiko

> --
> Tom

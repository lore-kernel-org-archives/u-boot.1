Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B801C021B2
	for <u-boot@archiver.kernel.org>; Sat, 22 Feb 2025 05:35:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5DB1980FA4;
	Sat, 22 Feb 2025 06:35:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="IyqZlH0X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A02980EC0; Sat, 22 Feb 2025 01:49:31 +0100 (CET)
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com
 [IPv6:2607:f8b0:4864:20::730])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E63DF801B0
 for <u-boot@lists.denx.de>; Sat, 22 Feb 2025 01:49:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=swboyd@chromium.org
Received: by mail-qk1-x730.google.com with SMTP id
 af79cd13be357-7c0a5aa0f84so240193485a.1
 for <u-boot@lists.denx.de>; Fri, 21 Feb 2025 16:49:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1740185368; x=1740790168; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:user-agent:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to; bh=Icxe75apJgsN6qw/LeXP2NE0QDw4j9JAPmfR+KuXxs4=;
 b=IyqZlH0XnEEx9Xh3nkUuGO4Zj2GAMMgW+yiAIKerK8wnZzm9f/71/8UYkTN+pOXq+a
 xtoBFaMvY9HPOPFo2PMdRjugBWttHA7zPW9n40fopjJ3AnJ5QdXvVfHgI2KdT5REeD7a
 A2ISTBZDIsEVNkjzhhZ47tauZvWs9VsdXHv5k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740185368; x=1740790168;
 h=cc:to:subject:message-id:date:user-agent:from:references
 :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Icxe75apJgsN6qw/LeXP2NE0QDw4j9JAPmfR+KuXxs4=;
 b=gvq6Zn/KHbXxehrgwbIohsrph/XpHGYxadBhm7hW+pVPyLsQKWZbEX15o7icdlNYEc
 CJLCzVm8wNYb3NjxvUYcqC4B0WI2UJcW9ApopniifYOi6Z7D6mPMs2/Vfjj4ab8gXTQV
 q+koXRtApSmGOWiZW/JgYMa8IyjAjKjISfT70SPxYYnPmlR5oM8j278Fvsb8UH+Tvaqk
 8V/YhYi9NfYK+CNcF78Bzf0rJFFTZcT9GxaGeoqa3TIGhl2y2DIygsmHfSs7ZOtQnkMG
 GHh/NOKWLJr6NkRA0ANahcDXnz0h1L+MtTq0sVJtXDz3jlUKbeNaZSZqUxF0ZYsLBKNm
 BYJg==
X-Gm-Message-State: AOJu0YzeKWVDWKvbFZ3HVYEk/nwGc8mJt0nYsclc6u0i5nYf5s7vc1+6
 HdPmtYmJGcZ4KJr4HosG3vJr0AB2sbNrqzjUWQwRdCwP89Em6w5gcMd5tXCJop1FMvbuqJFiy40
 HXqvw7DwSdNvVxQlGs8qRUtW7ql7Omzx2buM03/D8O1Pw0D8=
X-Gm-Gg: ASbGnctK7BT8foKq9xSyu0gBSzX9e+/vVBliprFRXEho48VdyVQYw0o3KWRhHO4GQ6u
 ASKmwywyF0ALPxCPgRN3w4iSmZ8Uy/b6JZs20TmfRgNSyoUf7vTdykxJYz3FQGJ8wvI5VSpEmbK
 1C9poz3fUWSyQws+D3Q29hlQPSoz2sydx9qiA=
X-Google-Smtp-Source: AGHT+IG94IbaeOraxy2A0CshwyxyPxp0hyIZauUke6OVM+4QJC6GPy0ySsWofNoVqtHma2JclX/D+mFeJcbUk8MvVvM=
X-Received: by 2002:a05:620a:1787:b0:7c0:9fab:bee with SMTP id
 af79cd13be357-7c0cf102772mr776214585a.10.1740185367880; Fri, 21 Feb 2025
 16:49:27 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 21 Feb 2025 16:49:27 -0800
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 21 Feb 2025 16:49:27 -0800
MIME-Version: 1.0
In-Reply-To: <20250221010721.GF1233568@bill-the-cat>
References: <20250220205900.3127680-1-swboyd@chromium.org>
 <20250220205900.3127680-8-swboyd@chromium.org>
 <20250221010721.GF1233568@bill-the-cat>
From: Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.12.dev1+gaa8c22fdeedb
Date: Fri, 21 Feb 2025 16:49:27 -0800
X-Gm-Features: AWEUYZlXbzHUfy8Jo5Ex7Y75wQe73KRlrwgp3WavYE-_I_llKFTVr7bWHpNWUHQ
Message-ID: <CAE-0n51Zksh8ReNkcJesVfcOJoP3acfgKbo99_kGTSOi8FfYqg@mail.gmail.com>
Subject: Re: [PATCH 07/12] cmd/cbsysinfo: Allow on ARM as well
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Jagan Teki <jagan@amarulasolutions.com>, Anatolij Gustschin <agust@denx.de>,
 u-boot-qcom@groups.io
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Sat, 22 Feb 2025 06:35:05 +0100
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

Quoting Tom Rini (2025-02-20 17:07:21)
> On Thu, Feb 20, 2025 at 12:58:49PM -0800, Stephen Boyd wrote:
> > diff --git a/cmd/Kconfig b/cmd/Kconfig
> > index 864b6d464ba0..0f456e3b95a2 100644
> > --- a/cmd/Kconfig
> > +++ b/cmd/Kconfig
> > @@ -2898,7 +2898,7 @@ menu "Debug commands"
> >
> >  config CMD_CBSYSINFO
> >       bool "cbsysinfo"
> > -     depends on X86
> > +     depends on X86 || (ARM && SYS_COREBOOT)
> >       default y if SYS_COREBOOT
> >       help
> >         This provides information about the coreboot sysinfo table stored in
>
> Maybe just depends on SYS_COREBOOT and default y?
>

Alright, sounds good.

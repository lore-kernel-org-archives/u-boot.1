Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFF5AD63936
	for <u-boot@archiver.kernel.org>; Wed, 20 Nov 2024 13:36:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 18F0D89301;
	Wed, 20 Nov 2024 14:36:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="diQQ5CyK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 299D3892DE; Wed, 20 Nov 2024 14:36:35 +0100 (CET)
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com
 [IPv6:2607:f8b0:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B5E089270
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 14:36:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-7ea8c4ce232so3890526a12.0
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 05:36:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732109791; x=1732714591; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=cBZSYip6G0hCBEvwPrZrLX88nrISqTgOLhj7GtCLPy0=;
 b=diQQ5CyK2g9eGZuo+DFfmeopTn/Bs0bNJ0WxYwQWGuCbmysQ+ONMQOmFRUYOK6LtMK
 9wmcX4kL74mPaHjL+Yr/n9Um6w7+KfvlnfvyGgz013pJjTWSRlv/TF0i7eKhevFjU1kf
 vDeItDJugmJpfJdD7T+k69ydf0MW5UkeIWkGU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732109791; x=1732714591;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cBZSYip6G0hCBEvwPrZrLX88nrISqTgOLhj7GtCLPy0=;
 b=ZXvriB98xFORSg7v1uSDeMkzJkhXggb1eRTUVlZkHIzmkATW8vG4AIJlnwX78IGEbG
 hYeiWE9y1TfqGXfBuCzAfAqn0YYW7W1jQB+THWThNrnf+9IODt3Ms8juwdFSIJ0GWEM5
 Pq+1U4vAblFe1cL64wnJ5BFgwoGceIfnN+VAWZoDmFHkPp9KgfL8WP+iepj4kScJc3DW
 rABGJXHrppOZhZcI6jAu+ageH46JIpGCEzKeLYtOfDOZJu/Ve162mGpekQYs4UQgpWrG
 daoyJjmFp8EZvQhjYTWktc1bcDwB0rrv8CZvy0G5oe7Fr4MYrUCo6zt0+LKbR09JWguk
 Jsew==
X-Gm-Message-State: AOJu0Yy0Sv1gO1yVcgAXiz4YLoKAxUTTAXFSq3YFo7wkEoBeyYt9ucKP
 /EtPf/5+lMb+oLnw7tmViZFbSoJFVbd5eFghauZJTmCqvyqbEQ9HA/oD9pVkKUkwa6ZH1wdwNsN
 73hDXzYk1GoKvVAJpk2F77SKqGnNBpN8OO1EXA8zJcd+3f+SftQ==
X-Google-Smtp-Source: AGHT+IFnE3hujyEWMVEDjYAL7sSHxQ9NYU9HiHhb0V3CSzs0tJBmDz/U6gzefas/8PBZMGGfZaGh5z7z30/lfUhHGXc=
X-Received: by 2002:a05:6a20:12ce:b0:1db:fff7:25d5 with SMTP id
 adf61e73a8af0-1ddaecd0194mr3815085637.19.1732109790952; Wed, 20 Nov 2024
 05:36:30 -0800 (PST)
MIME-Version: 1.0
References: <CAD2_vGoJuBnckL1GPNug2Aa3XJOVgO5tknKkLhM=iZduS0hBOg@mail.gmail.com>
In-Reply-To: <CAD2_vGoJuBnckL1GPNug2Aa3XJOVgO5tknKkLhM=iZduS0hBOg@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 20 Nov 2024 06:35:40 -0700
Message-ID: <CAFLszTicvjU_bwfhaYM1uCeotKXdv_yafFCur+SHN-e5KgTUpw@mail.gmail.com>
Subject: Re: Zeroing Unused Memory in U-Boot
To: Friedrich Doku <friedrichdoku2030@u.northwestern.edu>
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

Hi Friedrich,

On Thu, 7 Nov 2024 at 14:53, Friedrich Doku
<friedrichdoku2030@u.northwestern.edu> wrote:
>
> Hi,
>
> I hope this email finds you well. I am currently working on a project
> involving U-Boot, and I have a question regarding memory management.
> Specifically, I would like to understand the best approach to zero all
> memory that is not currently in use.
>
> I am considering using memset to achieve this, but I am unsure about the
> most efficient and safe way to determine which regions of memory are not in
> use and can be safely zeroed out. Could you please provide guidance on:
>
> 1. Identifying unused memory regions in U-Boot during runtime.
> 2. Using memset or any other recommended method to zero these regions
> without interfering with critical data structures or operational stability.
> 3. Any potential risks or best practices I should be aware of when
> performing such operations in U-Boot.
>
> I would greatly appreciate any insights, examples, or documentation you
> could share on this topic. Thank you for your time and for all the
> incredible work you do to maintain and enhance U-Boot.
>
> Looking forward to your response.

After relocation, before images are loaded, you can zero from the
start of memory to the bottom of the U-Boot stack. The 'meminfo'
command[1] shows this mapping.

Unfortunately a recent change has make the EFI_LOADER use memory
outside the U-Boot region. I am still hoping we can correct this
design error before it causes too many problems. For now you can
disable CONFIG_EFI_LOADER to avoid this, so long as you don't need to
load/run EFI apps.

Regards,
Simon

[1] https://docs.u-boot.org/en/latest/usage/cmd/meminfo.html

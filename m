Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E54B2C0218C
	for <u-boot@archiver.kernel.org>; Sat, 25 Jan 2025 17:14:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 63E3480EF6;
	Sat, 25 Jan 2025 18:14:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="eViJFCUS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CFEEB80EFE; Sat, 25 Jan 2025 18:14:19 +0100 (CET)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8477880ECD
 for <u-boot@lists.denx.de>; Sat, 25 Jan 2025 18:14:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5d7e3f1fc01so6315804a12.2
 for <u-boot@lists.denx.de>; Sat, 25 Jan 2025 09:14:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1737825257; x=1738430057; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=yduiMtwLOZ26C+yfk0kZq7+Xer5BjpYwbNBhu2VDdbM=;
 b=eViJFCUSxohEc2Ant9d5t97JayMYld/7KXW1G2OgCLTaMBUpqN6ERUuajiDYDjKWb4
 cJ6bNL8uOaBfTawuXlH2qdymEFWkCcgOvZrCrLRmN2LOGUyPs190TZ/j/niPGrsLCMS+
 hS3RRCqkz+WD4do5X6u250zVsSfckstgn+Klk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737825257; x=1738430057;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yduiMtwLOZ26C+yfk0kZq7+Xer5BjpYwbNBhu2VDdbM=;
 b=cIsUWAgkp0xiwSH+GdUTkUVexMPR1FzN9jjOAB012Mh39dB+M4H4PCXZKDXGWo2bI2
 8FcBPMnVEs++pvHsVj483H6rHDvbcFfZUTz+bbQ6Z43dRjqlItr8kJbgR6zEcNHBZ0Zt
 zIU+o0pIjOrBDlfLBVLG56w5pAdxKLIFSW92XsGUfmN6qGLA61tQ5yd5Ezo1qI/S24Km
 I5ysbvLoP7uasVycUwu+P6U/yySCHZVHLwIw5NZklEXm8Y2I1zv/K562LIFd3XXVRD8z
 uZ55zE3hASdbgVfbxi8Z7qldfqu/HJRg86FTJ08IrgtIWO4doRRbxt9/XW9hGKU39AzV
 3xlw==
X-Gm-Message-State: AOJu0Yx5tTNWBHaJgVwaJ62Nj+gRA/IVV64d9Tt2+BPWw4cJwDx496Vo
 O7WZYOBflC9G7nSIrHBAen5zc3elDIW69HjEesCjnwTLsTFBYHtfI3SPwn4MLkJYhIuah3Y7xTp
 jq+VTzbemZzEaNmPvWqf7dmb55Y7Olgk3X1FO
X-Gm-Gg: ASbGncv5kqiZOQV+7YYla0y4j7yUhbA/LVOB2E/5xE4iLlQD1T07c9jrRnlvuyQT6ca
 l0WatyOJ7ky3+wt2EBCrTj8dzLuA3C4722GANkhCucr29eZh9vMGJ3TuECVl5dBEEKuufENXGew
 ==
X-Google-Smtp-Source: AGHT+IGu3k2O7kf9AkfVcOoAeQgBPyIrO9jvUdBrF1Aduc/w/Oqffdr+I/2qxyyP3Uk4ijvygmTig8soFSJVkWkSZ/U=
X-Received: by 2002:a05:6402:51cd:b0:5d3:e4eb:8d1f with SMTP id
 4fb4d7f45d1cf-5db7d2fc8b0mr29834456a12.12.1737825256896; Sat, 25 Jan 2025
 09:14:16 -0800 (PST)
MIME-Version: 1.0
References: <20250124185605.372347-1-sjg@chromium.org>
 <20250124192056.GU60249@bill-the-cat>
In-Reply-To: <20250124192056.GU60249@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 25 Jan 2025 10:14:05 -0700
X-Gm-Features: AWEUYZkThBvmmv0sAMOcGTdZ_Y1nVPd6OIEgBkPQLzMBFysHBSrZ5hsNc5y6bc4
Message-ID: <CAFLszTjowGVr2R0=bz-h=sU0NHjP8CDaF04cfO1Kbh8d8F5nFA@mail.gmail.com>
Subject: Re: [PATCH] test/py: Add a report show test durations
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Stephen Warren <swarren@nvidia.com>, 
 Stephen Warren <swarren@wwwdotorg.org>
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

Hi Tom,

On Fri, 24 Jan 2025 at 12:21, Tom Rini <trini@konsulko.com> wrote:
>
> On Fri, Jan 24, 2025 at 11:56:04AM -0700, Simon Glass wrote:
>
> > Execution time varies widely with the existing tests. Provides a summary
> > of the time taken for each test, along with a histogram.
> >
> > Example:
> >
> >    Duration : Number of tests
> >    ======== : ========================================
> >        <1ms :  1
> >        <8ms :  1
> >       <20ms : # 20
> >       <30ms : ######## 127
> >       <50ms : ######################################## 582
> >       <75ms : ####### 102
> >      <100ms : ## 39
> >      <200ms : ##### 86
> >      <300ms : # 29
> >      <500ms : ## 42
> >      <750ms : # 16
> >       <1.0s : # 15
> >       <2.0s : # 23
> >       <3.0s :  13
> >       <5.0s :  9
> >       <7.5s :  1
> >      <10.0s :  6
> >      <20.0s :  12
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> >  test/py/conftest.py | 77 +++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 77 insertions(+)
>
> Whitespace issues aside,

Do you mean the blank lines? pylint wants those for top-level items.

 we should probably not do this every time, just
> when requested.

I'd like to see it on each run, actually. It doesn't take any time to
calculate and it lets us see where the time is going.

Regards,
Simon

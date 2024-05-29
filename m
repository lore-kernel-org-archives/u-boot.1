Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E22ACC25B75
	for <u-boot@archiver.kernel.org>; Wed, 29 May 2024 19:49:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 39FF38803A;
	Wed, 29 May 2024 21:49:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="I3cUdvzI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A77F5885E1; Wed, 29 May 2024 21:45:48 +0200 (CEST)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 66AC887D2F
 for <u-boot@lists.denx.de>; Wed, 29 May 2024 21:45:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-3d1bb1c3a88so14093b6e.2
 for <u-boot@lists.denx.de>; Wed, 29 May 2024 12:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1717011945; x=1717616745; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+Rp1/cao/1Kicgp49atMs/wfiu/6q7WiVanSij0A9l0=;
 b=I3cUdvzIhP/yNFgEGiWNGbviwZwxk0qoczvuzEKzqegJ3/nY0LNnuM0wnpDxfZI61Y
 qOARs6W/KxnQoCRuAx0YOUjFaEhBUoopxVUCEemVa9rVXLFpQYTq2PzyNf/EI1dmEL9O
 r+leYOnUOUoBmbTIa/C+YXqzQ+/BHjzZxKkGg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717011945; x=1717616745;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+Rp1/cao/1Kicgp49atMs/wfiu/6q7WiVanSij0A9l0=;
 b=s01tGCkzl0yLt0CoiziXVf+8XcOrdUoV6NqfgrUNuUTRm2OZDMXZdj5HlkETAO1gS9
 j/fo9Q4nv2ntqd7Nlsj3+fxAo+gN5RTVn4Q3TaTQdAiZmTAn4+zeEYWDDwD00CMTJbhG
 hcP3yA5QXqpzdTLoFPxMjeysUF5dWlffibgOIKY7QB5s+f9QQc3sSwIJMp7kwlTpcCpJ
 CcgABKPDCiF4O0k/P4wRiR1JUuEZPqcyB+fyYNqYGPtWKPIj9kq9ZT/W6sNO5nP6Tqtx
 hLsHRvGGrCCRiEhh2jeo7L6HfXkRXvTC2nPeyhmMA+ubwGSuNd7sWuKF2+JG0lx/T+nR
 Gj3w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUnkxlrjfmh9fUVROWMNhZRNbbRcoa/1bmmhHiJq+7uU2zgvMjiKbSNx5xZChCROnCPFTG0JvhoY1q9/UJ4U8hEdLuuCQ==
X-Gm-Message-State: AOJu0YxPUxDmXbb6vtEtUJOzARjTt4T9/lp6+x0iITrJMURyzIznbkSm
 2oDUeZbb1Y2kLg+5uIxdK6NYMjk3KILOvgOpClyg1fLGYjrzzpJqjTZICgcfaJMZUIocFnnuZD/
 5pw3gjFvFWh+cGaqi7z39vbx/ukbKbHV0QJs4
X-Google-Smtp-Source: AGHT+IFFgKL5LM35IX/gine3c6Q4YwR4+EEz89kQFptGFjrUWTg8qPPCbYD0sGbAlIhM2s21xStTNqi/gVl8oZR5Be8=
X-Received: by 2002:a05:6808:1895:b0:3d1:d399:2cd9 with SMTP id
 5614622812f47-3d1dcc9c62fmr28786b6e.7.1717011945025; Wed, 29 May 2024
 12:45:45 -0700 (PDT)
MIME-Version: 1.0
References: <20240529-b4-dynamic-uuid-v2-0-c26f31057bbe@linaro.org>
 <20240529-b4-dynamic-uuid-v2-6-c26f31057bbe@linaro.org>
 <CAFLszTgtJi+QE4Ry70jDJbqg3rgTMXEqbt-RROQ1kQwR1Qv-Ag@mail.gmail.com>
 <fd581f3d-00a9-4389-a9e5-e1fb8b5b213a@linaro.org>
In-Reply-To: <fd581f3d-00a9-4389-a9e5-e1fb8b5b213a@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 29 May 2024 13:45:34 -0600
Message-ID: <CAFLszTgWPikh3VA6VvvQc6uuPvb3MZL=E37mUB4Ng7STJeUBTw@mail.gmail.com>
Subject: Re: [PATCH v2 6/7] tools: add genguid tool
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mario Six <mario.six@gdsys.cc>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Richard Hughes <hughsient@gmail.com>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Wed, 29 May 2024 21:49:27 +0200
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

Hi Caleb,

On Wed, 29 May 2024 at 13:02, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
> Hi Simon,
>
> On 29/05/2024 18:30, Simon Glass wrote:
> > Hi Caleb,
> >
> > On Wed, 29 May 2024 at 08:49, Caleb Connolly <caleb.connolly@linaro.org> wrote:
> >>
> >> Add a tool that can generate GUIDs that match those generated internally
> >> by U-Boot for capsule update fw_images.
> >>
> >> Dynamic UUIDs in U-Boot work by taking a namespace UUID and hashing it
> >> with the board model, compatible, and fw_image name.
> >>
> >> This tool accepts the same inputs and will produce the same GUID as
> >> U-Boot would at runtime.
> >>
> >> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> >> ---
> >>   tools/Makefile  |   3 ++
> >>   tools/genguid.c | 154 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> >>   2 files changed, 157 insertions(+)
> >
> > Where is this tool used? Can you add a man page and test?
>
> It currently doesn't have any users, it just allows for pre-generating
> GUIDs ahead of time for a given board. It might be hooked up to vendor
> tooling or some usecase like that.
>
> I've somehow escaped learning Groff before now heh, I can give it a go
> and write a test.

OK (just copy bits of mkimage.1 :-)

Re the test, would this be something that binman would use? If so you
could put a test there.

Regards,
Simon

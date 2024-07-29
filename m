Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D73EAC3DA4A
	for <u-boot@archiver.kernel.org>; Mon, 29 Jul 2024 07:46:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 60E3886BF1;
	Mon, 29 Jul 2024 09:46:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="LJxgDnDp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B3FE583333; Mon, 29 Jul 2024 09:46:27 +0200 (CEST)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7FBC8887E3
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 09:46:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5a15c2dc569so3009418a12.3
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 00:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722239185; x=1722843985; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1nQN9HXs54Q+JYDbC2PbrLvtGM7StAA55rNCwAKd0HI=;
 b=LJxgDnDpfojdu7BbXb7KUDd5XKksTvGUULZR7yFGLQz92yBUXVVY7X/H9yUrC3ZziH
 RHBO8LGAyK2qEMBS2ALN/rTb2mh2zdhPoJOKmQ4BIAaygRZZOY1puKSrkHao1tK9DxAI
 QxxfN49Xb1FR90MbxHO3jRmkulNCbWaUN0YsVHjN67HiQ+ITfjOB9tMv/Fbzl7KPnxRb
 aK7qdNerL6TwYuCzjm10hp04VemMLSKA58fjAU2/mwGSU01xHF7FGSSkPwWBpGpRXce5
 mppgiDxHRKvF5fG01W+bUaLsSelwnnb6fd/GQPBXe3UyH3xlNuxsHsJa7t9bvnUwYS08
 hnuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722239185; x=1722843985;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1nQN9HXs54Q+JYDbC2PbrLvtGM7StAA55rNCwAKd0HI=;
 b=jmG5gH8RwbVlUSKIliAKpOacsz/xnBnEUUfYI6O8LpvVr5yJYSf8slRXQXRzGFqzbC
 MlRKz41VaTth1ZUpdGi+sqibCsb33yDF1vIqjrsi+So/JsnSw3KKBYRXZ5kdrDTgEZZ9
 29bCkEuxswtVyC/jYxgNA39NlWBXrR8C/w4g1yqhM0k4GLPUcAFuCCRLWw4TBNqzad8t
 vjfIAnetoyxhgnlxY9ceq1O04cR+8UbNWQLelfYmUXKLRaqwOItQ1xeqop74CL/ycUvD
 4Hcu0tZE7iKuRfC1wHzPaaTLHmt00w6q3unpKrYLZ7w5iALouRIsTn5vUM6Bq1Iy4x/q
 Slww==
X-Gm-Message-State: AOJu0Yzsq0tKhidwjyke+x1fFPOskfaSmxh3yu3qnMHnY8SpFPXZCO7L
 wHJiuquITTGj8lBIS8LJJ532tR+EtWT/iSI87kFRZlBHbzT+VtDMbSbrpTiJTaJjp8pjJlChmP3
 S1hHfyl/JDV4JJUq4vuPpR76sfKp0kA3OvlodmA==
X-Google-Smtp-Source: AGHT+IGi4Pj9tGUxu1UDuAdHVpVzKOl0bVQkzra4N76+Ncslzr4wtTfDk/QIDkF0glB8BCXIIE3sJDbE7KRvSXPbPaM=
X-Received: by 2002:a50:c092:0:b0:5a2:2b56:e06e with SMTP id
 4fb4d7f45d1cf-5b0239507bcmr4347138a12.36.1722239184702; Mon, 29 Jul 2024
 00:46:24 -0700 (PDT)
MIME-Version: 1.0
References: <20240724060224.3071065-1-sughosh.ganu@linaro.org>
 <20240724060224.3071065-6-sughosh.ganu@linaro.org>
 <CAFLszTjCUWWZ1at-NWR17NJu1V3JjksFehy2=QgX2xf98SfXug@mail.gmail.com>
In-Reply-To: <CAFLszTjCUWWZ1at-NWR17NJu1V3JjksFehy2=QgX2xf98SfXug@mail.gmail.com>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Mon, 29 Jul 2024 13:16:13 +0530
Message-ID: <CADg8p95aqMAAHjJwtwkq2JJGEcYLE9thnzR-EdHYD9v0PEd9oQ@mail.gmail.com>
Subject: Re: [PATCH 05/40] spl: alloc: call full alloc functions if malloc
 pool is available
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Marek Vasut <marex@denx.de>, 
 Mark Kettenis <mark.kettenis@xs4all.nl>, Michal Simek <michal.simek@amd.com>, 
 Patrick DELAUNAY <patrick.delaunay@foss.st.com>, 
 Patrice CHOTARD <patrice.chotard@foss.st.com>, Huan Wang <alison.wang@nxp.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, 
 Thomas Chou <thomas@wytron.com.tw>, Rick Chen <rick@andestech.com>, 
 Max Filippov <jcmvbkbc@gmail.com>
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

hi Simon,

On Fri, 26 Jul 2024 at 05:02, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Sughosh,
>
> On Wed, 24 Jul 2024 at 00:03, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> >
> > If the malloc simple functionality is enabled in SPL, it is not
> > possible to call the full-implementation alloc functions even after
> > the heap is set-up in ram memory. Check for this condition and
> > call the functions when enabled.
>
> Is this because you want to use lmb in SPL. Is that needed?

Yes, there was a discussion on this, and Tom [1], and you also [2] had
mentioned on the earlier series that we do need lmb in SPL. You had
mentioned that this would subsequently be needed for VPL too.

-sughosh

[1] - https://lists.denx.de/pipermail/u-boot/2024-July/558250.html
[2] - https://lists.denx.de/pipermail/u-boot/2024-July/558644.html

>
> BTW I'll send a patch to allow alist to run without realloc().
>
> >
> > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > ---
> > Changes since rfc: New patch
> >
> >  common/malloc_simple.c | 13 +++++++++++++
> >  1 file changed, 13 insertions(+)
>
> Regards,
> SImon

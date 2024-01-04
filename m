Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70922C47073
	for <u-boot@archiver.kernel.org>; Thu,  4 Jan 2024 01:34:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 93641876FF;
	Thu,  4 Jan 2024 02:34:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HNPIenac";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC47687707; Thu,  4 Jan 2024 02:34:47 +0100 (CET)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE31F876F6
 for <u-boot@lists.denx.de>; Thu,  4 Jan 2024 02:34:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-3bbb4806f67so33127b6e.3
 for <u-boot@lists.denx.de>; Wed, 03 Jan 2024 17:34:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1704332083; x=1704936883; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3HKxIVHrlRZ7FK3vO88sNOyLUZPP/cuA1s1FpuB6yMw=;
 b=HNPIenacJ/2zlZttdau4LXRA2KOwtKqL8j+G5AasJtyV9zhRrLNvaxh09TD7Bsm1RY
 fki6t93TggFnG2UbYJ/P5AWYcY+Jfj3r7QL+176eMSQrL2BJKZpH0JrXxqQ/CLu/JvLE
 +u49fx8ug60T+be7Gy+k+rlgJX48r6Ub4OM0M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704332083; x=1704936883;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3HKxIVHrlRZ7FK3vO88sNOyLUZPP/cuA1s1FpuB6yMw=;
 b=DPKYvEGYA+n2LRGJJgDo4FR94+KDr8H+29quo3z+MvqVt/OxWw95/3DSr09nI4cdF/
 7wXzbHST/Mv1ARpOjmrDRymJQm+gImzkycdRzKCoLVFhTqhQtyC2SYoRITh1Zshrpq0w
 itI0EMFYvWBZj3pJn2zg+rLNa9p+9H7unaXjbStUNgBb98tPJynEK7fzUcgm3svr3cky
 l5raDRlQQ8kV0Xx+8mW3VpGlL4x1z231cPVp/3qxkfCik73Vod/bMFuZxQLMrMKHBDue
 otrK4HNOrjPumOSpWA5vc30oFZ1wQVFzv/Q4DnRJyxuOTCKcumfLEdGNh6Ck3usoZNNz
 y1Ag==
X-Gm-Message-State: AOJu0YyTEfpBOJWYmQ5b58L7ZUoZ3/yK60XfKRgPJGQ87v96nbNbqcCR
 7IitxUVtW6vegJBAkIYDKPg491qyN4dEBu+gcl9xsSH3aOSGE7j9jRLdWcg=
X-Google-Smtp-Source: AGHT+IEc0rzp1FfkR2PbHMY52e1tNekPMF2ltonZ/rp4DLTEwpzvzKSuN8Bn9lCRcfZb9sB1GG0f/NhdxdLspvYOT5s=
X-Received: by 2002:a05:6808:2115:b0:3bc:164a:3c00 with SMTP id
 r21-20020a056808211500b003bc164a3c00mr3845253oiw.87.1704332083315; Wed, 03
 Jan 2024 17:34:43 -0800 (PST)
MIME-Version: 1.0
References: <CAFLszTjvFWYNJGK_cAo6UuGNcBqO1KSGWUS4j58DHM_fu6V_Tw@mail.gmail.com>
 <4cea9f42-9948-45a0-8f0a-31cd41e7095d@northern.tech>
In-Reply-To: <4cea9f42-9948-45a0-8f0a-31cd41e7095d@northern.tech>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 3 Jan 2024 18:34:32 -0700
Message-ID: <CAFLszThRE3hyPOOB-RA5a-eKw1Rr85ehr+6Vs=Xm_5O1cY9ikA@mail.gmail.com>
Subject: Re: vexpress and DM_SERIAL
To: Kristian Amlie <kristian.amlie@northern.tech>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
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

Hi Kristian,

On Wed, Jan 3, 2024 at 1:18=E2=80=AFAM Kristian Amlie
<kristian.amlie@northern.tech> wrote:
>
> On 27/12/2023 08:55, Simon Glass wrote:
> > Hi Kristian,
> >
> > Do you think it would be possible to migrate the vexpress_ca9x4 board
> > to use DM_SERIAL?
>
> Yes! This has taken the backseat for a while due to other priorities,
> but it's back near the top of our backlog now. Our goal is to have this
> solved in the first quarter.

OK, thank you.

Regards,
Simon


>
> --
>         *Kristian Amlie*
> Software Engineer | Mender <https://mender.io>
> Oslo, Norway
> <https://www.linkedin.com/company/northern.tech><https://twitter.com/nort=
herntechhq><https://northern.tech>
>         Northern.tech <https://northern.tech> | Securing the world's conn=
ected
> devices
>
>

Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CCF4CA5FE0
	for <u-boot@archiver.kernel.org>; Fri,  2 Oct 2026 19:14:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0327C81227;
	Fri,  2 Oct 2026 19:14:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LmXuSfH-dQSm; Fri,  2 Oct 2026 19:14:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 436DD81325
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790968496;
	b=pytfzCMawWsRHH4H8u/bTCBZuSdNbUQ+o8zuYHZjOCNpRfFbRluggMMZzDJS/clf+H2m
	 bk1iOhwCn6u52Xki27dULS8eJxaHsBLzlZSblhGxODaREWwJj2+7tbZ7gzY/tb+76hGSL
	 K8Nbt06YXvH9W+O3KAopSE6v5d/PaoBIH3Yl7Ad7vC4DnybN+HbpJfMMxOqZp/4HuqypP
	 wi1jTUIh7u1vdN+Rvt5VARHum2dZC06nSuoCA0PHqy8oEJtcxDNCMiK9yr3s4CmYHoBeJ
	 DuUoiiidj3UZzQyec+zmCPANpoLG+IixZ1h5jwUSSn+nrJhMhZ4qC9qd1nqUOdF9cuw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790968496;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=LfBggrmnGFKw/YjEV63jWHgf7+AOaUtSJxAcNBw7nrw=;
	b=oP+9s4At3WtA1q6Z520qOInap5YAkYwVGQiafIG06IbPHW7+WaJjdPitA9UAs0m88tx4
	 /KUBhUB960EcCSe4Ry1/7Q+TGfBQqfZnA81F4z7XaSoxvXdhSJHsPp5VpQ9M4NX77mDQX
	 1wGtZ3kvtb8XkEEjZ04au4EYdtVWZvVZeE6CLo8tnCb5slYiBBEFxXyj3RrmLiL91QPkc
	 tGLr6lvK00WJZMLsHC5uI8pPGrAIW2/UcVQbQJcdwIkqsClSEWV2rJx2qM+AGehn28gKV
	 V7wQDP/H+OLl6eQhRxPKDL/uade/SHsb2yZVk+yHA+oQ1+MISDnR6ButQnJ9bIoc+zA==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790968496;
	bh=LfBggrmnGFKw/YjEV63jWHgf7+AOaUtSJxAcNBw7nrw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=q0+UFoAJkyMhBYX8zdq+9zt3eQzq0SJZhcZgAiPbOYOF5iNnGy3S2gM+Bp9qceTS7
	 +rQZzveywuJyhdEczGL+mO3+HPiTvI6ygBQ01GMNLYF+EzSc/IYCWYD6d3k1jPQIOX
	 c/zWxuwD1jRaExnwFaafRM6pqiWCd0wKqlZxn2AWkoAw6+O3QRHW0yx7Ye4mFQM//z
	 stdpXzQYbAsFnRsVF1Ki3HAbC4Nsg+bpaljmetoa6kQC4Otn90k9L3jwagU+rSf+b0
	 D15lmlq28eBS9Qw9vR1z0MaoXEiMGFJZauKni9cGxTcGerNwCGS2CPLgP6gFIuNZ3w
	 CYwXCLIMdHCjg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 436DD81325;
	Fri,  2 Oct 2026 19:14:56 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 928C61D2
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 19:14:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8422460BC0
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 19:14:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Eoy4ErHNLdLt for <u-boot@lists.u-boot-project.org>;
 Fri,  2 Oct 2026 19:14:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org BE26960894
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:41::12"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790968494;
 b=Gzy2l8E2j8X8i/yV/98qNVxIg+VhH8Sagy4PL6DellkFnAi2k221DO5PYe+nxKAdeFzq
 HbCCnAhtMIgojQFUxvMyTrhQ8Thu9O4WmYmoCbybHUHHVG0prMVQhbxMqnG6QD1rOQMBG
 pcWwrHSWtUkOmW+qoiSy8V0LabFDqgIF59TaUVkkXimp0B0mPWWm5LuccorkFgoJWlOi3
 yaPDdsd/EPMN7fYdVEmMbUczE3ko51/f3q3gRG/cigggbTh8Kmm8juJL/PaISQVrcLTQY
 xK/zJVIVe45cHpxqcOs9+URW1b5hpN9eE0nAyIjXB+dOkC4TDcxNtDh2+I1+9L3yvsw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790968494;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type:Content-Transfer-Encoding;
 bh=LfBggrmnGFKw/YjEV63jWHgf7+AOaUtSJxAcNBw7nrw=;
 b=PkYFn2yC0HGGayYqsCGc3QxniTBNW679hSeH8NHd+znI0AwXspvOux93yMSeAYxXZuHq
 pqiNbQboz0jTvdC/mjb4jD10uJQ1xz8G/TZhn/o6mTgAu//C9NwoNwAgKPrVojv8lu2ZS
 rM9Rlg5kusj1fckHEOGHuMAAue7otGQEXAwwOvJ5sZC87gomZCpIqQMm0CWb9WNZ/AQUy
 OpOid8VK9Zfk0up+X/k2HvJjM+hqfRxrhqB9TT45Xf2li67dAaL1D6cMKfv+bUf9UYt3w
 0hPjHa33+cvGFPiIxT6TNpmPZzmoEJ1bdSvHXjT4zCwLdTzsCGTNbgj5MeI/i/4La6A==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=KhYS87Xo; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:41::12"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:41::12; helo=mail-yx2-x12.google.com;
 envelope-from=mibodhi@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=KhYS87Xo
Received: from mail-yx2-x12.google.com (mail-yx2-x12.google.com
 [IPv6:2607:f8b0:4864:41::12])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BE26960894
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 19:14:53 +0000 (UTC)
Received: by mail-yx2-x12.google.com with SMTP id
 00721157ae682-8ab42612328so52396397b3.0
 for <u-boot@lists.u-boot-project.org>; Fri, 02 Oct 2026 12:14:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790968492; cv=none;
 d=google.com; s=arc-20260327;
 b=bM5C4vqaOu++n+zItxC8IMGqSLGhZzXLw/Q7NqQtJQ2Q1D9bJuMb+Q/QBTBMMD7o25
 TpyPlu0e0L1SBC7Xx5lRbABpWmq75SEubL8sOOLXfT0UdHS7YqawqI9Sgdc6su3wH94m
 prmxJvVrgCRUJoVFqG7t6XavpuIEyKLvWGJrD++iT1KwQS2cfEp1qM3Uv8GV9RrPhuMA
 d6pqyG+sfXg/K7lfghVaGSCjjN7p/N9UEEbOafkpxdULCNL7J32gH/MoWuwLMsRkKow0
 thIXA/mNdDR32/pHjwoqzCb51Tw1bl6xtvc4BLW+D9zhnQSsVhRSerXx7mX1/leYw0On
 wsig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=LfBggrmnGFKw/YjEV63jWHgf7+AOaUtSJxAcNBw7nrw=;
 fh=xyhvjVQhvAiwBAzAt4vERCTXzNkwUATgRVAt8FDGV0c=;
 b=ghHMp5LNnEUJyQsnOop58R6yS/S5TEsXNHjTddG/aztGppxeo0+xnE44272f4gxFn4
 x1NhUQS0HQoFUzmMqFPfe+p6Ddvqy/1+6VuF8+tld0S+ZT3zhUVDVsGlz/lupmqULVKt
 o1bKGVWUcR12q0gU6AUjwuaL+OBQAERhc957nYRydxAO3kMWXolY0IxG+CQFq6pmweLo
 fWfy1USCN9quX6rPitNRMjTM/CXFxT41EDtRYmEdeSNJhcd8rjihSAVg4x5jd9JlLQf2
 9KjuWrJlCSdeUf89Bk4QY97K/lZbV6eE2iZt19s93f+2LmQSTzSyUNzjbnfmBzyPUGlc
 SMPw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790968492; x=1791573292;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=LfBggrmnGFKw/YjEV63jWHgf7+AOaUtSJxAcNBw7nrw=;
 b=KhYS87XoVJ8II2GenFLDaOrElWRoumIjoVpuhc8ZL49NWf9/9Xkc/1gxrmuhx9KrVY
 cY91rs5lH5G2GiYIBvkavVLgwXAmrAt3AtBTV+WFIyaBlo51oA/Y9NFxsdWVhtrc5ttR
 wCjCNyfi2lH3jXaBWOiD7UBSgaZ3qjZSzx5CIEKw6oaOMwNTpqAkbFasZwHHNjiDhcKt
 vFEvr6VCelxCEpU06V+SBwXFhQYhNJKVbhPul5aoFIRj8EXbwRdd0m0nwUuZTjkPhs1O
 Xd4NjE8AUe6sGSYv4mizaKL0Nu326yksKbLWCS4s0oLMxK12Ya2ynCYy/mP1Mov0J+u/
 0gLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790968492; x=1791573292;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LfBggrmnGFKw/YjEV63jWHgf7+AOaUtSJxAcNBw7nrw=;
 b=FP3vpTAK9HiN/B8VcXmK7dYSEKWhU4hL+K3I0Sca2uZ+Xs0axg1of8PYDpMjkYVlvV
 IZo2s3E/Oh0yBNA8jSKYJQpwCGBU2OwPyCI+gmcTLSywCLOgMEiYHOcErvF1IBhfUIWy
 w0g7H6bLUvKJJ2WzzdozdRX+37a/ogS8R3GPTNsDXE+7vjmMhj5ZpCsKmhq3LmBQU0sF
 MYCT8WnoKDuRDvz7XLT6jHOU92qlPZRtCsRS7PgtvQvzrcOOW/aNbi6wlw/Lw9YT7bbp
 om6il+j74gvqEc/JFdRe6HRNVY28XcYmi9PPBo72NkMbAiQn7rtAZmEeJAsYWk0JO5Ya
 LQAw==
X-Gm-Message-State: AFq9FYLu2nv4FLEsPpGn63dqlkiyBsRVKi+CAs/JyPpSiAYm2LBjOC+x
 Z1j1AverSTNJte8D9cxOB+OMl+eBb/RgeWsVuaNDzDnCfbILfm2K9GEdTsh87VkHobpRCo8SQTB
 44n+SAhGco49W73E9zLxTOipaSauaNC+Ql7c2
X-Gm-Gg: AYBFou35KgGC7Ly5qJBPEzkZLHHi3EM96gT6306WpdQvCsmARPMuV2k54XQ7MZIi+Z7
 YokqcGtJvvris0korIhHOLGAJunIWUTXO+wuu+QjuOuanQkWz2pdczpiBLRgbVxiOvPXP+6jI75
 cE+5cJJWteIBSeBTlfvg0NvVOFKKFT6kl5CRshD00nJxPWIutogIOg6AZbtCyKW+1bDNJHl/PTL
 V1HqP9Qpzu8BvWi8eXxn5fhAZZN0wd8XJPyL5y1Dn0ZR+QZNrxY5n3j1FFPBXY80jNd7rLQc/Bu
 yGUHkAX7f4tL9z+EcVrwJrOhn6jPVTepBRK64UOSmRRcsR+55XmZzjJH
X-Received: by 2002:a05:690c:86:b0:820:b01:9d6 with SMTP id
 00721157ae682-8ae39ab5aecmr13732327b3.11.1790968491983; Fri, 02 Oct 2026
 12:14:51 -0700 (PDT)
MIME-Version: 1.0
References: <20260914-nsa325_configs-v1-1-d4089f3f5bff@gmail.com>
 <20261002093156.2238815-1-stefan.roese@mailbox.org>
 <CAJaLiFxcfVWLNEFWRFD5o4x7s4NjUNH7f5t_-oPv7Fb6iqYwgA@mail.gmail.com>
In-Reply-To: <CAJaLiFxcfVWLNEFWRFD5o4x7s4NjUNH7f5t_-oPv7Fb6iqYwgA@mail.gmail.com>
From: Tony Dinh <mibodhi@gmail.com>
Date: Fri, 2 Oct 2026 12:14:33 -0700
X-Gm-Features: AclHuK88JcDmLxDaUN8ldd0mhR3GigdMMYg9NXrmypUGeP_LW9sVWOrRDzn9F3Y
Message-ID: <CAJaLiFxxsb-87h-XNsOH7a8o1MCOSjNteZFNv29w-fmkGV_u-g@mail.gmail.com>
Subject: Re: [PATCH] arm: kirkwood: remove obsolete configs for Zyxel NSA325
 board
To: Stefan Roese <stefan.roese@mailbox.org>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Please make that "(with no-cover letter)".

Thanks,
Tony

On Fri, Oct 2, 2026 at 12:12=E2=80=AFPM Tony Dinh <mibodhi@gmail.com> wrote=
:
>
> Hi Stefan,
>
> On Fri, Oct 2, 2026 at 2:31=E2=80=AFAM Stefan Roese <stefan.roese@mailbox=
.org> wrote:
> >
> > Hi Tony,
> >
> > On 14.09.26 22:24, Tony Dinh wrote:
> > > Zyxel NSA325 board has been updated to bootstd, remove obsolete confi=
gs.
> > >
> > > ---
> >
> > Your Signed-off-by is missing, so I can't apply this one. Could you
> > please resend it with the SoB added?
> >
>
> Weird, I do have a Signed-off-by in the patch. Perhaps because b4
> added a break line ----- before the Signed-off-by line when I sent it
> as a single commit (without no-cover letter).
>
> Let me see what I can do to get rid of this.
>
> Thanks,
> Tony

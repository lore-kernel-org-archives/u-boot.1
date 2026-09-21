Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20C5EC982E6
	for <u-boot@archiver.kernel.org>; Mon, 21 Sep 2026 16:06:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A622B40824;
	Mon, 21 Sep 2026 16:06:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0nm0gr53LHJi; Mon, 21 Sep 2026 16:06:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org A902240814
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790006816;
	b=rjzDEZB5u/pQQ/6chpcWfMumvaP/d5uR67FkAzREsNT4uxTy0gzStt65YfPQDmkhzCEl
	 VheT6J4ebG8r48ljWg5QPPDwHNbmuB1z1QlX1KMCjEgcGeq0uv8gIDGmeZjhD0CFvSM7M
	 47k1D2NBJnfrDijnUBi4MzxknKSExcFtuBYRivB+IT3kW9q0O2lqrqCdy8emEpMuzqjTj
	 XkLgDfl3S+kHQyuxuqLJiADrdwBASBCwI08cNk+eV3+Ki9kVq/ujdZlwhbNWny4MHrWX8
	 LwEqqLXxCNZCStGIHGliAUSO2aa6au5waN9NzkPK7zeM+4GorFyu3/gLUh9bGPU3EFA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790006816;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=ep+yciaGxLtGdfpwVp4HzPZf8IdFxjNm97XcxWJuxVg=;
	b=sx/qDthxRgT8CUMZqQrCPaa+7KN4HIuTctCo2S2OvhnjeA3pKtnLJ9dxD0ETGSk8G2kr
	 Om5aosv0wdHU/IyV/4iw4gHwnQtcdDKECMKeUldEKUJGg4YbUzSfRApqcOcnkg75aOUzk
	 b+HgFjEM57sJcDT0gy0QkWztssMQ5eYt2Z/yuvdt5AMDoT4F9jruHpZNFz1gm8DTQufC0
	 oZ/K5mGyiamEFROCeW7uJaeI3QylHc3GnXTEn22A6Y0mU8o1Fhl5BEsUDemLfZmqcdgbc
	 sXH6d5Tdnpafr4D6rwsH6sFm2c2KmDKK4zs0Ye3QHrZOOa8INz6nq/2s6tDZ6FgTyzg==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; dmarc=pass header.from=flipper.net;
	dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256 header.s=google header.b=lTYIFtiv;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790006816;
	bh=ep+yciaGxLtGdfpwVp4HzPZf8IdFxjNm97XcxWJuxVg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pdFxbYhfwXshKZbi8JqiFNz1kXSFN3bMSEHQGynqz4RW4IjmgHnFfPitI+dksxa5q
	 uHsPPbkUaYW+GeEoxsampeG+DwayxZZVNiNKht5eNQcRURMj8iOAApbroOw2Ff0tfY
	 /WCU3Zgi9nxR/VZxPkUOgkeebz02HxDG1u1wOPzpFsMahstLHhZm9kLYKCegOUIjTx
	 THM1UOsOr+Bjje22IQernTrtLXaRkVN+D8Di5eOwuqnjMat58n1I1MRWnz3OSc8EbV
	 EC1vYYeyRAqRr1Ykgp1MeP1Bnbt57j4ttCaujHmpdmz3fAleK9tusT8rOpz04VPomo
	 Idpysvan3BZuQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A902240814;
	Mon, 21 Sep 2026 16:06:56 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 00D8112C
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 16:06:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E686740814
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 16:06:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NfHWkD8JE2JJ for <u-boot@lists.u-boot-project.org>;
 Mon, 21 Sep 2026 16:06:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 9EBA340813
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:34::f"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790006814;
 b=F6GhD2SeBov6XYwD+IMb2XmFiGIzav5VQBYvXMui/1jknCM2DBURm/W32uUE8gEyMdlo
 QgFM2fI1cRYuhJXI2BqTgHOjQVmQReQJjMzGN9uKb4sw/xzTDjJ9QDF/r3PjnZzpubF97
 qqXQYTwAZNWlVKRsA4+V+HjFaxfT9e2XEUWX9YVFZLFOiR+fJrrLrbNGk4vyQIKXqhvOA
 QbxmiAfAHCnDqK3AwsopOlu5Q6gEldqqtphz5I/VnchErMWOe3I1Igy36UevXdQb7QMun
 7343LIQssiNRpz3SCgSGRRFLxiPOdOaF9OLAB71MEdSBAvDZzKa02nSGYZ0A/bjctzA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790006814;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type:Content-Transfer-Encoding;
 bh=ep+yciaGxLtGdfpwVp4HzPZf8IdFxjNm97XcxWJuxVg=;
 b=CEwtohcIf4KN/ChRtbeDms/vQdd+Buiq7nZMfxNBfLpNY0BPZsce+ir+1qbtnFAdukuf
 mlMtXXHowT1PhQePB/+gSAvTkA6fLrsjVsqwg55kLXu38Mu6xf/Dnpq83v+juiiShwvIV
 2QXJMPv9vwi9Xh3uFvrsoK3y5vly6iadGgQZZ6bo3y6QPhbyrLxefzuFDo7/K62z9ardZ
 d4H25hfc63JIRsGZ17vTlJVLkZNuoOkjMX8CGp6vWZ7mx7Gp27ztCv5UsA+/Ley00AmGw
 ZVvv6n2DueBTBs9BnEL9dwSY6WQWDq/Xm15JV07a7pXNgJVxQuIEXvfI+vU7Ya58yWQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=flipper.net; 
 dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=lTYIFtiv; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:34::f"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:34::f;
 helo=mail-ej2-x0f.google.com; envelope-from=alchark@flipper.net;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=lTYIFtiv
Received: from mail-ej2-x0f.google.com (mail-ej2-x0f.google.com
 [IPv6:2a00:1450:4864:34::f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9EBA340813
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 16:06:53 +0000 (UTC)
Received: by mail-ej2-x0f.google.com with SMTP id
 a640c23a62f3a-c2a8b9acbc6so31239466b.0
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 09:06:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790006811; cv=none;
 d=google.com; s=arc-20260327;
 b=czEYuX+cXh7YJZYFKOVUNNu+v22K84UMSbRoGICeQaw1GPfgThAv91AN8ncrWd+atx
 ErlwGafttipBgFLDx2uAgHUQb30aEmdBWCaLxLaD8UWIKvcWzLvfVhB3mFT9NGkvXp2e
 Y2uRIEO21c2VDrxMBD2khuSgezeEWKWvMehKngXgkRE+ZpjmGiNW4Z0IJ6zF77TUXBd8
 PH6bz+r6lWoWyCsYqqT4MTrPchMoX/ID2p10LhR3Rd2iKUHHuZMcvh5HG1BEpDTHSCfo
 u2eBHGJ5jpSXOPtICaHcJO8p+dXSu1lzGXgthlV8MBgTd3wuoV4/edOrwYtP3p/ipi1n
 UZHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ep+yciaGxLtGdfpwVp4HzPZf8IdFxjNm97XcxWJuxVg=;
 fh=k9kY7a1Wi14n0cNiG9IiAoGAT2s4BttBHc0XPc+Ktys=;
 b=Z9v+tUhiVhfeqxFgO0YyohF3TDvg8ixED8KMU+XVUoAL1jyDRoZB/wwMNlLXOKcyND
 odvEH7UeDhRW6sNxUTjpUO+vvbhBIqf7s4gD7oee9bv/SXDfm7Q+gKOXxwDkb70tZYlP
 nMhN7sAAtGeBJhbC8Tu5e5MQxxFwsrpcFrHa7tIyGQs2zltbCD06TI1P9ckFubP1yPga
 1qK9zDhpCld+ei7nzxs/bq0hdk+KFpNUq4ZzrnnGwTCd5vBa+vEvZbaI3u7zLh+A2yY5
 gDL3BpwK+qCqfaC0NWyJNFZNDIQJFrx42H07jHV6lLfomqN+i+eKSD1BDpPBjL5iO8g/
 DZnQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1790006811; x=1790611611;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ep+yciaGxLtGdfpwVp4HzPZf8IdFxjNm97XcxWJuxVg=;
 b=lTYIFtivq1WmXy/LbuEWOp261kKC2CAQgZqmz6XjW5OMCUDw64MBecRmcN6sbHRc5r
 kGl6r80RQJJr3f9rzLbiZsuOYryPOxIv2F6Uuv4RwFseqt1Qp8Ig3y+FidgSrNr3CxqL
 HsNs6AfRjaSF9mxkgcLhWxYKizBzWPX9nh1RNkm/UTtZWsu71vz+zJgtsamphsiBQyBP
 he4VGf2OmrLneSuR2LvvZNhotR2Aoz4GlovZlO2KwDezn4CkNecba6EAaOJaJ4d2o+rL
 c0MVokSJcj3TaDHg3NoNwJ1Mk0M3fVdHOpNsV+bUhPSR2INrf/BZjQv4EaG9rnEswoZ/
 Nkew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790006811; x=1790611611;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ep+yciaGxLtGdfpwVp4HzPZf8IdFxjNm97XcxWJuxVg=;
 b=QiirbVyksteFYKnK3iZIPokEWEJivcP5oIDv9p4G8A4phUGEToFXob5o92OxiV/++7
 /a9pip+lvxwAjSjk2Vo6SQlo1/L1PcjKkUS/e9CTLycgJVYfzXCkiusc6Ygdkzz2G+f6
 wRFlUKgCf3+3AWQjvNdO0gO490xw77yMnvtyY5sCufIumwyL6uD/oO+UBsIMlp2EYwF8
 9hj4XMA30FQKeEup88ua6EKEN8oGV5uyu4BMqLFbLvS4tNQZCOlGqM1a0FkQ61ydA9Y3
 pHIBUCRmAX9bcxZiEwAiJWHTqclNa6iO9nWuhjTBRH3Buxg5qPNqnO5JiDC3SkYm5Mb3
 51oA==
X-Gm-Message-State: AFuF++khtEZpdY8IlxRpQwtrXU5AdWm4PFSRPKNXOHBSmwZ5iXdaIMZq
 8mI9EUBX8ORjgqepCO3Dc+36V+evN5YEt3Sji9L63XyQ6qWxvRAP+skdfpAJvzaa7SlGPigiZbN
 sQU3hdPyNEA1CohNDjbTk1pPseapeJu7lMJvTJdaVkQ==
X-Gm-Gg: AYBFou1RHF+8O8p7gSFfZzWXDuyBPj0vSFyqXRitooSC7LegZ87/lTPe5zQ+jXe8y0b
 ogSZ5B/bA585IGfZsP/7/Zi2mrQzKkUBtFPIY0IFQuGXqy5Kb+V8AeaC+bq5oA0w4nsRkuNI7PM
 WaZVZCWmBUd7YEDefMT8omO+pd8tbgJCpkN/SFHiv5xcF522KGNrHbpc3MP2N31UzNRBf+i5ZfJ
 tiOVClec5IX26FI9ecPK3mRFcgQ4XVETUZxsRMR23w+et7FfM9CMtQM2EImGO6lY0mGrMYeLt3n
 5mFZOGmRHAUERUT4/KEYTDQvt5yXdjWXpiyj/1cXwHS/pboisUVyWXI/MQ==
X-Received: by 2002:a17:907:94d6:b0:c29:c531:7525 with SMTP id
 a640c23a62f3a-c2a15699fb5mr889326066b.7.1790006810861; Mon, 21 Sep 2026
 09:06:50 -0700 (PDT)
MIME-Version: 1.0
References: <20260918-spl-fit-compression-v2-0-28e946f57357@flipper.net>
 <30490adf-01dc-492f-aaf8-e280bc526a24@cherry.de>
 <CAKTNdwFVtH0-p9LmeXzFkUXi_uQ6f64om3rKCguMK5M_GHg=dA@mail.gmail.com>
 <31ec2b30-32cf-44bb-991c-476e78e52947@cherry.de>
In-Reply-To: <31ec2b30-32cf-44bb-991c-476e78e52947@cherry.de>
From: Alexey Charkov <alchark@flipper.net>
Date: Mon, 21 Sep 2026 19:06:39 +0300
X-Gm-Features: AcwNN1UluIUmg9gkj0iIX4T2RohVH3Hz_g8xzpdhYdQ2OB8UMytYJoWxKnFDUeg
Message-ID: <CAKTNdwHU3CoUCYg9fcPxNajtbTrtbAXYN4OXLze9RFfgczHjXg@mail.gmail.com>
Subject: Re: [PATCH v2 00/11] spl: fit: Generalize compression support
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Vincent Jardin <vjardin@free.fr>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Casey Connolly <casey.connolly@linaro.org>,
 Michael Srba <Michael.Srba@seznam.cz>, 
 Cole Munz <Munzzyy1@proton.me>, Richard Genoud <richard.genoud@bootlin.com>, 
 Daniel Golle <daniel@makrotopia.org>, Simon Glass <sjg@chromium.org>, 
 Francesco Valla <francesco@valla.it>, Anton Ivanov <anton@binarly.io>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 James Hilliard <james.hilliard1@gmail.com>, Quentin Schulz <u-boot@0leil.net>, 
 Kever Yang <kever.yang@rock-chips.com>, Johan Jonker <jbx6244@gmail.com>, 
 Aristo Chen <aristo.chen@canonical.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 =?UTF-8?Q?Jo=C3=A3o_Marcos_Costa?= <joaomarcos.costa@bootlin.com>
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

On Mon, Sep 21, 2026 at 6:42=E2=80=AFPM Quentin Schulz <quentin.schulz@cher=
ry.de> wrote:
>
> Hi Alexey,
>
> On 9/21/26 4:27 PM, Alexey Charkov wrote:
> > Hi Quentin,
> >
> > On Mon, Sep 21, 2026 at 5:14=E2=80=AFPM Quentin Schulz <quentin.schulz@=
cherry.de> wrote:
> >>
> >> Hi Alexey,
> >>
> >> On 9/18/26 12:52 PM, Alexey Charkov wrote:
> >>> SPL knows about multiple compression algorithms, but only two are
> >>> hand-rolled into the simple FIT loading code, in spite of a nice read=
y
> >>> made helper already being available right there.
> >>>
> >>> Generalize the compressed FIT handling code to accept any compression
> >>> algorithm compiled into the SPL, and fix up the SPL_ZSTD linkage whic=
h
> >>> requires xxhash in the SPL but which was absent to date.
> >>>
> >>> While here, also extend binman to support passing a compression level=
 via
> >>> its image templates, which helps squeeze additional ~15% size savings=
 in
> >>> my testing with Zstd level 19 without impacting decompression speed.
> >>>
> >>> This is done with Rockchip RK3576 in mind, so a small Rockchip image
> >>> template refactor is included.
> >>>
> >>> CI passes all green: https://git.u-boot-project.org/u-boot/contributo=
rs/alchark/u-boot/-/pipelines/1319
> >>>
> >>
> >> Doesn't work on my PX30 Ringneck for any of the supported compression
> >> algorithms (didn't check lzma as I'm daily driving Fedora and it doesn=
't
> >> have lzma_alone binary).
> >>
> >> Doesn't work on my RK3399 Puma as well (couldn't check zstd, SPL was t=
oo
> >> big and overlapped with U-Boot FIT, note that Puma is special in that =
it
> >> only allows (256-32)KiB for SPL, due to backward compatibility with
> >> older versions of U-Boot that had U-Boot FIT located at offset 256KiB)=
.
> >
> > That's interesting. Does it work without my series though? With Gzip.
> >
>
> It also doesn't work without your series.
>
> > If it doesn't, the first thing I'd check is overlapping memory regions
> > for the compressed data and the ultimate load address of any of the
> > binaries involved.
> >
> > Would you mind sharing your resulting FIT structure that binman
> > produced for the failing boards, including all the ATF segments?
> >
>
> BL31 for both come from upstream TF-A, seemingly from v2.13.0 (according
> to strings build/rk3399/release/bl31/bl31.elf | grep -E '^v').
>
> ringneck-px30_defconfig + CONFIG_ROCKCHIP_UBOOT_COMP_GZIP=3Dy
>
> $ mkimage -l build/ringneck/u-boot.itb
> Truncated file
> FIT description: FIT image for U-Boot with bl31 (TF-A)
> Created:         Mon Sep 21 17:29:13 2026
>   Image 0 (u-boot)
>    Description:  U-Boot
>    Created:      Mon Sep 21 17:29:13 2026
>    Type:         Standalone Program
>    Compression:  gzip compressed
>    Data Size:    315656 Bytes =3D 308.26 KiB =3D 0.30 MiB
>    Architecture: AArch64
>    Load Address: 0x00800000
>    Entry Point:  0x00800000

Right, so your decompression buffer at SYS_LOAD_ADDR is only 0x800
bytes behind the uncompressed U-Boot load address, so the
decompression output almost immediately overwrites its own source and
fails. Can you please try setting CONFIG_SYS_LOAD_ADDR to something
further up?

It just needs to clear the TF-A and the uncompressed U-Boot proper
region, so the kernel/fdt/ramdisk addresses U-Boot itself uses
shouldn't matter, as the SPL's decompression buffer would have already
been discarded by the time those are used.

Best regards,
Alexey

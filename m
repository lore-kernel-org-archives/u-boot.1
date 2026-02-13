Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EC89EF99D3
	for <u-boot@archiver.kernel.org>; Fri, 13 Feb 2026 20:20:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 78E8783CF2;
	Fri, 13 Feb 2026 21:20:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="N9T0/aie";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C43383DFF; Fri, 13 Feb 2026 21:20:15 +0100 (CET)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D5A483CF2
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 21:20:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-65807298140so2069280a12.2
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 12:20:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771014013; cv=none;
 d=google.com; s=arc-20240605;
 b=lLkGIGL7Qdyf7c6qiAj/nxh+cvPbXCjTvX7I9zuyQgiWmCL3V0dgY42ZFzaClaVQly
 TqAiGHwbF3YIuK+viAauzOxE8ObXVLlrE5QfMtXhW4BMWIE+NcwlGfyM0zTSiEHOhYhB
 d7BgxnFYtHEGVgjZAppCdtMOlvcx4DM9fQLTab0/O1+sExm2ysjY/2yAl4Zg3srKKL0J
 xnukZ3zBWidJqbMCg6eIbEFoJXD2AM4wOjPPPwdoRiguHQeZTyk6NqmPL2RrIKNCUcVU
 tlVxUhHj4s1gdxSmXc91OGk89HekYIA4NiJhSgKcPNb5ZJPqlpW3B1PLQA+VqJdbxXHU
 9J4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=4XyPpfNvmsGyfyfIQgAMO3b3Udd2fKY9dNVTG7ZYWuM=;
 fh=HxiuLRJc3MCX4z9ijAPzvKMhayyKYMsbWOuDpfNH1Ms=;
 b=E9R09vD0GUCmw4lyr3XigT/NpmTZNSHVR54y4+/9nq9JHKbcuV5mh1GMMlsDQpvtJa
 zJPdZUsueXysX1TAxcKnhv6fG3kv/Ck9YANwYW63X56DVWmbVaU4tcvyqboDZySqqiwR
 5+9bhYlYJqlBGB0/DiRR/KuMfBBtGN/yRUJGES56cqSf9unajGp04GFTCRlnfH/BU8BB
 pDdYPwG22IUNi9Qhv1AkClArHFkcI77RLsCUh9bcHLmG04U11aekf6s6BWtr5ytzBHx1
 GxT7WohNHpbCOm5oFW2LzqmQDe9uidU0JI8mQglY8mFfBS+GjGplB6vrr/ynGPZoVpKH
 4t+Q==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1771014013; x=1771618813; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4XyPpfNvmsGyfyfIQgAMO3b3Udd2fKY9dNVTG7ZYWuM=;
 b=N9T0/aie4jBYt3TJise1lpqza6RFP62ZaDisdfRtodMu5PSQMHHkRmsjr91BaeYY0c
 +/Iht5gw4MIDpTpZMUSSMyRhEfz6heMHQQX7gIwhzqBp4QJP1ZN4fnGN+J8xkPV+Vd01
 tK8oosacNGlki5l6A+lXxdFj9dNdEm04EDABI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771014013; x=1771618813;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4XyPpfNvmsGyfyfIQgAMO3b3Udd2fKY9dNVTG7ZYWuM=;
 b=YRd6Wj2PQD7nmr2JA261MgVOx2lF/ydDUQiers1M2C0+NpLdHkRa2+dxmCzaMQv1wL
 VPvIcDKhFHtbsBKxw7IJgjZFNZDSQwz3nkjLuLBChmZk0hBVGRlmIYMNT7gSGpAHjLKO
 pgMzFCRMvExm0qw+xrIT0lodn1mS/dVBDWsbnI1n5aIueksxpPEOYcd4Gi8Q0CYg2COY
 M0W7XlAVEI+e7k0rH0MNxwZwE8bKDFRocMP3BSM7JPaaD6h067HOghQTDp1zrbPuFWbj
 YUIa70Q2ZwyJUvvoC0+ONCB+E3CbS0i3qsvjniLDuMnSYZBrRO3kmkkOxti6pETk+gME
 77Qg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUmkHh9agNano1iF7FzT2uUmFh+rQljascerK5veo81WjVDi1Qv+Xn7ZhpL6dctABROxIvFvPA=@lists.denx.de
X-Gm-Message-State: AOJu0YxDUTeR2CB+yUvb+3hDxnqjD1io8ZFXy3tuyR3d9jDeFd/Ibb/N
 ncZM18jpYCrf5NCgzkdTsW34oWa3rBlEkx1qUDcMUQRwC8Ofvs/Vvb3XHvO0dB55laXBk6iMeMJ
 uctpBy7HguLABvC3AlSlJ75adNCLVBkuewZetNICj0+5cjphpF4c=
X-Gm-Gg: AZuq6aIeri7TYOvnXb9JR7D7GGP0+uixy+xG48V3SpPvhNaX5SCrjnAspzvpJHx62qJ
 CWLF9QIkG/KSZ1sgsUIzIPGTh02T8wTGHAKeUhXjdER+j7KCxCzNea1FZMluYcpwMt34L4hDzkJ
 WEXa2T3JgTZedQmo03BdVycaBGI7aVVvaqZyQ38Oaf4yW6gz8Z2jmmtMcfixalvaD65kqQPL/ve
 ypoIgqnUzmexKs1wzHsPsTdEbK3CzLJKDe/ON7m02RJeCEJ/HorkNDc1cl3goSFv+ghe+Au2HRe
 U7duW+/FcTJrzX8=
X-Received: by 2002:a17:907:dab:b0:b87:7485:b4a8 with SMTP id
 a640c23a62f3a-b8fb3ddac73mr199781666b.0.1771014012863; Fri, 13 Feb 2026
 12:20:12 -0800 (PST)
MIME-Version: 1.0
References: <20250714210249.4139916-1-eric.schikschneit@novatechautomation.com>
 <20250714210249.4139916-2-eric.schikschneit@novatechautomation.com>
 <20260203181444.GQ2603314@bill-the-cat>
 <CAFLszTgLx_TtEO-8qq_9uojLd7PgFdUuhs5_6kYqL7GuzFt7ow@mail.gmail.com>
 <SJ2PR07MB97113A17DC42B9E4E87E95EB8162A@SJ2PR07MB9711.namprd07.prod.outlook.com>
 <CAFLszThAYG9UXu0GoUDHv=k44G3b4CMBNdZjEUmHgrneJZAXOQ@mail.gmail.com>
 <20260213181405.GL2747538@bill-the-cat>
In-Reply-To: <20260213181405.GL2747538@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 13 Feb 2026 13:19:57 -0700
X-Gm-Features: AZwV_QjyBy9vYKKgq5jUTwvcEZOhyx9vlZvBm0dcPQyxuw3E19yjpFr0i8B-x8Q
Message-ID: <CAFLszTjozhsxoXHp=QEVA0TM90k5fp=F0HYFXMsRNxzU5tV0vg@mail.gmail.com>
Subject: Re: [PATCH 2/2] Fix x86 baytrail boot flow, UPD/VPD Updates
To: Tom Rini <trini@konsulko.com>
Cc: Eric Schikschneit <eric.schikschneit@novatechautomation.com>, 
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "bmeng.cn@gmail.com" <bmeng.cn@gmail.com>
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

On Fri, 13 Feb 2026 at 11:14, Tom Rini <trini@konsulko.com> wrote:
>
> On Fri, Feb 13, 2026 at 10:53:26AM -0700, Simon Glass wrote:
> > Hi Eric,
> >
> > On Tue, 10 Feb 2026 at 07:38, Eric Schikschneit
> > <eric.schikschneit@novatechautomation.com> wrote:
> > >
> > > Hello Simon, Tom,
> > >
> > > 1. Tom -
> > > > And we should spell out that device tree can't set these any more in the
> > > > commit message, along with spelling out why we can't do that anymore
> > > > safely (why can't we?). Thanks.
> > > I would be happy to move the code comment into the commit message:
> > >  /* NOTE: This breaks u-boot ability to set board options via    *
> > >   * device tree, but guarantees specific known values..          *
> > >   * you wouldnt use an uninitialized variable would you??        */
> > > These settings could be set by device tree, but every fdtdec* function must
> > > set a valid value. If a user has something set differently than called out in the
> > > FSP_MR5 Integration Guide the board stability will be compromised. Many of
> > > these settings are co-dependant so we would need much more robust error
> > > checking. This task would not be trivial. By using the specific values called out
> > > by the Integration guide we allow users to begin from a documented known
> > > good configuration. Maybe we could set all the values, and then check the
> > > device tree to see if the user specified a different value? If the device tree does
> > > not call out a specific setting we would not want to just set it to zero for example
> > > as this can cause undefined behavior.
> >
> > The device tree is actually where these values are set for all x86
> > boards. If you change any value in a device tree you risk bricking any
> > board. It should be considered an integral part of the build. If you
> > change the C code you can also brick a board.
> >
> > So I don't like the idea of changing this to C, sorry.
> >
> > NAK from me sorry.
>
> Let us not be hasty here. It sounds like we're getting some feedback
> from production users of this support finally and not just people like
> you and I that had reflashed our Minnowboards or similar to prove it
> worked.
>

OK.

Regards,
Simon
